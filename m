Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A33DBD1BDC0
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 16:22:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7zpp-00051m-RS; Mon, 04 Nov 2024 11:21:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1t7zpo-00051O-IB
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 11:21:44 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1t7zpm-0001e2-Oy
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 11:21:44 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2e2e88cb0bbso3370590a91.3
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 08:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730737301; x=1731342101; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2qjarR8FdQV3Yon+gtyLJmSDTycOunhRCpelKdnfkZY=;
 b=GdATHCgVk4tzrckLZ4HLyPND7rC1d1tZ5ZHkfBJSyI6+0+kyYk+ovkMfII8lk4KNt9
 nTFI/ln729rJddFjTyB2NYvKEmk3OGjydOxjy68vvjiVQrOBn/GZspn2OoX4vSYetLrr
 L8AyMrGcDLsmgVfQya7JgRIjrJhdUB/0EEllI/KWHKFeG/HrelQoTMwcqN1MpdqrrhoS
 GTj+UFaDvx/3SssT3hyeekTnSflImF3zslstHNJoDrkzA2pgKYQz8SlfTqEKFz5F6I5q
 cwvGo1ydX9y7SPvPwSWQGhd2yQimRyfR/1dazB+utN5lvEOFDyJsglgwmIw1wP2jqCn5
 YTYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730737301; x=1731342101;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2qjarR8FdQV3Yon+gtyLJmSDTycOunhRCpelKdnfkZY=;
 b=SmD3Fz/a9VFAbB1BaeeI90uJPcjH+KhPnE39C8KsZduXM51q16aSo4WDvByIrqheBF
 Uz/LnpcKafcAVXHaQrqsilKFYEzQXzeo7H79moBBAMrv4xOxaOcPT17y70xPVtAapWgC
 nhHgTC+xjWi1klLKAp+Ul5mZ4GqASU2Am+kzmvSjbDxxgrMkwCgZm+U++4qPnbs2sEPc
 nQmbn2N6iLfOue254j5oHefNH2lnaZ2bQl3yqcesbCMnb4GIthBjCvcoWzCxbxsAmo2V
 dGKkzR8VXN3ov6pBk5+0f1/x2IxZVwpBwxY+Svx2sfvR/QQ4dzdTvJm8yL/PtYng9wuc
 IEXg==
X-Gm-Message-State: AOJu0Yx+5A8wyr/o1Y1gnVtr8Q3EL+c3KO9gxVH/E7Uddz2j71/GgzLt
 7Xn8ov6Iz1ln55hqbmNmUSmQLpPNQyj8Su8MME15qNwaxFR6bF6E
X-Google-Smtp-Source: AGHT+IFC5RqEdybgP63yAKB03nWDVkm80CV7n2NH5H7y7MRGb1z3NnZirHTEg0hWYlJQN0qD8OQYjg==
X-Received: by 2002:a17:90a:b111:b0:2e2:d16e:8769 with SMTP id
 98e67ed59e1d1-2e8f106926emr34708335a91.15.1730737300603; 
 Mon, 04 Nov 2024 08:21:40 -0800 (PST)
Received: from valdaarhun.. ([223.233.80.39]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e92fa26246sm9999257a91.18.2024.11.04.08.21.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 08:21:40 -0800 (PST)
From: Sahil Siddiq <icegambit91@gmail.com>
X-Google-Original-From: Sahil Siddiq <sahilcdq@proton.me>
To: eperezma@redhat.com,
	sgarzare@redhat.com,
	mst@redhat.com
Cc: qemu-devel@nongnu.org,
	Sahil Siddiq <sahilcdq@proton.me>
Subject: [PATCH] vdpa: Support setting vring_base for packed svq
Date: Mon,  4 Nov 2024 21:51:24 +0530
Message-ID: <20241104162124.49867-1-sahilcdq@proton.me>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=icegambit91@gmail.com; helo=mail-pj1-x1029.google.com
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

Linux commit v5.14-rc1~30^2~8 enabled the vp_vdpa driver to set the
vq state to the device's initial state. This works differently for
split and packed vqs.

With shadow virtqueues enabled, vhost-vdpa sets the vring base using
the VHOST_SET_VRING_BASE ioctl. The payload (vhost_vring_state)
differs for split and packed vqs. The implementation in QEMU currently
uses the payload required for split vqs (i.e., the num field of
vhost_vring_state is set to 0). The kernel throws EOPNOTSUPP when this
payload is used with packed vqs.

This patch sets the num field in the payload appropriately so vhost-vdpa
(with the vp_vdpa driver) can use packed svqs.

Link: https://lists.nongnu.org/archive/html/qemu-devel/2024-10/msg05106.html
Link: https://lore.kernel.org/r/20210602021536.39525-4-jasowang@redhat.com
Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
---
QEMU currently does not support packed vhost shadow virtqueues. I am
working on adding support for packed svqs [1]. The test environment
that I am using [2] requires vhost-vdpa to use the relevant payload
when setting vring base.

[1] https://wiki.qemu.org/Internships/ProjectIdeas/PackedShadowVirtqueue
[2] https://www.redhat.com/en/blog/hands-vdpa-what-do-you-do-when-you-aint-got-hardware-part-2

 hw/virtio/vhost-vdpa.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 3cdaa12ed5..5f81945109 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -1230,6 +1230,10 @@ static bool vhost_vdpa_svq_setup(struct vhost_dev *dev,
     };
     int r;
 
+    if (virtio_vdev_has_feature(dev->vdev, VIRTIO_F_RING_PACKED)) {
+        s.num = 0x80008000;
+    }
+
     r = vhost_vdpa_set_dev_vring_base(dev, &s);
     if (unlikely(r)) {
         error_setg_errno(errp, -r, "Cannot set vring base");
-- 
2.47.0


