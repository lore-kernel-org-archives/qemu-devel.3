Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D4FC48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 11:31:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXJf9-0003zX-52; Tue, 06 Feb 2024 06:30:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXJf7-0003zI-MH
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 06:30:49 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXJf5-0008LH-W1
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 06:30:49 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40fdc63f4feso15536595e9.3
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 03:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707219046; x=1707823846; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R3jpptd8RXoHaXlN3NcepMoeKQLsWJxjKx6UUdLgNz0=;
 b=t3tu+3u42XccxcKk06WytARqU8qcfJUt/Wm1K5hUa3Er+aQiW/Fl2GP6jsvAD1bKQa
 vlMLePCvGU9Ek8zJwCfwc5h6m0NXEwUCnSEje3aed3pd2gjeO1PqOnesB1DV2WbbLtAY
 PeQTbKGDK4zprcB99uHSjCJRQQkZpH6XHAuIgYuKCoGKRiVam3Z9Vt14ww6WvQZ5JOz+
 NaffkGk5ACy3H4/gEqtPhitbBCzvu9AbDfqR0LVWrpf+XyTNU9suwy1bD/PxA0i2dpX+
 u9U61fYf0uvucrCCtfxydYyaaGwSs5ghjnfMJgWvBhCSDGftDqjoMyWlrNphuzF/myVr
 Cwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707219046; x=1707823846;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R3jpptd8RXoHaXlN3NcepMoeKQLsWJxjKx6UUdLgNz0=;
 b=qf+QysHeoBcTK5dFR0qoZF0k/uHGcW7w/OBqAUU1C4duzMmF2WLwfXa2iq5V7WIK1H
 M7G+M997JwJ/0h9gtIdbKputzb0+eGlGnYS+SWT0bw2hr0C6i7i+lglLW9ikae4Cf+8b
 K8GGesYremw8yuwzuUqe8wy5zgGPNgcRyqZMMaO7scIijsL43E/+tbdDVp6yTP8/tQdv
 RQxhNyPk3H9DJWS5n5bT/kmagFGXfwS3j3H3FhKZgmnGhbQ2RcazscrDrOqEJzOtZtBe
 Z+e6frv9XD0RDJ5cKOej8s0m8hXwSHO6fADLvFyAP8J9kw2nogSA4pXEVMILqcgDLIkm
 zhVw==
X-Gm-Message-State: AOJu0YyGJzIj1brlWXwOYEwq13LOWsbJYWdRRTj8v8N/kFHBWc0cQNcr
 luNS7WL0q4MuPFzhf+U5OQop5Zqq1V4tSQ/MfhE1asIIoC1Y8kZN4OF6Mgx3Qic=
X-Google-Smtp-Source: AGHT+IGLoWE8upMRANQd1j0lc9LDjVSBf+ay1HfzqAv0oRRqRjFK82uU8Q/l4xlyAGoloVK65Bbd6Q==
X-Received: by 2002:a05:600c:314d:b0:40f:afc8:ac6b with SMTP id
 h13-20020a05600c314d00b0040fafc8ac6bmr1847529wmo.6.1707219046259; 
 Tue, 06 Feb 2024 03:30:46 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUIckf7rRcHY8ZopdaKt4iLKhkHA6av16bVAxLc5dtAEXRN6TLiAWO0HwfUGlVmxkB6xmQx9tKsZfBAhcQPwobSgGwrHzBgRlPB+J+xQLYeSgGB28HeOJgp4zo=
Received: from [192.168.69.100] ([176.176.170.112])
 by smtp.gmail.com with ESMTPSA id
 fa13-20020a05600c518d00b0040fb03f803esm1688085wmb.24.2024.02.06.03.30.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Feb 2024 03:30:45 -0800 (PST)
Message-ID: <1c1b711a-d1d8-4d5b-ad28-e9555d848f9e@linaro.org>
Date: Tue, 6 Feb 2024 12:30:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/net/tulip: add chip status register values
To: Sven Schnelle <svens@stackframe.org>, Jason Wang <jasowang@redhat.com>
Cc: deller@gmx.de, qemu-devel@nongnu.org
References: <20240205194717.2056026-1-svens@stackframe.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240205194717.2056026-1-svens@stackframe.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 5/2/24 20:47, Sven Schnelle wrote:
> Netbsd isn't able to detect a link on the emulated tulip card. That's
> because netbsd reads the Chip Status Register of the Phy (address
> 0x14). The default phy data in the qemu tulip driver is all zero,
> which means no link is established and autonegotation isn't complete.
> 
> Therefore set the register to 0x3b40, which means:
> 
> Link is up, Autonegotation complete, Full Duplex, 100MBit/s Link
> speed.
> 
> Also clear the mask because this register is read only.
> 
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> ---
>   hw/net/tulip.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


