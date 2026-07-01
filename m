Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68041C43602
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 03:08:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1welHb-00005W-46; Tue, 30 Jun 2026 23:06:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1welHY-0008VS-CI
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 23:06:36 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1welHW-0003pK-Mf
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 23:06:35 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-8453427d3f4so79741b3a.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 20:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782875193; x=1783479993; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ls0T9EHio6ON4SVMOxDwfUlFQWjpZwELz7O6LMgd1Rg=;
 b=Qy7okZTjDCgzczLBIwg3kmnRnQOUuhcRZujoALx7GFwESArOKmEafPHzGnb5uTkvsJ
 MKad1lGi0PPo1lS+UvbUVkwngIO6ptGOB79JqhpDcEcc2CqpDVIIDm/JCc0YMDh2W3xK
 cHNrfOjruSVCX+NgQdgRMmTICQxpIRruO2dUtnQbNa82foQeZ+sDYObCjMSiyp8C1fWC
 AzvnGv4RNSOVdi51AY/RlAsZW9JJUPUnidb3YS+YdMYGahftpD7r3SKkxhmuIHWqmLxV
 osVk5+EmEaKk6cKdQmftXcHVsbAd0qFgRvVhpveQbShlELEYkymILmc7yYmt/XPkxGg9
 dyYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782875193; x=1783479993;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ls0T9EHio6ON4SVMOxDwfUlFQWjpZwELz7O6LMgd1Rg=;
 b=ZB+DTP8ci8Or5+eXQjzINAXpxhr76C49DHpAYeqPTyKva+X7Q5yryvU2uh1DrcgOaX
 7eJK6kd88ZUvnbtvDNtV4yaBmmd++W+ggHlfCcocTpUvCaS4ekRcAVuoOISe0U05+8J8
 JTSWQzhnPi55c9Jz5QWnie2oasX45S+mlK4gRknCnJ4cTfCyl8Tqw/0esuTqAsi6viJb
 5Xlk3JI5TDepKj1Biy90LkgHJwPWWk86AqE1xd4kQ3+ju/eVa5JpHyKjX1FSSIz8jQtZ
 2QtR64o8HntLQ1BoxvjxMT5agLJPzbODm15JJP5MDODg87lZlxqjvM8qAeMn3SRHP9Vk
 HRUQ==
X-Gm-Message-State: AOJu0YyT+lKVwulW5z4e2QTXfDNQUXtsCJE/umtZGz4orc1XyNzJwTOP
 gnsAFha9+I9AeCkiPlFuL5t7BhLU5SfPnrZf+pJ4U8cq+bEEjyvfBbvQtb1xyRcgpANt+4ENilB
 vIMgT
X-Gm-Gg: AfdE7ckGC/bpFBw1BZZT/FypcqSj6+b2bW34w/xzhGqxg565RnRbSV3mfAVtofDh7XH
 fmynr/aoULjJ9wA6F+bmMlg0VVbXc+9v6n5/R3iMkSCdYUNz8fTZY+wnx/8B/oSt488IiCIhhGv
 Z73ac76b9PQl5/+yO6KavzpquBL16HwUonXA3S3jGOhxdhaDFnd/Tqn4IHGxj3Xfg1ilb1iLzTf
 FmosSQhagfJfmxho27MTJsoIdl09g7oiCZJdpKnaBdxJRGyJqMxSStgE70/gqn2/C/iomY0lKra
 ssIQLzwkXpbEcNPoEtHnn0Jl5kLZoJ2/2n31sJO8DUWelXzP0YaA8nEDdEE7QiXbB02Uhv77aFN
 1pAcPKFsq/aL18OQjRNqiLvBxKm+mM/zqQiic6SDoek9av+p1hwGAgiG1yqOP5ixz202MuJBRIr
 y1L+3tyzc4Jhzp7NnKZTqAt7eUoGPDYLTcRhbba7JzZlpzcFJQDUdvra/ZDQ==
X-Received: by 2002:a05:6a00:4fc9:b0:846:4d4c:23f8 with SMTP id
 d2e1a72fcca58-847add62e06mr2948367b3a.1.1782875192944; 
 Tue, 30 Jun 2026 20:06:32 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847a0329c22sm3076883b3a.40.2026.06.30.20.06.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 20:06:32 -0700 (PDT)
