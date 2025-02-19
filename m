Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E66C9C021AD
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 02:05:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkZRj-0005U2-71; Tue, 18 Feb 2025 21:04:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oenhan@gmail.com>)
 id 1tkZHo-00041B-7Q; Tue, 18 Feb 2025 20:54:04 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <oenhan@gmail.com>)
 id 1tkZHm-00035e-Gm; Tue, 18 Feb 2025 20:54:03 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-21f61b01630so5802625ad.1; 
 Tue, 18 Feb 2025 17:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739930040; x=1740534840; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=D6LgqpX03QwL6L9d1sOao/5xpDf5ua9wvYOQ+nsrjqA=;
 b=OuPCwHlG5qcH0dBMraAwUUDMQo+49ekbCXg/6y795iBJwx9UR5rnB9a8yXoCO3Q3Vp
 0kpAXsH+nwsJGr5hhW9n12Y/Bc+C5kv1dfZ3WMIJDeW2sGbpog4rhKC643U7SCyCAeu7
 5E/1bz9i266T+rMusL1/+TBD++26LFbZAn2u7xRFiwQPWvmIqUcXI/4dIvANKlY0ZGtK
 WH9WIUhG895wujYl+ZRePZY1GDEcb6ojFFVyFOeJDVkPMSqI/+3Uym0Pbv7goXp/bc9P
 WDH9vA+9g4Grafj8Mjo5JNrPeM0LWk8oKpQvZ/Y9sm1jSVYwkIrHzQfHpahvIt/ZYic/
 qETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739930040; x=1740534840;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D6LgqpX03QwL6L9d1sOao/5xpDf5ua9wvYOQ+nsrjqA=;
 b=cg5/KM06Tt3JRJfkL3KPbN4HA/XNDEhJAoAdtL+4vLrVuiABP9KzicExznql3nIwC4
 FeJaAntdHBO6c2RfXMoP1LH9AhL7GE8jmfTb1MWLo3OqURZC9JNDgs6XXPl88ru50pIq
 zQDurjlzS44BDcIrmsAEN6w+44cubRFjoTixtnBIWMr8YgtjgIKEdI8vjlGLp4wKgn44
 ewnBZABjrW21Re/9hTaytUvv6BBs8OGxjTBvc+3WHwRo5Wn+nlYw5nWhgG/kaeJlNzXk
 HaWfFmYT/8OmGsXgaMi1u1R/ZDOsU+S3dRqC8fm7oOgd3cHRgqhom9HYM7bFf2vR2Ikb
 AakA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4kkdzjkdXeRCfrUfAqUbYweDKjPiUK+y/D/jVwnDkwhDkt21Zu1J6uGqwJnuLcIb40wUUZo6bpvVIOw==@nongnu.org
X-Gm-Message-State: AOJu0YzfwvNqSZBzKy56DpWeL90oeGr5VLFWBDFl5+0VQsvoRSKyHN93
 ly0ByeqpLWzY3TdHcavL34SJReqLk+6Tu5L8fYU/mVLMSbHJMGZh
X-Gm-Gg: ASbGncv/HJalJGg4+seUL8K3oZBfskO0TzPZJYqXuPdQPre95Go1cf0ObhJApYkPz//
 SpJBHRJ7LwbDZMtFjXaO/abHmMRy1fdtbkXARdv7V62xnCTX/eO6X1P9L2CVYydxwUGZcSc0YDj
 WMGICWP8CL8SqxFD0JCJRyCB3UXGTTD+uy0vvuqMynjua7hCxSaV6mp8MC42/Ur3NqxlpbeSywS
 eoNiEAuCs2+m+775TbmhUVhYvKaJKHg+fSpSYqlwJmeMqWc2Y7fsRXMCFA9esVx+CdnY4LomSaJ
 BpdnimqDvPazcDzV/R9Z8INj+C0I+LOigiUhcTjwcgEar7ReWTWaovakfuXn7wI/1Pgxnludmw=
 =
X-Google-Smtp-Source: AGHT+IHUdqNI+toHhDdZgO7OpcEjvpW9TqZ5xV5NvHWXOCzLSFuYlTo9ld4Ag8Xu3fo9Cy2J2wTJxA==
X-Received: by 2002:a05:6a00:1886:b0:732:6a48:22f6 with SMTP id
 d2e1a72fcca58-7329cf56ec1mr2978748b3a.9.1739930040471; 
 Tue, 18 Feb 2025 17:54:00 -0800 (PST)
Received: from localhost.localdomain (172-234-80-15.ip.linodeusercontent.com.
 [172.234.80.15]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-adb5a92d3basm9862675a12.75.2025.02.18.17.53.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 17:53:59 -0800 (PST)
From: oenhan@gmail.com
X-Google-Original-From: hanht2@chinatelecom.cn
To: mst@redhat.com,
	sgarzare@redhat.com
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Huaitong Han <hanht2@chinatelecom.cn>,
 Zhiyuan Yuan <yuanzhiyuan@chinatelecom.cn>
Subject: [PATCH v2] vhost: Don't set vring call if guest notifier is disabled
Date: Wed, 19 Feb 2025 09:52:35 +0800
Message-ID: <20250219015235.130194-1-hanht2@chinatelecom.cn>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=oenhan@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 18 Feb 2025 21:04:14 -0500
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

From: Huaitong Han <hanht2@chinatelecom.cn>

The vring call fd is set even when the guest does not use MSIX (e.g., virtio
PMD). This results in unnecessary CPU overhead for handling virtio interrupts.
The previous patch only optimized the condition when query_queue_notifier was
enabled and the vector was unset. However, if query_queue_notifier is disabled,
the vring call FD should also be unset to avoid this inefficiency.

Fixes: 96a3d98d2c ("vhost: don't set vring call if no vector")

Reported-by: Zhiyuan Yuan <yuanzhiyuan@chinatelecom.cn>
Signed-off-by: Huaitong Han <hanht2@chinatelecom.cn>
---
v2: - add Fixes tag
    - cc qemu-stable@nongnu.org

 hw/virtio/vhost.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 6aa72fd434..d17e7cc6fe 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1342,8 +1342,8 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
     }
 
     if (k->query_guest_notifiers &&
-        k->query_guest_notifiers(qbus->parent) &&
-        virtio_queue_vector(vdev, idx) == VIRTIO_NO_VECTOR) {
+        (!k->query_guest_notifiers(qbus->parent) ||
+            virtio_queue_vector(vdev, idx) == VIRTIO_NO_VECTOR)) {
         file.fd = -1;
         r = dev->vhost_ops->vhost_set_vring_call(dev, &file);
         if (r) {
-- 
2.43.5


