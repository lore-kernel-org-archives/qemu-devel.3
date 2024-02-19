Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2148FC48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 20:48:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcAXj-00026C-M4; Mon, 19 Feb 2024 15:47:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcAXV-00023Y-Lw
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 15:47:02 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcAXT-00064I-VC
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 15:47:01 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1dc139ed11fso956045ad.0
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 12:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708375617; x=1708980417; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8nwfjGk3alc5O/sDmzJYzN1Uxb/tlp5fmZQrLJEwAZ4=;
 b=iWUIe0wxY2MzYMfBxOe8RV4ZTT9/iyDOqnhfFsuUKikoaAj17yNFZmmwyWielcaj/k
 zvnxmcqhHykMd0hw2kMBZVKQpy2Bhxk47srt3K34Wo3VrcoXHMk/fVx0pVQrlbHDaHJT
 iqqU4XDQVkm7GogrdhQpDF9nnGFSV5cWY10IYewVJkEM98FoUPfbV+RyBj0QrtaDtI4g
 nvTNL7RyBMwOItd0VQMatxLlGrEpXT38NnryImzBk6qlvxTuZT2r1/niFc8xBHNbdcbA
 /8sV1tFsrZeCHVHMH1I9eaRZikfLiuhoGReIGTebjlc90dSBlQQECPdDsHsMu8Y+09js
 l0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708375617; x=1708980417;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8nwfjGk3alc5O/sDmzJYzN1Uxb/tlp5fmZQrLJEwAZ4=;
 b=wQ809hSK12H9hGECoPGx+HcHrygzw/9z+h506HVLK71KMzCgXN5WZZ1qX/dHa9NUGK
 QRVGk3DXRO60AvCUAf6E2b7+7VUtBLK/+mJwwe0ZnkD2g37yK1d8iolVTBxFa8GKIk9V
 mlonDF59lJfdh6nSYGMqdKsaQlAKLVed5XiRcDHzooEbiqd9GTagMEoQEXS5BME9bNXN
 Huo+sTYpkTY8uAFLfrzMOlokH78d+mGC+WOuyoM38E+qaXdB69qB+4Ufk+F0a5HUG47L
 FZQXEQw6EGPMiFTst/CygO9XCpIup89z42XslPtzyqG2UBwMEzXSriQmd6rrD4Njjc2R
 SmHw==
X-Gm-Message-State: AOJu0YwuEGJoDkFFB6hpWC0m5WwWv1eaUNRByvgXaJa5vB4zQhmu8kr4
 XmIX9357WMlL0KggEdayZBuWeSYVgikVOLSBYVCsLQdGlm11ihtm60RBKHpJgpY=
X-Google-Smtp-Source: AGHT+IEw07tSeNPCh2YDQGxAHEX8icW1shE10ECtJgQuztSEK8n9KOTtSGFy/DSK6Pc9QsiPinCAdg==
X-Received: by 2002:a17:902:f64f:b0:1d9:df9a:722f with SMTP id
 m15-20020a170902f64f00b001d9df9a722fmr18479996plg.17.1708375617449; 
 Mon, 19 Feb 2024 12:46:57 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 w11-20020a170902c78b00b001db81640315sm4866229pla.91.2024.02.19.12.46.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Feb 2024 12:46:57 -0800 (PST)
Message-ID: <485099f9-90fa-488a-9b45-3bbd43b48077@linaro.org>
Date: Mon, 19 Feb 2024 10:46:53 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/12] {linux,bsd}-user: Introduce get_task_state()
To: Ilya Leoshkevich <iii@linux.ibm.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel <qemu-devel@nongnu.org>
References: <20240219141628.246823-1-iii@linux.ibm.com>
 <20240219141628.246823-3-iii@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240219141628.246823-3-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 2/19/24 04:15, Ilya Leoshkevich wrote:
> A CPU's TaskState is stored in the CPUState's void *opaque field,
> accessing which is somewhat awkward due to having to use a cast.
> Introduce a wrapper and use it everywhere.
> 
> Suggested-by: Alex Bennée<alex.bennee@linaro.org>
> Signed-off-by: Ilya Leoshkevich<iii@linux.ibm.com>
> ---
>   bsd-user/bsd-file.h           |  2 +-
>   bsd-user/qemu.h               |  5 +++++
>   bsd-user/signal.c             | 20 ++++++++++----------
>   gdbstub/user-target.c         |  4 ++--
>   include/user/safe-syscall.h   |  2 +-
>   linux-user/aarch64/cpu_loop.c |  2 +-
>   linux-user/arm/cpu_loop.c     |  4 ++--
>   linux-user/arm/signal.c       |  2 +-
>   linux-user/cris/cpu_loop.c    |  2 +-
>   linux-user/elfload.c          |  6 +++---
>   linux-user/hppa/signal.c      |  2 +-
>   linux-user/linuxload.c        |  2 +-
>   linux-user/m68k/cpu_loop.c    |  2 +-
>   linux-user/m68k/target_cpu.h  |  2 +-
>   linux-user/mips/cpu_loop.c    |  2 +-
>   linux-user/ppc/signal.c       |  4 ++--
>   linux-user/qemu.h             |  5 +++++
>   linux-user/riscv/cpu_loop.c   |  2 +-
>   linux-user/signal-common.h    |  2 +-
>   linux-user/signal.c           | 30 +++++++++++++++---------------
>   linux-user/syscall.c          | 26 +++++++++++++-------------
>   linux-user/vm86.c             | 18 +++++++++---------
>   linux-user/xtensa/signal.c    |  2 +-
>   plugins/api.c                 |  8 ++++----
>   semihosting/arm-compat-semi.c |  8 ++++----
>   25 files changed, 87 insertions(+), 77 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

