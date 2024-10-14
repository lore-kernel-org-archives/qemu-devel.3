Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0385DD18133
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 17:33:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0Ow0-0001ER-KE; Mon, 14 Oct 2024 13:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1t0Ovy-0001ED-Cf
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 13:32:42 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1t0Ovw-0008GJ-Ra
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 13:32:42 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7ea8c4ce232so927669a12.0
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 10:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728927158; x=1729531958; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QgrBfoFk9ABIZA9b9HdnQNe/JlpsAZDZCwePdARlm7g=;
 b=NKe7fegyJ5Zypa0+wBxiJI07QOsUMTYtVueMwPPQLVVFijf2RfkOmuHc+wHTyF/1xt
 NdEthBKhGQuYPS8QDLpEYaCgvY2j5l/EQxVIlMHvc42VDAUtxPKUtQtO+Tk70mGdiadf
 +wOYw2hnpoW1nHGAopEwbOYcaaizz3NBW0+lYla3M/v3/Uyn3QtmvLMf2RtjJFQ5j6DH
 BMUB16ypiFjlL/+80gO4TzJgsiAtr1dQ8bS8YVKywi+ojdT9lceQpmPoW/y7kB7h6pQZ
 /jeIKUJYOOJWvWb++XKvp2PX3TFbZX664sZyROQNEnDPIY+U4UsoEjj0SrMnVC23+g/m
 ddFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728927158; x=1729531958;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QgrBfoFk9ABIZA9b9HdnQNe/JlpsAZDZCwePdARlm7g=;
 b=H9NuA7h1HouM4M6adFO6HZPAouxTLf0Vy2JOHwkHNb1cyuM3m3z4rPLNb1EuD7V+Vc
 ovTQvxVpQapYQP8YHY8UXUj39l2z7ImWHmZG5hCUki5IhbNkw0HBibnjlZLQnGV7lBCP
 /UtIXosBFrkjTai4xfKWHlm3QoOUGPQT/siM42OHJr8yieXQjJOCNQxnwLI5Ug5yHLmf
 WiqpMQUDYkCwn1r7vmLgLO+FeHCzCPC0QV4z3Gpd8PL221+Ro5sFPG3Ic2JaLAjJEVEY
 gqY1qsl9IoE4TNA9qDIjtdmUJEsTYKuPIXSEdKA5N9w7ElENqOWY3QfYGQwgcdksYW6l
 y1lg==
X-Gm-Message-State: AOJu0YzPrDox35S/9AzYKpd0bjYQe/FrVLxonYjcQ9PX0tW55rS2YOtX
 CFOat5pFMr6ps6gxe6lJlPZCMt0EgAByLexzyJRpfP2Bq8Xf0j5FzTqoIECli8wIZ6ua5B7n6vM
 r
X-Google-Smtp-Source: AGHT+IGCVgc7Bxlo/wgaUm8KQkBUlAJJ2sjWIkGm8J5oQ/LWRFJFkGNqxE8aJMy2G+wGnByChtV0FQ==
X-Received: by 2002:a05:6a21:4603:b0:1d8:b11e:19bc with SMTP id
 adf61e73a8af0-1d8c96c4addmr17775319637.49.1728927157840; 
 Mon, 14 Oct 2024 10:32:37 -0700 (PDT)
Received: from [192.168.0.102] ([191.205.39.21])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e59d6fc8bsm3715218b3a.141.2024.10.14.10.32.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Oct 2024 10:32:37 -0700 (PDT)
Message-ID: <b274d731-36ed-454b-9ad6-c58c6443d520@linaro.org>
Date: Mon, 14 Oct 2024 14:32:35 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] No-op support for Arm FEAT_XS, feedback needed
To: qemu-devel@nongnu.org
References: <20241014-arm-feat-xs-v1-0-42bb714d6b11@linaro.org>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20241014-arm-feat-xs-v1-0-42bb714d6b11@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pg1-x529.google.com
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

Hi Manos,

On 10/14/24 07:48, Manos Pitsidianakis wrote:
> This series is an initial incomplete attempt at adding support for the
> FEAT_XS feature in aarch64 TCG. This feature was introduced in ARMv8.7:
> it adds a new memory attribute XS which indicates that a memory access
> could take longer than usual to complete and also adds instruction
> variants for TLBI maintenance and DSB.
> 
> These variants are implemented as no-ops, since QEMU TCG doesn't
> implement caching.
> 
> This is my first foray into TCG and certain things weren't clear to me:
> 
> 1. How to make sure the feature is implemented properly. Since we model
>     cache maintenance as no-ops my understanding is the only
>     functionality we need to provide is to expose the FEAT_XS feature bit
>     and also make sure the nXS variants trap properly if configured with
>     fine-grained traps.
> 2. Is there a point in adding a TCG test? If I read the manual
>     correctly, the nXS variants should trap to the undefined instruction
>     vector if unimplemented.

Yes, I think a test as the one you provided is worth to at least, as you
mentioned, check if QEMU doesn't crash when encountering NXS instruction
variants.


Cheers,
Gustavo


> These patches lack support for FGT for now.
> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
> Manos Pitsidianakis (4):
>        arm: Add FEAT_XS's TLBI NXS variants
>        arm/tcg: add decodetree entry for DSB nXS variant
>        arm/tcg/cpu64: add FEAT_XS feat in max cpu
>        tests/tcg/aarch64: add system test for FEAT_XS
> 
>   target/arm/cpu-features.h          |   5 +
>   target/arm/helper.c                | 366 +++++++++++++++++++++----------------
>   target/arm/tcg/a64.decode          |   3 +
>   target/arm/tcg/cpu64.c             |   1 +
>   target/arm/tcg/translate-a64.c     |   6 +
>   tests/tcg/aarch64/system/feat-xs.c |  27 +++
>   6 files changed, 255 insertions(+), 153 deletions(-)
> ---
> base-commit: 7e3b6d8063f245d27eecce5aabe624b5785f2a77
> change-id: 20240919-arm-feat-xs-73eedb23d937
> 
> --
> γαῖα πυρί μιχθήτω
> 
> 


