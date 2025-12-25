Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77118E78498
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Dec 2025 00:40:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYZOt-00069r-5p; Wed, 24 Dec 2025 19:40:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1vYZOq-00068n-UF
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 19:40:16 -0500
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1vYZOk-0006bZ-JO
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 19:40:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=3DiUshcxOurNrO/X0nEGqOTynTWZlY3hzScUZK9itfc=; b=El59RsVOc3IgwoC6
 +jxHBvF1YpC0XeZX4MN4QR/7bKAsWB/B2n7mIGrCm7tSKQK13VLptPc/d1vXAeQCzCG/xgHwOcme7
 hVukW6uMK63/4CSKYM5x80R1LPYDhe9ZRrqU+Gpelb6NDgQ/tNY3xOFacUtbVgofUorUOhcUqbp1K
 pACGR7ZZh00wgn/yWvNueAf5NPMIMTWRrY99+fwZAoS7HYlKqoCu/n04Fq9Rkr0cwtg8/a3QmfJOD
 1fqXMMUEGznDt4SkUIQemhn7F6xQOVqX+K/Pt+FYFIfpsiAwT97FTpDM3j9TKK5qGJASVMhBT2kgi
 2vPwyRgFAWDrFScMvQ==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1vYZOd-0000000BFj4-0KC7;
 Thu, 25 Dec 2025 00:40:03 +0000
Date: Thu, 25 Dec 2025 00:40:03 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: Re: [PATCH 5/6] monitor/hmp: Fix coding style in hmp-cmds-target.c
Message-ID: <aUyH4-r1cCT2bMAh@gallifrey>
References: <20251224133949.85136-1-philmd@linaro.org>
 <20251224133949.85136-6-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251224133949.85136-6-philmd@linaro.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.48+deb13-amd64 (x86_64)
X-Uptime: 00:39:56 up 59 days, 16 min,  3 users,  load average: 0.00, 0.00,
 0.00
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

* Philippe Mathieu-Daudé (philmd@linaro.org) wrote:
> Previous to moving code contained in hmp-cmds-target.c,
> fix the coding style. Otherwise the checkpatch.pl script
> would report:

Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>

> 
>   ERROR: space required before the open parenthesis '('
>   #134: FILE: monitor/hmp-cmds-target.c:152:
>   +    switch(format) {
> 
>   ERROR: braces {} are necessary for all arms of this statement
>   #154: FILE: monitor/hmp-cmds-target.c:172:
>   +        if (l > line_size)
>   [...]
> 
>   ERROR: space required before the open parenthesis '('
>   #172: FILE: monitor/hmp-cmds-target.c:190:
>   +            switch(wsize) {
> 
>   ERROR: space required before the open parenthesis '('
>   #188: FILE: monitor/hmp-cmds-target.c:206:
>   +            switch(format) {
> 
>   ERROR: Don't use '#' flag of printf format ('%#') in format strings, use '0x' prefix instead
>   #190: FILE: monitor/hmp-cmds-target.c:208:
>   +                monitor_printf(mon, "%#*" PRIo64, max_digits, v);
> 
>   WARNING: line over 80 characters
>   #240: FILE: monitor/hmp-cmds-target.c:258:
>   +        error_setg(errp, "No memory is mapped at address 0x%" HWADDR_PRIx, addr);
> 
>   WARNING: line over 80 characters
>   #245: FILE: monitor/hmp-cmds-target.c:263:
>   +        error_setg(errp, "Memory at address 0x%" HWADDR_PRIx " is not RAM", addr);
> 
>   ERROR: Don't use '#' flag of printf format ('%#') in format strings, use '0x' prefix instead
>   #297: FILE: monitor/hmp-cmds-target.c:315:
>   +        monitor_printf(mon, "gpa: %#" HWADDR_PRIx "\n",
> 
>   WARNING: line over 80 characters
>   #329: FILE: monitor/hmp-cmds-target.c:347:
>   +    ret = ((pinfo & 0x007fffffffffffffull) * pagesize) | (addr & (pagesize - 1));
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  monitor/hmp-cmds-target.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
> index efab133cf2f..48c21559156 100644
> --- a/monitor/hmp-cmds-target.c
> +++ b/monitor/hmp-cmds-target.c
> @@ -149,7 +149,7 @@ static void memory_dump(Monitor *mon, int count, int format, int wsize,
>      }
>      max_digits = 0;
>  
> -    switch(format) {
> +    switch (format) {
>      case 'o':
>          max_digits = DIV_ROUND_UP(wsize * 8, 3);
>          break;
> @@ -169,8 +169,9 @@ static void memory_dump(Monitor *mon, int count, int format, int wsize,
>      while (len > 0) {
>          monitor_printf(mon, "%0*" PRIx64 ":", addr_width, addr);
>          l = len;
> -        if (l > line_size)
> +        if (l > line_size) {
>              l = line_size;
> +        }
>          if (is_physical) {
>              AddressSpace *as = cs ? cs->as : &address_space_memory;
>              MemTxResult r = address_space_read(as, addr,
> @@ -187,7 +188,7 @@ static void memory_dump(Monitor *mon, int count, int format, int wsize,
>          }
>          i = 0;
>          while (i < l) {
> -            switch(wsize) {
> +            switch (wsize) {
>              default:
>              case 1:
>                  v = ldub_p(buf + i);
> @@ -203,9 +204,9 @@ static void memory_dump(Monitor *mon, int count, int format, int wsize,
>                  break;
>              }
>              monitor_printf(mon, " ");
> -            switch(format) {
> +            switch (format) {
>              case 'o':
> -                monitor_printf(mon, "%#*" PRIo64, max_digits, v);
> +                monitor_printf(mon, "0%*" PRIo64, max_digits, v);
>                  break;
>              case 'x':
>                  monitor_printf(mon, "0x%0*" PRIx64, max_digits, v);
> @@ -255,12 +256,14 @@ void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, uint64_t size, Error **errp)
>                                                   addr, size);
>  
>      if (!mrs.mr) {
> -        error_setg(errp, "No memory is mapped at address 0x%" HWADDR_PRIx, addr);
> +        error_setg(errp,
> +                   "No memory is mapped at address 0x%" HWADDR_PRIx, addr);
>          return NULL;
>      }
>  
>      if (!memory_region_is_ram(mrs.mr) && !memory_region_is_romd(mrs.mr)) {
> -        error_setg(errp, "Memory at address 0x%" HWADDR_PRIx " is not RAM", addr);
> +        error_setg(errp,
> +                   "Memory at address 0x%" HWADDR_PRIx " is not RAM", addr);
>          memory_region_unref(mrs.mr);
>          return NULL;
>      }
> @@ -312,7 +315,7 @@ void hmp_gva2gpa(Monitor *mon, const QDict *qdict)
>      if (gpa == -1) {
>          monitor_printf(mon, "Unmapped\n");
>      } else {
> -        monitor_printf(mon, "gpa: %#" HWADDR_PRIx "\n",
> +        monitor_printf(mon, "gpa: 0x%" HWADDR_PRIx "\n",
>                         gpa + (addr & ~TARGET_PAGE_MASK));
>      }
>  }
> @@ -344,7 +347,8 @@ static uint64_t vtop(void *ptr, Error **errp)
>          error_setg(errp, "Page not present");
>          goto out;
>      }
> -    ret = ((pinfo & 0x007fffffffffffffull) * pagesize) | (addr & (pagesize - 1));
> +    ret = (pinfo & 0x007fffffffffffffull) * pagesize;
> +    ret |= addr & (pagesize - 1);
>  
>  out:
>      close(fd);
> -- 
> 2.52.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

