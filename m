Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEAFCC83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:09:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZEbm-00086r-Qv; Tue, 08 Jul 2025 16:08:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1uZDSp-0001Be-HY
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 14:54:56 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1uZDSR-0008OC-Jm
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 14:54:37 -0400
Received: by mail-oi1-x244.google.com with SMTP id
 5614622812f47-40ba3d91c35so2951593b6e.3
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 11:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752000801; x=1752605601; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=v4YZAm19501qatmdakHnxhE51uKPvDDuW89sHsrTH8c=;
 b=bfm8VR77ZBufbtkSVGZu/qGmfoiKsf4CvZ796qXwpOmMclRi/j/azcC3fU/Cb8ymH3
 1HE4jJGJeKovbOqeIdQmIwrG3QomATGwIFQ8+Xfl2Hwzx1Mz4iecGb/uW0zF/eEaV99k
 XMEZBx5hdUXy9kMZDLP3n5NrdIFfp7qYC/n190GZtrIALnl4mTsB7lzGwCSLmJb9CwXu
 MHesGaX11Ti0cZq3PEcprnr83PnV7al01S5n5kPqI6+cg5rB0w5wf73TApQ6A0e8gOJR
 Z07CAeJSYZ4WHnvexmBtYIU3MGVy0YA4BD8gXIcyUaj7E82sB8BT3GsiCKiNbzVdlBgV
 JhAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752000801; x=1752605601;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v4YZAm19501qatmdakHnxhE51uKPvDDuW89sHsrTH8c=;
 b=aFW2qlirV2RQ9Ws4uDvb6dIRTbA/ZM+QNx81iH9iWSpHx+4dHc+Guc/9nWQ3lfm2rD
 NdrDyNNmyCBEd7gJwE/BweEvNpFsnLrFmmtLdTyYD9HSZBXo5Twpi3Kja6Nid/jbiyb2
 lV+MI8h0VV9jpM/NSQma+o3krTVlcxzZLts69TAZfJTp61aUY0vyCisp29lxwhmZK5sU
 iSVKX2Ruoq07fC7qE9NH3oxk80oxjYx1b2PflIl1QjE+TcyxxqrwrNNe6d7W9u5Ykk3I
 JwadPaW4aEb42vdFSm2+xbJjvU9SO5Rw1tznndTVnravlWuPqOWObPhJpQRiBw1V3FXV
 EoOw==
X-Gm-Message-State: AOJu0YxxVly3KWAosaGTOGys9AXRImU613sMRgxxbXWVdCIOsMYQM6MI
 OBjnYFoELzswBs1C2EGw6zlgN9/xpewQQRNJHoTYhJvPNIjLq3mJv8hQllXl3IfjiPg=
X-Gm-Gg: ASbGncvuN903d854hvNHG505eHmLQejqswbtKwBNOC5N/AR75OJPHbl0qlqQWxVaoLm
 VZQcaOWhUMvaV2rZ6HnPc/I95Wyx0ZmrJBkVKSNmoMFYmtdlReHEkRpE3LeC9w4wGPvNEkRQY8f
 Am33Dr9Ms8G9T+mB/gKCBuAZW7iQ08EWbbLJ4fdphD07eUTO0FesSTFDgHyxt0zP3uDhiXYRv4v
 jW+XypKeWkApbZmyeSl9HOlSY7v+FgzsA0wTvUCqRLZorQtKh2zBHd3S4GfWyy430odz+1LNgWV
 Jc4w/bXZK2oEoNkEZBDcBuwI8dkgtfbT8R/ZnGyfd2YC+paJeZw0RFADWTcmvJVbd2MB21k=
X-Google-Smtp-Source: AGHT+IGJA95WDTEqBtWrMPVVStcoOJA+F1CXVH8dbAIQAI53/Vdb9BlTfaIABPiEEBb+G+4I9KjTtQ==
X-Received: by 2002:a05:6a20:918d:b0:215:dee4:4808 with SMTP id
 adf61e73a8af0-2260aa9f41bmr24984906637.18.1751966292874; 
 Tue, 08 Jul 2025 02:18:12 -0700 (PDT)
