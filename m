Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA56BC43458
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2026 16:25:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wg3A5-0000ad-U8; Sat, 04 Jul 2026 12:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wg3A4-0000XS-KH
 for qemu-devel@nongnu.org; Sat, 04 Jul 2026 12:24:12 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wg3A3-000107-7x
 for qemu-devel@nongnu.org; Sat, 04 Jul 2026 12:24:12 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-845f2909cd4so1054627b3a.1
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2026 09:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783182249; x=1783787049; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pJZ77teF1uPKH3EKjwQxrT5ZFaP5BDuJbluVHjodctw=;
 b=g7QbjOzzVI0Oge0kgk+Hfrz1JgjSfLJ64x4vmCLCygWtxa6Vke9nBdRG4lBOU2MjI5
 Pk8RtWEl7XA7MhuBCORHK6vMGTre16uDPGkxLur17hmcFX1GVzKqcP8nBxPlinXA8mcy
 aGtvGTKb9zS4umP8YCvEnDT8idA+FYB837hSkZrcuDZKhcoPvUXT8AgNkmh5zy4FUTGP
 hTX+KLkK9yTMIjm0RorVt7s2upeWfn5gd6uRa/C6ssbPnXSs0ErYXJhXT6BH2dxfk/zJ
 kFxQznK8a3kHigwMqpO+6d7vKy/eeV/HdLuNzLRO3GnICdcS00GP8ymqIz6rGLNL/AXd
 7cdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783182249; x=1783787049;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pJZ77teF1uPKH3EKjwQxrT5ZFaP5BDuJbluVHjodctw=;
 b=cmAl6uIl9CXy9WCYdHGBDbuGq5hFXOgpfOHnbRmWFJai3KmPdFsKAnxf86Hy4fUp2H
 lDB233hvIGxMtjeRPgDIP8DV9ZR9u6NCNV6YzgbdC4yrYB/fzUuxuBancQzPbMg4dFRG
 dWVMVKBx3pz/wnynbyo5o9hyBCEl5OyJB6WdqDvTbmOvK/E8qDCFuAWCOyg2h3q9/2/t
 bmCcAb9XUD3sK2ybh5dBUobIc+D/OI74d0RZvR8yC+qreYB3oT3RZG76wNlm/uVuKp1n
 7eZdmYAUnSflAk3kxYVgro/2FUgY7bXb++EDZJtPtjcizdwGOriNssM16wI36GiQdv3D
 yjyQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RouoDA75GaOgf8LNnfu4m8aJwYKDWtBX80JLKHnv3IWLjTS5JdJJA3MK4TVZK8pNj30rydLcZyTl8b5@nongnu.org
X-Gm-Message-State: AOJu0YyssQ8TZo0qgmCUuxRC8kdvnIiCrCWn6Jy4oHn8CsOaoY3CURv4
 brVRAGWGtSmTN3fDs1QGGd+h7g1qwQfRe+hu+JFLjPbyN8E9Lj2oQp6qWMJt71bZiZ0=
X-Gm-Gg: AfdE7cnpIe9CfmXyf8JOa4eNRzMdBc1b3za5uVe4SVhs4YWX6aWWvg7j9dflZwfLbUm
 LlZ/BZIbY8TX7NFR4a+B3L+rOwklApusmqurN1A3Tg3b1IiaWEISeJlrcQFp6m1jHFbxRd1nki2
 KGafeVHriesZMC5/Y942Sqs+SbLXOpzo5XF+58IOPCQjOXPIidF7RpK7ClTjA9lahhisdO9a320
 VHTZEFTwCnTdKSVMgvgQ4FyB9k6BHIVr7p9bTWQjslajw4XkGKFjhOAACZNftANyzm5QTSrwG87
 N22n28KLh/z9X/XkXOdtNAxeOvoSeTjgQWB0R2rZC/pIrijITJ49C6JNkaV0uFJfdJnCHouSzCi
 RvjyIjSNyaUNhKHFFLdXSrEh4IXH7BpIrK31T/RZTbnjUur1tKpHuOpEiJxB6ZyOuYbKizeaHNI
 V1Tt/c2W9N59Wh3EAP/HMYFlTSZW/QY9WbfBlgob91/MLhtFGVy2oqz4c=
X-Received: by 2002:a05:6a00:3cc8:b0:845:eb88:3d74 with SMTP id
 d2e1a72fcca58-847f6f21442mr3453178b3a.29.1783182249114; 
 Sat, 04 Jul 2026 09:24:09 -0700 (PDT)
Received: from [192.168.0.4] (71-212-39-188.tukw.qwest.net. [71.212.39.188])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847f6b62186sm1369043b3a.2.2026.07.04.09.24.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jul 2026 09:24:08 -0700 (PDT)
Message-ID: <6fd37365-5e4e-4fdb-8764-cf9cf99a676c@linaro.org>
Date: Sat, 4 Jul 2026 09:24:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 29/33] cpu: Move CPUWatchpoint definition to
 'exec/watchpoint.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, qemu-s390x@nongnu.org,
 Xiaoyao Li <xiaoyao.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 alex.bennee@linaro.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260703163757.55500-1-philmd@oss.qualcomm.com>
 <20260703163757.55500-30-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260703163757.55500-30-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 7/3/26 09:37, Philippe Mathieu-Daudé wrote:
> Define CPUWatchpoint in "exec/watchpoint.h", including this
> header where appropriate.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/accel/tcg/cpu-ops.h |  1 +
>   include/exec/breakpoint.h   |  9 ---------
>   include/exec/watchpoint.h   | 12 ++++++++++++
>   target/arm/internals.h      |  1 +
>   gdbstub/system.c            |  1 +
>   target/arm/hyp_gdbstub.c    |  1 +
>   target/i386/kvm/kvm.c       |  1 +
>   target/ppc/kvm.c            |  1 +
>   target/s390x/kvm/kvm.c      |  1 +
>   target/xtensa/helper.c      |  1 +
>   10 files changed, 20 insertions(+), 9 deletions(-)

FYI, I'm working on unifying the CPUBreakpoint and CPUWatchpoint structures.


r~

