Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 063FEC5DF9C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 19:16:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wya9Y-0005m9-Ry; Mon, 24 Aug 2026 15:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wya9X-0005m1-V7
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 15:16:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wya9W-00056F-2j
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 15:16:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787598972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9qp9k7P/i6D7uXXiCqCE5qj07OmoZLreUTm8GLA0Z2o=;
 b=QAxf6DeJvEjePA/q/DPi+/ftHIbkhZLwA2bGH9NbO7/qDwQDXRU4e+KEqNl1PIHeQBlcLf
 UkPuW/8Ni8zEReVzG0I7q9aVswffbgNKZ1dK5l9IleabzHxSSssRNCitYoi8zsLXaDVz80
 Ji84Hv7OkR3R9wQOsPOd6+H+zwQVQFY=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-1KYIAl9EMQ6iV3YmjvtEiQ-1; Mon, 24 Aug 2026 15:16:10 -0400
X-MC-Unique: 1KYIAl9EMQ6iV3YmjvtEiQ-1
X-Mimecast-MFC-AGG-ID: 1KYIAl9EMQ6iV3YmjvtEiQ_1787598969
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7f1ddcd241aso8729533a34.0
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 12:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787598969; x=1788203769; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9qp9k7P/i6D7uXXiCqCE5qj07OmoZLreUTm8GLA0Z2o=;
 b=Kmp01g61cOwE+kayfZt+Fms8BSwbHTHmfcQoUMsuMje2Asz+ksWZglSX36owzxQJBF
 JqZKRxNgzf1M265459RPYIFeuvZxfp5CDUgNUdFELrLALSaJpIz3Ah79TNLrht9D+jsr
 HASK3DyyAlgFP40SLgF/MrtyGBj150hmFeM6WzY83oLW0r3S8UN4iUia9XMoAgilcznO
 shOTJaB1NKh82bSlEpMw8iTebo0+t6BHhBteXplJcYqOciqdRdFFUpG/8J18c2C4G+Zo
 WX+dzay7JTUmTtrLXBr3hvsw4E8RVRm4etq9AIkb08ETu2PdRc4uwC0+SG11iFqVw27H
 FPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787598969; x=1788203769;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9qp9k7P/i6D7uXXiCqCE5qj07OmoZLreUTm8GLA0Z2o=;
 b=SgVU1qo10xh8PIszpkCqI4Q1MCVdz5Q8PeM/lDsFOGcGwfDK0OOF4PS1iCXj/OowuJ
 pZCGGylSdCjlnpkdBE8SI99CooGhaC86Xnk1Q4cy1qahhxnDKsGxM9YP1Thfie2eeX8y
 ogRbZpfc6USr4QklqrbELExxEM6tiHXOdZMftQ7Pkc/V0qzj+tzuGFriIw/hAzH+R3Cu
 mMPyuK6GunIb6kKHzBYWkd+edgyMe588+arrEUjbPtFsxK/6+ZirPmv76fYvzcrW0Pm4
 8pqm6ojE+WO7dePSu1xPMUweZw8kHEAbUnDo0sraQn4o7YhS8xVFCXycNEZeCcg44FFx
 0bVQ==
X-Gm-Message-State: AFuF++ksKHAcM8EpX+1JLxb4PJSRztGggYf6dgprLhho5fycxGqAr9Cm
 n2wTx9I6Q0XOgeYHz7JaP+Nb7f88JIMoqRiDXJXU3EXA7vuj9VElR8LfJ2dy/p+atjygP6zPhDI
 TsvBC3oFW2NMgKsev82IoUQfc/bTlTo9FnCNfklFXttJwysMirAdguhyI
X-Gm-Gg: AR+sD10K4aO4R+s27rlCocO6GCLArIExIDC6npVJF1Cr0nH5NQKKlToEdIpDLc68nDt
 aeKIuazkX/NNeVufEU2G1FJRZcJLsiBmSiarEBGvy6GQ192lhzS4Nz+30SDwZ/0oUtLU58O6Bkh
 tzgwLw9Rbi903CF5J2JuNiE+US5EkJnIR8Gk8pLuSu38pslRv0pYCQWm+V+0o+1DOLrTeNm39Pi
 U0mOm7yrVKRbFTiMinysMkeUqMft5b4lIHHU29nKt8xI5TTPFZxqXYzLPbcfJwLS9IyIYswmDiY
 ZHlhNxjfBFovanXjuqC1BBFiKal3/PvqT2xBVPLiIsjw9A5BLlx8/78/IJO9S9TBaVbFccMHz52
 lSWcD1YTaQSph/8RM52/AeGL6WtXHd4nOVbJ8TjAhL3de8+rvp47eXTb8CJg=
X-Received: by 2002:a05:6830:6111:b0:7e6:e162:915 with SMTP id
 46e09a7af769-7f4af75f1dcmr1221578a34.5.1787598968790; 
 Mon, 24 Aug 2026 12:16:08 -0700 (PDT)
