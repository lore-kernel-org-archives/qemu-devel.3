Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F3B5C5478C
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 12:15:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgOG1-000500-7J; Sat, 02 Mar 2024 07:14:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rgOFz-0004zS-Bc
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 07:14:23 -0500
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rgOFx-0002jF-0G
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 07:14:23 -0500
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3c19b7d9de7so1889494b6e.2
 for <qemu-devel@nongnu.org>; Sat, 02 Mar 2024 04:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709381659; x=1709986459; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OEktUWYGLUpxyNwaK1B015qbixqjSCwAFcJud5wAKE0=;
 b=mSc/iMnxe0Tet8d6MHwXwHvnsrPz96ozXeLmF3tYubaAqmL8I5iCWJTOwg4FhKC+L0
 2lU7CAzQeOFMpP/qyNQHO9GJixH8KoCBFYWjSGDvPG0uG2FY4NgtLXMBKXZnPFV0cyZs
 sys167jUII9q3fYcFTtyXkEp8JV6mqj+8JRk2Er30jzqj6wn13UdITQpBZQZgdf+6xAx
 DnFBGvduQZ07THDar0i1PEPUn8Z2wrD0ojtM/f1Zs2nlQaARGbRuUHoyUqmIRV6fE7Yf
 WDF7IajJ0QT3hvLKvgQzC2FQ9umk7Okb6chCbHsxVslp76cj4VnUpoqE+pE2YmFKLTaQ
 CFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709381659; x=1709986459;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OEktUWYGLUpxyNwaK1B015qbixqjSCwAFcJud5wAKE0=;
 b=wVeGBG605Wu32FWcxAw3AnFDyyTPolN2uMAHCu1zL9KdyJhHI0bIx8dewmRGLKguFM
 IoPcWxsdchJjbBTrM04k6tSDhwoKCIQ3oJ3YHlQY2LTBqYDQMyzNA2N2K2gV8C4LAGMp
 3efqFDDGcN6GrN/b9itZVQNFB11onH9faRFPzO6DwFtEtV4TwsVXOBXHiB3kLmEwd3Nn
 QYUXUo+llR//iZ6++TV8uB3Agh9jhbmLmQNUe8Lcu5qK4uYq6B7QSXXxYXEmYbLrLRnn
 cyhQYYJUj/Z0m/4xriJcb8p4fOOl3P21OxUd6XAgg1syadAkWIS78DPU1pTUzdWpDawN
 XKGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcKuDnhY/EecaciibSoIvuLJMKN3Zqlcy8SjOYf9f5RDNjJ34e5GfFGh8FBWvFTut7nPhjOs64AJ74gj1PtxOmwS4rJNk=
X-Gm-Message-State: AOJu0YxZwvSu96O1G1N6q445+mvJV8VXOioG6TbEISf6dRHXAJ8QTogu
 cClkgip91SfBecUKD9ZUQLex4Y92w7QeysHm3J4X0GkyB3sUfIDz
X-Google-Smtp-Source: AGHT+IHk+1DotWp3nbtaxwktGhWqGD969pb3goxhuBElMc7Rk+lU6/YeWYjNmlFLMMG7qMAdOMXb0A==
X-Received: by 2002:a05:6808:aa2:b0:3c1:5b64:bb51 with SMTP id
 r2-20020a0568080aa200b003c15b64bb51mr4181872oij.32.1709381659483; 
 Sat, 02 Mar 2024 04:14:19 -0800 (PST)
Received: from [127.0.0.1] (dynamic-089-012-171-109.89.12.pool.telefonica.de.
 [89.12.171.109]) by smtp.gmail.com with ESMTPSA id
 db23-20020a056130239700b007d65d653015sm813015uab.38.2024.03.02.04.14.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Mar 2024 04:14:18 -0800 (PST)
Date: Sat, 02 Mar 2024 12:14:17 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
CC: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?ISO-8859-1?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_3/5=5D_hw/isa=3A_Embed_TYPE=5FPORT?=
 =?US-ASCII?Q?92_in_south_bridges_used_in_PC_machines?=
In-Reply-To: <cff0513f-80ca-7f24-9af3-55acb059464c@eik.bme.hu>
References: <20240218131701.91132-1-shentey@gmail.com>
 <20240218131701.91132-4-shentey@gmail.com>
 <6a2333d7-9dea-4a0e-9d91-0889e6205128@ilande.co.uk>
 <F3980E89-7FE5-443A-9287-DB0350B159D9@gmail.com>
 <f25bdf58-2fc0-9f04-ef6c-c8d1cff02405@eik.bme.hu>
 <241AE060-27EF-4A36-92C8-7563256273A9@gmail.com>
 <e2299f9a-47bb-48a1-84fb-85f171c4e480@eik.bme.hu>
 <cff0513f-80ca-7f24-9af3-55acb059464c@eik.bme.hu>
