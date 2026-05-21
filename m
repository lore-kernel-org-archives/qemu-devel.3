Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C35CD5BA4
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 11:37:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ1i2-0000Tz-SR; Thu, 21 May 2026 07:37:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1wQ1i1-0000Tm-6l
 for qemu-devel@nongnu.org; Thu, 21 May 2026 07:37:01 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1wQ1hy-0007Jf-Jg
 for qemu-devel@nongnu.org; Thu, 21 May 2026 07:37:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=6rbqKuAYSVMfINFaSE7h8eYm9kmCOkh+ab4/cd2iWXw=; b=GJQVjFdiYh0xJgU7
 JzXCRVtDfWkQO3p/ZtOjCfL1KsTsozAHD28PNKP/QVjqczjC9IqN1LCpuKgRSuvNjrHVmFfn/fWOc
 /AGziXHlf4bkB8N7BqIEzt4pIqri5+T4ahqtfPYDbhzt81PN/I6Cn2S4sj0+wKrRvHvQ5ml/5OKox
 +IV3oxT+CsRZcZ20jEpPAu7y4eLOw9gX8y6dioMm6xgyCGH//OSzw8muDbQrd7jIyCrp5/tnSEsgQ
 1Ihep1zzO2IVkYyGeFusB22/eOYsODszyuyZEn88RCjmo+RaEjoYJkGXi6FnVtKn4V84s5LL0h0Rw
 aNxjXnbxmYXh9aHHEw==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1wQ1hu-00000001ZzG-2Dw1;
 Thu, 21 May 2026 11:36:54 +0000
Date: Thu, 21 May 2026 11:36:54 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, pierrick.bouvier@oss.qualcomm.com
Subject: Re: [PATCH 29/39] MAINTAINERS: Drop stale F: from "Human Monitor
 (HMP)"
Message-ID: <ag7uVlPotmcl5wRI@gallifrey>
References: <20260521080511.999266-1-armbru@redhat.com>
 <20260521080511.999266-30-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20260521080511.999266-30-armbru@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.88+deb13-amd64 (x86_64)
X-Uptime: 11:36:49 up 5 days, 14:49, 2 users, load average: 0.00, 0.03, 0.00
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

* Markus Armbruster (armbru@redhat.com) wrote:
> We neglected to update MAINTAINERS when we moved hmp.h to
> include/monitor/.  Commit 17dc3ae3e1 (monitor: Extract completion
> declarations to 'monitor/hmp-completion.h', 2026-03-20) added the
> missing entry without deleting the stale one.  Do that now.
> 
> Fixes: 275307aaab (hmp: Move hmp.h to include/monitor/, 2019-06-19)
> Cc: Dr. David Alan Gilbert <dave@treblig.org>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>

> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 95dbd663d4..abffa4730e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3418,7 +3418,6 @@ S: Maintained
>  F: monitor/monitor-internal.h
>  F: monitor/monitor.c
>  F: monitor/hmp*
> -F: hmp.h
>  F: hmp-commands*.hx
>  F: include/monitor/hmp.h
>  F: include/monitor/hmp-completion.h
> -- 
> 2.54.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

