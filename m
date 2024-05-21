Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70887C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 17:41:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9TTh-0007X7-0n; Tue, 21 May 2024 13:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s9TTf-0007WX-5w
 for qemu-devel@nongnu.org; Tue, 21 May 2024 13:40:43 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s9TTd-0003Hh-NV
 for qemu-devel@nongnu.org; Tue, 21 May 2024 13:40:42 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6f44390e328so1675112b3a.2
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 10:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716313240; x=1716918040; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oJbl0pUJpyx9SHlzQkN9tZq79fIIu+uxiWvfSM1OTh0=;
 b=TC8REf4qroIzdYLvOeMx3bhDuPZEvTqP1Ts2Kbsxqy+lWxgsmV3ZT68d/ETLTN23EQ
 c/NMlf7YiIfihZDW+D8We9IHLs0hXqWiutNX/+9nyRcL+eumF3wGwnOwOFU3GatMKEkB
 NhK28ljcH9biQSLsUsdJHMpumvOPhwFpS80/kN8dQjJl/tp6gsdTSBOnznI8zECSLWZW
 0bryQ0oCImnykXgiidXu+v99XY72N/qUHub8XQPKM0vey3gIrMhZrpPToI/BLKlAjDcP
 ljC7F5E5/Q0wizk1USywfu1YjZoizFIkxvwgRQRe+9+N3ZB1TCZNiqkYC88GBSyplOM1
 /t0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716313240; x=1716918040;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oJbl0pUJpyx9SHlzQkN9tZq79fIIu+uxiWvfSM1OTh0=;
 b=TdEJSWBy3fFWonXbFFUq7gDgjHhsjiehRM7e5gCrA4TxImIlnthelMZNAwiksWUjKI
 9LjPGhm2FheMblDTxqgVZSeDg96Cu3dwEqudM1fCtJ6dGr/U9jq8mgO2X638BtYgr1g+
 B2XPWoys6rX+GKGhz+RuzthPcAl7FEOFqzi7XO6FvCBgKjOdc0UC9bGfg+kD4O7nkLgF
 1OBKjfKvUv8z4ROYqNUOe5665DvOGcZAd/zFE4TXEOG6McFoIqKhZHSNsRFK0CBlXVx9
 gaWPqgQo1jJ+u6TAld4Q3aO8wk1+Cf0QI3SlT3yvtRAyY9ed2OlBVkpMofXAPt1YerND
 eI8w==
X-Gm-Message-State: AOJu0YxR5O0KpmHIhEZ5OHMUFD9HKmkgNlj/bSb0QFVqzeoaqsqdcYuf
 BRQARMP3A7/mGkVOD06ZfqCHEyeT5Av8XBMjNLYiKI5F6OzsjSNbSCa9En4BHyg=
X-Google-Smtp-Source: AGHT+IHPgIut4X5Hc0EyepinCU1FPl4Qb/YvavcWlAz8iXzdldqU4syurloI3u7yG5kVO5DmdnTvcA==
X-Received: by 2002:a05:6a00:2d13:b0:6ed:cd4c:cc1a with SMTP id
 d2e1a72fcca58-6f4e02aee05mr52027806b3a.8.1716313240075; 
 Tue, 21 May 2024 10:40:40 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f6ac00c037sm4532357b3a.111.2024.05.21.10.40.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 May 2024 10:40:39 -0700 (PDT)
Message-ID: <05148488-d827-4c6a-936b-5eeaff2a5d86@linaro.org>
Date: Tue, 21 May 2024 10:40:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/12] target/ppc: Add PPR32 SPR
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>
References: <20240521013029.30082-1-npiggin@gmail.com>
 <20240521013029.30082-7-npiggin@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240521013029.30082-7-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

On 5/20/24 18:30, Nicholas Piggin wrote:
> +void spr_write_ppr32(DisasContext *ctx, int sprn, int gprn)
> +{
> +    TCGv t0 = tcg_temp_new();
> +
> +    tcg_gen_shli_tl(t0, cpu_gpr[gprn], 32);
> +    gen_store_spr(SPR_PPR, t0);
> +    spr_store_dump_spr(SPR_PPR);
> +}

The documentation isn't clear on whether this zaps the low 32 bits. If the low bits of PPR 
are {reserved, must-be-zero, undefined} or suchlike, this is fine.

If not, then you need a deposit here, to preserve those bits, e.g.:

     gen_load_spr(t0, SPR_PPR);
     tcg_gen_deposit_tl(t0, t0, cpu_gpr[gprn], 32, 32);
     gen_store_spr(SPR_PPR, t0);

Anyway, it might be best to add a comment here re the above.


r~

