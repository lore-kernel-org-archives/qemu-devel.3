Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DFB0CCF9F8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Nov 2025 00:08:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEz8k-0002ww-3Z; Fri, 31 Oct 2025 20:06:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vEz8b-0002wk-Eh
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 20:06:33 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vEz8V-0002N8-9P
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 20:06:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=dlvla6Q7xrDcG6C6E9+qzzC336rgHPPw1zm6fSy0Ssg=; b=bB4qfBsZIC2Po0w7cn2mUm1AXg
 daIJoQrkKfX/OCawY/w/5v0WmSm6Rh7BTdaAU/DjJxKug3PQvSNo9tqw173UYhwLWVhYxx5LLVjob
 P1eySjfKu2uVR8Knndbl/NQDj0ZeHlumrfM45vq5SExjBW0n0qhqyb7mvRaxW8LKVQLZZLVt14OOH
 /VFf/5ixXRFYAMqZk7cq76e+1p7B7Ti19Z4AEea5vcqTYLpIBFhCdZMakKQWjM0FlnJzDZQQFt9Yk
 +1LNDPi97NdZcQr1xSpqkiQkJ9AuNoUHnSvlzbpLGK4+xIcUyvLm+rimLkjM56AVnVESre/r3L43K
 EL/F+2eY06yAqh8GRk368s45DrUnn9OlZJvxk+F5BfRlXuEAhgZbfVT4w5XnQkptw2UBmT+NHI1Ni
 OXibITtYH++XOxBFg52/pXCJYyfhsy5OFVlBj33neE0T03rgm7CyemIi7tscYYNWKece/JpcKmkU2
 ko7U41H/453yeqIX0hnpmH5BVTqPU5IMQ2xb15Xpk2+88rClATeWKOZoMA8pzn7b7yZiEugylN2ZB
 JoHZoaz2Jl3GfngqvfxjaVh0ZzToejSf2bXec1xH3ogntYgHFWfNljVNdCCAqtlmZ4rI3qQ4FoHBM
 J5zh+xkjTQ+DqNCsCobY9YIHDDj2kp1ovkJc6ZoE8=;
Received: from [2a02:8012:2f01:0:13e4:9053:ba25:9d4b]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vEz68-0006rJ-5p; Sat, 01 Nov 2025 00:04:00 +0000
Message-ID: <eb8782cd-5d31-4a27-a8d7-68361025d801@ilande.co.uk>
Date: Sat, 1 Nov 2025 00:06:13 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>, deller@gmx.de,
 qemu-devel@nongnu.org
Cc: sarkarsoumyajyoti23@gmail.com,
 Richard Henderson <richard.henderson@linaro.org>,
 Jason Wang <jasowang@redhat.com>
References: <20251031211516.208488-1-soumyajyotisarkar23@gmail.com>
 <20251031211516.208488-2-soumyajyotisarkar23@gmail.com>
Content-Language: en-US
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
In-Reply-To: <20251031211516.208488-2-soumyajyotisarkar23@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:13e4:9053:ba25:9d4b
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 1/3] hw/hppa: Enable LASI i82596 network on 715 machine
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 31/10/2025 21:15, Soumyajyotii Ssarkar wrote:

> From: RemZapCypher <soumyajyotisarkar23@gmail.com>
> 
> Enable the i82596 network chip which is included in the LASI
> multi I/O chip. Since LASI has different start addresses on
> the various machines, always initialize the LASI components
> by their offsets.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   hw/hppa/hppa_hardware.h | 20 ++++++++++++--------
>   hw/hppa/machine.c       | 25 +++++++++++--------------
>   2 files changed, 23 insertions(+), 22 deletions(-)
> 
> diff --git a/hw/hppa/hppa_hardware.h b/hw/hppa/hppa_hardware.h
> index d422af0429..a8a496c0e1 100644
> --- a/hw/hppa/hppa_hardware.h
> +++ b/hw/hppa/hppa_hardware.h
> @@ -21,14 +21,6 @@
>   #define DINO_SCSI_HPA   0xfff8c000
>   #define LASI_HPA_715    0xf0100000
>   #define LASI_HPA        0xffd00000
> -#define LASI_UART_HPA   0xffd05000
> -#define LASI_SCSI_HPA   0xffd06000
> -#define LASI_LAN_HPA    0xffd07000
> -#define LASI_RTC_HPA    0xffd09000
> -#define LASI_LPT_HPA    0xffd02000
> -#define LASI_AUDIO_HPA  0xffd04000
> -#define LASI_PS2KBD_HPA 0xffd08000
> -#define LASI_PS2MOU_HPA 0xffd08100
>   #define LASI_GFX_HPA    0xf8000000
>   #define ARTIST_FB_ADDR  0xf9000000
>   #define CPU_HPA         0xfffb0000
> @@ -44,6 +36,18 @@
>   
>   #define SCSI_HPA        0xf1040000      /* emulated SCSI, needs to be in f region */
>   
> +#define HPA_DISABLED_DEVICE     1       /* add to HPA to disable */
> +
> +/* LASI offsets */
> +#define LASI_LPT        0x02000
> +#define LASI_AUDIO      0x04000
> +#define LASI_UART       0x05000
> +#define LASI_SCSI       0x06000
> +#define LASI_LAN        0x07000
> +#define LASI_PS2        0x08000
> +#define LASI_RTC        0x09000
> +#define LASI_FDC        0x0A000
> +
>   /* offsets to DINO HPA: */
>   #define DINO_PCI_ADDR           0x064
>   #define DINO_CONFIG_DATA        0x068
> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> index cbca0026ab..7c5297c071 100644
> --- a/hw/hppa/machine.c
> +++ b/hw/hppa/machine.c
> @@ -50,8 +50,6 @@ struct HppaMachineState {
>   #define HPA_POWER_BUTTON        (FIRMWARE_END - 0x10)
>   static hwaddr soft_power_reg;
>   
> -#define enable_lasi_lan()       0
> -
>   static DeviceState *lasi_dev;
>   
>   static void hppa_powerdown_req(Notifier *n, void *opaque)
> @@ -376,13 +374,6 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
>           }
>       }
>   
> -    /* Network setup. */
> -    if (lasi_dev) {
> -        lasi_82596_init(addr_space, translate(NULL, LASI_LAN_HPA),
> -                        qdev_get_gpio_in(lasi_dev, LASI_IRQ_LAN_HPA),
> -                        enable_lasi_lan());
> -    }
> -
>       if (pci_bus) {
>           pci_init_nic_devices(pci_bus, mc->default_nic);
>   
> @@ -595,6 +586,11 @@ static void machine_HP_715_init(MachineState *machine)
>           lasi_ncr710_handle_legacy_cmdline(dev);
>       }
>   
> +    /* LASI i82596 network */
> +    lasi_82596_init(addr_space, translate(NULL, LASI_HPA_715 + LASI_LAN),
> +                    qdev_get_gpio_in(lasi_dev, LASI_IRQ_LAN_HPA),
> +                    true);
> +

