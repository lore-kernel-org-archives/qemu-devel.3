Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77BBBC25B10
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 22:47:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s477O-000161-U5; Mon, 06 May 2024 18:47:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s477H-00014x-Rt
 for qemu-devel@nongnu.org; Mon, 06 May 2024 18:47:28 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s477A-0003Wc-LF
 for qemu-devel@nongnu.org; Mon, 06 May 2024 18:47:25 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-34db6a299b2so2218309f8f.3
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 15:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715035632; x=1715640432; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pEf+lrp5eFQCWzhHqRbqNVaprVqtAUWyqVSYs2Ns0Ps=;
 b=gky7Qmkmvx0YrLDKi7Ta1y+SNXhp1Maq4c8ggySNSqhrT/3vY0W17UHrmu9lYr4MY4
 jBbAXl9mn24oJp+92yMfd+OIqLgjV4DjJvMv1AB7ypBRs4UM2Mgj4Hecd08Ko+OuQERI
 MBgynIkR3bwrtclqHpjkFpCWnhFIRxF5/kwP9FYREm847EMsaEi3ZPYnLP9/F7F1XwX0
 xw+3H6mG/KmXwuQMS4hDT/XTXS+QNTwOU2gNusfn/Oj2P/AWH+qSsdJQlnzJPyS+0lGZ
 QScdaQPkJjH0mtQJuCTDRgqckw/UhdwR3gGYKl+BCgFGYEc1shosMWvXuipKE7nVtA/K
 sC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715035632; x=1715640432;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pEf+lrp5eFQCWzhHqRbqNVaprVqtAUWyqVSYs2Ns0Ps=;
 b=KMw7yuC97jnvzL3JBzZrDhirq/hI5D9RhDuP8lBN12L7BOeGRxUl+fCYsC5BHhrCBe
 R+EX3ej63UoaqILsQlykZljzDnsiuBVVOOwksNif7o/m1e/Rarj1UcjocZSQ6I2J5FBU
 IqUA8bQLFKBRLGh/26YJ9P8vXbBnw8W3IYaops5uE+har9ur0qatBCXoAk7YLMbW6LQa
 TuM7qrjgXTYqiF0OWmwZshdMM6EZn9L2S4Y6Q8/pIHTtt/Fp8r26ttJ1gdnGCrX7unbN
 u9vxEWh5lmQW9OBGDuJ1V2qjUjMmyrzrBTfS6gR9B61WLFtI26dw9i81xpI8r2TPEmUT
 CwBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYozb31QuK5ARJAcckJcKUzrM4FSQkj17tDwDwn9gs33XorF+XkaAQPd8+/RD+Pixq/7aokURDv6lSKb1X/RzG5cfBhCA=
X-Gm-Message-State: AOJu0YyU7F57BGmj+usn+vSdgTvmLptvTxJu96VIOb3rKXTQPgA5b1D+
 mMnyVpHoIFRskqALgw3RN45Osch7DPZTYt6F7xXrb3eOcV66uW7RlPQAClohFQPce505+G2XhkJ
 z
X-Google-Smtp-Source: AGHT+IElM/BXLlw2g+mRirXuIP+zzpL8P2A7A8XnjuHTVT1lozJHHi1DAfwHgqIjYYvBZj681GwZgw==
X-Received: by 2002:a5d:460d:0:b0:34e:89cf:4576 with SMTP id
 t13-20020a5d460d000000b0034e89cf4576mr6481265wrq.51.1715035632377; 
 Mon, 06 May 2024 15:47:12 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.211.4])
 by smtp.gmail.com with ESMTPSA id
 cm11-20020a5d5f4b000000b0034dd27adb2fsm11574448wrb.107.2024.05.06.15.47.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 15:47:11 -0700 (PDT)
Message-ID: <aa92898b-860f-482f-b105-40d8b8c16a9e@linaro.org>
Date: Tue, 7 May 2024 00:47:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/33] accel/tcg: Reorg translator_ld*
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240424233131.988727-1-richard.henderson@linaro.org>
 <20240424233131.988727-5-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240424233131.988727-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 25/4/24 01:31, Richard Henderson wrote:
> Reorg translator_access into translator_ld, with a more
> memcpy-ish interface.  If both pages are in ram, do not
> go through the caller's slow path.
> 
> Assert that the access is within the two pages that we are
> prepared to protect, per TranslationBlock.  Allow access
> prior to pc_first, so long as it is within the first page.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/translator.c | 189 ++++++++++++++++++++++-------------------
>   1 file changed, 101 insertions(+), 88 deletions(-)


>   uint64_t translator_ldq(CPUArchState *env, DisasContextBase *db, vaddr pc)
>   {
> -    uint64_t ret, plug;
> -    void *p = translator_access(env, db, pc, sizeof(ret));
> +    uint64_t raw, tgt;
>   
> -    if (p) {
> -        plugin_insn_append(pc, p, sizeof(ret));
> -        return ldq_p(p);
> +    if (translator_ld(env, db, &raw, pc, sizeof(raw))) {
> +        tgt = tswap64(raw);
> +    } else {
> +        tgt = cpu_ldl_code(env, pc);

cpu_ldq_code() ?

> +        raw = tswap64(tgt);
>       }
> -    ret = cpu_ldq_code(env, pc);
> -    plug = tswap64(ret);
> -    plugin_insn_append(pc, &plug, sizeof(ret));
> -    return ret;
> +    plugin_insn_append(pc, &raw, sizeof(raw));
> +    return tgt;
>   }



