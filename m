Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EFCCC53219
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 19:19:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp9o2-0005zR-4H; Wed, 29 Jul 2026 15:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wp9o0-0005yv-FQ
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 15:19:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wp9ny-0005tm-7k
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 15:19:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785352741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zVEs3eBjql7RD8DsNLS4BG5zA6/dCRCLGrdLubsViTM=;
 b=OVRFexl/97jIois18K5A/8c7dQMcfveA/Q12RPIrU3Qvwl9jQdLYD4J1eUra0Awvg4uH4Z
 iAuEqvLZQY8ifcHGTXaVhZ66Z7cPUkkIW7uwf5R50VqGb+9sKVlUn95GgiSAKOYBKV1Yml
 CiPhETpmwG+CRRZNLRpUZJmCNLOi4nA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-i5f59LyANNC5qZMu4y2GIQ-1; Wed, 29 Jul 2026 15:18:59 -0400
X-MC-Unique: i5f59LyANNC5qZMu4y2GIQ-1
X-Mimecast-MFC-AGG-ID: i5f59LyANNC5qZMu4y2GIQ_1785352739
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9309af14fd7so130205085a.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 12:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785352739; x=1785957539; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zVEs3eBjql7RD8DsNLS4BG5zA6/dCRCLGrdLubsViTM=;
 b=a6jb9fR4CfJy6rmPa4BLvGJrv6iigwLNLH8AqhdOgRse75KUuEKh35QrUkN4na7yIE
 tP7YMOZL7/jj+oWXnc/HT72ONKRFZVd/MDvk4nQQqkEyUnnIQJxKA+Z+RH9mlSDtW/ej
 u6lE+HZTWOxV6KUbmy9wGDe0liJAN8PTggwc9R/ukcroGzA65zNXY3vQc5PgPpbdjpSW
 UUtu2A1iU8/LWVH3rZsKucEbytK96opA18kGrlnedmoKafCL8u/WAFdw6ZwJAnxNxAPH
 8c+oraH4LhDXOF6JOm3zjbw03e26FMG4CqDYBn32t2JET60n4/SCqOQofYDq0jKsgl2L
 jpXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785352739; x=1785957539;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zVEs3eBjql7RD8DsNLS4BG5zA6/dCRCLGrdLubsViTM=;
 b=rNHYveOYnq1vWIvH1aLsk1LUrkNokrIujTPkFzQbZB1UetwWuOYcJiUmJFAg7fBDiA
 yX736wkNnzsf5bhfNL2ClkkyvxeZrayLDawTS7sjF9aPyh3olAjSg0eKMfbuStxeQXlI
 YVfkju2lJ2Q1wwKlTHmnAQ+jP9r8OLpftAA3vpAPGYa5fZaDYkcPsJNRBJfLfRTWP91S
 jB94Ze47+JhKRa8jZUqXRrWFImjKaKTZBNNUAomth9FGcsYqMwbzDiTKS1MzEDgn0CTv
 AqujAHjnoDssYTX5ZZXPsWYx9DQ1wqWq31pDMCxbBfncOgpuua05nIjgQHEeR4BegyI2
 j7dA==
X-Gm-Message-State: AOJu0YynC8XLCbZuhzTMWs0R7FbxL/QCkyZtAVUzfzK/9Wechi4XT9R9
 PzxavO+vWf4YYYIxi4eNp3MqhW/LuYTwxRDUufYTOziQXwqNUH00L+2KXP3K7wioc4kvxbky5Oa
 8dGVn+alX9jBR98jWJJAWrImHJEsLb9/aW1o+4w9W9bvl/mhTzen4fgZn
X-Gm-Gg: AR+sD10vI+mBcyVvxfUP9EmLEVAS6Q87AUBPxeIkXFY8iISUjE5axnIC81MUR+kwwCh
 VN5nKyFg1947hxktCCY1a0nvFR0e6gPzG4GfkdMwNupFNa3iT2x3KyOBvUjUMcwGu8RwTXyMUyY
 aLyquSKTwpPUXapml4De/30Ic2ppiMXnHBTTjueBmhgSkmpubXYjS5zPz19/IYrzt8UY6+/94bT
 PY/pqMFMotwM8ZAUNRNGHAqZeFd4kTz3VJ/+tgPm70q4AAaTKDjM+tjnv96kQhu6SXD5oMSEAaf
 RbMzf4rSYrpnwItHjijWnLg74lZDMyaVLHEdf4+ADmnz+N43FocVtU0oz1Chc1L1SSAx
X-Received: by 2002:a05:620a:371c:b0:92b:6805:919f with SMTP id
 af79cd13be357-93483f1e9d3mr16252785a.71.1785352738865; 
 Wed, 29 Jul 2026 12:18:58 -0700 (PDT)
X-Received: by 2002:a05:620a:371c:b0:92b:6805:919f with SMTP id
 af79cd13be357-93483f1e9d3mr16245585a.71.1785352737876; 
 Wed, 29 Jul 2026 12:18:57 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-933e7351067sm233464485a.41.2026.07.29.12.18.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 12:18:57 -0700 (PDT)
Date: Wed, 29 Jul 2026 15:18:45 -0400
From: Peter Xu <peterx@redhat.com>
To: Samuel Zhang <guoqing.zhang@amd.com>,
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, lizhijian@fujitsu.com,
 eblake@redhat.com, armbru@redhat.com, Emily.Deng@amd.com,
 Victor.Zhao@amd.com, PengJu.Zhou@amd.com, Qing.Ma@amd.com
Subject: Re: [PATCH v4] migration/rdma: add x-rdma-chunk-size parameter
Message-ID: <ampSFcrRagKtf5y_@x1.local>
References: <20260330064758.2816891-1-guoqing.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260330064758.2816891-1-guoqing.zhang@amd.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

I'm looking at some RDMA security tickets recently, and I stumbled on top
of this chunk size problem.  Since this is very recently touched, I figured
maybe I should ask here,

On Mon, Mar 30, 2026 at 02:47:58PM +0800, Samuel Zhang wrote:
> @@ -2176,7 +2178,7 @@ static int qemu_rdma_write(RDMAContext *rdma,
>      rdma->current_length += len;
>  
>      /* flush it if buffer is too large */
> -    if (rdma->current_length >= RDMA_MERGE_MAX) {
> +    if (rdma->current_length >= rdma_merge_max()) {

[1]

What is this rdma_merge_max()?  Why it's twice the chunk size, and even if
I believe when reaching here the current_length should have been throttled
by chunk size too?

>          return qemu_rdma_write_flush(rdma, errp);
>      }

I mean, in qemu_rdma_buffer_mergeable():

    ...
    chunk_end = ram_chunk_end(block, rdma->current_chunk);
    ...
    if ((host_addr + len) > chunk_end) {
        return false;
    }

I believe it means when len will go beyond chunk size, it'll force a flush
already.

With that, when reaching [1] above, we either should have just flushed, or
we're under chunk size (which further guarantees smaller than
2*chunk_size).

What did I miss?  Or, is this line [1] dead code?

Thanks,

-- 
Peter Xu


