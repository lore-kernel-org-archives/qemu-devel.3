Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06279C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 08:07:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhPou-0007rd-TV; Tue, 05 Mar 2024 03:06:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rhPoU-0007nG-5c
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 03:06:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rhPoS-00032u-HY
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 03:06:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709625971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cRRPoViki63qm7Pnqx/HO7LHcA0o0KblBv1fRsjeFSY=;
 b=CZEKNcyVD8+K4osab8VFQL5C/gV60DhU8Lt0rpBkJEg6gLAMG5ETi+NVHZvtJ3bHF5FEhc
 KUKdGIFjcnNGj7EJpTzgPJSn4hAgRJeLNhgOcrzOkiTwgft3P2QmcjsicmgGZvqPEJFNvy
 OA/0A9GnWOLbmmjfmkE7umix6tdgRac=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-aF37goZnNFS0xJJ27MK7gQ-1; Tue, 05 Mar 2024 03:06:10 -0500
X-MC-Unique: aF37goZnNFS0xJJ27MK7gQ-1
Received: by mail-yb1-f200.google.com with SMTP id
 3f1490d57ef6-dc64f63d768so701006276.2
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 00:06:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709625970; x=1710230770;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cRRPoViki63qm7Pnqx/HO7LHcA0o0KblBv1fRsjeFSY=;
 b=EnaThc87/sqCee2Z6Phuh1fzUD7saPqTXZAv79i2SVkmHhqs7uxrjf/HOm3fd+Km9S
 hfWSXm/WLp8nOfG6RbaNoWQZKBhK8SfxakqQtOO99PTKxOEKNTwOzyxPqQlBcSwes429
 Y+H/zMVZcVhffOCxWyK2e+wAX3XUQp+kdaZdSn7bznoYGPcN/BToQ7FyVTNsYAtBtVgZ
 F4H28TEpQsb0fbM7JcDUVs56frlXWs6cMggMah1aQNaiE34v+IHOLKK540we6qIa9H2l
 vXtsrNNrEFd6Zed+3khDTVAWciA3/EKtMgHeF1ox3klomUBn6cfkqBnn/hYmMohnETI3
 YIWg==
X-Gm-Message-State: AOJu0YyJ5E3AAiBmzaoEB7LqS7aPJxuls5EaVTUXuYQTdJ4UMiWt9Azn
 08J4/JN1/iUMiA8lJRG9bX7Qh8WjQAlyxcwjQ/hVen34Czz7MMIrlFPT63JpVe9h+KuM7ALU5BL
 qr8EA+NuZ5muZ6v78FOwrfhDGsCWVChXcJnxaIy7zcClazNWq2yyQ4SwEFu3Ex5rgIUp1e1PutL
 tfl902GvwoVLz5ron86hooOytd0ho=
X-Received: by 2002:a25:6645:0:b0:dc7:32ea:c89f with SMTP id
 z5-20020a256645000000b00dc732eac89fmr9247225ybm.15.1709625970031; 
 Tue, 05 Mar 2024 00:06:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGugrxHL2sIY5QLA6tQbPvVtgO/26HzPW3QY1YMP/uardUs/mAkNQfpvfGghjGyh34jCCAxPtV7w7chgeiZbXs=
X-Received: by 2002:a25:6645:0:b0:dc7:32ea:c89f with SMTP id
 z5-20020a256645000000b00dc732eac89fmr9247216ybm.15.1709625969819; Tue, 05 Mar
 2024 00:06:09 -0800 (PST)
MIME-Version: 1.0
References: <20240304194612.611660-1-jonah.palmer@oracle.com>
 <20240304194612.611660-5-jonah.palmer@oracle.com>
In-Reply-To: <20240304194612.611660-5-jonah.palmer@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 5 Mar 2024 09:05:33 +0100
Message-ID: <CAJaqyWeFKL-UaQvtURxVw3FHtBcvL-hsB081rWf=FWa_yqtfgA@mail.gmail.com>
Subject: Re: [PATCH v1 4/8] virtio-mmio: Lock ioeventfd state with
 VIRTIO_F_NOTIFICATION_DATA
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, jasowang@redhat.com, 
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com, raphael@enfabrica.net, 
 kwolf@redhat.com, hreitz@redhat.com, pasic@linux.ibm.com, 
 borntraeger@linux.ibm.com, farman@linux.ibm.com, thuth@redhat.com, 
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com, 
 cohuck@redhat.com, pbonzini@redhat.com, fam@euphon.net, stefanha@redhat.com, 
 qemu-block@nongnu.org, qemu-s390x@nongnu.org, virtio-fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, Mar 4, 2024 at 8:46=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.co=
m> wrote:
>
> Prevent ioeventfd from being enabled/disabled when a virtio-mmio device
> has negotiated the VIRTIO_F_NOTIFICATION_DATA transport feature.
>
> Due to ioeventfd not being able to carry the extra data associated with
> this feature, the ioeventfd should be left in a disabled state for
> emulated virtio-mmio devices using this feature.
>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> ---
>  hw/virtio/virtio-mmio.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
> index f99d5851a2..f42ed5c512 100644
> --- a/hw/virtio/virtio-mmio.c
> +++ b/hw/virtio/virtio-mmio.c
> @@ -421,7 +421,8 @@ static void virtio_mmio_write(void *opaque, hwaddr of=
fset, uint64_t value,
>          virtio_update_irq(vdev);
>          break;
>      case VIRTIO_MMIO_STATUS:
> -        if (!(value & VIRTIO_CONFIG_S_DRIVER_OK)) {
> +        if (!(value & VIRTIO_CONFIG_S_DRIVER_OK) &&
> +            !virtio_vdev_has_feature(vdev, VIRTIO_F_NOTIFICATION_DATA)) =
{
>              virtio_mmio_stop_ioeventfd(proxy);
>          }
>
> @@ -433,7 +434,8 @@ static void virtio_mmio_write(void *opaque, hwaddr of=
fset, uint64_t value,
>
>          virtio_set_status(vdev, value & 0xff);
>
> -        if (value & VIRTIO_CONFIG_S_DRIVER_OK) {
> +        if ((value & VIRTIO_CONFIG_S_DRIVER_OK) &&
> +            !virtio_vdev_has_feature(vdev, VIRTIO_F_NOTIFICATION_DATA)) =
{
>              virtio_mmio_start_ioeventfd(proxy);
>          }
>
> --
> 2.39.3
>


