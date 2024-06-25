Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ABD2C2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 17:37:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM9wA-0000wg-6G; Tue, 25 Jun 2024 13:26:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbouman03@gmail.com>)
 id 1sM7Yv-0003fS-QA
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 10:54:25 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbouman03@gmail.com>)
 id 1sM7Yt-0003IY-W4
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 10:54:25 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-57cbc66a0a6so399885a12.1
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 07:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719327262; x=1719932062; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QCyejyP/ZmZFgO98LacfQCNiAcBDIeycsTCAxZG7mtU=;
 b=Z4V+Q/3Fr4fYd3Z1KirZ14VzeAhNHZdvqUCdHbQn0cQpaNuekZ5J72coUOpOeqeXEG
 5bBDRasHZphY4M+fCv57n70yYe2+KsR68FsgMuDZwG97nCJeWi2/VW58A1mRxZn24c84
 griSHAHFtCjXgRAUCHCNRQb790K3aCjJYJRXybeFLxuFgFVFNROGWVDDeAwc7hJrpWfF
 D8oHT/k4ONwt2pxt/MKW+tQtCZ1MX4uj1HlPoQRrKPW7uK3yJkgcdwzwexdzsP5bThVs
 DQCiDilHjDkrb2llm5IhxkstEbmtIA+vjfgLtzuGuLLHJtuQ+t9LCMPzKgo83byoZqFu
 TvSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719327262; x=1719932062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QCyejyP/ZmZFgO98LacfQCNiAcBDIeycsTCAxZG7mtU=;
 b=lPWZ+Wz0nzihZgNgNd1LaVuINuF3AzZuyeLZrRP+JprLQk/bxNiqgGd2ao8K5pGlkn
 6ziFivnm4qQXMba4gcC139XD6fLMGdvpQI/BPhHgbMgeE3j5j+thuV+nSxEGoyzvYAT+
 YAzI0OiGg2BzKb3C3hUjf29iFf1gzYXFkySLjwg92rNa47+ravxPrfKqeqeuwEccQ54R
 XKBJ6iJqz5Pk2Pf2blu1MClZBv8nFWFEDZzRtMbLgW9EgfJzPJFIBwmaT5ba97ARPwqZ
 DafW7PFJC7IA0uBK4HNzAoyyqpSM60B9iMaze81EGxMzWqvhCoknB/FBykVxvOTCv4Xt
 awtg==
X-Gm-Message-State: AOJu0YyQm+zY0sJ1wowZoaka/XGL5c1K89LcuaD9sG2lIouOIbUKIhdW
 rL3C+F3j2UMcssxJDpSXaDBZthxZXFqnqAY376fosgK6bmSR4iZeS72cGw==
X-Google-Smtp-Source: AGHT+IEirtFrpGKzLsTuornSmFt0JxKdS9u92cY+RQiVGGOROmTJGwMyEtOl7/iugJQqNFuP2N1a9g==
X-Received: by 2002:a50:a694:0:b0:57d:df3:4cf2 with SMTP id
 4fb4d7f45d1cf-57d701ee10bmr2349281a12.11.1719327262300; 
 Tue, 25 Jun 2024 07:54:22 -0700 (PDT)
Received: from 41414141.home (84-82-177-210.fixed.kpn.net. [84.82.177.210])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57d3042d421sm6092740a12.42.2024.06.25.07.54.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 07:54:21 -0700 (PDT)
From: David Bouman <dbouman03@gmail.com>
To: qemu-devel@nongnu.org
Cc: David Bouman <dbouman03@gmail.com>
Subject: [PATCH 3/4] hw/usb/u2f-passthru: Clean up code
Date: Tue, 25 Jun 2024 16:53:49 +0200
Message-Id: <20240625145350.65978-4-dbouman03@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625145350.65978-1-dbouman03@gmail.com>
References: <20240625145350.65978-1-dbouman03@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=dbouman03@gmail.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 25 Jun 2024 13:25:47 -0400
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

Prepare for implementing the FIDO-U2F keepalive feature:

Represent all u2fhid frames using one coherent structure,
and make casts explicit.

Signed-off-by: David Bouman <dbouman03@gmail.com>
---
 hw/usb/u2f-passthru.c | 73 ++++++++++++++++++++++++++-----------------
 1 file changed, 44 insertions(+), 29 deletions(-)

