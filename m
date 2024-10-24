Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC1BD0BB4F
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 02:42:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3nny-00032h-Sb; Wed, 23 Oct 2024 22:42:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t3nnv-000329-O0
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 22:42:28 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t3nnu-0003TN-4x
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 22:42:27 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7181c0730ddso185683a34.2
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 19:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729737744; x=1730342544; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dn9RyRAupsxgr1jkJrQWEP7jDgyqopxgQup/T9hL8VM=;
 b=LMLGy9hZVWeMcugwqyFfmHISvXP5dqVwffnVDR+4krcPcmfyVnKu7NJZOFbAIJhC8q
 E4uiAKS8wwk0lnUqu7O+Uv+0j2enPTBzRV0N9LcpVBb/tnzNqFFzwb55/mj1BYF3aYr5
 hmSbJuzf13GIk82VIYY0tWdArIIxmKsAze3O6dozYru6tKC77cogInNJrgeOHYWlEBGz
 piNGT1/7/e55Kif0uHoNL7SOe0AyyS0SxdztkUUu3YOYdMGHNzjAQkcfGsBlO6DiwgT+
 I6oCQorYBo8zRtP8DhsZOKXkxDxcFP5ZD1TO1o5msfkIzbeMTCYDrKD/7NuwUQcoBMR6
 FKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729737744; x=1730342544;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dn9RyRAupsxgr1jkJrQWEP7jDgyqopxgQup/T9hL8VM=;
 b=WCnMQP3ryJqxUITh3tWCb4TOEnQHoUCPweJjArFfLVCKAyN2je0rupQFLvXDm5tnsI
 gufaxxLh0clfgi56JzA/zuCj5+Ppm1Dy40sU40Y6LNbu97HxH8P2bAWQ46w7cPYLdssJ
 zsQ8tIgP76kz0DFtgOTLUakczzGvrgUjiiSlPD6SOBW/DWI2nxGJV0L+dkhbS8JUIzRv
 67Rycwh3VD9Vt55pO6AAhkWG3/kr2GBID8dsXTtMNz5ohYZB9hUUBIvPWECaDig8il9q
 3owkcOym7vfgSoPteAMCtixahL/bPBwE3F4FhiwSz13jotjK8VIGm9PqfrYcoSvkHzIA
 mDbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXN7yqGhOBE5DDNm4defKxUpFT/QXRVRCBWUqDMW+tQ1dMwRFxJ09Xq2dc2obaSNhfRz+G1TNTVvvgd@nongnu.org
X-Gm-Message-State: AOJu0YzQXBPhc/tGaREapejn8Ealqli6z6Yzb/5jQemL/dq4eKH1/Moy
 pLZZI5FoK5llQ1JmCScOMA8XWiCngR6DJruauWY1inVCLLesQLXihbCxuBopM+FrWYby/Llc7fg
 hBs4=
X-Google-Smtp-Source: AGHT+IEabsY+NepfnciosHyqYicMGCWbuBlTgzmIyXNyWsKt9dJYUcz8RSZid4I6zqC/b0JIdge0DA==
X-Received: by 2002:a05:6830:6d88:b0:718:1160:66fd with SMTP id
 46e09a7af769-718598598a5mr235234a34.26.1729737744334; 
 Wed, 23 Oct 2024 19:42:24 -0700 (PDT)
Received: from [192.168.100.49] ([45.176.88.171])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71ec1313a10sm7036819b3a.38.2024.10.23.19.42.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2024 19:42:23 -0700 (PDT)
Message-ID: <28ab5799-d096-4000-8806-0a30eeb10ba6@linaro.org>
Date: Wed, 23 Oct 2024 23:42:21 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/36] next-cube: remove overlap between next.dma and
 next.mmio memory regions
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, huth@tuxfamily.org,
 qemu-devel@nongnu.org
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
 <20241023085852.1061031-4-mark.cave-ayland@ilande.co.uk>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241023085852.1061031-4-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-ot1-x335.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 23/10/24 05:58, Mark Cave-Ayland wrote:
> Change the start of the next.mmio memory region so that it follows on directly
> after the next.dma memory region, adjusting the address offsets in
> next_mmio_read() and next_mmio_write() accordingly.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/m68k/next-cube.c | 28 ++++++++++++++--------------
>   1 file changed, 14 insertions(+), 14 deletions(-)


> @@ -897,7 +897,7 @@ static void next_pc_realize(DeviceState *dev, Error **errp)
>       qdev_init_gpio_in(dev, next_irq, NEXT_NUM_IRQS);
>   
>       memory_region_init_io(&s->mmiomem, OBJECT(s), &next_mmio_ops, s,
> -                          "next.mmio", 0xd0000);
> +                          "next.mmio", 0x9000);

Please mention 0xd0000 was incorrect, otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

