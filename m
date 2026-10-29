Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A34606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 12:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=zdKAKpiG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMP4S-0008H8-Vl; Thu, 29 Oct 2026 08:17:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMP4Q-0008DL-MY
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 08:17:26 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMP4P-0000Mc-2Z
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 08:17:26 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-53dbe9b8d6eso603298b6e.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 05:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793276244; x=1793881044; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HwCspv9KVpeNpKaoIMyOBsabutmcdbAvFeFXn1CMntk=;
 b=zdKAKpiGCn+ruCUDZBqZo2W+opB6yZ/uASd+VA80HaYeCOISeEnahrQv7Wpdz3Eg4s
 0zA1aXDt3qMKbhw5Zu4voTRcIhU4xU2hSxL26E8rCNcG6eDzv+AOJahyzBIDnXGqgAOI
 JWR28n5WX8MhAwdnMGWN1veYdQD2KKp+1ct0IewiVS+4P+UeY1VeD85+0OplHNWyXnbU
 0OGwYfAuvUykm/E+tWqIWP2oIP+QWvTCzGcbN6COCAvn2hxxsjo1PZPratB/gyzGe4da
 f7qeTdr6tqLnJb/xqyjmiB7ScqYDl09WCGRIo3sVnFaTe68DQDJc1lt7S5U+pPahO1Fa
 aRnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793276244; x=1793881044;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HwCspv9KVpeNpKaoIMyOBsabutmcdbAvFeFXn1CMntk=;
 b=wUVlVsUPXeBXahfEXLTFMbguVxVKTxPSuymjjrtdLplQ192Q89h8djywt86U3YFL4k
 yUEah2Zr1bHHOfXOp9bLiJ53HM5XaWnuzZy97OJcFEs7D1rjY5CWzi4Pw62I6KoxnI8u
 0atf2J3sh1QtNwgK2SUZbYoamyz7sIvrl65/M/YvXp/OBZbpXCPyTu+Jzs5Gd//otGF3
 TrkB4jCMu8zbGoogRN7IVLQTMg2KixdSy5T4kJSmG5/0yd5oKnNT/bwSijiLZDI7QZ/d
 oR75wFxqD/ZTt0SZ1c0ktScNBIkQRwBqlsqfs7jh2wNDtPujzJI5r938NQlE4dZ6zvjq
 hHFg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxOwnpgt5zvnHVvEI7zJ6mxbZNk3tjn3hl/N0Ki91W4MzB97kJzL6qPAfi7kAJMeAu5SuEg+eeYUaKm@nongnu.org
X-Gm-Message-State: AFq9FYL0KpOBsuBX1yWMBKwAegazVRT8wuerkwsIu6PY/LKj/Fyz/Wyo
 9hlZtRyxJ3nhkAPs9ZoSODdPbY6ymMaRi3SP9XpRNHcnO1TlBenSbHar/COE+V4uH8Q=
X-Gm-Gg: AYBFou2L9zSElMaEL8Nowm7SP+SBmAHMHAPmC16EE0z2Im7EeGKxVEFUAl/ABI7U1QJ
 nzur5EYvBr3vqz6hc/JNYFnr1DOO/ko3GM6TOR7QhQ4a7LGNkryW5XEKCmKunT+r54LS17GFDpG
 mhgZkiIHvQQ+nmgsAa185Hoo8wIV9Ouu8rmW3da215/ih0blFR0hElAZYzE8zXvq4q1ARrkv3Yv
 Rn9EiZ3D9hjbMlCif4ns9VXDmEfG3BF5iTaVSDMWDWCLVNgVBHSJZnyCXiNICnqBepc0wmzj01u
 q6X+U3T4yTFLbubYWIfVAtt+oWUqtZ3AkzWLloLJkfstgpOaaDKSweitiHxJILa2xFqmulLYlUl
 OGiaJOnPhCiICpmB8rH0ziu7Ykf7BQBu5CHDHBRy78D3o6AlWnRwkD3dTwU8T17Ojeava7QQbHT
 RN9n6B0BpTCIQaT8UehXUU6d7Az0xGFJV2yWYzi+Dv894D8Otv2Q+a9KnwhHwoaKetNfpCMC9GJ
 htzscZtlh9o7hqnmLYQJ2S0RFIlF0OaHvV68DynNJOcqftd1F9dZBTZo9EnzFNJtlDUvAjVjhHU
 Vis9dlNMfnZ7+PQPhU03tWCjGjeG1MZgFUGIgoyoodfp
X-Received: by 2002:a05:6808:250d:b0:496:976:acad with SMTP id
 5614622812f47-563ef5c1674mr1205981b6e.1.1793276243814; 
 Thu, 29 Oct 2026 05:17:23 -0700 (PDT)
Received: from [192.168.129.53] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-563c5a4d8b7sm3302136b6e.8.2026.10.29.05.17.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 05:17:22 -0700 (PDT)
Message-ID: <31a583fe-d71b-4b50-9e5b-c4acb138117e@linaro.org>
Date: Thu, 29 Oct 2026 07:17:21 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] tcg/riscv64: Fix constant handling in vector
 comparisons and selects
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, qemu-arm@nongnu.org
References: <20261028143330.6518-1-philmd@oss.qualcomm.com>
 <20261028143330.6518-5-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261028143330.6518-5-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22d.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/26 09:33, Philippe Mathieu-Daudé wrote:
> tcg_out_cmpsel() takes constants as TCGReg and passes them to the
> encoders unextracted. In a release build, "cmlt v0.8h, #0" emitted
> the illegal instruction 0xffffb057.
> 
> Use TCGArg for these operands and extract the element with
> vec_imm() before encoding, including before the LT/GE adjustment.
> 
> Fixes: 006352d69f14 ("tcg/riscv64: Assert immediate in range ...")
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   tcg/riscv64/tcg-target.c.inc | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

