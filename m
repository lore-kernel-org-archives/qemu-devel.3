Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70351E67A61
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 04:18:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxHCa-0003Ov-8a; Mon, 02 Mar 2026 23:17:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamedaymanworkspace@gmail.com>)
 id 1vxHCY-0003Ok-V1
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 23:17:42 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mohamedaymanworkspace@gmail.com>)
 id 1vxHCX-0006Sr-4q
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 23:17:42 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48373a4bca3so31258065e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 20:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772511457; x=1773116257; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=53zqa3khAxopP2aH9AXDCF45puHjLBt7Xl3ajmc+C4E=;
 b=DMmeETYqz0meHgM3mRgcoUiuuGVfDqBeTkoMF5acCV0a99RlSggN2Eq94knh+NXwUz
 6DHejfEBhQUkDQa+vHIzKnoD3EUrK1y7+ntA/xsjy+OABFZ/1qo8tAZS68cKx8LONnsd
 eqGkOtqb2wTsMJymx3rcTmstsuhLR6VHF/UiUh2+Vv9u42f0Ih3Y39HXQBySt81UG69p
 sEWfuT2oxUfLPR03vd0YbkEzIbCdvuJ1RXdbxMUzAxHbR6200hnHsqbPXk9rN9PNHnSg
 cPGYGr4yz4X1BTVOl1Km3dtZFEecwjCyOSr+2iWoYvPGk24Mngqzk3JuYtkzndr4Aemx
 T/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772511457; x=1773116257;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=53zqa3khAxopP2aH9AXDCF45puHjLBt7Xl3ajmc+C4E=;
 b=a1yJf60IIR4NWQ9DWtgOwjAOn/aE/29W7DxVZCbdlcMwGb5lcHOu56BEz5RtKLLh08
 VOcXRVVbSKsPg18sTZsFE1mwwLAtveFB0j4XOiMD7skbCK3c4EJ12z8UMJFIOuynJ19h
 sMOgHzRUuSLEzT5qHMmz2vTrvJLr++xpAav82A3T87uvp9hSw3bx47dAYb09y+gY/7A5
 jShoWD23aVi+tqgEmW+fcv87Ep14Bec6pHgDGIWj8MyBtbzfbFL8qoMVSWsQvTcbrSfZ
 pMJvt/UzkKV+TmpA6OrV5eJlLc2IxDjGmhsgSjDud+pVddn27r6ehi38DFBQfl4G62AQ
 exzA==
X-Gm-Message-State: AOJu0Yzt3lbskiMqE/AP+zZVYZkyrs1RigfsF6E8exXAFxtbsPIOr8ED
 zslEeMxckUhQHVdwCvuToNGuDfkvZXsWRxu+kUfeLNcuOFlSGBcUkMb8jj6BGdnQ0BRIRg==
X-Gm-Gg: ATEYQzx92kKZjsfLY6qzAO0SOjFdPiZ8Zb2NkAbYsj+m1ys9w9XXHZ4PNfsJr5i8/If
 xFZUvm5w3HEIOX0CKJX/6xnCA25a+ozWWCXmArDMh2cakCDJDVm4WreIk5qkCFU5J/umbK5jfdD
 +A/zjWOW+N1aE5r54XNXTmAIpo5zE+pzH4lX4B6uZ1/PkNohcBEzAbSDdu3BN7VG1T/OzTfMtlQ
 4Hfw+qxjyCFXtlisQ+2LEo1ieeDCkrGJGRwhmGun3Om/vKfTKmU7Z90gx/wfaCjIm6bsJeWPaBe
 sHunW5DNT8QKx4YGaWppAXteFGbSiccJtLxileEkgzGJ+tXXaPLpviHeNzltcE9+9mNzeGJ4Qr9
 RCty8KNf4yONqq5C6PyTgRZGKIh75TJNfbzO2zAdAHTUZ8JYjuwqzt8bFficDI9T4dT5FDj5NAG
 YjSTiwHggkbAvi++pi4Wv/jBNgqX6W
X-Received: by 2002:a05:600c:4f0e:b0:483:702f:4641 with SMTP id
 5b1f17b1804b1-483c9b94367mr244616705e9.3.1772511457294; 
 Mon, 02 Mar 2026 20:17:37 -0800 (PST)
Received: from ST.. ([102.185.186.72]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd765604sm388547795e9.15.2026.03.02.20.17.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 20:17:36 -0800 (PST)
From: Mohamed Ayman <mohamedaymanworkspace@gmail.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Ayman <mohamedaymanworkspace@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH] vhost-user: document vhost_user_read() message handling
Date: Tue,  3 Mar 2026 06:17:23 +0200
Message-Id: <20260303041723.7410-1-mohamedaymanworkspace@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=mohamedaymanworkspace@gmail.com; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Add a detailed documentation comment for vhost_user_read() describing
its message header validation, payload size checks, and error handling.

This clarifies how complete vhost-user messages (header + payload) are
read from the character device and how protocol violations are handled.

No functional changes.

Signed-off-by: Mohamed Ayman <mohamedaymanworkspace@gmail.com>
---
 hw/virtio/vhost-user.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index bb8f8eab77..157a869b35 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -300,6 +300,20 @@ static int vhost_user_read_header(struct vhost_dev *dev, VhostUserMsg *msg)
     return 0;
 }
 
+/**
+ * vhost_user_read:
+ * @dev: The vhost device state
+ * @msg: Pointer to the vhost-user message structure to populate
+ *
+ * Reads a complete vhost-user message (header and optional payload) from 
+ * the character device. It first reads and validates the header, checks 
+ * the advertised payload size against maximum bounds, and then reads any 
+ * attached payload directly into the message structure.
+ *
+ * Returns: 0 on success,
+ * -EIO or -errno on read failure or short read,
+ * -EPROTO if the protocol flags or payload size are invalid.
+ */
 static int vhost_user_read(struct vhost_dev *dev, VhostUserMsg *msg)
 {
     struct vhost_user *u = dev->opaque;
@@ -307,12 +321,13 @@ static int vhost_user_read(struct vhost_dev *dev, VhostUserMsg *msg)
     uint8_t *p = (uint8_t *) msg;
     int r, size;
 
+    /* 1. Read and validate the message header */
     r = vhost_user_read_header(dev, msg);
     if (r < 0) {
         return r;
     }
 
-    /* validate message size is sane */
+    /* 2. Validate that the payload size is sane to prevent buffer overflows */
     if (msg->hdr.size > VHOST_USER_PAYLOAD_SIZE) {
         error_report("Failed to read msg header."
                 " Size %d exceeds the maximum %zu.", msg->hdr.size,
@@ -320,9 +335,13 @@ static int vhost_user_read(struct vhost_dev *dev, VhostUserMsg *msg)
         return -EPROTO;
     }
 
+    /* 3. If the header indicates a payload exists, read it */
     if (msg->hdr.size) {
+        /* Advance the pointer to the start of the payload section */
         p += VHOST_USER_HDR_SIZE;
         size = msg->hdr.size;
+        
+        /* Block and read the exact payload size */
         r = qemu_chr_fe_read_all(chr, p, size);
         if (r != size) {
             int saved_errno = errno;
-- 
2.34.1


