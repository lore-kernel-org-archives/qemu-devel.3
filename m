Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4581C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 17:12:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfNST-00016b-08; Wed, 28 Feb 2024 12:11:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rfNSR-00013s-7k
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 12:11:03 -0500
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rfNSO-00024Y-M5
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 12:11:02 -0500
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5131f3fc695so481714e87.1
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 09:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709140259; x=1709745059; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lH0XgKtLoDdjDUuAYVHTFnAR2gtUqskjk3f+6UbeqU8=;
 b=GXGURHopuonvpB30FfuGUDfgEMEsumLX4d3CI/DBNo+eY80F/yWNfHDBQCe9ztOiTH
 03CyYBzv89fWVpS8HnjBh9vRvhmH0JTdJ+DwhZuYm8lvSDP9g4hrh1omzvqM0XsZxx2+
 BMEOuzbiXDW/LM2fOtUU5kbdcq2RoXbWiwPBbTBeXe/NMrx4baUXFUx+gkQrqbn2cClz
 eZIu0S3VJlC8prQqO0l7kICzso2qHpUEnzA7+bws8w7MGWQot7VuWMHDvgaJlUyjLJZ+
 x0QU/IuGSitVqr62rYu9kEy67AkG22aDJcpzJ8gInrIIY83RxOiXfDQfKEVinqzEfqn7
 3BCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709140259; x=1709745059;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lH0XgKtLoDdjDUuAYVHTFnAR2gtUqskjk3f+6UbeqU8=;
 b=PfUnYfCtcvroLd+jHBPIeX93DWuyGRYvV/MlfbEs3WSIuk4CrEeGXstELLCs5j8bW4
 fytXbUzTF7jgTZAmm2wLo5cTOOLl/SfZYxedTr1gS3rqckSbWwffyfFRrswdq6okPvm6
 6wK3esDUdOq7Bc0Qzk4ZLLo+48r41YCKqV5NrLa4tL7kH8TdueWSzhrdseeVYb8v2miQ
 P5UR2twa2nn+p8jVEPLTayh3ucR69wrVqisT7sf+FQwI+sKAWGen3ZgB8YGYNilJWAg6
 TzYjBk0E13jSSe4juHtyMgchtz8uhOsM5O7Aaa20B1Kc+4ank6fJVEQI7qoGvvWka7kp
 wY3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuRshpfc6oPcL6p7iMiSX4h/DVB6TOLvpAkpsmrKxyahUMefqcKl8aOXNoX9jCI+EBRjwFW8pKjuTJmISGZxMEg8nDIUY=
X-Gm-Message-State: AOJu0Yz4l3tAAsQLggl8iLOiWw6YWNYOPojArbZMFCeBhjUq6d29QxT1
 l8eHlWSaZjMAHXEM7+uoDfJ3inv2scvA0w5c4Z4gsoUw4tJ6uqYqsx7I3VR/9A051Gx2jBib7Ak
 WyV8=
X-Google-Smtp-Source: AGHT+IFgwMehDdoXwEtKWiRuG0gweswiwO3hxYrbRP9OZQmEhXVWX1TxR1cXMByiMc4t/1Fspcc+dA==
X-Received: by 2002:a19:ad48:0:b0:513:2027:27db with SMTP id
 s8-20020a19ad48000000b00513202727dbmr194882lfd.17.1709140258867; 
 Wed, 28 Feb 2024 09:10:58 -0800 (PST)
Received: from [192.168.61.175] ([92.88.171.132])
 by smtp.gmail.com with ESMTPSA id
 fa7-20020a05600c518700b00412b9e4af05sm40715wmb.0.2024.02.28.09.10.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Feb 2024 09:10:58 -0800 (PST)
Message-ID: <e44d140a-d5b2-4bbb-a344-f964981734f3@linaro.org>
Date: Wed, 28 Feb 2024 18:10:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update Sriram Yagnaraman mail address
Content-Language: en-US
To: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20240228080625.2412372-1-sriram.yagnaraman@ericsson.com>
 <3ac7d304-6bf4-49fa-b19e-74925409e736@linaro.org>
 <AS4PR07MB841212D830F253167DEBFFD890582@AS4PR07MB8412.eurprd07.prod.outlook.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <AS4PR07MB841212D830F253167DEBFFD890582@AS4PR07MB8412.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x131.google.com
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

On 28/2/24 16:33, Sriram Yagnaraman wrote:
> Hi Philippe,
> 
>> -----Original Message-----
>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Sent: Wednesday, 28 February 2024 16:25
>> To: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>; qemu-
>> devel@nongnu.org
>> Subject: Re: [PATCH] MAINTAINERS: Update Sriram Yagnaraman mail address
>>
>> Hi Sriram,
>>
>> On 28/2/24 09:06, Sriram Yagnaraman wrote:
>>> Due to company policies, I have changed my mail address. Updating
>>> MAINTAINERS and .mailmap to show my latest mail address.
>>>
>>> Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
>>> ---
>>>    .mailmap    | 1 +
>>>    MAINTAINERS | 2 +-
>>>    2 files changed, 2 insertions(+), 1 deletion(-)
>>
>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS index 65dfdc9677..0a3294f698
>>> 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -2474,7 +2474,7 @@ F: tests/qtest/libqos/e1000e.*
>>>
>>>    igb
>>>    M: Akihiko Odaki <akihiko.odaki@daynix.com>
>>> -R: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
>>
>> Could you confirm this from your <sriram.yagnaraman@est.tech> address?
> 
> Unfortunately, I don't have access to that mail address anymore.
> It was a chicken and egg situation for me, I was not allowed to be a reviewer with @ericsson.com when I still had @est.tech. :/
> 
> Is there any other way to prove I am the same person?

I suppose for a 'R:' tag this isn't an issue...

> 
>>
>>> +R: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
>>>    S: Maintained
>>>    F: docs/system/devices/igb.rst
>>>    F: hw/net/igb*


