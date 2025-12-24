Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89FC1E75448
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 10:52:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYMT1-0000Rd-8j; Wed, 24 Dec 2025 05:51:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYMSz-0000R9-Lk
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 05:51:41 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYMSw-0002OY-U3
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 05:51:40 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-42fb0fc5aa9so2512956f8f.1
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 02:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766573494; x=1767178294; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kQg6NcXMuNwigkUSWfWB7OEOiX5Vrdhh+lMXZvVV0ms=;
 b=dpWFUFZnPgCKx6F5zUdqrsOPO/rS+JFhIZDRdoB5pH/BZp9Xqkg+TLRERpgA4rsWOR
 r6KlZbTh+hTfT5OxTd9fNAyqrT2ulOHgReejm88KcHvRqPXuNP7KPaFH9yFr75L/cIxL
 2CF+hLcoqVytvwjbLf/NVxwVnxfNvlsa0HO0OvZpwxbIIdbZuwiPIza5n+ll51Xh/Yhn
 uIYcsVSMiuFr1EKJNlmC5Z1SRRq0I/DYz4q9Zd7lutJpR4YBWH8/EnfwVEY0yvbDnCYt
 PLacRpkmFYlbekZnbmvJLFQPOTYB3G4ZN3PMY2z6jHxvMyFZDAamojbgQpHVm+4dRshL
 jkdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766573494; x=1767178294;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kQg6NcXMuNwigkUSWfWB7OEOiX5Vrdhh+lMXZvVV0ms=;
 b=CKai4R35x5MdXPd03Oh2k864DN8eLHO/Qb95r2csolTYOAf/AZtpxktAfAyxUiYriK
 riWUSBHuqJZqDVa7w8AksMm87J9FruXuyUTmIuKRERDzb69emYTyZK8sWNEwrtOiL/vm
 2o3l6100xjcaT/CtJSQfQOEbeoRvcJ8SjImfIowOxX76dSwXVkwpOhJAS1f3TBtIZIs8
 2Qv2WriVohspZgYFcs6NVZshyU/JPuatn2lsc6DIaAjnoy1X0MeUDIJEPkM/+JP/AWWg
 g87JPe7LLkIiTEdC3eNZiHXZ6mz+pzY6bRMdHwWvJSQudLYEnfUSk/fhS3ujEwHN49yH
 m0fg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZ1uGAVWG9YrMGvAi5JaTvHArgSNxxmIFmhKReFrSLhAf2MhYZ5G+VN1LM7ffSVfeNFu8gGzN2533a@nongnu.org
X-Gm-Message-State: AOJu0YyBW0jdIwdcnH323G1k22fNqdga+qHBiW14MNZlj6d2USpo+k+O
 HCpZyEvJjQUdGZfwa4GVVwOMWX8NrHA9B3vqEF//ioB8cDPgbyp/QbAmySpvDhgZ1qw=
X-Gm-Gg: AY/fxX5xtJDNNArZjq3QXMBYFyLAh2bjKezaj17DXK68+FRiqVK0NSLWBFr5aS65Fsm
 LOevR/IuXI5TTInSzK4UdZugxomd69JsWvc8CNYLVixYc6toxshbcKu4G3wEJAwzqlnVhMpaSzH
 zlFWLeBdvTiNTgVp6bb5nwU3wSUYRCiDGu4rkNw76O1qwk8YrnKGclTgDJxpx/NBMNlWrEYzOYT
 JS2Qkg+Z5jgDt5na9ChdO7rNPliI8Mpuo0o1bVhOjMhU031ueTDY2i7HtTdfYd3nEbAwORcgf1j
 dmC/l15UHGPTJ1XXnlBFo/pAky5W/7cM838WhCgnr894XkvfKLzip9bYtkoD+IBRS/OdYaamL5r
 FuYuKF8gagDO7kVzR1iLtHyCa92fQgiCSMmTDGUS3bce6Q9uKUfkRvenQvwOsMjlcgfSNx6n9eO
 M+KxT4ztTiQFNhdarWE6nSP+mMWm2F/MKbQwBq0i4MC/tJdLTKojt2uL0Vbk6/gKgA
X-Google-Smtp-Source: AGHT+IE0kuaeG3llP3NNo0kraisXU7QL7/FRBWZiPBQKV/Wkmz7H6Am5mpES9oQlZqr3IRX8L4RNPw==
X-Received: by 2002:a5d:64e9:0:b0:430:f58d:40da with SMTP id
 ffacd0b85a97d-4324e4c68d6mr18982687f8f.10.1766573493478; 
 Wed, 24 Dec 2025 02:51:33 -0800 (PST)
Received: from [192.168.69.202] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa46c0sm33882505f8f.34.2025.12.24.02.51.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Dec 2025 02:51:32 -0800 (PST)
Message-ID: <589ced7e-0ad5-45cc-984a-102552cc8b5e@linaro.org>
Date: Wed, 24 Dec 2025 11:51:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Fix URL of gb200nvl-bmc image
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Ed Tanous <etanous@nvidia.com>,
 Patrick Williams <patrick@stwcx.xyz>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20251222073351.166720-1-clg@redhat.com>
 <100505ae-4d33-4bd4-800b-6ab21b99738a@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <100505ae-4d33-4bd4-800b-6ab21b99738a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 22/12/25 13:52, Cédric Le Goater wrote:
> On 12/22/25 08:33, Cédric Le Goater wrote:
>> Commit [1] moved the FW image of the gb200nvl-bmc machine and broke
>> the associated functional test. Fix that.
>>
>> [1] https://github.com/legoater/qemu-aspeed-boot/ 
>> commit/52451b2472eeb40aa97e131aeea327e9d4a8a78a
>>
>> Cc: Ed Tanous <etanous@nvidia.com>
>> Cc: Patrick Williams <patrick@stwcx.xyz>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   tests/functional/arm/test_aspeed_gb200nvl_bmc.py | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tests/functional/arm/test_aspeed_gb200nvl_bmc.py b/tests/ 
>> functional/arm/test_aspeed_gb200nvl_bmc.py
>> index 8e8e3f05c1b2..e5f2dce0f569 100755
>> --- a/tests/functional/arm/test_aspeed_gb200nvl_bmc.py
>> +++ b/tests/functional/arm/test_aspeed_gb200nvl_bmc.py
>> @@ -11,7 +11,7 @@
>>   class GB200Machine(AspeedTest):
>>       ASSET_GB200_FLASH = Asset(
>> -        'https://github.com/legoater/qemu-aspeed-boot/raw/refs/heads/ 
>> master/images/gb200nvl-obmc/obmc-phosphor-image-gb200nvl- 
>> obmc-20250702182348.static.mtd.xz',
>> +        'https://github.com/legoater/qemu-aspeed-boot/raw/refs/heads/ 
>> master/images/gb200nvl-bmc/openbmc-20250702182348/obmc-phosphor-image- 
>> gb200nvl-obmc-20250702182348.static.mtd.xz',
>>           
>> 'b84819317cb3dc762895ad507705978ef000bfc77c50c33a63bdd37921db0dbc')
>>       def test_arm_aspeed_gb200_openbmc(self):
> 
> Applied to aspeed-next.

Thanks, this is part of the 2 build failures blocking current pull
requests (other one being
https://lore.kernel.org/qemu-devel/20251224085714.83169-1-philmd@linaro.org/).

If we really want to consider our CI as source of truth (and blocking
when not green), then please consider applying it directly on master
as a build fix (maintainers Cc'ed).

Regards,

Phil.

