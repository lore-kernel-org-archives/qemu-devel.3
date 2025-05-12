Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09608C3ABCD
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 12:29:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uESH8-00058l-DF; Mon, 12 May 2025 08:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uESH6-00057j-Ax
 for qemu-devel@nongnu.org; Mon, 12 May 2025 08:28:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uESH1-0003HN-16
 for qemu-devel@nongnu.org; Mon, 12 May 2025 08:28:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747052925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iY7ZjkohqZva9suGMx/+9g/tRlkH13kFNrIBPOKtMIU=;
 b=TbWSV2t23i4v/4IWtyAatiYW9SNna4Mq2zUixm6H9zjClrHe3lZx8z5d/1yBSAL7c6waFV
 stf/L21hl3fZrrgwIwNe/14jdjGfSq8LewE+LMOZ+Dq6INKjx3xesJSu+u9KXCnDzi2p5q
 Ae1VAo6/RFhhK80oijix7W4O/Y9bq64=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-iKZTMF8_N_S_PQIcxxg_iw-1; Mon, 12 May 2025 08:28:44 -0400
X-MC-Unique: iKZTMF8_N_S_PQIcxxg_iw-1
X-Mimecast-MFC-AGG-ID: iKZTMF8_N_S_PQIcxxg_iw_1747052923
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a2046b5e75so361285f8f.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 05:28:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747052922; x=1747657722;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iY7ZjkohqZva9suGMx/+9g/tRlkH13kFNrIBPOKtMIU=;
 b=FE9U6f5DQlPbMh16Rjxs09piJlGaZ+TFQ9wVENp8aIAHaTO8bvSne5iY1BDAwSFNks
 Nnl3F8yfLk0kD+eDIS7V36HkR5MxCVCJkkWsM+08YO+iq7Bj6HBRWg4XaBLu2riW0b5k
 Hr5h0ubLs2xFj80KaBSOdqrqPz0vEIfrHys03JphNrSkaZLuKnxhMPoo/MjvmRWU0eWj
 BnB2lDU6D2JwNWDEfY3lUlaZhTVrVpxQXpzt9/YGJAdBS72U5pZlMLFGToL89LYKOiIA
 0RiRyfXfgd/vmjeGpVjEwbUFDuYvFY1Y1RkTj/S6vMjnLh/eb/inMqjcEdtn7xEMJpS/
 IJgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0UPFjfhwZZslsUfxFgQjdSdH/IhoI+GStR8RYEa9X/C7gLgBOGly5WAWw9aVKx/Um3a567iFBhD8z@nongnu.org
X-Gm-Message-State: AOJu0YyKrcEIJjAVhbF3r+1HSvLKCI+2nb6atCJmJxo7owWAIYmxg+vT
 NajQlTrg7/n/zYPRu6ev9FL32AjC4F7ckHwERR+JQSxPHSww5TkcLa/EBvt+6odQAADOiPlel5J
 V4opcHTJBzEl0Fk7oo+GXXvpOU48RyHctD7HsOttt65sgWn6169nxCqxJicYE
X-Gm-Gg: ASbGncuxyBJEjLPXncEdgzUgUwzSnhLEilra/TCVWOPz/AqK4IDReqmJqsQkfbSVrdT
 Cjp6rNy6/P0a8koxUSxZh315zuuLDMyVuZCeaK+CobRG0tfjrDfIrye/GBL8MRvukBTyTkIPuul
 AEOj/jmRN3KpR0vSHaPNBVrVcg4DgJhtNdRz8bqc5FHQDDiOFqAF3M/LDRWkK5IeFWKgACe+8Mz
 nGFRwbDfyY5JtUkYdE1tWelG1bzJ+CBrm8T8oNfCWH5+fl7fO+4pJ3AghpKV7uqUGC2KwwOFd9C
 0c3e4aeHwL9kAh8XkeiwOYFXJiHEnyZiW2SAOeMvAINbzgEXj1JnvAuKoaoyyPvzjQ0eSA8BLYU
 NOnoh/N+oZfouFx5RM7OEB1xiFFYPTXi3eJIyqoiI
X-Received: by 2002:a5d:5f96:0:b0:3a0:b797:c459 with SMTP id
 ffacd0b85a97d-3a1f6499d05mr10202535f8f.47.1747052922072; 
 Mon, 12 May 2025 05:28:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnRontGVc11z6aQnJbMrk0MHJ+fHXpGRkvEbtQJNTOpXqASaMxNXTKtjyJX7RjOE11oJNbiA==
X-Received: by 2002:a5d:5f96:0:b0:3a0:b797:c459 with SMTP id
 ffacd0b85a97d-3a1f6499d05mr10202520f8f.47.1747052921724; 
 Mon, 12 May 2025 05:28:41 -0700 (PDT)
