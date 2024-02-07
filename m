Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA83C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 18:59:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXn8I-0004h3-7P; Wed, 07 Feb 2024 13:58:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXn8G-0004gr-Fe
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 13:58:52 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXn8E-0007EW-SG
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 13:58:52 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-33b28aadb28so750901f8f.3
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 10:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707332328; x=1707937128; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qKsyMgjAhaOgB73+6+cP57A3bnhGu4oc+/RrQRs6Cx0=;
 b=MNYRi4N9MGvq3/GowJHtm3PRckZqytb33OG9YPUSV6NB5C3VX7fChx13wuGH8r5HlP
 rKy4t47mhIVOhIcD4eEtTAbLWjAvydmq0hg3MW2UEkXiqrtFLWNJHGAWt6YKcLP0XtwD
 puDGmWJde72Re5tsJhyfzb6TTT5RhO4Pp9lfhGR2HzptaI6tKgdW0iM+D2+Ilpve2dj6
 xWi2Q9IWdylncqGRb0vgkglQ8NpU+CHpEakXNcrVVJMNQVs3+1kMW3ANj7z1mM+f965o
 A3FQnCwVdyfiKkrJo5dMW7GUjIBFMEc4QdlbRZ6hm6RjNELlBPxzqDCcC+rQ/ttIlkvA
 pVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707332328; x=1707937128;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qKsyMgjAhaOgB73+6+cP57A3bnhGu4oc+/RrQRs6Cx0=;
 b=M3QAPc4q6xaxNO5xZpRKreQXZmG74Hye5YVtqtBQ88kVBg5EhNHBf3aoBec5uteuGx
 hyEFbIgw9TtuCQ9oB0xFpEi+MW7jdeISjJU0oGS8rG4t7kAU68RsofkTFc/XEVo68ggw
 wpThgaPNyZgwb5EnvPcisW3Bkqa8hiGcJu6/c9pjVafdjErEIxGLRLA9MIkeeDxSq3sB
 nKYxpsWq2VHUYNBc+jkqUYuA+mBdyrgEOTSJBfrB059jGJRE/5oh+2HTN5EdQOYUXXyo
 pq6w93ZuAatKLFRj6vJSnt+3YLaoTAcy2o9DcIpSjWxeem1JEFW+MSISIUHBLpUVkVOS
 6hFQ==
X-Gm-Message-State: AOJu0Yz1gEeH/nKdAfaKTz5lI+g4yklW4uTVNEYle3sZHNRvQvcZlqKN
 hfoNZqg4xja7JikGM+9RqZDdJx3nSNiP4TiyXvF05Q/0J9Cisus+hTjRmreOe6U=
X-Google-Smtp-Source: AGHT+IHlpW2MsiODuijx4uIpi5etyWVOsIl3tqnoKdEoub1fiiTjhW1aIHYQ/oUVMCBtFIGP1W018w==
X-Received: by 2002:adf:ef89:0:b0:33a:e8be:51bd with SMTP id
 d9-20020adfef89000000b0033ae8be51bdmr4076952wro.51.1707332328248; 
 Wed, 07 Feb 2024 10:58:48 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVdb8AFaBrOfNc2naNAuODFjjVFPj4kOOqPti5VfB9eij3w9qQOPr9nq3/5N0Rvs902S5jk3NA8XX2a/4VcsSjosWVLQUU=
Received: from [192.168.69.100] ([176.187.214.82])
 by smtp.gmail.com with ESMTPSA id
 g16-20020adfa490000000b0033b50ed5f98sm1384764wrb.72.2024.02.07.10.58.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Feb 2024 10:58:47 -0800 (PST)
Message-ID: <078c8c89-f468-43d1-9ca6-4c485f09c9ba@linaro.org>
Date: Wed, 7 Feb 2024 19:58:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] hw/mips/Kconfig: Remove ISA dependencies from
 MIPSsim board
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: shentey@gmail.com
References: <20240207111411.115040-1-pbonzini@redhat.com>
 <20240207111411.115040-4-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240207111411.115040-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 7/2/24 12:14, Paolo Bonzini wrote:
> From: Bernhard Beschow <shentey@gmail.com>
> 
> The board doesn't seem to have an ISA bus at all.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> Message-ID: <20230109204124.102592-3-shentey@gmail.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/mips/mipssim.c | 1 -
>   hw/mips/Kconfig   | 3 +--
>   2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/hw/mips/mipssim.c b/hw/mips/mipssim.c
> index 01e323904d9..abbeb6390e1 100644
> --- a/hw/mips/mipssim.c
> +++ b/hw/mips/mipssim.c
> @@ -31,7 +31,6 @@
>   #include "hw/clock.h"
>   #include "hw/mips/mips.h"
>   #include "hw/char/serial.h"
> -#include "hw/isa/isa.h"
>   #include "net/net.h"
>   #include "sysemu/sysemu.h"
>   #include "hw/boards.h"
> diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
> index ab61af209a0..afcfb2b8eca 100644
> --- a/hw/mips/Kconfig
> +++ b/hw/mips/Kconfig
> @@ -6,8 +6,7 @@ config MALTA
>   
>   config MIPSSIM
>       bool
> -    select ISA_BUS
> -    select SERIAL_ISA
> +    select SERIAL

Hmm there is an ISA bus which can be exposed with:

-- >8 --
diff --git a/hw/mips/mipssim.c b/hw/mips/mipssim.c
index 16af31648e..a1a4688861 100644
--- a/hw/mips/mipssim.c
+++ b/hw/mips/mipssim.c
@@ -209,8 +209,9 @@ mips_mipssim_init(MachineState *machine)
      /* Register 64 KB of ISA IO space at 0x1fd00000. */
      memory_region_init_alias(isa, NULL, "isa_mmio",
                               get_system_io(), 0, 0x00010000);
      memory_region_add_subregion(get_system_memory(), 0x1fd00000, isa);
+    isa_bus_new(NULL, get_system_memory(), get_system_io(), &error_abort);

      /*
       * A single 16450 sits at offset 0x3f8. It is attached to
       * MIPS CPU INT2, which is interrupt 4.
---

