Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32440D637DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 00:48:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVfhs-0000i4-Cq; Tue, 16 Dec 2025 19:47:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVfhq-0000ht-WB
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 19:47:55 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVfhp-0001vZ-G6
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 19:47:54 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2a0bae9aca3so41759135ad.3
 for <qemu-devel@nongnu.org>; Tue, 16 Dec 2025 16:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765932472; x=1766537272; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IGSqDeCP/b0CgWFyTYxjCpJuWa5Kbm1AaGXOoPmfs/c=;
 b=nrc1hgrupI2bGp3mkfvKayttKBwDgSi2izDbg+7/L+KaL9gaxI+MpuKQEVXAleuvHI
 2YRwIWTU02u+lNuOYOk+7sCBQDgYPeDNiIYBYV3l7vsDBjqsvLh8NynhThoYQLnoH0Ty
 xhiZ7Ymxr4XVsvgO6s7eUlYdeWp74++UvvmQ653RsV3JLwvzpsvkGbcJywsXhuPuLtMp
 c2gD/IaK+YvDpZoHbk5HD4pGAlE6Z1NxGholm1uy0OoIsaVWQKdqHNG8JdFlgPG2eMu1
 GEfc+diqvndUTPgCSIEtj1kjWyoD7IDZy9yz4tydUE4jO8WOHtVZhyL/Nt1yHw2uIAuE
 RnLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765932472; x=1766537272;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IGSqDeCP/b0CgWFyTYxjCpJuWa5Kbm1AaGXOoPmfs/c=;
 b=HitjoIYtPDin6AZM1n6X7cy1eqzICl8B80fXJJ9KVhLAVIePWm2M7RJWZIDK2r0588
 PBKM4DJbKRvB6tTtf75aA+QcRnbUJFe6VM6MRDu9mrMVUFlRsVP+XSC3enkDv9ojXU0+
 L0e6r6ViP1uTIKP+GNX0ArtJgQ3oi10uINB0E6jNEw+jjIzAdh0ueUAPB3b2nR+KDQjK
 YQx431mKuSj+ArtRN21+RWAqbYrSxSAMjOiOEOcOfjF/pUkl51rbgDQkB5WCTiqm/6As
 9mkIfKfht/wmtLOIthUAO2/+12rW48jNYV2uNtzDfzeV0NtBHiPm7aoxBNxIWk5RI7mS
 exxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDr3QUhMEA+ZiZ2YjDOOGlXkRolN4fxXjU8VBCHCuxSTo+auXw9LIMm4Q4P1A9z2qXP2/j65yqAqYN@nongnu.org
X-Gm-Message-State: AOJu0Yz2bWM92J99GDZnDU4f+3H56nse8f5tiJMb1GtO28UWR1gWeuk7
 7yr+c3mzV4igD4LJGkDmHF0ne+Uw5774b+ZIcanUls1VTn5o+XRqwOaP4+BawpWl/Fg=
X-Gm-Gg: AY/fxX7OdEzpWljL+VZe5ZtfAtBzdVWfVImk6mr2zhfuF9b9SGbOQllaekX09qRGL9h
 VTLsMihjPzdTsLbH/SsROQDBFuFyAh4D0OXHWjmnXUEKKfvLo1dcdA8pWe7gECmToj5xP6NnRuw
 rJv3zTuGiYhDYYTGV6j2ao66iOcb6iaBnuerKekV1lOCmdMBCHK07ASV51UREmBEeC5QgVYaX3B
 HfdiGm47c5phfD9UAh5W+kHm7J671/ZTEIYuxck5GPJEEYI5Ou12jbRlQ212oeZpQFbaCiNRVuG
 z8tSZU8zGUcj0UyIAzcaHW1XTWD9K7S7OmgS6Jx9S6KYbEDS16iZ+ZO2MeHLT8VvSy+Uyc5LAhU
 tz2WO6gLTL0uFA+C8ZyL8nozzWRcVtfjv8Ml9ey7S+WkjQ7DtrgKdNZIGP+4PJFPekhvVv7ihgs
 s6ajGtHAiOHSwBIIQTxzig7RJIBFIJmx7grHj5ZyHQcGbRP3wyC1Ec288=
X-Google-Smtp-Source: AGHT+IEnRgJ0ebL7g96yvdjhQyQTRBhuRNG6apYLMKK1fIz5RlHcZ4F8b7wFhE+hR5vmC2h/CioYuA==
X-Received: by 2002:a17:902:ce01:b0:29d:584e:6349 with SMTP id
 d9443c01a7336-29f26d0d496mr155523425ad.13.1765932471851; 
 Tue, 16 Dec 2025 16:47:51 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a0993ab61dsm110249515ad.46.2025.12.16.16.47.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Dec 2025 16:47:51 -0800 (PST)
Message-ID: <6a1b0815-1169-4540-8fc4-02c964cddee3@linaro.org>
Date: Tue, 16 Dec 2025 16:47:51 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/14] hw/riscv: Define SiFive E/U CPUs using runtime
 conditions
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, palmer@dabbelt.com, alistair.francis@wdc.com
References: <20251217-hw-riscv-cpu-int-v1-0-d24a4048d3aa@rev.ng>
 <20251217-hw-riscv-cpu-int-v1-13-d24a4048d3aa@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251217-hw-riscv-cpu-int-v1-13-d24a4048d3aa@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

On 12/16/25 3:51 PM, Anton Johansson wrote:
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   include/hw/riscv/sifive_cpu.h | 26 +++++++++++++++++++-------
>   hw/riscv/sifive_e.c           |  2 +-
>   hw/riscv/sifive_u.c           |  4 ++--
>   3 files changed, 22 insertions(+), 10 deletions(-)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


