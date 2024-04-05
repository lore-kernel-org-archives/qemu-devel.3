Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D33C67861
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 15:25:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rslR7-00051r-2O; Fri, 05 Apr 2024 11:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rslR4-00051R-Ra
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 11:24:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rslR3-0002rL-3u
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 11:24:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712330695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JtHGJ3p0GKheIynKACbBE2sgdsuAWnvHJ2ixWlwEV5o=;
 b=Te1Dne6vJdvpWCC8VgLdIUefkxEAP6TRdDzBPffmzYpesfqY1BAS+8S2P3qCteQnUpTnQy
 WogF+w0+whvNGvKB9Guw+ZiMQwAL87CZr0U/AiwUFlEes1DIKn+URO2Dc9Ucdt7YRXaJT5
 /OvabEf9j8wztJdxKSzttnXVww7rNCU=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-SgjQUQDRN7SgD6akmUtyOw-1; Fri, 05 Apr 2024 11:24:54 -0400
X-MC-Unique: SgjQUQDRN7SgD6akmUtyOw-1
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-dc6b26783b4so2866140276.0
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 08:24:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712330694; x=1712935494;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JtHGJ3p0GKheIynKACbBE2sgdsuAWnvHJ2ixWlwEV5o=;
 b=jfMawINjGEvg8An7mcDm9Xh04h0nngrGx9CdWyOm2XUiJneNCvbexV9OxKbm8d6jYv
 sL75SRR7XqwbGBhs7Ewc0ZesqhnlcvWV14D+68UrH7r3ZZAZhSIfhYSSoIRdXldXvw6Y
 diO4mUZycBIawPoWv4kuf+y26f05Ft4GMVOGooolMXLcjsJ4sBmuDRbhcdO8qXq49Uww
 BJks5YPXVki0+/cTXj9wRYq5meonGOUVev5EG3XhL3i3Vr4uiZgrSKpali5iSqj7biwS
 rVdzHhVyGLBYbXSXo0posbZZJeM6khV6zaz5XfwHGk6pqgm29sKs3rg6Cl8b99750vVs
 axaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8+DRlpeviP8kB6lyFvM//P1R0AmgqRhcGMWf1OageOcKeESp0IWLU2omguktYStarpGw9f30Cypc+UWWEYDodBR4SBzw=
X-Gm-Message-State: AOJu0Yy0NrNcgTJmgLIJgd7GBrwvcAGNKGyYUuhFP9Mz6kVZ0FnxglrX
 P5z1NDf8KHT3SQlDMdo1NPYRJP4moDfeHIg8c+EZA2/ErgIPBt9ntIeHF2tFqEk/AmQW/zO1kvE
 nK3EPHsCyayj660Bb1oQIfcLldZd4oZFZnVip+keho1vghDH3bcnn9DPgCLFaTmpQtZuTKZcHto
 wB9cIkRxqfgZooKQuaLYpBjgvI2l0=
X-Received: by 2002:a5b:ccd:0:b0:dca:c369:fac8 with SMTP id
 e13-20020a5b0ccd000000b00dcac369fac8mr1468164ybr.1.1712330693970; 
 Fri, 05 Apr 2024 08:24:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkbfLtQBnmxfeRdpoe6mkR3mx8fU0PDFTHdjtkHYd3aCJOdZrYV+5wR9QNySeLDEtlHexXvP1PcqlFVE9JGII=
X-Received: by 2002:a5b:ccd:0:b0:dca:c369:fac8 with SMTP id
 e13-20020a5b0ccd000000b00dcac369fac8mr1468150ybr.1.1712330693727; Fri, 05 Apr
 2024 08:24:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240405131945.6091-2-wafer@jaguarmicro.com>
In-Reply-To: <20240405131945.6091-2-wafer@jaguarmicro.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 5 Apr 2024 17:24:17 +0200
Message-ID: <CAJaqyWf=ddghri0cBE3G9SU1GpWdisVGmDwUFNhqgW3dmt_+8Q@mail.gmail.com>
Subject: Re: [PATCH v3] hw/virtio: Fix packed virtqueue flush used_idx
To: Wafer <wafer@jaguarmicro.com>
Cc: mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, 
 jonah.palmer@oracle.com, leiyang@redhat.com, angus.chen@jaguarmicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Apr 5, 2024 at 3:20=E2=80=AFPM Wafer <wafer@jaguarmicro.com> wrote:
>
> If a virtio-net device has the VIRTIO_NET_F_MRG_RXBUF feature
> but not the VIRTIO_RING_F_INDIRECT_DESC feature,
> 'VirtIONetQueue->rx_vq' will use the merge feature
> to store data in multiple 'elems'.
> The 'num_buffers' in the virtio header indicates how many elements are me=
rged.
> If the value of 'num_buffers' is greater than 1,
> all the merged elements will be filled into the descriptor ring.
> The 'idx' of the elements should be the value of 'vq->used_idx' plus 'nde=
scs'.
>
> Fixes: 86044b24e8 ("virtio: basic packed virtqueue support")

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Signed-off-by: Wafer <wafer@jaguarmicro.com>
>
> ---
> Changes in v3:
>   - Add the commit-ID of the introduced problem in commit message;
>
> Changes in v2:
>   - Clarify more in commit message;
> ---
>  hw/virtio/virtio.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index fb6b4ccd83..cab5832cac 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -957,12 +957,20 @@ static void virtqueue_packed_flush(VirtQueue *vq, u=
nsigned int count)
>          return;
>      }
>
> +    /*
> +     * For indirect element's 'ndescs' is 1.
> +     * For all other elemment's 'ndescs' is the
> +     * number of descriptors chained by NEXT (as set in virtqueue_packed=
_pop).
> +     * So When the 'elem' be filled into the descriptor ring,
> +     * The 'idx' of this 'elem' shall be
> +     * the value of 'vq->used_idx' plus the 'ndescs'.
> +     */
> +    ndescs +=3D vq->used_elems[0].ndescs;
>      for (i =3D 1; i < count; i++) {
> -        virtqueue_packed_fill_desc(vq, &vq->used_elems[i], i, false);
> +        virtqueue_packed_fill_desc(vq, &vq->used_elems[i], ndescs, false=
);
>          ndescs +=3D vq->used_elems[i].ndescs;
>      }
>      virtqueue_packed_fill_desc(vq, &vq->used_elems[0], 0, true);
> -    ndescs +=3D vq->used_elems[0].ndescs;
>
>      vq->inuse -=3D ndescs;
>      vq->used_idx +=3D ndescs;
> --
> 2.27.0
>


