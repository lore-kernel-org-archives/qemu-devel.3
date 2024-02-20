Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD65C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 06:02:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcJCP-0004ug-Fu; Tue, 20 Feb 2024 01:01:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcJCO-0004uW-3o
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 01:01:48 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcJCL-0005WD-4m
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 01:01:47 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-41264c364fbso13684275e9.1
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 22:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708408903; x=1709013703; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XWbyPdGh0ueULcmS1MLlyaBDL20X7SsEwFK3VXSZqrw=;
 b=lC39Wt3nTxaLylEBxoI4LqpKbtkVRwknnBoSgHCzU54XuX2i7SRspjwl9FG/wYw9lz
 qWKuB2M68w8vqeCsAhepWmrkU85sCFs8MDSmhCXujNdzqODlXq+Y/z7b/sbb+sJXh3mh
 GGsXygRvmS1CEr5UOmAHLFqMuOGLl0VMjbMYS7N47gfsIe/R7tpXiAcex0yfkXJjPFNE
 +Ovtn6czUypVQP6XUytl8koVpbspy+8Sp/xLHI1Y7fg9TRE98rN9GbtTJQAqCOUQtMYM
 Aciqbrgnr1x307v9an1IcneeIcxReTQ7T2uc+oXu0H401MEmLvn6X35tkoCmvFdCYRa+
 ugow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708408903; x=1709013703;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XWbyPdGh0ueULcmS1MLlyaBDL20X7SsEwFK3VXSZqrw=;
 b=cckhYOPk/IMzxjyuqEQT7GfT0og050lOO5PKTOp/owOeyQoKyGVjDFSOzYumDh7Izv
 8dZ1LwhANq+KCarvN7gLL7h3rKXxRvQ96cgmUvrEtB2QTmCcwk9mGT+sj2KqtfHEg4dh
 fXInXlv4CgUsr1eCbFc35RW/aviDtO3TZE/dLZAOH4sZiJnOyPCzClOsBtR9tqhpmGp7
 miTW2Q0GCf94MF3RpUqJedByXVjQH8+AkEKVUh9sCi8Ey+xL/JkuPybf6KozRVk8RD6T
 NJxxERD9CGj7hSkp0ucZJAezP5HUNOgYHxsdAdiqWwiUeFXAj0tsCCHGdpFiLDAu7TYI
 xLEw==
X-Gm-Message-State: AOJu0YzbNKkgXtamzl7mWYkNhQAWJfFr3WDT5JAIDa/201q7KOEmsTL2
 PdKnB9DiyM2xmzi3/CWnrf/XRcuzaAYs2AocmwB+aagLljfw+xAPOLAnt9j7QIk=
X-Google-Smtp-Source: AGHT+IHqiEdKEYsQWAeyRMXDlTcr7VzghlKHgaXacLiyG6uCIuprtKZuO+4jjQDw51IaaeoB5kOPGQ==
X-Received: by 2002:a1c:770a:0:b0:411:ea5e:6165 with SMTP id
 t10-20020a1c770a000000b00411ea5e6165mr11013361wmi.33.1708408902801; 
 Mon, 19 Feb 2024 22:01:42 -0800 (PST)
Received: from [192.168.69.100] (mek33-h02-176-184-23-7.dsl.sta.abo.bbox.fr.
 [176.184.23.7]) by smtp.gmail.com with ESMTPSA id
 6-20020a05600c22c600b004120537210esm13321416wmg.46.2024.02.19.22.01.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Feb 2024 22:01:42 -0800 (PST)
Message-ID: <de2caec4-c77b-4e1d-ad49-e1af3c515442@linaro.org>
Date: Tue, 20 Feb 2024 07:01:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/14] hw/southbridge/ich9: Add a AHCI function
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Bernhard Beschow <shentey@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240219163855.87326-1-philmd@linaro.org>
 <20240219163855.87326-10-philmd@linaro.org>
 <6cf6d2f4-5f24-fcb9-16c4-ab66d7b5e724@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <6cf6d2f4-5f24-fcb9-16c4-ab66d7b5e724@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 19/2/24 19:31, BALATON Zoltan wrote:
