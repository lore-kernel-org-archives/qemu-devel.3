Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E3960A3819
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 18:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vZeKgHuf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRZsG-0002P5-Ax; Thu, 12 Nov 2026 13:50:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nagendranjairam52@gmail.com>)
 id 1xRZsB-0002N9-CN
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 13:50:12 -0500
Received: from mail-dy1-x1332.google.com ([2607:f8b0:4864:20::1332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nagendranjairam52@gmail.com>)
 id 1xRZs7-0004OA-Sn
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 13:50:11 -0500
Received: by mail-dy1-x1332.google.com with SMTP id
 5a478bee46e88-37000e7234bso453711eec.1
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 10:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794509405; x=1795114205; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iUsGrThjNefYxcPqScCdOMiyGxht+SN9iKA89LsuUdY=;
 b=vZeKgHufy8E8Flkb/dOURqao9mdycD95k14DMQ2DmYKG4hgunLdBrWHA94sU0Sb469
 2nGNol4lJQ+wvrVb9HPNImEpYVHfZ8KCCXGD+TfEmGxJfl/pcY7oJsTt5QFnN4GL/0y3
 TQyGutvA7xeuChcBLnRtfx+H5w6Ys28J5Un6dxIoi508ovnqgBOdAt/hR+kXFXObSI3K
 LmXrpNJ+38t0a4u+TphyIZeI9Cz5FRGoiL2X3UqXzFOqwWpL3RXnU3Os/6Yto2FbvnAO
 atLxmJCfIll53o/533CWn8kukl0Xn/IEcHcOI46y3XNqrtj+nrSRWuoVHx6ejeYBjjtB
 D55w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794509405; x=1795114205;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iUsGrThjNefYxcPqScCdOMiyGxht+SN9iKA89LsuUdY=;
 b=Ej1Q5578yMJKA2G4DCX+a0oJ6Yid5E9Y6e3SFsKEO4AlrXa2dV06c9CEATC6EMfwLG
 XpaHBRYRWdxbFZeKmQFQl7Y8RmbrR+2F+ZKkkg6uulP/FHW8XeHpFuIgtGGaQs7qWit2
 TVzHIjva8fNV4xAv/oumwKdUqw6EEAJgxxYvgmInOkktAmW8SqRclOVB/mA1VcMftexH
 GG3Oe0zeXai7aYI9iJkgE6FcFZFR6GRerLDnTE0038yC9+sjv1puO0VZ2Hg+mdTV8tpz
 FLzi6YBZ/sDVtljyj2i1sOaPKUVN8Uw91wSilbpXNL8RxNXNA4slk9qn4o0vilWIHd8z
 xwNQ==
X-Gm-Message-State: APuU4Z9/JVb5A7InqS1/L5lwL72M3HKlVZmk7TKeiqE2CrAdghwMz2Ws
 XSMxODISWGdZEeWXYhEO0OPtVk9fkzX3JxBoPiFMgpS5vb1Y10R5Nait4m+kp+Zg
X-Gm-Gg: AYBFou2yu8NFS+69xyTgbXYW/ZSZokoqiuF6wX9NwsAjF8aIUms8M4Zb/4DChlcNjcU
 E0e3lVOimc33DepwMYZtHiFOU3yai7th8pezSQMVVNUW7Sq0y1KPPRsaaNtUFud4lx0DEgnAHop
 6DQu4+lwWWLa4QFe/BpR4ZtQsxh+lpU0EAVQlytWUltFzARL89Yg0sxsq2v++PFBgB2A/vLiPI7
 vZNbsdLgFCN4ppF+3U+Mn8gXOKRkktsB7E2IQUNdGzNBST65dYH2ThLnJhGI2JTKQu8g7ztBL3H
 Tns5P1pTNHSA31dO8Tfuk8qVoBx7uWZNlQdDNToLAlomfRSRa0jX6V1+LnbczXKPpyGqJAkHGxw
 kNLwyAJaiXDQWfPbP8XqZQCy/5HocHlfv3wMlJNZ+SAIJ6o2g6Pui3zkcm5AFaeV5UyZN3K7MOA
 YjskMIpQ73h8wxblFaJEiDwgcOQ02OloOdVi4ulUfE3shdSC6N1yodV9oGsltzLkIWOtq0D3VJ+
 wmq5z2RWLOIs8AamChML1EArlc82Zys6I9oJXNDK9fvCxlWDf78qrs1bygjBGGbTCUbTQXFzauW
 FtpBlbC0Jj6NNjj6W1TYbGSmmmBMvaR5TlMmaOyoRiCN04pSG2U=
X-Received: by 2002:a05:7301:19a1:b0:378:314:4041 with SMTP id
 5a478bee46e88-37965da110emr42517eec.16.1794509405292; 
 Thu, 12 Nov 2026 10:50:05 -0800 (PST)
Received: from DESKTOP-G8U0VEE ([2406:7400:63:168e:4c16:c78e:4fbb:f0a8])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379553316fdsm372440eec.5.2026.11.12.10.50.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 10:50:04 -0800 (PST)
From: Nagendran K <nagendranjairam52@gmail.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, philmd@linaro.org, daan.j.demeyer@gmail.com,
 peter.maydell@linaro.org, alistair@alistair23.me,
 Nagendran K <nagendranjairam52@gmail.com>
Subject: [PATCH v3] hw/core/loader.c: Add Extended Tektronix HEX file support
Date: Fri, 13 Nov 2026 00:19:48 +0530
Message-ID: <20261112184949.1042-1-nagendranjairam52@gmail.com>
X-Mailer: git-send-email 2.54.0.windows.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1332;
 envelope-from=nagendranjairam52@gmail.com; helo=mail-dy1-x1332.google.com
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


