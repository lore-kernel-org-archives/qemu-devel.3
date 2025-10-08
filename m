Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E42A3CCD188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 17:32:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6Xzp-00050j-O1; Wed, 08 Oct 2025 13:30:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v6Xzo-00050Z-HC
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 13:30:36 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v6Xzh-0003FC-Q3
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 13:30:35 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2698d47e776so504955ad.1
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 10:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759944627; x=1760549427; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QIBkZsGvAJtxs9YFkGzECCgqwjzAG37XZgIO63acsys=;
 b=SrcTI/0nuzT4Uvw8aK8EW6oW2LjpObvQVBSGYWWdmdjj01rdAJYNfzvhh+frd4nkxY
 IXKsLmVlxa39p5jmaIygi2zoB5lmdVpUif9kYWwvIKU/X30kyAYovm9LKadwoUwdur61
 nzLvt0v9NwLOoIbdP8zN/MmIhJSy2TcpoWw4WxymMwDd0iaP91b0Lt+BQp8fFgSaR/3l
 rat/adDhCTOxLoTvLHS0AFndOaRVw1MgUxV2u8zyD0rWaARLJhAiDOMWpTFvok8Sxr83
 5dgkCFJSa29FyMIVLB4ceAWJjcHhrOt2VjRHQuqFJRv5Ok08uhobOy32uJwVYoIOWLwU
 Yfdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759944627; x=1760549427;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QIBkZsGvAJtxs9YFkGzECCgqwjzAG37XZgIO63acsys=;
 b=qouFO9J3ILSnvp6fnS/l0jY59SJPT/RaIdUrWPAH6AUH11aMKcruy3eH+tO+gHT+//
 M/oQnMsXjWLY2+gNQ6TazlbzWHHjHDdkunFyC05DSV9jH24ru00esyzFs58J5RI6+Hhj
 q6qmbxhm4cMPkJYzeYhjl69biO3akSDkOwjjIhRk5yVorM2fPymETIZ6HTlPSML1qyGp
 OIDdijAv7u1VGMOYijgEneMj7x7y/h+3gP0uIqIzncBxtoUGJW/G1Fz3iP973zo3e7mf
 Le1rjptMLc+jW2ulIMNUHH/w7Cme0cAoAX33EPS52LaDme5NOdcOR5CDTNTJ4J01Y9zF
 6XLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOpBEoVyrAzZ5IazWrZZ4XpV9lW52NDEo72aRlSrylzJYcZta8MK5AN6erD6UGLyr/PqnJqXa85j+A@nongnu.org
X-Gm-Message-State: AOJu0YwjQJ75msfXbqHqx0xBDf1/2NuA17CAlwqKTWsOGut+rB6A4WMC
 ucNF2XtXrpT5Sgiye9X1WwjJeGKPxsCyNf4T/ot3yT2zQixaW2VJyO3hI4qTTodWTrA=
X-Gm-Gg: ASbGncvP5Oww6hkg+MQsYVtaOF96zqVtv0477vixnulGKnZ02kSPJC4FDFoFbouZoOR
 lvk8GgmdJyc+Arb8fb1w6pPouuO+ycVzHoQQXm8+mNPwh/jhMulzwe9QM6H8prurMRpmfpex7iT
 ko/Cs1deDT/20lV6L0u5uI8aADj4NI+rKVI28l1mvkjNPigxXn06j+NwiNxMxTQxXH85Hw68wV8
 gzmIuwjES04vOk6vQfn6dYMxBsauNBX36T2qdIJmf11MqYip8JQ3T7/mRADYC9LIw/OGzazrSXo
 5eQ1WJCFD/zXQgz+pCe2GfChqIKm+jBDHHr1E/TcWYuUqWKJODIP9O0YYslks0P1qUX1aknoqdp
 A3RqCexc+uVOkAL6bEszc4JhvC7L2EsK2zoq8+FtUJ5iSQDomTbG8Zp5zCOzSWoCA5E/Me//DaQ
 ==
X-Google-Smtp-Source: AGHT+IH9VSptggUt0j4KWNrO/JSQRuGONzH7mmukrsjB4IINyx67tiFLJ/vjokukm4Axm2Z0kAxovA==
X-Received: by 2002:a17:902:ea0d:b0:267:44e6:11b3 with SMTP id
 d9443c01a7336-2902737494amr58614875ad.45.1759944626677; 
 Wed, 08 Oct 2025 10:30:26 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f961c5sm2775625ad.129.2025.10.08.10.30.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Oct 2025 10:30:26 -0700 (PDT)
Message-ID: <7d705ff4-587f-41d1-8f39-e8190ce8547c@linaro.org>
Date: Wed, 8 Oct 2025 10:30:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] target/microblaze: Remove target_ulong uses in
 get_phys_page_attrs_debug
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Alistair Francis <alistair@alistair23.me>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20251008060129.87579-1-philmd@linaro.org>
 <20251008060129.87579-3-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251008060129.87579-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

On 10/7/25 11:01 PM, Philippe Mathieu-Daudé wrote:
> The CPUClass::get_phys_page_debug() handler takes a 'vaddr' address
> and return a 'hwaddr' type since commit 00b941e581b ("cpu: Turn
> cpu_get_phys_page_debug() into a CPUClass hook").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/microblaze/helper.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
> index ef0e2f973fa..cf577a72268 100644
> --- a/target/microblaze/helper.c
> +++ b/target/microblaze/helper.c
> @@ -274,7 +274,8 @@ hwaddr mb_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
>                                           MemTxAttrs *attrs)
>   {
>       MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
> -    target_ulong vaddr, paddr = 0;
> +    vaddr vaddr;
> +    hwaddr paddr = 0;
>       MicroBlazeMMULookup lu;
>       int mmu_idx = cpu_mmu_index(cs, false);
>       unsigned int hit;

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


