Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF975C3A59D
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Apr 2024 03:46:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtJTx-00055D-QA; Sat, 06 Apr 2024 23:46:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rtJTv-00053B-Nd
 for qemu-devel@nongnu.org; Sat, 06 Apr 2024 23:46:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rtJTr-0005aF-SQ
 for qemu-devel@nongnu.org; Sat, 06 Apr 2024 23:46:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712461566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WBAtgek/kpXAQ2XAzw062SeRhy9qBHkxOVAzEid8cqY=;
 b=HlLmKy/m+X8BnyyHWpbir1PaZQ29g1rag+ljWZR8hLdV921XR2Ioa9WcmyuCXrBYSe+h3L
 MAKjpNxxwxw2cBc6bBPXRsypdsdjQNi+eiCbt5ZX8byVfWGQnVcpEeCurXoSuBNS63JjP4
 AbfnbJksh8Tce4BMJJLwbKkB/CD36CE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-jL6Dix_xMLigNLeWBtoq8g-1; Sat, 06 Apr 2024 23:46:04 -0400
X-MC-Unique: jL6Dix_xMLigNLeWBtoq8g-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2a48ed89c7eso1389902a91.3
 for <qemu-devel@nongnu.org>; Sat, 06 Apr 2024 20:46:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712461563; x=1713066363;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WBAtgek/kpXAQ2XAzw062SeRhy9qBHkxOVAzEid8cqY=;
 b=vbThGZq6joY0Cs1hQJt1QazCLPafvH+uz2zvppyLG6oArLJZsU2vEzy+k7NTL5jpy9
 noeU5z69RdhgbvFM3Ee1207lcNXtBed57OrtLX+K2cakogywZyO3kvMP5gcAQciedgkZ
 RlXKY8VDOlfvODXTTgKkj9nIZKamgCz5mkxGPSuVQBGL2aXeq/f6Cnq8BGbJLglghBPj
 10V9Kvr+39tihLKYgonjdWhv4KQIIA1JLhpduS5mF9blSbG/4iwGhqa6aeg2DwXopFIT
 JuDI+2gQsfLOcDAM2hvUk9o3nV7mSBvimooxZlFuS2VYPcG4J+O1C7hTOLzs9vn52E74
 /F4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVu5j5G0qGWTOje00vaQ6Tc6bccBlTHx84emdbyv4pgAwpOmjwP9MAhr9J9tRurAFmRuE5M891vA+MM/F2ih/646fXXX0c=
X-Gm-Message-State: AOJu0Yw/DQVL24JbmphuKuN06E1YdzoFvCzAPw+IwOIDCNqYiyUBL3KD
 YVGbMD/gTHO/Xco0j3uu0QrU6LRep8rR1MgDjHfuYkeQvNJtic+BSRI1VgzVCTsmwsXlkPGndHW
 JK1POKF5hKcZBE5eXxyJsVjLqLmG+zglgOcBzF4NRwNH3kXRtKddsvlyGtkzGoU8GPvuHjCz98H
 lFT9/ILBZ6rfavw/1WmHYNNCMTDHg=
X-Received: by 2002:a05:6a20:3942:b0:1a7:5605:91e1 with SMTP id
 r2-20020a056a20394200b001a7560591e1mr1273869pzg.6.1712461563540; 
 Sat, 06 Apr 2024 20:46:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGxg3QlPdtggipRtnBnpSYFDj/cQzTiz/oSsJKuiEWButl9/hqzt/5p0z/iDW6MSBgqBQUPBauTYpQ1LfQeoE=
X-Received: by 2002:a05:6a20:3942:b0:1a7:5605:91e1 with SMTP id
 r2-20020a056a20394200b001a7560591e1mr1273861pzg.6.1712461563272; Sat, 06 Apr
 2024 20:46:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240407032240.1898-1-yuxue.liu@jaguarmicro.com>
In-Reply-To: <20240407032240.1898-1-yuxue.liu@jaguarmicro.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 7 Apr 2024 11:45:52 +0800
Message-ID: <CACGkMEs6FE7iZJAspCacWs+v4XTs9GsTHNdDVtcqoNfdDF_+3Q@mail.gmail.com>
Subject: Re: [PATCH] vdpa-dev: Fix the issue of device status not updating
 when configuration interruption is triggered
To: lyx634449800 <yuxue.liu@jaguarmicro.com>
Cc: eperezma@redhat.com, sgarzare@redhat.com, mst@redhat.com, 
 qemu-stable@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sun, Apr 7, 2024 at 11:22=E2=80=AFAM lyx634449800 <yuxue.liu@jaguarmicro=
.com> wrote:
>
> The set_config callback function vhost_vdpa_device_get_config in
> vdpa-dev does not fetch the current device status from the hardware
> device, causing the GUEST OS to not receive the latest device status

nit: no need for upper case here.

> information.
>
> The hardware updates the config status of the vdpa device and then
> notifies the OS. The GUEST OS receives an interrupt notification,
> triggering a get_config access in the kernel, which then enters qemu
> internally. Ultimately, the vhost_vdpa_device_get_config function of
> vdpa-dev is called
>
> One scenario encountered is when the device needs to bring down the
> vdpa net device. After modifying the status field of virtio_net_config
> in the hardware, it sends an interrupt notification. However, the guest
> OS always receives the STATUS field as VIRTIO_NET_S_LINK_UP.
>
> Signed-off-by: Yuxue Liu <yuxue.liu@jaguarmicro.com>

This aligns with the vhost-net support for vDPA.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  hw/virtio/vdpa-dev.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
> index 13e87f06f6..64b96b226c 100644
> --- a/hw/virtio/vdpa-dev.c
> +++ b/hw/virtio/vdpa-dev.c
> @@ -195,7 +195,14 @@ static void
>  vhost_vdpa_device_get_config(VirtIODevice *vdev, uint8_t *config)
>  {
>      VhostVdpaDevice *s =3D VHOST_VDPA_DEVICE(vdev);
> +    int ret;
>
> +    ret =3D vhost_dev_get_config(&s->dev, s->config, s->config_size,
> +                            NULL);
> +    if (ret < 0) {
> +        error_report("get device config space failed");
> +        return;
> +    }
>      memcpy(config, s->config, s->config_size);
>  }
>
> --
> 2.43.0
>


