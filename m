Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F183FD88D8
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 02:28:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w09J1-00015q-2y; Tue, 10 Mar 2026 22:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w09Is-0000tD-Hg
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 22:28:08 -0400
Received: from mail-dl1-x1233.google.com ([2607:f8b0:4864:20::1233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w09Ip-0003vV-RZ
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 22:28:05 -0400
Received: by mail-dl1-x1233.google.com with SMTP id
 a92af1059eb24-12776bebe9fso659512c88.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 19:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773196082; x=1773800882; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J5J5OYjq+qbSyZKLX7Uj093GYMjgrX6jSJBJCQtEQh4=;
 b=kg9kG1O2Q30Jx0PnuebXkD5xkGNGhUhiXSa+bokM8Ypt9ZyANFapDdNQt3HaXT+oFZ
 oEbC2u/xZd8/Nfho3I+/SM77+/bMB5GfHwB7ptAI5fsoyY14ymFxwmL16brJd3MJ4cUO
 ax8nTSHwbUUsYOptVnaT++nSeUSkjmsmkF4QrIe6Yy01srGkAM8E4ivEEs+3BOMPWcs9
 F5kJDLhI0uDnQY5Y1qgH4MwlhUOUootm2lSPNKLpBgg/2yZfYtq29RohrEGoU6v4sW3p
 bJL8V7xOdonNFB0ROaH7xnzilfnMtK9JhNZyaq+vrWr2CrxMxWUG79DB6K7nHCYoLsrW
 EZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773196082; x=1773800882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J5J5OYjq+qbSyZKLX7Uj093GYMjgrX6jSJBJCQtEQh4=;
 b=k8SIw38d8r923NMLom/mcaPqSHXueBHfFAro3KwFXxTpOnGPZVePyvQPGpdxmv4ES6
 MKj0+NHBuGuC+qZeZNCWG5hOxvy6dSTFnOvbG8n9sojDAdWngiayBxsDXjdpr1ZNSJSs
 XuBi7BWSTyy1k5Cia8CFJDDYhqNx3gV89UiDe2mk6P8ubDuB+slzUP0cmQEYNIuXUtUV
 to+n9Q9OPLyGAnqmtch9jX+F9odWpgZwD6i8Y42st8orFy9bRPxi2efLTbhwXnEhv0RX
 4aEEmlNipMciupVbkyGmNK7ijWSoyWxO5dircrdI7auLZfnaSkzhAOiDpm7XLjFhthqx
 Tz7g==
X-Gm-Message-State: AOJu0YzzI3kHr+c9Vbe3e9ce3xbEImOL83fddhmIRADUY7rUlNbJFAXI
 bzzsenO1cj/xvkFfoOSWeR+jKlZ8wg3tVcKR8mofnR5HUX2O5C3Ip9DzCQdUcw==
X-Gm-Gg: ATEYQzycpx0L/8hr4bbZbbPDBRXkEG6mOdTPdL0JY6l0IWfAigLacVqoY1LPdaJyKL3
 cm/qUJVYD7Wg+Mfnom4b2YYfVOAyBhW8RWcmg+fnSczkJITOy8T3HGUC5p5PSsUbbAETLOru816
 iq3/1z0crI/8kgxdY1CH6diwV1wX+N81yPnDMRtkMqGZM/4vtERrgHoSpdCDdYFL/bXVKEs+Rwf
 nU72m2WRbBEljakXWhcda3fSL7+RhA8RTUL1hUKHzzRLXu5idBmAS5oiO2/c5BemeSmHIs8SB2n
 RPM4nzTZeIJwXw8dPV7i+JcgU/uAHwGIWxiR+TDeOMM7rrVQCCuWw+cLwcHqK8vo9QDqzZQp9jo
 bXZncHfHXxMkGoIBgj8GEBcDNjoQK9iqEEIjR56kb6gJwwpnLKS16ldwh8ndmM7BveIR7EPdDBO
 0w5ZUeOfQ/1A4RROOCflGfepQuidp8Z2TZB+fF+jM7Ei9HLyB7O7c=
X-Received: by 2002:a05:7022:4587:b0:127:9d23:ad43 with SMTP id
 a92af1059eb24-128e7787fd4mr570850c88.1.1773196081535; 
 Tue, 10 Mar 2026 19:28:01 -0700 (PDT)
Received: from 192.168.0.29 ([2804:14d:4c71:86dd:80a9:8ba1:b664:ae3d])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-128e7cd6aafsm915123c88.14.2026.03.10.19.27.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Mar 2026 19:28:01 -0700 (PDT)
From: Lucas Amaral <lucaaamaral@gmail.com>
To: qemu-devel@nongnu.org
Cc: Lucas Amaral <lucaaamaral@gmail.com>
Subject: [PATCH v2 3/3] virtio-gpu: advertise VIRTIO_GPU_F_BLOB_ALIGNMENT
Date: Tue, 10 Mar 2026 23:27:52 -0300
Message-ID: <20260311022752.64192-4-lucaaamaral@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260311022752.64192-1-lucaaamaral@gmail.com>
References: <20260309214930.92616-1-lucaaamaral@gmail.com>
 <20260311022752.64192-1-lucaaamaral@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1233;
 envelope-from=lucaaamaral@gmail.com; helo=mail-dl1-x1233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_BARE_IP_2=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Define VIRTIO_GPU_F_BLOB_ALIGNMENT (feature bit 5) per the OASIS
virtio specification.  This allows the host to communicate its
memory alignment requirement to the guest via the blob_alignment
field in virtio_gpu_config.

Set blob_alignment to the host page size so the guest kernel can
align blob BAR offsets accordingly, avoiding alignment mismatches
with the VMM's memory mapping API (e.g., hv_vm_map on macOS).

Guest-side kernel support (drm_mm alignment) is pending upstream
Linux merge.

Signed-off-by: Lucas Amaral <lucaaamaral@gmail.com>
---
 hw/display/virtio-gpu.c                     | 8 ++++++++
 include/standard-headers/linux/virtio_gpu.h | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 643e91c..c12273d 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1517,6 +1517,14 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
 #endif
     }
 
+    /*
+     * TODO: guest-side F_BLOB_ALIGNMENT support pending upstream Linux merge
+     * (Sergio Lopez's patches, Nov 2025). Until merged, the guest won't
+     * negotiate this feature. The host advertises it per OASIS virtio spec.
+     */
+    g->parent_obj.virtio_config.blob_alignment =
+        cpu_to_le32(qemu_real_host_page_size());
+
     if (!virtio_gpu_base_device_realize(qdev,
                                         virtio_gpu_handle_ctrl_cb,
                                         virtio_gpu_handle_cursor_cb,
diff --git a/include/standard-headers/linux/virtio_gpu.h b/include/standard-headers/linux/virtio_gpu.h
index 00cd3f0..252704e 100644
--- a/include/standard-headers/linux/virtio_gpu.h
+++ b/include/standard-headers/linux/virtio_gpu.h
@@ -64,6 +64,11 @@
  * context_init and multiple timelines
  */
 #define VIRTIO_GPU_F_CONTEXT_INIT        4
+/*
+ * VIRTIO_GPU_F_BLOB_ALIGNMENT: device advertises blob_alignment
+ * in virtio_gpu_config (OASIS virtio-spec feature bit 5)
+ */
+#define VIRTIO_GPU_F_BLOB_ALIGNMENT      5
 
 enum virtio_gpu_ctrl_type {
 	VIRTIO_GPU_UNDEFINED = 0,
@@ -365,6 +370,7 @@ struct virtio_gpu_config {
 	uint32_t events_clear;
 	uint32_t num_scanouts;
 	uint32_t num_capsets;
+	uint32_t blob_alignment;
 };
 
 /* simple formats for fbcon/X use */
-- 
2.52.0


