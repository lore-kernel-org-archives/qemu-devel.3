Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D30C54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 05:34:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhjus-0000BG-Na; Wed, 06 Mar 2024 00:34:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rhjuj-0000Ag-FR
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 00:34:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rhjuh-0001Oc-PQ
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 00:34:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709703238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+jRY4LIfjrPdAXEdTkFyXRjOdZ0+3Sq/cJmK6iyjR/o=;
 b=aJcl3bcDRiCMWLG/ibVh0sqTtPTkPW+ZJ8GnNck7HoBtPxTUyFMCVmsLHYBxeYcu1ShkQ0
 mS/qcoXYDZdRgmsBmQyKLnHxg5H5O0S0erD3Y40ZJ7wBxNSy93+S5hEXjrBUI2mF/m80SP
 +9nu6saDowsRj79zf1kZcC5EWy8wRnQ=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-Rbq4cMwHMeGyFpAsUgXPjg-1; Wed, 06 Mar 2024 00:33:57 -0500
X-MC-Unique: Rbq4cMwHMeGyFpAsUgXPjg-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-5cfc2041cdfso5179069a12.2
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 21:33:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709703236; x=1710308036;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+jRY4LIfjrPdAXEdTkFyXRjOdZ0+3Sq/cJmK6iyjR/o=;
 b=ng7gauovuBlQoXpxBS+Sj17ntjLHtv0d2OWxD72OHocJbWGwuqnYInwMRAoaLkLpVb
 d2V5gcYgPS9N5MOm9xQxsMeKEQZRsW/pFlLyQURSCHrqM5RSZ2Aw/xQal7/bNglWWr/7
 l19J3hKp2ZJjTidxbRPXl76g7JQ1G6Mdw5Yo6DwTqSZmke9ZnRuaaFqmXLcvThJDj1wg
 Q3bTdzLvYXkI91LtVANFUwm2IKtLQt+c+Rfn9fZ15wguq9OqhwEJjewKEsJL+vxHlwax
 q+qxFh6jyj2dLrujg4RwRsMarXnMu+fCn6A2fhay2N3zItma3/X0CILZ27mYsek+0yPA
 vq2w==
X-Gm-Message-State: AOJu0YzNEI6e5goDCoI4qSVbIPS/2PKvupraeOmwBLGDHIfki7yaG/XH
 HoEL6CEj6aqTD5ieYTcK9QCpxSlU3wNCrHpGjvKsCWpGtgPMoJy2BXEfK/r2GMFMcWhllRiBOwU
 b21GTWnpSAnJ9m0X6i6LT5Cg9IXgI0u/4fmZQ11hYTn2mfL1kLH03v20gayhvM+QNioWe3VojkX
 EOGGpiyKT6x4KPTQqJB5Dr/mHfPhU=
X-Received: by 2002:a05:6a20:9381:b0:1a1:4d8b:73ce with SMTP id
 x1-20020a056a20938100b001a14d8b73cemr4088536pzh.18.1709703236264; 
 Tue, 05 Mar 2024 21:33:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFc9YubHmxLH2HgvNsaW29Pgi7ZOeVeII/wN72253bi/8jTx93xeFrQDmOaVi8CGLMc8Qkt7RZCXSHTxCZaNU4=
X-Received: by 2002:a05:6a20:9381:b0:1a1:4d8b:73ce with SMTP id
 x1-20020a056a20938100b001a14d8b73cemr4088513pzh.18.1709703235945; Tue, 05 Mar
 2024 21:33:55 -0800 (PST)
MIME-Version: 1.0
References: <20240304194612.611660-1-jonah.palmer@oracle.com>
In-Reply-To: <20240304194612.611660-1-jonah.palmer@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 6 Mar 2024 13:33:44 +0800
Message-ID: <CACGkMEtoA3SN9e9WnNpFyR32rkf_pWUNj-6uj2TZBzjB0E+3SQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/8] virtio,
 vhost: Add VIRTIO_F_NOTIFICATION_DATA support
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, eperezma@redhat.com, 
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com, raphael@enfabrica.net, 
 kwolf@redhat.com, hreitz@redhat.com, pasic@linux.ibm.com, 
 borntraeger@linux.ibm.com, farman@linux.ibm.com, thuth@redhat.com, 
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com, 
 cohuck@redhat.com, pbonzini@redhat.com, fam@euphon.net, stefanha@redhat.com, 
 qemu-block@nongnu.org, qemu-s390x@nongnu.org, virtio-fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Mar 5, 2024 at 3:46=E2=80=AFAM Jonah Palmer <jonah.palmer@oracle.co=
m> wrote:
>
> The goal of these patches are to add support to a variety of virtio and
> vhost devices for the VIRTIO_F_NOTIFICATION_DATA transport feature. This
> feature indicates that a driver will pass extra data (instead of just a
> virtqueue's index) when notifying the corresponding device.
>
> The data passed in by the driver when this feature is enabled varies in
> format depending on if the device is using a split or packed virtqueue
> layout:
>
>  Split VQ
>   - Upper 16 bits: shadow_avail_idx
>   - Lower 16 bits: virtqueue index
>
>  Packed VQ
>   - Upper 16 bits: 1-bit wrap counter & 15-bit shadow_avail_idx
>   - Lower 16 bits: virtqueue index
>
> Also, due to the limitations of ioeventfd not being able to carry the
> extra provided by the driver, ioeventfd is left disabled for any devices
> using this feature.

Is there any method to overcome this? This might help for vhost.

Thanks

>
> A significant aspect of this effort has been to maintain compatibility
> across different backends. As such, the feature is offered by backend
> devices only when supported, with fallback mechanisms where backend
> support is absent.
>
> Jonah Palmer (8):
>   virtio/virtio-pci: Handle extra notification data
>   virtio-pci: Lock ioeventfd state with VIRTIO_F_NOTIFICATION_DATA
>   virtio-mmio: Handle extra notification data
>   virtio-mmio: Lock ioeventfd state with VIRTIO_F_NOTIFICATION_DATA
>   virtio-ccw: Handle extra notification data
>   virtio-ccw: Lock ioeventfd state with VIRTIO_F_NOTIFICATION_DATA
>   vhost/vhost-user: Add VIRTIO_F_NOTIFICATION_DATA to vhost feature bits
>   virtio: Add VIRTIO_F_NOTIFICATION_DATA property definition
>
>  hw/block/vhost-user-blk.c    |  1 +
>  hw/net/vhost_net.c           |  2 ++
>  hw/s390x/s390-virtio-ccw.c   | 16 ++++++++++++----
>  hw/s390x/virtio-ccw.c        |  6 ++++--
>  hw/scsi/vhost-scsi.c         |  1 +
>  hw/scsi/vhost-user-scsi.c    |  1 +
>  hw/virtio/vhost-user-fs.c    |  2 +-
>  hw/virtio/vhost-user-vsock.c |  1 +
>  hw/virtio/virtio-mmio.c      | 15 +++++++++++----
>  hw/virtio/virtio-pci.c       | 16 +++++++++++-----
>  hw/virtio/virtio.c           | 18 ++++++++++++++++++
>  include/hw/virtio/virtio.h   |  5 ++++-
>  net/vhost-vdpa.c             |  1 +
>  13 files changed, 68 insertions(+), 17 deletions(-)
>
> --
> 2.39.3
>


