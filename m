Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43BBFC5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 23:01:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwSnp-0004yr-4C; Tue, 18 Aug 2026 19:01:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1wwSnn-0004yL-TI
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:01:03 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1wwSnl-0005ai-V9
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:01:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=EBu674DVp/U+9wb4LFbxsduWvVwTbiz0YJGVDUWBhTc=; b=I7am1WzK5A4JO5Lz
 69/hOMkC3LGdzh4GHij41lCMMIizZp0cdG7wVNW6yXkjtZBVA5Zrri+itjYHhIqVJ14OAEKEhNtwL
 qnFYEZv83Nb0uYkgPfpPeqrEBpMcX6ocxgONV3jqMSI/q3wfoF7NeJIAXaMhGfqKoNC5dEFxcHwQz
 ojTx+CiFIOREyTNIC+GB/+ypiqrc3qmZhLy/6lD0CI3mbpM5y6xPK2aI2eViLUJ4Gy4w1Bef9CxpJ
 oLoPljsLYAz/UrBzVSmFbeum/69DpE1hw2YNgIucuqSB6MQmpw6ocEYtbEUe2Nu8nstSS1t71EmFi
 +d+ImfwoLtu3Jh7nEw==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1wwSnh-00000002zcp-1POU;
 Tue, 18 Aug 2026 23:00:57 +0000
Date: Tue, 18 Aug 2026 23:00:57 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH v2] target/hexagon: Add HMP info tlb command
Message-ID: <aoTkKdqA7Erso4Sk@gallifrey>
References: <20260818203047.2933487-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260818203047.2933487-1-brian.cain@oss.qualcomm.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.101+deb13-amd64 (x86_64)
X-Uptime: 23:00:52 up 12 days,  2:38,  2 users,  load average: 0.00, 0.00, 0.00
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

* Brian Cain (brian.cain@oss.qualcomm.com) wrote:
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>

Acked-by: Dr. David Alan Gilbert <dave@treblig.org>

> ---
>  target/hexagon/hmp-cmds.c  | 23 +++++++++++++++++++++++
>  hmp-commands-info.hx       |  3 ++-
>  target/hexagon/meson.build |  1 +
>  3 files changed, 26 insertions(+), 1 deletion(-)
>  create mode 100644 target/hexagon/hmp-cmds.c
> 
> diff --git a/target/hexagon/hmp-cmds.c b/target/hexagon/hmp-cmds.c
> new file mode 100644
> index 00000000000..150045769cc
> --- /dev/null
> +++ b/target/hexagon/hmp-cmds.c
> @@ -0,0 +1,23 @@
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "cpu.h"
> +#include "hex_mmu.h"
> +#include "monitor/hmp.h"
> +#include "monitor/monitor.h"
> +
> +void hmp_info_tlb(Monitor *mon, const QDict *qdict)
> +{
> +    CPUArchState *env = mon_get_cpu_env(mon);
> +
> +    if (!env) {
> +        monitor_printf(mon, "No CPU available\n");
> +        return;
> +    }
> +
> +    dump_mmu(mon, env);
> +}
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index 82134eb6c21..0d31fb8a84c 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -193,7 +193,8 @@ ERST
>          .help       = "show virtual to physical memory mappings",
>          .cmd        = hmp_info_tlb,
>          .arch_bitmask = QEMU_ARCH_I386 | QEMU_ARCH_SH4 | QEMU_ARCH_SPARC \
> -                        | QEMU_ARCH_PPC | QEMU_ARCH_XTENSA | QEMU_ARCH_M68K,
> +                        | QEMU_ARCH_PPC | QEMU_ARCH_XTENSA | QEMU_ARCH_M68K \
> +                        | QEMU_ARCH_HEXAGON,
>      },
>  
>  SRST
> diff --git a/target/hexagon/meson.build b/target/hexagon/meson.build
> index 4c921eee73b..53c500522a8 100644
> --- a/target/hexagon/meson.build
> +++ b/target/hexagon/meson.build
> @@ -261,6 +261,7 @@ hexagon_softmmu_ss.add(files(
>      'hex_interrupts.c',
>      'hexswi.c',
>      'machine.c',
> +    'hmp-cmds.c',
>  ))
>  
>  #
> -- 
> 2.34.1
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

