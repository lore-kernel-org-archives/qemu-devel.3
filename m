Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8912C19F4F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 15:34:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4jJ9-0002IO-Dc; Wed, 08 May 2024 11:34:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4jJ7-0002IB-Rl
 for qemu-devel@nongnu.org; Wed, 08 May 2024 11:34:13 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4jIv-0007YF-3u
 for qemu-devel@nongnu.org; Wed, 08 May 2024 11:34:13 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a59a5f81af4so1187647166b.3
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 08:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715182438; x=1715787238; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QMt778G+OxRl+/izUK+nXba5OtT/1vSeGk7QlyGD15Q=;
 b=SpMl6NXktgDweWR94PILISknY38b/84Rt1F0kcwYFBHN1hzVCIL/CPAF8pvP1sw/GC
 QRzPIdMEvWvhav5SfoQbXqeaqsirZJEKWAfrpZC8xE+UIGPqtxeO6d/vxri2GI0vIIK3
 pcPHMCq6j8AaoVn3zGt4RMBCtUDCRgvRKtFBm8mWf90aGfwaygWGnd8XeloS4MuNuKHH
 2zhvnwK0N7EaFjqx5WVtB9iqlGhL1w74cV5yfb7kGwsvpeW+qukS4AWZ/ZnQYL/78Rhw
 hdksQmd7yX4ZW2STfjQc1neWAPJSNCQVag0/osuWbqop9K8MGy9knbsls1tuV1tIqALK
 J+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715182438; x=1715787238;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QMt778G+OxRl+/izUK+nXba5OtT/1vSeGk7QlyGD15Q=;
 b=s8nSLMtarfg+CGEeLqe0A5oJUhgduOnQWW+k/PR6KpTa9QSin+1EwYKOW7MbSRbwRv
 ZLZDzMAQoFEprdQeSv9bePlygjsfHuFRXIYUWIoC9sOO0Wm/0tfkXqcSphFZ3S4Cx5bf
 OGcD1e0u0PfWqYUG443C1z6Tdsf5M7oohHZCeUXfrZXwZ6VopsKm5w6Yuq1zbC/dmorH
 wUdUuZpNE5zA9dn02dBXGZOOqZwNAmLI8YcDvTd9cN+W7ouhR4x2tl/HAKW8+3eQYL9i
 pTzQ2SkeiawSvVtog6KRDlEV70AEIHBvGNqdS5y00iHhl5X6oxIRotHX29MYlFo6Sckv
 DEbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgAHaiacWWAF2OahW7mvtii1BdOG72g6uYpm61zrqf5wBYb1BPipJovzrR/EDRk+yde74bT60+s3jBfDUIndmd7pqPr4U=
X-Gm-Message-State: AOJu0Yy3xPkYeY+7wvsTt7YbLVKJy1HL9Ga3GnBxQ1bzJsT+7CdLplFU
 zCjzfY+Ws7vZzrbj8brUu1C14n5nYX7xX2HEejcy1ag+Ewn1OdDVoP8WAmgfnYfVEhzCq3s3Pa0
 V
X-Google-Smtp-Source: AGHT+IGQFYPb8anMKfV2eEQMYBPrp6VQbKQTuBm+Pd2nPM3DoDIWdMfSdnA7PLlpNcKNiznXzC4kpg==
X-Received: by 2002:a50:bb07:0:b0:56d:b687:5a45 with SMTP id
 4fb4d7f45d1cf-5731d9ccf90mr1924003a12.1.1715182438229; 
 Wed, 08 May 2024 08:33:58 -0700 (PDT)
Received: from [192.168.69.100] (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 c10-20020a0564021f8a00b005727e826977sm7696327edc.19.2024.05.08.08.33.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 08:33:57 -0700 (PDT)
Message-ID: <0d5d9ea1-bafb-46d0-8543-c5c6921003f1@linaro.org>
Date: Wed, 8 May 2024 17:33:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/33] disas: Use translator_st to get disassembly data
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240424233131.988727-1-richard.henderson@linaro.org>
 <20240424233131.988727-20-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240424233131.988727-20-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
> Read from already translated pages, or saved mmio data.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/disas/disas.h     |  5 +++--
>   include/exec/translator.h |  4 ++--
>   include/qemu/typedefs.h   |  1 +
>   accel/tcg/translator.c    |  2 +-
>   disas/disas-common.c      | 14 --------------
>   disas/disas-mon.c         | 15 +++++++++++++++
>   disas/disas-target.c      | 19 +++++++++++++++++--
>   plugins/api.c             |  4 ++--
>   8 files changed, 41 insertions(+), 23 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


