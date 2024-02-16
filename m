Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0519DC48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 11:14:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rawAm-0001xZ-V9; Fri, 16 Feb 2024 06:14:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rawAl-0001xQ-Ta
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 06:14:27 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rawAk-0003MU-9b
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 06:14:27 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-33d173acb98so371912f8f.2
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 03:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708082064; x=1708686864; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pxjjimkw9N157KH/wCqjV0z5Lt8mUHsBZFQNZNjoTnI=;
 b=DVd4BPBvAU3yJnC2Sbz/f/xuF+jIMPzCP5CDsUcJHZxnm/mb1GJwB6CAlIuUWt7wkJ
 JOl75GjhcVIc/dz9D9EwBKcIBV94FcsUj/hQLH5oKD2BJy8iFUjixLWSiZkvZC/gDCTQ
 Ww4iKK4YppzFC1LG9athoospIfrVLcQDrnEEn6wAIBnQLs/Lb80/ndb6+Q4spfnSo3WF
 Bb860+A4eNt09ZLyy30qxxXymwkc6/mknMo7to1pbSCEOVvYzJ9zewgrgUi/2Dwelb9M
 rFAiXfWLzo0PPB3rcOyEupM0rh2zcWxearuH0qG2Jbl6xSNS+Cn9XyEpHXalpZ/my8Xo
 O4TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708082064; x=1708686864;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pxjjimkw9N157KH/wCqjV0z5Lt8mUHsBZFQNZNjoTnI=;
 b=TpCRMvBSEcdkthkFh8xxQ6mati7o77eEt4DCDROqqaZl2imKFFWeGvOL+QnhCVICyo
 EWp47a7ZsevRkD2Thwv6dYHju7JjHZjKyFO8aHqbFNXdw29e6wj13Co3CfDuks4dbS6W
 ghTx8PO7pPj8rA2x/cZedzB1EY0aWZhYnczQ6oDKwdoJRaK8P9D/JO0Si/GFp0NDiAU/
 GOFSoqkG6OtZZtaRGJczj0WBfgzgI45RhQkRi2D41D3An54zdxqGRhr1zY2iPG0WWfkP
 ufNqfs36KcsTy1NhkQTpquw9id+TsKMYxWCT3Q5GIQjjCIiz0tjovSX6wGgs2Nl9SFEu
 93OA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIqr/4wh3YKEkvLJhmXE9jdnRE5ihJ93tk0yWjB0+4I7tMa0HGleLMVa53AItsD5KKE8H3a8EqDb8Fez/nfMYfRqlCUvU=
X-Gm-Message-State: AOJu0YwIMDvT1Zq2VhlIt1T2sJa/vNZXrTqpJ/8uyA3JbCLuLSkSRIjl
 q0VyQWAErZVG+x76Fc7gXJvP5ppGHFM5N9DvnLKr2Jc1nL8fz2C6tRbS5H0bZHE=
X-Google-Smtp-Source: AGHT+IFfFznUDEg+Q8O7TCRY4cIvxZRbm/bRAn6voUR0n5Ns8aGVLnKSO+nSueGeottS3/jbtDA6fg==
X-Received: by 2002:a5d:4a8e:0:b0:33d:1500:ba64 with SMTP id
 o14-20020a5d4a8e000000b0033d1500ba64mr1831841wrq.14.1708082064496; 
 Fri, 16 Feb 2024 03:14:24 -0800 (PST)
Received: from [192.168.69.100] ([176.187.210.246])
 by smtp.gmail.com with ESMTPSA id
 dw5-20020a0560000dc500b0033b278cf5fesm1883407wrb.102.2024.02.16.03.14.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Feb 2024 03:14:23 -0800 (PST)
Message-ID: <55614135-f142-4c37-b280-0550207f2229@linaro.org>
Date: Fri, 16 Feb 2024 12:14:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/9] usb: inline device creation functions
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: shentey@gmail.com, balaton@eik.bme.hu,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240213155005.109954-1-pbonzini@redhat.com>
 <20240213155005.109954-2-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240213155005.109954-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 13/2/24 16:49, Paolo Bonzini wrote:
> Allow boards to use the device creation functions even if USB itself
> is not available; of course the functions will fail inexorably, but
> this can be okay if the calls are conditional on the existence of
> some USB host controller device.  This is for example the case for
> hw/mips/loongson3_virt.c.
> 
> Acked-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   include/hw/usb.h | 27 ++++++++++++++++++++++++---
>   hw/usb/bus.c     | 23 -----------------------
>   2 files changed, 24 insertions(+), 26 deletions(-)

See alternatives:
https://lore.kernel.org/qemu-devel/20240216110313.17039-10-philmd@linaro.org/
https://lore.kernel.org/qemu-devel/20240216110313.17039-11-philmd@linaro.org/

