Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F42FCD5BA6
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 06:37:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPx1z-000782-SG; Thu, 21 May 2026 02:37:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPx1x-00076q-BF
 for qemu-devel@nongnu.org; Thu, 21 May 2026 02:37:17 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPx1v-0004dW-Sj
 for qemu-devel@nongnu.org; Thu, 21 May 2026 02:37:17 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5a8f9841616so4787342e87.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 23:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779345434; x=1779950234; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=711XTc+nYu882xY9Nq/q9sOvZjr17jp2oAtXi70W0VM=;
 b=hhR1cElWrpJc6uktSaRHRXf721Twl4N7T/ayFgwl5Uvu6gqowwtzSbc70Cdk3vPGqY
 nVRelwgQc/p9tQCPe+xD8FeEc1P6TdoU3yNG/bhGQqJ7TCKnjPmTWlIRl9AxtCLMJrpF
 dK0Va6X6rQu0Oq1G2qdR4wRoZRFgOXuKo6Qv87kq8vrB94Yh+90AuoSvX9q0hVfT9H3G
 MIKwrzpRVLrVfciWvUSkuIN6ropfCGUWlZgJ7IMjDxJvyupzGGKe8CItmLPFsmH8AStp
 UERJxuJJNbHszIQKy9X1uzbguL2z+QIFrJmVQwjJF9g0Poc1Su+Q/BzrgB1MFdsqgwfu
 cfZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779345434; x=1779950234;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=711XTc+nYu882xY9Nq/q9sOvZjr17jp2oAtXi70W0VM=;
 b=suoBWalvEPyEjxsX9jmiANkcxwdBiHR2iNbXnsloPOM4tLsfmwGJ7mQaV8e2AOTeiL
 eosYZvBO4hDP/LxVnLZ3H1KRNke7btNbdti7PtIjrvK8DkW8j+9Kdj6luqWUk+BrN6ai
 /mbMaHq5yCRlpkMqmU0lFYkIgWWoNtuOV043ihZC/k0fzZGiINvNtM0btAzCcQUWyyeE
 RobYcwnG3qx1QPrttY4v3z3y6blLDeIdeO+ISv1/PkQ3/dQS+4ITITooe9W7O7EIQZtZ
 jXKr3ieEiOEz6RfoHDH1VpDYTHwWT30BmMnY2nCLyEftOdisSwg7N3lai4+bsZqv5id1
 Sesw==
X-Gm-Message-State: AOJu0Yy0lI3bpe0PztKVBNAC9pKVZKOk9abfHw2kqyzIjxwl+YTPJHqG
 jX7t3dPm/Yy7EyP+v6ZQMghwZTlLSL157SFDPOI9hg1ipEhSXvsmDrbjwfgxVue882b184o8gya
 jSB9j7gs=
X-Gm-Gg: Acq92OHLlNp3WoaLoBbFxAucb0L+x1W+/9BxUMOqKDq8xgRXklBgsbN7+AJ4FraBW5/
 AkpHpzAdA4Ly0slvfmwigI7ihLndgjwrO4UoYYVvTGfTdPlwWbKbAyd9/JQ4aekn+Ym27bS6e/J
 sLC7GsSS3RRScX2oXVipZWOsytX3f3wdk5IZM2iu5rkFSI0rZlnM6P3DT1iziUEM19I2g/7P4E/
 q5zgZdM2+ah2isAClrly5KmeJFvrpkigqG+6p79ffrVTinMa+n9H6YRXqUe7S6nh1PvAH6A7uQ/
 GvkOcWJOwOHgfwjDEze2IsfcDbUQhq20UX14mQTMGpwSiNe3y7NP0XFUmYMTXLckpKx/heZW2NC
 zhzHPN2zUWD7Rvz41i0fkEE0JGoaPzbaLaMHybjDFemMtQBKeKx1/mahumc9T3AFS+6r+JmQTnM
 9nve+RPwoVx2u3aBxWpkZ4dguv8frH0gWUlMsaHuG0PQuvyctm9rcTU58Ks8T4Iuj6m25LtHJEI
 zU3
X-Received: by 2002:a05:600c:1f8d:b0:488:936a:6220 with SMTP id
 5b1f17b1804b1-4903607cc18mr17057915e9.21.1779344831290; 
 Wed, 20 May 2026 23:27:11 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4903c995f13sm2520205e9.3.2026.05.20.23.27.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 23:27:10 -0700 (PDT)
Message-ID: <88d5e3d0-8c77-4e17-b51e-65737771696e@linaro.org>
Date: Thu, 21 May 2026 08:27:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/18] single-binary: Make hw/arm/ common
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20260519144553.91483-1-philmd@linaro.org>
In-Reply-To: <20260519144553.91483-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
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

On 19/5/26 16:45, Philippe Mathieu-Daudé wrote:
> Series fully reviewed.


> Matthew Penney (1):
>    tests/qtest: fix discarded const qualifier warning

The first patch is now committed as e68da5b7a2cd8f46; hopefully
this series still applies correctly, otherwise I can respin.

> Philippe Mathieu-Daudé (17):
>    hw/arm/raspi: Initialize 64-bit CPU types during DeviceRealize()
>    hw/arm/raspi: Build objects once
>    hw/arm/aspeed: Do not realize 64-bit CPU types under QTest
>    hw/arm/aspeed: Build objects once
>    hw/arm/meson: Remove now unused arm_ss[] source set
>    target/arm: Introduce common system/user meson source set
>    target/arm: Build gdbstub64.o as common object
>    target/arm: Build cpu64.o as common object
>    target/arm: Extract common code related to 'max' CPU
>    target/arm: Use make_ccsidr(LEGACY) in 32 bit 'max' CPU type
>    target/arm: Implement DBGDEVID* registers in max AArch32 CPU
>    target/arm: Only set %kvm_target when KVM is enabled
>    target/arm: Factor aarch64_aa32_a57_init() out
>    target/arm: Re-use common aarch64_aa32_a57_init() helper
>    target/arm: Define 'max' CPU type in cpu-max.c
>    target/arm: Build cpu32-system.o as common object
>    target/arm: Build cpu-max.c once