> On Mon, 19 Feb 2024, Philippe Mathieu-Daudé wrote:
>> Instantiate TYPE_ICH9_AHCI in TYPE_ICH9_SOUTHBRIDGE.
>>
>> Since the PC machines can disable SATA (see the
>> PC_MACHINE_SATA dynamic property), add the 'sata-enabled'
>> property to disable it.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> MAINTAINERS                   |  2 ++
>> include/hw/southbridge/ich9.h |  4 ----
>> hw/i386/pc_q35.c              | 25 ++++---------------------
>> hw/southbridge/ich9.c         | 35 +++++++++++++++++++++++++++++++++++
>> hw/i386/Kconfig               |  1 -
>> hw/southbridge/Kconfig        |  1 +
>> 6 files changed, 42 insertions(+), 26 deletions(-)


>> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
>> index 2f15af540f..060358d449 100644
>> --- a/hw/i386/pc_q35.c
>> +++ b/hw/i386/pc_q35.c
>> @@ -61,9 +61,6 @@
>> #include "hw/acpi/acpi.h"
>> #include "target/i386/cpu.h"
>>
>> -/* ICH9 AHCI has 6 ports */
>> -#define MAX_SATA_PORTS     6
>> -
>> struct ehci_companions {
>>     const char *name;
>>     int func;
>> @@ -129,7 +126,7 @@ static void pc_q35_init(MachineState *machine)
>>     PCIDevice *lpc;
>>     Object *lpc_obj;
>>     DeviceState *lpc_dev;
>> -    BusState *idebus[MAX_SATA_PORTS];
>> +    BusState *idebus[2] = { };

[*]

>>     ISADevice *rtc_state;
>>     MemoryRegion *system_memory = get_system_memory();
>>     MemoryRegion *system_io = get_system_io();
>> @@ -138,7 +135,6 @@ static void pc_q35_init(MachineState *machine)
>>     ISABus *isa_bus;
>>     int i;
>>     ram_addr_t lowmem;
>> -    DriveInfo *hd[MAX_SATA_PORTS];
>>     MachineClass *mc = MACHINE_GET_CLASS(machine);
>>     bool acpi_pcihp;
>>     bool keep_pci_slot_hpc;
>> @@ -239,6 +235,7 @@ static void pc_q35_init(MachineState *machine)
>>     object_property_set_link(OBJECT(ich9), "mch-pcie-bus",
>>                              OBJECT(host_bus), &error_abort);
>>     qdev_prop_set_bit(ich9, "d2p-enabled", false);
>> +    qdev_prop_set_bit(ich9, "sata-enabled", pcms->sata_enabled);
>>     qdev_realize_and_unref(ich9, NULL, &error_fatal);
>>
>>     /* irq lines */
>> @@ -302,22 +299,8 @@ static void pc_q35_init(MachineState *machine)
>>                          0xff0104);
>>
>>     if (pcms->sata_enabled) {
> 
> Shouldn't this condition be inverted if you only leave the else leg?

idebus[] is NULL-initialized in [*] so we can remove the else
ladder.

> 
> Regards,.
> BALATON Zoltan
> 
>> -        PCIDevice *pdev;
>> -        AHCIPCIState *ich9;
>> -
>> -        /* ahci and SATA device, for q35 1 ahci controller is 
>> built-in */
>> -        pdev = pci_create_simple_multifunction(host_bus,
>> -                                               PCI_DEVFN(ICH9_SATA1_DEV,
>> -                                                         
>> ICH9_SATA1_FUNC),
>> -                                               "ich9-ahci");
>> -        ich9 = ICH9_AHCI(pdev);
>> -        idebus[0] = qdev_get_child_bus(DEVICE(pdev), "ide.0");
>> -        idebus[1] = qdev_get_child_bus(DEVICE(pdev), "ide.1");
>> -        g_assert(MAX_SATA_PORTS == ich9->ahci.ports);
>> -        ide_drive_get(hd, ich9->ahci.ports);
>> -        ahci_ide_create_devs(&ich9->ahci, hd);
>> -    } else {
>> -        idebus[0] = idebus[1] = NULL;
>> +        idebus[0] = qdev_get_child_bus(ich9, "ide.0");
>> +        idebus[1] = qdev_get_child_bus(ich9, "ide.1");
>>     }


