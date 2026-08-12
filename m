Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F204C5AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 23:27:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuIKm-0001Ld-Es; Wed, 12 Aug 2026 19:26:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1wuIKl-0001LN-MM
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 19:26:07 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1wuIKj-0000mZ-Me
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 19:26:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=814ktgYfJvXgOQViJ4hKgxOmwA9LvxzuuTfYJqXN6GQ=; b=tI6VgY6fQEYchxaZ
 IpRdkXvHJ35wGU8ryMbDIqyn63/hqIKg/fLWnZqggIYZrn7sBsXjP7wcIPqNiXURfFJwGzf5GB8+s
 EBGq00vUvE2LS0OSD9+UntuaGn97YwUSb9yVeHzYc9Vs/jDlWd0JeOxzRKOAI2gWon5kMvA2HUHso
 tbw8peIZ6R3k6+r13acmDe7nlDx48xdCiH7V8ypyvGUIVm5vU+si7Jdssk2SA0bN8jC8w3pV95Dmf
 3yLMqZlMHsz2j71gkgSfn242KG7zdfaZPsK0zOA6dGRqTQxbb9l2Ltjo++iya5GqZ1Rm+6Yrz/4Us
 OLO720P/mFnTZJ2eUQ==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1wuIKe-00000001bAS-0cwI;
 Wed, 12 Aug 2026 23:26:00 +0000
Date: Wed, 12 Aug 2026 23:26:00 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v3 06/23] migration/hmp-cmds: Include
 'block/block-global-state.h' header
Message-ID: <an0BCHXDCq9H-7Ab@gallifrey>
References: <20260812211708.92824-1-philmd@oss.qualcomm.com>
 <20260812211708.92824-7-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260812211708.92824-7-philmd@oss.qualcomm.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.101+deb13-amd64 (x86_64)
X-Uptime: 23:25:53 up 6 days, 3:03, 3 users, load average: 0.01, 0.02, 0.00
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

* Philippe Mathieu-Daudé (philmd@oss.qualcomm.com) wrote:
> migration-hmp-cmds.c uses types / methods declared in
> "block/block-global-state.h".  Include the latter otherwise
> we get when refactoring unrelated headers:
> 
>   ../migration/migration-hmp-cmds.c:911:5: error: use of undeclared identifier 'BdrvNextIterator'
>     911 |     BdrvNextIterator it;
>         |     ^
>   ../migration/migration-hmp-cmds.c:918:15: error: call to undeclared function 'bdrv_first'
>     918 |     for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
>         |               ^
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>

> ---
>  migration/migration-hmp-cmds.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index b04fc4489f4..351512942af 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -15,6 +15,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "block/qapi.h"
> +#include "block/block-global-state.h"
>  #include "migration/snapshot.h"
>  #include "monitor/hmp.h"
>  #include "monitor/hmp-completion.h"
> -- 
> 2.53.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