Message-ID: <85EE6619-DE60-42DC-87F1-393AC57C4ADD@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=shentey@gmail.com; helo=mail-oi1-x22c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 28=2E Februar 2024 13:02:55 UTC schrieb BALATON Zoltan <balaton@eik=2Eb=
me=2Ehu>:
>On Wed, 28 Feb 2024, BALATON Zoltan wrote:
>> On Tue, 27 Feb 2024, Bernhard Beschow wrote:
>>> Am 27=2E Februar 2024 21:54:19 UTC schrieb BALATON Zoltan <balaton@eik=
=2Ebme=2Ehu>:
>>>> On Tue, 27 Feb 2024, Bernhard Beschow wrote:
>>>>> Am 21=2E Februar 2024 11:53:21 UTC schrieb Mark Cave-Ayland <mark=2E=
cave-ayland@ilande=2Eco=2Euk>:
>>>>>> On 18/02/2024 13:16, Bernhard Beschow wrote:
>>>>>>> Port 92 is an integral part of the PIIX and ICH south bridges, so =
instantiate it
>>>>>>> there=2E The isapc machine now needs to instantiate it explicitly,=
 analoguous to
>>>>>>> the RTC=2E
>>>>>>>=20
>>>>>>> Note that due to migration compatibility, port92 is optional in th=
e south
>>>>>>> bridges=2E It is always instantiated the isapc machine for simplic=
ity=2E
>>>>>>>=20
>>>>>>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>>>>>>> ---
>>>>>>>   include/hw/i386/pc=2Eh          |  2 +-
>>>>>>>   include/hw/southbridge/ich9=2Eh |  4 ++++
>>>>>>>   include/hw/southbridge/piix=2Eh |  3 +++
>>>>>>>   hw/i386/pc=2Ec                  | 18 ++++++++++++------
>>>>>>>   hw/i386/pc_piix=2Ec             |  9 +++++++--
>>>>>>>   hw/i386/pc_q35=2Ec              |  8 +++++---
>>>>>>>   hw/isa/lpc_ich9=2Ec             |  9 +++++++++
>>>>>>>   hw/isa/piix=2Ec                 |  9 +++++++++
>>>>>>>   hw/isa/Kconfig                |  2 ++
>>>>>>>   9 files changed, 52 insertions(+), 12 deletions(-)
>>>>>>=20
>>>>>> I had a look at this (and did a bit of revision around 8042 and A20=
), and I am starting to wonder if the PORT92 device isn't something that be=
longs to the southbridge, but more specifically to the superio chip?
>>>>>=20
>>>>> If there is agreement to model real hardware in QEMU, then I think t=
hat
>>>>=20
>>>> I think there's no such agreement and QEMU is more lax about it both =
for historical reasons and to simplify machine models=2E Indeed, QEMU somet=
imes models non-existing machines (e=2Eg=2E the mac99 or virt boards) that =
don't correspond to real hardware but allow guest OSes to boot=2E Even when=
 modelllng real hardware it's ofren modelled just enough for guests to work=
 and unused details are omitted for simplicity=2E It is recommended to foll=
ow what real hardware does when modelling real hardware but not always requ=
ired=2E Although it might help both with verifying a device model and to co=
mpose machines with these models to try to follow the real hardware=2E
>>>=20
>>> Composing real machines and verifying device models is exactly what I'=
m after=2E I'm aware that QEMU provides virt machines such as the microvm, =
and from the context I didn't refer to these=2E
>>=20
>> Even without pure virt machines currently a lot of QEMU machines don't =
exactly model real hardware=2E They may roughly follow real hardware but no=
t exactly such as mac99 is a non-existent Mac and the pc machines also use =
some parts that don't exist in real life such as PIIX4-PIIX3 hybrid you've =
been working on resolving=2E Some of these however are restricted by backwa=
rd compatibilty requirements=2E But you probably aware of all of that but t=
his means the argument that real hardware should be followed is not enough=
=2E At least it should not break backward compatibility too much and that's=
 more important than exactly modelling real machine=2E Also having a simple=
 model may be more important than modeling every detail even when not used =
just to follow real hardware=2E
>>=20
>>>>> port 92 belongs into any device model where the hardware has one=2E =
All our PC-like southbridges (PIIX, ICH, VIA) have port 92=2E Many FDC37xxx=
x including the FDC37M81x as used in the Malta board have one, too -- where=
 it must first be enabled=2E
