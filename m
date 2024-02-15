Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE247C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 20:04:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rahx5-0002i5-Dk; Thu, 15 Feb 2024 15:03:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rahx3-0002gh-Lg
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 15:03:21 -0500
Received: from mail-il1-x130.google.com ([2607:f8b0:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rahx2-0003SK-8j
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 15:03:21 -0500
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-364f8246c8cso1910445ab.2
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 12:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708027397; x=1708632197; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hV7m/yFuhhEeiyh28P6oKjcSbDOB+OMGn198eFDqX0Q=;
 b=wjix1vFwMabeFxsLnTeCTMtEgTY6KorBzTrbWaq5n70iJCmLPg6rUPB3cFa2RbXkw8
 DmnoWgBzwooG0uAC68QwOkqw3Pf5tr19ozUV9r7aIRzisS2qtv0pgqBAVbBsPpjEUM+c
 dYstyGHsQLq9s21+ZHcXzsiaSXak6lO6vymE8XcAFk8hQ7+V4ncFbfAz9HFSHYLwWVNO
 oi9pX2MQZHZKZaiSKNdMY21xZbvfDHL69/ypejSK2chFvtx1dx35fgDe/jmW7jOIE2f3
 9J2KZGrM1P+2V2vsciZ8zuf/znRkkZEkcXqxH6CTUPBCxHO1o/kwDFM6eh0Jkz2Hslv3
 MTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708027397; x=1708632197;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hV7m/yFuhhEeiyh28P6oKjcSbDOB+OMGn198eFDqX0Q=;
 b=ePHTvA03E2q8S1//F/mipJnHEmcKFBI34YbKXz4W00fl0rmSpp+1MQq85uCoXU1ULA
 dDul/aLXNEzKxD7CJPM9nB+yQwGWz0quV9Cr5oflY6Vqccmm4e18vHjKWrnpl3MnQJWn
 xxX6e8hVVIQTU8m/tkbQb6Ifg/XgDpM0Zp4kCn7R3JE78TEebzxqJDn9UQ1iUCWOqf0t
 Z/ot3tbNMk3RRG13taH8bDVOhSlGyFuP9tkK8rRpUNhlrZbYSnl+1n+FcI+udwsNtmHl
 v6v2sET8+q2fxvMSnAVJMgAulhdfQZbzEbEseL6tjGh5hCvLorHK5bdRXEcIaJnkzQLT
 U+Dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUh0p5Bf5qrhZE4tvXN1q30vTuczfyXueBChInsolEv5ycYprjC9TPKKlmpdu0IKgritQe7jNV1evYji/lQ1RLqAsH5Q1g=
X-Gm-Message-State: AOJu0Yykyyp6MCqjEkPNhBgd4EFGLmEnPAi2uprulRPKEWMqPn+jbsx7
 AHY7kc1og20D1mHWA5HIh6qcmRCstC3urkgBEAaMPMs/F/U7gZuZ74dl9RE+hZE=
X-Google-Smtp-Source: AGHT+IHZurs5p0OmYiI073GJyf1yzmHbWc6xLDhpUaE+zam/D6rfRFO3otxjzl3MQ9hxHMn0fiqGIA==
X-Received: by 2002:a05:6e02:13ef:b0:363:c5c9:deb4 with SMTP id
 w15-20020a056e0213ef00b00363c5c9deb4mr2819417ilj.14.1708027397526; 
 Thu, 15 Feb 2024 12:03:17 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 w4-20020a636204000000b005cfbf96c733sm1769301pgb.30.2024.02.15.12.03.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Feb 2024 12:03:17 -0800 (PST)
Message-ID: <0d95525a-8307-4c89-9045-68130b44f095@linaro.org>
Date: Thu, 15 Feb 2024 10:03:13 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/6] accel/tcg: Avoid uncessary call overhead from
 qemu_plugin_vcpu_mem_cb
Content-Language: en-US
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: dbarboza@ventanamicro.com, Paolo Bonzini <pbonzini@redhat.com>
References: <20240215192823.729209-1-max.chou@sifive.com>
 <20240215192823.729209-3-max.chou@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240215192823.729209-3-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::130;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 2/15/24 09:28, Max Chou wrote:
> If there are not any QEMU plugin memory callback functions, checking
> before calling the qemu_plugin_vcpu_mem_cb function can reduce the
> function call overhead.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---
>   accel/tcg/ldst_common.c.inc | 40 +++++++++++++++++++++++++++----------
>   1 file changed, 30 insertions(+), 10 deletions(-)
> 
> diff --git a/accel/tcg/ldst_common.c.inc b/accel/tcg/ldst_common.c.inc
> index c82048e377e..bf24986c562 100644
> --- a/accel/tcg/ldst_common.c.inc
> +++ b/accel/tcg/ldst_common.c.inc
> @@ -134,7 +134,9 @@ uint8_t cpu_ldb_mmu(CPUArchState *env, abi_ptr addr, MemOpIdx oi, uintptr_t ra)
>   
>       tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_UB);
>       ret = do_ld1_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
> -    plugin_load_cb(env, addr, oi);
> +    if (cpu_plugin_mem_cbs_enabled(env_cpu(env))) {
> +        plugin_load_cb(env, addr, oi);
> +    }
>       return ret;
>   }

Rather than repeating N times, modify plugin_load_cb and plugin_store_cb just above to 
avoid the call to cpu_plugin_mem_cbs_enabled().  I expect the compiler is inlining those 
functions already.


r~

