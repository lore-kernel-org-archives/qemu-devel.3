Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68939C7EE31
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 06:50:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV2ta-0007vO-6d; Fri, 27 Jun 2025 02:49:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=5m2v=ZK=kaod.org=clg@ozlabs.org>)
 id 1uV2tX-0007uG-Ch; Fri, 27 Jun 2025 02:49:07 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=5m2v=ZK=kaod.org=clg@ozlabs.org>)
 id 1uV2tU-0007GM-C3; Fri, 27 Jun 2025 02:49:06 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4bT5kG2G3Wz4x6r;
 Fri, 27 Jun 2025 16:48:54 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4bT5kC01s1z4wcm;
 Fri, 27 Jun 2025 16:48:50 +1000 (AEST)
Message-ID: <a35878aa-bf5e-4a17-9c24-79c291326332@kaod.org>
Date: Fri, 27 Jun 2025 08:48:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] hw/misc/aspeed_sbc: Connect ASPEED OTP memory
 device to SBC
To: Kane Chen <kane_chen@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com
References: <20250627025606.631167-1-kane_chen@aspeedtech.com>
 <20250627025606.631167-3-kane_chen@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250627025606.631167-3-kane_chen@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=5m2v=ZK=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 6/27/25 04:56, Kane Chen wrote:
