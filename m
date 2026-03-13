Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD21F106FD90
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 06:45:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0wGN-00054z-Tp; Fri, 13 Mar 2026 02:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1w0wGG-00054X-6c
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:44:40 -0400
Received: from 5.mo533.mail-out.ovh.net ([54.36.140.180])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1w0wG6-00076V-0n
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:44:33 -0400
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net [152.228.215.222])
 by mo533.mail-out.ovh.net (Postfix) with ESMTPS id 4fXFMQ3WrFz64Tf;
 Fri, 13 Mar 2026 06:44:18 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net. [127.0.0.1])
 by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Fri, 13 Mar 2026 06:44:18 +0000 (UTC)
Received: from mta2.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.188.32])
 by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4fXFMQ2V3lz5vbp; Fri, 13 Mar 2026 06:44:18 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.7])
 (Authenticated sender: clg@kaod.org)
 by mta2.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 172169414C4; 
 Fri, 13 Mar 2026 06:44:17 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-103G0056bcb4c63-77fc-48c6-a3aa-8b637a209d4a,
 0AE3076C2B397DF7A4035413C8C766C19C560709) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <2b8f6063-f03f-47f1-bf52-a8dc14a558fc@kaod.org>
Date: Fri, 13 Mar 2026 07:44:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] Support HACE to AST2700 (resend)
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Kane Chen <kane_chen@aspeedtech.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20250225075622.305515-1-jamin_lin@aspeedtech.com>
 <675766c2-4015-43e8-b070-d58f2cdd23e7@kaod.org>
 <SEYPR06MB5037484B224FD0F3DE53B117FCD02@SEYPR06MB5037.apcprd06.prod.outlook.com>
 <588b3b38-172a-493f-a842-5a2fb5796391@kaod.org>
 <TYPPR06MB820670804B45D43A63786043FC45A@TYPPR06MB8206.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <TYPPR06MB820670804B45D43A63786043FC45A@TYPPR06MB8206.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 12844829091227610123
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEGIfdFI+OFZVgV/tvTZ2yz7ampqjW5TZZ5qTFODiX529cibMEu0ozf9p41q/2uQEjOuMpCZFl9QT7rXtdWDrWBgxHxRgN7soK/gqzj6U1kxXH/m86exxgiiO0Pm9vt7vVd9WYzByDuSjrH7uelAmPj3KN3BXVfKWPA6smVfUGJkKj9xMR3l34lZdpk9CIB6n8z5Q6EP8KuWp8W9OOxdMduuFhUFvgiloYqFnJn0xW3j9dfEhActRZyRFcNQKUbh/zfSSmLzt4XDqBShgmCamj1hGnTjyvYhtjyOHKNwTITJlzN7lTstORkJ5iqxpkdAfs/o/4A7ReZqP8DhZIQLKnGqrMMwLDfXQEIuq8A/TqN/2n+uZlegAaaY6axMtvMYbdhrYjXLWIqqiDVuY1YDwbLiCNgjg8AyxuuQp8rExCPX40+btvKIm6KWZRDYmmef9kVV4bqb+7bJ1zE9gWp4HoseRRuo0Alwc9BmaK006tylvrMp1Cje+pbZ1hyDQRrpokfIHDUtPM4dsfTSX27Ng6JHKy64Q6uo4GSGU1xD10s2+uCc9/bmtThTc4IgPwwv90PSA4PnOWWeAi8UNET9mvR3nPMMs1N3mUf7mcOnLPYe6LbaTK04Ze15/U9+EzcsLEkiD/7evYTu4uzYHQN6AIaTWYkxvcaY8H3h6PGOuy+xg
DKIM-Signature: a=rsa-sha256; bh=46YUNvjXcl26/o+y9gPjWcHAR1iymn+X+PZO1N4iiFc=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1773384260; v=1;
 b=aBbPm6hUp4X+2icakXeCLBRc7SEApLJ3zmkhZM/ekpvLXrYCoTQvGLqPVEeVzY8/7p9cBodh
 wyaszqCSvEmoEK3aR/SZaNriBrAE8sm1y7JiiLS7D4ejKMI5QChnhoWA6iBszNNDkAX74HuHguq
 6oYF/WIOITjUxbZXvT3AquggLGqSz6R9jt0/ujrR5wfdyiuV04vxBdtrgGsVphS9bxsjMet3+o/
 tH8qakNEqyMSppStek4CHAKSrNxITw/EseQMe6SeQg5yuhFx1t9dnHHiMAWGRHDEPRUe7Tdk1Ib
 C4mXmqWl5afx/EqlfvblVvUHn5Ghrt7vIiwrLz87VLB4w==
