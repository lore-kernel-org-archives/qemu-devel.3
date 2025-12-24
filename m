Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A06E5E7545F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 14:22:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYPkZ-0001zE-KG; Wed, 24 Dec 2025 09:22:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vYPkX-0001yo-I1
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 09:22:01 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vYPkV-0005KI-IU
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 09:22:01 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-64b9d01e473so7465279a12.2
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 06:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766586118; x=1767190918; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=neyquH4H+13+OqReGQtPnaAq1kAXAfhwEphJPPVVyMw=;
 b=fX8QodIwZTHKrbPKxyB9RjlinSRiUk4WeiJUedNOTX8YNpXzUGUxlPHeSq3B8fOJpW
 2WZQnuFZKJ3LgiTiTZbjqnvHXN6VSOxCknVnlGARllRyieyBR8No3lewKsE0QeXHNXYL
 behoHbA1aL6uA2cyNUckMCY1Va02IvEs32tb+7awuihUJbnpzEM7v7na0OCFZuLYERUx
 kewDVVgGenfB7bwjllJ8i/ZD/LVQ3aK7nT/5S9sGdJG31oy7sEEPvYuD5LQe2Q8nw3M+
 ynQQG0J29pVA05lHUd6t79AuWV+nHotTgiBn5X85BkIkweHT7CXPhZrCVKUT4lB9RVFl
 UY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766586118; x=1767190918;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=neyquH4H+13+OqReGQtPnaAq1kAXAfhwEphJPPVVyMw=;
 b=nv1OxC7cH0QF3t2xq/1LQ/zz6A/HLrKxliwfX87ie2Bu+Wi+wcFqLAkI+SGEnCKZQt
 /NhPGpjBbM+bfY+GIOBXyK4CtPKCKpHREfkFN+dHE9ZsRSuhfbNDzSX8iLtbHXV2Osd8
 qmx3abLxBKisX1hzBCfXEO04yL8g1aGlZXbelthG/rKCtyDYi7wCwNsxdgrNyC+5+Ri/
 HF8OGKkQb3zamZmuZoLo4wCD9ZlGvyP0Q4JXaaqdLchl9nLmYzQbn69biLFvIiHE85i0
 ZyuoxAILk+KfTOnPiZ+ysAdj84vk/KXGwZZi+KsUfVSGo78hBJ2YX8FnYu8OXtgqLobK
 yFjQ==
X-Gm-Message-State: AOJu0Yyx9K77QHMB8W9ajQcLO9r1Dc700OBWsBMu214AQPvIKdhsNmyI
 Zk5pNuRZFaQ0PecDSlmxWSPxY6NIaUKZBZJueG6p9TGAHGFHboaqd7wtH8dQLVaIS1Ea+sqCVyA
 3BYKOQd1MmHgwZgMheYMaEHw8PG67Q6m8sY9jLd/UVQ==
X-Gm-Gg: AY/fxX6CDatEsAjttJl/Ki3SScW9rUh7XmPfLHeWTRAKkW/LAZ79c+7v2tuwRT9Xlyi
 fnz7CCTNhn6gH/M+ZVETWvxbBouxRfzEWkiUHatp+QhV/uShCb0QMrcWh10f2dfvEwxgVtl8Msw
 atXNJNsIT2FfdEhcuTSgePGOoiSHmSWlP35h7a4d6S18bFOUX4xviSkWd3VPGXyrISgjsF+B2Om
 G1qHSi1UCICa4iPmDnM/GJIn4jh5QnJsFn+YovrzXHY2sO7jxOS97T5t89Gh6wJsdxhg2Q=
X-Google-Smtp-Source: AGHT+IFw40Jo8wxb24xdyyiODO0JHDQCyVVBAGP7ezDVm0FTQo3wADlzwKj/N3n8zNIMAUcKeLcf4nbqj8bBF3Ch4TU=
X-Received: by 2002:a17:907:2da0:b0:b73:5958:7e6c with SMTP id
 a640c23a62f3a-b8036f0add4mr2085499466b.3.1766586117690; Wed, 24 Dec 2025
 06:21:57 -0800 (PST)
MIME-Version: 1.0
References: <20251224133949.85136-1-philmd@linaro.org>
 <20251224133949.85136-6-philmd@linaro.org>
