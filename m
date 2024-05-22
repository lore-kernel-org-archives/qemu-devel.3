Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2038C25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 15:45:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9o9G-0003QE-1Y; Wed, 22 May 2024 11:45:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1s9o9E-0003Pa-Eu
 for qemu-devel@nongnu.org; Wed, 22 May 2024 11:45:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1s9o99-0000P1-9l
 for qemu-devel@nongnu.org; Wed, 22 May 2024 11:45:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716392694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6P5g06foTQHjIehNHQM0fLSeQ/78hvsOX+fFXtL4ybc=;
 b=IEH8OyVo+txVFVwkVM06ZmvLahSWYtbcxFVdJdGo46/PDXyYNauV3fyk+lgPVU9BRDgmr+
 duri9AsKMUTVb6WQbsAFNSXKouFtayH2ezTxpRO/TMjhfE1QA2ro+T4njU4QN4sVFgAgrE
 lqyaOZVdJ7//Yd2JAEjbJSX+W3WfXuw=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-tCJqPfS1Pv-xbcVaFwyeJA-1; Wed, 22 May 2024 11:44:52 -0400
X-MC-Unique: tCJqPfS1Pv-xbcVaFwyeJA-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-627e7734a29so13925147b3.1
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 08:44:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716392691; x=1716997491;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6P5g06foTQHjIehNHQM0fLSeQ/78hvsOX+fFXtL4ybc=;
 b=SWJhZrjGpok5oOud2AWxTPYTasYKAYD60dKhf7oGGrICBFi5ybQACD7GtPoYkz8P31
 j4zkqZyt22cONT/AqlvZk68oK/W6UqHTaY7pq973RG1gX/wsWfM8adUaFkv4eOoNNt80
 BT6Gke8j3nsbdPrZjZp4EdE/zBwngiOUANgr275ENMBvIh76+/l0+Qb+RZYnRNhpxGg1
 Ssu6bsWLpcsCo0okT8jdHAnkCS0Aexe2IynVtJKfpBShgo/4DgU5wAwJ16QaNJryPHhS
 G4qw84dilyI0GKOhvFoFqRQ/6J560HpJpfgkwtSkqhZNvy7jrwsppeFUZPKtilafNvw1
 aI/w==
X-Gm-Message-State: AOJu0Yz/dWsddnaGPifyXhc/B/l8eTKp87EeY47fmAujfTGmi5DmO4Uh
 HyWIjCiZ7SUSJAUDkMPaj+NBLfnEZfjKY0T2wKVQLrBq/FKQuCKyNvuKXFde0SVDcfRRGNs1vbs
 nwejFiPbRVtkxPnl8s2kHGu4qLHtUsADrDZKc5IIZh4S4Zwk/uOTlo4E0GVDfaWvnNKzj8ztVls
 uIHoz2TobH/B4abjNh+aDVyxfzYdU=
X-Received: by 2002:a25:6843:0:b0:dc7:4806:4fb with SMTP id
 3f1490d57ef6-df4e0a76659mr2797627276.8.1716392691647; 
 Wed, 22 May 2024 08:44:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbMedPNBn/CdrAhJfvuumyMZqeSpkXqnuyBvbq0qsNWe5w6TS655ubpXFTN0aChcHkZySoGR8+1cN2s45uJD4=
X-Received: by 2002:a25:6843:0:b0:dc7:4806:4fb with SMTP id
 3f1490d57ef6-df4e0a76659mr2797597276.8.1716392691341; Wed, 22 May 2024
 08:44:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240520130048.1483177-1-jonah.palmer@oracle.com>
 <20240520130048.1483177-2-jonah.palmer@oracle.com>
In-Reply-To: <20240520130048.1483177-2-jonah.palmer@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 22 May 2024 17:44:14 +0200
Message-ID: <CAJaqyWcTh9YPMyitxoOZTxTjKishHCcNSz8wm1B2FRG4YdYGFg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] virtio: Add bool to VirtQueueElement
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, raphael@enfabrica.net, 
 kwolf@redhat.com, hreitz@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, 
 fam@euphon.net, stefanha@redhat.com, qemu-block@nongnu.org, 
 schalla@marvell.com, leiyang@redhat.com, virtio-fs@lists.linux.dev, 
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
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

On Mon, May 20, 2024 at 3:01=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.c=
om> wrote:
>
> Add the boolean 'in_order_filled' member to the VirtQueueElement structur=
e.
> The use of this boolean will signify whether the element has been process=
ed
> and is ready to be flushed (so long as the element is in-order). This
> boolean is used to support the VIRTIO_F_IN_ORDER feature.
>
> Tested-by: Lei Yang <leiyang@redhat.com>

The code has changed from the version that Lei tested, so we should
drop this tag until he re-test again.

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> ---
>  include/hw/virtio/virtio.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 7d5ffdc145..88e70c1ae1 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -69,6 +69,8 @@ typedef struct VirtQueueElement
>      unsigned int ndescs;
>      unsigned int out_num;
>      unsigned int in_num;
> +    /* Element has been processed (VIRTIO_F_IN_ORDER) */
> +    bool in_order_filled;
>      hwaddr *in_addr;
>      hwaddr *out_addr;
>      struct iovec *in_sg;
> --
> 2.39.3
>


