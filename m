Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34841C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:06:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjl6-0005Y3-JA; Tue, 02 Jul 2024 16:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOjkx-0005VS-Ff
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:05:41 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOjks-00066R-3F
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:05:39 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-424adaa6ceeso28398795e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719950732; x=1720555532; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w8gAwN1D88QMpBVoNMosE1dI9F9t175M0EQtzx003Sc=;
 b=aWmIPRpKqthLVeZUO01Ld1xchsATWU0+5Im/58YKb3g9BdQwAWEXa0p6KRvVTG2sRU
 Vv+8LMWkFpXMKTanE+w7HO/pgOOzsL4U3USQ8m3uGs/T4UCFnRHEEWaZYTCAcUF2o5JC
 XtgzV1kI46v5M9ZbdSLxN7+WJYi3+WKfmxvCihQm8lSpkVJVPwZITU9IVp6DBmb3Rmzk
 xTzIBacA0U0NsLbw4K5ejin12Kqmug+qq6GRx7lKyZlc3KhQyzm3SIm9YvuKF8/E6UY3
 FwU2BsopzMNHb9G+BzPmD0ZrgLtm6u8yx2JchKzza+S+Uynxc500RgmseAXUu8kFLhgO
 jt1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719950732; x=1720555532;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w8gAwN1D88QMpBVoNMosE1dI9F9t175M0EQtzx003Sc=;
 b=pvzfmx7PpSa/G+bLwZOSdUBfya8Fgu8P8ryk/UOBedT2kbyoOzScAwC8pFY2zoAfpN
 mcBYg1dVkBjKyMiqlfaAUwGiHwJiDdMkZQ+p3I5vQABMUHdAddUkLeSGypJ9aZJ+nl9S
 IcP27/+P1rPkLkkhwVoNhCDHxol/60qQ+cP1hbngKmAKTndpAMmN5nVR1hbi2Up/uYFk
 ipCf+1ZekIhdjC7c3mP2ZFeLfv8vs29hMIbYbrYLUTM6uDL9dEEKD/8+cwQvf45nSp5n
 0xoblvErHS6ygdkOLqZPxpMudzrr/VUkpvdLnXGFAKhN3/7Mi01ClKmwff/f6vVvsFMY
 wCcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8x0+1fftYyZm/qK6w6yr9+MPWsV4NJnbjA2BRa+07gpPBf4HIP3ZBXxfxg+CayXd6WxLhBFMY9scuQAGtuYHy0vxBHxk=
X-Gm-Message-State: AOJu0YwW56nmbeEGU3XeHzPkwaOxMRstjLzjev7qIrjm5CxyAfEobNS0
 /RT3voxm2Xqs0hKNqXBUsed6R0Et+yiR5kHQQtm1l0LaYqZP1oI+jsPdyUn/CW9V9HmWabbVIsD
 H
X-Google-Smtp-Source: AGHT+IGGTBAAimkBPC0bVuIQMohYBcTIMmDQ5gMH1Kdz8DpO73EeK2jsD6xpciAnDm/VAxWarGGi9w==
X-Received: by 2002:a05:600c:54c4:b0:424:b3cf:d704 with SMTP id
 5b1f17b1804b1-4257a05edbdmr68282015e9.37.1719950732310; 
 Tue, 02 Jul 2024 13:05:32 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.220.97])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0d9b12sm14084722f8f.44.2024.07.02.13.05.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jul 2024 13:05:31 -0700 (PDT)
Message-ID: <dedc8d45-42cf-4474-ad33-9af44701dcb8@linaro.org>
Date: Tue, 2 Jul 2024 22:05:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [RFC PATCH v42 90/98] hw/sd/sdcard: Add experimental
 'x-aspeed-emmc-kludge' property
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-devel@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Troy Lee <troy_lee@aspeedtech.com>
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-91-philmd@linaro.org>
 <4b55f817-0e29-45c0-8f56-f997f34e0e97@kaod.org>
 <e1a6b93038e67271fc0bd9efcc7d40802cbbede7.camel@codeconstruct.com.au>
 <2b425f32-41de-4057-a8d0-79411f2519b4@linaro.org>
 <aa9bd7c7-1b4c-4f3a-975d-1ee7931be422@kaod.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aa9bd7c7-1b4c-4f3a-975d-1ee7931be422@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 2/7/24 18:21, Cédric Le Goater wrote:
> On 7/2/24 6:15 PM, Philippe Mathieu-Daudé wrote:
>> On 2/7/24 07:06, Andrew Jeffery wrote:
>>> On Fri, 2024-06-28 at 11:16 +0200, Cédric Le Goater wrote:
>>>> On 6/28/24 9:02 AM, Philippe Mathieu-Daudé wrote:
>>>>> When booting U-boot/Linux on Aspeed boards via eMMC,
>>>>> some commands don't behave as expected from the spec.
>>>>>
>>>>> Add the 'x-aspeed-emmc-kludge' property to allow non
>>>>> standard uses until we figure out the reasons.
>>>>
>>>> I am not aware of any singularity in the eMMC logic provided by Aspeed.
>>>> U-Boot and Linux drivers seem very generic. May be others can tell.
>>>
>>> I'm not aware of any command kludges. The main problem I had when I
>>> wrote the Linux driver for the Aspeed controller was the phase tuning,
>>> but that doesn't sound related.
>>
>> Yeah I don't think anything Aspeed nor U-boot related, we
>> model CSD/CID registers per the SD spec, not MMC. Various
>> fields are identical, but few differ, this might be the
>> problem.
>>
>> I rather respect the spec by default, so until we figure
>> the issue, are you OK to use a 'x-emmc-kludge' property
>> and set it on the Aspeed boards?
> 
> If these differences are eMMC related, why not simply test :
> 
>      if (sd_is_emmc(sd)) ...
> 
> in commands ALL_SEND_CID and APP_CMD ? The extra property looks
> ambiguous to me.

I'd like to keep the sd_is_emmc() check for code respecting
the eMMC spec. I believe the commands in sd_proto_emmc[] in
this series do respect it, modulo some register field
definitions that are SD specific. So 'x-emmc-kludge' would
be a property to allow eMMC use -- without delaying it further
--, by bypassing a *bug* in our current model. I'm willing to
figure out the problem and fix it, but /after/ the 9.1 release.
We are too close of the soft freeze and trying to fix that
before is too much pressure on my right now.

> Thanks,
> 
> C.
> 
> 


