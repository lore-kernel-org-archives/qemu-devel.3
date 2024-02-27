Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C0D5C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 23:35:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf6yL-00057S-Vq; Tue, 27 Feb 2024 18:34:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rf6yJ-000575-D9
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 18:34:51 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rf6yG-0005iE-IS
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 18:34:50 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-563d56ee65cso6601239a12.2
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 15:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709076886; x=1709681686; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GLP19PGDYEUGokez5vIjwGG/noCMRkva0IcYhvqV37k=;
 b=Fm1l6tkw4sQDiQTkhyPKhFVUYlvke1XCH8UjKtscfEdeapok4Uoc7pafY2gT0uKq7b
 1QkicL+S6Kl1eHqCkyy6JcV3+qSgWgQ932pG0/GpH4I1UwZYdOymB8mjUdxgy7co8CtI
 HVwCSGoo5XkBDsAl+wcpS8SSqFGqOCL5mTRZ7cyoUMoFYVKOfvQu3B7pZ71Voi7z0wxr
 GomnmdKIlqmECPWdeF1PNDVd1/HUFSD/h2KV0Yb73bL7vZakXh2skLoYmietnEvhjH1y
 PUuxIpsz5r/vYURQu/OOPM7j9LC0gqbU+k9FXmgkcRlaNyr58F37tgs02wc0wsi1wscs
 Ub5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709076886; x=1709681686;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GLP19PGDYEUGokez5vIjwGG/noCMRkva0IcYhvqV37k=;
 b=vzlpsn8ur/hbLjRv3bhFriNMvi9HbvhAWrA1U78yX9eMQSNi6NDj1LWiu2RfSDLXZG
 vxxpxXPj2FG9CEI5Qat3N2g9QFm2e+fAxT5Dx/+8SZM7uH25dAVqeep1/y7xckTf9USH
 +daOHXhSy2+AFOy6QTa/Rm3jE0GkODMo3sZVfcksjjwIq6niLB+ItBjGdMCsZq6FygXT
 hXdvF9DNr6qfALHNINVMi4zafzlPsa6dQDAeuccZJYKUcc/1onJicQk2KQ4VNfAtHecr
 mDkkOMKa3GDbihQgvWoi7NBgFH2o/czCAyYvxgDiANxAH5DPkmjKhGBGrMlROBW2fa8e
 aT7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6FT9gqhteMQB4aPIGt55zWLagwgIdq/bKYk92LehqmtRxPMHdt6+qDM2Zy8HJJuplgyeFbO0+R6SDv0KI/SqtmU4PFbY=
X-Gm-Message-State: AOJu0YzVdeIbGG928/RW72hXr/ga6WJlunSW76pp+FAYe/zK/MksGrdk
 8aTfWhOhXQ4ZBxMeQEWnt77mvHb2QENGw8y5ezZbwJJbcwU0mHKBizIsMkJ+
X-Google-Smtp-Source: AGHT+IFIQIPFn/jVXiM+Sy4g6FoFv1J0UH0PTvr/qDJ3BgPwi8JX+gpygCyzJskgx913pWt/dQsWMg==
X-Received: by 2002:a17:906:a893:b0:a43:9780:9492 with SMTP id
 ha19-20020a170906a89300b00a4397809492mr2965068ejb.5.1709076886347; 
 Tue, 27 Feb 2024 15:34:46 -0800 (PST)
Received: from [127.0.0.1] (dynamic-077-183-140-233.77.183.pool.telefonica.de.
 [77.183.140.233]) by smtp.gmail.com with ESMTPSA id
 vx5-20020a170907a78500b00a3f20a8d2f6sm1229680ejc.112.2024.02.27.15.34.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Feb 2024 15:34:46 -0800 (PST)
Date: Tue, 27 Feb 2024 23:34:45 +0000
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
In-Reply-To: <f25bdf58-2fc0-9f04-ef6c-c8d1cff02405@eik.bme.hu>
References: <20240218131701.91132-1-shentey@gmail.com>
 <20240218131701.91132-4-shentey@gmail.com>
 <6a2333d7-9dea-4a0e-9d91-0889e6205128@ilande.co.uk>
 <F3980E89-7FE5-443A-9287-DB0350B159D9@gmail.com>
 <f25bdf58-2fc0-9f04-ef6c-c8d1cff02405@eik.bme.hu>
Message-ID: <241AE060-27EF-4A36-92C8-7563256273A9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x530.google.com
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



