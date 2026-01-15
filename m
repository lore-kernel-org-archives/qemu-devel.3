Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 369EFD4661B
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 19:48:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgTKF-0002KD-Ni; Thu, 15 Jan 2026 14:48:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vgTK7-0002J9-KO
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 14:48:05 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vgTK5-0008RH-I6
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 14:48:03 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-480142406b3so5972535e9.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 11:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768506480; x=1769111280; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ug1YcFGOinbtgTHpfnbojUD33mGP8SL3zLP1Ja1h7sM=;
 b=xVtnIliIXWPNWcsxZAA800r/8VZtUtq0hGc+Of4grGDiPcaKeZ+jaP27LMj20OqwQ1
 Rchf0NCgR+bqy9xPM/z6rrlBABHa2+e+N/ZIP/cWa4PEed7H4ucqOb0LRJLUP2UTcka3
 ARI4odRiQ2dMC/S96wMGcZSf2fOew7mhIo7Rc0oHHbSFi/xxziAs9/Bhas0mxJVgBPlD
 Nk//nETB5HDNviBDhhzyJ4ChV+EFlTKds4ubt8Xu22ajT5ObyCVkJqbVEopJoRIzyGKq
 Pe1hbdCpDW0yauW8HfeYgkzsGBvgWoDVNLLCUiAMriSH9RTfHPicVNe3YxO0Iq16hhZD
 b4bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768506480; x=1769111280;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ug1YcFGOinbtgTHpfnbojUD33mGP8SL3zLP1Ja1h7sM=;
 b=DT2oRDUeT2VAwTm0Na6v8xE5F5YCQrv5iAB0PJDAXkI1ngJViNxqOYkO8j5vP+3Lw1
 UOR3a8y2tlUl4RBzbJ7+XCXwA+22u87Yg+0DJ5q6cRU+JcLxCv9KjSJ6HfxYKatwUDWx
 +Ue7Uby1BTqo0vkpoTXSDsv+ZRwm4roULZBXYB0QDjxHZcfD/msh1rtulFd16lkrA0M0
 47+zijbfSfV6TDKazJFw5VZyuJozLP7dSv876OWFaFD2hRd0njUl2QsFTkF1BPGaA4g2
 d9EI9UoyXkdf6ft4ket0OZKPR5dfZ5IlCqf0z1hYSDnzPq4cPwgFJteAY6DP96Fxy/3l
 q5Hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmpVyM7fl/8QA4Byrsw3fVP5OmAiEqYQ1u0ubT1xhd4rBfkefePLijWV+Xxw7KWm0k/gmHOhVv2YrB@nongnu.org
X-Gm-Message-State: AOJu0YyLs3Q6GfYoezoMYXVw+18FM/nRFXsdJ8CmQkKkCLBjcixSjxK+
 wGvagRZCYuf+/CygXmsLNBvAehswTlJSkTLNOivcbsJf24w9jv+2BsoxG/2lMZUEekk=
X-Gm-Gg: AY/fxX4nJx0DSFPmyBgjtCFiJZV7rthiCE4aaoFshjkEiirddxMOkVJHAFPRtwEzj7m
 VFj2zuglhC4kH970lAEardMRkZnZJ/m3yoPh1cEwExBStYbhPYQ0isy8+o7IeuBUyt/bobcZJ9o
 4BKYJzfFExRcanh2sXUD4YUvsYtHFc5Dxn8nGFQstvPNOvaNJnGUxU8cw/97FsjkJ7DCunGPQaE
 5AHLYzqUkv82ZvSCOo6PrFW8sIjJGmbcESvE8YTqJD32X2vfnVKoL+L2JSe1hamSyP/j9OR02ep
 9BjILPcsXjFDVbFZA7irMQ8copqumPBK4e8qfFuMNnv8mJxU1kzQMxSTaguX2uKn32Aaxzx6W2g
 LOhJIz3i65+7iRP61RzjaftH511rwwKBShGScQdQefILDz1RfJ6clFhH5yrCv/croRWsyxji/5s
 fRwtOks6dOZe4vj3Jaimpl9rJkeJrdOXX5hpEdtuC1HFs1JQu6HDZ7fQ==
X-Received: by 2002:a05:600c:4513:b0:477:9cdb:e337 with SMTP id
 5b1f17b1804b1-4801e2fc2e3mr12628575e9.7.1768506479413; 
 Thu, 15 Jan 2026 11:47:59 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f4b2672d6sm63511675e9.14.2026.01.15.11.47.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 11:47:58 -0800 (PST)
Message-ID: <5e72f6d4-6914-4797-85f6-6131af0d1349@linaro.org>
Date: Thu, 15 Jan 2026 20:47:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/1] hw/i2c/aspeed: Introduce 'bus-label' to customize
 bus naming
Content-Language: en-US
To: Kane Chen <kane_chen@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Cc: troy_lee@aspeedtech.com
References: <20260112083054.4151945-1-kane_chen@aspeedtech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260112083054.4151945-1-kane_chen@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Hi,

Cc'ing Markus.

On 12/1/26 09:30, Kane Chen via qemu development wrote:
> From: Kane-Chen-AS <kane_chen@aspeedtech.com>
> 
> Currently, the Aspeed I2C controller uses a static naming convention
> for its buses (e.g., "aspeed.i2c.bus.0"). This approach leads to
> object name conflicts in machine models that incorporate multiple I2C
> controllers, such as an Aspeed SoC paired with an external IO expander
> or a co-processor like the AST1700.
> 

Is this a side-effect of Problem 4: 'The /machine/unattached/ orphanage'
described here?
https://lore.kernel.org/qemu-devel/87o7d1i7ky.fsf@pond.sub.org/

This problem isn't specific to I2C nor Aspeed.

> This patch series introduces a 'bus-label' property to the Aspeed I2C
> controller. By setting this property, higher-level platform code
> (e.g., the SoC realize function) can provide a unique prefix for the
> I2C buses.
> 
> Changes in v1:
> 
> Added bus-label property to AspeedI2CState.
> Added bus-name property to AspeedI2CBus.
> Modified aspeed_i2c_realize to generate bus names based on the label.
> Updated aspeed_i2c_bus_realize to use the customized name for bus
> initialization and memory region naming.
> 
> Example usage: If a controller's bus-label is set to "ioexp0", its buses
> will be named "ioexp0.0", "ioexp0.1", etc., instead of the default
> "aspeed.i2c.bus.0".
> 
> Any feedback or suggestions are appreciated.
> 
> Best Regards,
> Kane
> 
> Kane-Chen-AS (1):
>    hw/i2c/aspeed: Introduce 'bus-label' to customize bus naming
> 
>   include/hw/i2c/aspeed_i2c.h |  2 ++
>   hw/i2c/aspeed_i2c.c         | 27 +++++++++++++++++++++------
>   2 files changed, 23 insertions(+), 6 deletions(-)
> 