Received-SPF: pass client-ip=54.36.140.180; envelope-from=clg@kaod.org;
 helo=5.mo533.mail-out.ovh.net
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/13/26 02:35, Jamin Lin wrote:
> + Kane
> 
> Hi Cedric,
> 
>> Subject: Re: RE: [PATCH v4 0/4] Support HACE to AST2700 (resend)
>>
>> Hello Jamin,
>>
>> On 3/12/25 10:32, Jamin Lin wrote:
>>> Hi Cedric,
>>>
>>>> -----Original Message-----
>>>> From: Cédric Le Goater <clg@kaod.org>
>>>> Sent: Wednesday, March 12, 2025 5:25 PM
>>>> To: Jamin Lin <jamin_lin@aspeedtech.com>; Peter Maydell
>>>> <peter.maydell@linaro.org>; Steven Lee <steven_lee@aspeedtech.com>;
>>>> Troy Lee <leetroy@gmail.com>; Andrew Jeffery
>>>> <andrew@codeconstruct.com.au>; Joel Stanley <joel@jms.id.au>; open
>>>> list:ASPEED BMCs <qemu-arm@nongnu.org>; open list:All patches CC here
>>>> <qemu-devel@nongnu.org>
>>>> Cc: Troy Lee <troy_lee@aspeedtech.com>
>>>> Subject: Re: [PATCH v4 0/4] Support HACE to AST2700 (resend)
>>>>
>>>> Jamin,
>>>>
>>>> On 2/25/25 08:56, Jamin Lin wrote:
>>>>> This patch series is from
>>>> https://patchwork.kernel.org/project/qemu-devel/cover/20250213033531.
>>>> 336
>>>> 7697-1-jamin_lin@aspeedtech.com/.
>>>>> To expedite the review process, I have separated the HACE patches
>>>>> portion from the
>>>> https://patchwork.kernel.org/project/qemu-devel/cover/20250213033531.
>>>> 336 7697-1-jamin_lin@aspeedtech.com/ patch series into this new patch
>>>> series.
>>>>>
>>>>> v4: Support HACE to AST2700
>>>>>
>>>>> Jamin Lin (4):
>>>>>      hw/misc/aspeed_hace: Fix coding style
>>>>>      hw/misc/aspeed_hace: Add AST2700 support
>>>>>      hw/arm/aspeed_ast27x0: Add HACE support for AST2700
>>>>>      hw/misc/aspeed_hace: Fix boot issue in the Crypto Manager Self
>>>>> Test
>>>>>
>>>>>     include/hw/misc/aspeed_hace.h |  2 ++
>>>>>     hw/arm/aspeed_ast27x0.c       | 15 ++++++++++
>>>>>     hw/misc/aspeed_hace.c         | 55
>>>> ++++++++++++++++++++++++++++++++---
>>>>>     3 files changed, 68 insertions(+), 4 deletions(-)
>>>>>
>>>>
>>>> The kernel reports a lot of errors when running the crypto tests on a
>>>> AST2700 A1 Soc. See the functional test logs :
>>>>
>>>>        $ grep alg:
>>>> build/tests/functional/aarch64/test_aarch64_aspeed.AST2x00MachineSDK.
>>>> test _aarch64_ast2700a1_evb_sdk_v09_05/console.log
>>>>
>>>>        2025-03-12 10:10:42,705: [    2.206831] alg: skcipher:
>> aspeed-ctr-tdes
>>>> encryption test failed (wrong result) on test vector 0, cfg="in-place (one
>> sglist)"
>>>>        2025-03-12 10:10:42,706: [    2.207328] alg: self-tests for
>>>> ctr(des3_ede) using aspeed-ctr-tdes failed (rc=-22)
>>>>        2025-03-12 10:10:42,707: [    2.207894] alg: self-tests for
>>>> ctr(des3_ede) using aspeed-ctr-tdes failed (rc=-22)
>>>>        2025-03-12 10:10:42,725: [    2.219342] alg: skcipher:
>> aspeed-ctr-des
>>>> encryption test failed (wrong result) on test vector 0, cfg="in-place (one
>> sglist)"
>>>>        2025-03-12 10:10:42,725: [    2.219511] alg: self-tests for ctr(des)
>>>> using aspeed-ctr-des failed (rc=-22)
>>>>        2025-03-12 10:10:42,725: [    2.219651] alg: self-tests for ctr(des)
>>>> using aspeed-ctr-des failed (rc=-22)
>>>>        2025-03-12 10:10:42,733: [    2.224344] alg: skcipher:
>> aspeed-ctr-aes
>>>> encryption test failed (wrong result) on test vector 0, cfg="in-place (one
>> sglist)"
>>>>        2025-03-12 10:10:42,734: [    2.224775] alg: self-tests for ctr(aes)
>>>> using aspeed-ctr-aes failed (rc=-22)
>>>>        2025-03-12 10:10:42,734: [    2.225015] alg: self-tests for ctr(aes)
>>>> using aspeed-ctr-aes failed (rc=-22)
>>>>        ...
>>>>
>>>> What is something missing in the models ?
>>>>
>>>
>>> Currently, we do not implement HACE/CRYPT in aspeed_hace.c.
>>> https://patchwork.kernel.org/project/qemu-devel/patch/20250225075622.3
>>> 05515-5-jamin_lin@aspeedtech.com/
>>>
>>> Known Issue:
>>> The HACE crypto and hash engine is enable by default since AST2700 A1.
>>> However, aspeed_hace.c(HACE model) currently does not support the
>> CRYPTO command.
>>> To boot AST2700 A1, created a patch which temporarily resolves the
>>> issue by sending an interrupt to notify the firmware that the
>>> cryptographic command has completed. It is a temporary workaround to
>>> resolve the boot issue in the Crypto Manager SelfTest.
>>>
>>> As a result, you will encounter the following kernel warning due to
>>> the Crypto Manager test failure.
>>>
>>> ```
>>> alg: skcipher: aspeed-ctr-tdes encryption test failed (wrong result) on test
>> vector 0, cfg="in-place (one sglist)"
>>> [    5.035966] alg: self-tests for ctr(des3_ede) using aspeed-ctr-tdes failed
>> (rc=-22)
>>> [    5.036139] ------------[ cut here ]------------
>>> [    5.037188] alg: self-tests for ctr(des3_ede) using aspeed-ctr-tdes failed
>> (rc=-22)
>>> [    5.037312] WARNING: CPU: 2 PID: 109 at /crypto/testmgr.c:5936
>> alg_test+0x42c/0x548
>>> [    5.038049] Modules linked in:
>>> [    5.038302] CPU: 2 PID: 109 Comm: cryptomgr_test Tainted: G
>> W          6.6.52-v00.06.04-gf52a0cf7c475 #1
>>> [    5.038787] Hardware name: AST2700-EVB (DT)
>>> [    5.038988] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS
>> BTYPE=--)
>>> [    5.039315] pc : alg_test+0x42c/0x548
>>> [    5.039505] lr : alg_test+0x42c/0x548
>>> [    5.039697] sp : ffffffc0825e3d50
>>> [    5.039862] x29: ffffffc0825e3df0 x28: 0000000000000004 x27:
>> 0000000000000000
>>> [    5.040226] x26: ffffffc080bcada0 x25: ffffffc081dac9d0 x24:
>> 0000000000000004
>>> [    5.040700] x23: 0000000000001285 x22: ffffff8003ded280 x21:
>> ffffff8003ded200
>>> [    5.041458] x20: 00000000ffffffff x19: 00000000ffffffea x18: ffffffffffffffff
>>> [    5.041915] x17: 282064656c696166 x16: 20736564742d7274 x15:
>> 00000000fffffffe
>>> [    5.042287] x14: 0000000000000000 x13: ffffffc081ba555c x12:
>> 65742d666c657320
>>> [    5.042684] x11: 00000000fffeffff x10: ffffffc0818ff048 x9 :
>> ffffffc0800a36e4
>>> [    5.043077] x8 : 000000000017ffe8 x7 : c0000000fffeffff x6 :
>> 000000000057ffa8
>>> [    5.043461] x5 : 000000000000ffff x4 : 0000000000000000 x3 :
>> 0000000000000000
>>> [    5.043751] x2 : 0000000000000000 x1 : 0000000000000000 x0 :
>> ffffff800415e740
>>> [    5.045544] Call trace:
>>> [    5.045693]  alg_test+0x42c/0x548
>>> [    5.045878]  cryptomgr_test+0x28/0x48
>>> [    5.046052]  kthread+0x114/0x120
>>> [    5.046226]  ret_from_fork+0x10/0x20
>>> [    5.046413] ---[ end trace 0000000000000000 ]---
>>> [    5.071510] alg: skcipher: aspeed-ctr-des encryption test failed (wrong
>> result) on test vector 0, cfg="in-place (one sglist)"
>>> [    5.072145] alg: self-tests for ctr(des) using aspeed-ctr-des failed
>> (rc=-22)
>>> ```
>>
>> This is a bit confusing for people running the tests, since it might be considered
>> as a regression in the models. I understand it is interesting for real HW and so,
>> it would good to complete the implementation of the QEMU models too or,
>> may be, we could deactivate the tests from the kernel command line ? if
>> possible.
>>
>> Thanks,
>>
> 
> We plan to implement the "HACE/CRYPT commands", which should resolve these kernel warnings.
> However, according to the kernel self-test report, the kernel attempts to test several crypto modes
> "that are currently not supported by QEMU crypto/cipher.c such as CFB (Cipher Feedback) and OFB(Output Feedback)"
> 
> root@ast2700-default:~# dmesg | grep "self-tests"
> [    5.312232] alg: self-tests for ctr(des) using aspeed-ctr-des failed (rc=-22)
> [    5.314913] alg: self-tests for ctr(des) using aspeed-ctr-des failed (rc=-22)
> [    5.316347] alg: self-tests for ctr(des3_ede) using aspeed-ctr-tdes failed (rc=-22)
> [    5.321167] alg: self-tests for ecb(des) using aspeed-ecb-des failed (rc=-22)
> [    5.321622] alg: self-tests for ecb(des) using aspeed-ecb-des failed (rc=-22)
> [    5.343443] alg: self-tests for ctr(des3_ede) using aspeed-ctr-tdes failed (rc=-22)
> [    5.358788] alg: self-tests for ecb(des3_ede) using aspeed-ecb-tdes failed (rc=-22)
> [    5.359267] alg: self-tests for ecb(des3_ede) using aspeed-ecb-tdes failed (rc=-22)
> [    5.541477] alg: self-tests for cbc(des) using aspeed-cbc-des failed (rc=-22)
> [    5.541888] alg: self-tests for cbc(des) using aspeed-cbc-des failed (rc=-22)
> [    5.561193] alg: self-tests for cbc(des3_ede) using aspeed-cbc-tdes failed (rc=-22)
> [    5.561645] alg: self-tests for cbc(des3_ede) using aspeed-cbc-tdes failed (rc=-22)
> [    5.629708] alg: self-tests for cbc(aes) using aspeed-cbc-aes failed (rc=-22)
> [    5.630234] alg: self-tests for cbc(aes) using aspeed-cbc-aes failed (rc=-22)
> [    5.640356] alg: self-tests for ctr(aes) using aspeed-ctr-aes failed (rc=-22)
> [    5.641544] alg: self-tests for ctr(aes) using aspeed-ctr-aes failed (rc=-22)
> [    5.653529] alg: self-tests for ecb(aes) using aspeed-ecb-aes failed (rc=-22)
> [    5.654212] alg: self-tests for ecb(aes) using aspeed-ecb-aes failed (rc=-22)
> 
> I asked our BSP team several times if they could disable the crypto self-tests, but they rejected the request.
> Their reason is that they want to validate our hardware crypto engine during kernel startup in the ASPEED SDK.

yes it makes sense.

> If you prefer not to see these kernel warnings, I can add the following kernel boot parameter in the functional test environment:
> bootargs=console=ttyS12,115200n8 root=/dev/ram rw earlycon cryptomgr.notests=1

Given the number of warnings in the kernel, I think we should rely
on the unit tests tests/qtest/ast2700-hace-test.c only and drop
the kernel tests to reduce confusion.

Once the QEMU (Aspeed HACE and crypto) implementation has made
progress, we should reassess.

Thanks,

C.



