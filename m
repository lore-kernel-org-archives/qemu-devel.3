Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E274CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 03:37:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMdvK-0004jX-SD; Mon, 11 May 2026 23:36:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMdvI-0004is-44
 for qemu-devel@nongnu.org; Mon, 11 May 2026 23:36:45 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMdvD-0004ap-FQ
 for qemu-devel@nongnu.org; Mon, 11 May 2026 23:36:43 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso57196825e9.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 20:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778556995; x=1779161795; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wXsxfuaOUblnbZsXIm56pA6hishhSFvyCAfhvItsa2c=;
 b=IAralr6fC9Aec0XKqqpwqk5x4MgsDObh+N9vLW7dOBIRwyv2MiqYOzW0wRfF7W7HtX
 8MixXZrwFEc+x6IsOMN5gCnZOO6ntJMhSfaiKrvy4jGIWPhlhaXpycJ6Bfrx4T5RuZXC
 V10XVHbEvw1fFJND2jyL/VAa+dcijMjQTVybJ0z7IEBxPQawULfUypabSAmbM+ey2YEQ
 IOsfwuFf9iOvHkF9BdLyAfc8DB5EfvpOtZlo8qVra8ZSROsM29AQ3G2gLHQwnyj9ScFC
 8alWJy6EtxKO8OD1rusruQmpOtsw1tdTGAdgadDt0vSoBM0rOsjet1Dlc54UUxAjWXwj
 PxHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778556995; x=1779161795;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wXsxfuaOUblnbZsXIm56pA6hishhSFvyCAfhvItsa2c=;
 b=YZgt6ktTkAkEY+Oj5G/q2K4iR5Z5T8s55mOfndUcPWwr0TYXJWyuh+BM/JJV3MsjSg
 xEfTtNbN6rh12CouupIx92XvT9w62CwWzXhELMy61AinBcSBpnA//oAQMna/Ewhf0+9O
 xNK4SvMBuDz+GnPDRImuR3HEoWrM6iBus4McMck8J8SEnHUfnYry3u7NE8JoiuU8Sw28
 lGFTYAd2d19v0ejqSMVTmzALpoKkjBeSKVl8Wbhgyu9Whg+qHDSYa93PNESLfVRV+tnL
 /qEDG6wrVQozmKLSH0V6ChwoCI4TtJHIX0X7rlWQKMbp2JwkH1f4ungVaTKzrSk9frOc
 8ZGQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+OLBFi/WYsGa3VUfPKX2WM9AQC6XDpx10GItg/I9sVcwXUVQ5ysXxLfM0ogLWWODxf/I3uik5dCaQk@nongnu.org
X-Gm-Message-State: AOJu0Yzmbu3w4dUPERIDBsdKXbIOOgExnYZ5ggNEHaxghplqyeQPUWTO
 FjAMtsKz8PIKBL/SlXnw70gDtzyaYIjVKpdGRnu678z1g5IYKAN/wbktwkvzOT00XVo=
X-Gm-Gg: Acq92OELLk6krpCDX41jGiIawSfvqd8RddG8XQNY9+X+h+SM/hMU/Nw+FQvcx7plUq3
 ur3LM52vT3xrLiy6/BNVcMDqfppM+WKtyGSh5gt7EtRVA8L034vgZrpKj8bRMYp98t6rGztMZPW
 5Ub6H3docfpFn0A8qj5ACXyItpFO4aMRxqcJyiCJjXshWNQCgsUdQFulPsiARPjGoVvP7r0Z2+U
 GBCcjX/JxeOoeRGjNh6ZdPuxER6MFco2GDJ+9/3E45Yj5odvtyHsNmDLI7U8gzj3tv/9uOFnAKJ
 IbkTutLOAxv1knFuipcCY41Y/f6Ejmfnljql/q+kTSlg6al5M+BVZwRofw6EWAi9yQfw6sY6eAw
 ljNJZU40TtnkJtPiFSyNJrUkPS5/h3KPlMCpu9qAkDxvQJpRGpbC5WyY7zdHhjXmfjWktoMZDmd
 /ddzhK1PDeNq4fIygpNYkrbATZGIQRMtXeplf5LgZGetIaazdUy5E3c5c1Lirq62l7PQ==
X-Received: by 2002:a05:600c:4ba3:b0:48a:5ee0:7781 with SMTP id
 5b1f17b1804b1-48e8e2195b0mr16488455e9.16.1778556995427; 
 Mon, 11 May 2026 20:36:35 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45491ca383asm28980429f8f.28.2026.05.11.20.36.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 20:36:34 -0700 (PDT)
Message-ID: <c4ba13b3-6e7f-45f0-9f4a-ebe2f7415f34@linaro.org>
Date: Tue, 12 May 2026 05:36:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 089/110] target/s390x: Introduce common system/user meson
 source set
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Farhan Ali <alifm@linux.ibm.com>
References: <20260506135524.20617-1-philmd@linaro.org>
 <20260506135524.20617-90-philmd@linaro.org>
 <5b1fd1f6-00ec-4575-9609-845218405403@redhat.com>
 <a57d5120-dabf-4953-a680-a9c875ecf238@linaro.org>
 <49384318-3050-46fd-af06-4b5c0a14699b@oss.qualcomm.com>
 <dbd55bb5-392b-4a8e-b332-bc009b99014d@redhat.com>
 <5c5e992b-e093-462c-999b-47ff0e5c07ef@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <5c5e992b-e093-462c-999b-47ff0e5c07ef@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 11/5/26 23:07, Pierrick Bouvier wrote:
> On 5/11/2026 1:46 PM, Cédric Le Goater wrote:
>> On 5/11/26 19:59, Pierrick Bouvier wrote:
>>> On 5/11/2026 10:48 AM, Philippe Mathieu-Daudé wrote:
>>>> On 11/5/26 17:48, Cédric Le Goater wrote:
>>>>> Hello,
>>>>>
>>>>> On 5/6/26 15:55, Philippe Mathieu-Daudé wrote:
>>>>>> Introduce a source set common to system / user. Start it
>>>>>> with the files built in both sets: 'cpu_models_user.c'
>>>>>> and 'gdbstub.c' No logical change intended.
>>>>>>
>>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>>> Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
>>>>>> Message-Id: <20260423135035.50126-4-philmd@linaro.org>
>>>>>
>>>>> This change introduced a regression with PCI passthrough which
>>>>> stopped working. Guest kernel reports :
>>>>>
>>>>>      [    0.156501] zpci: PCI is not supported because CPU facilities 69
>>>>> or 71 are not available
>>>>>
>>>>> and other devices (ap, ccw) are impacted too I think.
>>>>
>>>> Is it something we could test with the mainstream CI, or does this
>>>> requires specific hardware?
>>>>
>>>
>>> It could be tested with a tcg arm vm + nested VM with PCI passthrough.
>>
>> Yes, adding VFIO tests to the QEMU upstream CI would be great.
>>
>>> However, the problem is that you need to cross-compile QEMU in CI to
>>> test current version to launch the nested VM.

I guess remember one of your scripts close to that setup, mounting
the same directory in nested guest with:

   -virtfs \
    local,path=$(pwd),mount_tag=host,security_model=mapped,readonly=off

Same could be used with s390x / x86 I suppose.

