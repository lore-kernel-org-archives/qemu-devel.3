Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A7B5C54788
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 21:48:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcuQv-0000Jf-Rm; Wed, 21 Feb 2024 16:47:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcuQu-0000Fg-Ex
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:47:16 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcuQs-0007JR-UA
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:47:16 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1d7431e702dso70817595ad.1
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 13:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708552033; x=1709156833; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xaHEju4N6XZEKAd1TC8U2j6QNIS2DMzjyHv3tA7Eee4=;
 b=b0iX2NC8Dzm1XqaXvtQIimFUUalBjO80mmQyO86p/oGE5vwGQDME5Mtuq+/XnBfRGJ
 V8HnTrbVmwIp4Gi4NmwsWrSobwPeMyDdz0hXUpa5+Cqnkx5P22JoBDBFyCoVZUYf0img
 0VtsjjNEE9RvxyBwdILT5pmThppGxEHEkyq0AM+TRwAoqH6KQLXsCjAWZ3fdzGMgy8yr
 FLpRQNevOF0rFgKgMByeAhVSO6ddulktBEaVLogwqBmbp+HfzD3GXF6nTedQzuCAlRG/
 W2gtdl5yh0fQXL8xRUkA0qLLLn/ZHdYonnQdz2QP24DEnWIwcSCvShHIZWg/DlV8eyaM
 3r8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708552033; x=1709156833;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xaHEju4N6XZEKAd1TC8U2j6QNIS2DMzjyHv3tA7Eee4=;
 b=uU7bwWL/9GDnjXJFSc5OKwg6whXusM1kG74V+Ihl7OJdgEIo/m0N8ZoW3fIL4pjVji
 O9l/WXArpSgp3mZirOdHNEl3j0+N1zDS/1XFvQgmJCs1JapCFlTHg5CEaUTp1ftbpnX7
 Jugf0+uEwJXEtYwWOKIJpyBICiL7zO10MTIAqKT3BsYBiNY/Ny1H9fu053uScpUhWqt4
 FTLCxnVBmPzThMgblWsZqZzy96FxdYTq83Aa9uIXYpYfdcOQypqN1ZM+sCxovpGSKJpb
 dYHT5wnc07rxBzC7j+CRauCIWQGcaz0l79rxhTgaGpQlH7w26M1Wc0S1nsCkNE6N7gfq
 e7oA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgXFZeqMweyJkLIjFri1TaLRmfvCpBtT+ZR5i3iqdpb6nUj2nQ4tbrpA5ImMMA8jmYkKgBdaOZgHzjUAp7sQSZXynkSZI=
X-Gm-Message-State: AOJu0YxJXaBLNKDQE5su+Lqq81GhOuGoetrzlDGGOGWYUK6laidyON8a
 FAyff4woh/QAVKFWVmQF7EspSmVz8r6UEgZmpxIGk7Ll+2WBlzlurFTeEmCNI6nmZLUKzJ3WMd5
 I
X-Google-Smtp-Source: AGHT+IHmvtPB+gIXRiTXx2JyW4lMwDQHl/2wdwF+VhHWzP18HzZ3bLATj/DCedmBQqGBe4tjGF8t2w==
X-Received: by 2002:a17:903:2346:b0:1db:ab71:a4ae with SMTP id
 c6-20020a170903234600b001dbab71a4aemr14723192plh.42.1708552033309; 
 Wed, 21 Feb 2024 13:47:13 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 ke8-20020a170903340800b001d901c2087esm8577345plb.302.2024.02.21.13.47.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 13:47:12 -0800 (PST)
Message-ID: <f5f07aa2-6fe3-4030-b045-5110cfa0db74@linaro.org>
Date: Wed, 21 Feb 2024 11:47:09 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 18/22] hw/arm/virt: Add FEAT_GICv3_NMI feature
 support in virt GIC
Content-Language: en-US
To: Jinjie Ruan <ruanjinjie@huawei.com>, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240221130823.677762-1-ruanjinjie@huawei.com>
 <20240221130823.677762-19-ruanjinjie@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240221130823.677762-19-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 2/21/24 03:08, Jinjie Ruan via wrote:
> Included support FEAT_GICv3_NMI feature as part of virt platform
> GIC initialization.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>   hw/arm/virt.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index c442652d0f..0359dbd8bd 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -772,6 +772,8 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
>           qdev_prop_set_array(vms->gic, "redist-region-count",
>                               redist_region_count);
>   
> +        qdev_prop_set_bit(vms->gic, "has-nmi", true);

This should be set based on whether the cpu class created has FEAT_NMI.


r~


