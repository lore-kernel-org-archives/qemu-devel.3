Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32850C5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 19:45:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg8oV-0001jV-Bq; Fri, 01 Mar 2024 14:44:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rg8oQ-0001iX-Ec
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 14:44:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rg8oN-0004Je-Tf
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 14:44:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709322291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lf2UEL+cQJVaADNBAhNdeM2N2bKFN/niMKZZQVDvnhU=;
 b=fwl2sIsggbOpJ5hwkF8THknPp6Q6m/XxbFEJ477AUZHapm14PghbtYR2a+UP7A/59L8rdb
 TEm7UnTe8SyLp8v6FPQxMZeSwzT4DEBToqx6PTma9xTIZofs55HzmJhURvDraaN1460Yys
 qmnb9YM9z1soGRRNq8cNqJ/yMKtfqQ4=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-rrSBhJYWPmGL0S8uD5EGNw-1; Fri, 01 Mar 2024 14:44:49 -0500
X-MC-Unique: rrSBhJYWPmGL0S8uD5EGNw-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-dbe9e13775aso4200739276.1
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 11:44:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709322289; x=1709927089;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lf2UEL+cQJVaADNBAhNdeM2N2bKFN/niMKZZQVDvnhU=;
 b=PBYc5t8zYYIlOtUZLnbKGDMUheQctSVe0HBVs9/jzK6chu94CJpTwoJmzOonDmFB2r
 CUUZwm3yo0K1KgHZc4SrX25ROg2x7SHyXIumtcJZ45XtUOpH27DSTzcg3rEqtrTY1asV
 oh3qt1WjuTQJhTiOvSQwV3DAhSn5PBtTkSx+5tcBzAfkMoak22ULd3fiCPVElVaA2smq
 wewqPI+w+TpHrJeb7TKGRb+8Xtk0uCiklpfejgiGi8iBcXDKLlJ+Y+kxTdYWcmDc3QEc
 JZZ3ZE+Vu0PtNFBi/UcvpalyyQ6a9hveL6PRO2hvplWhAJaWvWt0tLgPL6un5aNVPnma
 8VSg==
X-Gm-Message-State: AOJu0YyS2MEfLc5vk48rL84VVJ4lTAmN5r4c8pLh4652sg3jCfvYMkv7
 iSGiCjHU1MF9FZQE/IasXICJCWUDHYW8mc7JZ3Cet1nofrL28gxK/+fwF3Ez4pjPmZtKQnY/cqf
 +UVblC5lJkERLBtojUB6KjSlrjzHzd4igFdEXeSSAn3g9pAD9S4CNSNC5vn4CuCeSDXnx39jvWG
 uKVbVUOK+lSG/JgvEn7mWtm8EUD/1qYm40mNJwVg==
X-Received: by 2002:a05:6902:218f:b0:dc7:4367:2527 with SMTP id
 dl15-20020a056902218f00b00dc743672527mr2997529ybb.49.1709322288860; 
 Fri, 01 Mar 2024 11:44:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjm65dBSSOlNwC1BtrHh8qaNA3M8Enj9DzCv1Fr4qh7klO6+qedckFBQJXH5Kctw5k6GV0jj7LvdNbWRKQEaQ=
X-Received: by 2002:a05:6902:218f:b0:dc7:4367:2527 with SMTP id
 dl15-20020a056902218f00b00dc743672527mr2997498ybb.49.1709322288610; Fri, 01
 Mar 2024 11:44:48 -0800 (PST)
MIME-Version: 1.0
References: <20240301134330.4191007-1-jonah.palmer@oracle.com>
 <20240301134330.4191007-3-jonah.palmer@oracle.com>
In-Reply-To: <20240301134330.4191007-3-jonah.palmer@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 1 Mar 2024 20:44:12 +0100
Message-ID: <CAJaqyWfzobbNeUOR0LvpZ=Er1ShVN8vcZAr6Vm4gU+dth5v4cw@mail.gmail.com>
Subject: Re: [RFC 2/8] virtio-pci: Lock ioeventfd state with
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
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

On Fri, Mar 1, 2024 at 2:44=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.co=
m> wrote:
>
> Prevent ioeventfd from being enabled/disabled when a virtio-pci
> device has negotiated the VIRTIO_F_NOTIFICATION_DATA transport
> feature.
>
> Due to ioeventfd not being able to carry the extra data associated with
> this feature, the ioeventfd should be left in a disabled state for
> emulated virtio-pci devices using this feature.
>
> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> ---
>  hw/virtio/virtio-pci.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index c7c577b177..fd9717a0f5 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -420,13 +420,15 @@ static void virtio_ioport_write(void *opaque, uint3=
2_t addr, uint32_t val)
>          }
>          break;
>      case VIRTIO_PCI_STATUS:
> -        if (!(val & VIRTIO_CONFIG_S_DRIVER_OK)) {
> +        if (!(val & VIRTIO_CONFIG_S_DRIVER_OK) &&
> +            !virtio_vdev_has_feature(vdev, VIRTIO_F_NOTIFICATION_DATA)) =
{
>              virtio_pci_stop_ioeventfd(proxy);
>          }
>
>          virtio_set_status(vdev, val & 0xFF);
>
> -        if (val & VIRTIO_CONFIG_S_DRIVER_OK) {
> +        if ((val & VIRTIO_CONFIG_S_DRIVER_OK) &&
> +            !virtio_vdev_has_feature(vdev, VIRTIO_F_NOTIFICATION_DATA)) =
{
>              virtio_pci_start_ioeventfd(proxy);
>          }
>
> --
> 2.39.3
>


