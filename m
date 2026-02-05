Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A47AECD981
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 15:46:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo1Yr-0001Jg-7M; Thu, 05 Feb 2026 10:46:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vo1Yo-0001ID-DO
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 10:46:26 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vo1Ym-0006iG-KL
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 10:46:26 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-43628a01c32so48834f8f.0
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 07:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770306382; x=1770911182; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LGGZlYNX//AY3489ZnoHGIdVTKj+NErPktciwKcwhbQ=;
 b=jINug98g/cRkP9ofBLG5oUlsyLiGv+9AoDqrfdWecFwkWkH1bCaiWWuyza5a/6hTaP
 9ZzhHiAYZJTW30xC32IJ25mQPkJfo+S+qf086JoPT/uzKUgd89QORvZglomJuyC7btn6
 S7anolOala4S4ZNI8yFKxu+4zisSBOx5V+X7NsR6krUlaJ8QBjDeXw551P8nWZWaBSZi
 dtndyev67KJcwJmAT7C6c8OlEZFSAtIvSyXH1VNfvrk+DNxi8L+HwCozYS3POI9C+Ubu
 EDh2xj9ytUfmRj4yp8CfltTT1Telt4BP+PzwIKJyNJhYcIZRIwiHGPkZQDruQOG+tZmk
 fevA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770306382; x=1770911182;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LGGZlYNX//AY3489ZnoHGIdVTKj+NErPktciwKcwhbQ=;
 b=W96K8AYXF33fjQGPC7dgGzPHntivymMx2naLYrYnJPGqM9c5c2XlbxY11tiJQ4u6Eg
 fWWYLziOe7JxdFkZl0msEVFJwHf0RO7kXoOt8PISAi6z4x6SGU5D9nR0BufAlBFTu7cZ
 n96ibwrJY8qVeFht0d7YMokBFwLm1jBtnYNJFX0PpT+u2EctmypyxjqaFyzkZaoDNbSa
 LFPCq1i8dQyCP4Aa+lCzT8AcinUg6Tf7dq+CcCN1/uiKeDjJDR3TR6aFG0LJaN7aA1Lm
 m1po3mlYR20hZ5CZe1AadU3QnJgu7pLONlsYuOMWZnb/RL2KktMBsqML7utAfzzQ0vFk
 bWqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUB2Axd7fh8f/5wpihmZp0hr1A+e/t+bBZX+Z8N6+qvEMGxCgnpW2GeKuaU2Hxn9BRRsXINXdirShHf@nongnu.org
X-Gm-Message-State: AOJu0Yy8bYFu04Dre6noQum0KmDa1DsH8oFjWhrkaPFOdYS4OQklKXdF
 8si+0U578+UbF06bj/XmfZViG6HeshPxJcv21DKFwewS3iNMu6kdsI3k7GbASvEgV/g=
X-Gm-Gg: AZuq6aIToqyqpt+HJLJhsCpnt7+jL1Zgxq44q88BwNHP080B9LticUxHvobZs0Yy2C5
 KP+QAWCNLiwRcjecAmiR0aJKBxWf8KJMdhV9qLLdAeF81IMSEYnBBwj61YmUivkiYTe+dYNgkna
 ehA5Fl+ZjMd5U3ov54XbVQf8zRqkO/vJ7iApKdhYnvjpXHzGkV6YMzU1S73UftJdvwTwtkMS1aj
 XdmWJUHPrQhS45Oteo8xJAVHaJiSGobw6DT55NmPYdP1Olol+whmPDtLMqf0Uv9nqd0E9G4nqPB
 w3qUKtZblZtV3qK37OPvM7Ysaud0U2WK5fG61p5GoQNLJOgpOqDCNvNUJtokqUoj1JmR+GyBgmU
 FDsIDJF1OqL4dEzRRl74JGujCJdugj1SaHc9Lb+n9Rmjg7Jh+ndNJsMjAJ/qELGEOZ3bEoHk2im
 /bbLS8yqvVsnvHb8yoSTfptevSfOTQnFz9xBG+FMesnjwiEUmBts/B/A==
X-Received: by 2002:a05:6000:26c8:b0:431:8f8:7f1a with SMTP id
 ffacd0b85a97d-436180552femr12307568f8f.31.1770306381584; 
 Thu, 05 Feb 2026 07:46:21 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43617e38fbbsm15531499f8f.13.2026.02.05.07.46.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Feb 2026 07:46:20 -0800 (PST)
