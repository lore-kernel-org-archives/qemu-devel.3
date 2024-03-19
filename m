Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D89C54E68
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 21:01:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmgaY-0003dw-Hn; Tue, 19 Mar 2024 17:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1rmgaV-0003b8-CC
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 17:01:35 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1rmgaT-0005m4-Pm
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 17:01:35 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-513dd2d2415so4833269e87.3
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 14:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710882091; x=1711486891; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xwN3IcsgjB2RDUBU1TiAnBHz4iAKRagrpYKAYPCLm+0=;
 b=cE0pYkSH6uvNObvwpz9o/y66xMEy2RLzyiWat0q/vLy6LDv/f4RhMSZ9axuP5+9+7W
 3XWz2q8b/Fy+tBiQ8+9u4d7ETMHGdTXr1b4ODZFOSM0ix8lLg1IFeTsHPa1me63+CDSc
 tVPPt9BOR2IVX9mZTjO/K3eNiWt++rfvvKol6hkZ3jyGSgixoKbq1sUCQVvgMcPimm49
 ihfav5xGiUklJqxNiWzMlDA/j3VWh1mLHJnXXygkcz6kNuiqs7KsVfQjU1sEbHt8vAgv
 +QyoAGnexOANL6QQDZaazsiZmqqRRGB41QoWpHBu0UMLS/I0CqGGLBuaokHcLLoxgyzp
 3EWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710882091; x=1711486891;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xwN3IcsgjB2RDUBU1TiAnBHz4iAKRagrpYKAYPCLm+0=;
 b=N9Q30QrjKyTEuLAL1nQnmHzqNtJsi+TuFqQ53kW9dpliIO/yEurS5iiCFJ7Fi3RyXT
 muzXOEDKAbkOH2AFH0LyQlyVY28FLtEb8Ys6WlVrihB6pWFBYPqWb25KurQ6tFBl8KlQ
 9sIBVEKSdwjme4B312GpWW9fIjMV+aR4/gH/QUZv5/bVcqMbQmRYziMcnk3nYuCmjhV4
 N+JaaGGQfflFbG705ZTTVTAHlHliDV4LuJnrr4KcNyn6eTI26nZco0xTsKTfozHEXTtD
 zr0XTVbsQKaUCvm2BFZBCG6OWjW07ikw8w67xvqN5BfkhZTBSthOnkMMd0sbLSwvasWh
 i7tQ==
X-Gm-Message-State: AOJu0Yy84H1iiiYqj9XQ0lCPe4FVr8WaoF5FtldHsAo9z1fQZH61dmv5
 ysn23Dsxr2Alg1a1o68rZ3kyDHvikfqMKCTMJR/Xme0/z50J8hyp
X-Google-Smtp-Source: AGHT+IGKN0TvgueqRa91RZl0kuB1aDG+YdYqu66s5aVoO5D/noQUhcOgcysDYsf2TbngkC3FpKdacA==
X-Received: by 2002:a05:6512:3283:b0:513:c97c:d5f with SMTP id
 p3-20020a056512328300b00513c97c0d5fmr10288071lfe.12.1710882090451; 
 Tue, 19 Mar 2024 14:01:30 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 t19-20020a192d53000000b00512f6cc7fc1sm2115006lft.55.2024.03.19.14.01.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 14:01:30 -0700 (PDT)
Date: Tue, 19 Mar 2024 22:01:29 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>
Subject: Re: [PATCH-for-9.1 6/8] target/microblaze: Rename helper.c ->
 sys_helper.c
Message-ID: <Zfn9KS6c_lIuC1AN@toto>
References: <20240319062855.8025-1-philmd@linaro.org>
 <20240319062855.8025-7-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240319062855.8025-7-philmd@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Mar 19, 2024 at 07:28:53AM +0100, Philippe Mathieu-Daudé wrote:
> helper.c only contains system emulation helpers,
> rename it as sys_helper.c.
> Adapt meson and remove pointless #ifdef'ry.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>


> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/microblaze/{helper.c => sys_helper.c} | 5 +----
>  target/microblaze/meson.build                | 2 +-
>  2 files changed, 2 insertions(+), 5 deletions(-)
>  rename target/microblaze/{helper.c => sys_helper.c} (99%)
> 
> diff --git a/target/microblaze/helper.c b/target/microblaze/sys_helper.c
> similarity index 99%
> rename from target/microblaze/helper.c
> rename to target/microblaze/sys_helper.c
> index 3f410fc7b5..5180500354 100644
> --- a/target/microblaze/helper.c
> +++ b/target/microblaze/sys_helper.c
> @@ -1,5 +1,5 @@
>  /*
> - *  MicroBlaze helper routines.
> + *  MicroBlaze system helper routines.
>   *
>   *  Copyright (c) 2009 Edgar E. Iglesias <edgar.iglesias@gmail.com>
>   *  Copyright (c) 2009-2012 PetaLogix Qld Pty Ltd.
> @@ -24,7 +24,6 @@
>  #include "qemu/host-utils.h"
>  #include "exec/log.h"
>  
> -#ifndef CONFIG_USER_ONLY
>  static bool mb_cpu_access_is_secure(MicroBlazeCPU *cpu,
>                                      MMUAccessType access_type)
>  {
> @@ -266,8 +265,6 @@ bool mb_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>      return false;
>  }
>  
> -#endif /* !CONFIG_USER_ONLY */
> -
>  void mb_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
>                                  MMUAccessType access_type,
>                                  int mmu_idx, uintptr_t retaddr)
> diff --git a/target/microblaze/meson.build b/target/microblaze/meson.build
> index 3ed4fbb67a..013ea542be 100644
> --- a/target/microblaze/meson.build
> +++ b/target/microblaze/meson.build
> @@ -5,7 +5,6 @@ microblaze_ss.add(gen)
>  microblaze_ss.add(files(
>    'cpu.c',
>    'gdbstub.c',
> -  'helper.c',
>    'op_helper.c',
>    'translate.c',
>  ))
> @@ -14,6 +13,7 @@ microblaze_system_ss = ss.source_set()
>  microblaze_system_ss.add(files(
>    'mmu.c',
>    'machine.c',
> +  'sys_helper.c',
>  ))
>  
>  target_arch += {'microblaze': microblaze_ss}
> -- 
> 2.41.0
> 

