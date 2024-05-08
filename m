Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F280C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 08:47:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4cwl-0005mr-VR; Wed, 08 May 2024 04:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1s4cwk-0005lw-KR
 for qemu-devel@nongnu.org; Wed, 08 May 2024 04:46:42 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1s4cwi-0006hD-Ol
 for qemu-devel@nongnu.org; Wed, 08 May 2024 04:46:42 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a59e4136010so559505666b.3
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 01:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715157999; x=1715762799; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eoHl+ES6kSyEzEnTAZM0QjRpAgoNP9Iphczzu+a7Cwk=;
 b=DZh/H+i9bfKsQnqzTfLyTivuxkUfU56wbJTRmeA8nMVquVeFAeqJNaY9SDqqTdzlsU
 Yh1YHp+gKA6uINzs26MpC3OM5noK1NoEm3oGQ4x+Idu1fiIrabgdXlZM/rDwlQRj9PMM
 565rO8kzeJdpzrjo0uw+l4/LiInTdfuklqYJfWKbSJzRw/TTJB7VS6Pa3bQStQGn9tP8
 LaYzRytprvmraLdiHGy/rZqIUHx/ZnhKILUJf3UFhdRZBP8f8+LN39cl3fxcOc/1T2zo
 13s//gIuLS9F+kR0srV57hL7bcl6pbMPi1wYeImIGFOWL2UEYHqceKHGrPqFzyqT8Nx7
 S7TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715157999; x=1715762799;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eoHl+ES6kSyEzEnTAZM0QjRpAgoNP9Iphczzu+a7Cwk=;
 b=ONQV+yr+ZXdUIn2vFzA1Np5cStRB4UNXUCJCz/9U6OP/U7PUrDwWs1tmMy+eyuqy5Q
 u33Brz/XWsc0D2TYuHKqzGt/0Pzhih+f7GcXRXbdQO0oqeldjdqZ8+4LiV7scezQvonM
 oB6v7x2kMq00tsZrCBoH+Yf7PH94QMUpPTX/D66KpNP3Bygu5uk+OJ8ULBumJ2j1MiIL
 A69PMI72AAJlkJ0pGhwNeRPPZKfy/ApryrQS0OQrEd7otxmerTwHhKnreNlL5lYYhPRl
 gvGW456afEA/8rfBE2+S3QK8W4m1d4yANKJm9uU50b25xi8wmlDpwQLsWmMj32KW54+c
 eDrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/BIepbJRjYlbMH+uzNY7ryJQs1707J1BwxHHoRkgSszdbv9sYJ2+3irHc/OB+zXIObbwEz1Em+ZupnBNSlgQC9xLKI80=
X-Gm-Message-State: AOJu0YwMd+fl6oB4QxRcqC9RKQ9eg5kMzh9B/bqz19JA4uymGtpueVss
 QapEg2yteSNESlMB/oHd8UrvynfPdbU2+s+l49puzzOF/e+TXlzuPlNe2g==
X-Google-Smtp-Source: AGHT+IGjl2Ng/hVsNAjM560PAlDgPJduMdMHPFxUI/joxNin9us4t0+Hi3TZ/Rb3gPwdm9e2maf2zg==
X-Received: by 2002:a50:8d41:0:b0:572:67d9:3400 with SMTP id
 4fb4d7f45d1cf-5731da9adb1mr1478416a12.39.1715157998474; 
 Wed, 08 May 2024 01:46:38 -0700 (PDT)
Received: from [127.0.0.1] (business-90-187-110-129.pool2.vodafone-ip.de.
 [90.187.110.129]) by smtp.gmail.com with ESMTPSA id
 g17-20020a056402091100b00571bbaa1c45sm7353136edz.1.2024.05.08.01.46.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 01:46:38 -0700 (PDT)
Date: Wed, 08 May 2024 08:17:05 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
CC: "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Sergio Lopez <slp@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_6/6=5D_hw/i386/pc=5Fsysfw=3A_?=
 =?US-ASCII?Q?Alias_rather_than_copy_isa-bios_region?=
In-Reply-To: <65316058-d2e1-4250-91e6-4da22c1279ed@linaro.org>
References: <20240430150643.111976-1-shentey@gmail.com>
 <20240430150643.111976-7-shentey@gmail.com>
 <65316058-d2e1-4250-91e6-4da22c1279ed@linaro.org>
Message-ID: <CDABAD92-BAD8-41A4-97A2-1C13C72552F8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 30=2E April 2024 15:39:21 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <ph=
ilmd@linaro=2Eorg>:
>On 30/4/24 17:06, Bernhard Beschow wrote:
>> In the -bios case the "isa-bios" memory region is an alias to the BIOS =
mapped
>> to the top of the 4G memory boundary=2E Do the same in the -pflash case=
, but only
>> for new machine versions for migration compatibility=2E This establishe=
s common
>> behavior and makes pflash commands work in the "isa-bios" region which =
some
>> real-world legacy bioses rely on=2E
>
>Can you amend a diff of 'info mtree' here to see how the layout changes?

Will do=2E

Right now I have to manually sort the output to get a minimal diff=2E Is t=
here a way to get a stable ordering of the memory regions? How would one fi=
x that if this is currently impossible? With stable orderings we could have=
 automated memory map tests which had been handy in the past=2E

>
>> Note that in the sev_enabled() case, the "isa-bios" memory region in th=
e -pflash
>> case will now also point to encrypted memory, just like it already does=
 in the
>> -bios case=2E
>>=20
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>>   include/hw/i386/pc=2Eh | 1 +
>>   hw/i386/pc=2Ec         | 1 +
>>   hw/i386/pc_piix=2Ec    | 3 +++
>>   hw/i386/pc_q35=2Ec     | 2 ++
>>   hw/i386/pc_sysfw=2Ec   | 8 +++++++-
>>   5 files changed, 14 insertions(+), 1 deletion(-)
>
>I'm still not convinced we need a migration back compat for this=2E=2E=2E

A copy behaves different than an alias, thus there is a behavioral change=
=2E Whether it really matters in practice for the kind of guests we care ab=
out I can't tell=2E Therefore I'd keep the compat machinery=2E

Best regards,
Bernhard

>
>> diff --git a/hw/i386/pc_sysfw=2Ec b/hw/i386/pc_sysfw=2Ec
>> index 82d37cb376=2E=2Eac88ad4eb9 100644
>> --- a/hw/i386/pc_sysfw=2Ec
>> +++ b/hw/i386/pc_sysfw=2Ec
>> @@ -135,6 +135,7 @@ static void pc_system_flash_map(PCMachineState *pcm=
s,
>>                                   MemoryRegion *rom_memory)
>>   {
>>       X86MachineState *x86ms =3D X86_MACHINE(pcms);
>> +    PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
>>       hwaddr total_size =3D 0;
>>       int i;
>>       BlockBackend *blk;
>> @@ -184,7 +185,12 @@ static void pc_system_flash_map(PCMachineState *pc=
ms,
>>             if (i =3D=3D 0) {
>>               flash_mem =3D pflash_cfi01_get_memory(system_flash);
>> -            pc_isa_bios_init(&x86ms->isa_bios, rom_memory, flash_mem);
>> +            if (pcmc->isa_bios_alias) {
>> +                x86_isa_bios_init(&x86ms->isa_bios, rom_memory, flash_=
mem,
>> +                                  true);
>> +            } else {
>> +                pc_isa_bios_init(&x86ms->isa_bios, rom_memory, flash_m=
em);
>> +            }
>>                 /* Encrypt the pflash boot ROM */
>>               if (sev_enabled()) {
>

