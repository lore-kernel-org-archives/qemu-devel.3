Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38FCCCF8851
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 05:43:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swxZO-0003dI-I6; Sat, 05 Oct 2024 01:43:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1swxZI-0003cT-Ji
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 01:43:04 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1swxZG-0006L0-TE
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 01:43:04 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a8d6ac24a3bso533458366b.1
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 22:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728106980; x=1728711780; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=LQ4h53oTsgPeXUGjZy3NFWeRXQatvwGGfIYAxg3DIRI=;
 b=SsVMoCVsCaKNoIaofkhySt6B6VjxBDeCfQeeCU6tJ8HPfrmS4R23BeSeWKrRje1izx
 JhfiGKj6+KG5wnjjmXNDEQ5nmPpldi2YRZWKR0mm90ng4GjRqllTwtA4pcVXV68wzvVl
 ovv6Cr7uyiig0j3DAH+BrOxCTk/nEZWJiOeK8yeBRcD2xt7tDw+ALebHo0mwKYTpJFm7
 y8JZgMrb0M3EF8iviy09ZWLEdsTIdAJbd6MdQ5102afMu9zxBYbJemaqFn69URzyDcNm
 esRup/6gzt1VCltcpzF48Zu2h3u4/2X4xh6p3OgT7kjeoy99jDXTiuOqOMwPkGKEYE64
 J4MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728106980; x=1728711780;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LQ4h53oTsgPeXUGjZy3NFWeRXQatvwGGfIYAxg3DIRI=;
 b=jqb1VHE+9s848e5Z1BJ+o3gyIpoTzAz7Cr5zYTYJsAc+Chbm7Ri8SF8YNCG/iO4LeT
 vnM8NE4uf2EWred9U+jjgJFjkMiiLa4eAyH/qsH5sASJRKvjy9xe0cvgiuq/PDRhrNxp
 KsqrEcuV53sERoRhnJ3laxKiNTmDcOxXdNmHDn+Jcw8ZXvaFab1xk7FZ9uXRNFAQb7Mx
 mmApg9oZ11TFGmUvHGUVZv1sdAKdSHF1keF9OmFgNcaYoffQjvtx69nrdQblpJ2GJzL9
 0rFoIYuGhxA+DpjrxA08xqjY/WoWhjD+JkWeKmiveEo0nLt/UsjNMnaPpFX5ERIsAg4s
 dV+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEgZsEy8nYSXL0QMY625YMGSpOQIfnzMAELP6+82MIPXAZOvi12yTqDieVA67UGNP+yoRiIOruERzx@nongnu.org
X-Gm-Message-State: AOJu0YxpA0GLB/tEMEg0mUOZ6hjNWevvTQC8j0KFYIWdSpSv4+nWt4t4
 uw26pIUZWaoEtdbdJbJGfGaYKGNSSobAANnOP7aJ5CdGu2uNjNSbztf4F1U/AJY=
X-Google-Smtp-Source: AGHT+IGFHSt7E0NT3muigbI3C0iRBnKbt/fFBno4wh24ExXIcXRdhALLpZeZGKVDMlgV6GQU5FH78A==
X-Received: by 2002:a17:907:368b:b0:a8d:6372:2d38 with SMTP id
 a640c23a62f3a-a990a05eeb9mr800102466b.18.1728106980309; 
 Fri, 04 Oct 2024 22:43:00 -0700 (PDT)
Received: from meli-email.org (adsl-74.109.242.227.tellas.gr. [109.242.227.74])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a993fa1b94csm14975166b.53.2024.10.04.22.42.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 22:43:00 -0700 (PDT)
Date: Sat, 05 Oct 2024 08:40:56 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Dorinda Bassey <dbassey@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mhrica@redhat.com,
 Dorinda Bassey <dbassey@redhat.com>
Subject: Re: [PATCH] virtio-gpu: Add definition for resource_uuid feature
User-Agent: meli 0.8.7
References: <20241004164140.1886877-1-dbassey@redhat.com>
In-Reply-To: <20241004164140.1886877-1-dbassey@redhat.com>
Message-ID: <kvbvl.ymheg31fu152@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x633.google.com
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

Hello Dorinda,

On Fri, 04 Oct 2024 19:41, Dorinda Bassey <dbassey@redhat.com> wrote:
>Add the VIRTIO_GPU_F_RESOURCE_UUID feature to enable the assignment
>of resources UUIDs for export to other virtio devices.
>
>Signed-off-by: Dorinda Bassey <dbassey@redhat.com>
>---
> hw/display/vhost-user-gpu.c    | 4 ++++
> hw/display/virtio-gpu-base.c   | 3 +++
> include/hw/virtio/virtio-gpu.h | 3 +++
> 3 files changed, 10 insertions(+)
>
>diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
>index 14548f1a57..053cfd9cff 100644
>--- a/hw/display/vhost-user-gpu.c
>+++ b/hw/display/vhost-user-gpu.c
>@@ -631,6 +631,10 @@ vhost_user_gpu_device_realize(DeviceState *qdev, Error **errp)
>         error_report("EDID requested but the backend doesn't support it.");
>         g->parent_obj.conf.flags &= ~(1 << VIRTIO_GPU_FLAG_EDID_ENABLED);
>     }
>+    if (virtio_has_feature(g->vhost->dev.features,
>+        VIRTIO_GPU_F_RESOURCE_UUID)) {
>+        g->parent_obj.conf.flags |= 1 << VIRTIO_GPU_F_RESOURCE_UUID_ENABLED;
>+    }
> 
>     if (!virtio_gpu_base_device_realize(qdev, NULL, NULL, errp)) {
>         return;
>diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
>index 4fc7ef8896..7827536ac4 100644
>--- a/hw/display/virtio-gpu-base.c
>+++ b/hw/display/virtio-gpu-base.c
>@@ -235,6 +235,9 @@ virtio_gpu_base_get_features(VirtIODevice *vdev, uint64_t features,
>     if (virtio_gpu_context_init_enabled(g->conf)) {
>         features |= (1 << VIRTIO_GPU_F_CONTEXT_INIT);
>     }
>+    if (virtio_gpu_resource_uuid_enabled(g->conf)) {
>+        features |= (1 << VIRTIO_GPU_F_RESOURCE_UUID);
>+    }
> 
>     return features;
> }
>diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
>index 7a59379f5a..15e193bb6d 100644
>--- a/include/hw/virtio/virtio-gpu.h
>+++ b/include/hw/virtio/virtio-gpu.h
>@@ -99,6 +99,7 @@ enum virtio_gpu_base_conf_flags {
>     VIRTIO_GPU_FLAG_BLOB_ENABLED,
>     VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED,
>     VIRTIO_GPU_FLAG_RUTABAGA_ENABLED,
>+    VIRTIO_GPU_F_RESOURCE_UUID_ENABLED,


s/F_/FLAG_/


> };
> 
> #define virtio_gpu_virgl_enabled(_cfg) \
>@@ -115,6 +116,8 @@ enum virtio_gpu_base_conf_flags {
>     (_cfg.flags & (1 << VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED))
> #define virtio_gpu_rutabaga_enabled(_cfg) \
>     (_cfg.flags & (1 << VIRTIO_GPU_FLAG_RUTABAGA_ENABLED))
>+#define virtio_gpu_resource_uuid_enabled(_cfg) \
>+    (_cfg.flags & (1 << VIRTIO_GPU_F_RESOURCE_UUID_ENABLED))
> #define virtio_gpu_hostmem_enabled(_cfg) \
>     (_cfg.hostmem > 0)
> 
>-- 
>2.46.1
>
>

