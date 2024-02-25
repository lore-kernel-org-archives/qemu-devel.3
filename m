Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85981C47DD9
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Feb 2024 19:40:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reKLW-0008DE-7i; Sun, 25 Feb 2024 14:39:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1reKLQ-0008Cl-0B
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 14:39:28 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1reKLK-0003Ya-3Y
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 14:39:24 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a26ed1e05c7so387532166b.2
 for <qemu-devel@nongnu.org>; Sun, 25 Feb 2024 11:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708889960; x=1709494760; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6qkp8qmmrpHEI3Gi0vduWPTE9/8rwQPVbWBxRKF16zY=;
 b=Ea5Ns75qGv2LPnUVSTOPcHSveSQWI9MbjtGxBU9qCtFvC+Bitb+xhhsLCu6yOv4e7Y
 LRbpZJiNuGuIm1huzPioYH1I/5Sna//9paFX6N7U9CUS4zL5MxKTQtPLKBSKjEutT5Pn
 rqVHXreHHfs4MnHF1j2uONXY2L7m0gtEe8ziHeLpsyumLqUA6J+xCxVw2Dw0dZKbH5Yz
 VDcFqvmt1PlQLVkCZV5OhvSLE5uQKiJoNZyZKUBRiAFta9AG/MSL/GB03uBGiDtFjwiq
 NsDQQikX1blL7nqx9j+0xkJuznF+VWGI/hmk4K0Arrpg0cf/vZ70GfER2jr96Z++4cVE
 H3Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708889960; x=1709494760;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6qkp8qmmrpHEI3Gi0vduWPTE9/8rwQPVbWBxRKF16zY=;
 b=vfhu4g5xdveRu/SZSChEGX3gbCJe/Ew3MGo0A1QEymzvv9olXfjsxrxVV+QAN57DFZ
 6i+ccwCUUsm0AjN5eRVnwSCRm0To2YoCYS6ILTh6us3MoTrMQnpcgqdABUlmH44rwpMo
 itJ6itDsyHuRupICI+R+RL9l7cSf1N2jSvh66x/sREVHN3tu724o3lv3IJB0Q3HBsQwx
 st6QP29HsI2D+OnbC2FPXiDmtRdsyVTtjstX1jA3tS3MMrVshOC8Ou2jbm5oeFpMzVwO
 XjZ/7DPosyCxohjpblQJPyvN63qRox59eDBMfBiPIWnczD46mr1vRsKiMMYviiwSLzAg
 D8gQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgP6h48Hsi2kJsgZdVowRb6ue8P5Enjwzqb1oFjqtewqRewOIKrGyz7UJDvlU+hmEgLj7tN2gFunUQSNNBHvWKL7ZgvpQ=
X-Gm-Message-State: AOJu0YyORruR6Uggyk/pCz15qGaCCQLhhNZCUo/XFvaP/b+KowvdDZmj
 ZbGJYC4PdGVOk3nnxLYyw0UdvGK+HeyqIODMa0KFMI6HQh7xYD14
X-Google-Smtp-Source: AGHT+IGDEPJgHleNOzw07QredD8CGcYbz9mnXZehduUb+8ssBvLj/UTt6VHFb+uiHyuByPWpk0ddFw==
X-Received: by 2002:a17:906:6c8c:b0:a43:6146:a4df with SMTP id
 s12-20020a1709066c8c00b00a436146a4dfmr10802ejr.21.1708889959937; 
 Sun, 25 Feb 2024 11:39:19 -0800 (PST)
Received: from [127.0.0.1] (dynamic-078-054-210-016.78.54.pool.telefonica.de.
 [78.54.210.16]) by smtp.gmail.com with ESMTPSA id
 b17-20020a170906195100b00a3e53eb1dcasm1709507eje.107.2024.02.25.11.39.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Feb 2024 11:39:19 -0800 (PST)
Date: Sun, 25 Feb 2024 19:39:19 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Volker_R=FCmelin?= <vr_qemu@t-online.de>
CC: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Subject: =?US-ASCII?Q?Re=3A_=5BPULL_14/25=5D_hw/i386/pc=3A_Confin?=
 =?US-ASCII?Q?e_system_flash_handling_to_pc=5Fsysfw?=
In-Reply-To: <9e82a04b-f2c1-4e34-b4b6-46a0581b572f@t-online.de>
References: <20240221211626.48190-1-philmd@linaro.org>
 <20240221211626.48190-15-philmd@linaro.org>
 <9e82a04b-f2c1-4e34-b4b6-46a0581b572f@t-online.de>
Message-ID: <F6997639-17B1-476D-B9F6-D2E37DCB23C5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x631.google.com
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



Am 25=2E Februar 2024 13:03:46 UTC schrieb "Volker R=C3=BCmelin" <vr_qemu@=
t-online=2Ede>:
>Am 21=2E02=2E24 um 22:16 schrieb Philippe Mathieu-Daud=C3=A9:
>> From: Bernhard Beschow <shentey@gmail=2Ecom>
>>
>> Rather than distributing PC system flash handling across three files, l=
et's
>> confine it to one=2E Now, pc_system_firmware_init() creates, configures=
 and cleans