The lasi_82596_init() function should not belong to the device in 
hw/net/lasi_i82596.c since it attempts to wire up the NIC in a sysbus-specific way 
which is not valid for other buses.

Having a look at lasi_82596_init() there are a few things wrong with it:
   - qemu_create_nic_device() should be done in lasi_82596_instance_init()
   - s->state.irq should not be set directly, but instead be initialised
     as a qdev gpio in lasi_82596_instance_init() and then connected by the board

One solution might be to make these changes and then move the remainder of 
lasi_82596_init() into hw/hppa/machine.c and then remove the function declaration 
from the lasi_82596.h.

>       /* Add NICs, graphics & load firmware */
>       machine_HP_common_init_tail(machine, NULL, translate);
>   }
> @@ -638,7 +634,7 @@ static void machine_HP_B160L_init(MachineState *machine)
>       assert(isa_bus);
>   
>       /* Serial ports: Lasi and Dino use a 7.272727 MHz clock. */
> -    serial_mm_init(addr_space, translate(NULL, LASI_UART_HPA + 0x800), 0,
> +    serial_mm_init(addr_space, translate(NULL, LASI_HPA + LASI_UART + 0x800), 0,
>           qdev_get_gpio_in(lasi_dev, LASI_IRQ_UART_HPA), 7272727 / 16,
>           serial_hd(0), DEVICE_BIG_ENDIAN);
>   
> @@ -647,7 +643,8 @@ static void machine_HP_B160L_init(MachineState *machine)
>           serial_hd(1), DEVICE_BIG_ENDIAN);
>   
>       /* Parallel port */
> -    parallel_mm_init(addr_space, translate(NULL, LASI_LPT_HPA + 0x800), 0,
> +    parallel_mm_init(addr_space,
> +                     translate(NULL, LASI_HPA + LASI_LPT + 0x800), 0,
>                        qdev_get_gpio_in(lasi_dev, LASI_IRQ_LPT_HPA),
>                        parallel_hds[0]);
>   
> @@ -657,11 +654,11 @@ static void machine_HP_B160L_init(MachineState *machine)
>       sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
>                          qdev_get_gpio_in(lasi_dev, LASI_IRQ_PS2KBD_HPA));
>       memory_region_add_subregion(addr_space,
> -                                translate(NULL, LASI_PS2KBD_HPA),
> +                                translate(NULL, LASI_HPA + LASI_PS2),
>                                   sysbus_mmio_get_region(SYS_BUS_DEVICE(dev),
>                                                          0));
>       memory_region_add_subregion(addr_space,
> -                                translate(NULL, LASI_PS2KBD_HPA + 0x100),
> +                                translate(NULL, LASI_HPA + LASI_PS2 + 0x100),
>                                   sysbus_mmio_get_region(SYS_BUS_DEVICE(dev),
>                                                          1));
>   
> @@ -832,7 +829,7 @@ static void HP_715_machine_init_class_init(ObjectClass *oc, const void *data)
>       /* can only support up to max. 8 CPUs due inventory major numbers */
>       mc->max_cpus = MIN_CONST(HPPA_MAX_CPUS, 8);
>       mc->default_ram_size = 256 * MiB;
> -    mc->default_nic = NULL;
> +    mc->default_nic = "lasi_82596";

This should be TYPE_LASI_82596.


ATB,

Mark.


