Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B91DC25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 14:48:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5RXq-0003Be-PV; Fri, 10 May 2024 10:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5RXo-0003BA-I5
 for qemu-devel@nongnu.org; Fri, 10 May 2024 10:48:20 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5RXm-00011m-3H
 for qemu-devel@nongnu.org; Fri, 10 May 2024 10:48:19 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-41ba1ba5592so13566025e9.1
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 07:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715352496; x=1715957296; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qsxNULBHHF/vY6B1HK1W5EKuQE1EHyj8eHMSoZ0gXzo=;
 b=NMU0f/ARRoXFql68ouOed/nqwAvh6tq/ys93UoU6OQJEVlf176ZoEMAeieg9TKv/h4
 gDVmX05sSOSC2zu3KWdcHFhW9bCfOGH0jROKG4jY9pcS3c1GZu/f6LPIArRccOlV9pyd
 Mlz1mNC3o9K7jT6PTbRQSA+N6IUBTC8t8wKgdPMTQKbzuAVnp9ntbDpZsoxUEffRNATC
 GLCV/uFR3GA6bYYr32kHPLHoe0RkFnl6DRUA8lXgrV7dOm7pTFP1JsIp8hF25BycPKff
 C5WQmndFTRvQXnhOuMPXb+wVGEGYV+q6ZL+N5FQeFqSUvGio/atwIBm/ZfUop8yEVScm
 nalg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715352496; x=1715957296;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qsxNULBHHF/vY6B1HK1W5EKuQE1EHyj8eHMSoZ0gXzo=;
 b=igVtFtYb7d5wF7d2oW5mt9PpTKGY6veWkQ7VRWNBZGhgVBBxD8CXezau/8PY0R3L/4
 oKH1e9zq1tJqIljsVKdpWjRqQ39EfedjMAqfmaDAyVb4nx0WWliDXbccN2Vhcz3KDzQ7
 IKTA9cJLlDwby6RB1kLK5tQR6PPfPn1XDKSGPyoKuo8LHxrvOCymLtxA6MH1dRBuHQ/D
 H77Lr4MDwHBiGTs3bT0g9J8YSh3JYrOt88aIdMFC3hCbtWPJIzFZ+OfivzxPhldp5Jxh
 ynbNOQQJLbQbBTljCQCKEtCDsMPu78fJAlKLWn535E1xIVCpHbhY95I5HRF2N57lIYyl
 JKBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOcJaxCa1RSXwFcYB2i8UPF+AHjP3UgXbjtPJZ5txo+Dzw8+Tg//Ey+yxSVcvxTyFsT78Bn2vz2mOvW5FKvhLXIOQCi3Y=
X-Gm-Message-State: AOJu0YzTXlzgTX1Jh6sAM9utDdp6ce1JKGvp9ePlSfbHhYR5Mb5maxOL
 obsWR/757wg+cHKWH/XNzwmjyGXfBNkuYx1v4K0vthK+pUm854LhLRrXjQAU8lk=
X-Google-Smtp-Source: AGHT+IEVK90yea0ciIxM3FhBuUzHXVSz3b1Vq5j00s1ArdCR5dqT9bOcPDLHa2tuHqtpFDavDSNcRA==
X-Received: by 2002:a05:600c:1d0a:b0:41c:2699:dd9d with SMTP id
 5b1f17b1804b1-41feac55694mr29481695e9.28.1715352496098; 
 Fri, 10 May 2024 07:48:16 -0700 (PDT)
Received: from [192.168.69.100] (sev93-h02-176-184-17-152.dsl.sta.abo.bbox.fr.
 [176.184.17.152]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccce73f5sm67227505e9.21.2024.05.10.07.48.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 May 2024 07:48:15 -0700 (PDT)
Message-ID: <9e271098-ce7b-46ad-9eb8-b49b912eaa49@linaro.org>
Date: Fri, 10 May 2024 16:48:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/45] target/hppa: Misc improvements
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240425000023.1002026-1-richard.henderson@linaro.org>
Content-Language: en-US
Cc: Helge Deller <deller@gmx.de>, Sven Schnelle <svens@stackframe.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240425000023.1002026-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Cc'ing Helge & Sven as I'm going to skip this series.

Suggestion:

-- >8 --
diff --git a/MAINTAINERS b/MAINTAINERS
index 1b79767d61..be7535b55e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -254,6 +254,8 @@ F: target/hexagon/gen_idef_parser_funcs.py

  HPPA (PA-RISC) TCG CPUs
  M: Richard Henderson <richard.henderson@linaro.org>
+R: Helge Deller <deller@gmx.de>
+R: Sven Schnelle <svens@stackframe.org>
  S: Maintained
  F: target/hppa/
  F: disas/hppa.c
