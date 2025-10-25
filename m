Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA71DCCD1BF
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Oct 2025 16:49:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vChSG-00016T-AY; Sat, 25 Oct 2025 12:49:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vChSE-00016C-KZ
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 12:49:22 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vChSC-0008Kq-W7
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 12:49:22 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-471191ac79dso32143505e9.3
 for <qemu-devel@nongnu.org>; Sat, 25 Oct 2025 09:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761410959; x=1762015759; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ifYoopudD6hR86pVd2Kw+QDnHgyDHItNWDcRTmzVcTY=;
 b=Vu3DE0BFJmZ9fbb6GB8wE/ie7FUlt46ageq4CJU38e1mtMk+l75h6Dsmuuzxsb4Ui2
 naZu9savG8ZCAFni439CX9Az8clo+Tj6h7Cv1jY1HwkTGBt2RXPdog2QMOwMT+dSfehK
 /X8fCYHoOxa0ZBVhYNzFsCdDNGk0N0BtvksJ0uGzF0N1aHIEVS5jhK7h2nDzturayyDs
 nHD5aObnWe0eTgOTor9NP7UO2Zh4BOUXHguszOLpkM9ta0rv1pAUbuyEERhjCDSmYkWr
 njPJgGcfmqRKyIMzL6X0bqr7E1ayYUgB1BjYa7ykkXhlaZod84JjdqdOMsDdiUs4SysW
 s7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761410959; x=1762015759;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ifYoopudD6hR86pVd2Kw+QDnHgyDHItNWDcRTmzVcTY=;
 b=MgqTc+Yu/gTDxx1IIHQuMZIikgOTxrRiTgWkY7jT+dJMcbm6Bv4p4tmR7pfvOXF9C9
 4yS20S5nLI8YiRWBPXRi2zGNPMtughN3GLD/LqhNbdt5yVDB2sCuV5fLy0ZGvxDsFJRy
 YazK5wYfCa+iB6B31ipN2ANgCQXyqylGtwt/I8KOusqRIWBTwCsAnSTzjHNn4hqpikKz
 tsJ5d1j///m4N84Eim+KIikS9cJcdS98wF1yxD2p2EMzWwGkZdKbY95QCgvsSPTt8dDc
 1co7V+E7wFEEciVLHz/nhhN/k7vzECjOXeYVSxSkxRa9PqYi3GrJD+aiOYVPsfdpmlGt
 RjAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4lDtHRCg/UXNuHD6qg4j4Hhnv7v/MiDTOnahTCaGOEhpdHWrPit3G7xMB4ewVWcH2dwDuV1QWCPzc@nongnu.org
X-Gm-Message-State: AOJu0Yy7hTR7Tatf1WBULGbSY5rXVAQxZu3fVgblbhXjCGRte04UnZ1x
 humXXDw3ASZwptkF+hwkzgTfmhWfFSrnpmoJf7OpfICc7JYOn89reKGFxpmTYbbkNBE=
X-Gm-Gg: ASbGnctpWz1xndWXCzC5TTR9U4WXmMuUiL9AwTIuUPWE2aoM0stVUu+HXqyz4TVzZ1t
 smWRltJoBw+YhY8H2iW9SkjrHsxKVvY3/DmbwzWZ+An68wiXXcytZg3USNiLyKqDk5mn+JnVvLx
 I0tfpM81KIaskui2uXzb0ZJZKBIAJ3ODsKm/Ud6SRVz/IkRpl3FgQbFWqXnEOou+rejmMQGrJ0I
 OrVeKRBVg8Bn1dtBMNlpm2bcr2kkS2MvHjHvMSasy/9GzEZ2AUnGJUjdyw6UF1oLZEDEw1+eAif
 vWRmrFTATHztNpPVHC7bdAf21XGSDAR3y6qWQe7KsP8llo9b3uf4kaX21soUr4p/TvMrdQLaPf4
 cbbRogoXjZpQf6c66gmGth3c8r+lmH6samKDyeaQAptVUgBXc31y3YjCzL1OsU6ivyW+xkr2Xd4
 YU7sbAczh0ywt0vlxQfLIq4TSnWk/kD2KtYKiJAZ6OoFIjxuziiP1MnMmg9A2ncJoW
X-Google-Smtp-Source: AGHT+IHc2Njl6/y5KTXNJNMfmy7HAv38sw7HH/Djbqye90u8rBiMkAa7WveFoOhjR2ECxoGEIgajKQ==
X-Received: by 2002:a05:600c:c173:b0:45d:e6b6:55fe with SMTP id
 5b1f17b1804b1-475d2ee1ca4mr57075005e9.34.1761410958771; 
 Sat, 25 Oct 2025 09:49:18 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475ddab6adcsm18972055e9.9.2025.10.25.09.49.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Oct 2025 09:49:18 -0700 (PDT)
Message-ID: <a7280729-ff67-46df-bcd3-1de5f6df84c1@linaro.org>
Date: Sat, 25 Oct 2025 18:49:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/pci-host/articia: Add variable for common type cast
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20251025125512.19967597305@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251025125512.19967597305@zero.eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 25/10/25 14:55, BALATON Zoltan wrote:
> We need the device casted to OBJECT often enough in realize to store
> it in a local variable that also makes function calls more readable.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
> Based-on: <cover.1761346145.git.balaton@eik.bme.hu>
> 
> hw/pci-host/articia.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/pci-host/articia.c b/hw/pci-host/articia.c
> index 761e89bc8f..56fe3b6953 100644
> --- a/hw/pci-host/articia.c
> +++ b/hw/pci-host/articia.c
> @@ -174,24 +174,24 @@ static void articia_realize(DeviceState *dev, Error **errp)
>   {
>       ArticiaState *s = ARTICIA(dev);
>       PCIHostState *h = PCI_HOST_BRIDGE(dev);
> +    Object *o = OBJECT(dev);

Preferably "obj".

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


