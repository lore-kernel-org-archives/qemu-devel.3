Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21648C48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:52:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoWp-0007md-L5; Wed, 21 Feb 2024 10:28:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rcoOM-0001R2-Id
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:20:14 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rclAF-0000r2-0k
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 06:53:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qUwsIaIJkH507gOAw6tYExAUSgUlUU1LHsOYXVYM688=; b=1VBBQtLxzUt8ozxWr8g2CuSLYt
 GEbnDZmqxjBsN087XSJBJLbDeTXneKA/ZmYZimZjr0CZM6XxSVEMnd8tPBIhSlOmiRPB3Npza+FvM
 mCGJPh2MgTtg9t9uGI1Eba4t5X3tAlGZVBjArL7JO+U+lYXJ0Lq63bja64Zy/7tO31Rv1moSIpLFC
 iWPQZNC3Z2ToGdbIINOvyT6GrAj7G9rck9hYUf17JsmgFuhmW32q/AEjhb6Lkr7GUh0+UWdBb+arm
 Qy9g00DyPUa5N/QTAElK6ycggNUH3RMUQgfDTw+XP0a7ANSj1hmovZ58huUkvroKRqBNzoFYXtWdg
 oCK9VoF+I4qfoIigsZqHavX9kPsgD9yAOBFr8yji3DUZHW3Ho4S8ZkjzzLytCkZTz+6u6hFqqMHpZ
 tj8N77s/J23eNL3biH5PFvRyjKujOmSFByPgwIIS/O78hZ05OsS5yMfuQ4X8ZTfiqe024M4Prgikq
 A+68BNyUgnurPmMrFYtpNJDYE0gkyVFXRi937wEjk98uqP87Ey/eY3K0kFM2dkuXj2CBD6g3AZshJ
 RpHtp6/sfRSFAaGJb2m6yayxseQAlMj7Sxi6MuBUHD2MrGOpkdJQfWuH5zDxpq/PHNVruYOuYUKWc
 cptwtJ+H1h0/aSMuGWo1pMMB4YVO+H7TInXovxqg8=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rcl9V-0008MU-1Q; Wed, 21 Feb 2024 11:52:41 +0000
Message-ID: <6a2333d7-9dea-4a0e-9d91-0889e6205128@ilande.co.uk>
Date: Wed, 21 Feb 2024 11:53:21 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>
References: <20240218131701.91132-1-shentey@gmail.com>
 <20240218131701.91132-4-shentey@gmail.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 xsBNBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAHNME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPsLA
 eAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63M7ATQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABwsBfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
In-Reply-To: <20240218131701.91132-4-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 3/5] hw/isa: Embed TYPE_PORT92 in south bridges used in PC
 machines
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 18/02/2024 13:16, Bernhard Beschow wrote:

