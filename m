Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC6EC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 20:08:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCPZn-0000uB-SA; Wed, 29 May 2024 16:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1sCPZl-0000ta-Sb
 for qemu-devel@nongnu.org; Wed, 29 May 2024 16:07:10 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1sCPZh-0001uo-Hz
 for qemu-devel@nongnu.org; Wed, 29 May 2024 16:07:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1717013211; x=1717618011; i=deller@gmx.de;
 bh=8i6XG+rmTNGfeIZFEvFeAHAvzReELokswebywUBz7CU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Hs/t9LJk1xUsjLtDRSZaqqNX0PHdZUeof+I6I2Pk0qubZblXwzz88aAPwryEr1x0
 ruSASP0xrrnTdyjFKrqWoE+ccA2Uk+/ZTxMjga54oLV69okDbJJ6g4AepEBJoLnho
 R4chvYy1RKFr7wUcA3NPIjeyQQ2YQJdKK7GVu2c3exCuXg34A/0oHN8+QLAzzuo2W
 n8t4ntVU7H6Q7LrtZwittDZ/W4Vmhj76CeejCUSXRZsk3f+GD/bzkqmyr6vUnHatw
 kx9P4xuPuygxpnr1y5zl6pVUsD0YyAA+Zq3lpnxV+W8Z6rvxoEnk1OcPpIRDCrQa1
 c7HrQhdEr6irIRVMmw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([83.135.217.92]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MO9zH-1rsPq62Bwn-00OY86; Wed, 29
 May 2024 22:06:51 +0200
Message-ID: <69caf556-49eb-47aa-82e6-9d20566271fb@gmx.de>
Date: Wed, 29 May 2024 22:06:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] hppa: Add support for an emulated TOC/NMI button.
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Cc: Sven Schnelle <svens@stackframe.org>, Anton Johansson <anjo@rev.ng>
References: <20220131213529.17404-1-deller@gmx.de>
 <20220131213529.17404-4-deller@gmx.de>
 <c6f9b777-4b6f-a71a-ce90-c08e5313e2a8@amsat.org>
 <d1ded13f-a2bf-4ce0-aabb-22dbdee25ce5@linaro.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <d1ded13f-a2bf-4ce0-aabb-22dbdee25ce5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V5cMccPU+Haxwql0zqNaVWD6ma4npZH90JtuwGP8LDUW3aBa+I9
 JLihHm/pL1jUzBNRCLaxtn2Wc8bYSBTttcHQUKbbeIsM7hG4eWNLB/zwH3zAfcxKZSyDyhI
 mj5X6QDj4S8QUz7W7+aoU1MDrAWkHet53Tvgm0ud8l+I2kYg4Ez4wYvgubnMZxlEJ3oMK4H
 ZztQJ52Y/YUbvIbwqmfQg==
UI-OutboundReport: notjunk:1;M01:P0:uDM1b+dTz6M=;tBkHuRrtxfLY/QdG16CxXBLdb6z
 lgCWtNNLV5XVMNcQGEAvq84/HtxLiBYVo0uyrAnqSQEn5Ux92nsRDFXjG8GTXlR+aTUS/WXHS
 utHceunSSP+6xZ0VnGkDpVuFjiEJR13tXz4JmhsTbUAmfDSR9bMe335u9X55ipsvB102K6Nye
 4uGENbnqlVKTEnqEIgJ1ej4y0u8urTwA7AmI2B2S58MaOfRJYDTGd5caNXmekPITB76r2RHzD
 5m68hH7tBwDFaVn3wpGBkocj5RXLs9sHITxkBaRncHh1twheyecMgtOR5WPI8nQuv3SUOgsrh
 YVqVlFb/8x2UnBmSG391om8sb1huID+8aCObJlqonOVQjF+akPJH3eQRr12Hgu2AgWLligAMh
 /9U9Z7e9KVXqRKOqlounXUktahZO6Gc/PaXR1737K4llDCNNQsHx7wJmDq5GWIfeJ6m7Z9rK6
 L6B3qvjSLtegRVQhCNDt1o5+JERW9uAB3atdLk3IKeFqF1s7IllVtUhFU7zXvkySRQ8AnLG48
 zrLb2k/KBFQdMPmHPiU4YYQKvvXzEAmpmacMNyLqjN/3YfLzdS3EetEMRk8ctDd9iuF0jNyXw
 QxKrWyGOJ3DOW5hSXTQRDBBY5kSYTxTwbGwJtTWJrWZqBI+k8kQlTgowQ5wlRRO1iJaqF4O1m
 vmQz8W6YMpwKU19UiGlfMOnV83q7+137WIqVUT6qqkWC46Q387h1uikC1BzrB0Ld1GAM53R7f
 ZcSHVFz1QZwHUMAwTvtpEHFeLV+KdTxp2ec0CeAlnz+ZKrHLd1tNX/aiuBqCzq860XMs/dzk2
 gzabcWLjyI1Zh23prKvVCWoXoYFn4lxT8cnJExm7HjTEs=
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 5/29/24 17:11, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Helge & Richard,