In-Reply-To: <20251224133949.85136-6-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 24 Dec 2025 16:21:30 +0200
X-Gm-Features: AQt7F2of7NmQens07zFB6JNty6yZapIEUvLnzxhCUl4YAMchp6AQBV5YcNayVFs
Message-ID: <CAAjaMXahmaxDRkZ9XA95zme3UTDoDRCNhjQX+ydmxjVMgpzq8A@mail.gmail.com>
Subject: Re: [PATCH 5/6] monitor/hmp: Fix coding style in hmp-cmds-target.c
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Anton Johansson <anjo@rev.ng>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed, Dec 24, 2025 at 3:40=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Previous to moving code contained in hmp-cmds-target.c,
> fix the coding style. Otherwise the checkpatch.pl script
> would report:
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
>   ERROR: Don't use '#' flag of printf format ('%#') in format strings, us=
e '0x' prefix instead
>   #190: FILE: monitor/hmp-cmds-target.c:208:
>   +                monitor_printf(mon, "%#*" PRIo64, max_digits, v);
>
>   WARNING: line over 80 characters
>   #240: FILE: monitor/hmp-cmds-target.c:258:
>   +        error_setg(errp, "No memory is mapped at address 0x%" HWADDR_P=
RIx, addr);
>
>   WARNING: line over 80 characters
>   #245: FILE: monitor/hmp-cmds-target.c:263:
>   +        error_setg(errp, "Memory at address 0x%" HWADDR_PRIx " is not =
RAM", addr);
>
>   ERROR: Don't use '#' flag of printf format ('%#') in format strings, us=
e '0x' prefix instead
>   #297: FILE: monitor/hmp-cmds-target.c:315:
>   +        monitor_printf(mon, "gpa: %#" HWADDR_PRIx "\n",
>
>   WARNING: line over 80 characters
>   #329: FILE: monitor/hmp-cmds-target.c:347:
>   +    ret =3D ((pinfo & 0x007fffffffffffffull) * pagesize) | (addr & (pa=
gesize - 1));
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  monitor/hmp-cmds-target.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
>
> diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
> index efab133cf2f..48c21559156 100644
> --- a/monitor/hmp-cmds-target.c
> +++ b/monitor/hmp-cmds-target.c
> @@ -149,7 +149,7 @@ static void memory_dump(Monitor *mon, int count, int =
format, int wsize,
>      }
>      max_digits =3D 0;
>
> -    switch(format) {
> +    switch (format) {
>      case 'o':
>          max_digits =3D DIV_ROUND_UP(wsize * 8, 3);
>          break;
> @@ -169,8 +169,9 @@ static void memory_dump(Monitor *mon, int count, int =
format, int wsize,
>      while (len > 0) {
>          monitor_printf(mon, "%0*" PRIx64 ":", addr_width, addr);
>          l =3D len;
> -        if (l > line_size)
> +        if (l > line_size) {
>              l =3D line_size;
> +        }
>          if (is_physical) {
>              AddressSpace *as =3D cs ? cs->as : &address_space_memory;
>              MemTxResult r =3D address_space_read(as, addr,
> @@ -187,7 +188,7 @@ static void memory_dump(Monitor *mon, int count, int =
format, int wsize,
>          }
>          i =3D 0;
>          while (i < l) {
> -            switch(wsize) {
> +            switch (wsize) {
>              default:
>              case 1:
>                  v =3D ldub_p(buf + i);
> @@ -203,9 +204,9 @@ static void memory_dump(Monitor *mon, int count, int =
format, int wsize,
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
> @@ -255,12 +256,14 @@ void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, uin=
t64_t size, Error **errp)
>                                                   addr, size);
>
>      if (!mrs.mr) {
> -        error_setg(errp, "No memory is mapped at address 0x%" HWADDR_PRI=
x, addr);
> +        error_setg(errp,
> +                   "No memory is mapped at address 0x%" HWADDR_PRIx, add=
r);
>          return NULL;
>      }
>
>      if (!memory_region_is_ram(mrs.mr) && !memory_region_is_romd(mrs.mr))=
 {
> -        error_setg(errp, "Memory at address 0x%" HWADDR_PRIx " is not RA=
M", addr);
> +        error_setg(errp,
> +                   "Memory at address 0x%" HWADDR_PRIx " is not RAM", ad=
dr);
>          memory_region_unref(mrs.mr);
>          return NULL;
>      }
> @@ -312,7 +315,7 @@ void hmp_gva2gpa(Monitor *mon, const QDict *qdict)
>      if (gpa =3D=3D -1) {
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
> -    ret =3D ((pinfo & 0x007fffffffffffffull) * pagesize) | (addr & (page=
size - 1));
> +    ret =3D (pinfo & 0x007fffffffffffffull) * pagesize;
> +    ret |=3D addr & (pagesize - 1);
>
>  out:
>      close(fd);
> --
> 2.52.0
>

