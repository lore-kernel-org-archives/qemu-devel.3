Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 581FAE83F05
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 05:27:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnrtE-0003n4-3t; Thu, 05 Feb 2026 00:26:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vnrtB-0003mX-LK
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 00:26:49 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vnrt2-00070B-PB
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 00:26:49 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2a76f90872cso3212975ad.3
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 21:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770268982; x=1770873782; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=orfzqkJkWLhRn5YwT0Ho2+HZFXs+m3QnX1DkhPa7KtU=;
 b=TmlHqx7jg6OxjaCLUhYhOs2Zk61xCrNf/j/B/9VKw9Z/9D7wZlPEn+E0XxKFdJrrG+
 23//bqwzbj7jxMHPn+s3u336TT8C1FTsEevcB4SNboUDLPkhUcLlDGjCv1TSJBhdX3jV
 ySfIwKOrAHHmd9djAgHnYrN1LbAc2Dbo9ycv/HkEuIOwY6GpNJzLLukwobOAzaRei6h8
 QHCkmvkIOLQdwnCeSqnCwfQ99kQhLYWxawdbRT9q42mwbMvR5LQYarGvqVCkLm2RLkiq
 I/49Mi+EpYRCL/cDBCWzKK1bZZOYA+wdOKt+uQmj0owmk18CvuLQzLQEec7/d9XdWdj0
 elgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770268982; x=1770873782;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=orfzqkJkWLhRn5YwT0Ho2+HZFXs+m3QnX1DkhPa7KtU=;
 b=IMAvwbhwifqXP6SMDHXeSLUuzb4xBwbhAH796b6+Wm0dEiPak6EIMuPuVrezzDgluR
 sSy/H23YrW1Q+ISIJUE49pyGSATuq6F4ep6P+GGFpxQhZrv5+A9OkGOtGLGI+cXMOfM4
 6y+nvKL80dC0qVxVxICWOsEYb00SzJEBCJYa8NTJq5+c1RIDaXoZIIrxVTvDuH0VMkNi
 zsdU4zd1yRYvgqs1cMqoOJ1i/pxa1C7Eg5zz1oKK9iTy04rmcPDbr3yL+lKh5dP4bXTA
 Jl/2ksYfaqEoKfRbAYhfK6V3LnjSFrlqbUSAs5j1gPriO4y7FJRKI8LnHvNY/xqBE4RD
 vA8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcUIRn8opRTxPgvleofcbyVi6MsqTHj7wrfQY1Fb8j/ljIQ7WlQcQpYmCEsyhZ+ad9sV4ft9S70stB@nongnu.org
X-Gm-Message-State: AOJu0Yw1PtxOUslboi/cHX6vNyqxVQKcl7FG60QQUUAGkjvRKanmdzPY
 7CxCdFjAr/GvxVy9oWVvfUbdRRfRPqDWtmiZsnelKJkkONYu4ZzAe25hpJ53ksINR6U=
X-Gm-Gg: AZuq6aI+9CFCApTzJ9FsQkLHHkZzBsKICZhipWtV1Vo4WQJCBWnB88HaMRJ+h2smFjx
 HCaQYDxcR+RlaL5apfMEq4K2WX/JZyozWCmwRUEYf5PIezNvl8jcUbH55EgoxvDO2BxyoKlEQAf
 64cLaVdFV0jA7hpXaR3v4i00mdgbrZBQCTgQe+fK2HE+dF4YMVOIbY/P9ESUaax+0nL+3jJUfwT
 4av0nxdI4lhGXr8vcsoG0HcsL8Ts2aLWUkvTxZNWf1uvkgre3jLv29I5sHTk+fTguw6eCstFz3X
 NR3MnuTXjrfAzaOdVkGpksWhqnMFNH3szXehNuidAb7E1pTEXbQZ4mX1KDUEgx0LyGxEbF0AtLp
 6HO09sxopxjXTgSzDnQRzFWMxVrL2dbKijPD4EwjnC0rn2c4WyXpLEUXUyUi4d5gGNe1+xFXv+w
 RUr6cbQb3HMey3mwnH6GwK9aB5yMAj6OAipC4U5sH7r2yg2AasOAUM+tyb
X-Received: by 2002:a17:902:d4c4:b0:2a7:683c:afd0 with SMTP id
 d9443c01a7336-2a933d01808mr63639825ad.14.1770268981830; 
 Wed, 04 Feb 2026 21:23:01 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a93394e3c5sm38601955ad.65.2026.02.04.21.23.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Feb 2026 21:23:01 -0800 (PST)
