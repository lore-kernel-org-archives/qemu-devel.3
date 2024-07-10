Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58464C3DA41
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 12:59:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRWuZ-0008Gm-LP; Wed, 10 Jul 2024 08:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1sRWuY-0008Bc-9Z
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 08:59:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1sRWuW-0006FF-DX
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 08:59:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720616343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ysuLCmGjsFZT8+9ub+Q9FmxdzGJAJ0Rcfny6+fjikq0=;
 b=I/LehbnY3yCPTi/1tKWR2rYpk21IlpGu3e9JLo6qeMbovSo+59ptJ/GFD7tbo4bq/9ca+y
 XKS9nsvQt9VCxQKRnAW6A0EsdmWnBPaXUQHipp1pOY3ZmbPUfXh0IqNmClXZ/FksISX00a
 qpkP7Mhlzhv67JnQ5iFuQwZteXMvzZU=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-X55AxVklM9GqwZ17IWmEQA-1; Wed, 10 Jul 2024 08:59:01 -0400
X-MC-Unique: X55AxVklM9GqwZ17IWmEQA-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2ee8f22ef7cso60521981fa.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 05:59:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720616340; x=1721221140;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ysuLCmGjsFZT8+9ub+Q9FmxdzGJAJ0Rcfny6+fjikq0=;
 b=olh/LMI+cM7fOeYejvufCoCBlP0Iqeh+kobvvk1esowpaJeBl9rHj72rhVr9WLMJkZ
 i+FsY6qo2Xwg6DUq0Xu9X8zo1wGzO8GevdvJzlJjKlnCdpkKgBc6lem+EYgMJkpg0rVC
 7ScfRab4csRfYtGHmoIz+kZ8W4ROIVtQ2Yq56dHmV8md+Wa8s3v218Hfmql2GyfBplnC
 wrfh53UY5Ita3EMLv9C3q/meOGzxtTo6z1CjLc36v/DFUNOgf5YMJkrv6mygTc6QCZyc
 1rVrJQkVYFzsTE3smUvvFAQuiIl5qakXJfOtMARC1LfnXfgkKMTaq8cGPCtlyQCXpRVT
 ePxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrmVxO/NVzQxnK7idlryYl1OrGsNR49JVoIlhWWEt766NFo9rqdj8HXEPKNyBgm7ksZPFbXjcc00KgNfd1kPOAnI7B1O4=
X-Gm-Message-State: AOJu0Yyc54KrmHzyqAwJV4d7HWWnkVb+Wu5kj5fhSGJyk3UfYPukmMGO
 Y6xfaXXhLDESGNaWh5Ean7o+PIJKQxWZw5ZNJuUS4dNjHfrVDD99jTfXzhODuS8VtF2iAuLuel0
 FftHPAvC8fdKWCEeIJ5KzhvRLNYZwIw5nzkq1cOMlBZDwl3EWyysc
X-Received: by 2002:a05:651c:21c:b0:2ee:bc94:6854 with SMTP id
 38308e7fff4ca-2eebc94692fmr17015201fa.13.1720616340451; 
 Wed, 10 Jul 2024 05:59:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYxKSP1mRZowSIgMktQzzVRMtQuSXaUxjgMmTVKtONMfbH18Gc0ctsaY0V/b7BjwqrxbIAFA==
X-Received: by 2002:a05:651c:21c:b0:2ee:bc94:6854 with SMTP id
 38308e7fff4ca-2eebc94692fmr17015061fa.13.1720616339673; 
 Wed, 10 Jul 2024 05:58:59 -0700 (PDT)
