Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4912D185F0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 12:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdpRR-0007Qh-Hk; Thu, 08 Jan 2026 07:48:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1vdpRO-0007MP-MM
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 07:48:38 -0500
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1vdpRM-0003It-To
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 07:48:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=GIxytoyq7LeQI+Xt2xX3VTAop32280JJ+Sj2QXD6TI0=; b=Ian0Y6xQtVMsrN7I
 tEqLgpDUMxMak9+G5Nxw4ReAUuut061CfPKzwoZZFdkiAdVrHxtI8Vv9RHwgY8y55Lp95qvyqhCxa
 67v3daOOd/zcD3YOssoYHj2NGOG1gfjZJ6O1VuvQSUTfk68egOYMJARJmBVcc+d7K8g+PJQVC5VIZ
 mL+V2HnIcHVUeSzYie6UUveZvtbEaKCJ08KYImROXxk99czog3qMm9HDnGwlQczBxYcfgaK1DeCCs
 zP0mTmmT0yfgq8CK7a0ZPE8CtPYR//0Vh4vxVXGC+5lqsjbrXVWOmqELWW8A55Qum+1WRtm12lbOj
 M+znmD0w0sMmdu/rww==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1vdpRG-0000000DFVC-3P0V;
 Thu, 08 Jan 2026 12:48:30 +0000
Date: Thu, 8 Jan 2026 12:48:30 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org
Subject: Re: [PATCH] hmp-commands-info.hx: Move definition of "info accel"
Message-ID: <aV-nngX2HxJlxcfv@gallifrey>
References: <20260108083249.1602654-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20260108083249.1602654-1-armbru@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.48+deb13-amd64 (x86_64)
X-Uptime: 12:48:22 up 73 days, 12:24,  2 users,  load average: 0.00, 0.01, 0.00
User-Agent: Mutt/2.2.13 (2024-03-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

* Markus Armbruster (armbru@redhat.com) wrote:
> Commit c10eb740108 (accel/system: Add 'info accel' on human monitor)
> inserted "info accel" in the middle of "info sync-profile".  Move it
> behind "info sync-profile".
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Thanks!


Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>

> ---
>  hmp-commands-info.hx | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index 41674dcbe1..74c741f80e 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -267,18 +267,6 @@ ERST
>          .cmd        = hmp_info_sync_profile,
>      },
>  
> -    {
> -        .name       = "accel",
> -        .args_type  = "",
> -        .params     = "",
> -        .help       = "show accelerator statistics",
> -    },
> -
> -SRST
> -  ``info accel``
> -    Show accelerator statistics.
> -ERST
> -
>  SRST
>    ``info sync-profile [-m|-n]`` [*max*]
>      Show synchronization profiling info, up to *max* entries (default: 10),
> @@ -294,6 +282,18 @@ SRST
>      being coalesced.
>  ERST
>  
> +    {
> +        .name       = "accel",
> +        .args_type  = "",
> +        .params     = "",
> +        .help       = "show accelerator statistics",
> +    },
> +
> +SRST
> +  ``info accel``
> +    Show accelerator statistics.
> +ERST
> +
>      {
>          .name       = "kvm",
>          .args_type  = "",
> -- 
> 2.52.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

