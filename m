Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 563B0C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 07:50:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3t6A-0004OL-EO; Mon, 06 May 2024 03:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3t5y-0004GH-5P
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:49:11 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3t5w-0000xk-6k
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:49:09 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-41bab13ca81so17301485e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 00:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714981746; x=1715586546; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AG9JPJ2NO0frLDtYOlHEhWYFOcm6MOuVJVo5/lWL+g4=;
 b=gG/ozM4auoUUcbP/6tSdeFpX9q5ZFT9sua1RpB+WFP66y/8Z2UKBw/CuzWr29bwdPb
 vJy3gNSw0dGqWUGg6XCn/+FshQ0oAhFlAOKvVE2yeaJZdTaddjIlgH1jgtY/BLrWzORG
 gia7sekFKIWPXiPVTjktAjuDNMZ4Lx1KgxBGsZuuUMzwES8PCkTyowYBtJIw2zJ+rBrq
 j9xunW3xQjaE3kObL8kslakGdPsbjaUPiWT+kY8Rg11niza2h6rkGSlIkiFsYOgB6kDj
 psbr93F9mWHgEaJiYGN4ant7SjJvBNWW0SbOwA7VT/Jk0Y1JDMaRrgStWv8vKHMwbZxD
 hE9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714981746; x=1715586546;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AG9JPJ2NO0frLDtYOlHEhWYFOcm6MOuVJVo5/lWL+g4=;
 b=KGn6xhA1b1ZijEFFuGvGqMiMuXvBb94VT087eeoELDLn9yKKhwkKtJud4hmW9dxGnO
 1CON8LyjTA4q7vdq+QXBrQBal15KmTJymu1M4TfmlV4ULIcqlz+RL76RS1M11rSKvD2B
 cVi6cSZ9KH61Mn5H5XIeDObbqxLJyP1Zidxuf7pmA1QYlmQrv0C0RAwwU7631jPVPyjs
 35hlWvsrlFtmy4AKJHGjvi5AdTRqpIfdT6X1ZWcLLioyuAOk4yiau23yRFPidKH0BtJJ
 dFNXVH+SOhjE4sx5cR9HeVU6XMyC/2qD7SGWtlnWo6hssojtW4wgGzkLVCghCHyG0OkN
 7yKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWD1nywxKDafTckhN6fGYo4ci9Bc7CvATVncFN6VHyD4SQjy1AiXm9c0PMXxWvBmujULZL40cAdNLAKT67IbzYe/d1mGBQ=
X-Gm-Message-State: AOJu0Yw25ja7dAD9wiEfjW3tnOcMJ8SZ21FVyMLm/a4Vehulv2R9gNT5
 KBEYRFCJABF4Lv5trllhb5wbp50MYnR8/vOf4vksDX6jBOs9/VsKDhTm1tyxoA69ycOG6ZCNn+q
 P
X-Google-Smtp-Source: AGHT+IF9x0q4MGsWgaIRvAWwMR9RbMRYKTPrvfmC24q2OhSJf4YhJ3KzWui3CTZyPZ0MlEM138mtcA==
X-Received: by 2002:a05:600c:1e09:b0:418:a706:3209 with SMTP id
 ay9-20020a05600c1e0900b00418a7063209mr10053658wmb.31.1714981746453; 
 Mon, 06 May 2024 00:49:06 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.211.4])
 by smtp.gmail.com with ESMTPSA id
 w15-20020a05600c474f00b0041ea90d11edsm5178504wmo.31.2024.05.06.00.49.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 00:49:06 -0700 (PDT)
Message-ID: <5c1507b8-7f6e-419e-972e-af4fc98e9112@linaro.org>
Date: Mon, 6 May 2024 09:49:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [sdl-qemu] [PATCH v1] /hw/intc/arm_gic WRONG ARGUMENTS
To: Andrey Shumilin <shum.sdl@nppct.ru>, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-devel@nongnu.org
Cc: sdl.qemu@linuxtesting.org, qemu-arm <qemu-arm@nongnu.org>
References: <a4cbfe6c-27d6-4df0-ae31-db0d60d88f9e@nppct.ru>
 <95ab6dcf-cc96-4472-93ab-f08682b37d5e@tls.msk.ru>
 <4c4dfebb-698d-466f-90b0-9475ad4c123a@nppct.ru>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <4c4dfebb-698d-466f-90b0-9475ad4c123a@nppct.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 5/5/24 21:57, Andrey Shumilin wrote:
>  1. Possibly mismatched call arguments in function 'gic_apr_ns_view':
>     'cpu' and 'regno' passed in place of 'int regno' and 'int cpu'.
>  2. Possibly mismatched call arguments in function
>     'gic_apr_write_ns_view': 'cpu' and 'regno' passed in place of 'int
>     regno' and 'int cpu'.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 

Fixes: 51fd06e0ee ("hw/intc/arm_gic: Fix handling of GICC_APR<n>, 
GICC_NSAPR<n> registers")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> 
>  From 23b142f5046ba9d3aec57217f6d8f3127f9bff69 Mon Sep 17 00:00:00 2001
> From: Andrey Shumilin <shum.sdl@nppct.ru>
> Date: Sun, 5 May 2024 20:13:40 +0300
> Subject: [PATCH] Patch hw/intc/arm_gic.c

Your patch is malformed, see:
https://www.qemu.org/docs/master/devel/submitting-a-patch.html#submitting-your-patches

> 
> Signed-off-by: Andrey Shumilin <shum.sdl@nppct.ru>
> ---
>   hw/intc/arm_gic.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
> index 7a34bc0998..47f01e45e3 100644
> --- a/hw/intc/arm_gic.c
> +++ b/hw/intc/arm_gic.c
> @@ -1658,7 +1658,7 @@ static MemTxResult gic_cpu_read(GICState *s, int 
> cpu, int offset,
>               *data = s->h_apr[gic_get_vcpu_real_id(cpu)];
>           } else if (gic_cpu_ns_access(s, cpu, attrs)) {
>               /* NS view of GICC_APR<n> is the top half of GIC_NSAPR<n> */
> -            *data = gic_apr_ns_view(s, regno, cpu);
> +            *data = gic_apr_ns_view(s, cpu, regno);
>           } else {
>               *data = s->apr[regno][cpu];
>           }
> @@ -1746,7 +1746,7 @@ static MemTxResult gic_cpu_write(GICState *s, int 
> cpu, int offset,
>               s->h_apr[gic_get_vcpu_real_id(cpu)] = value;
>           } else if (gic_cpu_ns_access(s, cpu, attrs)) {
>               /* NS view of GICC_APR<n> is the top half of GIC_NSAPR<n> */
> -            gic_apr_write_ns_view(s, regno, cpu, value);
> +            gic_apr_write_ns_view(s, cpu, regno, value);
>           } else {
>               s->apr[regno][cpu] = value;
>           }
> 


