Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 373EDCD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 14:34:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPLWL-0003xz-Ug; Tue, 19 May 2026 10:34:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPLWF-0003ug-Vn
 for qemu-devel@nongnu.org; Tue, 19 May 2026 10:34:05 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPLWE-0004uz-3o
 for qemu-devel@nongnu.org; Tue, 19 May 2026 10:34:03 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-48a3e9862f0so21333335e9.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 07:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779201240; x=1779806040; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1sQ6/dQ7zCds7GQE54OquqnEYgzjXDwNzenXR+zYMVk=;
 b=f/Weduj3I50Q6MnplwFTNmPEX6xEUifNZx0ye17QJ5cPJ1ytLREP+ay+ueTIL66wqT
 TfS3E6CAStX4ljRXk45NM4NiK4Pg3hvi+4cWdsqrzJaL8whAJuUcBKJMuahSp4hiACQ5
 9DkAqJ7rDMvfnU3fqhL91dZUI7tqf7KJcF233vcJvNh9UOk/rhHNx/6F8VlriezQUZIF
 gV8q9dTWb+gQMtG6coecQ4aMrcZjJSb/NvsbkqRN7qnEg6bi00ip6wXmACtqmZ0SbzYV
 o8rkWDrk4d2z5VXF5Lb6ov63yRWMJkFARmuWGAouGbjK0EStgyRlLtF5edB1EoyKza7s
 uHKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779201240; x=1779806040;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1sQ6/dQ7zCds7GQE54OquqnEYgzjXDwNzenXR+zYMVk=;
 b=FpsgliePNH3G5uBkqh/0INwjMwOclu5b1s8KRxnBBQZ2WrYPv69MkUyzGzrkheFyyu
 8QGxIqXSUdSMQeWqYp5jUjbrnhVLcZfW8OPQOH1Apm5RkiofbOC3TWgGIkZNoSF1K4LS
 KxRkMNZWrtVPnuHhfrvZIq9puON2hKJrRai4ssdGXo5xnInEJRwM5OuTCTnB/cAcqSXK
 Wac8qcDlWzElXLZPFNzE5Y0FdF2xxrR5Fma7ekZcu1+Aqpb0LtSws4Tx30XdtA8NPjM9
 lyfQmFpqyGLAESW8/GE/eNKQMVZqwqg46b/YXr42L9gN3dI4Wgo4gike7esrE9n7dvjU
 /+4A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8E/BUm6qDAI9NNV8Sg6UmoLxQ2yoLlnNaX6XKlJwbFk57xLQY5orh9rSjDPXAEoO4LV5GcAS7iuLS8@nongnu.org
X-Gm-Message-State: AOJu0YxvFb10ZKh29TqXYxIcsxvncJvcEeH96Uei1QWg6WGxEMijKbQD
 FSHJne8zRWpCNW3G2kRd86SWq49HhQBOwcPn95vQF2p8DLoqN/Nzsg94ABB4uLnzejU=
X-Gm-Gg: Acq92OFnxwrpubruh3AfyzyNQ9vDeGBoO0w7m5wvOJN6+8sK9U+W8vAO2k2bDxsRaAo
 72WAst/Bv1XD8M9s44jSkxm+LaeT4NFaa6yGlFvDkTDHDVcyy3y++wnaioaH5rpzcaqkQbgrVPi
 1ok/IMWn2yBGkPzTtwF5SmTSZSiXC82Qi3tUXo73UnLrfxvCa3S9o3D0Dr22oqbpsqnl7MoKEv5
 rWOcWa9V6YYqLEID1jTBV1oB8CqRvw9wcyp7Dca3YuPtP/ZByDr1afXDn0F1Dy6X2UMhtnRTmmg
 arMTX01h2FECzFyCmzyEoDWVjpayNhSODxwRK5N1ifdlRtGTwTZ6NAccnpjjIZj6u7F2XLxuAc3
 wWfEdSFbTdcI80geYIA7RnPWYUHPMm0By2LOKpzlSvLZCYXdfh+Z0wh/rzLSh1G8ntSbkIAm/7C
 vR0H1ru3fa9NeXIfLsBRpha1gwMJbIXI0HXYGttXtDufMw98zvxWKfTdjQiCi9Ps9r9PCw9DVNW
 dtt
X-Received: by 2002:a05:600d:8450:20b0:488:7d01:f67b with SMTP id
 5b1f17b1804b1-48fd6333288mr273442115e9.6.1779201240301; 
 Tue, 19 May 2026 07:34:00 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a19b1dsm45395520f8f.17.2026.05.19.07.33.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 07:33:59 -0700 (PDT)
Message-ID: <238ed188-c8df-4cda-ba06-f0d04e6165f7@linaro.org>
Date: Tue, 19 May 2026 16:33:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Two hppa cleanup patches
Content-Language: en-US
To: Helge Deller <deller@kernel.org>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260519133329.4268-1-deller@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260519133329.4268-1-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 19/5/26 15:33, Helge Deller wrote:
> From: Helge Deller <deller@gmx.de>
> 
> Two leftover cleanup patches which I did not wanted to merge shortly before the qemu-v11 release.
> Nothing critical, and both suggested by Philippe Mathieu-Daudé.
> 
> Please review.
> 
> Helge Deller (2):
>    hw/pci-host/astro: Encode Astro version numbers
>    hw/hppa: Move static variable lasi_dev into MachineState
> 
>   hw/hppa/machine.c   | 15 ++++++++++-----
>   hw/pci-host/astro.c |  5 ++++-
>   2 files changed, 14 insertions(+), 6 deletions(-)

Thank you! Series:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

