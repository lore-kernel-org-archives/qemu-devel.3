Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9944C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 19:29:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVyj4-00017S-TM; Mon, 22 Jul 2024 15:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sVyj2-00016w-Rb
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 15:29:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sVyj1-0003iy-9B
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 15:29:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721676572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q93AHWuhBui40teC6Ra0eCzoZ4QRM97QtGRyy9Cingg=;
 b=YndyqRsI5vEebg/XWbUK2yivqBOPXZnruTxF0LItouTDTgYNsJ9dlwfuv19YPS0D1ZrQlQ
 2VFlpWUvbqvBptEIJDKUvmxvCYzP4JircuA+M96CKDOBmQhFg6bDuvaBRnpVsiZRc1WxRf
 SZCbSTnM+bYNgDBL7znuWM0Lm7EnfQQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-wYCEfoPGNJqpLLyN3AnA8A-1; Mon, 22 Jul 2024 15:29:31 -0400
X-MC-Unique: wYCEfoPGNJqpLLyN3AnA8A-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6b95c005dbcso9377186d6.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 12:29:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721676570; x=1722281370;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q93AHWuhBui40teC6Ra0eCzoZ4QRM97QtGRyy9Cingg=;
 b=laPfPf/lyIZsrjayC3V269rBPWzwmjP3Ctf+y/WTGraHIKS6NSmJaToPAb150RcqpE
 53oi2cbUVQnyM42O2hX54GwnLwRs33X0ncaFwA6Dn6SOV15ZtaubW9XDN+LfyHRmVdSp
 knByLAO3gwHn0fGZvil6aLfTfvhLdeVSmWHe3psLi80P7bPvHh1KBKoaIT8W0SsZ7Mus
 CgzhYaRsPBi42YYoNo5u8aN9FdMY8gfCLOuyqcBfmY8UX2THE/TdnrjVAj+W98561p3Z
 16IXRizxA6K04iigxzw0H/NBAf7pv3mWCJ6yS5CRdYfe08mvoCIOZRoX+W6cmOzk6rYy
 Wdgw==
X-Gm-Message-State: AOJu0YzvfY8nR6poH60VCCGZDsI79NVGQO/va3MDqXbj1mDnLgNhMoXT
 /xVx81f2NxrwBOB5LOCdO+0OWpJK72q6MZDKGLJpzGGhUXpYKlfezFFkweeQ5ToQ4OQYsfNpWRf
 bcCNm16v6xp8Z2QJQVzcqfNAMi6S36PR0d1/ZLwkSbMOxz5a8ItpaMPanoF2p
X-Received: by 2002:ac8:5808:0:b0:447:e013:755c with SMTP id
 d75a77b69052e-44fa525dfc1mr71209651cf.4.1721676570108; 
 Mon, 22 Jul 2024 12:29:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpbvI11njvtqvEd8beRQYT8AvYs6Jqf8tSukwYvSgagYUgPAW/7gH6aZLnrL7Nsezcj5Bd7g==
X-Received: by 2002:ac8:5808:0:b0:447:e013:755c with SMTP id
 d75a77b69052e-44fa525dfc1mr71209511cf.4.1721676569648; 
 Mon, 22 Jul 2024 12:29:29 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-44f9cbf236esm35863741cf.13.2024.07.22.12.29.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 12:29:29 -0700 (PDT)
Date: Mon, 22 Jul 2024 15:29:27 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [RFC PATCH v2 6/9] migration/multifd: Move pages accounting into
 multifd_send_zero_page_detect()
Message-ID: <Zp6zF2oOHJMixISu@x1n>
References: <20240722175914.24022-1-farosas@suse.de>
 <20240722175914.24022-7-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240722175914.24022-7-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jul 22, 2024 at 02:59:11PM -0300, Fabiano Rosas wrote:
> All references to pages are being removed from the multifd worker
> threads in order to allow multifd to deal with different payload
> types.
> 
> multifd_send_zero_page_detect() is called by all multifd migration
> paths that deal with pages and is the last spot where zero pages and
> normal page amounts are adjusted. Move the pages accounting into that
> function.

True, but it's a bit hackish to update (especially, normal) page counters
in a zero page detect function.

I understand you want to move pages out of the thread function, that's
fair. How about put it in your new multifd_ram_fill_packet()?

> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/multifd-zero-page.c | 7 ++++++-
>  migration/multifd.c           | 2 --
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/migration/multifd-zero-page.c b/migration/multifd-zero-page.c
> index efc0424f74..899e8864c6 100644
> --- a/migration/multifd-zero-page.c
> +++ b/migration/multifd-zero-page.c
> @@ -14,6 +14,7 @@
>  #include "qemu/cutils.h"
>  #include "exec/ramblock.h"
>  #include "migration.h"
> +#include "migration-stats.h"
>  #include "multifd.h"
>  #include "options.h"
>  #include "ram.h"
> @@ -53,7 +54,7 @@ void multifd_send_zero_page_detect(MultiFDSendParams *p)
>  
>      if (!multifd_zero_page_enabled()) {
>          pages->normal_num = pages->num;
> -        return;
> +        goto out;
>      }
>  
>      /*
> @@ -74,6 +75,10 @@ void multifd_send_zero_page_detect(MultiFDSendParams *p)
>      }
>  
>      pages->normal_num = i;
> +
> +out:
> +    stat64_add(&mig_stats.normal_pages, pages->normal_num);
> +    stat64_add(&mig_stats.zero_pages, pages->num - pages->normal_num);
>  }
>  
>  void multifd_recv_zero_page_process(MultiFDRecvParams *p)
> diff --git a/migration/multifd.c b/migration/multifd.c
> index f64b053e44..fcdb12e04f 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -972,8 +972,6 @@ static void *multifd_send_thread(void *opaque)
>  
>              stat64_add(&mig_stats.multifd_bytes,
>                         p->next_packet_size + p->packet_len);
> -            stat64_add(&mig_stats.normal_pages, pages->normal_num);
> -            stat64_add(&mig_stats.zero_pages, pages->num - pages->normal_num);
>  
>              multifd_pages_reset(pages);
>              p->next_packet_size = 0;
> -- 
> 2.35.3
> 

-- 
Peter Xu


