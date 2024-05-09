Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36034C10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 08:10:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4yqk-0007uV-Oo; Thu, 09 May 2024 04:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s4yqj-0007uE-Cm
 for qemu-devel@nongnu.org; Thu, 09 May 2024 04:09:57 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s4yqh-00081y-FE
 for qemu-devel@nongnu.org; Thu, 09 May 2024 04:09:57 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-51f72a29f13so671865e87.3
 for <qemu-devel@nongnu.org>; Thu, 09 May 2024 01:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715242193; x=1715846993; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Wr5NiS9DDIrcdeFSoDKoKgLCkRyOmTAgib3wL4yicrs=;
 b=qS7PgHldWpwHrQZPAoqNSa7MHy/sPc7fl+ghIT7e9GBirIA3h0h4KMDMUVRO4DamoE
 NqJVVeK2wW1FS8D7mDBdh9mIHLjv2UdqiiBHTFEo7ktoKv+n6otobFadwKzzfuLys3EP
 8uokiG576hAteQZzKAJi5/mKswMJkCdD3z7eTN7u3LCqgkdkNWAxFG2oPEQLVxLKjhgN
 mIv1mfRHnykjWVpWGANnUxm2KuTttCbKoi1CfzW98s7I29TqL13nKHGmysYG010yIrdE
 3DuNSuj5ih3W0EZyyY6v1Dy5p79aAMNJ8WwUgbtf7cSigr84uRDbEaGkx33zxN66gLLJ
 UQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715242193; x=1715846993;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wr5NiS9DDIrcdeFSoDKoKgLCkRyOmTAgib3wL4yicrs=;
 b=jYpxc6IuiEiKHYSo9C80hoemuj9zIFFD8TtRxBj/exWMwcWasJwIbOyGWWgIlFcQks
 z7058vsKjLo4jXmUsq11sIcsw9o9fPYK0jXvSRwMSwFzfgyfZhqg64+zshgAUAQk6a4c
 1SGiHg13RjSmkMkf9EdF4/3jKUpXlPtEUMhH3kgi2qWph+9G7liqr0hi/MukCEKceqO2
 3rctdkh7+LElAol4tCovk2EY12z1knsPiL21ss2S3TY+hUO3BR5vEKKHtpXghTOGzrpI
 tafL5DOfLNHjcZSP2w9K6K2aX3r6wXd5JUGOa1iWrCxzSQFpcm+gZQh8HfsMhNw3Wor9
 HkiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPwBLjRaDENyFZRzE/OqkwrpHgVik/xluM2a1RAEmbqpfPHWtnz2BGWOP1yvg8wqVZjSjizNqWdAJtMyys8MlnRR/DKww=
X-Gm-Message-State: AOJu0Ywte+jxrvm3C55NpSi+raPLyR6TEMm1htYSGCwJ+hLwmasCDimn
 pM5wHCTWca0XIUr2oZybpc5EJkmUx0nA+Uk2n8CQqkGtsCDWGD1OB7PPNBoJGCk=
X-Google-Smtp-Source: AGHT+IF7Z27uN//bYPNn9W9O8me4C5R5cldEpgS7J6qeE/lHooWr9i7cH2Gsrd4iLUAr9oC52rRnrA==
X-Received: by 2002:a05:6512:3613:b0:51c:68a3:6f99 with SMTP id
 2adb3069b0e04-5217c2770acmr3179193e87.12.1715242192877; 
 Thu, 09 May 2024 01:09:52 -0700 (PDT)
Received: from [192.168.51.227] ([91.209.212.50])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-521f38d8688sm181229e87.213.2024.05.09.01.09.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 May 2024 01:09:52 -0700 (PDT)
Message-ID: <de307faa-5399-4548-9dd4-66166cdaf208@linaro.org>
Date: Thu, 9 May 2024 10:09:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/28] Misc HW patches for 2024-05-08
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240508221518.72350-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240508221518.72350-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x132.google.com
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

On 5/9/24 00:15, Philippe Mathieu-Daudé wrote:
> v2: Updated Bernhard's patches
> 
> The following changes since commit 4e66a08546a2588a4667766a1edab9caccf24ce3:
> 
>    Merge tag 'for-upstream' ofhttps://gitlab.com/bonzini/qemu  into staging (2024-05-07 09:26:30 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git  tags/hw-misc-20240508
> 
> for you to fetch changes up to 8b4d80bb53af30db5de91749216d0bb73fa93cab:
> 
>    misc: Use QEMU header path relative to include/ directory (2024-05-09 00:07:21 +0200)
> 
> ----------------------------------------------------------------
> Misc HW patches
> 
> - Few more g_memdup() replaced by safer g_memdup2() wrapper (Phil)
> - Endianness access fixed in vfio-user config space (Mattias)
> - Replace qemu_mutex_lock() -> QEMU_LOCK_GUARD in system/physmem (Phil)
> - Per-AddressSpace bounce buffering (Mattias)
> - Allow to compile x86 PC machines without Floppy Controller (Thomas)
> - Cleanups around i386 "isa-bios" memory regions (Bernhard)
> - Remove unused usb rndis_config_parameter structure (David)
> - Migrate missing clock in STM32L4x5 GPIOs (Inès)
> - Deprecate PPC 'ref405ep' machine and 405 CPUs (Cédric)
> - Memory leak fixed in Loongarch Virt machine (Song Gao)
> - hw/loongarch/ code moved around (Paolo & Bibo Mao)
> - Emulate S3 suspend in loongson3_virt machine (Jiaxun)
> - Implement IOCSR address space in Loongson IPI (Jiaxun)
> - Use QEMU header path relative to include/ directory (Phil)

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