@@ -1214,6 +1216,7 @@ HP-PARISC Machines
  HP B160L, HP C3700
  M: Richard Henderson <richard.henderson@linaro.org>
  R: Helge Deller <deller@gmx.de>
+R: Sven Schnelle <svens@stackframe.org>
  S: Odd Fixes
  F: configs/devices/hppa-softmmu/default.mak
  F: hw/display/artist.c
---

On 25/4/24 01:59, Richard Henderson wrote:
> Most of the patches lead up to implementing CF_PCREL.
> Along the way there is a grab bag of code updates (TCG_COND_TST*),
> bug fixes (space changes during branch-in-branch-delay-slot),
> and implementation of features (PSW bits B, X, T, H, L).
> 
> Sven reported that PSW L tripped up HP/UX, so possibly there's
> something wrong there, but that's right at the end of the patch set.
> So I'd like some feedback on the rest leading up to that too.
> 
> 
> r~
> 
> 
> Richard Henderson (45):
>    target/hppa: Move cpu_get_tb_cpu_state out of line
>    target/hppa: Use hppa_form_gva_psw in hppa_cpu_get_pc
>    target/hppa: Move constant destination check into use_goto_tb
>    target/hppa: Pass displacement to do_dbranch
>    target/hppa: Allow prior nullification in do_ibranch
>    target/hppa: Use CF_BP_PAGE instead of cpu_breakpoint_test
>    target/hppa: Add install_iaq_entries
>    target/hppa: Add install_link
>    target/hppa: Delay computation of IAQ_Next
>    target/hppa: Skip nullified insns in unconditional dbranch path
>    target/hppa: Simplify TB end
>    target/hppa: Add IASQ entries to DisasContext
>    target/hppa: Add space arguments to install_iaq_entries
>    target/hppa: Add space argument to do_ibranch
>    target/hppa: Use umax in do_ibranch_priv
>    target/hppa: Always make a copy in do_ibranch_priv
>    target/hppa: Introduce and use DisasIAQE for branch management
>    target/hppa: Use displacements in DisasIAQE
>    target/hppa: Rename cond_make_* helpers
>    target/hppa: Use TCG_COND_TST* in do_cond
>    target/hppa: Use TCG_COND_TST* in do_log_cond
>    target/hppa: Use TCG_COND_TST* in do_unit_zero_cond
>    target/hppa: Use TCG_COND_TST* in do_unit_addsub
>    target/hppa: Use TCG_COND_TST* in trans_bb_imm
>    target/hppa: Use registerfields.h for FPSR
>    target/hppa: Use TCG_COND_TST* in trans_ftest
>    target/hppa: Remove cond_free
>    target/hppa: Introduce DisasDelayException
>    target/hppa: Use delay_excp for conditional traps
>    target/hppa: Use delay_excp for conditional trap on overflow
>    linux-user/hppa: Force all code addresses to PRIV_USER
>    target/hppa: Store full iaoq_f and page bits of iaoq_d in TB
>    target/hppa: Do not mask in copy_iaoq_entry
>    target/hppa: Improve hppa_cpu_dump_state
>    target/hppa: Split PSW X and B into their own field
>    target/hppa: Manage PSW_X and PSW_B in translator
>    target/hppa: Implement PSW_B
>    target/hppa: Implement PSW_X
>    target/hppa: Drop tlb_entry return from hppa_get_physical_address
>    target/hppa: Adjust priv for B,GATE at runtime
>    target/hppa: Implement CF_PCREL
>    target/hppa: Implement PSW_T
>    target/hppa: Implement PSW_H, PSW_L
>    target/hppa: Log cpu state at interrupt
>    target/hppa: Log cpu state on return-from-interrupt
> 
>   linux-user/hppa/target_cpu.h |    4 +-
>   target/hppa/cpu.h            |   80 +--
>   target/hppa/helper.h         |    3 +-
>   linux-user/elfload.c         |    4 +-
>   linux-user/hppa/cpu_loop.c   |   14 +-
>   linux-user/hppa/signal.c     |    6 +-
>   target/hppa/cpu.c            |   92 ++-
>   target/hppa/fpu_helper.c     |   26 +-
>   target/hppa/gdbstub.c        |    6 +
>   target/hppa/helper.c         |   66 +-
>   target/hppa/int_helper.c     |   33 +-
>   target/hppa/mem_helper.c     |   99 +--
>   target/hppa/op_helper.c      |   17 +-
>   target/hppa/sys_helper.c     |   12 +
>   target/hppa/translate.c      | 1232 ++++++++++++++++++----------------
>   15 files changed, 947 insertions(+), 747 deletions(-)
> 


