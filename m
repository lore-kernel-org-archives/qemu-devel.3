Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14DC3C4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 04:46:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXZpB-0002At-8D; Tue, 06 Feb 2024 23:46:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXZp9-0002AQ-Mw
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 23:46:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXZp8-00060b-4W
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 23:46:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707281172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rJksiMIStA1V6HBjAmV7T4ik9n6eoPP+xaYeH93A308=;
 b=fZVorDoZWgfS9vwGrxMVAlyAp+5mqHEKl5fBySNbVAZppfaSv2rYri0ypAFpNEE/ibrKU7
 LqtFXQ+5Rdorp5AyhokkTim4OdA9zLivkXVrRmNDmoCO1+7Yh3yhzVHhoC8+OLUbmxYJIG
 fkzZYrjWm7eTCSnfqwFl7GSD+ti64Ag=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-pZOCwzJQPva77Jgo_BZ7ow-1; Tue, 06 Feb 2024 23:46:06 -0500
X-MC-Unique: pZOCwzJQPva77Jgo_BZ7ow-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-6da5a9defd5so93908b3a.0
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 20:46:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707281165; x=1707885965;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rJksiMIStA1V6HBjAmV7T4ik9n6eoPP+xaYeH93A308=;
 b=U1VzaYt/NrBC8fpse9m/fIzK46yx8c07imO4AGQLXkbIkscCp2rc7oqXVYsakXgZv+
 FO5tfMvMG38qLnZPktdA62flnPDv/71u8JK40JQ2LZdEpU21PC/t+q7hHcT3GyOBBoFJ
 syX8IJ2HixxB4DsAHn+xnvNtu5rCt0/HHh8v8goR3tkVp7IebFTRhNh2If6HitEljElY
 6cjJO7WQkuVYxkcrCoXSfzsYKeBJhGH3dZ8LXk6Lvzz5MzaxS8E8VMQt7q/zInM9kzZs
 fwmb56a4i1hpFkaieuVXJXZ3LyS0MJ5UhFgAvl8x0r6FYfWl50F2wIfROU2vd3s2qI8B
 ur1A==
X-Gm-Message-State: AOJu0YyMezcsEL4w8VyQ6hDiJDgUSmnzB081yb8iRtgasdUuzP0o+axz
 TmG99nu2H5RrVf5gnKth0ebLbAbLCfmD7jqTSQa/TJGIz1Ms2ZVwHgEB0UgKy1ZHNf6T7opkEQ4
 jANrXxM9nuMr2ADv9qtEYm5aGaFkWItmBL99ezC35/YpPhevPzDAq
X-Received: by 2002:a05:6a21:9986:b0:19c:a1b6:58c6 with SMTP id
 ve6-20020a056a21998600b0019ca1b658c6mr5191597pzb.6.1707281165133; 
 Tue, 06 Feb 2024 20:46:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE56khvoanGPkFUcFrxTgxM31E9FeJCgHgzUaLC/qt56j9WSl5oBIwCfczG7xU0keVwy+f1Xw==
X-Received: by 2002:a05:6a21:9986:b0:19c:a1b6:58c6 with SMTP id
 ve6-20020a056a21998600b0019ca1b658c6mr5191574pzb.6.1707281164827; 
 Tue, 06 Feb 2024 20:46:04 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXxUafgPRqdaZUZGSwEATMg8DWIOqxMzAZLnrithiuay6ACjjoiZfaMEC6aDmNhVu7t8FF8CY0uM1yuXVnec5M=
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 sk8-20020a17090b2dc800b0029619c8fa15sm480897pjb.27.2024.02.06.20.46.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 20:46:04 -0800 (PST)
Date: Wed, 7 Feb 2024 12:45:58 +0800
From: Peter Xu <peterx@redhat.com>
To: Hao Xiang <hao.xiang@bytedance.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de
Subject: Re: [PATCH 4/6] migration/multifd: Zero page transmission on the
 multifd thread.
Message-ID: <ZcMLBlQDiL-avbNy@x1n>
References: <20240206231908.1792529-1-hao.xiang@bytedance.com>
 <20240206231908.1792529-5-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240206231908.1792529-5-hao.xiang@bytedance.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SORBS_WEB=1.5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Tue, Feb 06, 2024 at 11:19:06PM +0000, Hao Xiang wrote:
> This implements the zero page detection and handling on the multifd
> threads.
> 
> Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> ---
>  migration/multifd.c | 62 +++++++++++++++++++++++++++++++++++++++++----
>  migration/multifd.h |  5 ++++
>  2 files changed, 62 insertions(+), 5 deletions(-)
> 
> diff --git a/migration/multifd.c b/migration/multifd.c
> index a20d0ed10e..c031f947c7 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -11,6 +11,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/cutils.h"
>  #include "qemu/rcu.h"
>  #include "exec/target_page.h"
>  #include "sysemu/sysemu.h"
> @@ -278,6 +279,12 @@ static void multifd_send_fill_packet(MultiFDSendParams *p)
>  
>          packet->offset[i] = cpu_to_be64(temp);
>      }
> +    for (i = 0; i < p->zero_num; i++) {
> +        /* there are architectures where ram_addr_t is 32 bit */
> +        uint64_t temp = p->zero[i];
> +
> +        packet->offset[p->normal_num + i] = cpu_to_be64(temp);
> +    }
>  }

Please be noted taht p->normal_num will be dropped very soon, see:

https://lore.kernel.org/all/20240202102857.110210-6-peterx@redhat.com/

Please use p->pages->num instead.

This patch also relies on some changes in previous patch.. IMHO we can
split the patch better in this way:

  - Patch 1: Add new parameter "zero-page-detection", support "none",
    "legacy".  You'll need to implement "none" here that we skip zero page
    by returning 0 in save_zero_page() if "none".

  - Patch 2: Add new "multifd" mode in above, implement it in the same
    patch completely.

  - Patch 3: introduce ram_save_target_page_multifd()

  - Patch 4: test case

If you want to add "zeros" accounting, that can be done as more patches on
top.

Thanks,

-- 
Peter Xu