>>>>=20
>>>> So port92 is not a real hardware but a QEMU abstraction or model of s=
ome functionality found in some machines=2E Real chips probably implement t=
his in different ways so we could either model this in these chips independ=
ently the same way as real hardware does or use the abstracted model anywhe=
re in our machine model=2E Since this does not exist in real hardware as th=
is abstract model it also does not belong anywhere so we are free to put it=
 where it's most convenient or simple to do=2E
>>>=20
>>> As mentioned already, port 92 is an integral part of PIIX, ICH, and VI=
A southbridges=2E
>>=20
>> Mark argued that more specifically it's part of the superio within thos=
e couthbridges=2E That makes sense, considering this port92 is related to f=
unctionality that was in the keyboard contorller before which is part of th=
e superio=2E I don't know PC hardware too well but reading about this fast =
gate A20 feature looks like original PC and XT had only a 1 MB address spac=
e but addresses above 1 MB wrapped to 0 and some software depended on that=
=2E Then AT added more memory but then it needed a way to control if addres=
ses above 1 MB would wrap or access high memory=2E This was done with some =
free part of the keyboard controller but that was too slow so an alternativ=
e fast way was added with this port92 device=2E But then the old keyboard c=
ontroller and this port92 stuff are interacting so may need to consider bot=
h=2E Apart from that all of this is not relevant to other machines that don=
't use this functionality=2E
>>=20
>> QEMU decided to model it as a separate QOM object that is now instantia=
ted by the machines that use it=2E This is not real hardware but a QEMU imp=
lementation detail=2E What's wrong with that? It seems you just want to sim=
plify the pc machine creation and push this object that does not correspond=
 to some real hardware somewhere else=2E But this belongs nowhere as it doe=
s not model a real hardware=2E
>>=20
>>> That's why I want to move it there=2E My goal is to create different P=
C machines in a data-driven manner which model real boards=2E I want to see=
 how low-level guests interact with the hardware, including e=2Eg=2E how th=
ey set up the memory map=2E
>>=20
>> Then I think the port92 as a QOM object should be gone completely and i=
mplemented separately in south bridges beacause in real machine there's no =
such port 92 thing, only a south briege so if you need to create port92 in =
a data driver machine description then that's not modeling real hardware bu=
t reflects QEMU implementation of it=2E However the QOM object could be ret=
ained
>
>So in real VIA vt8231 chip there's a pin that should be connected to the =
CPU=2E The docs say for this pin: "A20M# A20 Mask=2E Connect to A20 mask in=
put of the CPU to control address bit-20 generation=2E Logical combination =
of the A20GATE input (from internal or external keyboard controller) and Po=
rt 92 bit-1 (Fast A20)=2E See Device 0 Function 0 Rx59[1]=2E"
>
>There's another pin: "KBCK / A20GATE
>MultiFunction Pin (Internal keyboard controller enabled by F0 Rx51[0])
>Rx51[0]=3D1 Keyboard Clock=2E From internal keyboard controller
>Rx51[0]=3D0 Gate A20=2E Input from external keyboard controller=2E"
>
>To model this in QEMU following what hardware does these should be named =
gpios that the machine code connects=2E The functionality seems to be a qem=
u_irq that is either ORed to the similar output from the KBC or not dependi=
ng on register settings=2E So it seems the KBC model that's embedded in the=
 superio should also expose such pin then what uses it should connect it so=
mewhere (either forward to other components or combine it with its own A20 =
output)=2E
>
>If you want to follow real hardware then this should be implemented and t=
he port92 QOM object should be removed=2E Also need to check what other sou=
thbridges do as those may be different at least in how they control the qem=
u_irq so I'm not sure one implementation can be shared between all these so=
uth bridges that way=2E It moay be simpler for now to leave it as it is=2E

Thanks for sharing how A20 gets handled in VIA=2E Both ICH9 and PIIX work =
in a similar manner, where the A20 bits of port 92 and the KBC are logicall=
y ORed, except that they have an "A20GATE" input pin instead of an integrat=
ed KBC=2E This means that for the Intel chips the board needs an extra wire=
 from the KBC to the southbridge to handle A20=2E

Like you say, the correct way of modeling this in QEMU was to move the log=
ic into the southbridges and expose some GPIO pins=2E I'd need to look into=
 that to figure out how well that plays with bringing the VIA southbridges =
to the pc machine=2E Rather than passing port92 through pc_basic_device_ini=
t(), like this series does, it might be possible to just pass the southbrid=
ge instead=2E

One interesting outcome of this series is probably that port 92 gets deact=
ivated through the i8042 option which seems to be more than intended=2E I'd=
 send a patch to fix this=2E

Best regards,
Bernhard

>
>Regards,
>BALATON Zoltan