Message-ID: <41d7ead2-ee77-402b-864e-0a931d749f10@linaro.org>
Date: Wed, 4 Feb 2026 21:23:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] or1k: Rename the architecture from openrisc
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: shorne@gmail.com
References: <20260205030244.266447-1-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260205030244.266447-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

On 2/4/26 7:02 PM, Richard Henderson wrote:
> We have an odd mix of 'openrisc' and 'or1k' in use.
> Standardize TARGET_ARCH and all of the filenames to use 'or1k'.
> 
> 
> r~
> 
> 
> Richard Henderson (6):
>    target/or1k: Rename from openrisc
>    include/hw/or1k: Rename from openrisc
>    hw/or1k: Rename from openrisc
>    tests/tcg/or1k: Rename from openrisc
>    docs/system/or1k: Rename from openrisc
>    hw/or1k: Rename or1k-sim.c from openrisc_sim.c
> 
>   include/exec/poison.h                              |  2 +-
>   include/hw/{openrisc => or1k}/boot.h               |  6 +++---
>   include/system/arch_init.h                         |  2 +-
>   include/user/abitypes.h                            |  2 +-
>   linux-user/{openrisc => or1k}/sockbits.h           |  0
>   linux-user/{openrisc => or1k}/target_cpu.h         |  0
>   linux-user/{openrisc => or1k}/target_elf.h         |  0
>   linux-user/{openrisc => or1k}/target_errno_defs.h  |  0
>   linux-user/{openrisc => or1k}/target_fcntl.h       |  0
>   linux-user/{openrisc => or1k}/target_mman.h        |  0
>   linux-user/{openrisc => or1k}/target_prctl.h       |  0
>   linux-user/{openrisc => or1k}/target_proc.h        |  0
>   linux-user/{openrisc => or1k}/target_ptrace.h      |  0
>   linux-user/{openrisc => or1k}/target_resource.h    |  0
>   linux-user/{openrisc => or1k}/target_signal.h      |  0
>   linux-user/{openrisc => or1k}/target_structs.h     |  0
>   linux-user/{openrisc => or1k}/target_syscall.h     |  0
>   linux-user/{openrisc => or1k}/termbits.h           |  0
>   linux-user/syscall_defs.h                          |  4 ++--
>   target/{openrisc => or1k}/cpu-param.h              |  0
>   target/{openrisc => or1k}/cpu-qom.h                |  0
>   target/{openrisc => or1k}/cpu.h                    |  0
>   target/{openrisc => or1k}/exception.h              |  0
>   target/{openrisc => or1k}/helper.h                 |  0
>   hw/{openrisc => or1k}/boot.c                       |  2 +-
>   hw/{openrisc => or1k}/cputimer.c                   |  0
>   hw/{openrisc/openrisc_sim.c => or1k/or1k-sim.c}    |  2 +-
>   hw/{openrisc => or1k}/virt.c                       |  2 +-
>   linux-user/{openrisc => or1k}/cpu_loop.c           |  0
>   linux-user/{openrisc => or1k}/elfload.c            |  0
>   linux-user/{openrisc => or1k}/signal.c             |  0
>   system/qdev-monitor.c                              |  2 +-
>   target/{openrisc => or1k}/cpu.c                    |  0
>   target/{openrisc => or1k}/disas.c                  |  0
>   target/{openrisc => or1k}/exception.c              |  0
>   target/{openrisc => or1k}/exception_helper.c       |  0
>   target/{openrisc => or1k}/fpu_helper.c             |  0
>   target/{openrisc => or1k}/gdbstub.c                |  0
>   target/{openrisc => or1k}/interrupt.c              |  0
>   target/{openrisc => or1k}/interrupt_helper.c       |  0
>   target/{openrisc => or1k}/machine.c                |  0
>   target/{openrisc => or1k}/mmu.c                    |  0
>   target/{openrisc => or1k}/sys_helper.c             |  0
>   target/{openrisc => or1k}/translate.c              |  0
>   tests/tcg/{openrisc => or1k}/test_add.c            |  0
>   tests/tcg/{openrisc => or1k}/test_addc.c           |  0
>   tests/tcg/{openrisc => or1k}/test_addi.c           |  0
>   tests/tcg/{openrisc => or1k}/test_addic.c          |  0
>   tests/tcg/{openrisc => or1k}/test_and_or.c         |  0
>   tests/tcg/{openrisc => or1k}/test_bf.c             |  0
>   tests/tcg/{openrisc => or1k}/test_bnf.c            |  0
>   tests/tcg/{openrisc => or1k}/test_div.c            |  0
>   tests/tcg/{openrisc => or1k}/test_divu.c           |  0
>   tests/tcg/{openrisc => or1k}/test_extx.c           |  0
>   tests/tcg/{openrisc => or1k}/test_fx.c             |  0
>   tests/tcg/{openrisc => or1k}/test_j.c              |  0
>   tests/tcg/{openrisc => or1k}/test_jal.c            |  0
>   tests/tcg/{openrisc => or1k}/test_lf_add.c         |  0
>   tests/tcg/{openrisc => or1k}/test_lf_div.c         |  0
>   tests/tcg/{openrisc => or1k}/test_lf_eqs.c         |  0
>   tests/tcg/{openrisc => or1k}/test_lf_ges.c         |  0
>   tests/tcg/{openrisc => or1k}/test_lf_gts.c         |  0
>   tests/tcg/{openrisc => or1k}/test_lf_les.c         |  0
>   tests/tcg/{openrisc => or1k}/test_lf_lts.c         |  0
>   tests/tcg/{openrisc => or1k}/test_lf_mul.c         |  0
>   tests/tcg/{openrisc => or1k}/test_lf_nes.c         |  0
>   tests/tcg/{openrisc => or1k}/test_lf_rem.c         |  0
>   tests/tcg/{openrisc => or1k}/test_lf_sub.c         |  0
>   tests/tcg/{openrisc => or1k}/test_logic.c          |  0
>   tests/tcg/{openrisc => or1k}/test_lx.c             |  0
>   tests/tcg/{openrisc => or1k}/test_movhi.c          |  0
>   tests/tcg/{openrisc => or1k}/test_mul.c            |  0
>   tests/tcg/{openrisc => or1k}/test_muli.c           |  0
>   tests/tcg/{openrisc => or1k}/test_mulu.c           |  0
>   tests/tcg/{openrisc => or1k}/test_sfeq.c           |  0
>   tests/tcg/{openrisc => or1k}/test_sfeqi.c          |  0
>   tests/tcg/{openrisc => or1k}/test_sfges.c          |  0
>   tests/tcg/{openrisc => or1k}/test_sfgesi.c         |  0
>   tests/tcg/{openrisc => or1k}/test_sfgeu.c          |  0
>   tests/tcg/{openrisc => or1k}/test_sfgeui.c         |  0
>   tests/tcg/{openrisc => or1k}/test_sfgts.c          |  0
>   tests/tcg/{openrisc => or1k}/test_sfgtsi.c         |  0
>   tests/tcg/{openrisc => or1k}/test_sfgtu.c          |  0
>   tests/tcg/{openrisc => or1k}/test_sfgtui.c         |  0
>   tests/tcg/{openrisc => or1k}/test_sfles.c          |  0
>   tests/tcg/{openrisc => or1k}/test_sflesi.c         |  0
>   tests/tcg/{openrisc => or1k}/test_sfleu.c          |  0
>   tests/tcg/{openrisc => or1k}/test_sfleui.c         |  0
>   tests/tcg/{openrisc => or1k}/test_sflts.c          |  0
>   tests/tcg/{openrisc => or1k}/test_sfltsi.c         |  0
>   tests/tcg/{openrisc => or1k}/test_sfltu.c          |  0
>   tests/tcg/{openrisc => or1k}/test_sfltui.c         |  0
>   tests/tcg/{openrisc => or1k}/test_sfne.c           |  0
>   tests/tcg/{openrisc => or1k}/test_sfnei.c          |  0
>   tests/tcg/{openrisc => or1k}/test_sub.c            |  0
>   MAINTAINERS                                        | 14 +++++++-------
>   configs/targets/or1k-linux-user.mak                |  2 +-
>   configs/targets/or1k-softmmu.mak                   |  2 +-
>   docs/system/{openrisc => or1k}/cpu-features.rst    |  0
>   docs/system/{openrisc => or1k}/emulation.rst       |  0
>   docs/system/{openrisc => or1k}/or1k-sim.rst        |  0
>   docs/system/{openrisc => or1k}/virt.rst            |  0
>   .../{target-openrisc.rst => target-or1k.rst}       |  8 ++++----
>   docs/system/targets.rst                            |  2 +-
>   hw/Kconfig                                         |  2 +-
>   hw/meson.build                                     |  2 +-
>   hw/{openrisc => or1k}/Kconfig                      |  4 ++--
>   hw/{openrisc => or1k}/meson.build                  |  4 ++--
>   linux-user/meson.build                             |  2 +-
>   linux-user/openrisc/meson.build                    |  5 -----
>   linux-user/or1k/meson.build                        |  5 +++++
>   linux-user/{openrisc => or1k}/syscall.tbl          |  0
>   linux-user/{openrisc => or1k}/syscallhdr.sh        |  0
>   target/Kconfig                                     |  2 +-
>   target/meson.build                                 |  2 +-
>   target/{openrisc => or1k}/Kconfig                  |  2 +-
>   target/{openrisc => or1k}/insns.decode             |  0
>   target/{openrisc => or1k}/meson.build              |  4 ++--
>   tests/tcg/{openrisc => or1k}/Makefile              |  0
>   119 files changed, 43 insertions(+), 43 deletions(-)
>   rename include/hw/{openrisc => or1k}/boot.h (93%)
>   rename linux-user/{openrisc => or1k}/sockbits.h (100%)
>   rename linux-user/{openrisc => or1k}/target_cpu.h (100%)
>   rename linux-user/{openrisc => or1k}/target_elf.h (100%)
>   rename linux-user/{openrisc => or1k}/target_errno_defs.h (100%)
>   rename linux-user/{openrisc => or1k}/target_fcntl.h (100%)
>   rename linux-user/{openrisc => or1k}/target_mman.h (100%)
>   rename linux-user/{openrisc => or1k}/target_prctl.h (100%)
>   rename linux-user/{openrisc => or1k}/target_proc.h (100%)
>   rename linux-user/{openrisc => or1k}/target_ptrace.h (100%)
>   rename linux-user/{openrisc => or1k}/target_resource.h (100%)
>   rename linux-user/{openrisc => or1k}/target_signal.h (100%)
>   rename linux-user/{openrisc => or1k}/target_structs.h (100%)
>   rename linux-user/{openrisc => or1k}/target_syscall.h (100%)
>   rename linux-user/{openrisc => or1k}/termbits.h (100%)
>   rename target/{openrisc => or1k}/cpu-param.h (100%)
>   rename target/{openrisc => or1k}/cpu-qom.h (100%)
>   rename target/{openrisc => or1k}/cpu.h (100%)
>   rename target/{openrisc => or1k}/exception.h (100%)
>   rename target/{openrisc => or1k}/helper.h (100%)
>   rename hw/{openrisc => or1k}/boot.c (99%)
>   rename hw/{openrisc => or1k}/cputimer.c (100%)
>   rename hw/{openrisc/openrisc_sim.c => or1k/or1k-sim.c} (99%)
>   rename hw/{openrisc => or1k}/virt.c (99%)
>   rename linux-user/{openrisc => or1k}/cpu_loop.c (100%)
>   rename linux-user/{openrisc => or1k}/elfload.c (100%)
>   rename linux-user/{openrisc => or1k}/signal.c (100%)
>   rename target/{openrisc => or1k}/cpu.c (100%)
>   rename target/{openrisc => or1k}/disas.c (100%)
>   rename target/{openrisc => or1k}/exception.c (100%)
>   rename target/{openrisc => or1k}/exception_helper.c (100%)
>   rename target/{openrisc => or1k}/fpu_helper.c (100%)
>   rename target/{openrisc => or1k}/gdbstub.c (100%)
>   rename target/{openrisc => or1k}/interrupt.c (100%)
>   rename target/{openrisc => or1k}/interrupt_helper.c (100%)
>   rename target/{openrisc => or1k}/machine.c (100%)
>   rename target/{openrisc => or1k}/mmu.c (100%)
>   rename target/{openrisc => or1k}/sys_helper.c (100%)
>   rename target/{openrisc => or1k}/translate.c (100%)
>   rename tests/tcg/{openrisc => or1k}/test_add.c (100%)
>   rename tests/tcg/{openrisc => or1k}/test_addc.c (100%)
>   rename tests/tcg/{openrisc => or1k}/test_addi.c (100%)
>   rename tests/tcg/{openrisc => or1k}/test_addic.c (100%)
>   rename tests/tcg/{openrisc => or1k}/test_and_or.c (100%)
>   rename tests/tcg/{openrisc => or1k}/test_bf.c (100%)
>   rename tests/tcg/{openrisc => or1k}/test_bnf.c (100%)
>   rename tests/tcg/{openrisc => or1k}/test_div.c (100%)
>   rename tests/tcg/{openrisc => or1k}/test_divu.c (100%)
>   rename tests/tcg/{openrisc => or1k}/test_extx.c (100%)
>   rename tests/tcg/{openrisc => or1k}/test_fx.c (100%)
>   rename tests/tcg/{openrisc => or1k}/test_j.c (100%)
>   rename tests/tcg/{openrisc => or1k}/test_jal.c (100%)
>   rename tests/tcg/{openrisc => or1k}/test_lf_add.c (100%)
>   rename tests/tcg/{openrisc => or1k}/test_lf_div.c (100%)
>   rename tests/tcg/{openrisc => or1k}/test_lf_eqs.c (100%)
>   rename tests/tcg/{openrisc => or1k}/test_lf_ges.c (100%)
>   rename tests/tcg/{openrisc => or1k}/test_lf_gts.c (100%)
>   rename tests/tcg/{openrisc => or1k}/test_lf_les.c (100%)
>   rename tests/tcg/{openrisc => or1k}/test_lf_lts.c (100%)
>   rename tests/tcg/{openrisc => or1k}/test_lf_mul.c (100%)
>   rename tests/tcg/{openrisc => or1k}/test_lf_nes.c (100%)
>   rename tests/tcg/{openrisc => or1k}/test_lf_rem.c (100%)
>   rename tests/tcg/{openrisc => or1k}/test_lf_sub.c (100%)
>   rename tests/tcg/{openrisc => or1k}/test_logic.c (100%)
>   rename tests/tcg/{openrisc => or1k}/test_lx.c (100%)
>   rename tests/tcg/{openrisc => or1k}/test_movhi.c (100%)
>   rename tests/tcg/{openrisc => or1k}/test_mul.c (100%)
>   rename tests/tcg/{openrisc => or1k}/test_muli.c (100%)
>   rename tests/tcg/{openrisc => or1k}/test_mulu.c (100%)
>   rename tests/tcg/{openrisc => or1k}/test_sfeq.c (100%)
>   rename tests/tcg/{openrisc => or1k}/test_sfeqi.c (100%)
>   rename tests/tcg/{openrisc => or1k}/test_sfges.c (100%)
>   rename tests/tcg/{openrisc => or1k}/test_sfgesi.c (100%)
>   rename tests/tcg/{openrisc => or1k}/test_sfgeu.c (100%)
>   rename tests/tcg/{openrisc => or1k}/test_sfgeui.c (100%)
>   rename tests/tcg/{openrisc => or1k}/test_sfgts.c (100%)
>   rename tests/tcg/{openrisc => or1k}/test_sfgtsi.c (100%)
>   rename tests/tcg/{openrisc => or1k}/test_sfgtu.c (100%)
>   rename tests/tcg/{openrisc => or1k}/test_sfgtui.c (100%)
>   rename tests/tcg/{openrisc => or1k}/test_sfles.c (100%)
>   rename tests/tcg/{openrisc => or1k}/test_sflesi.c (100%)
>   rename tests/tcg/{openrisc => or1k}/test_sfleu.c (100%)
>   rename tests/tcg/{openrisc => or1k}/test_sfleui.c (100%)
>   rename tests/tcg/{openrisc => or1k}/test_sflts.c (100%)
>   rename tests/tcg/{openrisc => or1k}/test_sfltsi.c (100%)
>   rename tests/tcg/{openrisc => or1k}/test_sfltu.c (100%)
>   rename tests/tcg/{openrisc => or1k}/test_sfltui.c (100%)
>   rename tests/tcg/{openrisc => or1k}/test_sfne.c (100%)
>   rename tests/tcg/{openrisc => or1k}/test_sfnei.c (100%)
>   rename tests/tcg/{openrisc => or1k}/test_sub.c (100%)
>   rename docs/system/{openrisc => or1k}/cpu-features.rst (100%)
>   rename docs/system/{openrisc => or1k}/emulation.rst (100%)
>   rename docs/system/{openrisc => or1k}/or1k-sim.rst (100%)
>   rename docs/system/{openrisc => or1k}/virt.rst (100%)
>   rename docs/system/{target-openrisc.rst => target-or1k.rst} (96%)
>   rename hw/{openrisc => or1k}/Kconfig (89%)
>   rename hw/{openrisc => or1k}/meson.build (60%)
>   delete mode 100644 linux-user/openrisc/meson.build
>   create mode 100644 linux-user/or1k/meson.build
>   rename linux-user/{openrisc => or1k}/syscall.tbl (100%)
>   rename linux-user/{openrisc => or1k}/syscallhdr.sh (100%)
>   rename target/{openrisc => or1k}/Kconfig (76%)
>   rename target/{openrisc => or1k}/insns.decode (100%)
>   rename target/{openrisc => or1k}/meson.build (79%)
>   rename tests/tcg/{openrisc => or1k}/Makefile (100%)
> 

For the whole series:
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

