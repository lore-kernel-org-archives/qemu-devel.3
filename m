Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C7FC87FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 06:13:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uh03C-0007Vp-41; Wed, 30 Jul 2025 02:12:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uh036-0007Rl-LL
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 02:12:25 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uh034-0008IX-ST
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 02:12:24 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-24003ed822cso21010695ad.1
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 23:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753855941; x=1754460741; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VQ95C4XksQNZUdVbfOHZj7CvZf5NjWIFC48ihaIn55k=;
 b=Ld0xbstpWxiUbgWxqvvRfo3Rm8qjsEgac3bsNagLWdkn0lkYS4Z27jW5HN1DyDoOYW
 AlFn2cmxuHuhZhUz59MofpWFiWTgpXXaN1sjlUTIL1yKXn7XIV6Qho1u7AcIaN14OeCz
 kOjDisMdFwI+WNH4auqoLudnDR2PqHzM0c0FMvfb15cUd7nETDpF+55S/Hdf+gJSVNhC
 pQKQ3KXkypuMIPv8EL6Yuyyjr/OyvhTHovWC/8R8srjJBDoNXTmW8EsWzD662IGAemgI
 ax9HVumkEWmPFraauIuK5qYn8ve5oPTzLhKMeNLGKJ7ieA7v8ZqPqhJQIu/24DxYCw2y
 a7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753855941; x=1754460741;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VQ95C4XksQNZUdVbfOHZj7CvZf5NjWIFC48ihaIn55k=;
 b=r0KCWrmc4HHIIHwpcqDY47Uu8X7Cu6Mmv5r5lMDyI+T8ztSXNcjN9Ng5enr2z7KsKU
 qA2bMANoeObkQ/abwlOvru8cJq3YCX7CgZNCJI7VtJ92CO4bgAEmIABiwHmLegLEh/gA
 Xdmar9LXLjnD0Y1SHbiSYkT16I2pmDVRfhZFkxeT24wT/meObQ+pfTTJ7oTM551Ia+9L
 zK5eIsoqsT98jGbvldTUn1+t0SDnY6mg91Zj8bVWGkdfUSm9H41oGPgLp0qh57R6F4dV
 TC4TUJNfUN5a68jrS5xWJwdhuwEvcL9gvoJYRfBHVWP6DE1rC/Coucr4lg8HDCAIa3WQ
 a0GQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuaNnj3To2riTBWuEkzTz9LNuiCqfeD704yS9KKwcxtXdR4dxMvJK9AzVBTWyfcNlrnT/tbmpOAjMF@nongnu.org
X-Gm-Message-State: AOJu0YxBl+th5nMqi1UgctFbxQiZJkGvYRDublSstssYGTOYQzIBA2GV
 PNyuEpb34EmDHKkkEj1BDXhZa0ZtRN3ftIvgyaUWY7Uncfsu7abwILOla4RW9jwYK8I=
X-Gm-Gg: ASbGncv3Nnl479prDKI1ZKAS1502ew8XwMvAvuTNGFUKEY+7+/XviAcf1+KSBEh9KJm
 omSDnB18CTvPXv0DydjCkEVMoXBdbM5c31PX+aoGljGxcujgs1wpJ8d2oFAU4LsNjryhyYMkIWW
 OSAC+/2E03TAyXJ56FiAKJL9vq9Ebg3n4xanYOLz+D09uSCwBqOKosKxrY1b3DluKQRESAODEL6
 IOBJm2fsBThQ+kQ4nVpjxSEX4b7a2yOyY4rqSnrDtA5zksY2qMGU4SIQhy+J06nbPP8nT3ESHXE
 MnNeDErhEfmTaJ/MDzaRHdKNUWlSjVIlqhox4SCeW7DnumjEv1s16+ktUYrx0p1S4fbyReJE8Fm
 auxHmpVC17y61m4gO5XpTgkgkV0yBu7WN5Na3dJa17JmeXCuO2X1fdwOaVUe2nOC3iRyNWfcEP1
 cMFg==
X-Google-Smtp-Source: AGHT+IG2hWFHhpNpr4WX2ePxqbpALoF007RCywp03/dMX/3nRtnkD7xjc3vDLUvWMU0KEsMDtPs5ug==
X-Received: by 2002:a17:902:ef11:b0:240:725d:c396 with SMTP id
 d9443c01a7336-24096b17fb3mr31635145ad.34.1753855941151; 
 Tue, 29 Jul 2025 23:12:21 -0700 (PDT)
Received: from [192.168.4.112] (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2403e6085e6sm52646785ad.129.2025.07.29.23.12.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Jul 2025 23:12:20 -0700 (PDT)
Message-ID: <89b92bf4-a597-40c5-a118-481d0d9310c6@linaro.org>
Date: Tue, 29 Jul 2025 20:12:18 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/19] target/loongarch: Use correct address when flush
 tlb
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20250730030202.3425934-1-maobibo@loongson.cn>
 <20250730031055.3426197-1-maobibo@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250730031055.3426197-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 7/29/25 17:10, Bibo Mao wrote:
> With tlb_flush_range_by_mmuidx(), the virtual address is 64 bit.
> However on LoongArch TLB emulation system, virtual address is
> 48 bit. It is necessary to signed-extend 48 bit address to 64 bit when
> flush tlb, also fix address calculation issue with odd page.
> 
> Signed-off-by: Bibo Mao<maobibo@loongson.cn>
> ---
>   target/loongarch/tcg/tlb_helper.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

