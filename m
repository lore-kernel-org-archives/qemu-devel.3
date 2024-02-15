Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 559E1C48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 09:03:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raXe3-000525-DV; Thu, 15 Feb 2024 04:03:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raXe0-00051l-VK
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 04:03:01 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raXdz-0006ld-Fq
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 04:03:00 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4121a8635a2so2179225e9.3
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 01:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707987777; x=1708592577; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CgNb4meP4A3HxHTJnqVqTpNPDtzOozQLKTUK6J4AeZ8=;
 b=jE63wf8iBBuis7hwoWn7mTUFqUPiotbVB8/omr+BF3o5hQiBBIkuBrWw3r6fC70td6
 zsKPnZIp6w0G2sS5CKgj3sz4LDXIZQrZ9qxFqy3aMwliiDgr5cdF5ByzYkzqmlpIA/6S
 R3fGWeNr5DYS1HU1bPzt2nhNPQciqjOsDoJA9kddHcLuVmFrLusUDBe002eDiTZVNI7W
 vFAVgQpW+NNhYlOalJq3SKFt2WqZPgUFszAe8RVmkP7/LhXajDVGxieD5XXebjiVe99r
 meKxca7eApd+Qe+QzY+eJUAMAA3hQ1LpCOtv2foPIoPJ0JmjrNANE3BIK2jmVG/ja+38
 24Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707987777; x=1708592577;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CgNb4meP4A3HxHTJnqVqTpNPDtzOozQLKTUK6J4AeZ8=;
 b=jg3bbuWLfDvN03mcufks5gjRRSlnehFg4E8SDcVxAsa919xmhAOowa7nFSo+0SfOLx
 dOQHs/Sh+VcefM67w2czC4U0QSMKr9c1VGzHypuusXdNXx66Q/+zPTitl4YDp/8CK1S/
 aVhXb7jQPu7lok4YaGcPsH5rf0OW1CBwjEdYyfsVp9rqP6jiMj/TbpBxuN5SOIILKrSt
 2bdvGyV4Bcu8ZsEqhGqH0BCjtU8dXORPkxrJqscqRr8z9AXzmoTXZtE540tNJ8S2krua
 ayh9rSoFNAF7JhnBW1VI0wtcbfOEWrrBkAsXG3fvr7XOGsoRk3uqS8dw32wF0PGrvGsp
 a73Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCRU64nTX9CnbejzdqBrxW5tVJ/ob3oaupsI3B51VZoX0h9MUuuTACn8RucKm0/9uF/EcGm+aEzlCP78Td53BCGHfn2/0=
X-Gm-Message-State: AOJu0YwDZezRMep2KboGZN/u1FooyoEK6MjvuQVnRaCT6MEP1FGa2Jm3
 urbwF3wzVCRe8mm5ra7FvIzouwZjdkPyUy8jjYm3XDwi06UqupQXf9BEDruap9U=
X-Google-Smtp-Source: AGHT+IEmWEpNUSMazlXkC16KtlrDdpfr/+LjSiTJMACRUv80A61tU31Wgy7Fgtvytkayzr5Tovh6GQ==
X-Received: by 2002:a05:600c:3b8e:b0:411:c724:bc66 with SMTP id
 n14-20020a05600c3b8e00b00411c724bc66mr874282wms.3.1707987777632; 
 Thu, 15 Feb 2024 01:02:57 -0800 (PST)
Received: from [192.168.124.175] (14.red-88-28-17.dynamicip.rima-tde.net.
 [88.28.17.14]) by smtp.gmail.com with ESMTPSA id
 n2-20020a05600c3b8200b00410c449f25asm4691797wms.6.2024.02.15.01.02.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Feb 2024 01:02:57 -0800 (PST)
Message-ID: <81348d06-49f0-4102-983e-d6cf80e876a1@linaro.org>
Date: Thu, 15 Feb 2024 10:02:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] sparc/leon3: Add support for -smp
Content-Language: en-US
To: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>, qemu-devel@nongnu.org
Cc: Frederic Konrad <konrad.frederic@yahoo.fr>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20240131085047.18458-1-chigot@adacore.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240131085047.18458-1-chigot@adacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Hi Clément,

On 31/1/24 09:50, Clément Chigot wrote:

> This series allows leon3 emulations to record up 4 CPUs.

> Clément Chigot (9):
>    sparc/grlib: split out the headers for each peripherals
>    intc/grlib_irqmp: add ncpus property
>    intc/grlib_irqmp: implements the multiprocessor status register
>    intc/grlib_irqmp: implements multicore irq
>    target/sparc: implement asr17 feature for smp
>    leon3: remove SP initialization
>    leon3: implement multiprocessor
>    leon3: check cpu_id in the tiny bootloader
>    MAINTAINERS: replace Fabien by myself as Leon3 maintainer
What is your base commit to apply this series?

