Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1DEBC369D3
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 07:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9Inh-0002iI-EV; Mon, 28 Apr 2025 03:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=KRh2=XO=kaod.org=clg@ozlabs.org>)
 id 1u9Ine-0002hA-9H; Mon, 28 Apr 2025 03:21:10 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=KRh2=XO=kaod.org=clg@ozlabs.org>)
 id 1u9Inb-0007P2-4t; Mon, 28 Apr 2025 03:21:09 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4ZmFGz6WWXz4xD9;
 Mon, 28 Apr 2025 17:20:59 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4ZmFGv3bsGz4wj2;
 Mon, 28 Apr 2025 17:20:55 +1000 (AEST)
Message-ID: <3c8ff4de-e17f-46c5-ae43-e7ecfa071414@kaod.org>
Date: Mon, 28 Apr 2025 09:20:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] hw/misc/aspeed_sbc: Connect Aspeed OTP memory
 device to SBC controller
To: Kane Chen <kane_chen@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com
References: <20250423025651.189702-1-kane_chen@aspeedtech.com>
 <20250423025651.189702-3-kane_chen@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250423025651.189702-3-kane_chen@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=KRh2=XO=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
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

On 4/23/25 04:56, Kane Chen wrote:
> From: Kane-Chen-AS <kane_chen@aspeedtech.com>
> 
> This patch integrates the `aspeed.otpmem` device with the ASPEED
> Secure Boot Controller (SBC). The SBC now accepts an OTP backend via
> a QOM link property ("otpmem"), enabling internal access to OTP content
> for controller-specific logic.
> 
> This connection provides the foundation for future enhancements
> involving fuse storage, device configuration, or secure manufacturing
> data provisioning.
> 
> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
> ---
>   hw/misc/aspeed_sbc.c         | 146 +++++++++++++++++++++++++++++++++++
>   include/hw/misc/aspeed_sbc.h |  15 ++++
>   2 files changed, 161 insertions(+)
> 
> diff --git a/hw/misc/aspeed_sbc.c b/hw/misc/aspeed_sbc.c
> index e4a6bd1581..f0ce7bbdf0 100644
> --- a/hw/misc/aspeed_sbc.c
> +++ b/hw/misc/aspeed_sbc.c
> @@ -17,7 +17,11 @@
>   #include "migration/vmstate.h"
>   
>   #define R_PROT          (0x000 / 4)
> +#define R_CMD           (0x004 / 4)
> +#define R_ADDR          (0x010 / 4)
>   #define R_STATUS        (0x014 / 4)
> +#define R_CAMP1         (0x020 / 4)
> +#define R_CAMP2         (0x024 / 4)
>   #define R_QSR           (0x040 / 4)
>   
>   /* R_STATUS */
> @@ -57,6 +61,143 @@ static uint64_t aspeed_sbc_read(void *opaque, hwaddr addr, unsigned int size)
>       return s->regs[addr];
>   }
>   
> +static void aspeed_sbc_otpmem_read(void *opaque)

You could improve this prototype. How about :

bool aspeed_sbc_otpmem_read(AspeedSBCState *s, uint32_t otp_addr, Error *errp)

same below.

> +{
> +    AspeedSBCState *s = ASPEED_SBC(opaque);
> +    uint32_t otp_addr, data, otp_offset;
> +    bool is_data = false;
> +    Error *local_err = NULL;
> +
> +    assert(s->otpmem);
> +
> +    otp_addr = s->regs[R_ADDR];
> +    if (otp_addr < OTP_DATA_DWORD_COUNT) {
> +        is_data = true;
> +    } else if (otp_addr >= OTP_TOTAL_DWORD_COUNT) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Invalid OTP addr 0x%x\n",
> +                      __func__, otp_addr);
> +        return;
> +    }
> +    otp_offset = otp_addr << 2;
> +
> +    s->otpmem->ops->read(s->otpmem, otp_offset, &data, &local_err);
> +    if (local_err) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Failed to read data 0x%x, %s\n",
> +                      __func__, otp_offset,
> +                      error_get_pretty(local_err));
> +        error_free(local_err);
> +        return;> +    }

Please use an AddressSpace. See aspeed_smc for an example.

> +    s->regs[R_CAMP1] = data;
> +
> +    if (is_data) {
> +        s->otpmem->ops->read(s->otpmem, otp_offset + 4, &data, &local_err);
> +        if (local_err) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: Failed to read data 0x%x, %s\n",
> +                          __func__, otp_offset,
> +                          error_get_pretty(local_err));
> +            error_free(local_err);
> +            return;
> +        }
> +        s->regs[R_CAMP2] = data;
> +    }
> +}
> +
> +static void mr_handler(uint32_t otp_addr, uint32_t data)

data is unused