diff --git a/hw/usb/u2f-passthru.c b/hw/usb/u2f-passthru.c
index 54062ab4d5..d0fb7b377c 100644
--- a/hw/usb/u2f-passthru.c
+++ b/hw/usb/u2f-passthru.c
@@ -87,30 +87,45 @@ struct U2FPassthruState {
 #define PACKET_CONT_HEADER_SIZE 5
 #define PACKET_CONT_DATA_SIZE (U2FHID_PACKET_SIZE - PACKET_CONT_HEADER_SIZE)
 
-struct packet_init {
+/* Frame definition */
+
+#define U2FHID_CMD_PING      0x81
+#define U2FHID_CMD_MSG       0x83
+#define U2FHID_CMD_INIT      0x86
+#define U2FHID_CMD_WINK      0x88
+#define U2FHID_CMD_CBOR      0x90
+#define U2FHID_CMD_CANCEL    0x91
+#define U2FHID_CMD_KEEPALIVE 0xbb
+#define U2FHID_ERROR         0xbf
+
+struct u2fhid_frame {
     uint32_t cid;
-    uint8_t cmd;
-    uint8_t bcnth;
-    uint8_t bcntl;
-    uint8_t data[PACKET_INIT_DATA_SIZE];
+    union {
+        uint8_t type;
+        struct {
+            uint8_t cmd;
+            uint8_t bcnth;
+            uint8_t bcntl;
+            uint8_t data[PACKET_INIT_DATA_SIZE];
+        } init;
+        struct {
+            uint8_t seq;
+            uint8_t data[PACKET_CONT_DATA_SIZE];
+        } cont;
+    };
 } QEMU_PACKED;
 
-static inline uint32_t packet_get_cid(const void *packet)
+static inline bool packet_is_init(struct u2fhid_frame *packet)
 {
-    return *((uint32_t *)packet);
-}
-
-static inline bool packet_is_init(const void *packet)
-{
-    return ((uint8_t *)packet)[4] & (1 << 7);
+    return !!(packet->type & (1 << 7));
 }
 
 static inline uint16_t packet_init_get_bcnt(
-        const struct packet_init *packet_init)
+        const struct u2fhid_frame *packet)
 {
     uint16_t bcnt = 0;
-    bcnt |= packet_init->bcnth << 8;
-    bcnt |= packet_init->bcntl;
+    bcnt |= (uint16_t)(packet->init.bcnth) << 8;
+    bcnt |= packet->init.bcntl;
 
     return bcnt;
 }
@@ -237,13 +252,13 @@ static void u2f_transaction_add(U2FPassthruState *key, uint32_t cid,
 static void u2f_passthru_read(void *opaque);
 
 static void u2f_transaction_start(U2FPassthruState *key,
-                                  const struct packet_init *packet_init)
+                                  const struct u2fhid_frame *packet_init)
 {
     int64_t time;
 
     /* Transaction */
     if (packet_init->cid == BROADCAST_CID) {
-        u2f_transaction_add(key, packet_init->cid, packet_init->data);
+        u2f_transaction_add(key, packet_init->cid, packet_init->init.data);
     } else {
         u2f_transaction_add(key, packet_init->cid, NULL);
     }
@@ -259,20 +274,19 @@ static void u2f_transaction_start(U2FPassthruState *key,
 }
 
 static void u2f_passthru_recv_from_host(U2FPassthruState *key,
-                                    const uint8_t packet[U2FHID_PACKET_SIZE])
+                                const uint8_t raw_packet[U2FHID_PACKET_SIZE])
 {
     struct transaction *transaction;
     uint32_t cid;
 
+    struct u2fhid_frame *packet = (void *)raw_packet;
     /* Retrieve transaction */
-    cid = packet_get_cid(packet);
+    cid = packet->cid;
     if (cid == BROADCAST_CID) {
-        struct packet_init *packet_init;
         if (!packet_is_init(packet)) {
             return;
         }
-        packet_init = (struct packet_init *)packet;
-        transaction = u2f_transaction_get_from_nonce(key, packet_init->data);
+        transaction = u2f_transaction_get_from_nonce(key, packet->init.data);
     } else {
         transaction = u2f_transaction_get(key, cid);
     }
@@ -283,13 +297,12 @@ static void u2f_passthru_recv_from_host(U2FPassthruState *key,
     }
 
     if (packet_is_init(packet)) {
-        struct packet_init *packet_init = (struct packet_init *)packet;
-        transaction->resp_bcnt = packet_init_get_bcnt(packet_init);
+        transaction->resp_bcnt = packet_init_get_bcnt(packet);
         transaction->resp_size = PACKET_INIT_DATA_SIZE;
 
-        if (packet_init->cid == BROADCAST_CID) {
+        if (packet->cid == BROADCAST_CID) {
             /* Nonce checking for legitimate response */
-            if (memcmp(transaction->nonce, packet_init->data, NONCE_SIZE)
+            if (memcmp(transaction->nonce, packet->init.data, NONCE_SIZE)
                 != 0) {
                 return;
             }
@@ -302,7 +315,7 @@ static void u2f_passthru_recv_from_host(U2FPassthruState *key,
     if (transaction->resp_size >= transaction->resp_bcnt) {
         u2f_transaction_close(key, cid);
     }
-    u2f_send_to_guest(&key->base, packet);
+    u2f_send_to_guest(&key->base, raw_packet);
 }
 
 static void u2f_passthru_read(void *opaque)
@@ -333,14 +346,16 @@ static void u2f_passthru_read(void *opaque)
 }
 
 static void u2f_passthru_recv_from_guest(U2FKeyState *base,
-                                    const uint8_t packet[U2FHID_PACKET_SIZE])
+                                const uint8_t raw_packet[U2FHID_PACKET_SIZE])
 {
     U2FPassthruState *key = PASSTHRU_U2F_KEY(base);
     uint8_t host_packet[U2FHID_PACKET_SIZE + 1];
     ssize_t written;
 
+    struct u2fhid_frame *packet = (void *)raw_packet;
+
     if (packet_is_init(packet)) {
-        u2f_transaction_start(key, (struct packet_init *)packet);
+        u2f_transaction_start(key, packet);
     }
 
     host_packet[0] = 0;
-- 
2.34.1