X-Received: by 2002:a05:6830:6111:b0:7e6:e162:915 with SMTP id
 46e09a7af769-7f4af75f1dcmr1221535a34.5.1787598968272; 
 Mon, 24 Aug 2026 12:16:08 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f48fb1c6b2sm5492080a34.11.2026.08.24.12.16.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 12:16:07 -0700 (PDT)
Date: Mon, 24 Aug 2026 15:16:05 -0400
From: Peter Xu <peterx@redhat.com>
To: hongmianquan <hongmianquan@bytedance.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, caixiangfeng@bytedance.com,
 yanfei.xu@bytedance.com
Subject: Re: [RFC v1] migration/postcopy: fix page_requested leak for
 vhost-user shared pages
Message-ID: <aoyYdZj2kEStUTOO@x1.local>
References: <20260824122655.63646-2-hongmianquan@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260824122655.63646-2-hongmianquan@bytedance.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Aug 24, 2026 at 08:26:56PM +0800, hongmianquan wrote:
> With postcopy-preempt enabled, a postcopy migration of a guest with a
> vhost-user device can hang at the very end on the destination, after all
> pages are transferred (query-migrate: status=postcopy-active, remaining=0).
> 
> Root cause is an add/del key mismatch on mis->page_requested:
> 
> - add: a backend fault goes through postcopy_request_shared_page() ->
>   postcopy_request_page() -> migrate_send_rp_req_pages(), which inserts
>   the request and bumps page_requested_count keyed by client_addr.
> - del: qemu_ufd_copy_ioctl() removes the entry and drops the counter
>   keyed by this QEMU process's host address for the page.
> 
> client_addr is a VA in the external vhost-user backend's address space and
> never equals QEMU's host address, so the removal misses and the counter
> leaks. postcopy_ram_incoming_cleanup() then waits for it to reach zero
> forever, which also stalls the source (it waits for the return path).
> 
> Racing threads:
>   dst: postcopy_ram_listen_thread -> postcopy_ram_incoming_cleanup ->
>        qemu_cond_wait_impl              (waits for page_requested_count==0)
>        (postcopy_preempt_thread already placed/woke the pages)
>   src: migration_thread -> migration_completion ->
>        await_return_path_close_on_source -> qemu_thread_join
>        (source_return_path_thread blocked in recvmsg)
> 
> The leak is only triggered when the vhost-user backend faults on a page
> that has not been received yet: only then does the request take the
> shared-fault slow path and register an entry in page_requested. If that
> page is subsequently delivered while the request is still outstanding,
> its entry is never removed. (Pages already present when the backend
> faults just take the wake path and never register.) So a run may leak
> only a few entries (9 of ~244k requests in our repro) yet still hang.
> 
> Fix: key the request with the same host address the removal uses
> (rb->host + aligned_rbo) instead of client_addr. The backend wake still
> happens at placement time via postcopy_wake_shared().
> 
> Signed-off-by: hongmianquan <hongmianquan@bytedance.com>
> ---
>  migration/postcopy-ram.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index a3314d3180..98268b3c55 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -992,7 +992,20 @@ int postcopy_request_shared_page(struct PostCopyFD *pcfd, RAMBlock *rb,
>          return postcopy_wake_shared(pcfd, client_addr, rb);
>      }
>      /* TODO: support blocktime tracking */
> -    postcopy_request_page(mis, rb, aligned_rbo, client_addr, 0);
> +
> +    /*
> +     * The page will be placed by qemu_ufd_copy_ioctl(), which removes the
> +     * matching entry from mis->page_requested (and drops
> +     * page_requested_count) using this QEMU process's host address for the
> +     * page. Register the request with the same key, rb->host + aligned_rbo,
> +     * not client_addr: client_addr is a VA in the external vhost-user
> +     * backend's address space and can never equal that host address, so the
> +     * removal would miss forever, leaking page_requested_count and hanging
> +     * postcopy teardown.
> +     */
> +    postcopy_request_page(mis, rb, aligned_rbo,
> +                          (uint64_t)(uintptr_t)qemu_ram_get_host_addr(rb) +
> +                          aligned_rbo, 0);
>      return 0;
>  }

True.. this should have been overlooked, thanks for fixing it.

Reviewed-by: Peter Xu <peterx@redhat.com>

I haven't been looking at vhost-user path for years, now looking at it
again, I do have this feeling that this ->handler() API is a bit awkward
and too heavy: what we need is a translation of an HVA -> (rb, rb_offset),
then processing it the same as when the fault was generated from QEMU
process.  The vhost-user / client code might be more straightforward with a
->translate_hva().

I'm not sure if you agree with that idea, or would like to work on such a
cleanup, but if you're a serious vhost-user postcopy user (we don't have a
lot on the list..), feel free to take this if this sounds beneficial.

Thanks,

-- 
Peter Xu