Hi Philippe,

> Nevermind the missed review comments, I'm revisiting this
> patch while looking at building libtcg-hppa.so.

Ok.

> On 1/2/22 00:56, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 31/1/22 22:35, Helge Deller wrote:
>>> Almost all PA-RISC machines have either a button that is labeled with =
'TOC' or
>>> a BMC/GSP function to trigger a TOC.=C2=A0 TOC is a non-maskable inter=
rupt that is
>>> sent to the processor.=C2=A0 This can be used for diagnostic purposes =
like obtaining
>>> a stack trace/register dump or to enter KDB/KGDB in Linux.
>>>
>>> This patch adds support for such an emulated TOC button.
>>>
>>> It wires up the qemu monitor "nmi" command to trigger a TOC.=C2=A0 For=
 that it
>>
>> s/qemu/QEMU/ (few others).
>>
>>> provides the hppa_nmi function which is assigned to the nmi_monitor_ha=
ndler
>>> function pointer.=C2=A0 When called it raises the EXCP_TOC hardware in=
terrupt in the
>>> hppa_cpu_do_interrupt() function.=C2=A0 The interrupt function then ca=
lls the
>>> architecturally defined TOC function in SeaBIOS-hppa firmware (at fixe=
d address
>>> 0xf0000000).
>>>
>>> According to the PA-RISC PDC specification, the SeaBIOS firmware then =
writes
>>> the CPU registers into PIM (processor internal memmory) for later anal=
ysis.=C2=A0 In
>>
>> Typo "memory".
>>
>>> order to write all registers it needs to know the contents of the CPU =
"shadow
>>> registers" and the IASQ- and IAOQ-back values. The IAOQ/IASQ values ar=
e
>>> provided by qemu in shadow registers when entering the SeaBIOS TOC fun=
ction.
>>> This patch adds a new aritificial opcode "getshadowregs" (0xfffdead2) =
which
>>
>> Typo "artificial".
>>
>>> restores the original values of the shadow registers. With this opcode=
 SeaBIOS
>>> can store those registers as well into PIM before calling an OS-provid=
ed TOC
>>> handler.
>>>
>>> To trigger a TOC, switch to the qemu monitor with Ctrl-A C, and type i=
n the
>>> command "nmi".=C2=A0 After the TOC started the OS-debugger, exit the q=
emu monitor
>>> with Ctrl-A C.
>
> IIUC you are abusing TOC to communicate with SeaBIOS, filling
> iaoq_f with SeaBIOS-specific 0xf0000000, unrelated to the pa2.0
> spec; is that correct?

No.
A TOC on a physical machine sets the instruction pointer (iaoq_f)
to 0xf0000000 (for 32-bit).
Real physical firmware (and SeaBIOS) are located at that address
to be able to boot the machine.

> I'm trying to see how to integrate firmware specific knowledge
> into libtcg-hppa.so which is supposed to be only architectured
> parts (usually we handle firmware stuffs in machine code, not
> translation one).

That reset code is architectured.

Helge

>
> Regards,
>
> Phil.
>
>>> Signed-off-by: Helge Deller <deller@gmx.de>
>>> ---
>>> =C2=A0 hw/hppa/machine.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 3=
5 ++++++++++++++++++++++++++++++++++-
>>> =C2=A0 target/hppa/cpu.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 2 +-
>>> =C2=A0 target/hppa/cpu.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 5 +++++
>>> =C2=A0 target/hppa/helper.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
>>> =C2=A0 target/hppa/insns.decode |=C2=A0 1 +
>>> =C2=A0 target/hppa/int_helper.c | 19 ++++++++++++++++++-
>>> =C2=A0 target/hppa/op_helper.c=C2=A0 |=C2=A0 7 ++++++-
>>> =C2=A0 target/hppa/translate.c=C2=A0 | 10 ++++++++++
>>> =C2=A0 8 files changed, 76 insertions(+), 4 deletions(-)
>>> +static const TypeInfo machine_hppa_machine_init_typeinfo =3D {
>>> +=C2=A0=C2=A0=C2=A0 .name =3D ("hppa" "-machine"),
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D MACHINE_TYPE_NAME(=
"hppa"),
>>
>>> +=C2=A0=C2=A0=C2=A0 .parent =3D "machine",
>>> +=C2=A0=C2=A0=C2=A0 .class_init =3D machine_hppa_machine_init_class_in=
it,
>>> +=C2=A0=C2=A0=C2=A0 .interfaces =3D (InterfaceInfo[]) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { TYPE_NMI },
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { }
>>> +=C2=A0=C2=A0=C2=A0 },
>>> +};
>


