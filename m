Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43797C5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 19:19:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwlp2-000112-53; Wed, 19 Aug 2026 15:19:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wwlp0-00010o-NT
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 15:19:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wwloz-0003Tc-8L
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 15:19:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787167172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Eb74DaZdtuRgyTn6aQ9yEGgldigdTcve98YP8+b8+3I=;
 b=XlmuL6bFkdyCb/8TH+4qt/XBTbRB3nZsq5D+nJ0CQALuPsar0DMiuBFWl6burgViR0W2zN
 AA2jCWO4ac76XLxU9Mhr3Pgr85G51exxNVYOOyv3gvx7Ct5VpVMt7+FNRo79QBYDI+gKXX
 T45cLG5RqCrpSv7+A0pn5yukZELfC5g=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-bKMta55cOUOB6QpgSn8qzQ-1; Wed, 19 Aug 2026 15:19:20 -0400
X-MC-Unique: bKMta55cOUOB6QpgSn8qzQ-1
X-Mimecast-MFC-AGG-ID: bKMta55cOUOB6QpgSn8qzQ_1787167160
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c26012cd0so15091851cf.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 12:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787167160; x=1787771960; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Eb74DaZdtuRgyTn6aQ9yEGgldigdTcve98YP8+b8+3I=;
 b=mvr4LoruEhBj1EeKMa3boIrYGQFS2ftpX6UjdK6sIZDbLDVvgyawRD85yrMEqQA+i9
 NGN+BjPFW3Gz4OJzyO8S5VNk5LHySKxRRvFQGcARD5oARFrfc/oc18VGk3pwnVyBUZF0
 TTLKY7rII7KODPSPIHAdUsPp1PSqBwSTPEt3ufT6bUHMGzTz/EvTk5DrrCELXAdYmn8a
 PBiJXo0M0OPCC7f/tQWeakcuORHiaCmAyDWY5ncjCJcrsQRJuK/g3EnBg3tUR7OgH3Bm
 F7X7347bkcyFl3UYVxtbdebazpgXVGRKmyf+W+rUCgiedBgSXAA9D76UkgiQZiqOULv1
 MlGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787167160; x=1787771960;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Eb74DaZdtuRgyTn6aQ9yEGgldigdTcve98YP8+b8+3I=;
 b=r1WPK2cuWYray5c0ClH6eVsAxye+cB/8MfWqPi1gee0vip1IBG+k+N90fltzLwwDeB
 i5/A96ku2fi/rGTwsKVEBTwJMc0VnOHB/Pg3Z+UZcnYAHO7W08IJgPddstUewoFnIPjk
 tPDHkaohEUGrYpEPhOxsRzMFR0oZokGA2UwDHoIvb61vPciKgC5EEjd5zO7FbL4UBtAG
 7B50n1yJ3l6xBnUd76F4xYTlzmUNB5xfLLxtIG4C7svw316SrDH1I1LTp1hhXtkZu9Pr
 ppflT1CxO/xJHlvSS49CYXCbJpUgPG77LZCo/pwHGJ0pnSR7sgISX275QesB2QIuS7Ql
 8TKQ==
X-Gm-Message-State: AOJu0YwVk3uapAJH/6cXETk8nG4+83ej01ifHPsrpAl7ncAatM1Me0XU
 n/eUmIlv1skswTo6Kn8p1PlvoGSoUe8C37w06ADNZWkxGT62CyP4Hv6J75vpWivDEGpaI9bqlR0
 Pq/O0hbCGCNtvOJpou7cduJ37r5z/2CA7CnExXlc6CCfyWpwLzBW3/0yT
X-Gm-Gg: AR+sD137k+AeQF4RyXhBqneSd3Ft/xIsmU+GN0hk+9LNaf2ZyVLPYAQR9hk+Oj2+u+v
 xeswvuUwLoZTy8LPjtDstTg/QQ1HMZ6EVMeVy5sFq2DUUBMF9Efz+qvCxkQDUxIa7PWbGs3KKoZ
 8bXTBHgNd185uyxBVgvRLlMyls9WkBml1if7Gs9TR0g0P27xmn2FO8oddDxs8JAmaNHTHHRe4W9
 5bI4FlqvwEyoGATO9HhhpsuteTdOVgWaaOO9JtNe/ZuojpoB+SxbRKYJBNWBGQMr3xZEqMolPo4
 xDOGrblscMJtXrqgrmEHOa1Ne1MOJUg4V8Fx27helPozkiSEM+e53nVRii7lvdePhIxf
X-Received: by 2002:ac8:5984:0:b0:519:efea:cf41 with SMTP id
 d75a77b69052e-52dd5a35101mr63226711cf.28.1787167160195; 
 Wed, 19 Aug 2026 12:19:20 -0700 (PDT)
X-Received: by 2002:ac8:5984:0:b0:519:efea:cf41 with SMTP id
 d75a77b69052e-52dd5a35101mr63226211cf.28.1787167159652; 
 Wed, 19 Aug 2026 12:19:19 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52dd85991b1sm16835141cf.10.2026.08.19.12.19.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 12:19:19 -0700 (PDT)
Date: Wed, 19 Aug 2026 15:19:16 -0400
From: Peter Xu <peterx@redhat.com>
To: Yanfei Xu <yanfei.xu@bytedance.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, lizhijian@fujitsu.com
Subject: Re: [PATCH 1/3] migration/rdma: Fix write-side shutdown
Message-ID: <aoYBtFI-eJpLm35D@x1.local>
References: <20260817105117.3072040-1-yanfei.xu@bytedance.com>
 <20260817105117.3072040-2-yanfei.xu@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260817105117.3072040-2-yanfei.xu@bytedance.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Aug 17, 2026 at 06:51:15PM +0800, Yanfei Xu wrote:
> qio_channel_rdma_shutdown() reads rdmain for both the input and
> output contexts.  As a result, a write-side shutdown marks the input
> context as errored while leaving the output context active.  A shutdown
> of both directions also fails to stop the output context.
> 
> Read rdmaout from the output context so each shutdown direction marks
> the corresponding RDMA context as errored.
> 
> Fixes: 54db882f073a ("migration: implement the shutdown for RDMA QIOChannel")
> Signed-off-by: Yanfei Xu <yanfei.xu@bytedance.com>
> ---
>  migration/rdma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 438419d189..e17ace62b0 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -2982,7 +2982,7 @@ qio_channel_rdma_shutdown(QIOChannel *ioc,
>      RCU_READ_LOCK_GUARD();
>  
>      rdmain = qatomic_rcu_read(&rioc->rdmain);
> -    rdmaout = qatomic_rcu_read(&rioc->rdmain);
> +    rdmaout = qatomic_rcu_read(&rioc->rdmaout);
>  
>      switch (how) {
>      case QIO_CHANNEL_SHUTDOWN_READ:
> -- 
> 2.20.1
> 

I recall there was a patch like this somewhere, looks like we missed that..

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


