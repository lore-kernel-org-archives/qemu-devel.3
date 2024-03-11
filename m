Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6927AC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 20:00:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjloe-00009X-FZ; Mon, 11 Mar 2024 16:00:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjloc-00006f-Bf
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 16:00:06 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjloa-0000kY-N4
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 16:00:06 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-41329a665d8so10686425e9.2
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 13:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710187203; x=1710792003; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7XbtR/WEEhbLT1pUuOM2JR3wU7UPf8y386ac/r3GhlE=;
 b=GBP1FI3MPjSdSt5qBd8Cgs6u7x8DTYNi3BU22WN017b/BEOAfyzOeexFDmldjK4Ttq
 m+h+lMVwGI1zutriGU01p0PJN0OBNr2ZvckodJTuN8c4qGhTut4pLIv127PUBa3Snacy
 Umr/Fo1e7v7LFJBNqQYxMWasU/oxmgOT9+j73rP6rq3FPFmpyDpc72jDnZIolle2ffa1
 l6VmHDCVsdwMObI6ghMkc1plh2jb9ne6HfdRaJ9Gx/en2N8LL+axohOsJLJZ/ZSev1DH
 hCLBOxEBW7nxIbbqYyGXXww8LDbDbFaViCVzkBOkYmjrZfJNLkPY9UkTq7Vxh7z9Ugt7
 zOUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710187203; x=1710792003;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7XbtR/WEEhbLT1pUuOM2JR3wU7UPf8y386ac/r3GhlE=;
 b=g2aY/Z58xDZPrIUE5b1zGlWRNIEtYb5f7uE8Xd0WysZ09g2y/+pU1vDvnFTJE+qQ4H
 eIlZ3oBnJloV11fHLRNRizAAV3DVcy8arsMdhEwlV8Hvp0SZldEKEmguGIWV5x1A2T2C
 icwQJ7ZYmWxTKCrSwGKvCBckkg9dUVqkf/12xJ2NI2I0BY986XStHjMWl6bd+Uqcy7rB
 ZHpEsftJRHkqkNEh7Pbxglyuk8Tgk7sAYa8v0HK+FCgHtqZzKjs8KEonyjk+i603CLRG
 8j/nMI/XU5EcTRbfsxiUuoHUor9ce24HEW08GzyWAMX0oNbLHGLsqPtJcVpyT5MMKTYD
 iAkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWc7ckmAeYdWgbFuyevmsmIjCA8YviaKdrGWoaRkIO9HCCmQKw+GngzIpA1f5Acf+RntIo07p71l12A5UIXKFX5jcWSwwY=
X-Gm-Message-State: AOJu0YwTDYAq6DiiXKMar/Y6WHBYVUVOES0rNXx2mp5JcnAE/8wpl9Bi
 sD8Y3LQuGRUS/zkIr5NI7Z1uL52AlXyjzHR14d8BylrB5nSSxQH43ta6ICmTjO0=
X-Google-Smtp-Source: AGHT+IFpNG3Tja7pkAMGvM68q8jGRjBpPvYWCZNe25OeevI2o9Ww1vMGHHODXLw0JMYTDTMRUui6lw==
X-Received: by 2002:a05:600c:5405:b0:413:2b2e:4b74 with SMTP id
 he5-20020a05600c540500b004132b2e4b74mr2218098wmb.36.1710187202681; 
 Mon, 11 Mar 2024 13:00:02 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.167.228])
 by smtp.gmail.com with ESMTPSA id
 j27-20020a05600c1c1b00b00412f83e0c11sm16524328wms.22.2024.03.11.13.00.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Mar 2024 13:00:02 -0700 (PDT)
Message-ID: <394d85ab-e7b3-4126-b81e-f6c672485a9e@linaro.org>
Date: Mon, 11 Mar 2024 21:00:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/ppc/sam460ex: Support short options for adding drives
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org
References: <20240305225721.E9A404E6005@zero.eik.bme.hu>
 <894f71b9-8e03-7459-1946-c95d24efee72@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <894f71b9-8e03-7459-1946-c95d24efee72@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 9/3/24 12:34, BALATON Zoltan wrote:
> On Tue, 5 Mar 2024, BALATON Zoltan wrote:
>> Having to use -drive if=none,... and -device ide-[cd,hd] is
>> inconvenient. Add support for shorter convenience options such as
>> -cdrom and -drive media=disk. Also adjust two nearby comments for code
>> style.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> 
> Ping for freeze? (Forgot to cc qemu-ppc, now adding that too.)
> 
>> ---
>> hw/ppc/sam460ex.c | 24 +++++++++++++++++++-----
>> 1 file changed, 19 insertions(+), 5 deletions(-)

I'm queuing this patch, thanks.

