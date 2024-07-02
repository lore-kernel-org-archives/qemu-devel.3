Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3192EC30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 19:56:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjbe-0005MG-Te; Tue, 02 Jul 2024 15:56:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOjbc-0005LU-Dn
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 15:56:00 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOjba-0007zD-Jb
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 15:56:00 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-425814992aeso17954165e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 12:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719950157; x=1720554957; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jAkiePLfhkXU8nz4iHMlaIsbatin0g/vxYYhhk0TeqI=;
 b=PO1f5nwKpolgPqG9stKX8TSZ5eG0rv7XOz41OFIzAnfIsUUAUGo1Eei0pmd68YMCa5
 l/WB7D5WfenyXxC8o6AqRDwdsQ7NDaqJ5FC23tLoub6va/cp6+JPYgz5aRi4oVyEb/HK
 flDKgy7ypDiJTi2s2joZjuDVuthW9L3mcAXX7mTtGyy/oI0NOcwfjM33b1pQyNCilza3
 AId48dvlnTVaxKui63sTVKzgstFyB1PXY/Ry5QeGloYgR+/yayeQUOQkkpg9IwkKIIjc
 rMjrzL/ywdVWovmvm3xx/DYULwCsPlPUhbzSOLQe/cri1u978H7cW7AN+ha3UvqQgFvh
 he0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719950157; x=1720554957;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jAkiePLfhkXU8nz4iHMlaIsbatin0g/vxYYhhk0TeqI=;
 b=WVXEJt565UKfTCmZnd7Daaf2LmKo5J7P/dNQZCjVbv8MmHV2fyS5EMGzw2v3mHlwsW
 v5y7qTT5pj5vTFxkDfNfz/Vc2bfYW6+wQPZWdKpQ/GZj9MjNib2CtJbHy3ikfdx847n5
 aaAw2aKXTE3bQMR9I7BEcG9AQm3zqrcCKfcqdkcL1TS5XJZIQnaiMhEDfYrjy/CAoFXu
 lcI9Wwj+ZYy0l5gvywPQ5+67TM0omQn3OevPAmb62sy09iQ4D74RKV1y1rzdPPUS15tf
 VBKCZ99WRMtMw6XRhp565RGIrAyrtEoaH302Qv4nnaTrPUH6G9KWcfZh0yjIRLlGj/BQ
 bIWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXV5I0KkUtXA9NoYEEQPmFdUiF8byeDmsi0bDfl+hBjv/RrACVvzD/HgOOe8IG9Oz/v5eECbEfk0i1krjyLA1QOnjNIpoQ=
X-Gm-Message-State: AOJu0YxJ1+/wXRmAglcNU+hMlEgeaa6vQA91R/Hh17kUkxHfrzJkXEyZ
 ivAEU6eZgOkypWP2+IzNq8DPxKPTvXyOmr+ET+him5Af8hbT/1LKaHB64zlcHos=
X-Google-Smtp-Source: AGHT+IGqDB0I/oF8VbHP2A9WTBqINuGagYgxVTlEVQhsOX9AYYrq07LVQvG72Yb0JzVWZUxEukz2oA==
X-Received: by 2002:a5d:64e8:0:b0:360:9d4b:5b82 with SMTP id
 ffacd0b85a97d-36775721583mr8251455f8f.47.1719950156545; 
 Tue, 02 Jul 2024 12:55:56 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.220.97])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a1030dfsm14032796f8f.100.2024.07.02.12.55.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jul 2024 12:55:56 -0700 (PDT)
Message-ID: <360734c3-df2a-49cb-892a-0eb7953fa1c1@linaro.org>
Date: Tue, 2 Jul 2024 21:55:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] util/cpuinfo-riscv: Support host/cpuinfo.h for riscv
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: brad@comstyle.com, Alistair.Francis@wdc.com, palmer@dabbelt.com,
 qemu-riscv@nongnu.org
References: <20240627180350.128575-1-richard.henderson@linaro.org>
 <20240627180350.128575-2-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240627180350.128575-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 27/6/24 20:03, Richard Henderson wrote:
> Move detection code out of tcg, similar to other hosts.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   host/include/riscv/host/cpuinfo.h | 23 +++++++++
>   tcg/riscv/tcg-target.h            | 46 ++++++++---------
>   util/cpuinfo-riscv.c              | 85 +++++++++++++++++++++++++++++++
>   tcg/riscv/tcg-target.c.inc        | 84 +++---------------------------
>   util/meson.build                  |  2 +
>   5 files changed, 139 insertions(+), 101 deletions(-)
>   create mode 100644 host/include/riscv/host/cpuinfo.h
>   create mode 100644 util/cpuinfo-riscv.c


> +/* Called both as constructor and (possibly) via other constructors. */
> +unsigned __attribute__((constructor)) cpuinfo_init(void)
> +{
> +    unsigned left = CPUINFO_ZBA | CPUINFO_ZBB | CPUINFO_ZICOND;
> +    unsigned info = cpuinfo;
> +
> +    if (info) {
> +        return info;
> +    }
> +
> +    /* Test for compile-time settings. */
> +#if defined(__riscv_arch_test) && defined(__riscv_zba)
> +    info |= CPUINFO_ZBA;
> +#endif
> +#if defined(__riscv_arch_test) && defined(__riscv_zbb)
> +    info |= CPUINFO_ZBB;
> +#endif
> +#if defined(__riscv_arch_test) && defined(__riscv_zicond)
> +    info |= CPUINFO_ZICOND;
> +#endif
> +    left &= ~info;
> +
> +    if (left) {
> +        struct sigaction sa_old, sa_new;
> +
> +        memset(&sa_new, 0, sizeof(sa_new));
> +        sa_new.sa_flags = SA_SIGINFO;
> +        sa_new.sa_sigaction = sigill_handler;
> +        sigaction(SIGILL, &sa_new, &sa_old);
> +
> +        if (left & CPUINFO_ZBA) {
> +            /* Probe for Zba: add.uw zero,zero,zero. */
> +            got_sigill = 0;
> +            asm volatile(".insn r 0x3b, 0, 0x04, zero, zero, zero"
> +                         : : : "memory");
> +            info |= !got_sigill * CPUINFO_ZBA;

A bit too optimized to my taste, 'if (sigill) info|=ZBA' would be 
simpler to follow. Otherwise,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +            left &= ~CPUINFO_ZBA;
> +        }


