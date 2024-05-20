Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 792E2C04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 13:23:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s92yX-0002Lb-B0; Mon, 20 May 2024 09:22:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1s92yV-0002LM-Nq
 for qemu-devel@nongnu.org; Mon, 20 May 2024 09:22:47 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1s92yT-0002CA-AK
 for qemu-devel@nongnu.org; Mon, 20 May 2024 09:22:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=7J+aUvKve4WD2pVqsqlD4/7ojZQzYihNA+giBNhNDU0=; b=lM3/mu675yjNSGyP
 4TlKEah8BgHK2fEWPNS0jS8JMsNJ5WcZGdjYgA3LkIuDlML5D7RKt6YfYZmEUb1cvsNET72gEtyJ0
 rm+QjXHMKE0ZPmPotnSwN0D5vRRD09R6lYq3AWKOXzMUkzdQUHiI/9HjsS9SIByK9LDXA7EW2XzZU
 NmmQ+R/aJSw0/g91WirpEyIMiSv06DnxzOo/zOMv2pi+zCt0aZHb/IcsZtIskXrKDCwNGWguOX8zT
 xTLr41jIvAPnhbo4llHMDuzxZ0Up/A7vKickeKR1RN7hGEKI18PQp2rez2p3tCQXKdDRwsNkadRvx
 0qrEoSZqkM3qxDQIow==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1s92yN-001gSg-1v;
 Mon, 20 May 2024 13:22:39 +0000
Date: Mon, 20 May 2024 13:22:39 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: peter.maydell@linaro.org, laurent@vivier.eu,
 mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 3/7] linux-user: sparc: Remove unused struct 'target_mc_fq'
Message-ID: <ZktOn_j2dDdDZclF@gallifrey>
References: <20240505171444.333302-1-dave@treblig.org>
 <20240505171444.333302-4-dave@treblig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20240505171444.333302-4-dave@treblig.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 13:21:51 up 12 days, 35 min,  1 user,  load average: 0.04, 0.04, 0.01
User-Agent: Mutt/2.2.12 (2023-09-09)
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

* Dr. David Alan Gilbert (dave@treblig.org) wrote:
> This struct is unused since Peter's
> Commit b8ae597f0e6d ("linux-user/sparc: Fix errors in target_ucontext
> structures")
> 
> However, hmm, I'm a bit confused since that commit modifies the
> structure and then removes it, was that intentional?

Ping on this.
(I think the others in the set have been reviewed and one picked up).

Dave

> Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
> ---
>  linux-user/sparc/signal.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/linux-user/sparc/signal.c b/linux-user/sparc/signal.c
> index f164b74032..8181b8b92c 100644
> --- a/linux-user/sparc/signal.c
> +++ b/linux-user/sparc/signal.c
> @@ -546,11 +546,6 @@ void setup_sigtramp(abi_ulong sigtramp_page)
>  typedef abi_ulong target_mc_greg_t;
>  typedef target_mc_greg_t target_mc_gregset_t[SPARC_MC_NGREG];
>  
> -struct target_mc_fq {
> -    abi_ulong mcfq_addr;
> -    uint32_t mcfq_insn;
> -};
> -
>  /*
>   * Note the manual 16-alignment; the kernel gets this because it
>   * includes a "long double qregs[16]" in the mcpu_fregs union,
> -- 
> 2.45.0
> 
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

