Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4229ECA9EC5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 06:29:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xG9W7-0004th-OT; Mon, 12 Oct 2026 02:28:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xG9W4-0004rr-A9
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 02:28:09 -0400
Received: from smtpout4.mo540.mail-out.ovh.net ([51.210.91.53])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xG9W1-0005AP-ER
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 02:28:08 -0400
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net [79.137.60.223])
 by mo540.mail-out.ovh.net (Postfix) with ESMTPS id 4j36w91Ryqz44Dx;
 Mon, 12 Oct 2026 06:27:52 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net. [127.0.0.1])
 by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Mon, 12 Oct 2026 06:27:52 +0000 (UTC)
Received: from mta11.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.109.231.92])
 by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4j36w83SRjz1xpT; Mon, 12 Oct 2026 06:27:52 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.0])
 (Authenticated sender: clg@kaod.org)
 by mta11.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 1A5302402C97; Mon, 12 Oct 2026 06:27:51 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-111S0051d8828d7-b66f-409b-9508-58f8c8e99cb4,
 A46244FAB654B0099A82D276BA68AD972340DB92) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <959fd65c-64ee-4f89-88ec-07f7b14b898c@kaod.org>
Date: Mon, 12 Oct 2026 08:27:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/11] hw/usb/aspeed-udc: Make the SETUP buffer byte
 addressable
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20261005064418.3060881-1-jamin_lin@aspeedtech.com>
 <20261005064418.3060881-2-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20261005064418.3060881-2-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 9072501451517504523
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGiAXR8Ifyh3wPP9AAtd2qH1u9lmye61BdmBwEWKdch04gisrlgLmuw3IEbF5uLpFHrk/uRdlOVR+kDsI+xu3nKO/fuVVjLG3PX2zxWCLwDgNCdKzoId2UfguIikkocDaGek3KRESdjB3ye3EDci79JTh6LPNu/Rghgk0abhqqr80Pea4nucPYwHMVVg0Eaf8zTI+2acLY2ARg8HmR48hjdSZpvFhw0Vl0zTGjx2Ms9ajql6SFHcaPjL4Jw9oXgCpnc2T02IAJ+ZUfVKk1AvDf5wTzVePQapJcczEAVacoOUY6Gy14P9ClMXgBs8K7cujMg/a9cD0lNXPrB82s9yi9GJ76Acnd3vdnEso+7PHU0qn4xVwUpbVHP/4AjbfLIG4HDWLTLSh70zwSEGEHZLybY/EN1VQkC7OxPrur7GT/dfI5vSO1nbkq020yXm6KmGmbBu5T0G/TNLRCstsJamCPGL5MLMALDaUNyUgEryDlt4g4kfv5Zx3qoJkKJq+DChTUIRxjq96kiLD3gaWOcKsnu6WBq7bPkVCPPjGSuLlAx/XCnS3EWEYdQxELnSlbNuGXxq7CO5NYPYhft8yLEgkYwk7mYqlX0TVzpAbv+Fu/ASO2rvCPdL7tnJSn3sylaBQ036QLpHR5zzUvxGeT3b6kVecsNuXkUF1UQ10900uN0Cg
DKIM-Signature: a=rsa-sha256; bh=oYWYWABiRhMf8QEHURmKfoWC95WIw9E12zH+NHYNBMM=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1791786474; v=1;
 b=cUDPcHi1fgKP5ff5BMgTGI7G3pHGBAVObUDS2JJQ4efuoRjlIFiAhv5tJyWOCpQKrEbS9A9Z
 H3AYLkpckn/wF4BjZppAlxt8bu7BqL/MSURS8TXLuBx9L8GNmwNUccu51rTJcwQGJzDJjsohbxb
 C+Dv50jtNrNkmcwClHpkrjqUVzSa5M6u5pf+YHFHkhl19+P+xk8CmYaqRUvuxBVfxmTuWrdd1O3
 avJzfYxd/DF4S52aPNs+fkzXdn4t7dAajsU0h4Vp/IrbSLaU7cwY7vcvNx0ey6UUHBSQ1zj/bF+
 R3dbjXtl5jNI0XGD8U6N0COKKZYMdvpuD8D8ml5np6eZw==
Received-SPF: pass client-ip=51.210.91.53; envelope-from=clg@kaod.org;
 helo=smtpout4.mo540.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 10/5/26 08:44, Jamin Lin wrote:
