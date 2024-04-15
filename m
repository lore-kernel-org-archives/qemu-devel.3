Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4898C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 14:48:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwNc8-000741-E2; Mon, 15 Apr 2024 10:47:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwNc5-00073Y-Ll
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 10:47:19 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwNc3-00018E-4M
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 10:47:17 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-343f62d8124so2826809f8f.2
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 07:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713192433; x=1713797233; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z2DzZxJ/KOgagmr8P8Cs3+qyAvqhJlFjKrTrXZYEl14=;
 b=Peei211ivEEE8GqCx6ShSYRFhOY5cEo24PyQmRaL19mv3e0P7ZppzCJkYDC21GzcA6
 4LDML/e9q7Otg3yMZvCbFMad4TZ2elE4eFLBnkoKRoEMvpFtbtFuc1TAR1hqeVgEg2pi
 3zzS4NIBjCTT8gvzHTzM7vg4gjklGE8AgWmb9NeRfe7qwHcHaXNERkJKK65HHl3Vm7jO
 XpmKWNc4lGJC2s9Ua65KNtUiGJnV5ncogwJFDo5KWRZTVbRVEwWG0y/5h+ZHwSgGaIsa
 VYP/clFf3lggcVzGkgSWgQAKzyd7/MVRl8yOWHrZP6cc9V/2CiW+/mZS3PfMNgkWpqC9
 nCbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713192433; x=1713797233;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z2DzZxJ/KOgagmr8P8Cs3+qyAvqhJlFjKrTrXZYEl14=;
 b=RrW2Fa+NIW6305HJxvWcyJn8jdLZO68F0QZlL5f68FkZygcwUki4AzF7rukeioEshE
 UWcnCicKcUhbNTI6WV2zFOyzhztfwOFzyYedizGJbKRKsQtTBdXxmEVwO3SZ8kGCvxcj
 /FPsQF5RAa52w0n+s10+GuTTk8/8RCN4J3Juex77pZMHn5/rKC6rdtxyoJqXrsPc3UFm
 devkOSBGhHo5yRgPd8OJOwCh6mRXQk7w3W7iyaB1E+TowEP+2o3LlsRC+oEUkEkqM112
 xDhT9rxFbgpQ0tfOJXKZYMHNGcm5meOn99L4VQ1xXFgUPAL9t7NtgV6fhD2y2Re6CpzD
 l/tA==
X-Gm-Message-State: AOJu0YzO0bnMVpOqHPZwZTZwLZZZk0X+tkd+AmkfgqvXy7xlHNZEApIK
 b9y6bVpfyyLNhraRjDFdqlpiUMntIJIvuu3Cd4hWp5SfBEPi9V2UGq7wyaEN3r0=
X-Google-Smtp-Source: AGHT+IHVqFaw+X7kQmIYHO6O8KtMFmcLIg8o7t3S26yp8WCOS/aWQgCT0m8o/4E1gH6+weNrIb8r9g==
X-Received: by 2002:a5d:5104:0:b0:346:f906:f6c0 with SMTP id
 s4-20020a5d5104000000b00346f906f6c0mr6168432wrt.8.1713192432642; 
 Mon, 15 Apr 2024 07:47:12 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.132.126])
 by smtp.gmail.com with ESMTPSA id
 j10-20020adff00a000000b003469e7f5c52sm12329928wro.80.2024.04.15.07.47.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Apr 2024 07:47:12 -0700 (PDT)
Message-ID: <9d11f4fa-8153-49b7-8920-7edb61ef36f7@linaro.org>
Date: Mon, 15 Apr 2024 16:47:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ppc440_pcix: Do not expose a bridge device on PCI bus
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20240411192443.B4D644E6026@zero.eik.bme.hu>
 <eecb616c-ad00-42da-ac49-1ebe51d0a1ec@linaro.org>
 <81128dae-f01e-ff40-c2cc-ff721dfdf288@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <81128dae-f01e-ff40-c2cc-ff721dfdf288@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 14/4/24 15:00, BALATON Zoltan wrote:
> On Sat, 13 Apr 2024, Philippe Mathieu-Daudé wrote:
>> On 11/4/24 21:24, BALATON Zoltan wrote:
>>> Real 460EX SoC apparently does not expose a bridge device and having
>>> it appear on PCI bus confuses an AmigaOS file system driver that uses
>>> this to detect which machine it is running on.
>>>
>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>> ---
>>> Here's another version that keeps the values and only drops the device
>>> so it's even less likely it could break anything, in case this can be
>>> accepted for 9.0.
>>>
>>>   hw/pci-host/ppc440_pcix.c | 11 ++++-------
>>>   1 file changed, 4 insertions(+), 7 deletions(-)
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Thanks. Nick, could you ack this please so it could be merged if you 
> won't send more pull requests? (I'm the maintainer of this file as it's 
> only used by sam460ex so maybe an ack is not needed but it could help to 
> show you have no problem with it.)

No need, queued, thanks.


