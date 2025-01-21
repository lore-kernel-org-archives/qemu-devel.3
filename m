Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12287C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 16:43:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taHKt-00043y-Ux; Tue, 21 Jan 2025 11:42:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taHKq-00043k-Nv
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 11:42:40 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taHKp-0002my-69
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 11:42:40 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3862ca8e0bbso4716089f8f.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 08:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737477757; x=1738082557; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nINYbWSblEDSRw30cuTTGoy0PPjVbE3S3S7rqeQhNv4=;
 b=Ua1KWY/lOYMOD92RHB26Bjx3Bm3lESYpmMD/8p8aL03XKl+bjOMl2nYDAz0cyu3a+e
 LF8ICpfns67L6lqkSV085P7KUjAZIKt0heH0aS6tmG3Tx+EuPVFjO7XWs3xcmQW0Dj7i
 fYRAdVgqIY0mS0yZW7mMILZ6cmAGcuRkVh1S6nNRJSdZ1f5BvaZdTdoTXJ2J/r7/E+SV
 TJjnuKQpf8mPEutdfCycAfFhvl3uuBwnYcXFNJRq8XR7PHSwWD/rF2mNvZAtaihDrP5J
 0Ky7crP8kgFIrYlU/I52xJto5Hqy2VELvsWiW9yR9BrIJ9huEstiW0WeCcx6zFWkLZE+
 o3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737477757; x=1738082557;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nINYbWSblEDSRw30cuTTGoy0PPjVbE3S3S7rqeQhNv4=;
 b=SJLXcNHNEa7uLde32kZaOUMnG4Yf+N1UZ4/0FarPZSFQ5ZO7nDimFv8EJlA1GF5gtt
 qviYQCw3QpfkuZ0UcIQfFNi4dhW9JkFO4VBj6O353ifpLBW7MdN+oFZNNuEXzw4XPZJT
 FpLpLlwhZgTlueFypAE4xZiZkFv0MyXIT5PC46FOOPf/8KTZFlVFndnywgB2JF0lqiR1
 dbp3M8okFI+PsLyHT99C1yh5EqV25qO5ZbDlDOWTU4TTQxuQAYn8ogItFTz4oG60EPll
 tHFog34HipwLjLwrFGf6ofgezagYOJsXeZ3pLxU2Sl65UrGNXOCL4hUkg3JQV447qTRN
 qHrw==
X-Gm-Message-State: AOJu0Yy8cjIbPu2VhpZuF/BrJXb6Cb+oznPdrCOW05eJFAJmLbHPSXSG
 c7wvKnYvWEEcNT11rEqu4rL8Xqx7ShiM8v8OAFBz+fsK/zy9nCksEFfyUSVFkl8yWGQ1zRHn4FD
 TkaU=
X-Gm-Gg: ASbGncs5x/nDttJJq0FU4HnNGGEcp6Vmp4p7j7L8ImwiHsvBsLFLvfkyTO+ojLikcGO
 ZBEe9KbDQPwuIbd1cVrGzD4ULEWywc9sqbZEB5qE5Pqt5XCukNH0OJhoIEnn+mRw2cbnMZi67fv
 7/+dp+eMERr0+bevp+x/bZEsY7BWvnR/2t2+7I5BZ8Ti4Lm1IWdqjAqxjjn62maRotfF7Up0wZM
 +Zu9vuHZuSUCtB8fe98WXNeqCdIR2QFuYXZcODtoq4UJ9kHTJBkX1lFmU4uuMKg1lr/XDLDSuFk
 FNngETZ4daZMuUiyP6XFwvSquJ0LGSizR0y7/g==
X-Google-Smtp-Source: AGHT+IFHmYQJTEiMqqpnxmzR/u5kdzHQj9D4bbNfn9gRr7yF+tZo6LPgdkXoISgmwSapj4t91U/kEQ==
X-Received: by 2002:a5d:59a3:0:b0:382:4b9a:f51f with SMTP id
 ffacd0b85a97d-38bf57bd650mr16943340f8f.47.1737477757104; 
 Tue, 21 Jan 2025 08:42:37 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf322ab36sm13669168f8f.49.2025.01.21.08.42.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 08:42:36 -0800 (PST)
Message-ID: <f26a7087-0293-4000-ba38-1822950f2b35@linaro.org>
Date: Tue, 21 Jan 2025 17:42:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] target/mips: Convert legacy qemu_allocate_irqs() to
 qemu_init_irq()
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <arikalo@gmail.com>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Bernhard Beschow <shentey@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>
References: <20250121161817.33654-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250121161817.33654-1-philmd@linaro.org>
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

On 21/1/25 17:18, Philippe Mathieu-Daudé wrote:
> IRQ cleanup in bonito64 in order to remove legacy qemu_allocate_irqs
> call in target/mips/.
> 
> Philippe Mathieu-Daudé (6):
>    hw/pci-host/bonito: Expose output IRQ as QDev GPIO
>    target/mips: Create clock *after* accelerator vCPU is realized
>    target/mips: Initialize CPU-specific timer/IRQs once in DeviceRealize
>    target/mips: Pass env to cpu_mips_clock_init()
>    target/mips: Move CPU timer from hw/mips/ to target/mips/system/
>    target/mips: Allocate CPU IRQs within CPUMIPSState

Based-on: <20250121155526.29982-2-philmd@linaro.org>
           "hw/irq: Introduce qemu_init_irqs() helper"


