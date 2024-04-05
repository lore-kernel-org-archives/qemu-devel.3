Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A780CC67861
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 08:17:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsekm-0002oj-MM; Fri, 05 Apr 2024 04:16:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rsekl-0002oY-3G
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 04:16:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rsekj-0004NM-DX
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 04:16:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712305007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/53fXpDw1T+ksGA+fLR4I1vvWXyr+aIW1EoVSKjjn94=;
 b=A/2l8RLNf99ka2yWDcdymXjKiyjBTVzsd3F6egKgsc9twCVRq+snffisaQCDPoIF1xMRbq
 2wkJoi4oAAxyS60PjWHoUY/rrduc62iiYqBX3lz2ARycFMMRNl523lrXFDtEWWsk4CPkqg
 uKetGO765TN/TuQcgMbyzwvGTsO/nLA=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-9uOMnrUYNEuCfR7hJBmDhA-1; Fri, 05 Apr 2024 04:16:46 -0400
X-MC-Unique: 9uOMnrUYNEuCfR7hJBmDhA-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-dcbfe1a42a4so3247287276.2
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 01:16:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712305005; x=1712909805;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/53fXpDw1T+ksGA+fLR4I1vvWXyr+aIW1EoVSKjjn94=;
 b=MsS8AtlBnbDE3bG+SEI4DYeBGobSwTSE5TEnqNWhY3yyH7hCIEHCSt7yej04BwMDAR
 EMScDXoqN8zaT/90IGpVyp4+DdbJXbn4GaMG9a67V0arurC5VJfN6TV65/NDVozteSXy
 owXHclkch8cdjzDv6bINWqyd34wh25+5rG3vYoWiqEfOa4blDfD7zP1qx4FYp4nNDOcV
 IQ/haqHIz3w65ekzHuTAqh4Qyj1r0vtPMlORQ6JrDEYb0OAha2EXgbc88jq6X3qu6TL5
 oiatfHP3yqi5/jQxt1JMR695yoHz88cgSAe8sgKqwa002YPRQl+fsHaiOm8KMnL8En7W
 VtQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpL4K78dA7XxaEsR2pMZ8zlnr2CRim/HNVUxNfQ6+WMqisryjvALB0SEYQpKLStKP5j/DOCE+Azpyp2zb0prP7AxuU2A0=
X-Gm-Message-State: AOJu0YwShaCn5ab1N95CO/Zhuy/dC9oHL6TFocnArlC0LWmoPwrwGUNF
 WbNrFXskyDP8ol7l7e/dsGQHy2mfBA37q6Yw+Ptm3M/qhIA3Wk2PDp5rGuJZITRaCIft/4aPwHx
 uWH0efGprqY2mM37mv9pT8m3Qu+cTfpuJaFhlv80Zq0H5BN+e3mKRzzrKZlzHMKttOO+pnYCJI7
 ++LZQLmkR0QdRXXDa6c0FXA+u3EaM=
X-Received: by 2002:a25:2fc4:0:b0:ddd:696a:8656 with SMTP id
 v187-20020a252fc4000000b00ddd696a8656mr519307ybv.41.1712305005703; 
 Fri, 05 Apr 2024 01:16:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVYbGOTvY5yF7TF0Ie6pCY1MJ/ejPKFlOIXM/Nb6f+TUG5BJH51QPnt9nl78ku1yi3asoDQRkdX8lD5oGEMZY=
X-Received: by 2002:a25:2fc4:0:b0:ddd:696a:8656 with SMTP id
 v187-20020a252fc4000000b00ddd696a8656mr519295ybv.41.1712305005379; Fri, 05
 Apr 2024 01:16:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240404165706.23338-2-wafer@jaguarmicro.com>
In-Reply-To: <20240404165706.23338-2-wafer@jaguarmicro.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 5 Apr 2024 10:16:09 +0200
Message-ID: <CAJaqyWeVvCfamVpYK_Z76Wae1T3MsAcaFQ43QiteDTj5+CFvbg@mail.gmail.com>
Subject: Re: [PATCH v2] hw/virtio: Fix packed virtqueue flush used_idx
To: Wafer <wafer@jaguarmicro.com>
Cc: mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, 
 angus.chen@jaguarmicro.com, Jonah Palmer <jonah.palmer@oracle.com>, 
 Lei Yang <leiyang@redhat.com>
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

On Thu, Apr 4, 2024 at 7:03=E2=80=AFPM Wafer <wafer@jaguarmicro.com> wrote:
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
> Signed-off-by: Wafer <wafer@jaguarmicro.com>
>

Fixes: 86044b24e8 ("virtio: basic packed virtqueue support")
?

> ---
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

This bugged me recently when I was reviewing it for in_order feature
implementation, thanks for the patch!

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

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
>


