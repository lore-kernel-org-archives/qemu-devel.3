Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 623FAC55172
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Aug 2026 17:18:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqDLL-0007Dt-9Q; Sat, 01 Aug 2026 13:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1wqDLH-0007Bk-LF
 for qemu-devel@nongnu.org; Sat, 01 Aug 2026 13:17:47 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1wqDL9-00039b-0q
 for qemu-devel@nongnu.org; Sat, 01 Aug 2026 13:17:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=z7vIW4BHjacOOTizPQ55dTU8g8m53OULKUyiaJqt/W4=; b=he0n8xgzyt2hI2bW
 1tr6v5rsnvCO/LMv49Lxcvp2Nb2ZyXZpifzZhAEwDV/jcSEDJMz8wwbD43XIAGE6BWstM2fUhKM+U
 NAkKg9oZugO9nZ8W9i+jJFtqJchx0mvIrRZ8Zz0MZYd8k9wKFLnM5UcfxZP5c5w69aay3V6ccraru
 UbotcYZhK6Sjjayq0TiFa7BsKxpHFDoBfgdzZZ7SMmDdSMzCePSiU1tABOA5J36jFZYelsT8DR4j3
 S8X3TcYdeZs8AebKbzEycW+mp4g1vXt/HAnkUl4xdEfAZYmW5+5ZSPyAg2pDUO7yNyZZAkXNw53dA
 gx/vqcfym/t8xt+YpA==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1wqDL4-000000009Kn-0aH2;
 Sat, 01 Aug 2026 17:17:34 +0000
Date: Sat, 1 Aug 2026 17:17:34 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Tripp R <tripprobins@gmail.com>, hreitz@redhat.com, kwolf@redhat.com
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] added the inpsect block command ('xb') to print the
 contents within a block device to the monitor.
Message-ID: <am4qLtVApsOMHqis@gallifrey>
References: <20260726-xbcmd-v1-1-0ddbdcf82fcb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20260726-xbcmd-v1-1-0ddbdcf82fcb@gmail.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.100+deb13-amd64 (x86_64)
X-Uptime: 16:45:21 up 22:47,  3 users,  load average: 0.00, 0.02, 0.00
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

* Tripp R (tripprobins@gmail.com) wrote:
> 'xb' (examine block) is almost identical in usage to 'x' and 'xp', having the same targuments for those commands , albeit preceded by a drive name.

Hi Tripp,
  Thanks for resending this.  Note that normally you'd mark this as being a 'v2' version.
I'm copying in Kevin and Hanna from the Block layer; although there's still
some work to do here.

> ---
> Implemented the xb (examine block) command to print the contents of a block     device to the console.
> 
> It is effectively a clone of the x/xp commands (examine memory / examine        physical memory), having the same arguments for those commands, albeit preceded by the name of a block driver.

OK, these are still a bit weirdly formatted; you seem to have spaces added between 'block device'
and 'examine physical' rather than the line actually being broken into two lines.

> 
> e.g. usage
>          xd floppy0 /510c 0

Remember to include the explanation.

Also, I'd shorten the subject, something like
  [PATCH] Add the inspect block command ('xb')

> Signed-off-by: Tripp R <tripprobins@gmail.com>
> ---
>  hmp-commands.hx       |  14 +++++++
>  include/monitor/hmp.h |   1 +
>  monitor/hmp-cmds.c    | 104 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 119 insertions(+)
> 
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 7ae2468a3d..db63b58a47 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -472,6 +472,20 @@ ERST
>          .cmd        = hmp_memory_dump,
>      },
>  
> +SRST
> +``xb/``\ *fmt* *addr*
> +  Block memory dump starting at *addr*.

Block *device* not memory - or just 'Block dump'

> +ERST
> +
> +    {
> +        .name       = "xb",
> +        .args_type  = "device:s, fmt:/,addr:l",
> +        .params     = "device /fmt addr",
> +        .help       = "block memory dump starting at 'addr'",

again not 'block memory'

> +        .cmd        = hmp_block_dump,
> +    },
> +
> +
>  SRST
>  ``x/``\ *fmt* *addr*
>    Virtual memory dump starting at *addr*.

> diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
> index 9258a049bf..0c3e8a30c2 100644
> --- a/include/monitor/hmp.h
> +++ b/include/monitor/hmp.h
> @@ -182,6 +182,7 @@ void hmp_info_local_apic(Monitor *mon, const QDict *qdict);
>  void hmp_info_sev(Monitor *mon, const QDict *qdict);
>  void hmp_info_sgx(Monitor *mon, const QDict *qdict);
>  void hmp_info_via(Monitor *mon, const QDict *qdict);
> +void hmp_block_dump(Monitor *mon, const QDict *qdict);
>  void hmp_memory_dump(Monitor *mon, const QDict *qdict);
>  void hmp_physical_memory_dump(Monitor *mon, const QDict *qdict);
>  void hmp_info_registers(Monitor *mon, const QDict *qdict);
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index e9fb8d827a..5d4a6c6a78 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -39,8 +39,12 @@
>  #include "system/hw_accel.h"
>  #include "system/memory.h"
>  #include "system/system.h"
> +#include "system/block-backend-common.h"
> +#include "system/block-backend-io.h"
> +#include "system/block-backend-global-state.h"
>  #include "disas/disas.h"
>  
> +