Message-ID: <c85e5d5f-f29b-4ce4-a98a-8a37d8d45d70@linaro.org>
Date: Thu, 5 Feb 2026 16:46:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] target/or1k: Rename from openrisc
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, shorne@gmail.com
References: <20260205030244.266447-1-richard.henderson@linaro.org>
 <20260205030244.266447-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260205030244.266447-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 5/2/26 04:02, Richard Henderson wrote:
> This is the minimal change beginning with TARGET_ARCH in
> configs/targets/or1k-* from openrisc to or1k, then adjust
> TARGET_OR1K, QEMU_ARCH_OR1K, directory names,
> and meson.build to match.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/poison.h                             | 2 +-
>   include/system/arch_init.h                        | 2 +-
>   include/user/abitypes.h                           | 2 +-
>   linux-user/{openrisc => or1k}/sockbits.h          | 0
>   linux-user/{openrisc => or1k}/target_cpu.h        | 0
>   linux-user/{openrisc => or1k}/target_elf.h        | 0
>   linux-user/{openrisc => or1k}/target_errno_defs.h | 0
>   linux-user/{openrisc => or1k}/target_fcntl.h      | 0
>   linux-user/{openrisc => or1k}/target_mman.h       | 0
>   linux-user/{openrisc => or1k}/target_prctl.h      | 0
>   linux-user/{openrisc => or1k}/target_proc.h       | 0
>   linux-user/{openrisc => or1k}/target_ptrace.h     | 0
>   linux-user/{openrisc => or1k}/target_resource.h   | 0
>   linux-user/{openrisc => or1k}/target_signal.h     | 0
>   linux-user/{openrisc => or1k}/target_structs.h    | 0
>   linux-user/{openrisc => or1k}/target_syscall.h    | 0
>   linux-user/{openrisc => or1k}/termbits.h          | 0
>   linux-user/syscall_defs.h                         | 4 ++--
>   target/{openrisc => or1k}/cpu-param.h             | 0
>   target/{openrisc => or1k}/cpu-qom.h               | 0
>   target/{openrisc => or1k}/cpu.h                   | 0
>   target/{openrisc => or1k}/exception.h             | 0
>   target/{openrisc => or1k}/helper.h                | 0
>   linux-user/{openrisc => or1k}/cpu_loop.c          | 0
>   linux-user/{openrisc => or1k}/elfload.c           | 0
>   linux-user/{openrisc => or1k}/signal.c            | 0
>   system/qdev-monitor.c                             | 2 +-
>   target/{openrisc => or1k}/cpu.c                   | 0
>   target/{openrisc => or1k}/disas.c                 | 0
>   target/{openrisc => or1k}/exception.c             | 0
>   target/{openrisc => or1k}/exception_helper.c      | 0
>   target/{openrisc => or1k}/fpu_helper.c            | 0
>   target/{openrisc => or1k}/gdbstub.c               | 0
>   target/{openrisc => or1k}/interrupt.c             | 0
>   target/{openrisc => or1k}/interrupt_helper.c      | 0
>   target/{openrisc => or1k}/machine.c               | 0
>   target/{openrisc => or1k}/mmu.c                   | 0
>   target/{openrisc => or1k}/sys_helper.c            | 0
>   target/{openrisc => or1k}/translate.c             | 0
>   MAINTAINERS                                       | 2 +-
>   configs/targets/or1k-linux-user.mak               | 2 +-
>   configs/targets/or1k-softmmu.mak                  | 2 +-
>   hw/openrisc/Kconfig                               | 4 ++--
>   hw/openrisc/meson.build                           | 2 +-
>   linux-user/meson.build                            | 2 +-
>   linux-user/openrisc/meson.build                   | 5 -----
>   linux-user/or1k/meson.build                       | 5 +++++
>   linux-user/{openrisc => or1k}/syscall.tbl         | 0
>   linux-user/{openrisc => or1k}/syscallhdr.sh       | 0
>   target/Kconfig                                    | 2 +-
>   target/meson.build                                | 2 +-

s/openrisc_system_ss/or1k_system_ss/?

>   target/{openrisc => or1k}/Kconfig                 | 2 +-
>   target/{openrisc => or1k}/insns.decode            | 0
>   target/{openrisc => or1k}/meson.build             | 4 ++--
>   54 files changed, 23 insertions(+), 23 deletions(-)
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

Being picky, we could also rename the header guards (i.e.
OPENRISC_TARGET_CPU_H and OPENRISC_TARGET_*_H).

