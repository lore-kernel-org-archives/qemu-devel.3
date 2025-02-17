Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C866C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 14:08:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk1mY-0004UU-Q9; Mon, 17 Feb 2025 09:07:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1tk1mS-0004Tq-IR
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 09:07:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1tk1mQ-0007Sd-IY
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 09:07:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739801244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0/I7QnwGsEK7DwuVrIC50Z7se5/sI6Mhzp0Yx4NdQtw=;
 b=d4xtnTOJJUlH6C5D1Ac1+yr3reEjhe5f1nE3iqkkzUXJDszioKTQIaSnyaYNc61OvOF6wV
 9pabIq4wHNP0dgYVa2Yhm6v1Z8A4vB3+PXky15xWDtxNf1xJuE0MtsOjQbu7NMMi1OVYYn
 rWypaQaIHCwcfVHqhgt9WH/qXZnjFqw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-sGf7dQbYOjK2RIe-7NJJ9Q-1; Mon, 17 Feb 2025 09:07:22 -0500
X-MC-Unique: sGf7dQbYOjK2RIe-7NJJ9Q-1
X-Mimecast-MFC-AGG-ID: sGf7dQbYOjK2RIe-7NJJ9Q_1739801241
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43988b9ecfbso3960315e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 06:07:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739801241; x=1740406041;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0/I7QnwGsEK7DwuVrIC50Z7se5/sI6Mhzp0Yx4NdQtw=;
 b=V4InNd+UOZ21H0M0F4OGJit0cYx8B1DwXTStevjOItUGZjUICfXyn+rK4aezfhII/y
 GOmZAnmD/DrW7Aj10Djqf3JVY/deTbO5AHW8CMwTZ8o3WKrqrMjBrZzW62ziv9Yaf0Ac
 ZRU2JY9egg3g8ZR1V1DJ31x1ysk+NP3QQ2jz0Z1nTSlZE9hapVQ3AGHKGTa/O7rOefPp
 vdA9mE75nSO+zSoCZDSK03QtVYtEn3Q0saKVwrYS1ROe7dRzgLM6PmFmrok3PjNjKCPM
 4nr8e/OrPZDtuRCfCts3Jl3R86/5LmgQjQQcc5tI8/CPkmCF5ix95humNZQMI8Sxxrn7
 Qv8Q==
X-Gm-Message-State: AOJu0Yw9c3iTVxhd2osrnduW8ufdo0Ge66v+LMJJ/LKgTAOn4luIG9gV
 KC1n4D7qq+GSuVJNrKav3uNK4Ek4nNCLKZ4wbuCRXbMp624MZR69zdNPjfDlrejHEFTqeijkhRr
 IlI+Zq7m7m3QrVo7iBzzYe53ugbCChUXy7c/tkn5TSBxEivpD2i12
X-Gm-Gg: ASbGncu2WUHlw9fZXCDTd6flXl40hloWsnwsUUUkae9GnVt1TKlaasLqIUD85G31YiR
 WHTvGEwIV/fl7b587brilDEzk6nB8N1nbH6DBCP5dtkZ6Fh86uZEabVWN/PSIfPVJKpmapegzj2
 omiI380sri8VBuP1Y2gNhfcxN7L7a4ncLSQK6UEVpYiTZ/ROmKrl7G+D/rAa5NsH3lcift2V8tT
 AF72LpmmUCYDOUsyzeDQ+PaCHih8C5CqgPDeJ+BY1JWF1zgWZn54hpvoxW5v9jqbuOJg8lZZ+dC
 cYzRRDpucaqk4LH6SG6iEh2ZOWj7RR8R6cGFQ5GGnSMYIgZSqRSFYw==
X-Received: by 2002:a05:600c:458e:b0:439:65fa:5872 with SMTP id
 5b1f17b1804b1-4396e7335fbmr75530855e9.24.1739801241164; 
 Mon, 17 Feb 2025 06:07:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7fnmOWnnG1+BfA+FI4c2pbAQ1QoBdrVUu4r8+J1lwc/Ef5gtrQDDjN9G26gEPeSAxmJUjDA==
