Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BF31CE9D6E
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 15:52:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd9ME-0000S7-Ar; Tue, 06 Jan 2026 10:52:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vd9MC-0000RL-Pw; Tue, 06 Jan 2026 10:52:28 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vd9MA-0005H0-Kf; Tue, 06 Jan 2026 10:52:28 -0500
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dlwfC2Qt0zJ46rw;
 Tue,  6 Jan 2026 23:52:19 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
 by mail.maildlp.com (Postfix) with ESMTPS id 213CA40569;
 Tue,  6 Jan 2026 23:52:21 +0800 (CST)
Received: from localhost (10.195.245.156) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 6 Jan
 2026 15:52:20 +0000
Date: Tue, 6 Jan 2026 15:52:18 +0000
To: <AlanoSong@163.com>
CC: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <cminyard@mvista.com>,
 <peter.maydell@linaro.org>, <philmd@linaro.org>, <ani@anisinha.ca>,
 <pbonzini@redhat.com>, <shannon.zhaosl@gmail.com>
Subject: Re: [PATCH 1/2] hw/i2c/dw: Add DesignWare I2C controller emulator
Message-ID: <20260106155218.0000310f@huawei.com>
In-Reply-To: <20260106131253.16192-2-AlanoSong@163.com>
References: <20260106131253.16192-1-AlanoSong@163.com>
 <20260106131253.16192-2-AlanoSong@163.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.245.156]
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml100005.china.huawei.com (7.214.146.113)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue,  6 Jan 2026 21:12:52 +0800
AlanoSong@163.com wrote:

> Add DesignWare I2C controller according to DesignWare
> I2C databook v2.01a.
> Confirmed the model with i2c-tools under v6.18
> linux driver.
> 
> The slave mode is not implemented, cause this feature
> is usually not used.
> 
> The 10 bit slave address is not implemented, cause
> this feature is usually not used, and not supported
> by qemu I2C core bus currently.
> 
> Signed-off-by: Alano Song <AlanoSong@163.com>
Hi Alano,

A very superficial review. Sadly I don't have time to dig
much deeper at the moment.

Good to see this support.

Jonathan

> diff --git a/hw/i2c/dw_i2c.c b/hw/i2c/dw_i2c.c
> new file mode 100644
> index 0000000000..a5a31ec78c
> --- /dev/null
> +++ b/hw/i2c/dw_i2c.c
> @@ -0,0 +1,517 @@
> +/*
> + *  DesignWare I2C Bus Serial Interface Emulation
> + *
> + *  Copyright (C) 2026 Alano Song <AlanoSong@163.com>
> + *
> + *  This program is free software; you can redistribute it and/or modify it
> + *  under the terms of the GNU General Public License as published by the
> + *  Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful, but WITHOUT
> + *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + *  FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
> + *  for more details.
> + *
> + *  You should have received a copy of the GNU General Public License along
> + *  with this program; if not, see <http://www.gnu.org/licenses/>.
> + *
> + */
As below. Can probably replace the boilerplate with an SPDX license
line and just have the copyright + intro text here.


> diff --git a/include/hw/i2c/dw_i2c.h b/include/hw/i2c/dw_i2c.h
> new file mode 100644
> index 0000000000..512c749f21
> --- /dev/null
> +++ b/include/hw/i2c/dw_i2c.h
> @@ -0,0 +1,151 @@
> +/*
> + *  DesignWare I2C Bus Serial Interface Emulation
> + *
> + *  Copyright (C) 2026 Alano Song <AlanoSong@163.com>
> + *
> + *  This program is free software; you can redistribute it and/or modify it
> + *  under the terms of the GNU General Public License as published by the
> + *  Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful, but WITHOUT
> + *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + *  FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
> + *  for more details.
> + *
> + *  You should have received a copy of the GNU General Public License along
> + *  with this program; if not, see <http://www.gnu.org/licenses/>.

For new code in QEMU I think we are fine with just SPDX.  See many examples
in tree.  It saves on repeating this boilerplate.

> + *
> + */
> +
> +#ifndef DW_I2C_H
> +#define DW_I2C_H
> +
> +#include "hw/core/sysbus.h"
> +#include "qom/object.h"
> +#include "qemu/fifo8.h"
> +
> +#define TYPE_DW_I2C "dw.i2c"
> +OBJECT_DECLARE_SIMPLE_TYPE(DWI2CState, DW_I2C)
> +
> +#define DW_I2C_TX_FIFO_DEPTH        16
> +#define DW_I2C_RX_FIFO_DEPTH        16

> +
> +#define DW_IC_CON_MASTER            BIT(0)
> +#define DW_IC_CON_SPEED_STANDARD    (0x1 << 1)
> +#define DW_IC_CON_SPEED_FAST        (0x2 << 1)
> +#define DW_IC_CON_SPEED_HIGH        (0x3 << 1)

Smells of value being written to a field rather than
a series of values with meaning on their own. Qemu
has a rich set of register field macros. I'd look
at using those to make your life easier.

> +#define DW_IC_CON_RESTART_EN        BIT(5)


