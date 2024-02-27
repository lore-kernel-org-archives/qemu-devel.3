Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F64C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 20:49:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf4O0-0001j9-Bu; Tue, 27 Feb 2024 15:49:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rf4Nr-0001Ty-Tr
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 15:49:05 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rf4Nm-0006nj-Rw
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 15:49:02 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a3f829cde6dso567772466b.0
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 12:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709066937; x=1709671737; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WZkqonxt/+0kZAZSQG8ws8ihZ0c+xSZYvvsWzfJAuAk=;
 b=R/wSP3X7ekomoyBnVWI74oJ0ckGRTtYM6I3/cM4GPasPf/rfH9PYqdMT+PYrrS50hx
 lFDi1Bh4BkfZ1ylLQr6smOvpEq9rA+a11tPplP5JinrIEQQmlDJ89P30PQ1cXcod+Umi
 EJ/ccOxnhIfEda/GS2CthIqnieYnvwalXvLLjrFg+UCr86eX9nA2HvaEucB10FZq+i2f
 6tvRMmWwur8vvMyxi7ImpvRHKX0XLZcv9OcR17EgdDQ1aw/dyJesmWFgAUxwiKG0+/Cl
 l7d2iALpU8KO/XbVebnzWRh01dn1OYdsPTxYPTMIza3HBJdAaaFWphue3aSU6tuGMBwn
 JDoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709066937; x=1709671737;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WZkqonxt/+0kZAZSQG8ws8ihZ0c+xSZYvvsWzfJAuAk=;
 b=uJzhAVeB+6MeOA57dWQcfohFhvwZfVpLZQEruOXjKTcW7mJjs9zKrzRZYu++ctJ5KE
 vIIKLq9H9s/+x1cOS3LP/SU0yewMUOARJC3tjQIw19uEPgaHixHYzEXSucIbcX/apFs3
 Z78pHn4HXUIcNu/J8P0tW6a0HL2HQJy7sjLZEtdFYks1Kd8+3TMqx7qs2O6rgm0bq7AO
 f4J8J9SIq+vy7sE6ds0gXnceN1lijsRueZbPyVU2M0kCfkOJsTNX75auisAn+AcrD+zo
 /rrM4vb6WekNRu3lOxCq4xjQxHEnd2lJVGiATPJayW9U9hmFRWhe6/r7jqkpCui7LwOe
 hlfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBQKHV1l0EKanbogPzTE5FuYF5jokONomsZDsLAEwdTLCXlqSKjtvgfsMTXIHz0pmXtboqzuocp1q69v50MVGlCMkE7nQ=
X-Gm-Message-State: AOJu0YzzMIuPkfZHw3EC6AkjMA6NTFFmPW8ipeKwKma2YdDlNzHlBLOQ
 d6JgQgytY/sazalxw2e/IDG4N27ZWDtaABWF9xznLsn/pSIrSuao
X-Google-Smtp-Source: AGHT+IFxTgVsCRbj7SYjfk3wOhSTVF2eewC2GuaEOm7uHe1CbPJZuviMKAxZyxqxXNgbeGvTzv/LQQ==
X-Received: by 2002:a17:906:b7d3:b0:a3d:993e:ad24 with SMTP id
 fy19-20020a170906b7d300b00a3d993ead24mr6654467ejb.59.1709066936575; 
 Tue, 27 Feb 2024 12:48:56 -0800 (PST)
Received: from [127.0.0.1] (dynamic-077-183-140-233.77.183.pool.telefonica.de.
 [77.183.140.233]) by smtp.gmail.com with ESMTPSA id
 o17-20020a170906601100b00a4354b9893csm1106780ejj.74.2024.02.27.12.48.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Feb 2024 12:48:56 -0800 (PST)
Date: Tue, 27 Feb 2024 19:20:11 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
CC: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?ISO-8859-1?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_3/5=5D_hw/isa=3A_Embed_TYPE=5FPORT?=
 =?US-ASCII?Q?92_in_south_bridges_used_in_PC_machines?=
