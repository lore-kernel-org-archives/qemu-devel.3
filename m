Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E4CEC88E77
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 20:20:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6ZdW-0001ov-Kq; Tue, 15 Sep 2026 16:20:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nagendranjairam52@gmail.com>)
 id 1x6ZcR-0001Nb-Db
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 16:19:09 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nagendranjairam52@gmail.com>)
 id 1x6ZcP-0003bA-1w
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 16:19:06 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 d2e1a72fcca58-85469b35611so104270b3a.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 13:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789503543; x=1790108343; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iUsGrThjNefYxcPqScCdOMiyGxht+SN9iKA89LsuUdY=;
 b=eKNz0RlNxCkDj0+x1XVWq3u19IL/grqy0NMFL2dp9K4R40KFHGR49Wp80pWKyJ/tEg
 9I6NH7PVPSFG69aCeCFAsLWSWkGVygYiy9dsH9fZZwdzGzAUWtGlP4QEbWzbObYXgTc4
 631Qr86thAohY0A/TMQzgya0scqL4h6Dg1x8pBYccZ6fACuF64AH1KNkxlqb5gG2y64w
 R54IPgtp7eFqkkO3nXZ4wXD+0Q+LQUbDZC5L53YWqWCdK8jqkbaPBgQvkWr4WUUHG+q1
 9RnAe52s2KBs7hCe0gAfEFY1Pbud757Xnrol6Lcnvgy7YorulN68LxzSn0iaVCE5JOki
 Wqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789503543; x=1790108343;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iUsGrThjNefYxcPqScCdOMiyGxht+SN9iKA89LsuUdY=;
 b=PYE2s9VJYKAT2ygit6a3GKYdco51jYKnWLsnY5DLofL3dRYhWnFtTwbvCAvTYEW8dy
 rpk3QhYULs4i5Q6SsZqKWiyUanaksOWnubwa584aEMtU4O+zt8Xtkutdr77SIMBa47N3
 sp5RiTfTPQaexbTXyMw5ErTCrGP8vd1pEBJ+lWuZ25KO7XE45VW6XWJCJdQ2ZmqZLbQr
 tYUhRXHr9aUBJn7SRJyrxZsEtHfV3LKey15QtOnMjb9cEPCNKNLg8qKt5CiwEjCkSfT5
 yQMe99uvV0C79sm7D7X4QQLPIfA26L8S9fIS0xZNzb9+r2zZQPOjM8JXNIvYxNEQHlGi
 HGlw==
X-Gm-Message-State: AFuF++kInl0mrne1ezAw9rzMxbuSR1SthtBsgX1YzeN2EKAKFdNKsEKe
 rUG7Lw1+eLy5omS94BVf7NKC+yycEdY/0AafvNvJQjwtJ9XAvEQvcC7qXnXtOlrW
X-Gm-Gg: AYBFou3PvI3E0q1jdYN62OeFrUHxBGBOfbCqx1wuw3+aok0YgeubkOXjBOA79aK7BLR
 7LcTfGJbpd0cZQdWVrRRObihwfVMMCLJgkIbAD0ki7KNCqOTk0mCx3dTIRkSnO0lV0fifFkCNKZ
 uPErObo162QlL4z9bSAS02D8ZXPkdl5U6ly6E6zZFe96vayY5lGiPgmeE3IVJqik81GvXVOoGO7
 vDgvrOQJG41h3IzHeKNvUAi5n/TthTAr7m79SFE5lF3seRzIvVj4431ITZoJsS6uQfHYTbiaDHc
 q+O2T/7QGOAn0p6ezrqcLEIdchRYrzhwXh4TluaGqMFx8cVg8MR32MLgCZAeZU+wd236ch98YAK
 uGTkgHLTTPx112EYJfydj/cZ4/wECLVxevHV3v5qNlHSM0417U4HQrur79qHP14IOLqH4rAPysT
 05ZOHILv8QCgAVWTP0YKX485WTh7f3zN7SwkL6/2SRSHhBP6JcWNXiz0leGgAqn0WHyJdxETT8b
 A+OtFRBsLMtZbz3N11cqY8=
X-Received: by 2002:a05:6a20:3950:b0:3d1:d188:b0fe with SMTP id
 adf61e73a8af0-3db405a95eemr18927292637.13.1789503542502; 
 Tue, 15 Sep 2026 13:19:02 -0700 (PDT)
Received: from DESKTOP-G8U0VEE ([2401:4900:1cbd:b70a:d15e:fdae:296e:1a01])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5b1d65asm1295048eec.29.2026.09.15.13.18.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 13:19:01 -0700 (PDT)
From: Nagendran K <nagendranjairam52@gmail.com>
To: qemu-devel@nongnu.org
Cc: alistair@alistair23.me, daan.j.demeyer@gmail.com, philmd@oss.qualcomm.com,
 Nagendran K <nagendranjairam52@gmail.com>
Subject: [PATCH v2] hw/core/loader.c: Add Extended Tektronix HEX file support
Date: Wed, 16 Sep 2026 01:48:40 +0530
Message-ID: <20260915201840.693-1-nagendranjairam52@gmail.com>
X-Mailer: git-send-email 2.54.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=nagendranjairam52@gmail.com; helo=mail-pz2-x10.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

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


