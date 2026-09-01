Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F0BC624D1
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 11:57:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1N6l-0006uk-AH; Tue, 01 Sep 2026 07:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nagendranjairam52@gmail.com>)
 id 1x1LnU-0001Y4-Cf
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 06:32:56 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nagendranjairam52@gmail.com>)
 id 1x1LnS-0004ph-8f
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 06:32:56 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-398d2b28acfso1820772a91.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 03:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788258773; x=1788863573; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7kwdjrF+q/XbeywvWNcw3Wj5lkryI6dPWIi6HjkeNoE=;
 b=k7n1Y0pO5kkAxtDNSQUBgEpKtivteW7JVbdScELNSc0DO2FxmI99ast/4e6cJ7iYO8
 ZW+k3ZwYXcytkKwg3B07pHqiE0nNEJTXfFts8Jb7M8u5Zyk3IyoWfZ76vxPCC1MgYKp+
 3pg55f3wtyQkBLKcQtSIdxBO7x8+r8PqLN+XABV9ckHxrp62aFYRv0azNkq/NKzS9wY/
 VhbnaQC5uGLfwdI93IOKnd5wZziS3yfZIlkvVMcGdM+pZbYU57sDT1+llYAGYiLiuazN
 OruRofF10/4AD9hVM1sGEMX4WEkK6mpwbOVtbee1UPqOk9kgLuai2TuS+2HXDfp/VZT+
 qvfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788258773; x=1788863573;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7kwdjrF+q/XbeywvWNcw3Wj5lkryI6dPWIi6HjkeNoE=;
 b=Nwvq1Mg8N4vMVxPDPxnYKw/6UDkd9hg+Q62d37kHImk45vN2x/yAP7GG+DscXNwLt4
 8hd0Gx74z2GaO/m3eE3EPK8mP3TddgKbi6gWMcy4L+8OrCEMEoJoFvGSqorjv9N/hlye
 TToYiB3jwbPw5c3LSGWCz35lMKdAXeVLZnTW98ZzHsLsA9kNOdxAwLkRYz9kSEJ7dVDz
 FUQrXOnGafCO8dp9xLwBGhYZT9ucIJaA8ftQjhyj9rlVP7T2Xhy17Nsp57VuhBLFIcBJ
 gFL2B5h/WZ6hQi2J90l+2umYVzfZxDd9rBNXyvSrdgLFGwEZk8w1FBFQfdWyz8wTit3j
 nfRg==
X-Gm-Message-State: AFuF++mXbvUKcMlHrn6qnWOAXsEn4givdp2L58MzLK2sHb0cy1908LTq
 lzwSUrWKHF1LfgCWfkpwdgFa2m4V5yN60v8Wow42Ne/nPVRwWhDArYKlchIt0w==
X-Gm-Gg: AYBFou20HmJwdTWim5FHd26GQcGQyduvxnzYLaIa/3M5l5yPKRHuHLxgHzF1GXDBvbf
 zbeyeRy7B5G/dO9ojNaCENEBpvAaPf7uoNf6IjvMxpi35M1lS4ZnwhiSfDDneFI9eAR32PSnMpU
 zOaCgBrJ4hS3Jbow5KovGT6LNrt/R40OknFnQLdxRUtxTlDr2sbhsJUVodT16X1u/9tHAVgm/Lb
 7xJrwKPOsBgZ48Py4sR5c85WLYnS088yh1zHD1/Hc0MZCAAciM49B8hdbYSUdH7bS+7j1MMnCOA
 +WlT7HNEPSPfrr/DvSLBun9YtgY3aXv1oR33hqNRyokrlwhBE8fnJSRISAuvojbLHSDa/EO8+QE
 torh53ZnqGgeDS039gBnQOsrxOqzk8wdSlWTc+PTOsjG+c9uv6/Y/FqqSlkP4DLagqQutQDK0JZ
 mt0bT7n/li+DUQ/BxahLpMii1y9OxHxsc8Wmn3BfVR5KZMeMAibJcPQa5mYcTDoRUI9ModKz1qv
 dSfs7ghaA==
X-Received: by 2002:a17:90b:4e88:b0:398:a145:5d3d with SMTP id
 98e67ed59e1d1-39907b17a4dmr11231042a91.6.1788258772414; 
 Tue, 01 Sep 2026 03:32:52 -0700 (PDT)
Received: from DESKTOP-G8U0VEE ([2405:201:e03d:cb:7583:6eee:4319:afcd])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3286f9e2a95sm35968368eec.23.2026.09.01.03.32.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 03:32:51 -0700 (PDT)
From: Nagendran K <nagendranjairam52@gmail.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	Nagendran K <nagendranjairam52@gmail.com>
Subject: [PATCH] hw/core/loader.c: Added Extended Tektronix HEX file support
Date: Tue,  1 Sep 2026 16:02:39 +0530
Message-ID: <20260901103244.549-1-nagendranjairam52@gmail.com>
X-Mailer: git-send-email 2.54.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=nagendranjairam52@gmail.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 01 Sep 2026 07:56:50 -0400
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

Added support for loading Extended Tektronix HEX files through the
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


