Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83019C25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 07:48:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4FYj-0006nV-Qy; Tue, 07 May 2024 03:48:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4FYi-0006i9-16
 for qemu-devel@nongnu.org; Tue, 07 May 2024 03:48:20 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4FYg-0003r1-1e
 for qemu-devel@nongnu.org; Tue, 07 May 2024 03:48:19 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-41bab13ca80so21048175e9.0
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 00:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715068096; x=1715672896; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gAhwrHFupaSGY/KnapqnTNSwCVVPA+70CZkhHE4Ga2I=;
 b=s1b2FWEK8OJd7GkYksRHB/Dhz8+NQISC5KC1fzsxUClV5ggThOxUu7jWZXVL8hzTMl
 R1L6MqPc+SbVmy3V7JCx7Nf3mL3U9J+Le04zrZbOx3keeVCpVPh8UR4BFz4oUDz1j354
 /AvaZUK0tRghnUqZ+odqvjsp2OCKdPiSeZ+l4PMxUfBGGdSRUgni/pCULKpBMPNDsBiM
 cukfn7RtGRPhHFe2V23phmEJLX04DtFTrJzJM89mTRJQ0U4weak0/5LsH5ujm0Fr28Cq
 6uzTuSWtS6pgMk7DhSGM6IaROK4fO4yNGRiOh//jGLtc6FiBuAjUy8NUIlPr1DqHeSmy
 ZFZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715068096; x=1715672896;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gAhwrHFupaSGY/KnapqnTNSwCVVPA+70CZkhHE4Ga2I=;
 b=fA5ijOlfjP1dbeS01iBEZk58XQGt7nnbGsfWkcnwSlEvWcLvyowXV1peyzFVyqTRoT
 p1dWrhZi9ABStxogcmT/Cw+jQlhruIwxq+uL9J0ofgAKwFsmS+zxev3RaZov50BW8UW9
 SiOETpPrl0uYgeLZlEue9i487TmHwrtbZE/4BKqzCwnzanJv/nDh1/+M6GIRKKSCDhfX
 J4AyTKAg57ZRP5EfLKOGjdtm2iw2F8r6YHtKp5XuqH5lkmThZ9HQxhMLViJeE4iyExLH
 2CrvFk+vo6Vmfnoa4Jz5H6LgjANCxa0F//cMBCWXp/kcZLPIKeRhn3c5VmPldXdJ8qMn
 XZOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVc9CZGwMfKQMJ1XS4Smi+tlkTWd0EzXxYzhRjvsCFWhxHSJpNzGrbh8b2Y+ANOAhUnSPeQtpkAtJ91yD+NKXhshWgeCao=
X-Gm-Message-State: AOJu0YweJ39LOT8J9uy6DlhkRE/kxXkK9VpsOhGM9dwR9F1KXzZjl5d3
 250C+PnLM4VKq+cX/J/jqu+CnACIlVD9HP4M/+yH/psIBtIoThL041EkBu88CQvwlU8cZFdlXSF
 u
X-Google-Smtp-Source: AGHT+IEYBCk+uKbv1rAPFtS+bMF62/HiXP20XXyVolEVMMz/0K65kDQ5+IJ82ag9uex4V9dJVZ3GWw==
X-Received: by 2002:a05:600c:3596:b0:41a:f76f:3362 with SMTP id
 p22-20020a05600c359600b0041af76f3362mr9430757wmq.21.1715068096415; 
 Tue, 07 May 2024 00:48:16 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.243])
 by smtp.gmail.com with ESMTPSA id
 k7-20020a5d6287000000b0034f3f756293sm3659759wru.6.2024.05.07.00.48.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 00:48:15 -0700 (PDT)
Message-ID: <db5af536-718b-48d8-9f82-57dc0ff9e74d@linaro.org>
Date: Tue, 7 May 2024 09:48:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] kconfig: express dependency of individual boards on
 libfdt
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240507071948.105022-1-pbonzini@redhat.com>
 <20240507071948.105022-3-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240507071948.105022-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 7/5/24 09:19, Paolo Bonzini wrote:
> Now that boards are enabled by default and the "CONFIG_FOO=y"
> entries are gone from configs/devices/, there cannot be any more
> a conflicts between the default contents of configs/devices/
> and a failed "depends on" clause.
> 
> With this change, each individual board or target can express
> whether it needs FDT.  It can also include it in the
> build via "select DEVICE_TREE", instead of having each hw/*/meson.build
> file do it by hand, and this will bring in more components
> such as CONFIG_GUEST_LOADER.
> 
> This allows building non-microvm x86 emulators without having
> libfdt available.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   meson.build               |  1 +
>   Kconfig.host              |  3 +++
>   hw/arm/Kconfig            |  5 +++++
>   hw/arm/meson.build        |  2 +-
>   hw/core/Kconfig           |  9 ++++++++-
>   hw/core/meson.build       |  2 +-
>   hw/i386/Kconfig           |  3 ++-
>   hw/loongarch/Kconfig      |  3 ++-
>   hw/loongarch/meson.build  |  2 +-
>   hw/mips/Kconfig           |  1 +
>   hw/mips/meson.build       |  2 +-
>   hw/openrisc/Kconfig       |  2 ++
>   hw/openrisc/meson.build   |  4 ++--
>   hw/ppc/Kconfig            | 15 ++++++++-------
>   hw/ppc/meson.build        |  4 +---
>   hw/riscv/Kconfig          |  4 ++++
>   hw/riscv/meson.build      |  2 +-
>   hw/rx/Kconfig             |  3 ++-
>   hw/xtensa/Kconfig         |  1 +
>   system/meson.build        |  2 +-
>   target/arm/Kconfig        |  2 ++
>   target/microblaze/Kconfig |  1 +
>   target/openrisc/Kconfig   |  1 +
>   target/riscv/Kconfig      |  2 ++
>   24 files changed, 54 insertions(+), 22 deletions(-)


> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
> index 6808135c1f7..aefde0c69a3 100644
> --- a/hw/arm/meson.build
> +++ b/hw/arm/meson.build
> @@ -1,5 +1,5 @@
>   arm_ss = ss.source_set()
> -arm_ss.add(files('boot.c'), fdt)
> +arm_ss.add(files('boot.c'))

Don't we need to add fdt includes path to CPPFLAGS?

