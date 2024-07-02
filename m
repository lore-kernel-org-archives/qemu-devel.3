Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D743AC3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:07:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjmV-00074O-V7; Tue, 02 Jul 2024 16:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOjmT-00070y-Nu
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:07:13 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOjmS-0006FH-54
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:07:13 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42563a9fa58so32671055e9.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719950830; x=1720555630; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VAauEDfmqRI/Ai4xwtjQ3uCxlyWmwX2oy5GbL30AxZs=;
 b=SycoceAKPul7O9o4qsoIBXnwysdv84hxJxqiw48O9EeknhcLBSfoLZnR4j9K7mKXsl
 yZlkf3Vb8/foXErPE3w5X/bhk2cRvxjDvug8BloN9c/PYkoBQx0BA+BDqFrFMbEy/QKB
 fTbMwjbbolFbHFmDVLUgYeYIO6tUOkUul4vAdW4mQI+CTzwvhOObxdefx6QFfuralDGX
 cBRirctLohIfQszuHlilkgpcd26GBi9v1P+jD2gTMnju2Ek/hjR2zusfQwUa8y19RPKi
 4Cm3Ey0mvr20IHyPBWY/CI36oRpk8/ZTGNdiGsxevsWVHJ3i3ttBYH4VIIrkWwdDQxvM
 X5sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719950830; x=1720555630;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VAauEDfmqRI/Ai4xwtjQ3uCxlyWmwX2oy5GbL30AxZs=;
 b=qjvSTXOm1tDvRQBgFQvmOXdhcQjeJMLKqbFgzpDBB/kVoIDydXgiVMSQm38nXl0Cvm
 Vx99BJUM/Nc1mgcpbd9ZvF7OhoitM5c+90eImg3Eg2DLlt4vVYsShauPwr7/QGxuxIKt
 LfzCMIDdAxM+kx7UEBZ7ILPLjOZB6BFdDT4JCROkuRn7HmmETxryPoPJfQwRgUHxR2rg
 Cj9lsOoEs+TBS5xV+u/BGuSJ/+U4TCjTGbK6kH9XizU1BWbOpYkeiBtju5HppLaQbgn0
 yU06QQNZQ+xiVVGnkVtWW0dOciYtdv+NHK8cPi9xXYfgullrg8+yYwz4YAKFsEqVYGjI
 L0rQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRgCWTh8bLNMAw1YsSQxwtwnq9zC8jre9VCwZHup2mnoWWUaE8qz8TSvDRDsdH177ZiPHSkHL9b1v4YXSk5rzLTa8JuFo=
X-Gm-Message-State: AOJu0YzqpsTWSi6ErsP/i6OLA1Kmeca3mSMTP4Zx9lsrdgqud++rg1E9
 zYdNLc0IVnx0BihlD/MYDzZ7DyUF5CH7iySJV6UeRF688FAVnVhXsvwO7N2t9BSmebq/dpVI/Et
 L
X-Google-Smtp-Source: AGHT+IGUoTBC0z/X+JKEarwr8OFBtd+TV6ZQarjgdGotz2VkReMZyD7VRlmr0Y3rZNpDWV0PUyy5PQ==
X-Received: by 2002:a5d:456f:0:b0:366:e9f5:7814 with SMTP id
 ffacd0b85a97d-367756bca65mr6065984f8f.42.1719950830095; 
 Tue, 02 Jul 2024 13:07:10 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.220.97])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0cd623sm14166696f8f.16.2024.07.02.13.07.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jul 2024 13:07:09 -0700 (PDT)
Message-ID: <6e1ddf7a-bc0a-4be3-84e0-da8933343c10@linaro.org>
Date: Tue, 2 Jul 2024 22:07:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [RFC PATCH v42 90/98] hw/sd/sdcard: Add experimental
 'x-aspeed-emmc-kludge' property
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
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
 <dedc8d45-42cf-4474-ad33-9af44701dcb8@linaro.org>
Content-Language: en-US
In-Reply-To: <dedc8d45-42cf-4474-ad33-9af44701dcb8@linaro.org>
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

On 2/7/24 22:05, Philippe Mathieu-Daudé wrote:
> On 2/7/24 18:21, Cédric Le Goater wrote:
>> On 7/2/24 6:15 PM, Philippe Mathieu-Daudé wrote:
>>> On 2/7/24 07:06, Andrew Jeffery wrote:
>>>> On Fri, 2024-06-28 at 11:16 +0200, Cédric Le Goater wrote:
>>>>> On 6/28/24 9:02 AM, Philippe Mathieu-Daudé wrote:
>>>>>> When booting U-boot/Linux on Aspeed boards via eMMC,
>>>>>> some commands don't behave as expected from the spec.
>>>>>>
>>>>>> Add the 'x-aspeed-emmc-kludge' property to allow non
>>>>>> standard uses until we figure out the reasons.
>>>>>
>>>>> I am not aware of any singularity in the eMMC logic provided by 
>>>>> Aspeed.
>>>>> U-Boot and Linux drivers seem very generic. May be others can tell.
>>>>
>>>> I'm not aware of any command kludges. The main problem I had when I
>>>> wrote the Linux driver for the Aspeed controller was the phase tuning,
>>>> but that doesn't sound related.
>>>
>>> Yeah I don't think anything Aspeed nor U-boot related, we
>>> model CSD/CID registers per the SD spec, not MMC. Various
>>> fields are identical, but few differ, this might be the
>>> problem.
>>>
>>> I rather respect the spec by default, so until we figure
>>> the issue, are you OK to use a 'x-emmc-kludge' property
>>> and set it on the Aspeed boards?
>>
>> If these differences are eMMC related, why not simply test :
>>
>>      if (sd_is_emmc(sd)) ...
>>
>> in commands ALL_SEND_CID and APP_CMD ? The extra property looks
>> ambiguous to me.
> 
> I'd like to keep the sd_is_emmc() check for code respecting
> the eMMC spec. I believe the commands in sd_proto_emmc[] in
> this series do respect it, modulo some register field
> definitions that are SD specific. So 'x-emmc-kludge' would
> be a property to allow eMMC use -- without delaying it further
> --, by bypassing a *bug* in our current model. I'm willing to
> figure out the problem and fix it, but /after/ the 9.1 release.
> We are too close of the soft freeze and trying to fix that
> before is too much pressure on my right now.

(Similar pressure I'm putting on you to review this huge series...)