Received: from ?IPV6:2003:cf:d728:a02c:cb23:ffbf:e605:f5f4?
 (p200300cfd728a02ccb23ffbfe605f5f4.dip0.t-ipconnect.de.
 [2003:cf:d728:a02c:cb23:ffbf:e605:f5f4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f57dddebsm12166711f8f.3.2025.05.12.05.28.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 May 2025 05:28:40 -0700 (PDT)
Message-ID: <c43d6a3b-ac4e-4cee-b034-7ddcdf7dedf8@redhat.com>
Date: Mon, 12 May 2025 14:28:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] qcow2: put discards in discard queue when
 discard-no-unref is enabled
To: Jean-Louis Dupond <jean-louis@dupond.be>, qemu-devel@nongnu.org
Cc: Alexander Ivanov <alexander.ivanov@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
References: <20250429103110.761910-1-jean-louis@dupond.be>
 <20250429103110.761910-3-jean-louis@dupond.be>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20250429103110.761910-3-jean-louis@dupond.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 29.04.25 12:31, Jean-Louis Dupond wrote:
> When discard-no-unref is enabled, discards are not queued like it
> should.
> This was broken since discard-no-unref was added.
>
> Add some helper function qcow2_discard_cluster which handles some common
> checks and calls the queue_discards function if needed to add the
> discard request to the queue.
>
> Signed-off-by: Jean-Louis Dupond <jean-louis@dupond.be>
> ---
>   block/qcow2-cluster.c  | 16 ++++++----------
>   block/qcow2-refcount.c | 19 ++++++++++++++++++-
>   block/qcow2.h          |  4 ++++
>   3 files changed, 28 insertions(+), 11 deletions(-)
>
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index ce8c0076b3..c655bf6df4 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -1978,12 +1978,10 @@ discard_in_l2_slice(BlockDriverState *bs, uint64_t offset, uint64_t nb_clusters,
>           if (!keep_reference) {
>               /* Then decrease the refcount */
>               qcow2_free_any_cluster(bs, old_l2_entry, type);
> -        } else if (s->discard_passthrough[type] &&
> -                   (cluster_type == QCOW2_CLUSTER_NORMAL ||
> -                    cluster_type == QCOW2_CLUSTER_ZERO_ALLOC)) {
> +        } else {
>               /* If we keep the reference, pass on the discard still */
> -            bdrv_pdiscard(s->data_file, old_l2_entry & L2E_OFFSET_MASK,
> -                          s->cluster_size);
> +            qcow2_discard_cluster(bs, old_l2_entry & L2E_OFFSET_MASK,
> +                                  s->cluster_size, cluster_type, type);
>           }
>       }
>   
> @@ -2092,12 +2090,10 @@ zero_in_l2_slice(BlockDriverState *bs, uint64_t offset,
>               if (!keep_reference) {
>                   /* Then decrease the refcount */
>                   qcow2_free_any_cluster(bs, old_l2_entry, QCOW2_DISCARD_REQUEST);
> -            } else if (s->discard_passthrough[QCOW2_DISCARD_REQUEST] &&
> -                       (type == QCOW2_CLUSTER_NORMAL ||
> -                        type == QCOW2_CLUSTER_ZERO_ALLOC)) {
> +            } else {
>                   /* If we keep the reference, pass on the discard still */
> -                bdrv_pdiscard(s->data_file, old_l2_entry & L2E_OFFSET_MASK,
> -                            s->cluster_size);
> +                qcow2_discard_cluster(bs, old_l2_entry & L2E_OFFSET_MASK,
> +                            s->cluster_size, type, QCOW2_DISCARD_REQUEST);
>               }
>           }
>       }
> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
> index d796018970..e1f830504d 100644
> --- a/block/qcow2-refcount.c
> +++ b/block/qcow2-refcount.c
> @@ -1205,6 +1205,23 @@ void qcow2_free_any_cluster(BlockDriverState *bs, uint64_t l2_entry,
>       }
>   }
>   
> +void qcow2_discard_cluster(BlockDriverState *bs, uint64_t offset,
> +                           uint64_t length, QCow2ClusterType ctype,
> +                           enum qcow2_discard_type dtype) {
> +

QEMU coding style requires putting the { on a separate line.

> +    BDRVQcow2State *s = bs->opaque;
> +
> +    if (s->discard_passthrough[dtype] &&
> +        (ctype == QCOW2_CLUSTER_NORMAL ||
> +         ctype == QCOW2_CLUSTER_ZERO_ALLOC)) {
> +        if (has_data_file(bs)) {
> +            bdrv_pdiscard(s->data_file, offset, length);
> +        } else {
> +            queue_discard(bs, offset, length);
> +        }
> +    }
> +}
> +
>   int qcow2_write_caches(BlockDriverState *bs)
>   {
>       BDRVQcow2State *s = bs->opaque;
> @@ -3619,7 +3636,7 @@ qcow2_discard_refcount_block(BlockDriverState *bs, uint64_t discard_block_offs)
>           /* discard refblock from the cache if refblock is cached */
>           qcow2_cache_discard(s->refcount_block_cache, refblock);
>       }
> -    update_refcount_discard(bs, discard_block_offs, s->cluster_size);
> +    queue_discard(bs, discard_block_offs, s->cluster_size);
>   
>       return 0;
>   }

This hunk should go into the previous patch.

> diff --git a/block/qcow2.h b/block/qcow2.h
> index a9e3481c6e..547bb2b814 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -880,6 +880,10 @@ void GRAPH_RDLOCK qcow2_free_clusters(BlockDriverState *bs,
>   void GRAPH_RDLOCK
>   qcow2_free_any_cluster(BlockDriverState *bs, uint64_t l2_entry,
>                          enum qcow2_discard_type type);
> +void GRAPH_RDLOCK
> +qcow2_discard_cluster(BlockDriverState *bs, uint64_t offset,
> +                      uint64_t length, QCow2ClusterType ctype,
> +                      enum qcow2_discard_type dtype);
>   
>   int GRAPH_RDLOCK
>   qcow2_update_snapshot_refcount(BlockDriverState *bs, int64_t l1_table_offset,

With the above done, for both patch 1 and 2:

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>


