Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A23FC5478A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:34:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoU2-0000Lx-4h; Wed, 21 Feb 2024 10:26:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rcoML-0000wk-Fu
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:18:12 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rcl0k-0007Zm-95
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 06:43:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7k30ACzpKa2rKS5+dmRM7qfouc1yR7zIpJ7tiHdP5g0=; b=s/Zmez0C4bsE6VmyIW5XM8+wJq
 ljXvrWHQLq7BtoXnyOQaBBTnt5qk4ropLBvxZkNmZqsC4StSek8tzWvWPMi/pTBZ3oBTEg2BshLFv
 lu6lpNExc65GoQ6m2mz6KLo1361piHNbkx7G56QzVLXlk/vEwEtec4OKg+e6b7UqlwinIgpESAxI3
 jWEei6QMTZMNayCT9Fwb/LrEmaCZWqj55Epe1wsTMquGLPLhYi8A+T6GUvZRgZwmd1MX0ax8WR0sN
 ekUDcwh7SRm42+ZHNq9NY+Xlevgc9LNqq8B7vNzlVfLRXz30I/gh2qvuUkkR6J7hkfvIqYtKQEQlt
 ++y+etf0NdkDKy/98jNyxkS25OI3ECS2Hv1IAxQ3uKjGKklvZScTFGyXtyDGXQgDhLZTnziQRX3U1
 SzcoahnAhaKrcmy03LFMl/o0QPvIcBNnuXlJYreRt/ixywUCEgpwaTQWcsmSo88NPo5MhPqTYYqwo
 MtHnO/07fiTXrzykXgCFTFc68KqTRX0qGFITNkNwHDJXrajw2MW9meqgpvRENfCmUGN6S2gqPb/PT
 PKfyFQ9UZJ9yxtLhLiimO2YgQYusqa7dDzmYM/3N9hVERCd6iZ0ycM4hJnVD+J/MKC4/Hll21Rn61
 rUG7eqb2kj3rL3l+NmKlf+pAr5OxC68BANk4BqQJk=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rckzw-0008HQ-HS; Wed, 21 Feb 2024 11:42:52 +0000
Message-ID: <26f9ca25-b828-4ca5-983a-5e8667239d01@ilande.co.uk>
Date: Wed, 21 Feb 2024 11:43:30 +0000
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
 <20240218131701.91132-3-shentey@gmail.com>
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
In-Reply-To: <20240218131701.91132-3-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 2/5] hw/i386/port92: Allow for TYPE_PORT92 to be embedded
 in devices
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

