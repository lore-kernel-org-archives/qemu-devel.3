Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D30CE7AB0
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 07:50:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snZ8t-000718-FT; Mon, 09 Sep 2024 03:48:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Li2i=QH=kaod.org=clg@ozlabs.org>)
 id 1snZ8p-0006qZ-G9; Mon, 09 Sep 2024 03:48:55 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Li2i=QH=kaod.org=clg@ozlabs.org>)
 id 1snZ8n-00044d-Gq; Mon, 09 Sep 2024 03:48:55 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4X2Jqk5nFzz4x11;
 Mon,  9 Sep 2024 17:48:50 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4X2Jqd3FLYz4wb0;
 Mon,  9 Sep 2024 17:48:45 +1000 (AEST)
Message-ID: <d2e07e85-97a0-4151-9349-3f989cdafad2@kaod.org>
Date: Mon, 9 Sep 2024 09:48:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/8] usb/uhci: Introduce and use register defines
To: Guenter Roeck <linux@roeck-us.net>, qemu-devel@nongnu.org
Cc: Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 BALATON Zoltan <balaton@eik.bme.hu>, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org
References: <20240906122542.3808997-1-linux@roeck-us.net>
 <20240906122542.3808997-3-linux@roeck-us.net>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240906122542.3808997-3-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=Li2i=QH=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/6/24 14:25, Guenter Roeck wrote:
> Introduce defines for UHCI registers to simplify adding register access
> in subsequent patches of the series.
> 
> No functional change.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/usb/hcd-uhci.c          | 32 ++++++++++++++++----------------
>   include/hw/usb/uhci-regs.h | 11 +++++++++++
>   2 files changed, 27 insertions(+), 16 deletions(-)
> 
> diff --git a/hw/usb/hcd-uhci.c b/hw/usb/hcd-uhci.c
> index dfcc3e05c0..8bc163f688 100644
> --- a/hw/usb/hcd-uhci.c
> +++ b/hw/usb/hcd-uhci.c
> @@ -389,7 +389,7 @@ static void uhci_port_write(void *opaque, hwaddr addr,
>       trace_usb_uhci_mmio_writew(addr, val);
>   
>       switch (addr) {
> -    case 0x00:
> +    case UHCI_USBCMD:
>           if ((val & UHCI_CMD_RS) && !(s->cmd & UHCI_CMD_RS)) {
>               /* start frame processing */
>               trace_usb_uhci_schedule_start();
> @@ -424,7 +424,7 @@ static void uhci_port_write(void *opaque, hwaddr addr,
>               }
>           }
>           break;
> -    case 0x02:
> +    case UHCI_USBSTS:
>           s->status &= ~val;
>           /*
>            * XXX: the chip spec is not coherent, so we add a hidden
> @@ -435,27 +435,27 @@ static void uhci_port_write(void *opaque, hwaddr addr,
>           }
>           uhci_update_irq(s);
>           break;
> -    case 0x04:
> +    case UHCI_USBINTR:
>           s->intr = val;
>           uhci_update_irq(s);
>           break;
> -    case 0x06:
> +    case UHCI_USBFRNUM:
>           if (s->status & UHCI_STS_HCHALTED) {
>               s->frnum = val & 0x7ff;
>           }
>           break;
> -    case 0x08:
> +    case UHCI_USBFLBASEADD:
>           s->fl_base_addr &= 0xffff0000;
>           s->fl_base_addr |= val & ~0xfff;
>           break;
> -    case 0x0a:
> +    case UHCI_USBFLBASEADD + 2:
>           s->fl_base_addr &= 0x0000ffff;
>           s->fl_base_addr |= (val << 16);
>           break;
> -    case 0x0c:
> +    case UHCI_USBSOF:
>           s->sof_timing = val & 0xff;
>           break;
> -    case 0x10 ... 0x1f:
> +    case UHCI_USBPORTSC1 ... UHCI_USBPORTSC4:
>           {
>               UHCIPort *port;
>               USBDevice *dev;
> @@ -493,28 +493,28 @@ static uint64_t uhci_port_read(void *opaque, hwaddr addr, unsigned size)
>       uint32_t val;
>   
>       switch (addr) {
> -    case 0x00:
> +    case UHCI_USBCMD:
>           val = s->cmd;
>           break;
> -    case 0x02:
> +    case UHCI_USBSTS:
>           val = s->status;
>           break;
> -    case 0x04:
> +    case UHCI_USBINTR:
>           val = s->intr;
>           break;
> -    case 0x06:
> +    case UHCI_USBFRNUM:
>           val = s->frnum;
>           break;
> -    case 0x08:
> +    case UHCI_USBFLBASEADD:
>           val = s->fl_base_addr & 0xffff;
>           break;
> -    case 0x0a:
> +    case UHCI_USBFLBASEADD + 2:
>           val = (s->fl_base_addr >> 16) & 0xffff;
>           break;
> -    case 0x0c:
> +    case UHCI_USBSOF:
>           val = s->sof_timing;
>           break;
> -    case 0x10 ... 0x1f:
> +    case UHCI_USBPORTSC1 ... UHCI_USBPORTSC4:
>           {
>               UHCIPort *port;
>               int n;
> diff --git a/include/hw/usb/uhci-regs.h b/include/hw/usb/uhci-regs.h
> index fd45d29db0..5b81714e5c 100644
> --- a/include/hw/usb/uhci-regs.h
> +++ b/include/hw/usb/uhci-regs.h
> @@ -1,6 +1,17 @@
>   #ifndef HW_USB_UHCI_REGS_H
>   #define HW_USB_UHCI_REGS_H
>   
> +#define UHCI_USBCMD       0
> +#define UHCI_USBSTS       2
> +#define UHCI_USBINTR      4
> +#define UHCI_USBFRNUM     6
> +#define UHCI_USBFLBASEADD 8
> +#define UHCI_USBSOF       0x0c
> +#define UHCI_USBPORTSC1   0x10
> +#define UHCI_USBPORTSC2   0x12
> +#define UHCI_USBPORTSC3   0x14
> +#define UHCI_USBPORTSC4   0x16
> +
>   #define UHCI_CMD_FGR      (1 << 4)
>   #define UHCI_CMD_EGSM     (1 << 3)
>   #define UHCI_CMD_GRESET   (1 << 2)


