Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCBFDC83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 14:03:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZrqi-0002mN-1a; Thu, 10 Jul 2025 10:02:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZrkw-0005W8-SS
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 09:56:14 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZrko-0001OV-Hv
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 09:56:10 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a6f2c6715fso1043277f8f.1
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 06:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752155760; x=1752760560; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9ClVCl3vZb7LR0LoO1FkTT9NDw1qhfn1wNaD88rCQgc=;
 b=f2gYf58m+ZQF7mRMlAHteOK5wFbkDym9JColv3HFwvDpVC8gjBmCC39GiCpWA9TpQq
 OSK4vzOY/k+06zkzOpZ/2HU4z0LEzwd1uwEkmm93TVvZ7jlPSI2TSrIsDz2yXJhlAbQi
 ahHV8xJ7QBh6lD2lMLx7oW/tYByLkorn2eNPb2s6iW0j8Kjt9GsPbFngMINUBwexPBvT
 ZP39FXfI5/OwFxb1+qpMJNV04xrijwxmRQLOB2Cte9nNG0f6bdVVEjp6YR1ZwEsp6GRr
 4lJU5HDGWH8Xu93rgxXQ+/cIrN/h+cW+ufmvQ9nTDui+tZ9QPpOBeG28XpcI8yVGzgqR
 plUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752155760; x=1752760560;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9ClVCl3vZb7LR0LoO1FkTT9NDw1qhfn1wNaD88rCQgc=;
 b=sYJutHsJOwJulHWskOPKxfIg+P8ImXcHjaUx26ANsSUypREC3o2KFKaOwK64jjrenq
 QDjOibXu3dEanOLZ/mexvWo1RLUUGXNyAx/0L72y4eaQn+GXzq6ZIaiR2KkiHErEJx8k
 8DkPc8IOnVju0rDFnrtOxLlSIaaBaht0xm/QcN2trUaO8ajLOJtf32xXy8huvT+iLOK1
 ecWMNWUQSynd5X1ivkfvvUW0JBjdhUYPhHM/jlb384aV46ydxssENyfeszBoMkkhThJH
 uuy7O54fPXoz5eM92Z2vayo02CdguepnsOGAlOXIU69GQxcVaeLCMCZph+TYc95mWi7A
 YOgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZDQSROYMx5lFZas2wOBjbUe2B2XQKP+1Tqt+JBauwm3ddAoqMPylGV+kvJnJW9eRJ+0/KAceAPEhv@nongnu.org
X-Gm-Message-State: AOJu0Yx1R07IpWHK0S5y4paRHB52qYkX22i4Jgkr0tvx7gERt5eE0K0M
 3sDDC7+Xb0iaXFC3Zk1jIix0vsk34D7ZjShuAe2lbWT/X/k/tLN7hbUrn8La/h976Gg=
X-Gm-Gg: ASbGncsIzm6Sj8fMCYSGqLWksylXtxJ5fMnE/QQ3AM4LWwbfDM44M7MFZ1ON5A16YM6
 dMwY9dx8YTCd89TmOPu2k8xf9jczhHaSKxPMc8RRHV5HDRSQNqrP2+Or0ZeoWphUsQP+aACMPnd
 10fiAeqhHQztDmYv4Z6wv+iiTKBe0ncEZ1AFxxxeD/c26W6LQGVfQ8EzJoy8Cr0nMELVlwmCVQX
 riaDwwzj1VitEoAVMJnn49/70+54F7tuhc1LSfuiVukJ3DQ4CTitjW9gmLnVANNPAnVGVWisPzG
 W6TWa/vfjdpNVgo9ws557abTTiCe3IaADh6I1TYG2tc7PJrGdWZXZrOg+GPGFmvx5VdNOup8aib
 E9wW8NOdNTAJDNeJs31XjUEvge/gcHIRuCvDSuI4W/H9pMh0i
X-Google-Smtp-Source: AGHT+IGSf/cHljGcoezSnhL7SttKHgunq0LO7bZQXfIGxcOUoYzI9ODz3AX7/NGBCLmAhcS7CC/9XA==
X-Received: by 2002:a05:6000:490f:b0:3a3:4baa:3f3d with SMTP id
 ffacd0b85a97d-3b5e866974dmr2506257f8f.6.1752155760068; 
 Thu, 10 Jul 2025 06:56:00 -0700 (PDT)
Received: from [192.168.1.117] (lfbn-mon-1-970-120.w86-227.abo.wanadoo.fr.
 [86.227.5.120]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d50fb874sm60434555e9.28.2025.07.10.06.55.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jul 2025 06:55:59 -0700 (PDT)
Message-ID: <25f66336-ce6b-4eb7-8e98-a9838c8785e5@linaro.org>
Date: Thu, 10 Jul 2025 15:55:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-headers: Remove the 32-bit arm headers
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20250710120035.169376-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250710120035.169376-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 10/7/25 14:00, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> KVM support for 32-bit arm has been dropped a while ago, so we don't
> need these headers in QEMU anymore.
> 
> Fixes: 82bf7ae84ce ("target/arm: Remove KVM support for 32-bit Arm hosts")
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   configure                             |   1 -
>   linux-headers/asm-arm/bitsperlong.h   |   1 -
>   linux-headers/asm-arm/kvm.h           | 312 --------------------
>   linux-headers/asm-arm/mman.h          |   4 -
>   linux-headers/asm-arm/unistd-common.h | 397 --------------------------
>   linux-headers/asm-arm/unistd-eabi.h   |   5 -
>   linux-headers/asm-arm/unistd-oabi.h   |  17 --
>   linux-headers/asm-arm/unistd.h        |  41 ---
>   scripts/update-linux-headers.sh       |   5 -
>   9 files changed, 783 deletions(-)
>   delete mode 100644 linux-headers/asm-arm/bitsperlong.h
>   delete mode 100644 linux-headers/asm-arm/kvm.h
>   delete mode 100644 linux-headers/asm-arm/mman.h
>   delete mode 100644 linux-headers/asm-arm/unistd-common.h
>   delete mode 100644 linux-headers/asm-arm/unistd-eabi.h
>   delete mode 100644 linux-headers/asm-arm/unistd-oabi.h
>   delete mode 100644 linux-headers/asm-arm/unistd.h

Nice.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