X-Received: by 2002:a05:600c:458e:b0:439:65fa:5872 with SMTP id
 5b1f17b1804b1-4396e7335fbmr75530245e9.24.1739801240408; 
 Mon, 17 Feb 2025 06:07:20 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it.
 [79.46.200.29]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4398872fa85sm20236535e9.28.2025.02.17.06.07.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 06:07:19 -0800 (PST)
Date: Mon, 17 Feb 2025 15:07:13 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-stable@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2] vhost-user-snd: correct the calculation of config_size
Message-ID: <rmroel5kfax2inqmwtbu2bdabzppz46agjh2epjx7enup5kpsi@bqjc6oxnaagj>
References: <20250217131255.829892-1-mvaralar@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250217131255.829892-1-mvaralar@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Feb 17, 2025 at 02:12:55PM +0100, Matias Ezequiel Vara Larsen wrote:
>Use virtio_get_config_size() rather than sizeof(struct
>virtio_snd_config) for the config_size in the vhost-user-snd frontend.
>The frontend shall rely on device features for the size of the device
>configuration space. The presence of `controls` in the config space
>depends on VIRTIO_SND_F_CTLS according to the specification (v1.3):
>`
>5.14.4 Device Configuration Layout
>...
>
>controls
>(driver-read-only) indicates a total number of all available control
>elements if VIRTIO_SND_F_CTLS has been negotiated.
>`
>This fixes an issue introduced by commit ab0c7fb2 ("linux-headers:
>update to current kvm/next") in which the optional field `controls` is
>added to the virtio_snd_config structure. This breaks vhost-user-device
>backends that do not implement the `controls` field.
>
>Fixes: ab0c7fb22b ("linux-headers: update to current kvm/next")

If we want to backport this on stable branches, better to add:

Cc: qemu-stable@nongnu.org

>Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2805
>Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
>---
>Changes in v2:
> - Addressed comments from Stefano Garzarella about commit msg and the
>   property name.

Thanks for that! LGTM, I also tested with old vhost-device-sound and it 
works well!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>---
> hw/virtio/vhost-user-snd.c | 18 +++++++++++++++++-
> 1 file changed, 17 insertions(+), 1 deletion(-)
>
>diff --git a/hw/virtio/vhost-user-snd.c b/hw/virtio/vhost-user-snd.c
>index 8610370af8..b414c75c06 100644
>--- a/hw/virtio/vhost-user-snd.c
>+++ b/hw/virtio/vhost-user-snd.c
>@@ -16,6 +16,18 @@
> #include "standard-headers/linux/virtio_ids.h"
> #include "standard-headers/linux/virtio_snd.h"
>
>+static const VirtIOFeature feature_sizes[] = {
>+    {.flags = 1ULL << VIRTIO_SND_F_CTLS,
>+    .end = endof(struct virtio_snd_config, controls)},
>+    {}
>+};
>+
>+static const VirtIOConfigSizeParams cfg_size_params = {
>+    .min_size = endof(struct virtio_snd_config, chmaps),
>+    .max_size = sizeof(struct virtio_snd_config),
>+    .feature_sizes = feature_sizes
>+};
>+
> static const VMStateDescription vu_snd_vmstate = {
>     .name = "vhost-user-snd",
>     .unmigratable = 1,
>@@ -23,16 +35,20 @@ static const VMStateDescription vu_snd_vmstate = {
>
> static const Property vsnd_properties[] = {
>     DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
>+    DEFINE_PROP_BIT64("controls", VHostUserBase,
>+                      parent_obj.host_features, VIRTIO_SND_F_CTLS, false),
> };
>
> static void vu_snd_base_realize(DeviceState *dev, Error **errp)
> {
>     VHostUserBase *vub = VHOST_USER_BASE(dev);
>     VHostUserBaseClass *vubs = VHOST_USER_BASE_GET_CLASS(dev);
>+    VirtIODevice *vdev = &vub->parent_obj;
>
>     vub->virtio_id = VIRTIO_ID_SOUND;
>     vub->num_vqs = 4;
>-    vub->config_size = sizeof(struct virtio_snd_config);
>+    vub->config_size = virtio_get_config_size(&cfg_size_params,
>+                                              vdev->host_features);
>     vub->vq_size = 64;
>
>     vubs->parent_realize(dev, errp);
>-- 
>2.42.0
>


