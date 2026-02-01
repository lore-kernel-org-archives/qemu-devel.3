Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B86DD172A9
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Feb 2026 23:21:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmgk0-000531-Qo; Sun, 01 Feb 2026 18:20:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmgjz-00051V-Ve
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 18:20:28 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmgjy-0000H8-Fg
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 18:20:27 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48068127f00so32306715e9.3
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 15:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769988024; x=1770592824; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EAuDEWjgtcjAI73PpDk9D1EoNYCz8v3TBHOpftqU/Uk=;
 b=FOuft4NweEY+IbSuazrUqK5s4F32jHW0m9TGPbtPjfN6HaD5wWMBTyB26CP1x7T01j
 hTn1/nEFHEyKM0DPlD0pv4xFDVHv7havIAWuUvEYVlHUnIMQiGeuBpMIoUXweXdLjivs
 q3Q+U8l2J4L+6GaJSRsV/Z1GAwen878+qjhRsOdbK51iX5Ui4qzMuQiYjz9HsXh5Ls9e
 OVKZdLoRCPp6em4gZpL8rbptyPU8AciRBo9BZuWvMZIGmKUI+7gUq2qiBPLFG24JuAwr
 X4h4plgxkvfjV0w+EHbFiaAuSAMuqvnZ9C67UYEOp8xZeL0fclwPSNNmKFwZy48G8jns
 NnBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769988024; x=1770592824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EAuDEWjgtcjAI73PpDk9D1EoNYCz8v3TBHOpftqU/Uk=;
 b=wtg18l9Ypw0KJ1zpYOvPCjC9G1KkFqGDK5KYqRkpRg4Nf5Dax8z4LwZSdMyNnK4UFU
 uz+abIvbv8Dv9GK/diHRAVf8xu6pXKoH44YfXv3Y5bza1pbxAwZ/xVwCwc7Sdvosd2jn
 H3MN0gIYjg5Zq11KKX1jBaPYE4gQldAAU7YqeEpyCqgRqcXTBFK1izGnNfIbpbYe9ahd
 MwL7KYimu9r+Hz9H3L0XoHNyReKf9VeiIcPp9/N9XCvNByj6C8WIM+e1wdi0MNV/mdBI
 ZBCp0b5Puf7KEp4FrkD57UKTLznbAHPR1FPd7+Ie+McW0WriW0Giur8j+dp/kKQNa2nC
 m88A==
X-Gm-Message-State: AOJu0Yw8Mp8SvmBuuKb2GrtYPpvvhYyzytb4fTlhPHMO6LYN9js5gPQU
 ToMahJPhHy8DcfLEfpy3MXUVw7dAvLWflSCFDm/703vrawHT1YI1uf8FEpnJDQI1QJi8Dg7L6CU
 ceATXkgc=
X-Gm-Gg: AZuq6aLToHsHrs3ErzggvPuVAASOh5zP3dOzN+CyETxL290t4/XhGbaUhwAEJ/gB9MJ
 zE+Od5bqZGZAVfQGmOWNNImLR00HKw9BC+iS7cpUFTi0jeWkjgvz3B2sJm2E5MsCf/JZQwfpxnX
 Hhaj+0yLQRfZPVAMjx5cnqxFUILOCtMQBIpXq3kezWlHEtbFAE274Ba5tzrSbmuhxrMB/X7Rp2q
 4wKml86Am8nWLZ3hzl3pROlHTR9gonw0B2SLQzo/u255KqL6dG1XnuUquHnbdJZ8lr7e5M5D6dg
 2vWWId3EXSaqe7Ji3yGuTduyC8/3r/GnKvNAr31fhAERs7VLnQR7bVsQH1ftoJcSSgWWyQmSDWb
 iTdJKhM9jiUR0QBzqhMz+pkgyZ/3R+bztQatCZlw1rqQXXW2cZnayV4rnUdbz+kEXP2BlwXjJQ3
 GLidjuGZSmhL7QtDs7XFfLkj9Blkad3X2OJpXJOgHR24FWorJDzHoUQeWSpBJ5
X-Received: by 2002:a05:600c:358d:b0:480:f27c:6335 with SMTP id
 5b1f17b1804b1-482db499704mr137519085e9.25.1769988024354; 
 Sun, 01 Feb 2026 15:20:24 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806cddffe9sm507872655e9.4.2026.02.01.15.20.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 01 Feb 2026 15:20:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v2 03/10] hw/virtio: Introduce
 VirtIODevice::access_is_big_endian boolean field
Date: Mon,  2 Feb 2026 00:19:52 +0100
Message-ID: <20260201231959.88559-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260201231959.88559-1-philmd@linaro.org>
References: <20260201231959.88559-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

VirtIODevice::access_is_big_endian boolean field, initialized on
device reset, represents whether load/store accesses are ordered
using big endianness.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/virtio/virtio.h | 5 +++++
 hw/virtio/virtio.c         | 1 +
 2 files changed, 6 insertions(+)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 17b105c146d..7a4f7de7475 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -154,6 +154,11 @@ struct VirtIODevice
     VMChangeStateEntry *vmstate;
     char *bus_name;
     uint8_t device_endian;
+    /**
+     * @access_is_big_endian: whether load/store memory accesses are ordered
+     * using big endianness. Might change during device resets.
+     */
+    bool access_is_big_endian;
     /**
      * @user_guest_notifier_mask: gate usage of ->guest_notifier_mask() callback.
      * This is used to suppress the masking of guest updates for
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 86fc0e262f7..242c207a591 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3247,6 +3247,7 @@ void virtio_reset(VirtIODevice *vdev)
         /* System reset */
         vdev->device_endian = virtio_default_endian();
     }
+    vdev->access_is_big_endian = virtio_access_is_big_endian(vdev);
 
     if (k->get_vhost) {
         struct vhost_dev *hdev = k->get_vhost(vdev);
-- 
2.52.0