> The controller registers need a 4 byte access, but the 8 bytes at 0x80
> are not registers. They are a SRAM buffer holding the EP0 SETUP packet.
> A read or a write that is not 4 bytes returned the wrong data, so the
> driver saw a broken SETUP packet.
> 
> Introduce a separate SETUP MMIO region that handles 1, 2 and 4 byte
> reads and writes.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   include/hw/usb/aspeed-udc.h | 11 ++++++--
>   hw/usb/aspeed-udc.c         | 56 +++++++++++++++++++++++++++++++++----
>   hw/usb/trace-events         |  2 ++
>   3 files changed, 61 insertions(+), 8 deletions(-)
> 
> diff --git a/include/hw/usb/aspeed-udc.h b/include/hw/usb/aspeed-udc.h
> index 7701c1aa34..42916c0bd6 100644
> --- a/include/hw/usb/aspeed-udc.h
> +++ b/include/hw/usb/aspeed-udc.h
> @@ -24,11 +24,14 @@ OBJECT_DECLARE_SIMPLE_TYPE(AspeedUDCState, ASPEED_UDC)
>   OBJECT_DECLARE_SIMPLE_TYPE(AspeedUDCGadget, ASPEED_UDC_GADGET)
>   
>   /*
> - * Register map: root/global block at 0x000 - 0x087, then one 0x10 byte bank
> - * per programmable endpoint from 0x200.
> + * Register map: root/global block at 0x000 - 0x07f, the SETUP buffer at
> + * 0x080 - 0x087, then one 0x10 byte bank per programmable endpoint from
> + * 0x200.
>    */
>   #define ASPEED_UDC_MEM_SIZE     0x300
> -#define ASPEED_UDC_ROOT_NR_REGS (0x88 >> 2)
> +#define ASPEED_UDC_ROOT_NR_REGS (0x80 >> 2)
> +#define ASPEED_UDC_SETUP_BASE   0x80
> +#define ASPEED_UDC_SETUP_SIZE   0x08
>   #define ASPEED_UDC_EP_REG_BASE  0x200
>   #define ASPEED_UDC_EP_NR_REGS   (0x10 >> 2)
>   
> @@ -62,9 +65,11 @@ struct AspeedUDCState {
>   
>       MemoryRegion udc_container;
>       MemoryRegion root_mr;
> +    MemoryRegion setup_mr;
>       MemoryRegion *dram_mr;
>       AddressSpace dram_as;
>       uint32_t regs[ASPEED_UDC_ROOT_NR_REGS];
> +    uint8_t setup_buf[ASPEED_UDC_SETUP_SIZE];
>       AspeedUDCEP ep[ASPEED_UDC_NUM_EP];
>       qemu_irq irq;
>   
> diff --git a/hw/usb/aspeed-udc.c b/hw/usb/aspeed-udc.c
> index 4c90b4f4c2..355512822b 100644
> --- a/hw/usb/aspeed-udc.c
> +++ b/hw/usb/aspeed-udc.c
> @@ -58,9 +58,6 @@ REG32(UDC_EP0_CTRL, 0x30)
>       FIELD(UDC_EP0_CTRL, STALL,              0, 1)
>   REG32(UDC_EP0_DATA_BUFF, 0x34)
>       FIELD(UDC_EP0_DATA_BUFF, BASE_ADDR,     0, 31)
> -/* EP0 SETUP packet buffer: SETUP0 = bytes 0...3, SETUP1 = bytes 4...7 */
> -REG32(UDC_SETUP0, 0x80)
> -REG32(UDC_SETUP1, 0x84)
>   
>   /* Per programmable-endpoint registers (offset from the EP register base) */
>   REG32(EP_CONFIG, 0x00)
> @@ -363,6 +360,45 @@ static const MemoryRegionOps aspeed_udc_ops = {
>       },
>   };
>   
> +static uint64_t aspeed_udc_setup_read(void *opaque, hwaddr offset,
> +                                      unsigned size)
> +{
> +    AspeedUDCState *s = ASPEED_UDC(opaque);
> +    uint64_t value = 0;
> +    int i;
> +
> +    for (i = 0; i < size; i++) {
> +        value |= (uint64_t)s->setup_buf[offset + i] << (8 * i);
> +    }
> +
> +    trace_aspeed_udc_setup_read(offset, size, value);
> +
> +    return value;
> +}
> +
> +static void aspeed_udc_setup_write(void *opaque, hwaddr offset,
> +                                   uint64_t value, unsigned size)
> +{
> +    AspeedUDCState *s = ASPEED_UDC(opaque);
> +    int i;
> +
> +    trace_aspeed_udc_setup_write(offset, size, value);
> +
> +    for (i = 0; i < size; i++) {
> +        s->setup_buf[offset + i] = value >> (8 * i);
> +    }
> +}
> +
> +static const MemoryRegionOps aspeed_udc_setup_ops = {
> +    .read = aspeed_udc_setup_read,
> +    .write = aspeed_udc_setup_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 1,
> +        .max_access_size = 4,
> +    },
> +};
> +
>   /*
>    * Copy len bytes from guest memory at addr into the IN packet, going through
>    * a bounce buffer one buf-full at a time. Returns false on DMA failure.
> @@ -708,6 +744,7 @@ static void aspeed_udc_reset_hold(Object *obj, ResetType type)
>       int i;
>   
>       memset(s->regs, 0, sizeof(s->regs));
> +    memset(s->setup_buf, 0, sizeof(s->setup_buf));
>       for (i = 0; i < ASPEED_UDC_NUM_EP; i++) {
>           memset(s->ep[i].regs, 0, sizeof(s->ep[i].regs));
>           s->ep[i].pkt = NULL;
> @@ -754,6 +791,12 @@ static void aspeed_udc_realize(DeviceState *dev, Error **errp)
>                             ASPEED_UDC_ROOT_NR_REGS << 2);
>       memory_region_add_subregion(&s->udc_container, 0, &s->root_mr);
>   
> +    memory_region_init_io(&s->setup_mr, OBJECT(s), &aspeed_udc_setup_ops,
> +                          s, TYPE_ASPEED_UDC ".setup",
> +                          ASPEED_UDC_SETUP_SIZE);
> +    memory_region_add_subregion(&s->udc_container,
> +                                ASPEED_UDC_SETUP_BASE, &s->setup_mr);
> +
>       /* Each programmable endpoint has its own register bank */
>       for (i = 0; i < ASPEED_UDC_NUM_EP; i++) {
>           g_autofree char *name = g_strdup_printf(TYPE_ASPEED_UDC ".ep%d", i);
> @@ -918,8 +961,11 @@ static void aspeed_udc_gadget_handle_control(USBDevice *udev, USBPacket *p,
>        * Reconstruct the 8-byte SETUP packet into the SETUP data buffer where
>        * the guest gadget driver reads it from.
>        */
> -    s->regs[R_UDC_SETUP0] = type | (req << 8) | ((value & 0xffff) << 16);
> -    s->regs[R_UDC_SETUP1] = (index & 0xffff) | ((length & 0xffff) << 16);
> +    s->setup_buf[0] = type;
> +    s->setup_buf[1] = req;
> +    stw_le_p(&s->setup_buf[2], value);
> +    stw_le_p(&s->setup_buf[4], index);
> +    stw_le_p(&s->setup_buf[6], length);
>   
>       /* A new SETUP clears the EP0 STALL condition */
>       s->regs[R_UDC_EP0_CTRL] &= ~R_UDC_EP0_CTRL_STALL_MASK;
> diff --git a/hw/usb/trace-events b/hw/usb/trace-events
> index 80ead23358..aa260dacad 100644
> --- a/hw/usb/trace-events
> +++ b/hw/usb/trace-events
> @@ -381,6 +381,8 @@ canokey_unrealize(void)
>   # aspeed-udc.c
>   aspeed_udc_read(uint64_t offset, uint32_t value) "offset 0x%" PRIx64 " value 0x%x"
>   aspeed_udc_write(uint64_t offset, uint32_t value) "offset 0x%" PRIx64 " value 0x%x"
> +aspeed_udc_setup_read(uint64_t offset, unsigned size, uint64_t value) "offset 0x%" PRIx64 " size %u value 0x%" PRIx64
> +aspeed_udc_setup_write(uint64_t offset, unsigned size, uint64_t value) "offset 0x%" PRIx64 " size %u value 0x%" PRIx64
>   aspeed_udc_ep_read(int ep, uint64_t offset, uint32_t value) "ep %d, offset 0x%" PRIx64 " value 0x%x"
>   aspeed_udc_ep_write(int ep, uint64_t offset, uint32_t value) "ep %d, offset 0x%" PRIx64 " value 0x%x"
>   aspeed_udc_pullup(int on, int attached) "on %d, attached %d"


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