Received: from ?IPV6:2003:cf:d74b:1ce0:c033:e72e:9d5f:f8c4?
 (p200300cfd74b1ce0c033e72e9d5ff8c4.dip0.t-ipconnect.de.
 [2003:cf:d74b:1ce0:c033:e72e:9d5f:f8c4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cdfab7d4sm5233878f8f.113.2024.07.10.05.58.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jul 2024 05:58:58 -0700 (PDT)
Message-ID: <80a77456-da98-4346-aa56-a7389934cdcf@redhat.com>
Date: Wed, 10 Jul 2024 14:58:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] qcow2: handle discard-no-unref in measure
To: Jean-Louis Dupond <jean-louis@dupond.be>, qemu-devel@nongnu.org,
 kwolf@redhat.com, andrey.drobyshev@virtuozzo.com
References: <20240605132539.3668497-2-jean-louis@dupond.be>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20240605132539.3668497-2-jean-louis@dupond.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

On 05.06.24 15:25, Jean-Louis Dupond wrote:
> When doing a measure on an image with a backing file and
> discard-no-unref is enabled, the code should take this into account.

That doesn’t make sense to me.  As far as I understand, 'measure' is 
supposed to report how much space you need for a given image, i.e. if 
you were to convert it to a new image.  discard-no-unref doesn’t factor 
into that, because for a 'convert' target (a new image), nothing can be 
discarded.

Reading the issue, I understand that oVirt uses measure to determine the 
size of the target of a 'commit' operation.  Seems a bit like abuse to 
me, precisely because of the issue you’re facing.  More specifically, a 
'commit' operation is a complex thing with a lot of variables, so the 
outcome depends on a lot.

For example, this patch just checks the discard-no-unref setting on the 
top image.  But AFAIU it doesn’t matter what the setting on the top 
image is, it matters what the setting on the commit target is. 'measure' 
can’t know this because it doesn’t know what the commit target is.  As 
far as I can see, this patch actually assumes the commit target is the 
first backing image (it specifically checks in the image whether a block 
is allocated) – why?

So to me that means if 'measure' is supposed to give reliable data on 
the commit case, it needs to be extended.  Best thing I can come up with 
off the top of my head would be to add an option e.g. 
'commit=<target-node-name>', so we (A) that we’re looking at a commit 
and not a convert, and (B) we know what data will be collapsed into 
which image and where we need to check for discard-no-unref.

Hanna

> If for example you have a snapshot image with a base, and you do a
> discard within the snapshot, it will be ZERO and ALLOCATED, but without
> host offset.
> Now if we commit this snapshot, and the clusters in the base image have
> a host offset, the clusters will only be set to ZERO, but the host offset
> will not be cleared.
> Therefor non-data clusters in the top image need to check the
> base to see if space will be freed or not, to have a correct measure
> output.
>
> Bug-Url: https://gitlab.com/qemu-project/qemu/-/issues/2369
> Signed-off-by: Jean-Louis Dupond <jean-louis@dupond.be>
> ---
>   block/qcow2.c | 32 +++++++++++++++++++++++++++++---
>   1 file changed, 29 insertions(+), 3 deletions(-)
>
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 956128b409..50354e5b98 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -5163,9 +5163,16 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
>           } else {
>               int64_t offset;
>               int64_t pnum = 0;
> +            BlockDriverState *parent = bdrv_filter_or_cow_bs(in_bs);
> +            BDRVQcow2State *s = NULL;
> +
> +            if (parent) {
> +                s = parent->opaque;
> +            }
>   
>               for (offset = 0; offset < ssize; offset += pnum) {
>                   int ret;
> +                int retp = 0;
>   
>                   ret = bdrv_block_status_above(in_bs, NULL, offset,
>                                                 ssize - offset, &pnum, NULL,
> @@ -5176,10 +5183,29 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
>                       goto err;
>                   }
>   
> -                if (ret & BDRV_BLOCK_ZERO) {
> +                /* If we have a parent in the chain and the current block is not data,
> +                 * then we want to check the allocation state of the parent block.
> +                 * If it has a valid offset, then we want to include it into
> +                 * the calculation, cause blocks with an offset will not be freed when
> +                 * committing the top into base with discard-no-unref enabled.
> +                 */
> +                if (parent && s->discard_no_unref && !(ret & BDRV_BLOCK_DATA)) {
> +                        int64_t pnum_parent = 0;
> +                        retp = bdrv_block_status_above(parent, NULL, offset,
> +                                              ssize - offset, &pnum_parent, NULL,
> +                                              NULL);
> +                        /* If the parent continuous block is smaller, use that pnum,
> +                         * so the next iteration starts with the smallest offset.
> +                         */
> +                        if (pnum_parent < pnum) {
> +                            pnum = pnum_parent;
> +                        }
> +                }
> +                if (ret & BDRV_BLOCK_ZERO && !parent && !(parent && s->discard_no_unref)) {
>                       /* Skip zero regions (safe with no backing file) */
> -                } else if ((ret & (BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED)) ==
> -                           (BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED)) {
> +                } else if (((ret & (BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED)) ==
> +                            (BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED)) ||
> +                           (retp & BDRV_BLOCK_OFFSET_VALID)) {
>                       /* Extend pnum to end of cluster for next iteration */
>                       pnum = ROUND_UP(offset + pnum, cluster_size) - offset;
>   


