Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B40606A31E
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 09:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=s0Rvlo3a
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKXd9-0005FF-QO; Sat, 24 Oct 2026 05:01:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nagendranjairam52@gmail.com>)
 id 1xKXd2-0005Ah-BW
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 05:01:31 -0400
Received: from mail-dl1-x122f.google.com ([2607:f8b0:4864:20::122f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nagendranjairam52@gmail.com>)
 id 1xKXcx-0000cS-Eu
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 05:01:28 -0400
Received: by mail-dl1-x122f.google.com with SMTP id
 a92af1059eb24-1517bda04a0so1778210c88.0
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 02:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792832479; x=1793437279; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iUsGrThjNefYxcPqScCdOMiyGxht+SN9iKA89LsuUdY=;
 b=s0Rvlo3a1ENgk54XMlKiIhYDh5eUD7HHsqrrSYLCbWCNdXJ6eE6cQuYD6/7ZYWLpP3
 a/ccuXBdr6fkQTeovGNLvTo0CLAmAmkl4hsgalOMJbmWGJ6mDpgjFgUJRcdu4RBaCEbT
 rYGjP7qvTOUiI+raFB4PZDrQRsp9DX9Sq3ig907BxolWwfYx9BQKfSLUkqMuABhs0zmq
 Ppg7k4cuiEFNbRXSzwLORXPgTgn9XqY//NeQEJieCL7FWmUKwZmg7vtwr169ByKr8dIp
 8TEEfmQXUwUC+2yxb+B5Prt6Mw6TvqcM9iabRmZwauD5GSEYctFPyc6ivBGfqnYEEFQW
 l6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792832479; x=1793437279;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iUsGrThjNefYxcPqScCdOMiyGxht+SN9iKA89LsuUdY=;
 b=dVRwSn/c6dX78EtqSU0hD+qB4DW104HkkilxPE8i7lJ6TkGA1aHO886s9kTOi6HL7W
 eFYCPn+07kV+9w7ti2Ru2Cx/2ISRJE2o01MRQPVbUpHnP2ukJmVrTdpeRUq7CtK7tRRf
 vFmDifU4F8H7PmlQ7v5KiTQ/trC3aEaEV5eOgGRxqsoynhYq5qWqYZNj5LPdwsMzfYQs
 XrIAZFUol/ICn3d2sqjLekdf1m0KLKMBxvo7eW46AwsH0JuHF08wF9fuRrWYjCX1izLF
 /KqnMBHEeT2wuEcU5h5hQOLknyVN5ARmfuHgC1rHOvWimiG6iFVPXTgmoFrDMvy8Mo2S
 GKCQ==
X-Gm-Message-State: AFq9FYKqDG1Iz7K1a0/v6RSI+RLDH/YgaoPKQinP+tEzHFN1GUlFRwnc
 P0iKzFSV5bJX5UbtVZrylNShn/LWBldEVA2a59VLiFDPDIGH+oQUY3prGb2OoPJr
X-Gm-Gg: AYBFou1d1xZIJ4qkNQ45vwGDCH681bfT+xJCF1GCKMEPu5G9o0b3lssV4jIDy6Hr3NY
 r+rq6eqM86mt+9y2ttW5Ru0mG+RhzJFZCL52WajB3hSehz+F/SBKSa8IxUY20r8yhEfraHTCRpJ
 1cCCfJ0tEvSlrLtz6rvTKLgXGpUmH95irKeRikTgxT5+AzBCyRc48zvllH7w2TR7eGxSqv0TwlG
 F0DDilCqsb/Hzdrg+Yqqp6/zP/FrAvnaCZBI22Itec/BL5DME0K/ia6ffkQkrWqucAeyJOUmrkC
 6uRWKayvCTMH5WM1bnbGFnLSaSUTWeiqFMI0yhC2GrYebv+3gi6v7yGk4h4VjMO+IENx9QA+JzZ
 05x0LuJy/A2bdfqcc0DZ+0fUw/lUIcjOaSkNIC6/uhp6xfqLCnWBEI5ger/heswDdee4RtWt99R
 55+W+faJ22o5opCvLQjEGXPdZuT6olOUh2m8Eea+UCjnkloTxo46y3XF+TPg1XEe7oBr0OlaM7D
 i3KWuoeW0BQBM0QDDdkDr9MBu89GLVMCk2vDrjECiWQ6HeIMV5wGSMwOKTlpar1ihGP8dVs3adq
X-Received: by 2002:a05:701a:ca05:b0:14c:1f57:3e86 with SMTP id
 a92af1059eb24-1993f3f1d75mr2362818c88.47.1792832479064; 
 Sat, 24 Oct 2026 02:01:19 -0700 (PDT)
Received: from DESKTOP-G8U0VEE ([2406:7400:63:dd69:b8ef:f477:c38b:7d0e])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a37c88aasm4637478c88.23.2026.10.24.02.01.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 02:01:18 -0700 (PDT)
From: Nagendran K <nagendranjairam52@gmail.com>
To: qemu-devel@nongnu.org
Cc: alistair@alistair23.me,
	Nagendran K <nagendranjairam52@gmail.com>
Subject: [PATCH v2] hw/core/loader.c: Add Extended Tektronix HEX file support
Date: Sat, 24 Oct 2026 14:30:59 +0530
Message-ID: <20261024090059.860-1-nagendranjairam52@gmail.com>
X-Mailer: git-send-email 2.54.0.windows.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122f;
 envelope-from=nagendranjairam52@gmail.com; helo=mail-dl1-x122f.google.com
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


