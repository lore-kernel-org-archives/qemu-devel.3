Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 015A7C44512
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 14:01:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkMea-0000l3-0r; Thu, 16 Jul 2026 10:01:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wkMeX-0000kb-EI; Thu, 16 Jul 2026 10:01:29 -0400
Received: from smtpout1.mo528.mail-out.ovh.net ([46.105.34.251])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wkMeU-0001LY-F9; Thu, 16 Jul 2026 10:01:29 -0400
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net [57.128.106.70])
 by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 4h1F813mvlz62SM;
 Thu, 16 Jul 2026 14:01:21 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net. [127.0.0.1])
 by director5.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Thu, 16 Jul 2026 14:01:21 +0000 (UTC)
Received: from mta11.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.109.249.154])
 by director5.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4h1F806fybz7tBf;
 Thu, 16 Jul 2026 14:01:20 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.7])
 (Authenticated sender: clg@kaod.org)
 by mta11.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 C1BCF2403DD2; Thu, 16 Jul 2026 14:01:18 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-104R00558d3656e-3da2-4bb8-83e0-b8cece9cd647,
 816DE1EE18DD2826DFD8B9EE289546F56902E1FE) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <e709723d-71fd-497a-83a8-e462254eac8c@kaod.org>
Date: Thu, 16 Jul 2026 16:01:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/5] fsi/cfam: Add CFAM-S model for AST2700
To: Mikail Sadic <mikail.sadic@ibm.com>, peter.maydell@linaro.org
Cc: pbonzini@redhat.com, ninad@linux.ibm.com, titusr@google.com,
 jeuk20.kim@samsung.com, philmd@mailo.com, steven_lee@aspeedtech.com,
 leetroy@gmail.com, jamin_lin@aspeedtech.com, kane_chen@aspeedtech.com,
 andrew@codeconstruct.com.au, joel@jms.id.au, calebs@us.ibm.com,
 milesg@ibm.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20260715155037.2237011-1-mikail.sadic@ibm.com>
 <20260715155037.2237011-3-mikail.sadic@ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260715155037.2237011-3-mikail.sadic@ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 16442923717610155173
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFUGZPB2GsUNXaVEmgH3FsWmmtHd1YN4Ye896ShwJe5fL8M02SNshlce2dWm39okPF7r5NsqH/xMSHjfLHpRQ0Y3We34xDu+Ct+BSaT0UrB9paC7l7lOtoLbg8PhON8si/1VIcYaxwc5MnZWo6/c9Gk+Zcf0q0REQmscCK2CTGBzjM4WCfuiayLQjqHXPgSDOLN+Vv3tWLMCv7XWo4SnHhdqwKapY2Z4ghAE4y5QMhxnrdggHvJbwjILAVQBU+GnGQkcj1xGu6s/RMkB7Q2oWwqR/G4y2ulrpCOi+8/o1fkTdR3fE4Xzug0NF8Hwla0iPsdir2qQFhSmIFBWnMCpXygGD8l6JGrmWI6sjM0BcwSTDdAgr7wzybbqmR+2EEi3ocrGNWBOgO0BH1T4R+tEpkEpCPfaUpgV2ZXQtHe/438vb+QCXPVOaBS8LOq98f1cMn6e51yHxDVjV3uw9ztCnLyuCIOOvYcQpFgqsZxhoi4npsVgqnY2N+ZtmtFE4cnIOUO9F3G57FofQ9nsZlCGPdeFLeCbuoI2Njndjf0CHb3rcRbUjnwviLiQ7PdDYCYzN90omk7RFozVvEvRYEI7IKdl3C6x3/LS5SC9tAtiFY0ELwcN+E25dCqWRBvMcNpxoN/ux3b/CFCTPjcQD81h9SwTZEmsSe3YiE9TqPWugvMzw
DKIM-Signature: a=rsa-sha256; bh=HpotnQKvMhIGtDidyHt0ESReYRvTrdhjXvGZr0y5tQM=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1784210483; v=1;
 b=graHLifqVjS6sD3e8k/1c99Z5sLVkoANzUdS/5LJkkhbAtUVqs7UhGTfWA9tFCFPBFNyCzrq
 y09xEG4F5UNGAMos6Vj9pm7A+FFrK+vsVfHNOyPBDaaPBwS8/5L3lYkdYw/dJ25vzihXhCevP0T
 Fx1VDzp3pG8kHgvNUM42uHFd/IhS4GaKMxUP6vLzTbkrucfirFB7aK0UUVeXR/zEMSQa6nBQbAR
 bObUKJPCoW4n1fZ5mSMxSLsvoORYe106gNSlSjqmUrjNpT8GELg87EzC2WgXmwcdaq5XKvqCflC
 Y1JNTY1fsrnNfxAoWUu0BLzf+48M+5eSTMZFjDUQCD91w==
