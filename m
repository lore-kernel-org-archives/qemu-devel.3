Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F70C48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 20:09:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rai2q-0007b7-L9; Thu, 15 Feb 2024 15:09:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rai2p-0007aU-CW
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 15:09:19 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rai2m-0004Dt-Mx
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 15:09:19 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1d746856d85so11260295ad.0
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 12:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708027755; x=1708632555; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0FEc4bzySbDLp/Zv8hWKPlmHTGgcWjeDSlRGZ8d4Glw=;
 b=z4NfhzhPixNxUp8p1rHbKVB4OZTfTn3FYDzWQv9DYfdvYvFYnO+hdS3llpUZB3l1rj
 8mt+iMFPcAC9aYD10gS5jO//WbGtNTMuVcx1BqbQTT9k29dVaHmsykwBNOuESFuL3j/r
 kM4i1Y5j6WhmSGslLex+JusaUHiyRMG0pZBLO6ANGLSv5jAl1I+jJMAlstU7vmMp8XeL
 i/6ckeByc72UvNz9c45VIhUGYltzXe0DlB0PnIK3sSI0btPBMUIl3iSsDRD1Cw9Agg08
 mLiXmDLzLy9HMTD3waOKg5EawKps3eczTGA1IA4HIMQO4xpMH7cYKB3SbAiSOlTUQyOa
 2Y6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708027755; x=1708632555;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0FEc4bzySbDLp/Zv8hWKPlmHTGgcWjeDSlRGZ8d4Glw=;
 b=LfK8xvVas2Lf+nN1l3u55x7q4VyW8sWC32EMXpljmHMi1pCCPBVnBc8P+aPpTcBBEv
 rrXTOuNkVZlikv5FBGGHVPKsfOZ4/hK/z3VhEccFPiuqmBoMjFyPv/9M8gZc4olf72B8
 boZ/qgOurF/zVtLbz+LFRvAK+d+zrruJTyqN5vckZrx1GDQ5TMp6dbax9YV15aMuYeLo
 abGXXnCWAkUu+eOIdT9brU6SA4iT7mYgs7AjFeULqwdmDdsEOq0UICPt47OJVG3yk2rr
 hBycj3OZto8Ipem9rsGxZiOnKhm15F3kvW2c2PJHORaAvukrA5mxlvI5rob4NWi6+ILm
 eMow==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmQEhKzG+Xhl9cP53qec2pYeRCBHO87Jakrp7GPejzXEilRmXN6ohEIesRpj5SCQdrihdgQ1Vn+6hFrO8vedeAn6rConY=
X-Gm-Message-State: AOJu0YycX9RH00j36iD6aiO1P9cHwjhmpIZLcnP5/Tg6UflcjX/SX7B5
 M7gm1Xa1yIx6Mh1ipwhDJGrnQZsvviKS+2LMtfvV/Z1ef85Q+73i/NSmp2miHsmBlQEvWbZIJpy
 m
X-Google-Smtp-Source: AGHT+IGBb1xFfV1hpqCVcmSQEuvagjMs5RLboDbkCIkltu4TdPrkHz4NN/jJw+OOrHlNxwhqXunbvA==
X-Received: by 2002:a17:902:e5d1:b0:1d7:17e6:44df with SMTP id
 u17-20020a170902e5d100b001d717e644dfmr3703178plf.14.1708027755182; 
 Thu, 15 Feb 2024 12:09:15 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 d23-20020a170902729700b001d8a93fa5b1sm1634176pll.131.2024.02.15.12.09.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Feb 2024 12:09:14 -0800 (PST)
Message-ID: <ffd49534-9080-4f86-b0a7-b3b9e2e4e361@linaro.org>
Date: Thu, 15 Feb 2024 10:09:11 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/6] target/riscv: Inline vext_ldst_us and
 coressponding function for performance
Content-Language: en-US
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: dbarboza@ventanamicro.com, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20240215192823.729209-1-max.chou@sifive.com>
 <20240215192823.729209-4-max.chou@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240215192823.729209-4-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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
>   /* unmasked unit-stride load and store operation */
> -static void
> +static inline QEMU_ALWAYS_INLINE void
>   vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
>                vext_ldst_elem_fn *ldst_elem, uint32_t log2_esz, uint32_t evl,
>                uintptr_t ra)

Yes, this is important so that ldst_elem itself can always be inlined.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

