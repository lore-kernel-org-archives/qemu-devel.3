Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 062BCC3DA7F
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2024 15:51:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sadV0-0001fx-1z; Sun, 04 Aug 2024 11:50:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luzhixing12345@gmail.com>)
 id 1sadUx-0001f0-NY
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 11:50:19 -0400
Received: from mail-oa1-x41.google.com ([2001:4860:4864:20::41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luzhixing12345@gmail.com>)
 id 1sadUw-0006Zh-6X
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 11:50:19 -0400
Received: by mail-oa1-x41.google.com with SMTP id
 586e51a60fabf-25e3d8d9f70so5931451fac.2
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2024 08:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722786616; x=1723391416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5wMP4WTzU0xCZQ55XMOPYDIvPMxtBsKQOe0XlHntDvA=;
 b=G0bHL0j4zIW5R2hXhwQqo+Qefu44KzozAWH8jtyoVtWgs9sJ+MLEzLfdOa8/nNnqTm
 FVJmHYRjFckczLT1QtSUjBT6/cjoXh+Xqj0xy+sHwhlFK0hgtQJqVdCxSo/TURD6ML3Q
 04VO0dBaFxiapYf8CMEs9YqeoTnvLiX1jYZFTTNxNrhKaDeL3s+q+7S84l1APvAE7r3L
 BfHrx4kEJZuyYrztueXHSyeRPbR6Y+F/+L1BGBSt9hiKZpP02EBEn6oRtKSz0CfCw8M1
 PPGQIOsZzlvb36NMMxLaU2s+cfiVcgDbx+TV7OWWf/ngrlZk9AFR68TeK0U24WFJnyat
 g58g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722786616; x=1723391416;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5wMP4WTzU0xCZQ55XMOPYDIvPMxtBsKQOe0XlHntDvA=;
 b=EV5wI1hAfuzyrpp06XH7aBaQC3OGVdMbYW/k+JHAdLD7LqDY3CxhUUj/4uTuBe5prM
 +1hgU+hR5APsokyD2aU4dp7MtAmVtDVMij4Wnm7DyhWPnlQoM6GwFCcPiAMabjq/HYFD
 bEAC74JjQ+HU4Gmx4YtIP0pp/0xjKtijOn/MrZHkruGne4+eHtvxTei8ghSTzaPukacg
 JM/Dp9lJnKJKXdSzFQE4vFBUN9GBHkvYvAr1lDO+brC2NUPu4tjRXqWMPIHLTx5kz53+
 TC9WcBnrsQMFoNaaJkZNaCLTOzOm82FMRQgMPBIHnkja9608pn5ho0bxa2/HNwQcBDEI
 YS0A==
X-Gm-Message-State: AOJu0YwJ32jEvLwXNwdYhVbWxh7zJF5w8GBaMnzi9YaUtMYNCoBsooDJ
 JPe6Rum+cJBTtjbkiyP7t+h8p1U5dxThW9QNKi5gfypundJVep2IpgtDES914Ic=
X-Google-Smtp-Source: AGHT+IEKlrZ/vD3R2AUzU0t8bCw+QNJXUwilfniBvHhX5mCBt+3C090cXHOyVhxigZ2Jcpawf+unEQ==
X-Received: by 2002:a05:6871:5a16:b0:268:ada1:5eba with SMTP id
 586e51a60fabf-268ada172bdmr5509176fac.19.1722786616504; 
 Sun, 04 Aug 2024 08:50:16 -0700 (PDT)
Received: from localhost.localdomain ([223.104.134.101])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ed30840sm4056724b3a.210.2024.08.04.08.50.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Aug 2024 08:50:16 -0700 (PDT)
From: luzhixing12345 <luzhixing12345@gmail.com>
To: qemu-devel@nongnu.org
Cc: luzhixing12345 <luzhixing12345@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH] vhost-user: add NEED_REPLY flag
Date: Sun,  4 Aug 2024 23:48:59 +0800
Message-Id: <20240804154859.28342-1-luzhixing12345@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::41;
 envelope-from=luzhixing12345@gmail.com; helo=mail-oa1-x41.google.com
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

Front-end message requests which need reply should set NEED_REPLY_MASK
in flag, and response from slave need clear NEED_REPLY_MASK flag.

---
 hw/virtio/vhost-user.c                    | 2 +-
 subprojects/libvhost-user/libvhost-user.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 00561daa06..edf2271e0a 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1082,7 +1082,7 @@ static int vhost_user_get_u64(struct vhost_dev *dev, int request, uint64_t *u64)
     int ret;
     VhostUserMsg msg = {
         .hdr.request = request,
-        .hdr.flags = VHOST_USER_VERSION,
+        .hdr.flags = VHOST_USER_VERSION | VHOST_USER_NEED_REPLY_MASK,
     };
 
     if (vhost_user_per_device_request(request) && dev->vq_index != 0) {
diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index 9c630c2170..40f665bd7f 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -667,6 +667,7 @@ vu_send_reply(VuDev *dev, int conn_fd, VhostUserMsg *vmsg)
 {
     /* Set the version in the flags when sending the reply */
     vmsg->flags &= ~VHOST_USER_VERSION_MASK;
+    vmsg->flags &= ~VHOST_USER_NEED_REPLY_MASK;
     vmsg->flags |= VHOST_USER_VERSION;
     vmsg->flags |= VHOST_USER_REPLY_MASK;
 
-- 
2.34.1


