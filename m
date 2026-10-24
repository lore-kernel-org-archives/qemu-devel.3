Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD12A606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 09:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Q0XM0++i
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKXfi-0005oo-0c; Sat, 24 Oct 2026 05:04:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nagendranjairam52@gmail.com>)
 id 1xKXfb-0005oQ-UF
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 05:04:08 -0400
Received: from mail-dy1-x1330.google.com ([2607:f8b0:4864:20::1330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nagendranjairam52@gmail.com>)
 id 1xKXfZ-0000iw-RC
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 05:04:07 -0400
Received: by mail-dy1-x1330.google.com with SMTP id
 5a478bee46e88-3535a54bed9so2549723eec.1
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 02:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792832644; x=1793437444; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iUsGrThjNefYxcPqScCdOMiyGxht+SN9iKA89LsuUdY=;
 b=Q0XM0++ij+q7VpR6dklWrAiwLsbsAT/G7KV/IaYTXS6MEBHzAmElqyHTL33hGg8Uro
 oSgfwfkYZKbWVdFAx0NFWVDnzOT+PgYyNA0IhyOjbo2qTKRwujBdfR5V6UmLTy+7Mink
 kwcJuPFZPML+Zo0v+7dj6huaZGsycLnmp1MimqovBL8hjlt9WE1s+YjK6zHNcASVBBXK
 hRDAbf21Z6q20Dy/VFSYhAEGsMW6RsVFI90HUmTIfUqyRbZomgyllR0xcvcWhAqvwfkp
 QzbKKuxLpInD6KglMzXdccaJAzGDhsOxgJ+Coksf6wriGG7izS7HHT6O7JMEFllzXds8
 UzZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792832644; x=1793437444;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iUsGrThjNefYxcPqScCdOMiyGxht+SN9iKA89LsuUdY=;
 b=IYo4z6KO63fltrrurumvG3oCXuOVP8IpY32X9A7SIgBONIdvN+POD8cKswlKT8n1uh
 F2mFoMgYhEyJ9nCGO8JhAq4t0qOVFlAFU9RjCMv3YdAvqQIoP/gf73dQQQ9GdMSQ6MFm
 jtISZ8KLuhBDrdiL81wgUMEqlM+OFOQitC8fmVm7drZuvp7O/T43KKDArcIxtXZ0EBAU
 L5WqOC+6xvYFVGBjK8m6rMbPavpNqEES6eydK94AyrOuGwrhX1IdgCP/xLvTPXlzeFau
 i0FGkNDAhQxxaLAvUun/JvzujTRB4UDHSCvWqhAzb5OMK9lVxjdhT9JrP1wdF/vLJ7Jl
 1f8A==
X-Gm-Message-State: AFq9FYJIiM1tqLb6u5UqCTBY7uteR2nQhxPfLtAVShmrD9+g8Bvrm8sA
 BhcePD8+OGXK9b16+NBQDYSYUMDE9vVrzJYVoXGHPYXx10mDU4M+tdvb
X-Gm-Gg: AYBFou21QfcGs2Vq2kLtwNsZFYuPqH2/GDly1RJjXCG4tT6o7hKesQMPlerKnzprc8A
 7S7adHGaYGmT1bg0ux/mklxDXfYZKCv5zq+xD7MZueb/Xf60tY3hEKFuA/cbzKDT/iWytLSEt57
 URL11t58bZO1MVydEXaTUxtILg0Iu5+ExQL+jsYj2iZo3r+AEB1yrh99iktSA1LNIfDXsYt/XyK
 NW79cx8w7xic6z+VLe/L+M0Lp1fPk9mUacuwNdVESr8Wu9Hqpw0LaCxe2TzlDTnplM4oAFpJREX
 zdT972BFRkMzmbw3ve6aXZ6xAsYezKUKf7VDsJ1rf+HA5TKYfWsBZOBf6vZeNSSaUKeC8DbRCEL
 VoyPE+LbojWbq1PYvI0FaTENOamc56N+SENJseTA4FxgQhbAJN3QP/6T87KHZ7E9U9MmjErAM4R
 /YaYpZZKxph9Ue8HE7QerPJsiuKG+R0VdU1jjnHfbDTDLlQL4B/++K0pe0Vy4O9SE44xS7AfW+o
 sEhCLbNx9PE0Eo2B/4qEjkJWS5i/k5MVox6oIZF2MISStdkqOLc4CHlUNwR+LmB7SD/UgoGaVR4
X-Received: by 2002:a05:693c:87d9:20b0:369:987f:d15e with SMTP id
 5a478bee46e88-369e8336389mr2413485eec.2.1792832643876; 
 Sat, 24 Oct 2026 02:04:03 -0700 (PDT)
Received: from DESKTOP-G8U0VEE ([2406:7400:63:dd69:b8ef:f477:c38b:7d0e])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369e8db7b23sm6937559eec.19.2026.10.24.02.04.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 02:04:03 -0700 (PDT)
From: Nagendran K <nagendranjairam52@gmail.com>
To: alistair@alistair23.me
Cc: qemu-devel@nongnu.org,
	Nagendran K <nagendranjairam52@gmail.com>
Subject: [PATCH v2] hw/core/loader.c: Add Extended Tektronix HEX file support
Date: Sat, 24 Oct 2026 14:33:54 +0530
Message-ID: <20261024090354.1228-1-nagendranjairam52@gmail.com>
X-Mailer: git-send-email 2.54.0.windows.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1330;
 envelope-from=nagendranjairam52@gmail.com; helo=mail-dy1-x1330.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add support for loading Extended Tektronix HEX files through the
generic loader.

The loader parses Extended Tektronix records, validates their
checksums, and loads the data at the addresses specified in the file.

This allows Extended Tektronix files to be loaded directly without
manual conversion to another supported format.

Tested by loading an Extended Tektronix file containing a simple UART
application on the RealView EB machine. The application executed
successfully and produced the expected UART output.

Signed-off-by: Nagendran K <nagendranjairam52@gmail.com>
---
 hw/core/loader.c         | 141 +++++++++++++++++++++++----------------
 include/hw/core/loader.h |   7 +-
 2 files changed, 87 insertions(+), 61 deletions(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index 2943f69e92..33ccb51d56 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -1958,8 +1958,11 @@ typedef struct {
 } Ext_Tek_HexLine;
 
 /* return 0 or -1 if error */
-static bool parse_ext_tek_hex_record(Ext_Tek_HexLine *line, uint8_t *our_checksum, const uint8_t c,
-                         uint32_t *index, const bool in_process)
+static bool parse_ext_tek_hex_record(Ext_Tek_HexLine *line,
+                                     uint8_t *our_checksum,
+                                     const uint8_t c,
+                                     uint32_t *index,
+                                     const bool in_process)
 {
     /* +---------+---------------+-----------+---------------+-------------+
      * | record  |    record     |           |               |             |
@@ -1977,27 +1980,35 @@ static bool parse_ext_tek_hex_record(Ext_Tek_HexLine *line, uint8_t *our_checksu
     if (!g_ascii_isxdigit(c) || !in_process) {
         return false;
     }
-    //still idx is computed nibble wise
+    /* still idx is computed nibble wise */
     value = g_ascii_xdigit_value(c);
     value = (idx & 0x1) ? (value & 0xf) : (value << 4);
     if (idx < 2) {
         line->record_length |= value;
-    } else if (idx==2) {
+    } else if (idx == 2) {
         line->record_type |= value;
-    } else if (2 < idx && idx <=4) {
+    } else if (2 < idx && idx <= 4) {
         line->checksum |= value;
     }
-    //Extracting address length from record to fill that many no of address characters in the address field of the line structure. 
-    else if ( idx==5){
+    /*
+     * Extracting address length from record to fill that many no of address
+     * characters in the address field of the line structure.
+     */
+    else if (idx == 5) {
         address_len |= value;
-    }else if (6 <= idx && idx <= (6 + address_len)) {
+    } else if (6 <= idx &&
+                   idx <= (6 + address_len)) {
         line->address <<= address_len;
         line->address += g_ascii_xdigit_value(c);
     }
-    //Checking whether index above address last char index and reaches till record length 
+    /*
+     * Checking whether index above address last char index
+     * and reaches till record length. Right shifting one divides the
+     * nibble wise index by 2 to get the byte wise index to
+     * fill the data field of the line structure
+     */
     else if ((6 + address_len) < idx &&
-               idx <= line->record_length) {
-        //Right shifting one divides the nibble wise index by 2 to get the byte wise index to fill the data field of the line structure.
+              idx <= line->record_length) {
         line->data[(idx - (6 + address_len)) >> 1] |= value;
     } else {
         return false;
@@ -2040,12 +2051,12 @@ static int handle_ext_tek_hex_record_type(Ext_TekHexParser *parser)
         }
 
         /* copy from line buffer to output bin_buf */
-        //sizeof(line->data) is given to dynamically calculate the size of data field
+        /* sizeof(line->data) dynamically calculates the size of data field */
         memcpy(parser->bin_buf + parser->current_rom_index, line->data,
                sizeof(line->data));
         parser->current_rom_index += sizeof(line->data);
         parser->total_size += sizeof(line->data);
-        //As address is absolute address, we dont need to calculate next address to write
+        /* As address is absolute, we dont need to calculate next address */
         break;
 
     case TEK_TERMINATION_RECORD:
@@ -2065,15 +2076,18 @@ static int handle_ext_tek_hex_record_type(Ext_TekHexParser *parser)
 }
 
 /* return size or -1 if error */
-static int parse_ext_tek_hex_blob(const char *filename, hwaddr *addr, uint8_t *ext_tek_blob,
-    size_t ext_tek_blob_size, AddressSpace *as)
-{
-        bool in_process = false; /* avoid re-enter and
-                * check whether record begin with '%' */
+static int parse_ext_tek_hex_blob(const char *filename,
+                                  hwaddr *addr,
+                                  uint8_t *ext_tek_blob,
+                                  size_t ext_tek_blob_size,
+                                  AddressSpace *as)
+{
+    /* avoid re-enter and check whether record begin with '%' */
+        bool in_process = false;
         uint8_t *end = ext_tek_blob + ext_tek_blob_size;
         uint8_t our_checksum = 0;
         uint32_t record_index = 0;
-        
+
         Ext_TekHexParser parser = {
         .filename = filename,
         .bin_buf = g_malloc(ext_tek_blob_size),
@@ -2085,47 +2099,52 @@ static int parse_ext_tek_hex_blob(const char *filename, hwaddr *addr, uint8_t *e
         rom_transaction_begin();
 
         for (; ext_tek_blob < end && !parser.complete; ++ext_tek_blob) {
-        switch (*ext_tek_blob) {
-        case '\r':
-        case '\n':
-        if (!in_process) {
-        break;
-        }
+            switch (*ext_tek_blob) {
+            case '\r':
+            case '\n':
+                if (!in_process) {
+                    break;
+                }
 
-        in_process = false;
-        //record_length byte stores the number of hex characters (nibbles) in the record
-        //so, record_length as the authoritative count of hex characters (nibbles) in the record 
-        //and compare it directly to the nibble index(record index).
-        if ((parser.line.record_length != record_index) || (our_checksum != 0)) {
-        parser.total_size = -1;
-        goto out;
-        }
+                in_process = false;
+                /*
+                 * record_length byte stores the number of hex characters
+                 * (nibbles) in the record and compare it directly to
+                 * the nibble index(record index).
+                 */
+                if ((parser.line.record_length != record_index) ||
+                    (our_checksum != 0)) {
+                    parser.total_size = -1;
+                    goto out;
+                }
 
-        if (handle_ext_tek_hex_record_type(&parser) == -1) {
-        parser.total_size = -1;
-        goto out;
-        }
-        break;
+                if (handle_ext_tek_hex_record_type(&parser) == -1) {
+                    parser.total_size = -1;
+                    goto out;
+                }
+                break;
 
-        /* start of a new record. */
-        case '%':
-        memset(&parser.line, 0, sizeof(Ext_Tek_HexLine));
-        in_process = true;
-        record_index = 0;
-        break;
+            /* start of a new record. */
+            case '%':
+                memset(&parser.line, 0, sizeof(Ext_Tek_HexLine));
+                in_process = true;
+                record_index = 0;
+                break;
 
-        /* decoding lines */
-        default:
-        if (!parse_ext_tek_hex_record(&parser.line, &our_checksum, *ext_tek_blob,
-                &record_index, in_process)) {
-        parser.total_size = -1;
-        goto out;
-        }
-        break;
-        }
+            /* decoding lines */
+            default:
+                if (!parse_ext_tek_hex_record(&parser.line,
+                                            &our_checksum,
+                                            *ext_tek_blob,
+                                            &record_index, in_process)) {
+                    parser.total_size = -1;
+                    goto out;
+                }
+                break;
+            }
         }
 
-        out:
+    out:
         g_free(parser.bin_buf);
         rom_transaction_end(parser.total_size != -1);
         return parser.total_size;
@@ -2133,18 +2152,22 @@ static int parse_ext_tek_hex_blob(const char *filename, hwaddr *addr, uint8_t *e
 
 
 /* return size or -1 if error */
-ssize_t load_targphys_ext_tek_hex_as(const char *filename, hwaddr *entry, AddressSpace *as)
+ssize_t load_targphys_ext_tek_hex_as(const char *filename,
+                                     hwaddr *entry,
+                                     AddressSpace *as)
 {
     gsize ext_tek_blob_size;
     gchar *ext_tek_blob;
     int total_size = 0;
 
-    if (!g_file_get_contents(filename, &ext_tek_blob, &ext_tek_blob_size, NULL)) {
+    if (!g_file_get_contents(filename, &ext_tek_blob,
+                             &ext_tek_blob_size, NULL)) {
         return -1;
     }
-    total_size = parse_ext_tek_hex_blob(filename, entry, (uint8_t *)ext_tek_blob,
-                                ext_tek_blob_size, as);
+    total_size = parse_ext_tek_hex_blob(filename, entry,
+                                       (uint8_t *)ext_tek_blob,
+                                       ext_tek_blob_size, as);
 
     g_free(ext_tek_blob);
     return total_size;
-}
\ No newline at end of file
+}
diff --git a/include/hw/core/loader.h b/include/hw/core/loader.h
index 336a987f85..c0d29b1d44 100644
--- a/include/hw/core/loader.h
+++ b/include/hw/core/loader.h
@@ -57,7 +57,8 @@ ssize_t load_image_targphys_as(const char *filename,
 ssize_t load_targphys_hex_as(const char *filename, hwaddr *entry,
                              AddressSpace *as);
 
-                             /**load_targphys_ext_tek_as:
+/**
+ * load_targphys_ext_tek_as:
  * @filename: Path to the .tek file
  * @entry: Store the entry point given by the .tek file
  * @as: The AddressSpace to load the .tek file to. The value of
@@ -67,7 +68,9 @@ ssize_t load_targphys_hex_as(const char *filename, hwaddr *entry,
  *
  * Returns the size of the loaded .tek file on success, -1 otherwise.
  */
-ssize_t load_targphys_ext_tek_hex_as(const char *filename, hwaddr *entry, AddressSpace *as);
+ssize_t load_targphys_ext_tek_hex_as(const char *filename,
+                                     hwaddr *entry,
+                                     AddressSpace *as);
 
 /** load_image_targphys:
  * Same as load_image_targphys_as(), but doesn't allow the caller to specify
-- 
2.54.0.windows.1


