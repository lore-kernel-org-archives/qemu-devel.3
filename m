Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEE10C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 14:50:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTNWX-0000qB-Rk; Fri, 26 Jan 2024 09:49:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rTNWW-0000q2-3i
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:49:40 -0500
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rTNWT-0003UW-WB
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:49:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1706280574; x=1706885374; i=deller@gmx.de;
 bh=8nE6tj1b5/7KH9O1f6Qm/JzH4fthb2UfdIse6tNfI7E=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=W4s2bIjoO2T2jnfiysMt3SQxPIGgaFruPClvVOxPeF3aKqSwzxc8tkfnV5nO9lWe
 E8ad+42kdr6yYa+RM0rNO3VDsR4lAJyAfvo7WAs1aLyovGrbUJ/bOdQsZkHGK3wi+
 ideNlPKyh9EVECgGceU4u9GkSHX6A+mILfRA6WLb2Ss9tteMjqFHsbvTiVe71Mha+
 iFIK7g0SsTXY66D1rk1glD1hQkI+Cqn4AaazIST98Doce/KF75dn3j6Zsu7hsi8dU
 Wd0mkfQphsN81Il9hGT2wWnVceakwf1TM+OZuVyQQ6Zeb2YwBoebN8csgSwtvXYV2
 BqM0IfkIPWJ9dFD5PQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.148.39]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfpOT-1qrazP0dCL-00gGYP; Fri, 26
 Jan 2024 15:49:34 +0100
Message-ID: <7e119eb2-66a5-47bf-81af-f4ca408f740f@gmx.de>
Date: Fri, 26 Jan 2024 15:49:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/9] hw/hppa/machine: Disable default devices with
 --nodefaults option
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>, deller@kernel.org,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20240112102927.35406-1-deller@kernel.org>
 <20240112102927.35406-3-deller@kernel.org>
 <4d7dae131a04b101a864b51cf64b6e8fd9e6366c.camel@infradead.org>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <4d7dae131a04b101a864b51cf64b6e8fd9e6366c.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jH6kfHNdsM64bhVIIRW2uhYTikFilsJ++mXcZ6pDvSI/fx78gIg
 V1hsgjRxLkmRZxzj5yLfcr3qi4hZoEpqgUu3PVswf4xTUKqGqo/DL+k9JDmPbo2wLfBu6vN
 IEcZ5PTdA95AVLzv2oqrn5sW9T9Iwo6rceYMEC5bErJ5SiVBLpZh3yTnEZJSh7DYwdWb4dW
 KPAJukhCcPONKoKvEzgvg==
UI-OutboundReport: notjunk:1;M01:P0:PT4qnlxn4Rc=;49qj/AHxlFXQR/VJb6T8SEzYt8/
 PkQFKK1X9BqTIIdwedpZkNEJVDge4v3tF7HJOm551O0BRhj4nK9JGQQLk13L9oLjybLH1WYQH
 e6OMpmzY7MtITJ33/Yuk+mfAcEyDF6AIWjpB3qPsjqvqkUi4wpiU870EGSNiRxdCoPTQpV/hw
 Cgho0+PY6KoWfTjnGK0kGcjg0P/2jvP0Fwq8POhFsL+t0fq7Gc6mNwTcrM/dLYk1NLv6KwAnr
 IC2SwyNVvsBwswsVDLgAO6L4rlfiuBsCu+sYaP0UIu7HQ7ZsPZPcDFUr8g33SbNch+hvyYk64
 bnXEKyCWTygj85qwqy+xf9rrcy5JPKR8oUFNs0KAAc3gwZEzLE2AFZm/ElI9yrPeec5xCQmkt
 m1F9iHGYmCIA9uSDMjtWhjjnzUOD+QGssMLZQR5F3E8V9PrLY51YlwiuR8L1fUh5K+J8xF2qi
 xfVDelGFi8bJmNipz1s2yCOI37P1YYLJDMofGo7luQBJgQEMoGGQWHGSji3VuJR9LHhffY5lb
 MdleBrdwHcITyhR6T+eEgGrU2UtW9euV8lrsdnyXpfrYtYbNrbHOAnKnXyYL1My6DsmGQs8GR
 oicCbRPPlQibFLXTrfQQOsn2PHuyTOF3+79rcmOhkq/Q3BcWk5iq5zrDRgqPE7YGoAWYxF+hF
 0wUntNhrsXkD2xSN+/FlOoesTa81rV+VX307aNdq1jCFlhMBWZO2H49D6TYaxm3FnxNzw9SOp
 YAKDpYHBmQoxms/n+ecOlQowSmmnsfDHMGu29nIi5qptUbwKbX/fYRjeMp2pILGUtDdGjEdFw
 SR06mFqDCI9ATVyqPr9J8XtcRK+90Gh5Sw7YukwjjcVil8jnq3n88CpoGP8qj/RkS/InocZ6t
 JtTXsBhxXlArC4G0kpf84C6u+gtWCBKkk2D6jboQ51YFcl9mDY8L9dSBOFHxY+1x0L3CmA4dZ
 8/bOrA==
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 1/26/24 13:02, David Woodhouse wrote:
> On Fri, 2024-01-12 at 11:29 +0100, deller@kernel.org wrote:
>> From: Helge Deller <deller@gmx.de>
>>
>> Recognize the qemu --nodefaults option, which will disable the
>> following default devices on hppa:
>> - lsi53c895a SCSI controller,
>> - artist graphics card,
>> - LASI 82596 NIC,
>> - tulip PCI NIC,
>> - second serial PCI card,
>> - USB OHCI controller.
>>
>> Adding this option is very useful to allow manual testing and
>> debugging of the other possible devices on the command line.
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>
> Well, the LASI 82596 hasn't actually been built since 2019, when there
> was a typo in the meson conversion and it started to depend on the non-
> existent CONFIG_LASI_I82596 option instead of CONFIG_LASI_82596.
>
> But that doesn't really matter because enable_lasi_lan() has been
> #defined to zero for hw/hppa/machine.c ever since the LASI support was
> first introduced, so nothing ever tries to instantiate one anyway.

True.
I do have code for LASI_82596 in my github repo, but since
it's not working correctly yet, I haven't pushed it yet upstream.
I do plan to work at it when time permits though..

> As part of the -nic rework=C2=B9 I plan to allow the user to explicitly
> specify "lasi_82596" as the model if they want one, or else the default
> -nic will be a PCI one as it is at the moment. OK?

Yes, that would be great.
Thanks!
Helge

> =C2=B9 https://lore.kernel.org/qemu-devel/20240108204909.564514-1-dwmw2@=
infradead.org/T/