> From: Kane-Chen-AS <kane_chen@aspeedtech.com>
> 
> This patch connects the aspeed.otpmem device to the ASPEED Secure Boot
> Controller (SBC) model. It implements OTP memory access via the SBC's
> command interface and enables emulation of secure fuse programming flows.
> 
> The following OTP commands are supported:
>    - READ: reads a 32-bit word from OTP memory into internal registers
>    - PROG: programs a 32-bit word value to the specified OTP address
> 
> Trace events are added to observe read/program operations and command
> handling flow.
> 
> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
> ---
>   include/hw/misc/aspeed_sbc.h |   5 ++
>   hw/misc/aspeed_sbc.c         | 117 +++++++++++++++++++++++++++++++++++
>   hw/misc/trace-events         |   5 ++
>   3 files changed, 127 insertions(+)
> 
> diff --git a/include/hw/misc/aspeed_sbc.h b/include/hw/misc/aspeed_sbc.h
> index 405e6782b9..0c2746d392 100644
> --- a/include/hw/misc/aspeed_sbc.h
> +++ b/include/hw/misc/aspeed_sbc.h
> @@ -10,6 +10,7 @@
>   #define ASPEED_SBC_H
>   
>   #include "hw/sysbus.h"
> +#include "hw/nvram/aspeed_otp.h"
>   
>   #define TYPE_ASPEED_SBC "aspeed.sbc"
>   #define TYPE_ASPEED_AST2600_SBC TYPE_ASPEED_SBC "-ast2600"
> @@ -36,10 +37,14 @@ struct AspeedSBCState {
>       MemoryRegion iomem;
>   
>       uint32_t regs[ASPEED_SBC_NR_REGS];
> +
> +    AspeedOTPState otp;
>   };
>   
>   struct AspeedSBCClass {
>       SysBusDeviceClass parent_class;
> +
> +    bool has_otp;
>   };
>   
>   #endif /* ASPEED_SBC_H */
> diff --git a/hw/misc/aspeed_sbc.c b/hw/misc/aspeed_sbc.c
> index a7d101ba71..2f5b83a3f2 100644
> --- a/hw/misc/aspeed_sbc.c
> +++ b/hw/misc/aspeed_sbc.c
> @@ -15,9 +15,13 @@
>   #include "hw/misc/aspeed_sbc.h"
>   #include "qapi/error.h"
>   #include "migration/vmstate.h"
> +#include "trace.h"
>   
>   #define R_PROT          (0x000 / 4)
> +#define R_CMD           (0x004 / 4)
> +#define R_ADDR          (0x010 / 4)
>   #define R_STATUS        (0x014 / 4)
> +#define R_CAMP1         (0x020 / 4)
>   #define R_QSR           (0x040 / 4)
>   
>   /* R_STATUS */
> @@ -41,6 +45,11 @@
>   #define QSR_RSA_MASK           (0x3 << 12)
>   #define QSR_HASH_MASK          (0x3 << 10)
>   
> +#define OTP_MEMORY_SIZE 0x4000
> +/* OTP command */
> +#define SBC_OTP_CMD_READ 0x23b1e361
> +#define SBC_OTP_CMD_PROG 0x23b1e364
> +
>   static uint64_t aspeed_sbc_read(void *opaque, hwaddr addr, unsigned int size)
>   {
>       AspeedSBCState *s = ASPEED_SBC(opaque);
> @@ -57,6 +66,84 @@ static uint64_t aspeed_sbc_read(void *opaque, hwaddr addr, unsigned int size)
>       return s->regs[addr];
>   }
>   
> +static bool aspeed_sbc_otp_read(AspeedSBCState *s,
> +                                   uint32_t otp_addr)
> +{
> +    MemTxResult ret;
> +    AspeedOTPState *otp = &s->otp;
> +    uint32_t value, otp_offset;
> +
> +    otp_offset = otp_addr << 2;
> +    ret = address_space_read(&otp->as, otp_offset, MEMTXATTRS_UNSPECIFIED,
> +                             &value, sizeof(value));
> +    if (ret != MEMTX_OK) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "Failed to read OTP memory, addr = %x\n",
> +                      otp_addr);
> +        return false;
> +    }
> +    s->regs[R_CAMP1] = value;
> +    trace_aspeed_sbc_otp_read(otp_addr, value);
> +
> +    return true;
> +}
> +
> +static bool aspeed_sbc_otp_prog(AspeedSBCState *s,
> +                                   uint32_t otp_addr)
> +{
> +    MemTxResult ret;
> +    AspeedOTPState *otp = &s->otp;
> +    uint32_t value = s->regs[R_CAMP1];
> +
> +    ret = address_space_write(&otp->as, otp_addr, MEMTXATTRS_UNSPECIFIED,
> +                        &value, sizeof(value));
> +    if (ret != MEMTX_OK) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "Failed to write OTP memory, addr = %x\n",
> +                      otp_addr);
> +        return false;
> +    }
> +
> +    trace_aspeed_sbc_otp_prog(otp_addr, value);
> +
> +    return true;
> +}
> +
> +static void aspeed_sbc_handle_command(void *opaque, uint32_t cmd)
> +{
> +    AspeedSBCState *s = ASPEED_SBC(opaque);
> +    AspeedSBCClass *sc = ASPEED_SBC_GET_CLASS(opaque);
> +    bool ret = false;
> +    uint32_t otp_addr;
> +
> +    if (!sc->has_otp) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: OTP memory is not supported\n",
> +                      __func__);
> +        return;
> +    }
> +
> +    s->regs[R_STATUS] &= ~(OTP_MEM_IDLE | OTP_IDLE);
> +    otp_addr = s->regs[R_ADDR];
> +
> +    switch (cmd) {
> +    case SBC_OTP_CMD_READ:
> +        ret = aspeed_sbc_otp_read(s, otp_addr);
> +        break;
> +    case SBC_OTP_CMD_PROG:
> +        ret = aspeed_sbc_otp_prog(s, otp_addr);
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Unknown command 0x%x\n",
> +                      __func__, cmd);
> +        break;
> +    }
> +
> +    trace_aspeed_sbc_handle_cmd(cmd, otp_addr, ret);
> +    s->regs[R_STATUS] |= (OTP_MEM_IDLE | OTP_IDLE);
> +}
> +
>   static void aspeed_sbc_write(void *opaque, hwaddr addr, uint64_t data,
>                                 unsigned int size)
>   {
> @@ -78,6 +165,9 @@ static void aspeed_sbc_write(void *opaque, hwaddr addr, uint64_t data,
>                         "%s: write to read only register 0x%" HWADDR_PRIx "\n",
>                         __func__, addr << 2);
>           return;
> +    case R_CMD:
> +        aspeed_sbc_handle_command(opaque, data);
> +        return;
>       default:
>           break;
>       }
> @@ -115,10 +205,36 @@ static void aspeed_sbc_reset(DeviceState *dev)
>       s->regs[R_QSR] = s->signing_settings;
>   }
>   
> +static void aspeed_sbc_instance_init(Object *obj)
> +{
> +    AspeedSBCClass *sc = ASPEED_SBC_GET_CLASS(obj);
> +    AspeedSBCState *s = ASPEED_SBC(obj);
> +
> +    if (sc->has_otp) {
> +        object_initialize_child(OBJECT(s), "otp", &s->otp,
> +                                TYPE_ASPEED_OTP);
> +    }
> +}
> +
>   static void aspeed_sbc_realize(DeviceState *dev, Error **errp)
>   {
>       AspeedSBCState *s = ASPEED_SBC(dev);
>       SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +    AspeedSBCClass *sc = ASPEED_SBC_GET_CLASS(dev);
> +    Error *local_errp = NULL;
> +    bool ret;
> +
> +    if (sc->has_otp) {
> +        qdev_prop_set_uint64(DEVICE(&s->otp), "size", OTP_MEMORY_SIZE);


Please prefer object_property_set_int() instead. For examples, see
aspeed_soc_ast2600_realize().

> +        ret = qdev_realize(DEVICE(&s->otp), NULL, &local_errp);
> +        if (!ret && local_errp) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: %s\n",
> +                          __func__, error_get_pretty(local_errp));
> +            error_free(local_errp);
> +            return;

This should be :

         if (!qdev_realize(DEVICE(&a->otp), NULL, errp)) {
             return;
         }

Thanks,

C.

> +        }
> +    }
>   
>       memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_sbc_ops, s,
>               TYPE_ASPEED_SBC, 0x1000);
> @@ -155,6 +271,7 @@ static const TypeInfo aspeed_sbc_info = {
>       .name = TYPE_ASPEED_SBC,
>       .parent = TYPE_SYS_BUS_DEVICE,
>       .instance_size = sizeof(AspeedSBCState),
> +    .instance_init = aspeed_sbc_instance_init,
>       .class_init = aspeed_sbc_class_init,
>       .class_size = sizeof(AspeedSBCClass)
>   };
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index e3f64c0ff6..9e05b82f37 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -90,6 +90,11 @@ slavio_sysctrl_mem_readl(uint32_t ret) "Read system control 0x%08x"
>   slavio_led_mem_writew(uint32_t val) "Write diagnostic LED 0x%04x"
>   slavio_led_mem_readw(uint32_t ret) "Read diagnostic LED 0x%04x"
>   
> +# aspeed_sbc.c
> +aspeed_sbc_handle_cmd(uint32_t cmd, uint32_t addr, bool ret) "Handling command 0x%" PRIx32 " for OTP addr 0x%" PRIx32 " Result: %d"
> +aspeed_sbc_otp_read(uint32_t addr, uint32_t value) "OTP Memory read: addr 0x%" PRIx32 " value 0x%" PRIx32
> +aspeed_sbc_otp_prog(uint32_t addr, uint32_t value) "OTP Memory write: addr 0x%" PRIx32 " value 0x%" PRIx32
> +
>   # aspeed_scu.c
>   aspeed_scu_write(uint64_t offset, unsigned size, uint32_t data) "To 0x%" PRIx64 " of size %u: 0x%" PRIx32
>   aspeed_scu_read(uint64_t offset, unsigned size, uint32_t data) "To 0x%" PRIx64 " of size %u: 0x%" PRIx32