>> up the system flash which makes the code easier to understand=2E It als=
o avoids
>> the extra call to pc_system_flash_cleanup_unused() in the Xen case=2E
>>
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>
>> Message-ID: <20240208220349=2E4948-7-shentey@gmail=2Ecom>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>
>> ---
>>  include/hw/i386/pc=2Eh | 2 --
>>  hw/i386/pc=2Ec         | 1 -
>>  hw/i386/pc_piix=2Ec    | 1 -
>>  hw/i386/pc_sysfw=2Ec   | 6 ++++--
>>  4 files changed, 4 insertions(+), 6 deletions(-)
>
>Hi Bernhard,

Hi Volker,

>
>this patch breaks QEMU on my system=2E
>
>=2E/qemu-system-x86_64 -machine q35,pflash0=3Dpflash0-storage -blockdev
>driver=3Dfile,node-name=3Dpflash0-storage,filename=3D/usr/share/qemu/ovmf=
-x86_64=2Ebin,read-only=3Dtrue
>qemu-system-x86_64: Property 'pc-q35-9=2E0-machine=2Epflash0' not found
>
>I had to revert cb05cc1602 ("hw/i386/pc_sysfw: Inline
>pc_system_flash_create() and remove it") and 6f6ad2b245 ("hw/i386/pc:
>Confine system flash handling to pc_sysfw") to make it work again=2E

In my tests I've followed https://wiki=2Earchlinux=2Eorg/title/QEMU#Bootin=
g_in_UEFI_mode for both pc and q35 machine, and therefore missed the machin=
e properties=2E If there is no way to fix it with compat properties or the =
like, I propose to revert the two patches until a different solution is fou=
nd=2E

Best regards,
Bernhard

>
>With best regards,
>Volker
>
>> diff --git a/include/hw/i386/pc=2Eh b/include/hw/i386/pc=2Eh
>> index 0a8a96600c=2E=2Ee8f4af5d5c 100644
>> --- a/include/hw/i386/pc=2Eh
>> +++ b/include/hw/i386/pc=2Eh
>> @@ -193,8 +193,6 @@ void pc_i8259_create(ISABus *isa_bus, qemu_irq *i82=
59_irqs);
>>  #define TYPE_PORT92 "port92"
>> =20
>>  /* pc_sysfw=2Ec */
>> -void pc_system_flash_create(PCMachineState *pcms);
>> -void pc_system_flash_cleanup_unused(PCMachineState *pcms);
>>  void pc_system_firmware_init(PCMachineState *pcms, MemoryRegion *rom_m=
emory);
>>  bool pc_system_ovmf_table_find(const char *entry, uint8_t **data,
>>                                 int *data_len);
>> diff --git a/hw/i386/pc=2Ec b/hw/i386/pc=2Ec
>> index e526498164=2E=2E1ee41a5e56 100644
>> --- a/hw/i386/pc=2Ec
>> +++ b/hw/i386/pc=2Ec
>> @@ -1733,7 +1733,6 @@ static void pc_machine_initfn(Object *obj)
>>  #endif
>>      pcms->default_bus_bypass_iommu =3D false;
>> =20
>> -    pc_system_flash_create(pcms);
>>      pcms->pcspk =3D isa_new(TYPE_PC_SPEAKER);
>>      object_property_add_alias(OBJECT(pcms), "pcspk-audiodev",
>>                                OBJECT(pcms->pcspk), "audiodev");
>> diff --git a/hw/i386/pc_piix=2Ec b/hw/i386/pc_piix=2Ec
>> index 34203927e1=2E=2Eec7c07b362 100644
>> --- a/hw/i386/pc_piix=2Ec
>> +++ b/hw/i386/pc_piix=2Ec
>> @@ -231,7 +231,6 @@ static void pc_init1(MachineState *machine,
>>          assert(machine->ram_size =3D=3D x86ms->below_4g_mem_size +
>>                                      x86ms->above_4g_mem_size);
>> =20
>> -        pc_system_flash_cleanup_unused(pcms);
>>          if (machine->kernel_filename !=3D NULL) {
>>              /* For xen HVM direct kernel boot, load linux here */
>>              xen_load_linux(pcms);
>> diff --git a/hw/i386/pc_sysfw=2Ec b/hw/i386/pc_sysfw=2Ec
>> index c8d9e71b88=2E=2Eb4c3833352 100644
>> --- a/hw/i386/pc_sysfw=2Ec
>> +++ b/hw/i386/pc_sysfw=2Ec
>> @@ -91,7 +91,7 @@ static PFlashCFI01 *pc_pflash_create(PCMachineState *=
pcms,
>>      return PFLASH_CFI01(dev);
>>  }
>> =20
>> -void pc_system_flash_create(PCMachineState *pcms)
>> +static void pc_system_flash_create(PCMachineState *pcms)
>>  {
>>      PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
>> =20
>> @@ -103,7 +103,7 @@ void pc_system_flash_create(PCMachineState *pcms)
>>      }
>>  }
>> =20
>> -void pc_system_flash_cleanup_unused(PCMachineState *pcms)
>> +static void pc_system_flash_cleanup_unused(PCMachineState *pcms)
>>  {
>>      char *prop_name;
>>      int i;
>> @@ -212,6 +212,8 @@ void pc_system_firmware_init(PCMachineState *pcms,
>>          return;
>>      }
>> =20
>> +    pc_system_flash_create(pcms);
>> +
>>      /* Map legacy -drive if=3Dpflash to machine properties */
>>      for (i =3D 0; i < ARRAY_SIZE(pcms->flash); i++) {
>>          pflash_cfi01_legacy_drive(pcms->flash[i],
>

