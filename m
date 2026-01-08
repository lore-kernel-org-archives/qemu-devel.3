Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B1FD1D47B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 15:27:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdru8-0006t0-58; Thu, 08 Jan 2026 10:26:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdru5-0006sQ-Rv
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 10:26:25 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdru4-0006SD-8N
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 10:26:25 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-432777da980so1814038f8f.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 07:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767885983; x=1768490783; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=er190dVj/QEv5Aco2lQ/G4IVvoGhfLvfd28B+TWtRB4=;
 b=Me7bFIrD0h823fmjiK5YDlsZV1ye0QPcx3zBQ0SFEWH927IQ/4gv33WonXfiV1ajW/
 jGCsUmrBT6aYIjoRmI+xjL5OStac8bDItE8uXOS+V3Jh/KN+eDwGlnBoQ7p4nPkeszP7
 duwDrUzVsBQo45Su6ZUKsO8PLyb2AtNThJgcJHhxLpogxXynKpPH2C1jjf0/usE8bZow
 ZolKchYJd3vh9KoTGvJ2ZcGEY/wnq7kHUFYO5GHM77Ggg2aVYlMQ2Jzcu9yRevCzSjgU
 XwyXQs4Ml9/ccR60AurDEojxkVTuLWjE6icMAisSwvvypa/J0eFcSebhalFJZUs+Mjoi
 f+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767885983; x=1768490783;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=er190dVj/QEv5Aco2lQ/G4IVvoGhfLvfd28B+TWtRB4=;
 b=kf59BNamC1ZCRLkEjfhLvgG2uyrI0JOIxPCO5HUghpK7XWX96qX7kWTkgPWrDIluua
 ++gdXvM0A7j+5u9Y0dhT8W51umWgYkSnQz/GY8/iJ3SvnHgZBnW3B9+O0sLAvhauDfUF
 oBSNGMAFUWUcxLWzG29qpEuv6ZlghDunr9J++BMfpuv1lr66q5Kgx9GZIk4C4AW5jY93
 wPZ4mAJ3tccneu0n06MUEQZJfmcY3Mw7hjlQA4lZoHaNuQC8AyLsfKOR66txJgUV3C9A
 88ExJ2v9lUQ1uz7QDzCJZk0iJCwegZxbJITjnI6P9MpwnRgU313RdnuEmmb0jpncBCOZ
 R02g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrVfE+lZEdHiH+4nYlL7/jY4ejm9Dzq/yLoYESeSDDwnjhELQ6hU56M0zA915d5nllX9fPPd0+zeVC@nongnu.org
X-Gm-Message-State: AOJu0YyEwc5Y7Wp8gTu4c+2AjpK4vZGnpl0hNEpeB83L8vmw9OeadoxZ
 UHQZY9w1qUWSHZzHhpuPurn7kY1up3EK0NPmxYntR9Aq03FtZJiF1k2d4b0FvqB1Sj0=
X-Gm-Gg: AY/fxX7BuM6DVcXjQTkORtZXzMba0XjLzs6sOf+EyHLPOq6m5rJiEqZ6S9dKkqOWaMS
 ojo516f9Q+r8W/KiN5aUMcBoEGVmpTctRxBs16XcyFVvlZ3nWsbsb0MWy1oStUIADglu2eCrJaQ
 Rn2WRD/NTBL9s5ojVblWQ1d7dnIphlMpsrfOlu0+4DxFPpIDtlv1bYjM+YM8R8zb7E3k9coytYH
 nwiBIGYDS6LDcRTMCM5FNELuoZ03jXTsK11px3E9niMVy06EtEXqjYIYvs0UYKJE6LZ5gwsI49/
 HUQ1NgBsVpIqIMrRC5ejAkKoubIKx5lqIYbyc0Hdwzjqlgp94gADxjPiE4wox00k29WCBvGoIxe
 yeVUiLqftf+or7Jae3D73mBSr057QnPDJG3GEGdK4f9MPpDv5JcQ2D4wNsqtqdl+l19p1f4EAt0
 NWmDF0Oxk5Kxsp3K47Ps8ZnCSjotKh9CTTmAKfJQELHvPWQ25Y7YmDWA==
X-Google-Smtp-Source: AGHT+IEiEeZhMQ54uAfGPF6KcYh0ICA3A6rrnpJifgmq6449UFRYTk7asQtmghP5F/FSGbEQ1KpHNQ==
X-Received: by 2002:a5d:64e7:0:b0:430:f7ae:af3c with SMTP id
 ffacd0b85a97d-432c374fc2dmr8259422f8f.31.1767885982616; 
 Thu, 08 Jan 2026 07:26:22 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ee243sm16726075f8f.31.2026.01.08.07.26.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 07:26:22 -0800 (PST)
Message-ID: <2fc0c7f0-e3f6-40ea-b114-7f17ab8cd017@linaro.org>
Date: Thu, 8 Jan 2026 16:26:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] hw/core: Deprecate query-kvm
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org, berrange@redhat.com, eblake@redhat.com
References: <20260108131455.2240598-1-armbru@redhat.com>
 <20260108131455.2240598-2-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260108131455.2240598-2-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 8/1/26 14:14, Markus Armbruster wrote:
> query-accelerators covers all accelerators, and should be used
> instead.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   docs/about/deprecated.rst | 4 ++++
>   qapi/accelerator.json     | 8 +++++++-
>   2 files changed, 11 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Long due, thanks!