Stray extra line

>  /* Please update hmp-commands.hx when adding or changing commands */
>  static HMPCommand hmp_info_cmds[] = {
>  #include "hmp-commands-info.h"
> @@ -584,6 +588,89 @@ void hmp_info_registers(Monitor *mon, const QDict *qdict)
>      }
>  }
>  
> +
> +static void block_dump(Monitor *mon, BlockBackend* blk, int count, int format, 
> +    int wsize, int64_t offset)
> +{
> +    uint8_t buf[16];
> +
> +    uint16_t max_digits = 0;
> +
> +    switch (format) {
> +    case 'o':
> +        max_digits = DIV_ROUND_UP(wsize * 8, 3);
> +        break;
> +    default:
> +    case 'x':
> +        max_digits = (wsize * 8) / 4;
> +        break;
> +    case 'u':
> +    case 'd':
> +        max_digits = DIV_ROUND_UP(wsize * 8 * 10, 33);
> +        break;
> +    case 'c':
> +        wsize = 1;
> +        break;
> +    }

This code is a copy/paste out of memory_dump; it's always best
to avoid copy paste - so if you can move this code out of memory_dump
into a function - e.g. digits_for_format say, and then just call
it from both places it would be best.

> +    while (count > 0) {
> +        int bytes = MIN(16, count * wsize);
> +
> +        if (blk_pread(blk, offset, bytes, buf, 0) < 0) {
> +            monitor_printf(mon,
> +                           "Read failed at 0x%" PRIx64 "\n",
> +                           offset);
> +            return;
> +        }
> +
> +        monitor_printf(mon, "%08" PRIx64 ": ", offset);
> +
> +        for (int i = 0; i < bytes; i += wsize) {
> +            uint64_t v;
> +
> +            switch (wsize) {
> +            case 1:
> +                v = buf[i];
> +                break;
> +            case 2:
> +                v = lduw_le_p(buf + i);
> +                break;
> +            case 4:
> +                v = ldl_le_p(buf + i);
> +                break;
> +            case 8:
> +                v = ldq_le_p(buf + i);
> +                break;

I don't think you need to use the magic ld*_le_p functions here - those
are normally used for access to guest ram, which the 'x' command does;
you can use normal C casts etc here.

> +            default:
> +                v=0;
> +            }
> +            switch (format) {
> +            case 'o':
> +                monitor_printf(mon, "0%*" PRIo64, max_digits, v);
> +                break;
> +            case 'x':
> +                monitor_printf(mon, "0x%0*" PRIx64, max_digits, v);
> +                break;
> +            case 'u':
> +                monitor_printf(mon, "%*" PRIu64, max_digits, v);
> +                break;
> +            case 'd':
> +                monitor_printf(mon, "%*" PRId64, max_digits, v);
> +                break;
> +            case 'c':
> +                monitor_printc(mon, v);
> +                break;
> +            }
> +        }

Again this is a block of code copied from memory_dump; so better
to share a function rather than copy.

> +        monitor_printf(mon, "\n");
> +
> +        offset += bytes;
> +        count -= bytes / wsize;

OK, so you're printing one entry per line rather than memory_dump's
fancier trick of printing a few on a line; I prefer memory_dumps way
of doing it - your example dump of 510 bytes must be annoying to scroll
through!

Dave

> +    }
> +}
> +
>  static void memory_dump(Monitor *mon, int count, int format, int wsize,
>                          uint64_t addr, bool is_physical)
>  {
> @@ -692,6 +779,23 @@ static void memory_dump(Monitor *mon, int count, int format, int wsize,
>      }
>  }
>  
> +void hmp_block_dump(Monitor *mon, const QDict *qdict)
> +{
> +    int count = qdict_get_int(qdict, "count");
> +    int format = qdict_get_int(qdict, "format");
> +    int size = qdict_get_int(qdict, "size");
> +    vaddr addr = qdict_get_int(qdict, "addr");
> +    const char* dblock = qdict_get_str(qdict, "device");
> +
> +    BlockBackend *blk = blk_by_name(dblock);
> +
> +    if (!blk) {
> +        monitor_printf(mon, "Invalid block device name '%s'.\n\r", dblock);
> +        return;
> +    }
> +    block_dump(mon,blk, count, format, size, addr);
> +}
> +
>  void hmp_memory_dump(Monitor *mon, const QDict *qdict)
>  {
>      int count = qdict_get_int(qdict, "count");
> 
> ---
> base-commit: 443e02410695b35a27fad18217424b6370358be7
> change-id: 20260726-xbcmd-7fa889067f15
> 
> Best regards,
> -- 
> Tripp R <tripprobins@gmail.com>
> 
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

