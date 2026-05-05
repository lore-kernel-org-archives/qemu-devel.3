Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD01CD13DA
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 06:20:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wK995-0004k7-AD; Tue, 05 May 2026 02:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wK992-0004jK-7n
 for qemu-devel@nongnu.org; Tue, 05 May 2026 02:20:36 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wK98y-0005CQ-TT
 for qemu-devel@nongnu.org; Tue, 05 May 2026 02:20:35 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-36520a83186so1735215a91.3
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 23:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777962031; x=1778566831; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=s9UOh/Cffx0ycKHLNCfKf1nhx/FEgo3N8Hw5BBFmBN0=;
 b=D/P9Z4YxYB5WONquxQtVxAAhbNw18bV4CSn0VQYYJkx+Wnd3FUcRLug4H3MMQYDyCB
 HAkt3tqjTx+jSCLdVtIRebKxgwLu8XzfRrn6mqwqm/k1sTkgakRavg6PCrsFhOBVe9x0
 tFOrgRGXrldvFErv6Dzd0iz03iD0bwLRuV+bYMtXoLu8lagpegrNgZPSl1lMrrnIUUEP
 uhLsR003DNp0RGKoSZcKBYIGYFGzpmBvYHiZj80V+yQoh4hnG6SiOzJ8nOSMNJBevjuR
 BB7XfyJ8tD/cWsHzTnHfq8PDfmoEdU1GDjpV1c8Mdq8oAyWlWFnGJNSxtt742ib21Aqb
 Lc7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777962031; x=1778566831;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s9UOh/Cffx0ycKHLNCfKf1nhx/FEgo3N8Hw5BBFmBN0=;
 b=tAw4ZK03u95LYfBpUW6VmZ8AQpuDsSFfMZngTpBbsc1NWH3xn92sSnEaYTDihHTYSq
 SP1AbomAn8uPxS3bWJseEmwVAUGYDwGTaMJFtUtKjh8w8DzwRu0XqurGfjO3NEtVLzX+
 aLSWsq89kYF+T2xr/EdWxaNgyWRip05nCSN4n7wB5WFn7J+iXW17Ph/8+OcWZTh3elEl
 FBoZA9SGSlDYXHbm8Jj2BD7aNJJnQpXna/BA48BAVkSIDoV6uTimqdJUwfnmzGEgCebR
 qx30UodFLyMHqmTy3LcOaFDmV61wwrVr4XIbOxytmibUVtWl7G5Q/FabnTGTzJVNI9oa
 E/Kg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ijJ/Fkv8xdZdSOOVeVgR1iHvj5BmwaU8D5KUhIPlDBcFKRYX1pfzIvTK5qzqn4XtrIN+J+foh0Zu6@nongnu.org
X-Gm-Message-State: AOJu0YwypshBEjK7FdZBEf7o/4gTgJC8eRcX2nYXXRwiC/W+OxxvHMr+
 zeaOZkzEsevIV0ALCr0hjp5d53mJlAZVP+aYroDoE4tnIDzbhp2IM9N/
X-Gm-Gg: AeBDievTxxI+pkLWERS4AIeiWeKqAJFqekM+OxAwiAr+AIoxXl5WEbFl77s9hjHm0Ap
 xs9KbFvivTYclMvz2mJUfgTMsAOO2OItr6pvqjanFD44i9ShF651n3Dk5zRZ3Ogpo83isfAwhkM
 80yBwAjUUgO88H94pHALydWdqrijaPwEyrpceDonubDWkBwEA2B/I/eVLEO+sHhpLe9tiptZB/f
 FE+5EK5pdFNdImU2vmuOSgdOPDbWTEql0VlwmlcdkETk5RHazqra2rGi8nfzD4TcnVSYeol+QNa
 U5H26nrclAG4qSqMb61PXDZaZXFH45GIhk5SplotZqZ8F4An3cjarFMJCAUbxYApCtyi0jUY6jv
 IL++lie75HydNLjpjQWD5kISKzcsFcPEVQ1gPUh/eJBzzrfBGoec+I56DGMT4VMyEF7CMW3WWFh
 ZqXwVcFYNOuF1vp8ZeRiFk6eXHA3o5IMlmuOkpkTbmumQ=
