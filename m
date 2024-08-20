Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A4E2C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 10:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgMWm-0004VJ-Mm; Tue, 20 Aug 2024 06:55:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sgMWa-0004SQ-Rt
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 06:55:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sgMWZ-00088C-0j
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 06:55:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724151337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=po7wPHbzpUWxc5y8yxarIOBDiNbyjnslu9VJaZDHJII=;
 b=bXCELUBEJTpIQ/2aN2UyCD+ZJ+Y3iI1RuAxUf4Rs/oS1GHTlgFYWDdSHhP2CNF74Sr+36f
 uQ4IjuRHrn97SfBV5E2k61dWt5RAqV7feHIOmkLp5I2YZsG35ZDJicN+1fbfkQbaVm3HUn
 L3jgha+nu0/L+HWhqSwWh+WTSqJFnek=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-ZjHATTjYMUW9uTIuN5T8eg-1; Tue, 20 Aug 2024 06:55:35 -0400
X-MC-Unique: ZjHATTjYMUW9uTIuN5T8eg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4280645e3e0so43856625e9.1
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 03:55:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724151334; x=1724756134;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=po7wPHbzpUWxc5y8yxarIOBDiNbyjnslu9VJaZDHJII=;
 b=gYQgc7c9EN9gSkETOl0cz7ZJ3/OFfqQbPaU6nCO4x1g3v9ztalztqYr8lxWcBES0Qo
 RC6+YcdgwSlBx2sK7uvlDcGqaJmS2Lh7uH/ta/CJNkk75DaxSFx9uOSr3RhX49w2uJgG
 wxNd49GF83GA0lUuzNaf6T8aOgFWf2bZ5NGsKOOaQ9iZSsFN/I2awgh32MokZZrRzikT
 VKrH/dJoSPF/XnkaZXyLgvMzAezxBaYpBWxuVwWwmy5OM/2Mpze4TPmwF9XAYUPU6HGK
 3v9+nyXZT8Nz+LKbj0egXBQKxiZUyAN3vfc1+ofvNVIotzDLU6no/Eq1bI7PufgWOtpz
 tO/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2Duq8GUGttZuLs8OMwr3VlwIQshyWb4YNgqq3Kb+B15ZvKNMdVSw4mhO+hbLwASAtUp2cHuI2F+LMMveFk9xTFwuSYAA=
X-Gm-Message-State: AOJu0YzlFDoBbWgbMxDSP1rvjnnQ51ei8OnHo+Lgp8mrOgQ1LtBdAV1h
 Ak9wapHHkAXJZdkOf00cbgO5+xT+yM+/VGIJ6PESW35etHk8pn4DOUrIVj16SW29kr5V9ga1orP
 fiNs/s8tm+qO1H6zoGnteLxVwPo9r82gXWUbRT9DVQZecNsVUfgEG
X-Received: by 2002:a05:600c:1553:b0:428:e866:3933 with SMTP id
 5b1f17b1804b1-42ab692ab21mr13235095e9.22.1724151334368; 
 Tue, 20 Aug 2024 03:55:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnk/R2oW8BBa6xiRCxq6lPPXv0rFy907EldKxPoyglaG2WWRZBKQuG4AQ0Uz2kPJLHci3o0g==
X-Received: by 2002:a05:600c:1553:b0:428:e866:3933 with SMTP id
 5b1f17b1804b1-42ab692ab21mr13234805e9.22.1724151333425; 
 Tue, 20 Aug 2024 03:55:33 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f4:a812:cb6d:d20c:bd3b:58cf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429ded35991sm192547035e9.21.2024.08.20.03.55.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2024 03:55:32 -0700 (PDT)
Date: Tue, 20 Aug 2024 06:55:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2] hw/virtio/vdpa-dev: Check returned value instead of
 dereferencing @errp
Message-ID: <20240820065310-mutt-send-email-mst@kernel.org>
References: <20240716162615.271010-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240716162615.271010-1-zhao1.liu@intel.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Jul 17, 2024 at 12:26:15AM +0800, Zhao Liu wrote:
> As the comment in qapi/error, dereferencing @errp requires
> ERRP_GUARD():
> 
> * = Why, when and how to use ERRP_GUARD() =
> *
> * Without ERRP_GUARD(), use of the @errp parameter is restricted:
> * - It must not be dereferenced, because it may be null.
> ...
> * ERRP_GUARD() lifts these restrictions.
> *
> * To use ERRP_GUARD(), add it right at the beginning of the function.
> * @errp can then be used without worrying about the argument being
> * NULL or &error_fatal.
> *
> * Using it when it's not needed is safe, but please avoid cluttering
> * the source with useless code.
> 
> Though vhost_vdpa_device_realize() is called at DeviceClass.realize()
> context and won't get NULL @errp, it's still better to follow the
> requirement to add the ERRP_GUARD().
> 
> But qemu_open() and vhost_vdpa_device_get_u32()'s return values can
> distinguish between successful and unsuccessful calls, so check the
> return values directly without dereferencing @errp, which eliminates
> the need of ERRP_GUARD().
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Acked-by: Eugenio Pérez <eperezma@redhat.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
> v2:
>  * Added a/b from Eugenio.
>  * Deleted unnecessary ERRP_GUARD(). (Eugenio)
> ---
>  hw/virtio/vdpa-dev.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
> index 64b96b226c39..8a1e16fce3de 100644
> --- a/hw/virtio/vdpa-dev.c
> +++ b/hw/virtio/vdpa-dev.c
> @@ -63,19 +63,19 @@ static void vhost_vdpa_device_realize(DeviceState *dev, Error **errp)
>      }
>  
>      v->vhostfd = qemu_open(v->vhostdev, O_RDWR, errp);
> -    if (*errp) {
> +    if (v->vhostfd < 0) {
>          return;
>      }
>  
>      v->vdev_id = vhost_vdpa_device_get_u32(v->vhostfd,
>                                             VHOST_VDPA_GET_DEVICE_ID, errp);
> -    if (*errp) {
> +    if (v->vdev_id < 0) {
>          goto out;
>      }

vdev_id is unsigned, no idea how is this supposed to work.

>  
>      max_queue_size = vhost_vdpa_device_get_u32(v->vhostfd,
>                                                 VHOST_VDPA_GET_VRING_NUM, errp);
> -    if (*errp) {
> +    if (max_queue_size < 0) {
>          goto out;
>      }
>  
max_queue_size is unsigned, too.

> @@ -89,7 +89,7 @@ static void vhost_vdpa_device_realize(DeviceState *dev, Error **errp)
>  
>      v->num_queues = vhost_vdpa_device_get_u32(v->vhostfd,
>                                                VHOST_VDPA_GET_VQS_COUNT, errp);
> -    if (*errp) {
> +    if (v->num_queues < 0) {
>          goto out;
>      }
>  

num_queues is unsigned, too.

> @@ -127,7 +127,7 @@ static void vhost_vdpa_device_realize(DeviceState *dev, Error **errp)
>      v->config_size = vhost_vdpa_device_get_u32(v->vhostfd,
>                                                 VHOST_VDPA_GET_CONFIG_SIZE,
>                                                 errp);
> -    if (*errp) {
> +    if (v->config_size < 0) {
>          goto vhost_cleanup;
>      }
>  
> -- 
> 2.34.1


