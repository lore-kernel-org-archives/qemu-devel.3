Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E55DC48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 16:10:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcpAI-0003Z7-Qp; Wed, 21 Feb 2024 11:09:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcpAH-0003Yn-4k
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 11:09:45 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcpAF-0001ZG-Ll
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 11:09:44 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a3e85a76fa8so378443966b.1
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 08:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708531782; x=1709136582; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n3IIbYcVuMhg8KhNRHLaxZ00549+QuDTgHn0Bvr5zI8=;
 b=UAXtEJnIjArzbvQe6b8JhBeycdzteSKn4XK25DgdmboRgUxEbLwy4b2UWO+i7ymHgh
 +H2JCkVkLmhrAq9gTpcn/PFTO9zmRtA50eXxr4M1PD3WZ94EUlYWKRkEeR4mkVCfx0ub
 xzOW8xYo1YOlRDb7ST2sUKN3mH0ItadCDRGCfUjX9lrW7H4rYknmd9uhifdNQj07lX2B
 slPqlph6/J+vSYeZr0B3eDhN9z6KSP9zoGLgYQpf1qBm0EZb3VDTKMU+3d5UIWAizHOq
 y53XJbV05+BEa6lBlLCL0hVU3B4TUxq0akm6hYaFQTHVrwquYeABJC4d3Mk9PQp+Aoz2
 1obg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708531782; x=1709136582;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n3IIbYcVuMhg8KhNRHLaxZ00549+QuDTgHn0Bvr5zI8=;
 b=a4XGQgNMEub7iShWw/K26yPUnoiX6rKMqlyIEB5RuQfOErfdMpV31V75H1WXyv4fz+
 EvFEPfSZ7vRV7/wgsRkQKzQ6Ar/rEwYm1yHlRJXNJGJ+fGXziaIHzZ8uV0laqyJ4Db/b
 s+UACm8anSPblU1N/AQOy9Vk1yM+kN+dD30AtQaXBGb548YA0mPVsfCS5k1gYgF7DUhI
 BsbtnPaokRM1l+uCBz4kBqbSzU1FvDIjLKfLiDf5LlRBpI6V1oZOxfzxTLGSEs30ly4w
 24Pc1khPOS0FgXGFS5licELJvfUB3tSRrHiXZ5w0VkW2tkZZC+4AeKtuIIjNaX5i0FQE
 zdOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVXdfsaez/ESTCAfn3corN7BIMH2gYqsRuDW2mCyRoEe/7xtI2Gz1KID35Gi4fsx6adE3wQqyHfO5YLRFVEG3xiDVfkHg=
X-Gm-Message-State: AOJu0YzxOIPc99jO9VL5MTgvq2M0NATcBWbwjGb7CMlIj/G5vBaJjwJp
 Lpywkf54epd1VNbCYjv8cMqcnnCVw8vkphomajis0wxxynjBIk/YGs6P9plv5L4=
X-Google-Smtp-Source: AGHT+IFtoSAKFVHroD3xJNEBLT+vySwVvd3agKU+8CHAOrX88/biOw0qnVHFOfwnjrke6MACK9oNaQ==
X-Received: by 2002:a17:906:34c3:b0:a3e:b407:65ab with SMTP id
 h3-20020a17090634c300b00a3eb40765abmr5410110ejb.50.1708531781885; 
 Wed, 21 Feb 2024 08:09:41 -0800 (PST)
Received: from [192.168.69.100] ([176.187.211.34])
 by smtp.gmail.com with ESMTPSA id
 vb7-20020a170907d04700b00a3d6737afe2sm5075282ejc.138.2024.02.21.08.09.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 08:09:41 -0800 (PST)
Message-ID: <56817323-4565-478d-8ab1-a415c38cc789@linaro.org>
Date: Wed, 21 Feb 2024 17:09:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] hw/i386/pc: Confine system flash handling to pc_sysfw
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Sergio Lopez <slp@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240208220349.4948-1-shentey@gmail.com>
 <20240208220349.4948-7-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240208220349.4948-7-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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

On 8/2/24 23:03, Bernhard Beschow wrote:
> Rather than distributing PC system flash handling across three files, let's
> confine it to one. Now, pc_system_firmware_init() creates, configures and cleans
> up the system flash which makes the code easier to understand. It also avoids
> the extra call to pc_system_flash_cleanup_unused() in the Xen case.

Maybe add " because pc_memory_init() is not called by Xen."

> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   include/hw/i386/pc.h | 2 --
>   hw/i386/pc.c         | 1 -
>   hw/i386/pc_piix.c    | 1 -
>   hw/i386/pc_sysfw.c   | 6 ++++--
>   4 files changed, 4 insertions(+), 6 deletions(-)

Nice!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