Am 27=2E Februar 2024 21:54:19 UTC schrieb BALATON Zoltan <balaton@eik=2Eb=
me=2Ehu>:
>On Tue, 27 Feb 2024, Bernhard Beschow wrote:
>> Am 21=2E Februar 2024 11:53:21 UTC schrieb Mark Cave-Ayland <mark=2Ecav=
e-ayland@ilande=2Eco=2Euk>:
>>> On 18/02/2024 13:16, Bernhard Beschow wrote:
>>>> Port 92 is an integral part of the PIIX and ICH south bridges, so ins=
tantiate it
>>>> there=2E The isapc machine now needs to instantiate it explicitly, an=
aloguous to
>>>> the RTC=2E
>>>>=20
>>>> Note that due to migration compatibility, port92 is optional in the s=
outh
>>>> bridges=2E It is always instantiated the isapc machine for simplicity=
=2E
>>>>=20
>>>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>>>> ---
>>>>   include/hw/i386/pc=2Eh          |  2 +-
>>>>   include/hw/southbridge/ich9=2Eh |  4 ++++
>>>>   include/hw/southbridge/piix=2Eh |  3 +++
>>>>   hw/i386/pc=2Ec                  | 18 ++++++++++++------
>>>>   hw/i386/pc_piix=2Ec             |  9 +++++++--
>>>>   hw/i386/pc_q35=2Ec              |  8 +++++---
>>>>   hw/isa/lpc_ich9=2Ec             |  9 +++++++++
>>>>   hw/isa/piix=2Ec                 |  9 +++++++++
>>>>   hw/isa/Kconfig                |  2 ++
>>>>   9 files changed, 52 insertions(+), 12 deletions(-)
>>>=20
>>> I had a look at this (and did a bit of revision around 8042 and A20), =
and I am starting to wonder if the PORT92 device isn't something that belon=
gs to the southbridge, but more specifically to the superio chip?
>>=20
>> If there is agreement to model real hardware in QEMU, then I think that
>
>I think there's no such agreement and QEMU is more lax about it both for =
historical reasons and to simplify machine models=2E Indeed, QEMU sometimes=
 models non-existing machines (e=2Eg=2E the mac99 or virt boards) that don'=
t correspond to real hardware but allow guest OSes to boot=2E Even when mod=
elllng real hardware it's ofren modelled just enough for guests to work and=
 unused details are omitted for simplicity=2E It is recommended to follow w=
hat real hardware does when modelling real hardware but not always required=
=2E Although it might help both with verifying a device model and to compos=
e machines with these models to try to follow the real hardware=2E

Composing real machines and verifying device models is exactly what I'm af=
ter=2E I'm aware that QEMU provides virt machines such as the microvm, and =
from the context I didn't refer to these=2E

>
>> port 92 belongs into any device model where the hardware has one=2E All=
 our PC-like southbridges (PIIX, ICH, VIA) have port 92=2E Many FDC37xxxx i=
ncluding the FDC37M81x as used in the Malta board have one, too -- where it=
 must first be enabled=2E
>
>So port92 is not a real hardware but a QEMU abstraction or model of some =
functionality found in some machines=2E Real chips probably implement this =
in different ways so we could either model this in these chips independentl=
y the same way as real hardware does or use the abstracted model anywhere i=
n our machine model=2E Since this does not exist in real hardware as this a=
bstract model it also does not belong anywhere so we are free to put it whe=
re it's most convenient or simple to do=2E

As mentioned already, port 92 is an integral part of PIIX, ICH, and VIA so=
uthbridges=2E That's why I want to move it there=2E My goal is to create di=
fferent PC machines in a data-driven manner which model real boards=2E I wa=
nt to see how low-level guests interact with the hardware, including e=2Eg=
=2E how they set up the memory map=2E

>
>>> A couple of thoughts as to why I came to this conclusion: firstly the =
superio chip is generally considered to be a single integrated implementati=
on of legacy IO devices, so this feels like a natural home for the PORT92 d=
evice=2E
>>=20
>>> Secondly the value of the "has-port92" property is controlled by pcms-=
>i8042_enabled, and this value is already passed into functions such as pc_=
superio_init() for example=2E
>>=20
>> Rhight=2E There, it also controls the presence of port 92=2E If we move=
 port 92 into the southbridges, we have to respect this command line switch=
 there to preserve backward compatibility=2E
>>=20
>> I wonder what `-M i8042` is supposed to do=2E If it is for modeling a s=
tripped-down x86 system, why not use the microvm instead? How is it possibl=
e to omit an essential piece of hardware needed to boot x86 systems? Don't =
we need at least either one (i8042 or port 92)?
>
>Try git log -p 4ccd5fe22fe (found it via git blame and see what added tha=
t property)=2E

Alright, the intention was to omit the PS/2 controller in favor of USB=2E =
That doesn't mean that port 92 needs to be affected=2E I see an opportunity=
 here to reduce the scope of the i8042 option which may help with data-driv=
en machine creation in the future=2E

>
>>> I think this would also help reduce the changes required for the indiv=
idual machines, however the devil is always in the details particularly whe=
n migration is involved=2E
>>=20
>> As stated above, this series is more about modeling real hardware, in t=
he hope that this will lend itself for configuration-driven machine creatio=
n=2E It is also about identifying obstacles towards this goal=2E Does it ma=
ke sense to deprecate some machine-specific options such as i8042?
>
>Only if you want to break downsteam users of those options but maybe they=
 won't be happy about that=2E

I don't want to break downstream users of course=2E

I want device models true to the original=2E I think that this series is a=
 step in this direction, hence I'd like feedback for achieving that=2E What=
's necessary to get this series in?

Best regards,
Bernhard

>
>Regards,
>BALATON Zoltan

