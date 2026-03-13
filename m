Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD2B7106FD6E
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 03:10:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0suE-0000w1-Vv; Thu, 12 Mar 2026 23:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w0suC-0000vT-Qd
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 23:09:40 -0400
Received: from mail-dy1-x1336.google.com ([2607:f8b0:4864:20::1336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w0suB-00017u-5J
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 23:09:40 -0400
Received: by mail-dy1-x1336.google.com with SMTP id
 5a478bee46e88-2bea8a1c040so302013eec.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 20:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773371377; x=1773976177; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yzfjk3WBN6i3CkQe1TmyF3J36CtVBQdyaJf9bxHnuwE=;
 b=hgR9Zsd7Gss83E3hTeJDdCYF26V8bFI98bh1oRsJ3FnNZEFLOdgrOwdHX3zvFPYs7B
 YMmltrqSJ34328shCLqUWOriJ8BxBoH3JdZPpveN8xuxkIIxjlJgDT4by5xY11vSEDn9
 YQ3dAUAvvJ9fcSwEb7pO4p86s++QluYipW9/ReuS/LRTsKh/X6aAi93OjzaaGuXQ5vk5
 Bb/GAZUoeOoNrofExlKLT4xYpU+LBL+0vUsgQTltzEko/L617pGKjeGjp3/tV+MEYU95
 GVRZoVlo3DM5QwKs95xgHeam3deI3HrV6Yt7O2TKZwKN1hYXPkyWxVHBX38mGc2DxS7D
 GIJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773371377; x=1773976177;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yzfjk3WBN6i3CkQe1TmyF3J36CtVBQdyaJf9bxHnuwE=;
 b=kYULqZg0hckPZxwo2nfIdpwXjvWtyiHBW1UKGPIpfGeY6kzgjA12WZwCLQ1T760B0L
 jnJO2kekv8giT6JNzKrd+hi8kXmDWRJMcXkPQ1+30guf0BpXmNHQYCoadWaJG7hDrJoM
 Z3GNF6aNfPBGnD2ogrJRdhl3BiU8suyfP6lgAKZbHxkJQHR5cJ/F3Q1UA8wltJ4ZPGoz
 o3iRzph11ttY/DUzy+PSBn0WeB0P9B84K2CA5UTtLJs68qslOenczI1mr/LlQygV6bRK
 D5RrmTvYA/wwpYRwtf28ITpzerLws6rQkrayhBHvTqKJbjqL2bSXeEwn953eALf2sdRv
 WusA==
X-Gm-Message-State: AOJu0Yzwa0VsEDq4PaWqf0EWSBRWo9jRwxInZPPZ0wqvMWl0V1+Sosin
 906yvApVG3Cq1pEIJi7zKtRdmAoB/5igWNgglB2j5L8Vb7tb/5DfkJSrh18JurhL
X-Gm-Gg: ATEYQzxqrsqzut0uaqDVtfe0m9PKhsgoRTn59unChCyYYGRwAYGFxQjLYIKcxyBXhE4
 aYivz0JlSpHZcmsqObEmlPHTDPoTR4B/d19wrH7uniu0v75xVVj0WSHXcdSYJiYSdyquiqgCWMq
 BnRbHaZhco1C0LErTnFt2TLjGeIBjipe6hu/OLfToFgFeuJmtu4AhYT+QD9rar9MXohgqfCd3Sl
 mad8dnyGOZj2Z7N7b79lf+bJBn/vRuQRAUQMt2+7JB4UUFeC2PZY/xHj2IPxGhDXrns/YCEWwVU
 8RtJqePx8beN3t/EfMMhtbzqq8YrQHq7LxiiiqS7DY1WJOV/JhfGxMGaUPvUN5IHBEtVFQeir0R
 sqMQgyYfXwKZqGXNEcAdov/4TI//G7DEI8td47Np7914p2+rMeUfYT8JJowugLKGY0hs0Ip7SVQ
 YRNQ6ePUnbXMyP31H3c7iZAiahK5R75X4t70TNsdrU8na6o+ORROw=
X-Received: by 2002:a05:7301:10c4:b0:2be:9e34:fd24 with SMTP id
 5a478bee46e88-2bea5537045mr813515eec.34.1773371377309; 
 Thu, 12 Mar 2026 20:09:37 -0700 (PDT)
Received: from 192.168.0.29 ([2804:14d:4c71:86dd:588a:39d7:d008:37c2])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2beab52702asm902472eec.16.2026.03.12.20.09.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Mar 2026 20:09:36 -0700 (PDT)
From: Lucas Amaral <lucaaamaral@gmail.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, dmitry.osipenko@collabora.com,
 marcandre.lureau@redhat.com, Lucas Amaral <lucaaamaral@gmail.com>
Subject: [PATCH v3 3/3] virtio-gpu: advertise VIRTIO_GPU_F_BLOB_ALIGNMENT
Date: Fri, 13 Mar 2026 00:09:24 -0300
Message-ID: <20260313030924.45299-4-lucaaamaral@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260313030924.45299-1-lucaaamaral@gmail.com>
References: <20260311022752.64192-1-lucaaamaral@gmail.com>
 <20260313030924.45299-1-lucaaamaral@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1336;
 envelope-from=lucaaamaral@gmail.com; helo=mail-dy1-x1336.google.com
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
index de7a86a7..44ae5034 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1532,6 +1532,14 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
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
index 00cd3f04..252704e7 100644
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


