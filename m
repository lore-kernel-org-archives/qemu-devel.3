Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55938E87839
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:26:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnIHr-0003Ik-OJ; Tue, 03 Feb 2026 10:25:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnIHn-0003HU-RP
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:25:52 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnIHl-0003ba-Ax
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:25:51 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4806f80cac9so31441385e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 07:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770132346; x=1770737146; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zz9Xptb//vhNN0iiRD6i4hpiptz//NbAq6XkSaRkxT8=;
 b=pjss1YIIaPSbvKcINQfGWSVwwhTHUFQJtJcLM7xzdunvu8uv6AojuXZdzDfuxp7bBl
 JpoXeQS2HaAq/qR9Es+MS3wWF3jrdHOhw7YKg5VjF5iUUYgHUlKTcenaHTzhUX4pPBQM
 T/fr+ybjqFKiqmZElHSqLRLLGd9T0daWwrWM2Pwq4xHfQoEDBo/zmMbAxLpiG/57GOIK
 lkF7pNAfs9ipO3jdR7qvLx72+M3iwr8QgalVouyElQbdsRc3pFCtK4eCI1Z5PT1bUOH5
 SQPbWdlhnF1TG57Uy+2QsOA2GipTGuIsn1HE0AMI/UmebHTuUx74xsOaQDSHPp/HLOx+
 PjeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770132346; x=1770737146;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zz9Xptb//vhNN0iiRD6i4hpiptz//NbAq6XkSaRkxT8=;
 b=FW4rng+QoVWIhYzKYFcxlZoo+dBPvG6HBgRXcgiRQxPOWX4wjVV4NbXoDMBvstKSAb
 nSkRK0LHwn+SzvZ3eaN3gbV4eZ9xUESh0DbUVOj/IukggCGjHqAw9YvEd6DErGgyk3gJ
 fPr3AIr1vzLdcEPfP7Sun2vDMbu9HUAFNU6Cvn3FirV7Nlcl0n6VDk1gu4BMEcXqkKz7
 9ELZj/oAPVvUNxZdMNkogqHgESv10e5zhX9ZL6HtIp+Rb5mgjkFxfxZLmCvkYNPgB4L/
 XDWoCubs5PmW24Dyg0P1vWx0lskmhtiANh/appWOUGGXjB0dN+klBxOEeJ5Izgmmqv8T
 xyfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtGv7Xd6Hl4FqSsCPcBE61nu1+GBZN1eSdIwUjUSNcDK2ZucmRKe2U3EyND9BN9z+RPhVrqyewZMq7@nongnu.org
X-Gm-Message-State: AOJu0YzVVqWWJ0jRuoZSp9xnzi2wM8zgQCKJRM69EXVVow6ydW7velEV
 KWJAcnLEIr6Saum8tQYYcx2M9s2D/Yb8EPjRg2zz6GxI4+s5wWYkDQxPwxhtqRHnqtg=
X-Gm-Gg: AZuq6aL1xvX+7wtZ590Ghm/PjfI9vtSnCrLUp8cDz2wQU9G2eO/8/Lo9oRukoIvbPms
 eqb3a1gH5xBoPLg0A8bnl7kPc40WFIXYnN6FCtWqSEAvVQo4ycYp1biACteEWF3psqKEjZoh658
 EM7m45l1BNFsiMuljc5dpM75pfT0aukSd658d8LX+PTihgzqC3bHoJ+nnAYulM1iGw4EpMuFS09
 78ZhTW+1epX+YerVz4njAMUQ9LNZcG+ic9rYGvWusot7LH04dE28xtvNhfdrlNEVJqzIIufsMJE
 XyRQ6ZIKbBbSitB0VbZmSlKyhgoKjoGXgoLwR2vMLB+0lmyJiUh1qNNozLcL+cGcZexD4Myxteb
 2DDQC+p0i71ubZlvOQ6DhU+/L/yx3O58/dDK7CUhxj5OEGpju71C1KjOhMcLs0eSD8UzuRsmMOf
 +zxDW4WXQQk/LZxaaHNMQsub3T1gpqtN/4mwnNxOaBQnFzbsp5EeyWAA==
X-Received: by 2002:a05:600c:4e0f:b0:482:f12f:f35e with SMTP id
 5b1f17b1804b1-4830e9310f6mr381205e9.12.1770132346156; 
 Tue, 03 Feb 2026 07:25:46 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-482da903a30sm151679675e9.1.2026.02.03.07.25.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Feb 2026 07:25:45 -0800 (PST)
Message-ID: <30e03d21-44ee-487c-90bd-bdbee3ac69a0@linaro.org>
Date: Tue, 3 Feb 2026 16:25:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] vfio/pci: Refactor atomic capability checking
Content-Language: en-US
To: "Pekovic, Manojlo" <Manojlo.Pekovic@amd.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "Prica, Nikola" <Nikola.Prica@amd.com>,
 "Andjelkovic, Dejan" <Dejan.Andjelkovic@amd.com>,
 Manojlo Pekovic <mpekovic@example.com>
References: <20260203144939.49-1-manojlo.pekovic@amd.com>
 <20260203144939.49-2-manojlo.pekovic@amd.com>
 <2af33652-d467-42be-86c3-e1995f2c1b89@linaro.org>
 <CH0PR12MB52838F23E3431D5C21EF5240FA9BA@CH0PR12MB5283.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CH0PR12MB52838F23E3431D5C21EF5240FA9BA@CH0PR12MB5283.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 3/2/26 15:55, Pekovic, Manojlo wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hi Philippe,
> 
> Yeah, just caught it in the output of git send-email.. Sorry for that.
> What is the appropriate fix, should I send the completely new patch, as this one went out?

Yeah that would be better :)

> 
> Thanks and sorry for inconvenience,
> Manojlo Pekovic
> Software Development Engineer 2
> Cloud Software Team
> 
> 
> 
> -----Original Message-----
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Sent: Tuesday, February 3, 2026 3:53 PM
> To: Pekovic, Manojlo <Manojlo.Pekovic@amd.com>; qemu-devel@nongnu.org
> Cc: alex.williamson@redhat.com; clg@redhat.com; Prica, Nikola <Nikola.Prica@amd.com>; Andjelkovic, Dejan <Dejan.Andjelkovic@amd.com>; Manojlo Pekovic <mpekovic@example.com>
> Subject: Re: [PATCH 1/2] vfio/pci: Refactor atomic capability checking
> 
> Hi Manojlo,
> 
> On 3/2/26 15:49, Manojlo Pekovic wrote:
>> From: Manojlo Pekovic <mpekovic@example.com>
>>
>> Extract atomic capability checking logic into a separate function
>> vfio_get_atomic_cap() for better code organization and reusability.
>>
>> Signed-off-by: Manojlo Pekovic <mpekovic@example.com>
> 
> Don't you mean "Manojlo Pekovic <manojlo.pekovic@amd.com>"?
> 
>> ---
>>    hw/vfio/pci.c | 53 ++++++++++++++++++++++++++++++---------------------
>>    1 file changed, 31 insertions(+), 22 deletions(-)
> 