X-Received: by 2002:a17:90b:4fc8:b0:35f:b293:7ac6 with SMTP id
 98e67ed59e1d1-3657737bde3mr2098120a91.6.1777962031245; 
 Mon, 04 May 2026 23:20:31 -0700 (PDT)
Received: from localhost ([124.158.97.178]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c8024ffdef6sm6416960a12.29.2026.05.04.23.20.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 23:20:30 -0700 (PDT)
Date: Tue, 5 May 2026 16:20:26 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: Joel Stanley <joel@jms.id.au>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, Chris Rauer <crauer@google.com>, 
 Michael Ellerman <mpe@kernel.org>, Joel Stanley <jms@oss.tenstorrent.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, Hao Wu <wuhaotsh@google.com>
Subject: Re: [PATCH v4 01/13] hw/i2c: Add designware i2c controller
Message-ID: <afmKctliUOEgQrmN@lima-default>
References: <20260425131721.932250-1-joel@jms.id.au>
 <20260425131721.932250-2-joel@jms.id.au>
 <CAKmqyKPyUYfnS3BsHT31hp_P5ufDOZHmr3VW8aUyeTTSTS-Rcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKPyUYfnS3BsHT31hp_P5ufDOZHmr3VW8aUyeTTSTS-Rcw@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Apr 30, 2026 at 01:53:21PM +1000, Alistair Francis wrote:
> On Sat, Apr 25, 2026 at 11:20 PM Joel Stanley <joel@jms.id.au> wrote:
> >
> > From: Chris Rauer <crauer@google.com>
> >
> > In the past this model has been submitted for use with the arm virt
> > machine, however in this case it will be used by the upcoming
> > Tenstorrent Atlantis RISC-V machine.
> >
> > This is a re-submission of the model with Chris' permission, with a
> > light touch of updates to make it build with qemu master.
> >
> > Reviewed-by: Hao Wu <wuhaotsh@google.com>
> > Signed-off-by: Chris Rauer <crauer@google.com>
> > Link: https://lore.kernel.org/qemu-devel/20220110214755.810343-2-venture@google.com
> > [jms: rebase and minor build fixes for class_init and reset callback]
> > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > ---
> > v4: Remove unused random header
> > v2: Add trace event for read and write, document Alano and myself as
> > reviewers.
> > ---
> >  MAINTAINERS                     |   8 +
> >  include/hw/i2c/designware_i2c.h | 101 ++++
> >  hw/i2c/designware_i2c.c         | 817 ++++++++++++++++++++++++++++++++
> >  hw/i2c/Kconfig                  |   4 +
> >  hw/i2c/meson.build              |   1 +
> >  hw/i2c/trace-events             |   4 +
> >  6 files changed, 935 insertions(+)
> >  create mode 100644 include/hw/i2c/designware_i2c.h
> >  create mode 100644 hw/i2c/designware_i2c.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index aa4267b15806..e1942a86eba5 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2716,6 +2716,14 @@ S: Orphan
> >  F: hw/gpio/pcf8574.c
> >  F: include/gpio/pcf8574.h
> >
> > +DesignWare I2C
> > +M: Chris Rauer <crauer@google.com>
> > +R: Alano Song <alanosong@163.com>
> > +R: Joel Stanley <joel@jms.id.au>
> > +S: Maintained
> > +F: hw/i2c/designware_i2c.c
> > +F: include/hw/i2c/designware_i2c.h
> > +
> >  Generic Loader
> >  M: Alistair Francis <alistair@alistair23.me>
> >  S: Maintained
> > diff --git a/include/hw/i2c/designware_i2c.h b/include/hw/i2c/designware_i2c.h
> > new file mode 100644
> > index 000000000000..0d8f904f51b7
> > --- /dev/null
> > +++ b/include/hw/i2c/designware_i2c.h
> > @@ -0,0 +1,101 @@
> > +/*
> > + * DesignWare I2C Module.
> > + *
> > + * Copyright 2021 Google LLC
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + */
> > +#ifndef DESIGNWARE_I2C_H
> > +#define DESIGNWARE_I2C_H
> > +
> > +#include "hw/i2c/i2c.h"
> > +#include "hw/core/irq.h"
> > +#include "hw/core/sysbus.h"
> > +
> > +/* Size of the FIFO buffers. */
> > +#define DESIGNWARE_I2C_RX_FIFO_SIZE 16
> > +#define DESIGNWARE_I2C_TX_FIFO_SIZE 16
> > +
> > +typedef enum DesignWareI2CStatus {
> > +    DW_I2C_STATUS_IDLE,
> > +    DW_I2C_STATUS_SENDING_ADDRESS,
> > +    DW_I2C_STATUS_SENDING,
> > +    DW_I2C_STATUS_RECEIVING,
> > +} DesignWareI2CStatus;
> > +
> > +/*
> > + * struct DesignWareI2CState - DesignWare I2C device state.
> > + * @bus: The underlying I2C Bus
> > + * @irq: GIC interrupt line to fire on events
> > + * @ic_con: : I2C control register
> > + * @ic_tar: I2C target address register
> > + * @ic_sar: I2C slave address register
> > + * @ic_ss_scl_hcnt: Standard speed i2c clock scl high count register
> > + * @ic_ss_scl_lcnt: Standard speed i2c clock scl low count register
> > + * @ic_fs_scl_hcnt: Fast mode or fast mode plus i2c clock scl high count
> > + *                  register
> > + * @ic_fs_scl_lcnt:Fast mode or fast mode plus i2c clock scl low count
> > + *                  register
> > + * @ic_intr_mask: I2C Interrupt Mask Register
> > + * @ic_raw_intr_stat: I2C raw interrupt status register
> > + * @ic_rx_tl: I2C receive FIFO threshold register
> > + * @ic_tx_tl: I2C transmit FIFO threshold register
> > + * @ic_enable: I2C enable register
> > + * @ic_status: I2C status register
> > + * @ic_txflr: I2C transmit fifo level register
> > + * @ic_rxflr: I2C receive fifo level register
> > + * @ic_sda_hold: I2C SDA hold time length register
> > + * @ic_tx_abrt_source: The I2C transmit abort source register
> > + * @ic_sda_setup: I2C SDA setup register
> > + * @ic_enable_status: I2C enable status register
> > + * @ic_fs_spklen: I2C SS, FS or FM+ spike suppression limit
> > + * @ic_comp_param_1: Component parameter register
> > + * @ic_comp_version: I2C component version register
> > + * @ic_comp_type: I2C component type register
> > + * @rx_fifo: The FIFO buffer for receiving in FIFO mode.
> > + * @rx_cur: The current position of rx_fifo.
> > + * @status: The current status of the SMBus.
> > + */
> > +typedef struct DesignWareI2CState {
> > +    SysBusDevice parent;
> > +
> > +    MemoryRegion iomem;
> > +
> > +    I2CBus      *bus;
> > +    qemu_irq     irq;
> > +
> > +    uint32_t ic_con;
> > +    uint32_t ic_tar;
> > +    uint32_t ic_sar;
> > +    uint32_t ic_ss_scl_hcnt;
> > +    uint32_t ic_ss_scl_lcnt;
> > +    uint32_t ic_fs_scl_hcnt;
> > +    uint32_t ic_fs_scl_lcnt;
> > +    uint32_t ic_intr_mask;
> > +    uint32_t ic_raw_intr_stat;
> > +    uint32_t ic_rx_tl;
> > +    uint32_t ic_tx_tl;
> > +    uint32_t ic_enable;
> > +    uint32_t ic_status;
> > +    uint32_t ic_txflr;
> > +    uint32_t ic_rxflr;
> > +    uint32_t ic_sda_hold;
> > +    uint32_t ic_tx_abrt_source;
> > +    uint32_t ic_sda_setup;
> > +    uint32_t ic_enable_status;
> > +    uint32_t ic_fs_spklen;
> > +    uint32_t ic_comp_param_1;
> > +    uint32_t ic_comp_version;
> > +    uint32_t ic_comp_type;
> > +
> > +    uint8_t      rx_fifo[DESIGNWARE_I2C_RX_FIFO_SIZE];
> > +    uint8_t      rx_cur;
> > +
> > +    DesignWareI2CStatus status;
> > +} DesignWareI2CState;
> > +
> > +#define TYPE_DESIGNWARE_I2C "designware-i2c"
> > +#define DESIGNWARE_I2C(obj) OBJECT_CHECK(DesignWareI2CState, (obj), \
> > +                                        TYPE_DESIGNWARE_I2C)
> > +
> > +#endif /* DESIGNWARE_I2C_H */
> > diff --git a/hw/i2c/designware_i2c.c b/hw/i2c/designware_i2c.c
> > new file mode 100644
> > index 000000000000..7d8b1c13533e
> > --- /dev/null
> > +++ b/hw/i2c/designware_i2c.c
> > @@ -0,0 +1,817 @@
> > +/*
> > + * DesignWare I2C Module.
> > + *
> > + * Copyright 2021 Google LLC
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +
> > +#include "hw/i2c/designware_i2c.h"
> > +#include "migration/vmstate.h"
> > +#include "qemu/bitops.h"
> > +#include "qemu/log.h"
> > +#include "qemu/module.h"
> > +#include "qemu/units.h"
> > +#include "trace.h"
> > +
> > +enum DesignWareI2CRegister {
> > +    DW_IC_CON                   = 0x00,
> > +    DW_IC_TAR                   = 0x04,
> > +    DW_IC_SAR                   = 0x08,
> > +    DW_IC_DATA_CMD              = 0x10,
> > +    DW_IC_SS_SCL_HCNT           = 0x14,
> > +    DW_IC_SS_SCL_LCNT           = 0x18,
> > +    DW_IC_FS_SCL_HCNT           = 0x1c,
> > +    DW_IC_FS_SCL_LCNT           = 0x20,
> > +    DW_IC_INTR_STAT             = 0x2c,
> > +    DW_IC_INTR_MASK             = 0x30,
> > +    DW_IC_RAW_INTR_STAT         = 0x34,
> > +    DW_IC_RX_TL                 = 0x38,
> > +    DW_IC_TX_TL                 = 0x3c,
> > +    DW_IC_CLR_INTR              = 0x40,
> > +    DW_IC_CLR_RX_UNDER          = 0x44,
> > +    DW_IC_CLR_RX_OVER           = 0x48,
> > +    DW_IC_CLR_TX_OVER           = 0x4c,
> > +    DW_IC_CLR_RD_REQ            = 0x50,
> > +    DW_IC_CLR_TX_ABRT           = 0x54,
> > +    DW_IC_CLR_RX_DONE           = 0x58,
> > +    DW_IC_CLR_ACTIVITY          = 0x5c,
> > +    DW_IC_CLR_STOP_DET          = 0x60,
> > +    DW_IC_CLR_START_DET         = 0x64,
> > +    DW_IC_CLR_GEN_CALL          = 0x68,
> > +    DW_IC_ENABLE                = 0x6c,
> > +    DW_IC_STATUS                = 0x70,
> > +    DW_IC_TXFLR                 = 0x74,
> > +    DW_IC_RXFLR                 = 0x78,
> > +    DW_IC_SDA_HOLD              = 0x7c,
> > +    DW_IC_TX_ABRT_SOURCE        = 0x80,
> > +    DW_IC_SLV_DATA_NACK_ONLY    = 0x84,
> > +    DW_IC_DMA_CR                = 0x88,
> > +    DW_IC_DMA_TDLR              = 0x8c,
> > +    DW_IC_DMA_RDLR              = 0x90,
> > +    DW_IC_SDA_SETUP             = 0x94,
> > +    DW_IC_ACK_GENERAL_CALL      = 0x98,
> > +    DW_IC_ENABLE_STATUS         = 0x9c,
> > +    DW_IC_FS_SPKLEN             = 0xa0,
> > +    DW_IC_CLR_RESTART_DET       = 0xa8,
> > +    DW_IC_COMP_PARAM_1          = 0xf4,
> > +    DW_IC_COMP_VERSION          = 0xf8,
> > +    DW_IC_COMP_TYPE             = 0xfc,
> > +};
> > +
> > +/* DW_IC_CON fields */
> > +#define DW_IC_CON_STOP_DET_IF_MASTER_ACTIV  BIT(10)
> > +#define DW_IC_CON_RX_FIFO_FULL_HLD_CTRL     BIT(9)
> > +#define DW_IC_CON_TX_EMPTY_CTRL             BIT(8)
> > +#define DW_IC_CON_STOP_IF_ADDRESSED         BIT(7)
> > +#define DW_IC_CON_SLAVE_DISABLE             BIT(6)
> > +#define DW_IC_CON_IC_RESTART_EN             BIT(5)
> > +#define DW_IC_CON_10BITADDR_MASTER          BIT(4)
> > +#define DW_IC_CON_10BITADDR_SLAVE           BIT(3)
> > +#define DW_IC_CON_SPEED(rv)                 extract32((rv), 1, 2)
> > +#define DW_IC_CON_MASTER_MODE               BIT(0)
> > +
> > +/* DW_IC_TAR fields */
> > +#define DW_IC_TAR_IC_10BITADDR_MASTER  BIT(12)
> > +#define DW_IC_TAR_SPECIAL              BIT(11)
> > +#define DW_IC_TAR_GC_OR_START          BIT(10)
> > +#define DW_IC_TAR_ADDRESS(rv)          extract32((rv), 0, 10)
> > +
> > +/* DW_IC_DATA_CMD fields */
> > +#define DW_IC_DATA_CMD_RESTART  BIT(10)
> > +#define DW_IC_DATA_CMD_STOP     BIT(9)
> > +#define DW_IC_DATA_CMD_CMD      BIT(8)
> > +#define DW_IC_DATA_CMD_DAT(rv)  extract32((rv), 0, 8)
> > +
> > +/* DW_IC_INTR_STAT/INTR_MASK/RAW_INTR_STAT fields */
> > +#define DW_IC_INTR_RESTART_DET  BIT(12)
> > +#define DW_IC_INTR_GEN_CALL     BIT(11)
> > +#define DW_IC_INTR_START_DET    BIT(10)
> > +#define DW_IC_INTR_STOP_DET     BIT(9)
> > +#define DW_IC_INTR_ACTIVITY     BIT(8)
> > +#define DW_IC_INTR_RX_DONE      BIT(7)
> > +#define DW_IC_INTR_TX_ABRT      BIT(6)
> > +#define DW_IC_INTR_RD_REQ       BIT(5)
> > +#define DW_IC_INTR_TX_EMPTY     BIT(4) /* Hardware clear only. */
> > +#define DW_IC_INTR_TX_OVER      BIT(3)
> > +#define DW_IC_INTR_RX_FULL      BIT(2) /* Hardware clear only. */
> > +#define DW_IC_INTR_RX_OVER      BIT(1)
> > +#define DW_IC_INTR_RX_UNDER     BIT(0)
> > +
> > +/* DW_IC_ENABLE fields */
> > +#define DW_IC_ENABLE_TX_CMD_BLOCK  BIT(2)
> > +#define DW_IC_ENABLE_ABORT         BIT(1)
> > +#define DW_IC_ENABLE_ENABLE        BIT(0)
> > +
> > +/* DW_IC_STATUS fields */
> > +#define DW_IC_STATUS_SLV_ACTIVITY  BIT(6)
> > +#define DW_IC_STATUS_MST_ACTIVITY  BIT(5)
> > +#define DW_IC_STATUS_RFF           BIT(4)
> > +#define DW_IC_STATUS_RFNE          BIT(3)
> > +#define DW_IC_STATUS_TFE           BIT(2)
> > +#define DW_IC_STATUS_TFNF          BIT(1)
> > +#define DW_IC_STATUS_ACTIVITY      BIT(0)
> > +
> > +/* DW_IC_TX_ABRT_SOURCE fields */
> > +#define DW_IC_TX_TX_FLUSH_CNT          extract32((rv), 23, 9)
> > +#define DW_IC_TX_ABRT_USER_ABRT        BIT(16)
> > +#define DW_IC_TX_ABRT_SLVRD_INTX       BIT(15)
> > +#define DW_IC_TX_ABRT_SLV_ARBLOST      BIT(14)
> > +#define DW_IC_TX_ABRT_SLVFLUSH_TXFIFO  BIT(13)
> > +#define DW_IC_TX_ARB_LOST              BIT(12)
> > +#define DW_IC_TX_ABRT_MASTER_DIS       BIT(11)
> > +#define DW_IC_TX_ABRT_10B_RD_NORSTRT   BIT(10)
> > +#define DW_IC_TX_ABRT_SBYTE_NORSTRT    BIT(9)
> > +#define DW_IC_TX_ABRT_HS_NORSTRT       BIT(8)
> > +#define DW_IC_TX_ABRT_SBYTE_ACKDET     BIT(7)
> > +#define DW_IC_TX_ABRT_HS_ACKDET        BIT(6)
> > +#define DW_IC_TX_ABRT_GCALL_READ       BIT(5)
> > +#define DW_IC_TX_ABRT_GCALL_NOACK      BIT(4)
> > +#define DW_IC_TX_ABRT_TXDATA_NOACK     BIT(3)
> > +#define DW_IC_TX_ABRT_10ADDR2_NOACK    BIT(2)
> > +#define DW_IC_TX_ABRT_10ADDR1_NOACK    BIT(1)
> > +#define DW_IC_TX_ABRT_7B_ADDR_NOACK    BIT(0)
> > +
> > +
> > +/* IC_ENABLE_STATUS fields */
> > +#define DW_IC_ENABLE_STATUS_SLV_RX_DATA_LOST         BIT(2)
> > +#define DW_IC_ENABLE_STATUS_SLV_DISABLED_WHILE_BUSY  BIT(1)
> > +#define DW_IC_ENABLE_STATUS_IC_EN                    BIT(0)
> > +
> > +/* Masks for writable registers. */
> > +#define DW_IC_CON_MASK          0x000003ff
> > +#define DW_IC_TAR_MASK          0x00000fff
> > +#define DW_IC_SAR_MASK          0x000003ff
> > +#define DW_IC_SS_SCL_HCNT_MASK  0x0000ffff
> > +#define DW_IC_SS_SCL_LCNT_MASK  0x0000ffff
> > +#define DW_IC_FS_SCL_HCNT_MASK  0x0000ffff
> > +#define DW_IC_FS_SCL_LCNT_MASK  0x0000ffff
> > +#define DW_IC_INTR_MASK_MASK    0x00001fff
> > +#define DW_IC_ENABLE_MASK       0x00000007
> > +#define DW_IC_SDA_HOLD_MASK     0x00ffffff
> > +#define DW_IC_SDA_SETUP_MASK    0x000000ff
> > +#define DW_IC_FS_SPKLEN_MASK    0x000000ff
> > +
> > +/* Reset values */
> > +#define DW_IC_CON_INIT_VAL          0x7d
> > +#define DW_IC_TAR_INIT_VAL          0x1055
> > +#define DW_IC_SAR_INIT_VAL          0x55
> > +#define DW_IC_SS_SCL_HCNT_INIT_VAL  0x190
> > +#define DW_IC_SS_SCL_LCNT_INIT_VAL  0x1d6
> > +#define DW_IC_FS_SCL_HCNT_INIT_VAL  0x3c
> > +#define DW_IC_FS_SCL_LCNT_INIT_VAL  0x82
> > +#define DW_IC_INTR_MASK_INIT_VAL    0x8ff
> > +#define DW_IC_STATUS_INIT_VAL       0x6
> > +#define DW_IC_SDA_HOLD_INIT_VAL     0x1
> > +#define DW_IC_SDA_SETUP_INIT_VAL    0x64
> > +#define DW_IC_FS_SPKLEN_INIT_VAL    0x2
> > +
> > +#define DW_IC_COMP_PARAM_1_HAS_ENCODED_PARAMS   BIT(7)
> > +#define DW_IC_COMP_PARAM_1_HAS_DMA              0 /* bit 6 - DMA disabled. */
> > +#define DW_IC_COMP_PARAM_1_INTR_IO              BIT(5)
> > +#define DW_IC_COMP_PARAM_1_HC_COUNT_VAL         0 /* bit 4 - disabled */
> > +#define DW_IC_COMP_PARAM_1_HIGH_SPEED_MODE      (BIT(2) | BIT(3))
> > +#define DW_IC_COMP_PARAM_1_APB_DATA_WIDTH_32    BIT(1) /* bits 0, 1 */
> > +#define DW_IC_COMP_PARAM_1_INIT_VAL             \
> > +    (DW_IC_COMP_PARAM_1_APB_DATA_WIDTH_32 | \
> > +    DW_IC_COMP_PARAM_1_HIGH_SPEED_MODE | \
> > +    DW_IC_COMP_PARAM_1_HC_COUNT_VAL | \
> > +    DW_IC_COMP_PARAM_1_INTR_IO | \
> > +    DW_IC_COMP_PARAM_1_HAS_DMA | \
> > +    DW_IC_COMP_PARAM_1_HAS_ENCODED_PARAMS | \
> > +    ((DESIGNWARE_I2C_RX_FIFO_SIZE - 1) << 8) | \
> > +    ((DESIGNWARE_I2C_TX_FIFO_SIZE - 1) << 16))
> > +#define DW_IC_COMP_VERSION_INIT_VAL             0x3132302a
> > +#define DW_IC_COMP_TYPE_INIT_VAL                0x44570140
> 
> I would prefer these to sue the QEMU register API

That's probably a good idea. It's a lot of churn to change it, but
I'm having a try. Might do it as a follow on patch.

> > +
> > +    /* Receive data */
> > +    if (recv) {
> > +        uint8_t pos = (s->rx_cur + s->ic_rxflr) % DESIGNWARE_I2C_RX_FIFO_SIZE;
> > +
> > +        if (s->ic_rxflr < DESIGNWARE_I2C_RX_FIFO_SIZE) {
> > +            s->rx_fifo[pos] = i2c_recv(s->bus);
> > +            s->ic_rxflr++;
> 
> QEMU also has the Fifo8 which would handle the FIFO for you, I would
> prefer that as well.

Yeah, that one isn't so hard and makes the code nicer. I might've found
a bug in dw_i2c_reset_to_idle() not clearing rx_cur while doing it.

Thanks,
Nick