In-Reply-To: <6a2333d7-9dea-4a0e-9d91-0889e6205128@ilande.co.uk>
References: <20240218131701.91132-1-shentey@gmail.com>
 <20240218131701.91132-4-shentey@gmail.com>
 <6a2333d7-9dea-4a0e-9d91-0889e6205128@ilande.co.uk>
Message-ID: <F3980E89-7FE5-443A-9287-DB0350B159D9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62f.google.com
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



Am 21=2E Februar 2024 11:53:21 UTC schrieb Mark Cave-Ayland <mark=2Ecave-a=
yland@ilande=2Eco=2Euk>:
>On 18/02/2024 13:16, Bernhard Beschow wrote:
>
>> Port 92 is an integral part of the PIIX and ICH south bridges, so insta=
ntiate it
>> there=2E The isapc machine now needs to instantiate it explicitly, anal=
oguous to
>> the RTC=2E
>>=20
>> Note that due to migration compatibility, port92 is optional in the sou=
th
>> bridges=2E It is always instantiated the isapc machine for simplicity=
=2E
>>=20
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>>   include/hw/i386/pc=2Eh          |  2 +-
>>   include/hw/southbridge/ich9=2Eh |  4 ++++
>>   include/hw/southbridge/piix=2Eh |  3 +++
>>   hw/i386/pc=2Ec                  | 18 ++++++++++++------
>>   hw/i386/pc_piix=2Ec             |  9 +++++++--
>>   hw/i386/pc_q35=2Ec              |  8 +++++---
>>   hw/isa/lpc_ich9=2Ec             |  9 +++++++++
>>   hw/isa/piix=2Ec                 |  9 +++++++++
>>   hw/isa/Kconfig                |  2 ++
>>   9 files changed, 52 insertions(+), 12 deletions(-)
>>=20
>> diff --git a/include/hw/i386/pc=2Eh b/include/hw/i386/pc=2Eh
>> index b2987209b1=2E=2Ea9ff1f5ab3 100644
>> --- a/include/hw/i386/pc=2Eh
>> +++ b/include/hw/i386/pc=2Eh
>> @@ -178,7 +178,7 @@ uint64_t pc_pci_hole64_start(void);
>>   DeviceState *pc_vga_init(ISABus *isa_bus, PCIBus *pci_bus);
>>   void pc_basic_device_init(struct PCMachineState *pcms,
>>                             ISABus *isa_bus, qemu_irq *gsi,
>> -                          ISADevice *rtc_state,
>> +                          ISADevice *rtc_state, ISADevice *port92,
>>                             bool create_fdctrl,
>>                             uint32_t hpet_irqs);
>>   void pc_cmos_init(PCMachineState *pcms,
>> diff --git a/include/hw/southbridge/ich9=2Eh b/include/hw/southbridge/i=
ch9=2Eh
>> index fd01649d04=2E=2Ed70a94f5e7 100644
>> --- a/include/hw/southbridge/ich9=2Eh
>> +++ b/include/hw/southbridge/ich9=2Eh
>> @@ -3,6 +3,7 @@
>>     #include "hw/isa/apm=2Eh"
>>   #include "hw/acpi/ich9=2Eh"
>> +#include "hw/isa/port92=2Eh"
>>   #include "hw/intc/ioapic=2Eh"
>>   #include "hw/pci/pci=2Eh"
>>   #include "hw/pci/pci_device=2Eh"
>> @@ -32,6 +33,7 @@ struct ICH9LPCState {
>>       uint8_t irr[PCI_SLOT_MAX][PCI_NUM_PINS];
>>         MC146818RtcState rtc;
>> +    Port92State port92;
>>       APMState apm;
>>       ICH9LPCPMRegs pm;
>>       uint32_t sci_level; /* track sci level */
>> @@ -54,6 +56,8 @@ struct ICH9LPCState {
>>       uint8_t rst_cnt;
>>       MemoryRegion rst_cnt_mem;
>>   +    bool has_port92;
>> +
>>       /* SMI feature negotiation via fw_cfg */
>>       uint64_t smi_host_features;       /* guest-invisible, host endian=
 */
>>       uint8_t smi_host_features_le[8];  /* guest-visible, read-only, li=
ttle
>> diff --git a/include/hw/southbridge/piix=2Eh b/include/hw/southbridge/p=
iix=2Eh
>> index 86709ba2e4=2E=2E35058529d1 100644
>> --- a/include/hw/southbridge/piix=2Eh
>> +++ b/include/hw/southbridge/piix=2Eh
>> @@ -15,6 +15,7 @@
>>   #include "hw/pci/pci_device=2Eh"
>>   #include "hw/acpi/piix4=2Eh"
>>   #include "hw/ide/pci=2Eh"
>> +#include "hw/isa/port92=2Eh"
>>   #include "hw/rtc/mc146818rtc=2Eh"
>>   #include "hw/usb/hcd-uhci=2Eh"
>>   @@ -56,6 +57,7 @@ struct PIIXState {
>>       int32_t pci_irq_levels_vmstate[PIIX_NUM_PIRQS];
>>         MC146818RtcState rtc;
>> +    Port92State port92;
>>       PCIIDEState ide;
>>       UHCIState uhci;
>>       PIIX4PMState pm;
>> @@ -71,6 +73,7 @@ struct PIIXState {
>>       bool has_acpi;
>>       bool has_pic;
>>       bool has_pit;
>> +    bool has_port92;
>>       bool has_usb;
>>       bool smm_enabled;
>>   };
>> diff --git a/hw/i386/pc=2Ec b/hw/i386/pc=2Ec
>> index 0b11d4576e=2E=2E8b601ea6cf 100644
>> --- a/hw/i386/pc=2Ec
>> +++ b/hw/i386/pc=2Ec
>> @@ -1160,7 +1160,7 @@ static void pc_superio_init(ISABus *isa_bus, bool=
 create_fdctrl,
>>       int i;
>>       DriveInfo *fd[MAX_FD];
>>       qemu_irq *a20_line;
>> -    ISADevice *fdc, *i8042, *port92, *vmmouse;
>> +    ISADevice *fdc, *i8042, *vmmouse;
>>         serial_hds_isa_init(isa_bus, 0, MAX_ISA_SERIAL_PORTS);
>>       parallel_hds_isa_init(isa_bus, MAX_PARALLEL_PORTS);
>> @@ -1193,18 +1193,15 @@ static void pc_superio_init(ISABus *isa_bus, bo=
ol create_fdctrl,
>>                                    &error_abort);
>>           isa_realize_and_unref(vmmouse, isa_bus, &error_fatal);
>>       }
>> -    port92 =3D isa_create_simple(isa_bus, TYPE_PORT92);
>>   -    a20_line =3D qemu_allocate_irqs(handle_a20_line_change, first_cp=
u, 2);
>> +    a20_line =3D qemu_allocate_irqs(handle_a20_line_change, first_cpu,=
 1);
>>       i8042_setup_a20_line(i8042, a20_line[0]);
>> -    qdev_connect_gpio_out_named(DEVICE(port92),
>> -                                PORT92_A20_LINE, 0, a20_line[1]);
>>       g_free(a20_line);
>>   }
>>     void pc_basic_device_init(struct PCMachineState *pcms,
>>                             ISABus *isa_bus, qemu_irq *gsi,
>> -                          ISADevice *rtc_state,
>> +                          ISADevice *rtc_state, ISADevice *port92,
>>                             bool create_fdctrl,
>>                             uint32_t hpet_irqs)
>>   {
>> @@ -1296,6 +1293,15 @@ void pc_basic_device_init(struct PCMachineState =
*pcms,
>>       /* Super I/O */
>>       pc_superio_init(isa_bus, create_fdctrl, pcms->i8042_enabled,
>>                       pcms->vmport !=3D ON_OFF_AUTO_ON);
>> +
>> +    if (port92) {
>> +        qemu_irq *a20_line;
>> +
>> +        a20_line =3D qemu_allocate_irqs(handle_a20_line_change, first_=
cpu, 1);
>> +        qdev_connect_gpio_out_named(DEVICE(port92),
>> +                                    PORT92_A20_LINE, 0, a20_line[0]);
>> +        g_free(a20_line);
>> +    }
>>   }
>>     void pc_nic_init(PCMachineClass *pcmc, ISABus *isa_bus, PCIBus *pci=
_bus)
>> diff --git a/hw/i386/pc_piix=2Ec b/hw/i386/pc_piix=2Ec
>> index 999b7b806c=2E=2Edfdfd36551 100644
>> --- a/hw/i386/pc_piix=2Ec
>> +++ b/hw/i386/pc_piix=2Ec
>> @@ -115,7 +115,7 @@ static void pc_init1(MachineState *machine,
>>       qemu_irq smi_irq;
>>       GSIState *gsi_state;
>>       BusState *idebus[MAX_IDE_BUS];
>> -    ISADevice *rtc_state;
>> +    ISADevice *rtc_state, *port92;
>>       MemoryRegion *ram_memory;
>>       MemoryRegion *pci_memory =3D NULL;
>>       MemoryRegion *rom_memory =3D system_memory;
>> @@ -269,6 +269,8 @@ static void pc_init1(MachineState *machine,
>>                                    &error_abort);
>>           object_property_set_bool(OBJECT(pci_dev), "has-pit", false,
>>                                    &error_abort);
>> +        object_property_set_bool(OBJECT(pci_dev), "has-port92",
>> +                                 pcms->i8042_enabled, &error_abort);
>>           qdev_prop_set_uint32(DEVICE(pci_dev), "smb_io_base", 0xb100);
>>           object_property_set_bool(OBJECT(pci_dev), "smm-enabled",
>>                                    x86_machine_is_smm_enabled(x86ms),
>> @@ -296,6 +298,8 @@ static void pc_init1(MachineState *machine,
>>           isa_bus =3D ISA_BUS(qdev_get_child_bus(DEVICE(pci_dev), "isa=
=2E0"));
>>           rtc_state =3D ISA_DEVICE(object_resolve_path_component(OBJECT=
(pci_dev),
>>                                                                "rtc"));
>> +        port92 =3D ISA_DEVICE(object_resolve_path_component(OBJECT(pci=
_dev),
>> +                                                          "port92"));
>>           piix4_pm =3D object_resolve_path_component(OBJECT(pci_dev), "=
pm");
>>           dev =3D DEVICE(object_resolve_path_component(OBJECT(pci_dev),=
 "ide"));
>>           pci_ide_create_devs(PCI_DEVICE(dev));
>> @@ -310,6 +314,7 @@ static void pc_init1(MachineState *machine,
>>           qdev_prop_set_int32(DEVICE(rtc_state), "base_year", 2000);
>>           isa_realize_and_unref(rtc_state, isa_bus, &error_fatal);
>>   +        port92 =3D isa_create_simple(isa_bus, TYPE_PORT92);
>>           i8257_dma_init(OBJECT(machine), isa_bus, 0);
>>           pcms->hpet_enabled =3D false;
>>           idebus[0] =3D NULL;
>> @@ -336,7 +341,7 @@ static void pc_init1(MachineState *machine,
>>       }
>>         /* init basic PC hardware */
>> -    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, rtc_state, true,
>> +    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, rtc_state, port92,=
 true,
>>                            0x4);
>>         pc_nic_init(pcmc, isa_bus, pci_bus);
>> diff --git a/hw/i386/pc_q35=2Ec b/hw/i386/pc_q35=2Ec
>> index d346fa3b1d=2E=2E26bb1c2cb9 100644
>> --- a/hw/i386/pc_q35=2Ec
>> +++ b/hw/i386/pc_q35=2Ec
>> @@ -127,7 +127,7 @@ static void pc_q35_init(MachineState *machine)
>>       PCIDevice *lpc;
>>       DeviceState *lpc_dev;
>>       BusState *idebus[MAX_SATA_PORTS];
>> -    ISADevice *rtc_state;
>> +    ISADevice *rtc_state, *port92;
>>       MemoryRegion *system_memory =3D get_system_memory();
>>       MemoryRegion *system_io =3D get_system_io();
>>       MemoryRegion *pci_memory =3D g_new(MemoryRegion, 1);
>> @@ -238,6 +238,7 @@ static void pc_q35_init(MachineState *machine)
>>       lpc =3D pci_new_multifunction(PCI_DEVFN(ICH9_LPC_DEV, ICH9_LPC_FU=
NC),
>>                                   TYPE_ICH9_LPC_DEVICE);
>>       lpc_dev =3D DEVICE(lpc);
>> +    qdev_prop_set_bit(lpc_dev, "has-port92", pcms->i8042_enabled);
>>       qdev_prop_set_bit(lpc_dev, "smm-enabled",
>>                         x86_machine_is_smm_enabled(x86ms));
>>       pci_realize_and_unref(lpc, host_bus, &error_fatal);
>> @@ -246,6 +247,7 @@ static void pc_q35_init(MachineState *machine)
>>       }
>>         rtc_state =3D ISA_DEVICE(object_resolve_path_component(OBJECT(l=
pc), "rtc"));
>> +    port92 =3D ISA_DEVICE(object_resolve_path_component(OBJECT(lpc), "=
port92"));
>>         object_property_add_link(OBJECT(machine), PC_MACHINE_ACPI_DEVIC=
E_PROP,
>>                                TYPE_HOTPLUG_HANDLER,
>> @@ -287,8 +289,8 @@ static void pc_q35_init(MachineState *machine)
>>       }
>>         /* init basic PC hardware */
>> -    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, rtc_state, !mc->no=
_floppy,
>> -                         0xff0104);
>> +    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, rtc_state, port92,
>> +                         !mc->no_floppy, 0xff0104);
>>         if (pcms->sata_enabled) {
>>           PCIDevice *pdev;
>> diff --git a/hw/isa/lpc_ich9=2Ec b/hw/isa/lpc_ich9=2Ec
>> index 70c6e8a093=2E=2E3be5bc01b1 100644
>> --- a/hw/isa/lpc_ich9=2Ec
>> +++ b/hw/isa/lpc_ich9=2Ec
>> @@ -749,6 +749,14 @@ static void ich9_lpc_realize(PCIDevice *d, Error *=
*errp)
>>       irq =3D object_property_get_uint(OBJECT(&lpc->rtc), "irq", &error=
_fatal);
>>       isa_connect_gpio_out(ISA_DEVICE(&lpc->rtc), 0, irq);
>>   +    if (lpc->has_port92) {
>> +        object_initialize_child(OBJECT(lpc), "port92", &lpc->port92,
>> +                                TYPE_PORT92);
>> +        if (!qdev_realize(DEVICE(&lpc->port92), BUS(isa_bus), errp)) {
>> +            return;
>> +        }
>> +    }
>> +
>>       pci_bus_irqs(pci_bus, ich9_lpc_set_irq, d, ICH9_LPC_NB_PIRQS);
>>       pci_bus_map_irqs(pci_bus, ich9_lpc_map_irq);
>>       pci_bus_set_route_irq_fn(pci_bus, ich9_route_intx_pin_to_irq);
>> @@ -821,6 +829,7 @@ static Property ich9_lpc_properties[] =3D {
>>       DEFINE_PROP_BOOL("noreboot", ICH9LPCState, pin_strap=2Espkr_hi, f=
alse),
>>       DEFINE_PROP_BOOL("smm-compat", ICH9LPCState, pm=2Esmm_compat, fal=
se),
>>       DEFINE_PROP_BOOL("smm-enabled", ICH9LPCState, pm=2Esmm_enabled, f=
alse),
>> +    DEFINE_PROP_BOOL("has-port92", ICH9LPCState, has_port92, true),
>>       DEFINE_PROP_BIT64("x-smi-broadcast", ICH9LPCState, smi_host_featu=
res,
>>                         ICH9_LPC_SMI_F_BROADCAST_BIT, true),
>>       DEFINE_PROP_BIT64("x-smi-cpu-hotplug", ICH9LPCState, smi_host_fea=
tures,
>> diff --git a/hw/isa/piix=2Ec b/hw/isa/piix=2Ec
>> index 2d30711b17=2E=2E4c12855461 100644
>> --- a/hw/isa/piix=2Ec
>> +++ b/hw/isa/piix=2Ec
>> @@ -346,6 +346,14 @@ static void pci_piix_realize(PCIDevice *dev, const=
 char *uhci_type,
>>       irq =3D object_property_get_uint(OBJECT(&d->rtc), "irq", &error_f=
atal);
>>       isa_connect_gpio_out(ISA_DEVICE(&d->rtc), 0, irq);
>>   +    /* Port 92 */
>> +    if (d->has_port92) {
>> +        object_initialize_child(OBJECT(d), "port92", &d->port92, TYPE_=
PORT92);
>> +        if (!qdev_realize(DEVICE(&d->port92), BUS(isa_bus), errp)) {
>> +            return;
>> +        }
>> +    }
>> +
>>       /* IDE */
>>       qdev_prop_set_int32(DEVICE(&d->ide), "addr", dev->devfn + 1);
>>       if (!qdev_realize(DEVICE(&d->ide), BUS(pci_bus), errp)) {
>> @@ -413,6 +421,7 @@ static Property pci_piix_props[] =3D {
>>       DEFINE_PROP_BOOL("has-acpi", PIIXState, has_acpi, true),
>>       DEFINE_PROP_BOOL("has-pic", PIIXState, has_pic, true),
>>       DEFINE_PROP_BOOL("has-pit", PIIXState, has_pit, true),
>> +    DEFINE_PROP_BOOL("has-port92", PIIXState, has_port92, true),
>>       DEFINE_PROP_BOOL("has-usb", PIIXState, has_usb, true),
>>       DEFINE_PROP_BOOL("smm-enabled", PIIXState, smm_enabled, false),
>>       DEFINE_PROP_END_OF_LIST(),
>> diff --git a/hw/isa/Kconfig b/hw/isa/Kconfig
>> index efdf43e92c=2E=2Ef42a087c07 100644
>> --- a/hw/isa/Kconfig
>> +++ b/hw/isa/Kconfig
>> @@ -47,6 +47,7 @@ config PIIX
>>       select IDE_PIIX
>>       select ISA_BUS
>>       select MC146818RTC
>> +    select PORT92
>>       select USB_UHCI
>>     config PORT92
>> @@ -78,3 +79,4 @@ config LPC_ICH9
>>       select ISA_BUS
>>       select ACPI_ICH9
>>       select MC146818RTC
>> +    select PORT92
>
>I had a look at this (and did a bit of revision around 8042 and A20), and=
 I am starting to wonder if the PORT92 device isn't something that belongs =
to the southbridge, but more specifically to the superio chip?

If there is agreement to model real hardware in QEMU, then I think that po=
rt 92 belongs into any device model where the hardware has one=2E All our P=
C-like southbridges (PIIX, ICH, VIA) have port 92=2E Many FDC37xxxx includi=
ng the FDC37M81x as used in the Malta board have one, too -- where it must =
first be enabled=2E

>
>A couple of thoughts as to why I came to this conclusion: firstly the sup=
erio chip is generally considered to be a single integrated implementation =
of legacy IO devices, so this feels like a natural home for the PORT92 devi=
ce=2E

> Secondly the value of the "has-port92" property is controlled by pcms->i=
8042_enabled, and this value is already passed into functions such as pc_su=
perio_init() for example=2E

Rhight=2E There, it also controls the presence of port 92=2E If we move po=
rt 92 into the southbridges, we have to respect this command line switch th=
ere to preserve backward compatibility=2E

I wonder what `-M i8042` is supposed to do=2E If it is for modeling a stri=
pped-down x86 system, why not use the microvm instead? How is it possible t=
o omit an essential piece of hardware needed to boot x86 systems? Don't we =
need at least either one (i8042 or port 92)?

>
>I think this would also help reduce the changes required for the individu=
al machines, however the devil is always in the details particularly when m=
igration is involved=2E

As stated above, this series is more about modeling real hardware, in the =
hope that this will lend itself for configuration-driven machine creation=
=2E It is also about identifying obstacles towards this goal=2E Does it mak=
e sense to deprecate some machine-specific options such as i8042?

Best regards,
Bernhard

>
>
>ATB,
>
>Mark=2E
>

