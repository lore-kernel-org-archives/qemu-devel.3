Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2BDDCD4840
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 17:49:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMUkd-0001iG-LK; Mon, 11 May 2026 13:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wMUkW-0001Ym-Av
 for qemu-devel@nongnu.org; Mon, 11 May 2026 13:49:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wMUkU-0000DW-Lf
 for qemu-devel@nongnu.org; Mon, 11 May 2026 13:49:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778521737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2k6EVpPdTvF6lgkq1jsRaaapq0/oSVZuA6kMYpBnMyM=;
 b=AzNvLXo7cLTg+24abBxeo02Y5i4qoh6acvaz/78xd3wK5kbUDjbTymZTrCBzGd8Ys3JmjK
 UK1GasnDtcg88F+wL1SS/M2w0qSYfmJssGqsrTsnzxvXulcH4kndxG/+O2YkTWDXoALj5j
 nMEjw0meI/GAS+Rl9jGZYMoFDHVMRck=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-hsxk99K4MbylbZm3wff1WA-1; Mon, 11 May 2026 13:48:56 -0400
X-MC-Unique: hsxk99K4MbylbZm3wff1WA-1
X-Mimecast-MFC-AGG-ID: hsxk99K4MbylbZm3wff1WA_1778521736
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-514cbe73d00so10516221cf.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 10:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778521735; x=1779126535; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2k6EVpPdTvF6lgkq1jsRaaapq0/oSVZuA6kMYpBnMyM=;
 b=tgOl08EYZTSZub8j8yq+BULjZtESBUFoXoy3/yGGUB8p+/KDFnM2E3mRGJjRZoI2NQ
 A7gIqsArotSPfvci8/H2yIyw5att0fne+rfj+hvrIrhSo7fE53/cn0KLUwEnnbO+YUoW
 MyKVj59P5NkCfKXaGESn5OD8dPD3zAmUEiikAwpQErcIpfwWumU1nM0iDXGua5bK5MjZ
 2GOBHOEyRVG7COsqrndzAW3IoUaW7GvtpKJbYNfgSptqMyiokpWjS0JBwQR/l3Kf+g3G
 C3gqgQ9GsLXMtCrDqaVc8UvBI2v0kKnI4DbbQFEBELzOVa9GvSGRthbZRxxKrpiV8mvm
 e0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778521735; x=1779126535;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2k6EVpPdTvF6lgkq1jsRaaapq0/oSVZuA6kMYpBnMyM=;
 b=LFwpLXI5n+UMy7Apdw6C6xN/M0g1dDUSAeim2/scpGfPgWWNxuQPJ79nfbmWh5zVEy
 Wu+LQRn7rxDZmmhVBEPEZf1mOBhaM8OYBVNJuKyvLUwf/85WlzbupousUg1CoyOQVFZ5
 lEWCIQf06BfUF9gwnS+MTw39F0FTZ92aTmlOzuzf/JewTxNWLOZIefb4yvTe63mL+J5z
 w0yGUdjvs/N/7YCvO/Rsapl//s3zKkOuGNrMQaq0x4mKJNUIistBCo0tP9cFvKTGiDey
 iLPyEdB1c0JVD3LK5BAKrzhflGmwBezf9nG2wAqHmNhUTLG8Q9vpQOmJ6YOmej0mXTmV
 yf+Q==
X-Gm-Message-State: AOJu0YyDqeHt+JXfPn7TLU3bZR+Idmmboi58IVJQsrDwtZYS0b93kEVs
 JiljL/B8yGQsDlsuApRiJpp+1WFp3oZ93mEj7nlv/ZDiyzaQXzssw3bRLnDx0Ot0uVFRr+mIJPY
 1uo7srqkrYj3TLobB4GDAVR2z3ELVHhGTXzidnyXDkgWbPlJurnqQkk5YGRzAsG2hubNMPo8Z3U
 D3Pw/Y5kJJLx7E7qvmb/vFW5kl/r2Rg+R6OfaKUg==
X-Gm-Gg: Acq92OHHT83J67HeBepbVe4HgT1O0YbtbgOY8lK9gnp35pQqI0PzkQ+KgE3X6qnFy3n
 +fMSYfDWgMtGV2KmBaBlvp3k2oP7ZDUV+No0EL0sPj3TucFHmUfkHZSP8T6113V+19bIEwvXETq
 RtAlfLxgpedyFDSBMYh94qMppB2NBfICSWdET3XNPJQRaFdFtVzYyt/thq2pGspa37LQE2ckB93
 WdBrBvBL6YwuTFQnDiauDujxpz1LLfSptK6wHCDIfHYJyEXqSLwDrRlL0dBux1KBVDexYp/dc55
 Mi6V8nCiMvTQpGwjsgqSh6N734vN1itPR+ebdaoqerL5c81R0aGon1EUuDrSpUaYI97KyqSPTWv
 0vFC8+jjfHqoj5Lfsluyp2yKqBCAK7TliI1EkzcWxh7thUtc=
X-Received: by 2002:ac8:5d11:0:b0:510:141d:9d03 with SMTP id
 d75a77b69052e-5148e7ca391mr208727961cf.7.1778521735420; 
 Mon, 11 May 2026 10:48:55 -0700 (PDT)
X-Received: by 2002:ac8:5d11:0:b0:510:141d:9d03 with SMTP id
 d75a77b69052e-5148e7ca391mr208727531cf.7.1778521734716; 
 Mon, 11 May 2026 10:48:54 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5148e6336c0sm102823551cf.2.2026.05.11.10.48.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 10:48:54 -0700 (PDT)
Date: Mon, 11 May 2026 13:48:53 -0400
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Cc: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: Update RDMA migration entry with M:
Message-ID: <agIWhVlVazRBxNWe@x1.local>
References: <20260511143026.1296485-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260511143026.1296485-1-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

I somehow thought this will copy Fabiano by default.. now copied.

On Mon, May 11, 2026 at 10:30:26AM -0400, Peter Xu wrote:
> We wanted to remove RDMA migration once but that didn't go further.  In
> reality, with the help of Zhijian it's in Odd Fixes stage, even if we just
> merged one new parameter for it, for performance improvements.
> 
> Markus pointed out we'd better have at least one M: for it to match
> anything that is not orphaned.
> 
> Remove the X: for Migration entry for RDMA files, then it'll start to cover
> RDMA migration again. Keep the separate entry so Zhijian can keep getting
> copied, and copy the M:s over to say someone is collecting patches.
> Logically these M:s aren't needed after removing X:, but make it clearer.
> 
> Link: https://lore.kernel.org/r/5326b854-fcea-4af6-a479-792888a94a4d@fujitsu.com
> Cc: Zhijian Li (Fujitsu) <lizhijian@fujitsu.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9d3d645953..c57ef413ca 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3758,11 +3758,11 @@ F: docs/devel/migration/
>  F: qapi/migration.json
>  F: tests/migration-stress/
>  F: util/userfaultfd.c
> -X: migration/rdma*
>  
>  RDMA Migration
> +M: Peter Xu <peterx@redhat.com>
> +M: Fabiano Rosas <farosas@suse.de>
>  R: Li Zhijian <lizhijian@fujitsu.com>
> -R: Peter Xu <peterx@redhat.com>
>  S: Odd Fixes
>  F: migration/rdma*
>  F: scripts/rdma-migration-helper.sh
> -- 
> 2.53.0
> 

-- 
Peter Xu


