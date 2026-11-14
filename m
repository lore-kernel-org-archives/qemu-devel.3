Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE476606A8AA
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Nov 2026 11:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bR75xBaN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSBx4-0007J2-53; Sat, 14 Nov 2026 06:29:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nagendranjairam52@gmail.com>)
 id 1xSBx1-0007Ir-ED
 for qemu-devel@nongnu.org; Sat, 14 Nov 2026 06:29:43 -0500
Received: from mail-dy1-x1329.google.com ([2607:f8b0:4864:20::1329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nagendranjairam52@gmail.com>)
 id 1xSBwy-0004rF-S1
 for qemu-devel@nongnu.org; Sat, 14 Nov 2026 06:29:42 -0500
Received: by mail-dy1-x1329.google.com with SMTP id
 5a478bee46e88-33fb4680717so5436331eec.1
 for <qemu-devel@nongnu.org>; Sat, 14 Nov 2026 03:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794655779; x=1795260579; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZGajRjWkqtwceqvcOgL0izWuFN2Ll1rvHS+X7uML2uo=;
 b=bR75xBaNov/YgYFxU/veVJtfaAvjO/9xtuU31lKM5AR1kRqTNfW9u8fGT0o+A1SMvf
 a/J1L9nF/ZZZF1mCXC2Krc0YRQq6NZ3JKgYf6MulCPIgUYyxSbLxFiEUPxj3rCVfacLa
 we/SMU23qQSzxQiCR6xW5vs5Tx5cb3ravxnxGZ6kDcdCK+vliha4XuLm9ZF7zw08EtQq
 yQUB2Xnn5WE5d8NIsuvNr0V7EemwkmMKRj7dgfZJ3Eu7XxPut8dJxq8hrj28PRGaLOmc
 bosvK7t77agr2N9pD3icKP+ulbu/R4X22ag/DSjN/Cm5N0RbY0hgHS9mMF8IrBBHszsG
 eb4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794655779; x=1795260579;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZGajRjWkqtwceqvcOgL0izWuFN2Ll1rvHS+X7uML2uo=;
 b=Y1cO7T8GlFTveh/QrQGyUp/7vxsDmTYOHPA7LzQf+26pcgY5RdBCcA4vWPWuUaVNLZ
 hz1C84LcWA4HWh+PA86TIFidpPHQNLqSMlBAg7Mn60euh1tBqQm4x+EFV7B62tjS/JNQ
 NRee84ZD8X5u3vnMjJmlp8iHg/kiW/qZwTSspyG2vHcSJ1rdrKb6oJLu478tOiegf7rC
 62GJoH4Zi5Z2g9QTKGTykp54xhDpQqhEV/64bWVIjgM6V25x8tAZOE5AJn1QiBDSrL+x
 O3mWozl0xS3fSwJKxDexp2hIz5z1toDS2a66X//q8CfDz3yERqLs28GvRg+hNCqElY5b
 ty/Q==
X-Gm-Message-State: APuU4Z9RKUfkqgLKEj5DLPF2o9+wCPchyIfME/0hPwIWtDxryRLByYj/
 9q5aNQWzOxQmSRTUtDfmK+GE9cEws9mv+BFLpql1nmobXoS3YYftl2SPULttt87u
X-Gm-Gg: AYBFou0v0Xy+wlyhXpnJaObbwoM8GT4BxHN4MOxgBq4TMDTzmBWnb2KiLyPjYtU0GHs
 YCAkUoduuMpAw8+hl6GN74NCnmXxqiHP+Uef8o8Q4bVCffwJ4GT/CckQ/FxaTr7cV5vethoCV8q
 wBJ2+IHff367CZJKRvrbyisaMNO8JK2aOub6dwFaZOdYGmMzbHPrCoNJYa6XWdyPTIGkn5oHv7i
 OdpDpqcwJNgo0Ia8RRO400ylzdPbuoiASKe2soT6Uluk1lJaQPfOxFC9YbPzqPuklGYgxCF84o2
 4vKjkqcH0BNaUqpTe66WjtQ1i9uBC4mYG4ecC7WZ+DIqVlZXRoZxdEF+6OqxYBRmFRkILTepT0d
 cZ0njr4AqVb1jriLxMvHdbvz4aJYsXnKVxwnHPA2WE/hx8fjgsDzyggP/kACeeQgF2OYnSS8gIO
 zjU5YlIAaOqdHv18jqtSQewLcV7mo1wbBxNhASZaQikARzqAX6Pv53n1vXJynEIy9cw50Wlgf8I
 FY6FKyrJDDDhLk53q6OLRgd8tky9W3lQy6QhkErfDxNA6bIvzFW6LGM8FvEVZqyU/lqFBVcK1+Y
 imfINHIujICdeH/wsy9D8anZDkqchyD2AxA3sF5kbo2M6SYwmvKmT0zS9e31DbJEFVOHTKM=
X-Received: by 2002:a05:693c:8105:b0:36a:1d6f:917c with SMTP id
 5a478bee46e88-3796731337bmr5393258eec.22.1794655778661; 
 Sat, 14 Nov 2026 03:29:38 -0800 (PST)
Received: from DESKTOP-G8U0VEE ([2406:7400:63:9390:8dad:ac3b:73ea:f083])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379553316fdsm16224256eec.5.2026.11.14.03.29.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 03:29:37 -0800 (PST)
From: Nagendran K <nagendranjairam52@gmail.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, philmd@linaro.org, daan.j.demeyer@gmail.com,
 peter.maydell@linaro.org, alistair@alistair23.me,
 Nagendran K <nagendranjairam52@gmail.com>
Subject: [PATCH] hw/core/loader: Add Extended Tektronix HEX support
Date: Sat, 14 Nov 2026 16:58:50 +0530
Message-ID: <20261114112855.108-1-nagendranjairam52@gmail.com>
X-Mailer: git-send-email 2.54.0.windows.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1329;
 envelope-from=nagendranjairam52@gmail.com; helo=mail-dy1-x1329.google.com
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

Signed-off-by: Nagendran K <nagendranjairam52@gmail.com>
---
 hw/core/loader.c         | 231 +++++++++++++++++++++++++++++++++++++++
 include/hw/core/loader.h |  15 +++
 2 files changed, 246 insertions(+)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index 5cbfba0a86d24569923c863d6ecda125ce43bceb..33ccb51d56dda1035e815479e20c2a6c793843d9 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -1940,3 +1940,234 @@ ssize_t load_targphys_hex_as(const char *filename, hwaddr *entry,
     g_free(hex_blob);
     return total_size;
 }
+
+typedef enum Ext_Tek_HexRecord Ext_Tek_HexRecord;
+enum Ext_Tek_HexRecord {
+    TEK_DATA_RECORD = 0,
+    TEK_TERMINATION_RECORD
+};
+
+#define DATA_FIELD_MAX_LEN 0xff
+
+typedef struct {
+    uint8_t record_length;
+    uint8_t record_type;
+    uint8_t checksum;
+    uint32_t address;
+    uint8_t data[DATA_FIELD_MAX_LEN];
+} Ext_Tek_HexLine;
+
+/* return 0 or -1 if error */
+static bool parse_ext_tek_hex_record(Ext_Tek_HexLine *line,
+                                     uint8_t *our_checksum,
+                                     const uint8_t c,
+                                     uint32_t *index,
+                                     const bool in_process)
+{
+    /* +---------+---------------+-----------+---------------+-------------+
+     * | record  |    record     |           |               |             |
+     * | length  |    type       | checksum  |   address     |   data      |
+     * +---------+---------------+-----------+---------------+-------------+
+     *     ^             ^            ^              ^            ^
+     * |1 byte   |    1 bytes    |1 byte     | 1 to N byte   | 0-255 bytes |
+     */
+    uint8_t value = 0, address_len = 0;
+    uint32_t idx = *index;
+    /* ignore space */
+    if (g_ascii_isspace(c)) {
+        return true;
+    }
+    if (!g_ascii_isxdigit(c) || !in_process) {
+        return false;
+    }
+    /* still idx is computed nibble wise */
+    value = g_ascii_xdigit_value(c);
+    value = (idx & 0x1) ? (value & 0xf) : (value << 4);
+    if (idx < 2) {
+        line->record_length |= value;
+    } else if (idx == 2) {
+        line->record_type |= value;
+    } else if (2 < idx && idx <= 4) {
+        line->checksum |= value;
+    }
+    /*
+     * Extracting address length from record to fill that many no of address
+     * characters in the address field of the line structure.
+     */
+    else if (idx == 5) {
+        address_len |= value;
+    } else if (6 <= idx &&
+                   idx <= (6 + address_len)) {
+        line->address <<= address_len;
+        line->address += g_ascii_xdigit_value(c);
+    }
+    /*
+     * Checking whether index above address last char index
+     * and reaches till record length. Right shifting one divides the
+     * nibble wise index by 2 to get the byte wise index to
+     * fill the data field of the line structure
+     */
+    else if ((6 + address_len) < idx &&
+              idx <= line->record_length) {
+        line->data[(idx - (6 + address_len)) >> 1] |= value;
+    } else {
+        return false;
+    }
+    *our_checksum += value;
+    ++(*index);
+    return true;
+}
+
+typedef struct {
+    const char *filename;
+    Ext_Tek_HexLine line;
+    uint8_t *bin_buf;
+    hwaddr *start_addr;
+    int total_size;
+    uint32_t next_address_to_write;
+    uint32_t current_address;
+    uint32_t current_rom_index;
+    uint32_t rom_start_address;
+    AddressSpace *as;
+    bool complete;
+} Ext_TekHexParser;
+
+/* return size or -1 if error */
+static int handle_ext_tek_hex_record_type(Ext_TekHexParser *parser)
+{
+    Ext_Tek_HexLine *line = &(parser->line);
+    switch (line->record_type) {
+    case TEK_DATA_RECORD:
+        parser->current_address = line->address;
+        /* verify this is a contiguous block of memory */
+        if (parser->current_address != parser->next_address_to_write) {
+            if (parser->current_rom_index != 0) {
+                rom_add_blob_fixed_as(parser->filename, parser->bin_buf,
+                                      parser->current_rom_index,
+                                      parser->rom_start_address, parser->as);
+            }
+            parser->rom_start_address = parser->current_address;
+            parser->current_rom_index = 0;
+        }
+
+        /* copy from line buffer to output bin_buf */
+        /* sizeof(line->data) dynamically calculates the size of data field */
+        memcpy(parser->bin_buf + parser->current_rom_index, line->data,
+               sizeof(line->data));
+        parser->current_rom_index += sizeof(line->data);
+        parser->total_size += sizeof(line->data);
+        /* As address is absolute, we dont need to calculate next address */
+        break;
+
+    case TEK_TERMINATION_RECORD:
+        if (parser->current_rom_index != 0) {
+            rom_add_blob_fixed_as(parser->filename, parser->bin_buf,
+                                  parser->current_rom_index,
+                                  parser->rom_start_address, parser->as);
+        }
+        parser->complete = true;
+        return parser->total_size;
+
+    default:
+        return -1;
+    }
+
+    return parser->total_size;
+}
+
+/* return size or -1 if error */
+static int parse_ext_tek_hex_blob(const char *filename,
+                                  hwaddr *addr,
+                                  uint8_t *ext_tek_blob,
+                                  size_t ext_tek_blob_size,
+                                  AddressSpace *as)
+{
+    /* avoid re-enter and check whether record begin with '%' */
+        bool in_process = false;
+        uint8_t *end = ext_tek_blob + ext_tek_blob_size;
+        uint8_t our_checksum = 0;
+        uint32_t record_index = 0;
+
+        Ext_TekHexParser parser = {
+        .filename = filename,
+        .bin_buf = g_malloc(ext_tek_blob_size),
+        .start_addr = addr,
+        .as = as,
+        .complete = false
+        };
+
+        rom_transaction_begin();
+
+        for (; ext_tek_blob < end && !parser.complete; ++ext_tek_blob) {
+            switch (*ext_tek_blob) {
+            case '\r':
+            case '\n':
+                if (!in_process) {
+                    break;
+                }
+
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
+
+                if (handle_ext_tek_hex_record_type(&parser) == -1) {
+                    parser.total_size = -1;
+                    goto out;
+                }
+                break;
+
+            /* start of a new record. */
+            case '%':
+                memset(&parser.line, 0, sizeof(Ext_Tek_HexLine));
+                in_process = true;
+                record_index = 0;
+                break;
+
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
+        }
+
+    out:
+        g_free(parser.bin_buf);
+        rom_transaction_end(parser.total_size != -1);
+        return parser.total_size;
+}
+
+
+/* return size or -1 if error */
+ssize_t load_targphys_ext_tek_hex_as(const char *filename,
+                                     hwaddr *entry,
+                                     AddressSpace *as)
+{
+    gsize ext_tek_blob_size;
+    gchar *ext_tek_blob;
+    int total_size = 0;
+
+    if (!g_file_get_contents(filename, &ext_tek_blob,
+                             &ext_tek_blob_size, NULL)) {
+        return -1;
+    }
+    total_size = parse_ext_tek_hex_blob(filename, entry,
+                                       (uint8_t *)ext_tek_blob,
+                                       ext_tek_blob_size, as);
+
+    g_free(ext_tek_blob);
+    return total_size;
+}
diff --git a/include/hw/core/loader.h b/include/hw/core/loader.h
index d9431e8a8d12e3b676160f70ed141f1064143ea3..c0d29b1d4456bb92984749e56f1109f8421cee51 100644
--- a/include/hw/core/loader.h
+++ b/include/hw/core/loader.h
@@ -57,6 +57,21 @@ ssize_t load_image_targphys_as(const char *filename,
 ssize_t load_targphys_hex_as(const char *filename, hwaddr *entry,
                              AddressSpace *as);
 
+/**
+ * load_targphys_ext_tek_as:
+ * @filename: Path to the .tek file
+ * @entry: Store the entry point given by the .tek file
+ * @as: The AddressSpace to load the .tek file to. The value of
+ *      address_space_memory is used if nothing is supplied here.
+ *
+ * Load a fixed .tek file into memory.
+ *
+ * Returns the size of the loaded .tek file on success, -1 otherwise.
+ */
+ssize_t load_targphys_ext_tek_hex_as(const char *filename,
+                                     hwaddr *entry,
+                                     AddressSpace *as);
+
 /** load_image_targphys:
  * Same as load_image_targphys_as(), but doesn't allow the caller to specify
  * an AddressSpace.
-- 
2.54.0.windows.1