Received: from fedora.. ([118.151.210.82]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b38f55c6490sm10190721a12.74.2025.07.08.02.18.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 02:18:10 -0700 (PDT)
From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, deller@gmx.de, jasowang@redhat.com,
 tank0nf <soumyajyotisarkar23@gmail.com>
Subject: [PATCH] hw/net: Enhancing_transmit_function_i82596
Date: Tue,  8 Jul 2025 14:47:53 +0530
Message-ID: <20250708091752.48027-2-soumyajyotisarkar23@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=soumyajyotisarkar23@gmail.com; helo=mail-oi1-x244.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: tank0nf <soumyajyotisarkar23@gmail.com>

---
 hw/net/i82596.c | 117 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 92 insertions(+), 25 deletions(-)

diff --git a/hw/net/i82596.c b/hw/net/i82596.c
index ee919dab3c..8da1564f9e 100644
--- a/hw/net/i82596.c
+++ b/hw/net/i82596.c
@@ -74,13 +74,16 @@ enum commands {
 #define SIZE_MASK       0x3fff

 /* various flags in the chip config registers */
-#define I596_PREFETCH   (s->config[0] & 0x80)
-#define I596_PROMISC    (s->config[8] & 0x01)
-#define I596_BC_DISABLE (s->config[8] & 0x02) /* broadcast disable */
-#define I596_NOCRC_INS  (s->config[8] & 0x08)
-#define I596_CRCINM     (s->config[11] & 0x04) /* CRC appended */
-#define I596_MC_ALL     (s->config[11] & 0x20)
-#define I596_MULTIIA    (s->config[13] & 0x40)
+#define I596_PREFETCH       (s->config[0] & 0x80)
+#define I596_LOOPBACK       (s->config[3] >> 6)     /* loopback mode */
+#define I596_PROMISC        (s->config[8] & 0x01)
+#define I596_BC_DISABLE     (s->config[8] & 0x02)   /* broadcast status */
+#define I596_NOCRC_INS      (s->config[8] & 0x08)   /* do not append CRC to Tx frame */
+#define I596_CRC16_32       (s->config[8] & 0x10)   /* CRC-16 or CRC-32 */
+#define I596_PADDING        (s->config[8] & 0x80)   /* Should we add padding?*/
+#define I596_MIN_FRAME_LEN  (s->config[10])         /* minimum frame length */
+#define I596_MC_ALL         (s->config[11] & 0x20)
+#define I596_MULTIIA        (s->config[13] & 0x40)


 static uint8_t get_byte(uint32_t addr)
@@ -132,35 +135,99 @@ struct qemu_ether_header {

 static void i82596_transmit(I82596State *s, uint32_t addr)
 {
-    uint32_t tdb_p; /* Transmit Buffer Descriptor */
+    uint32_t tbd_p; /* Transmit Buffer Descriptor */
+    uint16_t tcb_bytes = 0;
+    uint16_t tx_data_len = 0;
+    int insert_crc;
+
+    /* Get TBD pointer */
+    tbd_p = get_uint32(addr + 8);
+
+    /* Get TCB byte count (immediate data in TCB) */
+    tcb_bytes = get_uint16(addr + 12);
+
+    /* Copy immediate data from TCB if present */
+    if (tcb_bytes > 0) {
+        assert(tcb_bytes <= sizeof(s->tx_buffer));
+        address_space_read(&address_space_memory, addr + 16,
+                           MEMTXATTRS_UNSPECIFIED, s->tx_buffer, tcb_bytes);
+        tx_data_len = tcb_bytes;
+    }

-    /* TODO: Check flexible mode */
-    tdb_p = get_uint32(addr + 8);
-    while (tdb_p != I596_NULL) {
-        uint16_t size, len;
+    /* Process TBD chain if present */
+    if (tbd_p != I596_NULL) {
+        while (tbd_p != I596_NULL && tx_data_len < sizeof(s->tx_buffer)) {
+            uint16_t size;
         uint32_t tba;
+            uint16_t buf_len;
+
+            size = get_uint16(tbd_p);
+            buf_len = size & SIZE_MASK;
+            tba = get_uint32(tbd_p + 8);

-        size = get_uint16(tdb_p);
-        len = size & SIZE_MASK;
-        tba = get_uint32(tdb_p + 8);
-        trace_i82596_transmit(len, tba);
+            trace_i82596_transmit(buf_len, tba);

-        if (s->nic && len) {
-            assert(len <= sizeof(s->tx_buffer));
+            if (buf_len > 0 && (tx_data_len + buf_len) <= sizeof(s->tx_buffer)) {
             address_space_read(&address_space_memory, tba,
-                               MEMTXATTRS_UNSPECIFIED, s->tx_buffer, len);
-            DBG(PRINT_PKTHDR("Send", &s->tx_buffer));
-            DBG(printf("Sending %d bytes\n", len));
-            qemu_send_packet(qemu_get_queue(s->nic), s->tx_buffer, len);
+                                   MEMTXATTRS_UNSPECIFIED,
+                                   &s->tx_buffer[tx_data_len], buf_len);
+                tx_data_len += buf_len;
         }

-        /* was this the last package? */
+            /* Check if this is the last TBD */
         if (size & I596_EOF) {
             break;
         }

-        /* get next buffer pointer */
-        tdb_p = get_uint32(tdb_p + 4);
+            /* Get next TBD pointer */
+            tbd_p = get_uint32(tbd_p + 4);
+        }
+    }
+
+    /* We Check if we should insert CRC */
+    insert_crc = (I596_NOCRC_INS == 0) && !I596_LOOPBACK;
+
+    if (s->nic && tx_data_len > 0) {
+        DBG(printf("i82596_transmit: insert_crc = %d, len = %d\n", insert_crc, tx_data_len));
+
+        if (insert_crc && (tx_data_len + 4) <= sizeof(s->tx_buffer)) {
+            uint32_t crc = crc32(~0, s->tx_buffer, tx_data_len);
+            crc = cpu_to_be32(crc);
+            memcpy(&s->tx_buffer[tx_data_len], &crc, sizeof(crc));
+            tx_data_len += sizeof(crc);
+        }
+
+        /* Validate minimum frame size */
+        if (tx_data_len < I596_MIN_FRAME_LEN) {
+            /* Minimum Ethernet frame header */
+            DBG(printf("Adding Padding to reach minimum frame length\n"));
+            if(I596_PADDING){
+                int padding_needed = I596_MIN_FRAME_LEN - tx_data_len;
+                if (padding_needed > 0 && (tx_data_len + padding_needed) <= sizeof(s->tx_buffer)) {
+                    memset(&s->tx_buffer[tx_data_len], 0x7E, padding_needed);
+                    tx_data_len += padding_needed;
+                    DBG(printf("Added %d bytes of padding\n", padding_needed));
+                } else {
+                    /* Buffer overflow would occur if we added padding */
+                    DBG(printf("WARNING: Cannot add %d bytes of padding - would overflow buffer (tx_data_len=%d, buffer_size=%zu)\n",
+                               padding_needed, tx_data_len, sizeof(s->tx_buffer)));
+                }
+            }
+        }
+    }
+
+    DBG(PRINT_PKTHDR("Send", s->tx_buffer));
+    DBG(printf("Sending %d bytes (crc_inserted=%d)\n", tx_data_len, insert_crc));
+
+    switch (I596_LOOPBACK) {
+    case 0:     /* no loopback, send packet */
+        qemu_send_packet_raw(qemu_get_queue(s->nic), s->tx_buffer, tx_data_len);
+        break;
+    case 1:     /* external loopback enabled */
+        i82596_receive(qemu_get_queue(s->nic), s->tx_buffer, tx_data_len);
+        break;
+    default:    /* all other loopback modes: ignore! */
+        break;
     }
 }

--
2.49.0