> +{
> +    switch (otp_addr) {
> +    case MODE_REGISTER:
> +    case MODE_REGISTER_A:
> +    case MODE_REGISTER_B:
> +        /* HW behavior, do nothing here */
> +        break;
> +    default:
> +    qemu_log_mask(LOG_GUEST_ERROR,

alignment issue.

> +                  "%s: Unsupported address 0x%x\n",
> +                  __func__, otp_addr);
> +        return;
> +    }
> +}
> +
> +static void aspeed_sbc_otpmem_write(void *opaque)
> +{
> +    AspeedSBCState *s = ASPEED_SBC(opaque);
> +    uint32_t otp_addr, data;
> +
> +    otp_addr = s->regs[R_ADDR];
> +    data = s->regs[R_CAMP1];
> +
> +    if (otp_addr == 0) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: ignore write program bit request\n",
> +                      __func__);
> +    } else if (otp_addr >= MODE_REGISTER) {
> +        mr_handler(otp_addr, data);
> +    } else {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Unhandled OTP write address 0x%x\n",
> +                      __func__, otp_addr);
> +    }
> +}
> +
> +static void aspeed_sbc_otpmem_prog(void *opaque)
> +{
> +    AspeedSBCState *s = ASPEED_SBC(opaque);
> +    uint32_t otp_addr, value;
> +    Error *local_err = NULL;
> +
> +    assert(s->otpmem);
> +
> +    otp_addr = s->regs[R_ADDR];
> +    value = s->regs[R_CAMP1];
> +    if (otp_addr >= OTP_TOTAL_DWORD_COUNT) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Invalid OTP addr 0x%x\n",
> +                      __func__, otp_addr);
> +        return;
> +    }
> +
> +    s->otpmem->ops->prog(s->otpmem, otp_addr, value, &local_err);
> +    if (local_err) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Failed to program data 0x%x to 0x%x, %s\n",
> +                      __func__, value, otp_addr,
> +                      error_get_pretty(local_err));
> +        error_free(local_err);
> +        return;
> +    }
> +}
> +
> +static void aspeed_sbc_handle_command(void *opaque, uint32_t cmd)
> +{
> +    AspeedSBCState *s = ASPEED_SBC(opaque);
> +
> +    s->regs[R_STATUS] &= ~(OTP_MEM_IDLE | OTP_IDLE);
> +
> +    switch (cmd) {
> +    case READ_CMD:
> +        aspeed_sbc_otpmem_read(s);
> +        break;
> +    case WRITE_CMD:
> +        aspeed_sbc_otpmem_write(s);
> +        break;
> +    case PROG_CMD:
> +        aspeed_sbc_otpmem_prog(s);
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Unknown command 0x%x\n",
> +                      __func__, cmd);
> +        break;
> +    }
> +
> +    s->regs[R_STATUS] |= (OTP_MEM_IDLE | OTP_IDLE);
> +}
> +
> +
>   static void aspeed_sbc_write(void *opaque, hwaddr addr, uint64_t data,
>                                 unsigned int size)
>   {
> @@ -78,6 +219,9 @@ static void aspeed_sbc_write(void *opaque, hwaddr addr, uint64_t data,
>                         "%s: write to read only register 0x%" HWADDR_PRIx "\n",
>                         __func__, addr << 2);
>           return;
> +    case R_CMD:
> +        aspeed_sbc_handle_command(opaque, data);
> +        return;
>       default:
>           break;
>       }
> @@ -139,6 +283,8 @@ static const VMStateDescription vmstate_aspeed_sbc = {
>   static const Property aspeed_sbc_properties[] = {
>       DEFINE_PROP_BOOL("emmc-abr", AspeedSBCState, emmc_abr, 0),
>       DEFINE_PROP_UINT32("signing-settings", AspeedSBCState, signing_settings, 0),
> +    DEFINE_PROP_LINK("otpmem", AspeedSBCState, otpmem,
> +                     TYPE_ASPEED_OTPMEM, AspeedOTPMemState *),

hmm, no.

Instead AspeedOTPMemState should be a child object of AspeedSBCState,
only created and realized for ast2600/1030  Soc. This means you will
probably need a class attribute in AspeedSBCClass.



>   };
>   
>   static void aspeed_sbc_class_init(ObjectClass *klass, void *data)
> diff --git a/include/hw/misc/aspeed_sbc.h b/include/hw/misc/aspeed_sbc.h
> index 405e6782b9..8ae59d977e 100644
> --- a/include/hw/misc/aspeed_sbc.h
> +++ b/include/hw/misc/aspeed_sbc.h
> @@ -10,6 +10,7 @@
>   #define ASPEED_SBC_H
>   
>   #include "hw/sysbus.h"
> +#include "hw/misc/aspeed_otpmem.h"
>   
>   #define TYPE_ASPEED_SBC "aspeed.sbc"
>   #define TYPE_ASPEED_AST2600_SBC TYPE_ASPEED_SBC "-ast2600"
> @@ -27,6 +28,18 @@ OBJECT_DECLARE_TYPE(AspeedSBCState, AspeedSBCClass, ASPEED_SBC)
>   #define QSR_SHA384                  (0x2 << 10)
>   #define QSR_SHA512                  (0x3 << 10)
>   
> +#define READ_CMD                    (0x23b1e361)
> +#define WRITE_CMD                   (0x23b1e362)
> +#define PROG_CMD                    (0x23b1e364)
> +
> +#define OTP_DATA_DWORD_COUNT        (0x800)
> +#define OTP_TOTAL_DWORD_COUNT       (0x1000)
> +#define OTP_FILE_SIZE               (OTP_TOTAL_DWORD_COUNT * sizeof(uint32_t))
> +
> +#define MODE_REGISTER               (0x1000)
> +#define MODE_REGISTER_A             (0x3000)
> +#define MODE_REGISTER_B             (0x5000)
> +

These define belong to the implementation : aspeed_sbc.c.


Thanks,

C.


>   struct AspeedSBCState {
>       SysBusDevice parent;
>   
> @@ -36,6 +49,8 @@ struct AspeedSBCState {
>       MemoryRegion iomem;
>   
>       uint32_t regs[ASPEED_SBC_NR_REGS];
> +
> +    AspeedOTPMemState *otpmem;
>   };
>   
>   struct AspeedSBCClass {


