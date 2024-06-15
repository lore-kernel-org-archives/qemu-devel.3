Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F52CC27C4F
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2024 23:56:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sIdFQ-0001bt-9D; Sat, 15 Jun 2024 19:55:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1sIdFM-0001au-75; Sat, 15 Jun 2024 19:55:48 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1sIdFK-0000aK-2x; Sat, 15 Jun 2024 19:55:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=q8pHLb4NS79pOg3qhGn+hXWfgBDpH6U6Cngkex8HSWU=; b=T89SOEdPYMukbcr6
 E9R5KkBndFedJB6tuVK6kLwDx8JrwU7ph75bASyCau1l7KOpOL7DR4cAhBljlvaCcrpJCk7ZoVWQP
 3pirWQQ3uBYoj6sDf6XYufyEdZiPYn3LKgbGx4BhZisSsK8JlCatIzARu0A0QKamCUza2tVHTMOOv
 heqgk9C6CWNi722EzFByfC/CtNrNJJebephaPfUI5VsH5uah0E9nDFI9EKukCclOsmUeEEi6HV/yA
 wbJ2O5NoCXXjih652TX3xHl/lSS9QPPKeH4RYxut6+ZrZhI7Fb6qydhhD1XUT+3TFJX2E+oCbmDsc
 ONdupFxIkjQju6yN6w==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1sIdFG-006RFN-0k;
 Sat, 15 Jun 2024 23:55:42 +0000
Date: Sat, 15 Jun 2024 23:55:42 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Martin Joerg <martin.joerg@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Subject: Re: [PATCH] hmp-commands-info.hx: Add missing info command for stats
 subcommand
Message-ID: <Zm4p_kmbp8lh6rFF@gallifrey>
References: <20240615114323.30550-1-martin.joerg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20240615114323.30550-1-martin.joerg@gmail.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 23:55:04 up 38 days, 11:09, 1 user, load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

* Martin Joerg (martin.joerg@gmail.com) wrote:
> Signed-off-by: Martin Joerg <martin.joerg@gmail.com>

Thanks!
(Trivial please take that).

Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>

> ---
>  hmp-commands-info.hx | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index 20a9835ea8..f5639af517 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -892,7 +892,7 @@ ERST
>      },
>  
>  SRST
> -  ``stats``
> +  ``info stats``
>      Show runtime-collected statistics
>  ERST
>  
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

