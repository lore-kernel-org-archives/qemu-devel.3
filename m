Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B825EC04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 16:21:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4k2a-000626-2k; Wed, 08 May 2024 12:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4k2Y-00061p-Mr
 for qemu-devel@nongnu.org; Wed, 08 May 2024 12:21:10 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4k2T-0006Mj-7n
 for qemu-devel@nongnu.org; Wed, 08 May 2024 12:21:09 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2e34e85ebf4so31114801fa.2
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 09:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715185263; x=1715790063; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WUHnHpwMf8BvaPrjbKUlAMw8ZVLJYlT7QG0WqWUCLRc=;
 b=g2q8x5wfiJehkRBed8gFJrvWN/SUUPBlgojWkGgIrno1dog+9jtyfu/ndKfbc+GAmb
 2Ir0ai6N+VaewcANtcNU65Yb+fdBngQK8e1B58VVKWqWNNKbEclwnenhhz1ApMW/faTs
 ZZhggss/h0qBIiabBZkoQn7H8Mkf85nJGtM+EQwDtnQXBLl5oJaatS1Ys5WcRHr7mxRg
 G8hGSaVeF0NOHnjpWLxYVEw+FQANMiA56VabbsX7lrd9Sw4qVjJjHKkQig11U9sAasZk
 sFj8uitHOWmJNkxDH7Ui/XXw8Vx1roS9jG797oztqs/nM2mxpnCCwToyhz0EkL4ecrTM
 QxoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715185263; x=1715790063;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WUHnHpwMf8BvaPrjbKUlAMw8ZVLJYlT7QG0WqWUCLRc=;
 b=LvQUqdaQlgfeiqHr2Iq6iVou3ebQdDfy1M4m2znCzv4oabfxR1XzWuZxm9pwT7WnFf
 f3ENa+Wcvqg2od0dLwQew3a+IGKE62+mtBJX7v8A2Cj8szNt9DDHWbe5ZvaKQBOUwSr8
 4Kb9D9u9AZjwlVmYTEQLetr1PC0Rp2oc3o1ZQseQR0Jt21Oxy/zPeUdM3Vv8SEsP+D3Q
 dCrjMmHHnfevVPfCF2sshrnR7wqMepHWBb/wuG2EIr0ENxnWxODjWy6hCEviYf2t599o
 qKiHq6BrIpxaoGXWkuoMKNEm0X6MUq36k1y304t45ahI0IrNpbP4xvzPT7AjVUG6//yv
 YBPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbtlWdEjW54gdEIxnVsFeosv4rf92ssu2POhWwRoobi1nVQn+HCTh42qA27rEZtx0oaDAw3cHsz6MzLtMZYKN8KqWLU9s=
X-Gm-Message-State: AOJu0YyIA9rygFzGMd5sTtmx2yxMJsMc2BqDae+sADvxJ7ntU2i+qUOx
 kEvnNlRWT2a5EWJUwm/Sm+1oNCoe8i9YI2YQ8FS8YESNDpTjJeDOmVOWqqYDSZU=
X-Google-Smtp-Source: AGHT+IFOOYYvBNZC7d5Qr7oVY1bCwP5wSHGVHSnnnBmFwHXLIg3qDzPuKteL/m4IacpC9QJIYfXklA==
X-Received: by 2002:a2e:80d4:0:b0:2e3:cba4:22f with SMTP id
 38308e7fff4ca-2e446d83e06mr19968671fa.11.1715185263249; 
 Wed, 08 May 2024 09:21:03 -0700 (PDT)
Received: from [192.168.69.100] (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 k6-20020a05600c1c8600b0041facbd2619sm999591wms.13.2024.05.08.09.21.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 09:21:02 -0700 (PDT)
Message-ID: <05ee02c0-c189-4c67-8988-c1b646a2c107@linaro.org>
Date: Wed, 8 May 2024 18:21:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] hw/intc/loongson_ipi: Implement IOCSR address space
 for MIPS
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Song Gao <gaosong@loongson.cn>
References: <20240508-loongson3-ipi-v1-0-1a7b67704664@flygoat.com>
 <20240508-loongson3-ipi-v1-3-1a7b67704664@flygoat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240508-loongson3-ipi-v1-3-1a7b67704664@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x235.google.com
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

On 8/5/24 15:06, Jiaxun Yang wrote:
> Implement IOCSR address space get functions for MIPS/Loongson CPUs.
> 
> For MIPS/Loongson without IOCSR (i.e. Loongson-3A1000), get_cpu_iocsr_as
> will return as null, and send_ipi_data will fail with MEMTX_DECODE_ERROR,
> which matches expected behavior on hardware.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> I understand that there was a review comment stating that I shouldn't
> use TARGET_* macros in device drivers. But I still think this is the
> best way to handle architectural difference. There are many TARGET_*
> usages in hw/virtio for similiar purpose.
> ---
>   hw/intc/loongson_ipi.c | 39 ++++++++++++++++++++++++++++++---------
>   1 file changed, 30 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


