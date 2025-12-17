Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7519D66B86
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 18:40:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVwRH-0007Ok-3S; Wed, 17 Dec 2025 13:39:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVwRD-0007Cw-U9
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 13:39:51 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVwQv-0008H6-Go
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 13:39:38 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2a0d52768ccso47468475ad.1
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 10:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765996772; x=1766601572; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2p8bLgGlZF48CbmV5rbMnXHgll7dyQAg8oeKzqnEuWM=;
 b=kwzp88dfa/hDfeKUKnAJF11Ua9ebL+UVhuntaqqwQVrODoTr4EP2Wp6BCEYhmHW28L
 VJ1gjkVIg4FAs2kGXzh6ayj0iE/zcf5oWR4VoTO1L4Nv1in7GJh53sZJeATIQ8NydEvs
 yYpgQgK4I+RfYwV7x+3AP7cOtJOtPsZsRP9wsrAxkxW5FDN9nyT6H/AQT5LdB68e8Zmt
 7FhQciNqDDkDtUgMgjVSX66Kot/TXCkL1/CIappij+e/BwnBDDavY6SHs5JBRh5VJwjI
 /HoyQbkFb/t+VQjCJkQNCDAfnauVXm9dw9BAhAlAe8I+DwJnobCglvJX6qtPgXjEAoVo
 Uyow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765996772; x=1766601572;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2p8bLgGlZF48CbmV5rbMnXHgll7dyQAg8oeKzqnEuWM=;
 b=QzNzQgVWGXav7bsuZ5BU2aL/2NAEMelyjwOFTj/Cbp+Co+oySChOaiJTNvRoOMbg5y
 JII9j37q4OBFXzC904xG5oIhaxFUrMiwAhlGC951X7qM59OJe+mEHJr8crWRKVQUvrBi
 YPpyrqussEGfSaRgeaJ9uNf3vTXzTg3huCGLZFSFmcQdUX8Uw2OuUssstE/i1tD05Mh5
 iPYnn0dFoLy8W4tgQeeiBRLu1/8AuITvrUNFgzIMaiTSDsflDlj23mSrN+i/ykPokNLM
 S1F2JeJaIVVI8JarjnJWQktydOwxLoP2THedaH+QmFApU4jQngOcP4pNMgPIstG0k0LD
 NTKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUH1a1Wbbv8Ivs8CxsV7Ck8jb3iqULsvjRPBmDmrYKsphABR4VmLz7+zdBa9vTfFoq0Agiwau8rG777@nongnu.org
X-Gm-Message-State: AOJu0YxPTYFdRcWwftAlNCaYrfr3reLWHj+fCWVcH5/9bnq/wzzDkdg+
 wTquI+DeO/dVCP0vuD8BfUVk7AuYmTCqGlPIcN1aOrjMy2paTLer+0z/h/eLBAoSQNo=
X-Gm-Gg: AY/fxX44jFdNRlsiJYxBmqfj3dMvE2OPqiaoloMXBSJfhmBkhbLvd1nkyEyPG22+hmK
 4DsMG9A0P1/lpPtE007jKMew/Tgyz2xqXDEUSqe1hrrNEcukJahu+SVf78f88DsnhWsHCgEI0hh
 UwS/ewa3bPfXuMO9dOf9Aqk9CUpiNEatWNjA4t/WJwBqMPKupecDQfLML5sLSSCsTEeN9F/yRwU
 o2MCJmZYCsz8UFSAw2//O8dQAC2H5CBCy/0DLpnRQ9c4zHahG4vNc+MLoNvPrGT3QCetIDLpved
 cnuOdoFLG60ZkfaUXLHOleoYE1H11KB0YqlXKcUbcCjQUtUJHe4gEQFkbHRakMxtaMkY57+i2g3
 gA+apqSm1Z259eIMoJMbfdJc8wTIJqkCAbUDQ+npQ3nD778Lq4lGn01XH5MXdclMSJRFHxw9dm3
 e0v2n39WEu8SlPcFSgVYxLJfDnw1SHP5FjN9LVMbVYRaHFCh5+lyoXa6yekQa8veOxmQ==
X-Google-Smtp-Source: AGHT+IF9KcHsv77UPexlhp6ID7kWycFmbxsvkj3Iqv8KfR9+wAUpi5Z5KSkLW0dQXkNZoDc1Z7z4lA==
X-Received: by 2002:a17:902:f68f:b0:29f:2b8a:d3d with SMTP id
 d9443c01a7336-29f2b8a256fmr163204105ad.4.1765996771688; 
 Wed, 17 Dec 2025 10:39:31 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2d16125e0sm245905ad.56.2025.12.17.10.39.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Dec 2025 10:39:31 -0800 (PST)
Message-ID: <722810f7-6d08-442f-ad88-107ed7940c4f@linaro.org>
Date: Wed, 17 Dec 2025 10:39:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/14] hw/arm: Update bootloader generated with '-kernel'
 using stl_phys()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@kernel.org>, Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
References: <20251217143150.94463-1-philmd@linaro.org>
 <20251217143150.94463-4-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251217143150.94463-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

On 12/17/25 6:31 AM, Philippe Mathieu-Daudé wrote:
> When the MemTxAttrs value is not specified and no MemTxResult
> provided, address_space_ld/st() is equivalent to the simpler
> ld/st_phys() API variant. Use the latter.
> 
> The _notdirty() variant is supposed to /not/ mark the updated
> CODE page as dirty, to not re-translate it. However this code
> is only used with the '-kernel' CLI option after the machine
> is created and /before/ the vCPUs run, and *only* during the
> first (cold) reset; not during following (hot) resets. The
> optimisation is totally not justified, since we haven't
> translated any guest code yet. Replace by the normal stl_phys()
> helper.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/arm/aspeed.c | 3 +--
>   hw/arm/boot.c   | 6 ++----
>   2 files changed, 3 insertions(+), 6 deletions(-)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