Message-ID: <00f3bf40-b9da-462f-aac4-b956163193a5@linaro.org>
Date: Tue, 30 Jun 2026 20:06:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/17] accel/tcg: Use IntervalTree for breakpoints and
 watchpoints
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: shivangu@linux.ibm.com, qemu-arm@nongnu.org, qemu-riscv@nongnu.org
References: <20260701030443.1382447-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260701030443.1382447-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 6/30/26 20:04, Richard Henderson wrote:
> Follow-up to 20260630171555.114844-1-shivangu@linux.ibm.com
> ("[RFC PATCH 0/2] change cpu->breakpoints to a GTree")
> 
> Beyond using interval-tree for breakpoints:
> 
>    - Pass the matching breakpoint to the target debug hook,
>    - Allow the target to record an id/index for each BP or WP
>      so that the target doesn't have to search for which item
>      triggered, so that the target doesn't have to search again.
>    - Convert both BP and WP to IntervalTree.
> 
> 
> r~

Bah.  I was mid-rebase for this, and it's missing the CPUWatchpoint work.
I'll send a v2 tommorrow.


r~

> 
> 
> Richard Henderson (17):
>    accel/tcg: Pass CPUBreakpoint to debug_check_breakpoint
>    accel/tcg: Constify CPUWatchpoint for debug_check_watchpoint
>    cpu: Move cpu_breakpoint_test out of line
>    exec/breakpoint: Move BP declarations from hw/core/cpu.h
>    qemu/typedefs: Declare CPUBreakpoint and CPUWatchpoint globally
>    *: Add missing include of exec/breakpoint.h
>    hw/core/cpu: Remove exec/breakpoint.h include
>    exec/breakpoint: Introduce BP_CPU_ID_SHIFT
>    target/arm: Split is_wp out of bp_wp_matches
>    target/arm: Set ID for watchpoints and breakpoints
>    target/arm: Use bp argument in arm_debug_check_breakpoint
>    target/arm: Use wp argument in arm_debug_check_watchpoint
>    target/riscv: Set ID for watchpoints and breakpoints
>    target/riscv: Use bp argument in riscv_cpu_debug_check_breakpoint
>    target/riscv: Use bp argument in riscv_cpu_debug_check_watchpoint
>    target/xtensa: Use BP_CPU_ID_SHIFT
>    cpu: Use interval-tree for CPUBreakpoint
> 
>   include/accel/tcg/cpu-ops.h         |   4 +-
>   include/exec/breakpoint.h           |  39 ++++++++--
>   include/hw/core/cpu.h               |  39 +---------
>   include/qemu/typedefs.h             |   2 +
>   target/arm/internals.h              |   4 +-
>   target/ppc/internal.h               |   4 +-
>   target/riscv/debug.h                |   4 +-
>   target/xtensa/cpu.h                 |   2 +-
>   accel/tcg/cpu-exec.c                |  48 ++++++------
>   accel/tcg/tcg-accel-ops.c           |   1 +
>   cpu-common.c                        |  54 ++++++++-----
>   gdbstub/system.c                    |   1 +
>   gdbstub/user.c                      |   1 +
>   hw/core/cpu-common.c                |   1 -
>   linux-user/main.c                   |  13 +++-
>   system/watchpoint.c                 |   1 +
>   target/arm/tcg/debug.c              |  76 ++++--------------
>   target/i386/cpu.c                   |   1 +
>   target/i386/kvm/kvm.c               |   1 +
>   target/i386/machine.c               |   1 +
>   target/i386/tcg/system/bpt_helper.c |   1 +
>   target/i386/tcg/tcg-cpu.c           |   2 +-
>   target/ppc/cpu.c                    |   1 +
>   target/ppc/tcg-excp_helper.c        |   4 +-
>   target/riscv/debug.c                | 116 ++++++----------------------
>   target/xtensa/dbg_helper.c          |  19 ++---
>   target/xtensa/helper.c              |   1 +
>   27 files changed, 174 insertions(+), 267 deletions(-)
> 