> Port 92 is an integral part of south bridges. Allow for embedding it there.
> 
> South bridges aren't architecture-specific, so move port92.c to hw/isa which is
> accessible to other architectures than x86.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   include/hw/i386/pc.h      |  5 -----
>   include/hw/isa/port92.h   | 30 ++++++++++++++++++++++++++++++
>   hw/i386/pc.c              |  1 +
>   hw/{i386 => isa}/port92.c | 14 +-------------
>   hw/i386/Kconfig           |  1 +
>   hw/i386/meson.build       |  3 +--
>   hw/i386/trace-events      |  4 ----
>   hw/isa/Kconfig            |  3 +++
>   hw/isa/meson.build        |  1 +
>   hw/isa/trace-events       |  4 ++++
>   10 files changed, 42 insertions(+), 24 deletions(-)
>   create mode 100644 include/hw/isa/port92.h
>   rename hw/{i386 => isa}/port92.c (91%)
> 
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index ec0e5efcb2..b2987209b1 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -188,11 +188,6 @@ void pc_nic_init(PCMachineClass *pcmc, ISABus *isa_bus, PCIBus *pci_bus);
>   
>   void pc_i8259_create(ISABus *isa_bus, qemu_irq *i8259_irqs);
>   
> -/* port92.c */
> -#define PORT92_A20_LINE "a20"
> -
> -#define TYPE_PORT92 "port92"
> -
>   /* pc_sysfw.c */
>   void pc_system_flash_create(PCMachineState *pcms);
>   void pc_system_flash_cleanup_unused(PCMachineState *pcms);
> diff --git a/include/hw/isa/port92.h b/include/hw/isa/port92.h
> new file mode 100644
> index 0000000000..214783d071
> --- /dev/null
> +++ b/include/hw/isa/port92.h
> @@ -0,0 +1,30 @@
> +/*
> + * QEMU I/O port 0x92 (System Control Port A, to handle Fast Gate A20)
> + *
> + * Copyright (c) 2003-2004 Fabrice Bellard
> + *
> + * SPDX-License-Identifier: MIT
> + */
> +
> +#ifndef HW_PORT92_H
> +#define HW_PORT92_H
> +
> +#include "exec/memory.h"
> +#include "hw/irq.h"
> +#include "hw/isa/isa.h"
> +#include "qom/object.h"
> +
> +#define TYPE_PORT92 "port92"
> +OBJECT_DECLARE_SIMPLE_TYPE(Port92State, PORT92)
> +
> +struct Port92State {
> +    ISADevice parent_obj;
> +
> +    MemoryRegion io;
> +    uint8_t outport;
> +    qemu_irq a20_out;
> +};
> +
> +#define PORT92_A20_LINE "a20"
> +
> +#endif /* HW_PORT92_H */
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 196827531a..0b11d4576e 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -32,6 +32,7 @@
>   #include "hw/i386/vmport.h"
>   #include "sysemu/cpus.h"
>   #include "hw/ide/internal.h"
> +#include "hw/isa/port92.h"
>   #include "hw/timer/hpet.h"
>   #include "hw/loader.h"
>   #include "hw/rtc/mc146818rtc.h"
> diff --git a/hw/i386/port92.c b/hw/isa/port92.c
> similarity index 91%
> rename from hw/i386/port92.c
> rename to hw/isa/port92.c
> index 1070bfbf36..06df06b088 100644
> --- a/hw/i386/port92.c
> +++ b/hw/isa/port92.c
> @@ -9,20 +9,8 @@
>   #include "qemu/osdep.h"
>   #include "sysemu/runstate.h"
>   #include "migration/vmstate.h"
> -#include "hw/irq.h"
> -#include "hw/i386/pc.h"
> +#include "hw/isa/port92.h"
>   #include "trace.h"
> -#include "qom/object.h"
> -
> -OBJECT_DECLARE_SIMPLE_TYPE(Port92State, PORT92)
> -
> -struct Port92State {
> -    ISADevice parent_obj;
> -
> -    MemoryRegion io;
> -    uint8_t outport;
> -    qemu_irq a20_out;
> -};
>   
>   static void port92_write(void *opaque, hwaddr addr, uint64_t val,
>                            unsigned size)
> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
> index a1846be6f7..ccf6de4a00 100644
> --- a/hw/i386/Kconfig
> +++ b/hw/i386/Kconfig
> @@ -37,6 +37,7 @@ config PC
>       select I8254
>       select PCKBD
>       select PCSPK
> +    select PORT92
>       select I8257
>       select MC146818RTC
>       # For ACPI builder:
> diff --git a/hw/i386/meson.build b/hw/i386/meson.build
> index b9c1ca39cb..94d558edd6 100644
> --- a/hw/i386/meson.build
> +++ b/hw/i386/meson.build
> @@ -24,8 +24,7 @@ i386_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-common.c'))
>   i386_ss.add(when: 'CONFIG_PC', if_true: files(
>     'pc.c',
>     'pc_sysfw.c',
> -  'acpi-build.c',
> -  'port92.c'))
> +  'acpi-build.c'))
>   i386_ss.add(when: 'CONFIG_X86_FW_OVMF', if_true: files('pc_sysfw_ovmf.c'),
>                                           if_false: files('pc_sysfw_ovmf-stubs.c'))
>   
> diff --git a/hw/i386/trace-events b/hw/i386/trace-events
> index 53c02d7ac8..b730589394 100644
> --- a/hw/i386/trace-events
> +++ b/hw/i386/trace-events
> @@ -118,10 +118,6 @@ vmport_command(unsigned char command) "command: 0x%02x"
>   x86_gsi_interrupt(int irqn, int level) "GSI interrupt #%d level:%d"
>   x86_pic_interrupt(int irqn, int level) "PIC interrupt #%d level:%d"
>   
> -# port92.c
> -port92_read(uint8_t val) "port92: read 0x%02x"
> -port92_write(uint8_t val) "port92: write 0x%02x"
> -
>   # vmmouse.c
>   vmmouse_get_status(void) ""
>   vmmouse_mouse_event(int x, int y, int dz, int buttons_state) "event: x=%d y=%d dz=%d state=%d"
> diff --git a/hw/isa/Kconfig b/hw/isa/Kconfig
> index 73c6470805..efdf43e92c 100644
> --- a/hw/isa/Kconfig
> +++ b/hw/isa/Kconfig
> @@ -49,6 +49,9 @@ config PIIX
>       select MC146818RTC
>       select USB_UHCI
>   
> +config PORT92
> +    bool
> +
>   config VT82C686
>       bool
>       select ISA_BUS
> diff --git a/hw/isa/meson.build b/hw/isa/meson.build
> index 3219282217..fb7cd44984 100644
> --- a/hw/isa/meson.build
> +++ b/hw/isa/meson.build
> @@ -5,6 +5,7 @@ system_ss.add(when: 'CONFIG_ISA_BUS', if_true: files('isa-bus.c'))
>   system_ss.add(when: 'CONFIG_ISA_SUPERIO', if_true: files('isa-superio.c'))
>   system_ss.add(when: 'CONFIG_PC87312', if_true: files('pc87312.c'))
>   system_ss.add(when: 'CONFIG_PIIX', if_true: files('piix.c'))
> +system_ss.add(when: 'CONFIG_PORT92', if_true: files('port92.c'))
>   system_ss.add(when: 'CONFIG_SMC37C669', if_true: files('smc37c669-superio.c'))
>   system_ss.add(when: 'CONFIG_VT82C686', if_true: files('vt82c686.c'))
>   
> diff --git a/hw/isa/trace-events b/hw/isa/trace-events
> index 1816e8307a..bb5d9f1078 100644
> --- a/hw/isa/trace-events
> +++ b/hw/isa/trace-events
> @@ -10,6 +10,10 @@ superio_create_ide(int id, uint16_t base, unsigned int irq) "id=%d, base 0x%03x,
>   pc87312_io_read(uint32_t addr, uint32_t val) "read addr=0x%x val=0x%x"
>   pc87312_io_write(uint32_t addr, uint32_t val) "write addr=0x%x val=0x%x"
>   
> +# port92.c
> +port92_read(uint8_t val) "port92: read 0x%02x"
> +port92_write(uint8_t val) "port92: write 0x%02x"
> +
>   # apm.c
>   apm_io_read(uint8_t addr, uint8_t val) "read addr=0x%x val=0x%02x"
>   apm_io_write(uint8_t addr, uint8_t val) "write addr=0x%x val=0x%02x"

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


