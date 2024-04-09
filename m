Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 079A7CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 09:44:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru80u-0006tr-Ll; Tue, 09 Apr 2024 05:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1ru80r-0006t5-Id
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 05:43:34 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1ru80o-00073w-Ir
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 05:43:33 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6e6888358dfso3241797a34.2
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 02:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1712655809; x=1713260609; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y3Kcrz1FLMcB5NuIbKjq1jK9dIrPfEZZQKCZyAyPH2E=;
 b=BQj83RTsY+0PBrqd4Hi1ILva6gKSQ2vvkD5wzuPCagEF7o7AKtd5hIXJjipoaPgP9y
 n+lKv3ha6cMiw0yTknKLYfMYIXJR9R9DuR5JxURiSS5ooqay6uUBEF5cP/3KQcUDzONR
 SJZoPn1dDNOeBKhnIcEcc29JMXz3nASZNKfahKXSnthY0rsLroahoMLQles2SP4Uw5c5
 kc9ZIJyK3ypCLEN92QDg3+elEOx+b0m4NR1Orr6mFi0yslEQvtd/vxdPrGeiPUjbfEVk
 OOitlSjLJtYVoI9ktZPiEIpayMlyl7LQQ+rS75E427yBHFSekc4+kKSL3Z8hsrgafm40
 sLZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712655809; x=1713260609;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y3Kcrz1FLMcB5NuIbKjq1jK9dIrPfEZZQKCZyAyPH2E=;
 b=T1cPMGxvo1negfFU8BhTyu2bmUs2Zb8VS4UncAi6hg6mk6ntmkWQ5Rf3SUZT9d18Gy
 aYKog75Ca16VLCUSkwtJp7BrJpcN+qswq1Ga6SVaVS4cQZ1hAqGAV/PE/TfV2M945DTn
 zl8GlthrEFqESK27MocmPtiYb6jbsMoukur018aggTBWCQzNkjAj0xYtACs9NyS6jAlg
 ReKMwbqcv0+2xn0TsGRviUZt2QnywJqO4OaV7STPdzn648CueLY/Igom/bGr8h/5N325
 slYE7hEI9+c+m0p21xxk3VZSts36M3bl3X8dt3OEI7NJoth/bEWw2AfbDpG9+DFK8Epo
 PLlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWF+pqU/hB2XPsNcwT52Uy0jIbWJW3ilUf3IyXU1lXEGDAv61+RdLnydKgMO1BfTpzUiQDwr+enagb6u7GCpuiNSd1eeQY=
X-Gm-Message-State: AOJu0Yyk7yhM+3F61jEfxZAPpdpySzmGY20o2B4f3QTz6uE2qhhaggXD
 Obh01UpXjUbRwUTRqFwv7SteCqFgxBOf6oXkZYsD6v/lOtqqdMfnKBg6NO/yL2o=
X-Google-Smtp-Source: AGHT+IH4IktjB8mMaJogDytSVS9S5Vt5375+G32YoPrq1yufjm8o4s7v5DOGby7jRYalUfyVpB5ppg==
X-Received: by 2002:a05:6808:a9b:b0:3c5:fc44:643d with SMTP id
 q27-20020a0568080a9b00b003c5fc44643dmr2717889oij.54.1712655809012; 
 Tue, 09 Apr 2024 02:43:29 -0700 (PDT)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 t5-20020a635345000000b005e83b3ce8d9sm7825413pgl.8.2024.04.09.02.43.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Apr 2024 02:43:28 -0700 (PDT)
Message-ID: <7e9cd605-04aa-41d9-af97-aaaadc347a39@ventanamicro.com>
Date: Tue, 9 Apr 2024 06:43:25 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] target/riscv: Support Zve32x and Zve64x extensions
Content-Language: en-US
To: Jason Chien <jason.chien@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <20240328022343.6871-1-jason.chien@sifive.com>
 <CADr__8p1Gzg1u3Rk4EuT8k1nJyjDdXuMCfN7GZLLgWDJN3piSg@mail.gmail.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <CADr__8p1Gzg1u3Rk4EuT8k1nJyjDdXuMCfN7GZLLgWDJN3piSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Jason,


We're in the middle of code freeze for the incoming 9.0 release. In this
period the maintainer will only queue bug fixes.

Your support is a new feature, so it'll only be pushed after the release is
done. Current ETA for the release is Apr 16th if there's no rc4. A safe
bet is to expect Alistair to queue the patches in the start of May.


Thanks,

Daniel



Perhaps we should start advertising the freeze dates more clearly in the
qemu-riscv ML.

On 4/9/24 03:29, Jason Chien wrote:
> Ping.
> 
> Jason Chien <jason.chien@sifive.com <mailto:jason.chien@sifive.com>> 於 2024年3月28日 週四 上午10:23寫道：
> 
>     This patch series adds the support for Zve32x and Zvx64x and makes vector
>     registers visible in GDB if any of the V/Zve*/Zvk* extensions is enabled.
> 
>     v2:
>          Rebase onto riscv-to-apply.next (commit 385e575).
>     v3:
>          Spuash patch 2 into patch 1.
>          Spuash patch 4 into patch 3.
> 
>     Jason Chien (3):
>        target/riscv: Add support for Zve32x extension
>        target/riscv: Add support for Zve64x extension
>        target/riscv: Relax vector register check in RISCV gdbstub
> 
>       target/riscv/cpu.c                      |  4 +++
>       target/riscv/cpu_cfg.h                  |  2 ++
>       target/riscv/cpu_helper.c               |  2 +-
>       target/riscv/csr.c                      |  2 +-
>       target/riscv/gdbstub.c                  |  2 +-
>       target/riscv/insn_trans/trans_rvv.c.inc |  4 +--
>       target/riscv/tcg/tcg-cpu.c              | 33 ++++++++++++++-----------
>       7 files changed, 30 insertions(+), 19 deletions(-)
> 
>     -- 
>     2.43.2
> 

