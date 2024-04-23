Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D599EC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 13:38:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzGLg-0001RG-NR; Tue, 23 Apr 2024 09:38:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzGLT-0001Js-7t
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:38:05 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzGLR-00062i-HE
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:38:03 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-41a77836fa6so14096065e9.2
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 06:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713879479; x=1714484279; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O5zVUdW7qPDwTGPLOk1Y71XQYtKYXkpHJ4rhwRRts9A=;
 b=PMLlgoHs3gpw7Y9RvI2CJ0heb86B9cjn8mhmbYE8cjFNJozGA7NlBEsti/OxAX4q3M
 tBykUa+RZkvXRPUY6QOxvCD1Qgw+UKQIuUAcKGMFl8BAVh9uz7tM21lWST9PcD4YZiLI
 lEDSBpOqdrjPng7oR1GjKZD8Jy/MJAnpIIOaYgA98DSfZrgYlNyGM+SeOL0N/f7g7VKh
 PMGQP1Eln2eA5LusBg5szrPlKnReKBBcb5HpnO3z5PRihv3m4+I69Z4/YCW2s5B/Jl6a
 yZgxtfud5X1GK8mOc2jYG8mKiNC9GeAN4rGh+N8QnsEEGU2+r0B51i+0XrpSODaNffzl
 nPQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713879479; x=1714484279;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O5zVUdW7qPDwTGPLOk1Y71XQYtKYXkpHJ4rhwRRts9A=;
 b=dUJmVAuM8dukjeF7nc6+Mqr5O+NOR1RJYYmpx8ChFp5dIBJkiSJCd7k+I2dmbBnCmq
 jjqYfOafn53X8jwm2XveOfJM0SaC+RKrJGzona7EKHqSUojdHfSE0S1CB9+ujOxiqfnl
 NO+V5sD/7RgvmadmT/AZ/pXxPfuQPsU63xAp307dhhOOyg2kogMlzVulvmIcyN3+e/gc
 EkCIESYb2lbVsUVoNkcahBbuesdnLuYGVR7IFAQg/hHEuYcUQ/l0EnN641mmXLsn8Dl5
 8p6WnxTr/lNd6U9bWxzkgqDpup6eFkK9h058fyPnZSTARgngV0iuRLkuRkSy5/JQ0rby
 RC1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQNSiYmZ6x7h+O3rsU7AhDjIWI5goEPgPNCZ9+XOpozi7dU2dxDTPFbX0f310Csjvk/5OHoHH3jfY5CxxCnQMYtX3v/jQ=
X-Gm-Message-State: AOJu0YybcxcJyqDCisc8QIlKhtkJYKjT86piz6aUyoLr9OVUOey06oBt
 IwAqCd+TlPyUwftHzFz3rz+c7iwR4iW3Vm5LPl3whC79uPDYE5NpLA3LbaqXjT8=
X-Google-Smtp-Source: AGHT+IHUdLYLnEDI5sD4r2Cnlc0nr2lcQsyfHjQRMsHMUsmQXkUnbqb2/hSQ9d0iLR6fNkXDGDeI8g==
X-Received: by 2002:a5d:6886:0:b0:34a:48a0:fa70 with SMTP id
 h6-20020a5d6886000000b0034a48a0fa70mr11970367wru.40.1713879479553; 
 Tue, 23 Apr 2024 06:37:59 -0700 (PDT)
Received: from [192.168.175.175] ([92.88.171.241])
 by smtp.gmail.com with ESMTPSA id
 hg16-20020a05600c539000b0041aa8ad46d6sm2955023wmb.16.2024.04.23.06.37.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Apr 2024 06:37:59 -0700 (PDT)
Message-ID: <b0e903f8-1821-4b16-b848-1e0f7f3a8964@linaro.org>
Date: Tue, 23 Apr 2024 15:37:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/22] hppa: switch boards to "default y"
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: farosas@suse.de
References: <20240423131612.28362-1-pbonzini@redhat.com>
 <20240423131612.28362-7-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240423131612.28362-7-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 23/4/24 15:15, Paolo Bonzini wrote:
> Some targets use "default y" for boards to filter out those that require
> TCG.  For consistency we are switching all other targets to do the same.
> Continue with PARISC.
> 
> No changes to generated config-devices.mak file.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   configs/devices/hppa-softmmu/default.mak | 5 ++---
>   hw/hppa/Kconfig                          | 2 ++
>   2 files changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


