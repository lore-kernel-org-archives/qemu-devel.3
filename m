Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 262A4D73E86
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 19:26:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlXeX-0000UJ-Kz; Thu, 29 Jan 2026 14:26:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlXe6-0008F2-Cn
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 14:25:39 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlXe3-0007Fq-Ix
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 14:25:38 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-82361bcbd8fso855383b3a.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 11:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769714733; x=1770319533; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3aIrQkM+rvdMxE1gj4afg0DNeC/uDoTmoFBxLNKi+zA=;
 b=dnvs5mBvgCBWVYjIPVRbv76L+QelR51BvUxxeGxSkaFCLB1RPVCC5piIqtq7lWXkuP
 8IRm8LBiiXseKypM0clJP4JPKfzsKcF6863f0xyec9GJJjQDVge8rxrNd4bXNUVpJDzg
 q7TjsdPPyqStMnifvm2tRfy6VoIjXSqmyGk5SbqglEy9t742/C0teOsVE3CE6Cq/mg4n
 2yP9Rs8E/2CuO2ZHckkvi2bUWRjTXR+MbJC4SIPv9/BXLlkyRsTuLGGyn2IzJtkwXSDL
 YnHxq60P0RFVZ8cZtSy88d6oxtAejGT/16AXL/R06iz15/AFQg9XEh+oL4DHMqTwEVBy
 Ixeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769714733; x=1770319533;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3aIrQkM+rvdMxE1gj4afg0DNeC/uDoTmoFBxLNKi+zA=;
 b=D2UhMA0Lq25RyDJxwEAqZPR6tIsNr7YixozpvWxOQ1SNsZdSJr2SW1rwJpZKqAU55F
 PPovszHZroSSWA2rjHODs/DUp02+gt/oLirxC1dPRSUaIuACXT/BBvW8aQfsoAvEEvXi
 pFuH00WX9xo7jilMnZnl2sBKZt3QVvvWbsGDCuKSq8W1VeyR+jdzQYNEmAnLk7CpBUTh
 f00NkNvMWTIEfKe3kk5cYwgw7ndkBrO/sJOHrV/LlJAJnBuU3t4i84GpJMhqNXLj0DJl
 WwU1/XAab1dZGvgQEvrAY+0B74QnGT2CPAyiCMqREWO/NZd1BDzGrmkS1n/HW33WXzMS
 8j6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdyDA20rcPi5OJVwdBJdKoKkTjkH0TYlerZX+yE9jI4Tv3DRR1c6UyanJVFSVmYzzZ4dX6kZOUnRJV@nongnu.org
X-Gm-Message-State: AOJu0Yz1S0QHy2CyBre+9EO6c3OVuT+iaIlE8h9AsS2C4jBz4MgO9CWO
 SWjZ6SeBwGA/h33EnYQSvheN+GYmjJATtqLB61o8BbVkYXJl3DTGenhV7THwFoEVXaw=
X-Gm-Gg: AZuq6aL8W33ZGKIPnsc4dL4CV7mug0dUo7+Wn0zncKtgPY7c06SIOgtAianXELllhZd
 g2Sz4h34rWtWyoy21RSKqCizWw+1hubB9U7uOmt284swOIfMUcz4pbB4bu2Ut9Om+EalhptKwfC
 RSaB81ybfarF6OkBfzkWwBh0/egfm7OlCN8+C2qDw/62qfNs1T+/ubSFuCXq84jeDA5FYannjlG
 uT2khr7jfj3fSCpexe+cttZPmqzLreT31mCBZeLFcnnBBwdPU1O+lxhTYl2oR95tLezbfYqhI7y
 jBQcA8mEaVBtBn3uxNFnwQZDDVbThU2EZkOzJ8sBGkfp9NhfAxumh0yM5fZUz26OWT1C0OWdHpj
 F1ghagrop02X4i5G3N+n5tr0zDZ3BznseihjOqFaWvmxO/4Pfa6H30+TqRHImgTGVhDA+M+WnqM
 apNqe6eJ6v+8n4iasyDZF7ShiS7MXkbPnTxSc8pvEmeNuU9jCMBaRsi9kJhXG6JUaKG2g=
X-Received: by 2002:a05:6a21:e8a:b0:38f:df47:87b9 with SMTP id
 adf61e73a8af0-392e019033fmr117926637.70.1769714732977; 
 Thu, 29 Jan 2026 11:25:32 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6428371715sm5518537a12.13.2026.01.29.11.25.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jan 2026 11:25:32 -0800 (PST)
Message-ID: <a2ed0d36-f5bb-4dbf-b8bf-65a08f2bc5f6@linaro.org>
Date: Thu, 29 Jan 2026 11:25:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/9] monitor: Add hmp_cmds_for_target() helper
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org
References: <20260129164039.58472-1-philmd@linaro.org>
 <20260129164039.58472-4-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260129164039.58472-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 1/29/26 8:40 AM, Philippe Mathieu-Daudé wrote:
> HMPCommand arrays are filled with target-specific
> commands, so defined in a target-specific unit.
> Introduce the hmp_cmds_for_target() to allow
> target-agnostic code to access the arrays.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
> ---
>   monitor/monitor-internal.h |  9 +++++++--
>   monitor/hmp-target.c       | 13 ++++++++-----
>   monitor/hmp.c              |  8 +++++---
>   3 files changed, 20 insertions(+), 10 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

