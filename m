Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3451CFB442
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 07:04:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxhmf-0003no-Oy; Mon, 07 Oct 2024 03:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1sxhme-0003lh-Hp
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 03:03:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1sxhmc-0002bP-Gw
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 03:03:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728284633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4DWUWe2YTF9Mp7s2Rzy7goI6TLzA8F86EqqfYBapLc8=;
 b=WlrAdeB6kWyg/hI8rb+fyjPfp3SP2omZwbupa+TXnEZAry8wbWE+CnwX1WYZ9CY8ltlewU
 8f6IdVOpoiHp4qjofOkqAAD5X+wJuRsZUjo9aQeT5Ylu3IIUJhuxzRGd/axX5AkvKvdkDY
 wNdKnJvjepVpzcpRFIcE++DKmrpA0hw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-4qElVt2SPs2kif0O5pzB-A-1; Mon, 07 Oct 2024 03:03:50 -0400
X-MC-Unique: 4qElVt2SPs2kif0O5pzB-A-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7ac8f684cdaso829686385a.3
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 00:03:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728284630; x=1728889430;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4DWUWe2YTF9Mp7s2Rzy7goI6TLzA8F86EqqfYBapLc8=;
 b=ombn9PMPqYJ4hvlDsmWBWorRr1PqQuvZisA654EN3VPFc1K4EGfcmUfgKqUXs3AaR4
 qAKWcEjyn2giKeQbdG7hi4wqAHJzQ6lsYpIZq3PmTi687XCjpE9Tukxt0n7NJHR5OF0L
 pBD24cLftLbv8Ow4FS6KCaT1JQxgo2C6/4B9xzEZJZSt8Cc+dSkVlbNJy2tT+V2ewtLe
 U37SW+MAKTJ5a/LYG0k0rkKAD9oWbruUACkgQCcIZX+NoyU+fYlhyNja9eZo3UxOeMJA
 GsnEkmXxXm+Y76RL4D7unlOB9dnqVgz9wYat69ymgHuoHpk+O5tts00o8hJoEQfm8Adx
 W6rg==
X-Gm-Message-State: AOJu0YxFET+zLbojbjaofqqyWRVzdLpGiRsduGljOLHZ0+MAyzvhkUet
 hADIq0NE1yknfAZF4gjdYFFkpStD6h6V9KVmesZGIsxZ05PNaTR2+8JwSOMO54TxIhT6xg1i6bj
 07jAqlIO2ybpunuL7dYqZPhyQLjw5KvHghmMS8rMhiyngitQKqlT1U4NzUAMHb3WRWGJ3+9vUR2
 edm2L0HrNB2xeslIRPyg2cvnr0AR8=
X-Received: by 2002:a05:620a:454a:b0:7ac:a6f9:297e with SMTP id
 af79cd13be357-7ae6f488680mr1736555685a.45.1728284630320; 
 Mon, 07 Oct 2024 00:03:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHI1VFhmIcK0+x+X04Q6UJTyCLNZAXRK7T97HTj32h2kiHAs/sTTYEApHVGw108i38OBlN0ZWoOJwVfzYWQs4E=
X-Received: by 2002:a05:620a:454a:b0:7ac:a6f9:297e with SMTP id
 af79cd13be357-7ae6f488680mr1736554085a.45.1728284629989; Mon, 07 Oct 2024
 00:03:49 -0700 (PDT)
MIME-Version: 1.0
References: <20241007070013.3350752-1-dbassey@redhat.com>
In-Reply-To: <20241007070013.3350752-1-dbassey@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 7 Oct 2024 11:03:38 +0400
Message-ID: <CAMxuvazp3CZRLzWLV-RggiWQkhmFt3_MRXs7cRNVTwNoMOGWCA@mail.gmail.com>
Subject: Re: [PATCH v2] virtio-gpu: Add definition for resource_uuid feature
To: Dorinda Bassey <dbassey@redhat.com>
Cc: qemu-devel@nongnu.org, mhrica@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi

On Mon, Oct 7, 2024 at 11:00=E2=80=AFAM Dorinda Bassey <dbassey@redhat.com>=
 wrote:
>
> Add the VIRTIO_GPU_F_RESOURCE_UUID feature to enable the assignment
> of resources UUIDs for export to other virtio devices.
>
> Signed-off-by: Dorinda Bassey <dbassey@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/display/vhost-user-gpu.c    | 4 ++++
>  hw/display/virtio-gpu-base.c   | 3 +++
>  include/hw/virtio/virtio-gpu.h | 3 +++
>  3 files changed, 10 insertions(+)
>
> diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
> index 14548f1a57..aa6c6416fa 100644
> --- a/hw/display/vhost-user-gpu.c
> +++ b/hw/display/vhost-user-gpu.c
> @@ -631,6 +631,10 @@ vhost_user_gpu_device_realize(DeviceState *qdev, Err=
or **errp)
>          error_report("EDID requested but the backend doesn't support it.=
");
>          g->parent_obj.conf.flags &=3D ~(1 << VIRTIO_GPU_FLAG_EDID_ENABLE=
D);
>      }
> +    if (virtio_has_feature(g->vhost->dev.features,
> +        VIRTIO_GPU_F_RESOURCE_UUID)) {
> +        g->parent_obj.conf.flags |=3D 1 << VIRTIO_GPU_FLAG_RESOURCE_UUID=
_ENABLED;
> +    }
>
>      if (!virtio_gpu_base_device_realize(qdev, NULL, NULL, errp)) {
>          return;
> diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
> index 4fc7ef8896..7827536ac4 100644
> --- a/hw/display/virtio-gpu-base.c
> +++ b/hw/display/virtio-gpu-base.c
> @@ -235,6 +235,9 @@ virtio_gpu_base_get_features(VirtIODevice *vdev, uint=
64_t features,
>      if (virtio_gpu_context_init_enabled(g->conf)) {
>          features |=3D (1 << VIRTIO_GPU_F_CONTEXT_INIT);
>      }
> +    if (virtio_gpu_resource_uuid_enabled(g->conf)) {
> +        features |=3D (1 << VIRTIO_GPU_F_RESOURCE_UUID);
> +    }
>
>      return features;
>  }
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gp=
u.h
> index 7a59379f5a..f12869376c 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -99,6 +99,7 @@ enum virtio_gpu_base_conf_flags {
>      VIRTIO_GPU_FLAG_BLOB_ENABLED,
>      VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED,
>      VIRTIO_GPU_FLAG_RUTABAGA_ENABLED,
> +    VIRTIO_GPU_FLAG_RESOURCE_UUID_ENABLED,
>  };
>
>  #define virtio_gpu_virgl_enabled(_cfg) \
> @@ -115,6 +116,8 @@ enum virtio_gpu_base_conf_flags {
>      (_cfg.flags & (1 << VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED))
>  #define virtio_gpu_rutabaga_enabled(_cfg) \
>      (_cfg.flags & (1 << VIRTIO_GPU_FLAG_RUTABAGA_ENABLED))
> +#define virtio_gpu_resource_uuid_enabled(_cfg) \
> +    (_cfg.flags & (1 << VIRTIO_GPU_FLAG_RESOURCE_UUID_ENABLED))
>  #define virtio_gpu_hostmem_enabled(_cfg) \
>      (_cfg.hostmem > 0)
>
> --
> 2.46.1
>