> Port 92 is an integral part of the PIIX and ICH south bridges, so instantiate it
> there. The isapc machine now needs to instantiate it explicitly, analoguous to
> the RTC.
> 
> Note that due to migration compatibility, port92 is optional in the south
> bridges. It is always instantiated the isapc machine for simplicity.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   include/hw/i386/pc.h          |  2 +-
>   include/hw/southbridge/ich9.h |  4 ++++
>   include/hw/southbridge/piix.h |  3 +++
>   hw/i386/pc.c                  | 18 ++++++++++++------
>   hw/i386/pc_piix.c             |  9 +++++++--
>   hw/i386/pc_q35.c              |  8 +++++---
>   hw/isa/lpc_ich9.c             |  9 +++++++++
>   hw/isa/piix.c                 |  9 +++++++++
>   hw/isa/Kconfig                |  2 ++
>   9 files changed, 52 insertions(+), 12 deletions(-)
> 
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index b2987209b1..a9ff1f5ab3 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -178,7 +178,7 @@ uint64_t pc_pci_hole64_start(void);
>   DeviceState *pc_vga_init(ISABus *isa_bus, PCIBus *pci_bus);
>   void pc_basic_device_init(struct PCMachineState *pcms,
>                             ISABus *isa_bus, qemu_irq *gsi,
> -                          ISADevice *rtc_state,
> +                          ISADevice *rtc_state, ISADevice *port92,
>                             bool create_fdctrl,
>                             uint32_t hpet_irqs);
>   void pc_cmos_init(PCMachineState *pcms,
> diff --git a/include/hw/southbridge/ich9.h b/include/hw/southbridge/ich9.h
> index fd01649d04..d70a94f5e7 100644
> --- a/include/hw/southbridge/ich9.h
> +++ b/include/hw/southbridge/ich9.h
> @@ -3,6 +3,7 @@
>   
>   #include "hw/isa/apm.h"
>   #include "hw/acpi/ich9.h"
> +#include "hw/isa/port92.h"
>   #include "hw/intc/ioapic.h"
>   #include "hw/pci/pci.h"
>   #include "hw/pci/pci_device.h"
> @@ -32,6 +33,7 @@ struct ICH9LPCState {
>       uint8_t irr[PCI_SLOT_MAX][PCI_NUM_PINS];
>   
>       MC146818RtcState rtc;
> +    Port92State port92;
>       APMState apm;
>       ICH9LPCPMRegs pm;
>       uint32_t sci_level; /* track sci level */
> @@ -54,6 +56,8 @@ struct ICH9LPCState {
>       uint8_t rst_cnt;
>       MemoryRegion rst_cnt_mem;
>   
> +    bool has_port92;
> +
>       /* SMI feature negotiation via fw_cfg */
>       uint64_t smi_host_features;       /* guest-invisible, host endian */
>       uint8_t smi_host_features_le[8];  /* guest-visible, read-only, little
> diff --git a/include/hw/southbridge/piix.h b/include/hw/southbridge/piix.h
> index 86709ba2e4..35058529d1 100644
> --- a/include/hw/southbridge/piix.h
> +++ b/include/hw/southbridge/piix.h
> @@ -15,6 +15,7 @@
>   #include "hw/pci/pci_device.h"
>   #include "hw/acpi/piix4.h"
>   #include "hw/ide/pci.h"
> +#include "hw/isa/port92.h"
>   #include "hw/rtc/mc146818rtc.h"
>   #include "hw/usb/hcd-uhci.h"
>   
> @@ -56,6 +57,7 @@ struct PIIXState {
>       int32_t pci_irq_levels_vmstate[PIIX_NUM_PIRQS];
>   
>       MC146818RtcState rtc;
> +    Port92State port92;
>       PCIIDEState ide;
>       UHCIState uhci;
>       PIIX4PMState pm;
> @@ -71,6 +73,7 @@ struct PIIXState {
>       bool has_acpi;
>       bool has_pic;
>       bool has_pit;
> +    bool has_port92;
>       bool has_usb;
>       bool smm_enabled;
>   };
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 0b11d4576e..8b601ea6cf 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1160,7 +1160,7 @@ static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl,
>       int i;
>       DriveInfo *fd[MAX_FD];
>       qemu_irq *a20_line;
> -    ISADevice *fdc, *i8042, *port92, *vmmouse;
> +    ISADevice *fdc, *i8042, *vmmouse;
>   
>       serial_hds_isa_init(isa_bus, 0, MAX_ISA_SERIAL_PORTS);
>       parallel_hds_isa_init(isa_bus, MAX_PARALLEL_PORTS);
> @@ -1193,18 +1193,15 @@ static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl,
>                                    &error_abort);
>           isa_realize_and_unref(vmmouse, isa_bus, &error_fatal);
>       }
> -    port92 = isa_create_simple(isa_bus, TYPE_PORT92);
>   
> -    a20_line = qemu_allocate_irqs(handle_a20_line_change, first_cpu, 2);
> +    a20_line = qemu_allocate_irqs(handle_a20_line_change, first_cpu, 1);
>       i8042_setup_a20_line(i8042, a20_line[0]);
> -    qdev_connect_gpio_out_named(DEVICE(port92),
> -                                PORT92_A20_LINE, 0, a20_line[1]);
>       g_free(a20_line);
>   }
>   
>   void pc_basic_device_init(struct PCMachineState *pcms,
>                             ISABus *isa_bus, qemu_irq *gsi,
> -                          ISADevice *rtc_state,
> +                          ISADevice *rtc_state, ISADevice *port92,
>                             bool create_fdctrl,
>                             uint32_t hpet_irqs)
>   {
> @@ -1296,6 +1293,15 @@ void pc_basic_device_init(struct PCMachineState *pcms,
>       /* Super I/O */
>       pc_superio_init(isa_bus, create_fdctrl, pcms->i8042_enabled,
>                       pcms->vmport != ON_OFF_AUTO_ON);
> +
> +    if (port92) {
> +        qemu_irq *a20_line;
> +
> +        a20_line = qemu_allocate_irqs(handle_a20_line_change, first_cpu, 1);
> +        qdev_connect_gpio_out_named(DEVICE(port92),
> +                                    PORT92_A20_LINE, 0, a20_line[0]);
> +        g_free(a20_line);
> +    }
>   }
>   
>   void pc_nic_init(PCMachineClass *pcmc, ISABus *isa_bus, PCIBus *pci_bus)
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 999b7b806c..dfdfd36551 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -115,7 +115,7 @@ static void pc_init1(MachineState *machine,
>       qemu_irq smi_irq;
>       GSIState *gsi_state;
>       BusState *idebus[MAX_IDE_BUS];
> -    ISADevice *rtc_state;
> +    ISADevice *rtc_state, *port92;
>       MemoryRegion *ram_memory;
>       MemoryRegion *pci_memory = NULL;
>       MemoryRegion *rom_memory = system_memory;
> @@ -269,6 +269,8 @@ static void pc_init1(MachineState *machine,
>                                    &error_abort);
>           object_property_set_bool(OBJECT(pci_dev), "has-pit", false,
>                                    &error_abort);
> +        object_property_set_bool(OBJECT(pci_dev), "has-port92",
> +                                 pcms->i8042_enabled, &error_abort);
>           qdev_prop_set_uint32(DEVICE(pci_dev), "smb_io_base", 0xb100);
>           object_property_set_bool(OBJECT(pci_dev), "smm-enabled",
>                                    x86_machine_is_smm_enabled(x86ms),
> @@ -296,6 +298,8 @@ static void pc_init1(MachineState *machine,
>           isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(pci_dev), "isa.0"));
>           rtc_state = ISA_DEVICE(object_resolve_path_component(OBJECT(pci_dev),
>                                                                "rtc"));
> +        port92 = ISA_DEVICE(object_resolve_path_component(OBJECT(pci_dev),
> +                                                          "port92"));
>           piix4_pm = object_resolve_path_component(OBJECT(pci_dev), "pm");
>           dev = DEVICE(object_resolve_path_component(OBJECT(pci_dev), "ide"));
>           pci_ide_create_devs(PCI_DEVICE(dev));
> @@ -310,6 +314,7 @@ static void pc_init1(MachineState *machine,
>           qdev_prop_set_int32(DEVICE(rtc_state), "base_year", 2000);
>           isa_realize_and_unref(rtc_state, isa_bus, &error_fatal);
>   
> +        port92 = isa_create_simple(isa_bus, TYPE_PORT92);
>           i8257_dma_init(OBJECT(machine), isa_bus, 0);
>           pcms->hpet_enabled = false;
>           idebus[0] = NULL;
> @@ -336,7 +341,7 @@ static void pc_init1(MachineState *machine,
>       }
>   
>       /* init basic PC hardware */
> -    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, rtc_state, true,
> +    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, rtc_state, port92, true,
>                            0x4);
>   
>       pc_nic_init(pcmc, isa_bus, pci_bus);
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index d346fa3b1d..26bb1c2cb9 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -127,7 +127,7 @@ static void pc_q35_init(MachineState *machine)
>       PCIDevice *lpc;
>       DeviceState *lpc_dev;
>       BusState *idebus[MAX_SATA_PORTS];
> -    ISADevice *rtc_state;
> +    ISADevice *rtc_state, *port92;
>       MemoryRegion *system_memory = get_system_memory();
>       MemoryRegion *system_io = get_system_io();
>       MemoryRegion *pci_memory = g_new(MemoryRegion, 1);
> @@ -238,6 +238,7 @@ static void pc_q35_init(MachineState *machine)
>       lpc = pci_new_multifunction(PCI_DEVFN(ICH9_LPC_DEV, ICH9_LPC_FUNC),
>                                   TYPE_ICH9_LPC_DEVICE);
>       lpc_dev = DEVICE(lpc);
> +    qdev_prop_set_bit(lpc_dev, "has-port92", pcms->i8042_enabled);
>       qdev_prop_set_bit(lpc_dev, "smm-enabled",
>                         x86_machine_is_smm_enabled(x86ms));
>       pci_realize_and_unref(lpc, host_bus, &error_fatal);
> @@ -246,6 +247,7 @@ static void pc_q35_init(MachineState *machine)
>       }
>   
>       rtc_state = ISA_DEVICE(object_resolve_path_component(OBJECT(lpc), "rtc"));
> +    port92 = ISA_DEVICE(object_resolve_path_component(OBJECT(lpc), "port92"));
>   
>       object_property_add_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
>                                TYPE_HOTPLUG_HANDLER,
> @@ -287,8 +289,8 @@ static void pc_q35_init(MachineState *machine)
>       }
>   
>       /* init basic PC hardware */
> -    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, rtc_state, !mc->no_floppy,
> -                         0xff0104);
> +    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, rtc_state, port92,
> +                         !mc->no_floppy, 0xff0104);
>   
>       if (pcms->sata_enabled) {
>           PCIDevice *pdev;
> diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
> index 70c6e8a093..3be5bc01b1 100644
> --- a/hw/isa/lpc_ich9.c
> +++ b/hw/isa/lpc_ich9.c
> @@ -749,6 +749,14 @@ static void ich9_lpc_realize(PCIDevice *d, Error **errp)
>       irq = object_property_get_uint(OBJECT(&lpc->rtc), "irq", &error_fatal);
>       isa_connect_gpio_out(ISA_DEVICE(&lpc->rtc), 0, irq);
>   
> +    if (lpc->has_port92) {
> +        object_initialize_child(OBJECT(lpc), "port92", &lpc->port92,
> +                                TYPE_PORT92);
> +        if (!qdev_realize(DEVICE(&lpc->port92), BUS(isa_bus), errp)) {
> +            return;
> +        }
> +    }
> +
>       pci_bus_irqs(pci_bus, ich9_lpc_set_irq, d, ICH9_LPC_NB_PIRQS);
>       pci_bus_map_irqs(pci_bus, ich9_lpc_map_irq);
>       pci_bus_set_route_irq_fn(pci_bus, ich9_route_intx_pin_to_irq);
> @@ -821,6 +829,7 @@ static Property ich9_lpc_properties[] = {
>       DEFINE_PROP_BOOL("noreboot", ICH9LPCState, pin_strap.spkr_hi, false),
>       DEFINE_PROP_BOOL("smm-compat", ICH9LPCState, pm.smm_compat, false),
>       DEFINE_PROP_BOOL("smm-enabled", ICH9LPCState, pm.smm_enabled, false),
> +    DEFINE_PROP_BOOL("has-port92", ICH9LPCState, has_port92, true),
>       DEFINE_PROP_BIT64("x-smi-broadcast", ICH9LPCState, smi_host_features,
>                         ICH9_LPC_SMI_F_BROADCAST_BIT, true),
>       DEFINE_PROP_BIT64("x-smi-cpu-hotplug", ICH9LPCState, smi_host_features,
> diff --git a/hw/isa/piix.c b/hw/isa/piix.c
> index 2d30711b17..4c12855461 100644
> --- a/hw/isa/piix.c
> +++ b/hw/isa/piix.c
> @@ -346,6 +346,14 @@ static void pci_piix_realize(PCIDevice *dev, const char *uhci_type,
>       irq = object_property_get_uint(OBJECT(&d->rtc), "irq", &error_fatal);
>       isa_connect_gpio_out(ISA_DEVICE(&d->rtc), 0, irq);
>   
> +    /* Port 92 */
> +    if (d->has_port92) {
> +        object_initialize_child(OBJECT(d), "port92", &d->port92, TYPE_PORT92);
> +        if (!qdev_realize(DEVICE(&d->port92), BUS(isa_bus), errp)) {
> +            return;
> +        }
> +    }
> +
>       /* IDE */
>       qdev_prop_set_int32(DEVICE(&d->ide), "addr", dev->devfn + 1);
>       if (!qdev_realize(DEVICE(&d->ide), BUS(pci_bus), errp)) {
> @@ -413,6 +421,7 @@ static Property pci_piix_props[] = {
>       DEFINE_PROP_BOOL("has-acpi", PIIXState, has_acpi, true),
>       DEFINE_PROP_BOOL("has-pic", PIIXState, has_pic, true),
>       DEFINE_PROP_BOOL("has-pit", PIIXState, has_pit, true),
> +    DEFINE_PROP_BOOL("has-port92", PIIXState, has_port92, true),
>       DEFINE_PROP_BOOL("has-usb", PIIXState, has_usb, true),
>       DEFINE_PROP_BOOL("smm-enabled", PIIXState, smm_enabled, false),
>       DEFINE_PROP_END_OF_LIST(),
> diff --git a/hw/isa/Kconfig b/hw/isa/Kconfig
> index efdf43e92c..f42a087c07 100644
> --- a/hw/isa/Kconfig
> +++ b/hw/isa/Kconfig
> @@ -47,6 +47,7 @@ config PIIX
>       select IDE_PIIX
>       select ISA_BUS
>       select MC146818RTC
> +    select PORT92
>       select USB_UHCI
>   
>   config PORT92
> @@ -78,3 +79,4 @@ config LPC_ICH9
>       select ISA_BUS
>       select ACPI_ICH9
>       select MC146818RTC
> +    select PORT92

I had a look at this (and did a bit of revision around 8042 and A20), and I am 
starting to wonder if the PORT92 device isn't something that belongs to the 
southbridge, but more specifically to the superio chip?

A couple of thoughts as to why I came to this conclusion: firstly the superio chip is 
generally considered to be a single integrated implementation of legacy IO devices, 
so this feels like a natural home for the PORT92 device. Secondly the value of the 
"has-port92" property is controlled by pcms->i8042_enabled, and this value is already 
passed into functions such as pc_superio_init() for example.

I think this would also help reduce the changes required for the individual machines, 
however the devil is always in the details particularly when migration is involved.


ATB,

Mark.


