Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B28E4C48285
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jan 2024 04:25:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTaFS-00016k-4R; Fri, 26 Jan 2024 23:24:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTaFR-000166-51
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 23:24:53 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTaFO-0005Hi-Cz
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 23:24:52 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-29026523507so1103011a91.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 20:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706329489; x=1706934289; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qwh7umL/TaZaRiuFz8g8riwDzaQCkJzC/LRygZGabUQ=;
 b=En7F3iWPK+Zm2bkWGP+3XocxWfulQrogLV/kX9RM960+trBZXqiviW36xSG5bzD+CG
 PVgm+bxf6j9PCpMvDOgzcA5H7gZSi5J6bfRnuHwhCKfmdCHj6NKAsbwfwsFlElyKIrkZ
 z3F+G94h0+Pm9F1Ti7SY5zNv7TzQzMAvEbt24Scaf/xqLIyAyDyohGHtDqA27IimBd2S
 UHyvID4vwSDt4oq+aKJs/XKcEtyUWz5+gfVuiApe/Tyt9dI14GEmDluXPuTqU49hoB21
 mSYNVvea6JnRPdgPEGG0+lDRi2GiQHRGDbkfeT1wyR5IRL/IMkqOeLCmwJXnWyuiiING
 5dWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706329489; x=1706934289;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qwh7umL/TaZaRiuFz8g8riwDzaQCkJzC/LRygZGabUQ=;
 b=NhfCGW7W49WrcTns4BgdTIfFqXpuQQnhYv/1u4SwsXyvsAWQFR9cuCtkrxXiKTcDNS
 xC2+IdPhd1yjoHB+fHigMHBSlUVHzx0KJJL6flWeK4ff04GTZpN7q2Z88Yh+TYz9qbNC
 +1M9TgbddI4rChxNMwq/g+SbOjGPTo7EdtuNzRyX1xTxFolGKAW9bIo5Rx/RjNbNLych
 ms/oa9fUhIAglGZoOS42wG+bZM+v3ypg/9wuCvRa0x49M3qh4mOnUOw5omFcXv+fJSJt
 bpIP6eTNaqSTYKM4zLF0nyAgsCiVpPY+Wqa0zjwayy1+hYOv9Kzwcl05k8UMuRNpaHPX
 873w==
X-Gm-Message-State: AOJu0YwG7jJ01csnEtS5eUTvgN3ON/25Bnw49l19fkMfwEh6z+MT6C62
 e/9Q+MW/r1vHlLPF3ui5zYlfq4F6rpg5osnGPZkuQ8JfpBEp1tV5z7Y7Nd9UxSo=
X-Google-Smtp-Source: AGHT+IGK2DBWPNtxzlLodlwjUNmEQHXnJj5Hti/GjMngNufThupxNKunkB43c6zDyx3F21GAXHPM5g==
X-Received: by 2002:a17:902:788f:b0:1d7:8c9a:14b0 with SMTP id
 q15-20020a170902788f00b001d78c9a14b0mr909200pll.42.1706329488906; 
 Fri, 26 Jan 2024 20:24:48 -0800 (PST)
Received: from ?IPV6:2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e?
 ([2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e])
 by smtp.gmail.com with ESMTPSA id
 gd17-20020a17090b0fd100b0028ffc524085sm4001781pjb.56.2024.01.26.20.24.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jan 2024 20:24:48 -0800 (PST)
Message-ID: <8d359557-3672-4813-a415-b0f8e0a69832@linaro.org>
Date: Sat, 27 Jan 2024 14:24:43 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/23] target/arm: Prefer fast cpu_env() over slower
 CPU QOM cast macro
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>
References: <20240126220407.95022-1-philmd@linaro.org>
 <20240126220407.95022-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240126220407.95022-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

On 1/27/24 08:03, Philippe Mathieu-Daudé wrote:
> Mechanical patch produced running the command documented
> in scripts/coccinelle/cpu_env.cocci_template header.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/intc/arm_gicv3_cpuif_common.c |  5 +----
>   target/arm/cpu.c                 | 19 +++++--------------
>   target/arm/debug_helper.c        |  8 ++------
>   target/arm/gdbstub.c             |  6 ++----
>   target/arm/gdbstub64.c           |  6 ++----
>   target/arm/helper.c              |  9 +++------
>   target/arm/hvf/hvf.c             | 12 ++++--------
>   target/arm/kvm.c                 |  3 +--
>   target/arm/ptw.c                 |  3 +--
>   target/arm/tcg/cpu32.c           |  3 +--
>   10 files changed, 22 insertions(+), 52 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

