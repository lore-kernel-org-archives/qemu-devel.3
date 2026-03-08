Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB40CEA8545
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 21:56:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzM6w-0006xC-5w; Sun, 08 Mar 2026 17:56:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzM6t-0006wY-21
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 17:56:27 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzM6q-0006TA-Na
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 17:56:25 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-48538c5956bso5453065e9.0
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 14:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773006983; x=1773611783; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OWG9iN3qqepCYkioMpvHKEZS+w8pRJzbAj4UZzfmZ2I=;
 b=JoAZXVdROtteGxH5T3W0pex049T95t9jZq/4ez1Cl+Efa/XzOe9v3BZESpJeM+b+hQ
 kL0RxBkodixqBeNJWmRfe+k9TP4Awy7MOU5mB0aDxQuPNb/MRyLp7KpPeegwb4UrcP9S
 LNd7ckzrQyc7g4mdpiSz3ZrzlqiuCMxqbbNWljtM0XPJYtNEWOY7tCx/ApIsoAqA+jsH
 +iGknTGIl7c13p7hZZJIJ++zg8Hrkug1yHzLAGKGF806F8yvrBRO749TkYLEvawIYeLY
 8gjwFJoTCcY/ZEE2HWFN2EIZnkGPterJD9FKRVgDsqGERTwX5n+FTvBdIEPHDjzvGSoN
 cBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773006983; x=1773611783;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OWG9iN3qqepCYkioMpvHKEZS+w8pRJzbAj4UZzfmZ2I=;
 b=vMt9EcatEYQBT+08JKxKmHHa5yqRUUak476rzoWIrlraUyIR3DP27Sm//feVPKrQax
 qxpJT72ZisaB6geAtBjoLwf55jH+vs3LwhAZq+WrrbMyinNvZY4uZhV7n0w+YP6my0Km
 eGDZETf8XtsWaCvimdnr6XjonBLoEifOl58Leplu5dXdcxjebFxd25Z6n4bv1IxU6aYf
 KJAznIEHvmpPnhOhQsLUc844/ddVJFrhYiLn453vlcjJuvBMFLzaw/unMpLRJFooiG7i
 tHZ0Szavje2RvJWJeOCAzDe3yD9AARoS53aOMIfo7HydVosEHe5sPsgzFgYGrIbc2gXd
 Y+UA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvE2pLI8bD2dlbLc/4Fw4EMF4MwBK2Ex8GZUekxx9AvRcaJP2ZfkrYlHdu9vDMaM66GQsZ6kqa2wFs@nongnu.org
X-Gm-Message-State: AOJu0YyBnG53X0OLdiNuaSQAHNhEjle1bYWFhiZsCpMo9ojVVOuYlYCi
 FJzIm7bnsXUPFiGFZFxQk41qNAhhst5CcDbwKzwIzmm3q2x9URi17VFTF46oFM3D6tU=
X-Gm-Gg: ATEYQzzqsjLZlLSO6FQ16LbgvKr9k63vwQZ8LqgVH09EUsdWoS7jWQs12ZiyuunTHOB
 BTb76MZbVFLnBXptirpgc7WV8kVEsWhp5ZXQ+u5pLwp1lezBSlY6JvN7LQk6VBDr78mdLoG5lxU
 f6bcrD09FRJV+4QojuF2CMoGhWlPiWYH10EMxjhYWRYzmc4eG89Ny+VwMHZNlCm9/QlolFojt/a
 v4ACmOejMGW9rASAXaQGKjMo+ExF+1VMr3i2w2GEuTdnTtp7DG2ggFC0kJfuyia4ikejxDSSPqz
 pNavbKdiRRi1hfa4v8ws8HjFDL8VllTiOTHti4V8LL9EveWk5Azlbv58NKYM+rERLMRLRdGt4g/
 xa5RkGebn46JooltHXXKUnIcnSjTi7ocXdIJTB2IBbsOVf+U7G8oyCaO+tw2hXaTmgmUsIjPie7
 CHf5WxKNJxGNb0PasVjfdIu24qb9eSjR0ZMRdau/Ars43CpHRz1+4hJ+WWVJ8t4xxzHQ==
X-Received: by 2002:a05:600c:8b2b:b0:477:9890:9ab8 with SMTP id
 5b1f17b1804b1-48526715213mr135556955e9.3.1773006983202; 
 Sun, 08 Mar 2026 14:56:23 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dad8d840sm23611168f8f.8.2026.03.08.14.56.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Mar 2026 14:56:22 -0700 (PDT)
Message-ID: <81e7b6c1-bedc-4762-8051-f67c54a3ffab@linaro.org>
Date: Sun, 8 Mar 2026 22:56:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/14] TYPE_SERIAL cleanup
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, Troy Lee
 <leetroy@gmail.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Steven Lee <steven_lee@aspeedtech.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, qemu-arm@nongnu.org, Helge Deller <deller@gmx.de>
References: <20260305220911.131508-1-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260305220911.131508-1-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 5/3/26 23:08, Bernhard Beschow wrote:
> This series consists of cosmetic changes around TYPE_SERIAL. The biggest change
> is having it derive from TYPE_SYS_BUS_DEVICE which 1) eliminates usage of
> qemu_{un,}register_reset() and 2) stops all its users from accessing private
> data. The latter allows TYPE_SERIAL to be ported to Rust in the (near) future.


> Bernhard Beschow (14):
>    hw/arm/Kconfig: Fix serial selection for NPCM8XX
>    hw/char/{diva-gsp,serial-pci-multi}: Fix deinitialization order
>    hw/arm/aspeed_ast27x0-{ssp, tsp}: Do not access SerialMM internals
>      directly
>    util/fifo8: Make all read-only methods const-correct
>    hw/char/serial: Remove explicit cast from void pointer
>    hw/char/serial: Prefer fifo8 methods over open-coding
>    hw/char/serial: Reuse fifo8_num_used()
>    hw/char/serial: Remove unhelpful comment
>    hw/char/serial: Add constants for Line Control Register
>    hw/char/serial: Remove redundant reset
>    hw/char/serial: Avoid implicit conversion when tracing

Queueing 1-11, thanks!

>    hw/char/serial: Keep MemoryRegionOps private
>    hw/char/serial: Inherit from SysBusDevice
>    hw/char/serial: Plug into reset framework


