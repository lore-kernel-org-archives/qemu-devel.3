Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B9A9CD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:19:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzvE-0000Y3-S2; Fri, 15 May 2026 17:18:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wNzv2-0000Vu-Co
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:18:07 -0400
Received: from smtpout4.mo534.mail-out.ovh.net ([188.165.54.92])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wNzuz-00020s-EB
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:18:04 -0400
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net [152.228.215.222])
 by mo534.mail-out.ovh.net (Postfix) with ESMTPS id 4gHKmM58Prz6NNb;
 Fri, 15 May 2026 21:17:55 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net. [127.0.0.1])
 by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Fri, 15 May 2026 21:17:55 +0000 (UTC)
Received: from mta6.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.113.54])
 by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4gHKmM4CP0z5vcn; Fri, 15 May 2026 21:17:55 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.4])
 (Authenticated sender: clg@kaod.org)
 by mta6.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id B56C81B43B20;
 Fri, 15 May 2026 21:17:53 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-112S0064e93ffbf-45c4-49d2-aa66-4f8156d14cc6,
 EA554B2574883C805624521E1FD22DE9D7B94BA5) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 90.14.253.154
Message-ID: <3c55962b-cd03-4728-8442-c895f7e8d132@kaod.org>
Date: Fri, 15 May 2026 23:17:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/20] hw/arm/aspeed: Initialize 64-bit CPU types
 during DeviceRealize()
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Kane Chen <kane_chen@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260515141032.3271-1-philmd@linaro.org>
 <20260515141032.3271-5-philmd@linaro.org>
 <e8e1d0f8-b5b9-49a3-9478-f58f72e962e7@kaod.org>
 <99983366-9174-40cf-a158-a663daa7965f@oss.qualcomm.com>
 <3db1823e-bdb3-4801-81a0-dc901bf75655@kaod.org>
 <64a611a9-a509-412b-8ff4-5bcd85348b97@oss.qualcomm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <64a611a9-a509-412b-8ff4-5bcd85348b97@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 10196993981808290931
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFZmr+SgvfSvI2h1llvsCEVhFwoIcMiwV4qoZpFkSaCEQAng1OyjPF8VZVRq6S8z/PdR5tlii6+PwVw1b/7KhHqc6tS0PxcspKjxkiu4xFH8LrU4Lh5wk8DJ3OMT1jP8nZC3uEp30n29OeUvpfxmhhkROmXDsaccnIeDEc3qzdcNrGbconHjisQkwgyVTNyNGk4eCELlUsrt0Fjy1N677E34UZm0arokOxskYlRJ66GwNOahdI2Nvm5RJ3rXVWXJ9Yw7FJlHnhUQkiBhUhPUCyew33CYO9dkTXVFKPEidxP9+/G0Xf2BNTIo72eQ28k2UJ+wWgMZQklpLTHBSo5c9Tkk7VhmE0KajvzFimeKXdQR6/h+W2DJQMwHd5VHCyukAyDPdr85TLXouJaadDA9tJatj/kLmgOyudXb3gvNQrrh8Bvlx9XRc3zTqWiPlkj/OJp4DB1JM4YtNpnBZWimPTJrFNtbcEkp/Xt8GYtfnSZW1H/IqGfZ5gJV/nU9DkuiCOFZg+1KoglSOSZXuZ8zO/tyBXwe86OlSE0oFyuwb40hXrbFB0JLmWmCUiyyqWSg9PFpqSfstauMNVFXoEXLFcho2ShWv8KmWZYWVRaol787P47KVP4MAi+4QI6uEDtEIhX46l3LSM9yrT7W5chTSsXrZLt8C1wW0/k/CdbydUQ7A
DKIM-Signature: a=rsa-sha256; bh=RwDYReVfK9HFm8pKnirKcqe+shbZV7YOMK+9Dy+QQVs=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1778879877; v=1;
 b=LaH4p+paubjXa1wwUvicWBivX0qzb4NWPzklrz4V4lWslu0MARkZfl0/PoS2yE2rA3+BVVRI
 ohi7+omXu5UT94opmm4FxINEANCST2pTguTlPGj7d1L9VM2JkJ/SwAcfJnpLGRuuQUejqG1BS/X
 Cy4vOy2+c8IwxyO9c5PMG8gUDHxQmXquHMz79UKVwWn8zNF9D9mecKlbuNjIabGKPF0tKpmL4xT
 gx8m1/cfPzeC4TABRQoLtQ2DT6P9GnO8zR/AtE+5ji43rx0oIZjUlASno1xkg/+kJKbpUuGQffO
 j5z4QfCfOxwCw9SwTMXgBrnlS6NjzhMKlJMYBrf5HxcJw==
Received-SPF: pass client-ip=188.165.54.92; envelope-from=clg@kaod.org;
 helo=smtpout4.mo534.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 5/15/26 19:22, Pierrick Bouvier wrote:
> On 5/15/2026 10:18 AM, Cédric Le Goater wrote:
>> On 5/15/26 19:00, Pierrick Bouvier wrote:
>>> On 5/15/2026 9:29 AM, Cédric Le Goater wrote:
>>>> On 5/15/26 16:10, Philippe Mathieu-Daudé wrote:
>>>>> aspeed_ast27x0.c models 2 similar SoC based on a 64-bit only
>>>>> CPU (Cortex-A35), only available in the 64-bit binary.
>>>>>
>>>>> If we build this file as common object, these SoCs become
>>>>> available in both 32 and 64-bit binaries; however when running
>>>>> the introspection test on the 32-bit binary, the init() method
>>>>> tries to init the Cortex-A35 type -- although not realizing it
>>>>> -- which is not available. This can be avoided by deferring the
>>>>> CPU type initialization to the SoC DeviceRealize step (this is
>>>>> safe because nothing uses the CPU type before, only the GIC
>>>>> access them, just after their realization).
>>>>
>>>> I understand this is a qtest workaround. Could we introduce
>>>> instead a (qtest_enabled() && 32-bit binary) helper ?
>>>>
>>>
>>> In general, it exposes a dependency issue in QOM type system.
>>> In this case, we get a class depending on another one through
>>> class_init. Moving this to realize seems like the best fix.
>>
>> My feeling is that this goes against the best modeling practices
>> we have tried to put in place over the last decade.
>>
> 
> In this case, adding the workaround you suggested might be the best
> approach indeed.


Well, if we want to make progress, let's at least add a comment
for better fix later.

C.

