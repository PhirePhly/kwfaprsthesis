// CRC-16-CCITT Reference Implementation in C
// Kenneth Finnegan, 2014
//
// This is a skeleton program that takes a static AX.25 frame,
// calculates the Frame Check Sum, and prints every octet as hex.

#include <stdio.h>
#include <stdint.h>

uint16_t calc_crc(uint8_t frame[], size_t frame_len);
void send_octet(uint8_t byte);

int main(void) {
	uint16_t crc;
	int i;

	// Sample APRS frame payload - FCS = {0x76, 0x4A}
	uint8_t testvector[] = 
		{ 0x82, 0xA0, 0xB4, 0x60, 0x60, 0x60, 0xE0, // "APZ___"
		  0x9C, 0x60, 0x86, 0x82, 0x98, 0x98, 0xE3, // "N0CALL-1"
		  0x03, 0xF0, 0x2C, 0x41}; // Control PID ",A"
	size_t testlength = sizeof(testvector);

	// Calculate the FCS
	crc = calc_crc(testvector, testlength);

	// "Transmit" the complete frame
	printf("             ........7E\n");
	for (i=0; i<testlength; i++) {
		send_octet(testvector[i]);
	}
	send_octet(crc & 0xFF); // Send FCS bits 8-15
	send_octet((crc >> 8) & 0xFF); // Send FCS bits 0-7

	printf("\n7E........\n");
	return 0;
}

// Calculate the CRC-16-CCITT of a given array of a given length
// NOTE: Operates completely in reverse-bit order
uint16_t calc_crc(uint8_t frame[], size_t frame_len) {
	int i, j;

	// Preload the CRC register with ones
	uint16_t crc = 0xffff;

	// Iterate over every octet in the frame
	for (i=0; i<frame_len; i++) {
		// Iterate over every bit, LSb first
		for (j=0; j<8; j++) {
			int bit = (frame[i] >> j) & 0x01;
			// Divide by a bit-reversed 0x1021
			if ( (crc & 0x0001) != (bit) ) {
				crc = (crc >> 1) ^ 0x8408;
			} else {
				crc = crc >> 1;
			}
		}
	}

	// Take the one's compliment of the calculated CRC
	crc = crc ^ 0xffff;

	return crc;
}

// A dummy modulator that only prints each octet to the screen
// NOTE: The actual modulator should send the argument byte
// least significant bit first, and handle bit-stuffing
// the entire frame
void send_octet(uint8_t byte) {
	static int octetsperline = 0;

	printf("%02X ", byte);

	if ((++octetsperline) > 7) {
		octetsperline = 0;
		printf("\n");
	}
	return;
}

// END CRC-16-CCITT Reference Implementation