Received-SPF: pass client-ip=46.105.34.251; envelope-from=clg@kaod.org;
 helo=smtpout1.mo528.mail-out.ovh.net
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Ninad,

Since you are the FSI maintainer, Could you please provide feedback ?

Thanks,

C.


On 7/15/26 17:50, Mikail Sadic wrote:
> Introduce TYPE_FSI_CFAM_S as a dedicated QOM type that presents the
> config table and mailbox scratch registers expected by the new Linux
> FSI responder framework. FSIMasterState gains a cfam_s field.
> fsi_master_realize() instantiates both cfam (at offset 0) and cfam-s
> (at offset 2 MiB) into the OPB-to-FSI aperture. aspeed_ast27x0.c wires
> up both fsi[0] and fsi[1] APB-to-OPB bridges for the AST2700 SoC.
> 
> Signed-off-by: Mikail Sadic <mikail.sadic@ibm.com>
> ---
>   docs/specs/fsi.rst          |  58 +++++++++++++++
>   include/hw/fsi/cfam-s.h     |  26 +++++++
>   include/hw/fsi/fsi-master.h |   2 +
>   hw/arm/aspeed_ast27x0.c     |  18 +++++
>   hw/fsi/cfam-s.c             | 145 ++++++++++++++++++++++++++++++++++++
>   hw/fsi/fsi-master.c         |  10 ++-
>   hw/fsi/meson.build          |   2 +-
>   7 files changed, 258 insertions(+), 3 deletions(-)
>   create mode 100644 include/hw/fsi/cfam-s.h
>   create mode 100644 hw/fsi/cfam-s.c
> 
> diff --git a/docs/specs/fsi.rst b/docs/specs/fsi.rst
> index f7d86d3e37..a8896b67ef 100644
> --- a/docs/specs/fsi.rst
> +++ b/docs/specs/fsi.rst
> @@ -120,3 +120,61 @@ from the BMC. (see the `pdbg source repository`_ for more details)
>   
>   .. _pdbg source repository:
>      https://github.com/open-power/pdbg
> +
> +CFAM-S model (AST2700)
> +----------------------
> +
> +The AST2700 uses a CFAM variant known as the CFAM-S, required by the new
> +Linux FSI responder framework. A dedicated QOM type, ``TYPE_FSI_CFAM_S``
> +(``"cfam-s"``), implements this alongside the existing ``TYPE_FSI_CFAM``
> +(``"cfam"``) used by the AST2600 machines.
> +
> +``FSIMasterState`` realizes both ``cfam`` and ``cfam-s``. The regular
> +``cfam`` is mapped at offset 0 into the OPB-to-FSI aperture; ``cfam-s`` is
> +mapped at offset 2 MiB. The DTS overrides ``fsim0`` with
> +``compatible = "aspeed,ast2600-fsi-master"`` and ``reg = <0x21800000>``,
> +pointing the kernel FSI driver at the QEMU APB-to-OPB bridge, which routes
> +through the FSI master's OPB-to-FSI window to reach the CFAM-S.
> +
> +The CFAM-S model presents an 8 MiB region and folds the SID bits ``[22:21]``
> +so both the SID_BREAK enumeration view (``0x600000``) and the runtime view
> +(``0x000000``) address the same register space. The config table at folded
> +offset ``0x000`` contains three CRC4-valid words: a chip_id word with
> +``MAJOR=9`` (selecting the ``cfam_s`` kernel driver), a responder engine
> +entry (``TYPE=0x3``), and a mailbox v1 engine entry (``TYPE=0x14``) at
> +engine address ``0x800``.
> +
> +The responder registers at folded offset ``0x400`` implement ``SMODE``,
> +``SSTAT``, ``SRES``, ``SSISM``, and ``SLBUS`` with store-on-write semantics.
> +The mailbox scratch registers at folded offset ``0x8e0`` are five stateful
> +32-bit registers served to the ``ibm,mbox-cfam-s`` kernel driver, which
> +creates ``/dev/fsi/mbox0``.
> +
> +The following commands start the ``huygens-bmc`` machine with the built-in
> +CFAM-S model. There are no model specific arguments. Please check this
> +document to learn more about Aspeed ``huygens-bmc`` machine:
> +(:doc:`../../system/arm/aspeed`)
> +
> +.. code-block:: console
> +
> +  qemu-system-aarch64 -M huygens-bmc \
> +    -drive file=image-bmc,if=mtd,format=raw \
> +    -drive file=ufs.img,if=none,format=raw \
> +    -nographic
> +
> +The CFAM-S appears as follows in the QEMU device tree:
> +
> +.. code-block:: console
> +
> +  (qemu) info qtree
> +  bus: main-system-bus
> +    type System
> +    ...
> +    dev: aspeed.apb2opb, id ""
> +      mmio 0000000021800000/0000000000001000
> +      bus: opb.0
> +        type opb
> +        dev: fsi.master, id ""
> +          bus: fsi.bus.0
> +            type fsi.bus
> +            dev: cfam-s, id ""
> diff --git a/include/hw/fsi/cfam-s.h b/include/hw/fsi/cfam-s.h
> new file mode 100644
> index 0000000000..3793b01471
> --- /dev/null
> +++ b/include/hw/fsi/cfam-s.h
> @@ -0,0 +1,26 @@
> +/*
> + * IBM Common FRU Access Macro - S variant (CFAM-S)
> + *
> + * Copyright (C) 2026 IBM Corp.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#ifndef FSI_CFAM_S_H
> +#define FSI_CFAM_S_H
> +
> +#include "system/memory.h"
> +#include "hw/fsi/fsi.h"
> +
> +#define TYPE_FSI_CFAM_S "cfam-s"
> +#define FSI_CFAM_S(obj) OBJECT_CHECK(FSICFAMSState, (obj), TYPE_FSI_CFAM_S)
> +
> +#define CFAM_S_MBOX_SCRATCH_NUM 5
> +
> +typedef struct FSICFAMSState {
> +    FSISlaveState parent;
> +
> +    MemoryRegion mr;
> +    uint32_t mbox_scratch[CFAM_S_MBOX_SCRATCH_NUM];
> +} FSICFAMSState;
> +
> +#endif /* FSI_CFAM_S_H */
> diff --git a/include/hw/fsi/fsi-master.h b/include/hw/fsi/fsi-master.h
> index 60ddaa994f..6a2782fdf2 100644
> --- a/include/hw/fsi/fsi-master.h
> +++ b/include/hw/fsi/fsi-master.h
> @@ -11,6 +11,7 @@
>   #include "hw/core/qdev.h"
>   #include "hw/fsi/fsi.h"
>   #include "hw/fsi/cfam.h"
> +#include "hw/fsi/cfam-s.h"
>   
>   #define TYPE_FSI_MASTER "fsi.master"
>   OBJECT_DECLARE_SIMPLE_TYPE(FSIMasterState, FSI_MASTER)
> @@ -26,6 +27,7 @@ typedef struct FSIMasterState {
>   
>       uint32_t regs[FSI_MASTER_NR_REGS];
>       FSICFAMState cfam;
> +    FSICFAMSState cfam_s;
>   } FSIMasterState;
>   
>   
> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
> index dddd7d2106..b908d7d4ff 100644
> --- a/hw/arm/aspeed_ast27x0.c
> +++ b/hw/arm/aspeed_ast27x0.c
> @@ -17,6 +17,7 @@
>   #include "qemu/module.h"
>   #include "qemu/error-report.h"
>   #include "hw/i2c/aspeed_i2c.h"
> +#include "hw/fsi/aspeed_apb2opb.h"
>   #include "net/net.h"
>   #include "system/qtest.h"
>   #include "system/system.h"
> @@ -98,6 +99,8 @@ static const hwaddr aspeed_soc_ast2700_memmap[] = {
>       [ASPEED_DEV_PCIE_MMIO0] = 0x60000000,
>       [ASPEED_DEV_PCIE_MMIO1] = 0x80000000,
>       [ASPEED_DEV_PCIE_MMIO2] = 0xA0000000,
> +    [ASPEED_DEV_FSI1]      =  0x21800000,
> +    [ASPEED_DEV_FSI2]      =  0x23800000,
>       [ASPEED_DEV_SPI_BOOT]  =  0x100000000,
>       [ASPEED_DEV_SDRAM]     =  0x400000000,
>   };
> @@ -559,6 +562,11 @@ static void aspeed_soc_ast2700_init(Object *obj)
>                                sc->silicon_rev);
>       }
>   
> +    for (i = 0; i < ARRAY_SIZE(s->fsi); i++) {
> +        object_initialize_child(obj, "fsi[*]", &s->fsi[i],
> +                                TYPE_ASPEED_APB2OPB);
> +    }
> +
>       object_initialize_child(obj, "dpmcu", &s->dpmcu,
>                               TYPE_UNIMPLEMENTED_DEVICE);
>       object_initialize_child(obj, "iomem", &s->iomem,
> @@ -1132,6 +1140,16 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
>           }
>       }
>   
> +    /* FSI / OPB */
> +    for (i = 0; i < ARRAY_SIZE(s->fsi); i++) {
> +        if (!sysbus_realize(SYS_BUS_DEVICE(&s->fsi[i]), errp)) {
> +            return;
> +        }
> +        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->fsi[i]), 0,
> +                        sc->memmap[ASPEED_DEV_FSI1 + i]);
> +    }
> +
> +
>       aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->dpmcu),
>                                     "aspeed.dpmcu",
>                                     sc->memmap[ASPEED_DEV_DPMCU],
> diff --git a/hw/fsi/cfam-s.c b/hw/fsi/cfam-s.c
> new file mode 100644
> index 0000000000..bf000d1879
> --- /dev/null
> +++ b/hw/fsi/cfam-s.c
> @@ -0,0 +1,145 @@
> +/*
> + * IBM Common FRU Access Macro - S variant (CFAM-S)
> + *
> + * Copyright (C) 2026 IBM Corp.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "trace.h"
> +#include "hw/fsi/cfam-s.h"
> +#include "hw/fsi/fsi.h"
> +
> +/* bits [22:21] are the slave ID, low 21 bits address registers within it */
> +#define CFAM_SID_MASK       0x1fffff
> +#define CFAM_WINDOW_SIZE    0x800000 /* 8 MiB per slave, covers SID 0..3 */
> +
> +#define CFAM_RESPONDER_BASE 0x400 /* == FSI_RESPONDER_PAGE_SIZE */
> +
> +/* Config-table word fields (see Linux fsi-master.h) */
> +#define CFAM_CONF_NEXT          (1u << 31)
> +#define CFAM_CONF_SLOTS(n)      (((n) & 0xff) << 16)
> +#define CFAM_CONF_VERSION(v)    (((v) & 0xf) << 12)
> +#define CFAM_CONF_TYPE(t)       (((t) & 0xff) << 4)
> +#define CFAM_CHIP_ID_MAJOR(m)   (((m) & 0xf) << 8)
> +
> +/* Engine IDs (include/linux/fsi.h) */
> +#define FSI_ENGINE_ID_RESPONDER     0x3
> +#define FSI_ENGINE_ID_MBOXV1        0x14
> +#define FSI_CHIP_ID_MAJOR_CFAM_S    0x9 /* major == 9 -> CFAM-S */
> +
> +/* Engine layout: 0x000 config table, 0x400 responder, 0x800 mbox */
> +#define CFAM_MBOX_BASE          0x800
> +#define CFAM_MBOX_SCRATCH_OFF   0xe0
> +#define CFAM_MBOX_SCRATCH_BASE  (CFAM_MBOX_BASE + CFAM_MBOX_SCRATCH_OFF)
> +
> +static uint8_t cfam_s_crc4(uint8_t c, uint64_t x, int bits)
> +{
> +    static const uint8_t tab[16] = {
> +        0x0, 0x7, 0xe, 0x9, 0xb, 0xc, 0x5, 0x2,
> +        0x1, 0x6, 0xf, 0x8, 0xa, 0xd, 0x4, 0x3,
> +    };
> +    int i;
> +
> +    x &= (1ull << bits) - 1;
> +    bits = (bits + 3) & ~0x3;
> +    for (i = bits - 4; i >= 0; i -= 4) {
> +        c = tab[c ^ ((x >> i) & 0xf)];
> +    }
> +    return c;
> +}
> +
> +static uint32_t cfam_s_cfg_word(uint32_t fields)
> +{
> +    return fields | cfam_s_crc4(0, fields >> 4, 28);
> +}
> +
> +static uint64_t fsi_cfam_s_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    FSICFAMSState *cfam = FSI_CFAM_S(opaque);
> +    uint32_t off = (uint32_t)addr & CFAM_SID_MASK;
> +    uint32_t val = 0;
> +
> +    if (off < CFAM_RESPONDER_BASE) {
> +        switch (off) {
> +        case 0x00:
> +            /* chip-id: NEXT set, MAJOR=9 (CFAM-S) */
> +            val = cfam_s_cfg_word(CFAM_CONF_NEXT |
> +                                  CFAM_CHIP_ID_MAJOR(FSI_CHIP_ID_MAJOR_CFAM_S));
> +            break;
> +        case 0x04:
> +            /* responder engine entry */
> +            val = cfam_s_cfg_word(CFAM_CONF_NEXT | CFAM_CONF_SLOTS(1) |
> +                                  CFAM_CONF_VERSION(1) |
> +                                  CFAM_CONF_TYPE(FSI_ENGINE_ID_RESPONDER));
> +            break;
> +        case 0x08:
> +            /* mailbox engine entry, last (NEXT clear) */
> +            val = cfam_s_cfg_word(CFAM_CONF_SLOTS(1) | CFAM_CONF_VERSION(1) |
> +                                  CFAM_CONF_TYPE(FSI_ENGINE_ID_MBOXV1));
> +            break;
> +        default:
> +            break;
> +        }
> +    } else if (off >= CFAM_MBOX_SCRATCH_BASE &&
> +               off < CFAM_MBOX_SCRATCH_BASE + CFAM_S_MBOX_SCRATCH_NUM * 4) {
> +        val = cfam->mbox_scratch[(off - CFAM_MBOX_SCRATCH_BASE) / 4];
> +    }
> +
> +    trace_fsi_cfam_config_read(addr, size);
> +    return val;
> +}
> +
> +static void fsi_cfam_s_write(void *opaque, hwaddr addr, uint64_t data,
> +                             unsigned size)
> +{
> +    FSICFAMSState *cfam = FSI_CFAM_S(opaque);
> +    uint32_t off = (uint32_t)addr & CFAM_SID_MASK;
> +
> +    if (off >= CFAM_MBOX_SCRATCH_BASE &&
> +        off < CFAM_MBOX_SCRATCH_BASE + CFAM_S_MBOX_SCRATCH_NUM * 4) {
> +        cfam->mbox_scratch[(off - CFAM_MBOX_SCRATCH_BASE) / 4] = (uint32_t)data;
> +    }
> +    trace_fsi_cfam_config_write(addr, size, data);
> +}
> +
> +static const MemoryRegionOps cfam_s_ops = {
> +    .read = fsi_cfam_s_read,
> +    .write = fsi_cfam_s_write,
> +    .endianness = DEVICE_BIG_ENDIAN,
> +    .valid.min_access_size = 1,
> +    .valid.max_access_size = 4,
> +    .impl.min_access_size = 1,
> +    .impl.max_access_size = 4,
> +};
> +
> +static void fsi_cfam_s_realize(DeviceState *dev, Error **errp)
> +{
> +    FSICFAMSState *cfam = FSI_CFAM_S(dev);
> +
> +    memory_region_init_io(&cfam->mr, OBJECT(cfam), &cfam_s_ops, cfam,
> +                          TYPE_FSI_CFAM_S, CFAM_WINDOW_SIZE);

This could be in a instance_init() handler.

> +}
> +
> +static void fsi_cfam_s_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    dc->bus_type = TYPE_FSI_BUS;
> +    dc->realize = fsi_cfam_s_realize;
> +}
> +
> +static const TypeInfo fsi_cfam_s_info = {
> +    .name = TYPE_FSI_CFAM_S,
> +    .parent = TYPE_FSI_SLAVE,
> +    .instance_size = sizeof(FSICFAMSState),
> +    .class_init = fsi_cfam_s_class_init,
> +};
> +
> +static void fsi_cfam_s_register_types(void)
> +{
> +    type_register_static(&fsi_cfam_s_info);
> +}
> +
> +type_init(fsi_cfam_s_register_types);
> diff --git a/hw/fsi/fsi-master.c b/hw/fsi/fsi-master.c
> index 083a5507ab..f7c19e24b0 100644
> --- a/hw/fsi/fsi-master.c
> +++ b/hw/fsi/fsi-master.c
> @@ -8,6 +8,7 @@
>   #include "qemu/osdep.h"
>   #include "qapi/error.h"
>   #include "qemu/log.h"
> +#include "qemu/units.h"
>   #include "trace.h"
>   
>   #include "hw/fsi/fsi-master.h"
> @@ -112,8 +113,6 @@ static void fsi_master_init(Object *o)
>   {
>       FSIMasterState *s = FSI_MASTER(o);
>   
> -    object_initialize_child(o, "cfam", &s->cfam, TYPE_FSI_CFAM);
> -

euh. Don't to that. Why ?

>       qbus_init(&s->bus, sizeof(s->bus), TYPE_FSI_BUS, DEVICE(s), NULL);
>   
>       memory_region_init_io(&s->iomem, OBJECT(s), &fsi_master_ops, s,
> @@ -125,12 +124,19 @@ static void fsi_master_realize(DeviceState *dev, Error **errp)
>   {
>       FSIMasterState *s = FSI_MASTER(dev);
>   
> +    object_initialize_child(OBJECT(dev), "cfam", &s->cfam, TYPE_FSI_CFAM);

no again.>       if (!qdev_realize(DEVICE(&s->cfam), BUS(&s->bus), errp)) {
>           return;
>       }
>   
>       /* address ? */
>       memory_region_add_subregion(&s->opb2fsi, 0, &s->cfam.mr);
> +
> +    object_initialize_child(OBJECT(dev), "cfam-s", &s->cfam_s, TYPE_FSI_CFAM_S);

no again.

> +    if (!qdev_realize(DEVICE(&s->cfam_s), BUS(&s->bus), errp)) {
> +        return;
> +    }
> +    memory_region_add_subregion(&s->opb2fsi, 2 * MiB, &s->cfam_s.mr);
>   }
>   
>   static void fsi_master_reset(DeviceState *dev)
> diff --git a/hw/fsi/meson.build b/hw/fsi/meson.build
> index a18a076552..585d549405 100644
> --- a/hw/fsi/meson.build
> +++ b/hw/fsi/meson.build
> @@ -1,2 +1,2 @@
> -system_ss.add(when: 'CONFIG_FSI', if_true: files('lbus.c','fsi.c','cfam.c','fsi-master.c'))
> +system_ss.add(when: 'CONFIG_FSI', if_true: files('lbus.c','fsi.c','cfam.c','cfam-s.c','fsi-master.c'))
>   system_ss.add(when: 'CONFIG_FSI_APB2OPB_ASPEED', if_true: files('aspeed_apb2opb.c'))


