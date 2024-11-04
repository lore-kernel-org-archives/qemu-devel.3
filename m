Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C33D132A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 10:34:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7uOk-0004BW-Cj; Mon, 04 Nov 2024 05:33:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t7uOi-0004B9-MM
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 05:33:24 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t7uOg-00010r-SL
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 05:33:24 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43193678216so35081895e9.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 02:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730716401; x=1731321201; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KzVHIa4009J5lHNdd+RPwSYq34F+AL83D7dZKkSBSu8=;
 b=Vl6ejsj3/bsBMPi1Bsdr9i88FFeWd904aJyLEDbYkuzrcAIwk/kiq2TPv+WdRPoo/x
 SoK0gD3njjAk/robrkpZY25PL7kPEDgQMd82dLsU51Zs+9juphrRc8d8dywO5fA64L+S
 E2Xjba3X7uIeB61drVL2WSM3AoYHcECYspExjf0OMZIJx5NlO2Bg8RbH4RCJyP/rg2ka
 fPlPeFSYpQWz9nsyaCmHWlm0C3ShEUH0L38boyU+aQWSI4oY39YBSDnKp46DzhuCn1me
 GVNQY+bw7cuGlMVNbJRpT6MuDVWyUCx9MvbQvVclu4TJUJ/uYIhT8/Mqw933ahDXFcIH
 j7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730716401; x=1731321201;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KzVHIa4009J5lHNdd+RPwSYq34F+AL83D7dZKkSBSu8=;
 b=cmeJ2zM+KMpR9JbB6LH7obVeY//zJSEIKafAqg65LJM0iHPiFAmtotKIHwivwrhpK9
 j8cr0L9SWBdo3VXJlOxuGYyWaKeE018VXvd8bxCbPKmuoS5M1HAZyZYN99gTvbGcGOt8
 +i7MQkVWSSKggdyF77MMrR8WnqKMJpHbtEI+SAvbHtABlFc3ywKCQO2Ol/0BG/CWacMB
 AaGHJFap8YWo5ytFisLVXnPhPDTVCySYzkQwnrFX7FUJ5rbSmzIW8aGePEvIHJuBW++K
 kq2wbLJSw3FNvbZL4W0jjkU4Jz3TCHA9v7ZttLXezbBm5Qoisp7UeeHKBdErJwov7wV4
 L+GQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTiKLL/LvYEumarmHZ5cRJjRw/ZSq6GRqGCG5LFWsI+EZhkWpsAWLi7eu1fqLCB/CiFhhbbIaheFcv@nongnu.org
X-Gm-Message-State: AOJu0Yw92+v1mgJl/wsQ5cHFBTVjmvODYd9H3BmrE15EG7IWWNHJuP18
 KHcdbeHTee7FB1p9LWAuUeL2kEmhwDDa8whv8oEqANGt4i8AbouO5bZcR3kTMIs=
X-Google-Smtp-Source: AGHT+IHypJGW3vf9nXsIxYicHzy74AQuZlxgMt0ghMMHAfdCxTTs33KAAk2Q9Frh2oXeBn+yv2mObw==
X-Received: by 2002:a05:600c:458e:b0:42c:baf9:bee7 with SMTP id
 5b1f17b1804b1-4328250f211mr122777275e9.12.1730716401195; 
 Mon, 04 Nov 2024 02:33:21 -0800 (PST)
Received: from [192.168.69.126] ([176.176.145.27])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d5e8562sm149387215e9.23.2024.11.04.02.33.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 02:33:20 -0800 (PST)
Message-ID: <9ecb2c75-3e1f-4c3b-918b-af40fa3d6fac@linaro.org>
Date: Mon, 4 Nov 2024 11:33:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/sd/sdcard: Fix calculation of size when using eMMC
 boot partitions
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Jan Luebbe <jlu@pengutronix.de>, qemu-devel@nongnu.org
Cc: Guenter Roeck <linux@roeck-us.net>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org, qemu-block@nongnu.org
References: <1bce4c22-9281-44c5-8acb-860881dc271c@kaod.org>
 <20241028162308.2152712-1-jlu@pengutronix.de>
 <9fa94cbc-8010-4805-be44-939ce35182dc@kaod.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <9fa94cbc-8010-4805-be44-939ce35182dc@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 2/11/24 12:06, Cédric Le Goater wrote:
> Philippe,
> 
> I can take this patch through the aspeed branch.

I missed this patch because it was deeply buried in a long thread.

Since you mentioned this feature will be reworked in the next cycle:

Acked-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> 
> Thanks,
> 
> C.
> 
> On 10/28/24 17:23, Jan Luebbe wrote:
>> The sd_bootpart_offset() function calculates the *runtime* offset which
>> changes as the guest switches between accessing the main user data area
>> and the boot partitions by writing to the EXT_CSD_PART_CONFIG_ACC_MASK
>> bits, so it shouldn't be used to calculate the main user data area size.
>>
>> Instead, subtract the boot_part_size directly (twice, as there are two
>> identical boot partitions defined by the eMMC spec).
>>
>> Suggested-by: Cédric Le Goater <clg@kaod.org>
>> Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
>> --->   hw/sd/sd.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>> index 2d3467c3d956..8430d5ae361c 100644
>> --- a/hw/sd/sd.c
>> +++ b/hw/sd/sd.c
>> @@ -826,7 +826,9 @@ static void sd_reset(DeviceState *dev)
>>           sect = 0;
>>       }
>>       size = sect << HWBLOCK_SHIFT;
>> -    size -= sd_bootpart_offset(sd);
>> +    if (sd_is_emmc(sd)) {
>> +        size -= sd->boot_part_size * 2;
>> +    }
>>       sect = sd_addr_to_wpnum(size) + 1;
> 


