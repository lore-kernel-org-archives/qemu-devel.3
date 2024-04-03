Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B99BCCD1288
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 05:59:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrte0-0001uQ-3Q; Wed, 03 Apr 2024 01:58:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rrtdy-0001u7-H6
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 01:58:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rrtdw-0001Bz-Cu
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 01:58:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712123918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0qBmk5DSpZWOAP+Nh/xEhlr8+MhFy3gbFTOR4VuC2OQ=;
 b=IIm0otvQcnPzWBM7Kc2JQgYkSg0uBwB7PlZqBibP6DbwANz9gl1FkjzxG1nMflrOv6gR1j
 BuKSVP6t5yY23o4d19UOdYBaq6/DdKXJ+8YoBUc5MHFXSoGDynD27YzfefoQQRPY2hxZq0
 3VGKUT1Mpl/7Qc1Qp7bzdRNCwk0/p+c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-QritsJs-OFGCqRUYri34yw-1; Wed, 03 Apr 2024 01:58:37 -0400
X-MC-Unique: QritsJs-OFGCqRUYri34yw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-415667f46a8so12800455e9.2
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 22:58:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712123916; x=1712728716;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0qBmk5DSpZWOAP+Nh/xEhlr8+MhFy3gbFTOR4VuC2OQ=;
 b=m2uce5thLtOJDNBt6H92uRbLms/EO2mc2pye4BP7TehvQWYciJKslNYiROSjrNwO6b
 Vx+GHvIezVUVdmJuD492Z3WZ1hrV4DphSaFrylGPSLaRYKic8Sa/aUhngSCODx1/jPGf
 IPYOuQvnPldAvUV8FfEr59aP4vEj3NUA/aWnLGqAx0uO0D7cJSENc2Z2Qii2drWs6Bhu
 0R4iF3P3azLgv2oK/5LRPN8HosvnxOIJopVSWII/ll+usc7xRRBAHF48GdTvwcEORUSg
 pqbnjsVTe6CZg2daJzEZVpzntB9y6xosGYvVVaZe92D7h9dh+gDMwsj1tUF/DnLZgDqN
 g7CQ==
X-Gm-Message-State: AOJu0YzNtfK23+DxMYNmLykOV+C0JXL+Vsds/a7WXXkmTZVZ2RFaDiJP
 P3Imfoud51dapGR+TX2bOSP4Gt1ATR+Wd2ZVQg3DUSyOLkpTGciRAcmdxBy8wA7aIIaW93CNa1G
 P7hhLCgRb0c/A6eqtPWKd5zG82xf5S+wTuE9FbMOT4yoFyZDAuf8L
X-Received: by 2002:a05:600c:5253:b0:413:f3f0:c591 with SMTP id
 fc19-20020a05600c525300b00413f3f0c591mr14589646wmb.41.1712123915692; 
 Tue, 02 Apr 2024 22:58:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJp809qNLf0s+BHbWM7KduIzHfkv9SLAAqroG4GHlxNh+IAyQd5Q0AkqDIHZ2cgQGuxwblAw==
X-Received: by 2002:a05:600c:5253:b0:413:f3f0:c591 with SMTP id
 fc19-20020a05600c525300b00413f3f0c591mr14589627wmb.41.1712123915039; 
 Tue, 02 Apr 2024 22:58:35 -0700 (PDT)
Received: from redhat.com ([2a02:14f:174:9128:ec74:5892:ce26:6869])
 by smtp.gmail.com with ESMTPSA id
 bh2-20020a05600005c200b003438cc1d2b4sm1315182wrb.59.2024.04.02.22.58.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Apr 2024 22:58:34 -0700 (PDT)
Date: Wed, 3 Apr 2024 01:58:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Wafer <wafer@jaguarmicro.com>
Cc: qemu-devel@nongnu.org, angus.chen@jaguarmicro.com,
 Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] hw/virtio: Fix packed virtqueue flush used_idx
Message-ID: <20240403012519-mutt-send-email-mst@kernel.org>
References: <20240327061518.13200-1-wafer@jaguarmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327061518.13200-1-wafer@jaguarmicro.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Wed, Mar 27, 2024 at 02:15:18PM +0800, Wafer wrote:
> For indirect descriptors the elelm->ndescs was one,
> For direct descriptors the elele->ndesc was the numbe of entries.
> elem->ndescs = (desc_cache == &indirect_desc_cache) ? 1 : elem_entries;
> 
> When flushing multiple elemes,
> the used_idx should be added to all the privious numeric entry value.
> 
> Signed-off-by: Wafer <wafer@jaguarmicro.com>

Thanks for the patch.
It's kind of hard to figure out what you are trying to say
with all the typos and grammar errors in the commit log.
What's up with that?


Please describe the following in the commit log:
- current behaviour is abc
- this is wrong because the virtio spec says def
- as a result we observed guest doing pqr and then stu
- to fix do ghi
- with this fix the guest does xyz as expected
- tested by klm


Also I think you might want to add:

Fixes: 86044b24e8 ("virtio: basic packed virtqueue support")
Cc: "Jason Wang" <jasowang@redhat.com>


> ---
>  hw/virtio/virtio.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index d229755eae..44f1d2fcfc 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -957,12 +957,17 @@ static void virtqueue_packed_flush(VirtQueue *vq, unsigned int count)
>          return;
>      }
>  
> +    /*
> +     * When the descriptor's flag was 'INDIRECT', the value of 'ndescs' is one.
> +     * When the descriptor's flag was 'chain', the value of 'ndescs'
> +     * is the number of entries.
> +     */

There's no such thing as "the flag" - descriptors do have a "flags" field
though. And there's no 'chain' value either.
maybe just "


	For indirect elems, ndescs is 1. For all other elems, ndescs is the
	number of descriptors chained by NEXT (as set in virtqueue_packed_pop).


> +    ndescs += vq->used_elems[0].ndescs;
>      for (i = 1; i < count; i++) {
> -        virtqueue_packed_fill_desc(vq, &vq->used_elems[i], i, false);
> +        virtqueue_packed_fill_desc(vq, &vq->used_elems[i], ndescs, false);
>          ndescs += vq->used_elems[i].ndescs;
>      }
>      virtqueue_packed_fill_desc(vq, &vq->used_elems[0], 0, true);
> -    ndescs += vq->used_elems[0].ndescs;
>  
>      vq->inuse -= ndescs;
>      vq->used_idx += ndescs;


The patch itself seems correct to me.



> -- 
> 2.27.0


