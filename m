Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C748CD5BAF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 20:25:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ9wY-0007Dk-Cz; Thu, 21 May 2026 16:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1wQ9wS-0007D9-Ks
 for qemu-devel@nongnu.org; Thu, 21 May 2026 16:24:30 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1wQ9wM-00070Y-IX
 for qemu-devel@nongnu.org; Thu, 21 May 2026 16:24:24 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-82f9fdfc965so3058591b3a.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 13:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779395058; x=1779999858; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KN0OsPMDfQXie9k1JqGXzBUNthccIyZQhv7ABy281jo=;
 b=g5IyX1M9JBzofwimWc3SKLEQpNfLc20xjvsfXrzHtFWxpVh/9z/SylL/hKUrvKHzrx
 f21YD38ZK4grn2ICf6xO+6W34t5IidoCO8yDXlnDXWOWkIrcbQjYROjfuSpD0MNf3TbH
 7dBDPRPgcD7FgXwigzPCadYmJpiKaU3bSmSk+JMEVleZa1/rCjYwZrc/DRQowxiiR1Nv
 BuKEEFXnKyDewCrBpadayyX7WKIqaEWx49+9N3+z5uJv8IPeqSqQmXI/S+iMS5ggTWo8
 zXKvug5l5IR992Os3UAfJH/R0pXds7PtbcDmFlgaXu95nkMYsBsHgZN3fLYGo6+aDGFG
 Ms8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779395058; x=1779999858;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KN0OsPMDfQXie9k1JqGXzBUNthccIyZQhv7ABy281jo=;
 b=r45YwSfh5iOzM69lirUvFFio8WyWVpn/f8FjUX0ZiR/NXMD2Mvd7B0/a6h+QnTgMq2
 p3u+m/O07uaKGpzRiHVZmmPlJ74MM3DrQtVVjlF1lOda0zxGEEectWSwQqiaQV7InSdQ
 gmpOeZpstarvPv1/9vOex4ZpOx+th25VuLhypYnzXbJ2U3JoMPy8HoJtTtAFslX02dv5
 Z0SklIPNOMN62Zi2uu/CBk0NHa9wstb2NWMMnuBESKx1gCYdbgLym/JPN+WjNVfzBblx
 LYjBFYN38fjCF6l6r0tVySlBk9i3DwEn3lfk27bT3+HHoTCGvMi9qLcQ3G1G77bX/vjL
 CwBw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8gYQmtAzBz+WpjlfcxzSsOcHMDFlHRJoRp2jiNK0mYDQdkWpUyeHU2NfQhQs2dlC96uAZorneyJbsR@nongnu.org
X-Gm-Message-State: AOJu0YzrrIu8pgDRQoS7MqR9ZJ/8ZtoDYfOszKeGS7KP4vkyhgskoWQa
 bVXcp5RVVbgrJPi0Nk1tm2/FF2tDTENr5jWUdLWNHyHT7xKd1mJarhas
X-Gm-Gg: Acq92OHkW6ybDMY4INMC3KPtKIMy/n9a7c0Gi9nrISMiq5+T+sbXVF6REl8UBMdO9Xi
 FnMj2rfS4zcuy6sPYKm3yjFK/DlNCggIfVBcqOwMQcakZf+5yoRxD4eB+2Z3DahzMft4My5u1zH
 cz31a0pey16ixBkvg3iT29ULA82phByDvUfYkWdJLfH/AJH0yUeNXdsZvdjJUnx10R+USjTlA9A
 VNNQ9wszNwpQBOJa6rDlPMFmgCcdwo8tz4sGmzL1l6T22aox6ms6iHzqvWuh6T/fz/H0Gtfr6cG
 ELSGLXexDT+ZbywAPNp9ibGZDGbgBB2QEAhaJIihWzVslK6kZNHKBnpIMFuAfU2r6Zx2sa9rxbj
 xZCbDRmnntvYKcUgW1ZtcSwz3812ey4dTFbNf4D8HfRya7+zoSoAqgSd11k1U4YZnyfk69Q2Sje
 pGPMDSVHVjh27e3t6c7ifB4bFpUZS08L1E8QCH
X-Received: by 2002:a05:6a00:e8e:b0:82f:1b1b:e166 with SMTP id
 d2e1a72fcca58-8415f33b21emr729002b3a.33.1779395057652; 
 Thu, 21 May 2026 13:24:17 -0700 (PDT)
Received: from google.com ([2402:7500:579:5981:b0bb:9ef6:6aa9:ac59])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84154a000cdsm1914006b3a.17.2026.05.21.13.24.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 13:24:16 -0700 (PDT)
Date: Fri, 22 May 2026 04:24:11 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Chao Liu <chao.liu.zevorn@gmail.com>
Cc: pbonzini@redhat.com, marcandre.lureau@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, christoph.muellner@vrull.eu,
 farosas@suse.de, lvivier@redhat.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, marscheng@google.com,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Subject: Re: [PATCH v2 3/6] hw/misc: Add Sophgo CV1800B clock controller
Message-ID: <ag9p62JNQi4IPumS@google.com>
References: <20260514011528.1263665-1-visitorckw@gmail.com>
 <20260514011528.1263665-4-visitorckw@gmail.com>
 <agrjBBqnINoAOCYS@ChaodeMBP.bbrouter>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <agrjBBqnINoAOCYS@ChaodeMBP.bbrouter>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=visitorckw@gmail.com; helo=mail-pf1-x42f.google.com
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

Hi Chao,

On Mon, May 18, 2026 at 06:13:58PM +0800, Chao Liu wrote:
> On Thu, May 14, 2026 at 01:15:25AM +0800, Kuan-Wei Chiu wrote:
> > Add a stub for the CV1800B clock controller. This is specifically
> > required for the SDHCI controller to function correctly under Linux.
> > 
> > The Linux 'sophgo,cv1800-clk' driver probes this device to determine
> > the clock tree configuration. This implementation sets the bypass
> > registers (CLK_BYP_0 and CLK_BYP_1) to 0xFFFFFFFF during reset,
> > matching the POR default state. This bypasses the PLLs and allows the
> > SDHCI and other peripherals to operate using the 25MHz reference clock.
> > 
> > Without this device, the SD card driver fails to initialize, preventing
> > the system from mounting the root filesystem from the SD card:
> > 
> > [    0.888739] Waiting for root device /dev/mmcblk0...
> > [   10.727739] mmc0: Timeout waiting for hardware cmd interrupt.
> > [   10.728042] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
> > [   10.728356] mmc0: sdhci: Sys addr:  0x00000002 | Version:  0x00002402
> > [   10.728618] mmc0: sdhci: Blk size:  0x00000000 | Blk cnt:  0x00000000
> > [   10.728919] mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x00000000
> > [   10.729271] mmc0: sdhci: Present:   0x01ff0000 | Host ctl: 0x00000001
> > [   10.729591] mmc0: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
> > [   10.729903] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000000
> > [   10.730223] mmc0: sdhci: Timeout:   0x00000000 | Int stat: 0x00000000
> > [   10.730537] mmc0: sdhci: Int enab:  0x00ff0083 | Sig enab: 0x00ff0083
> > [   10.730795] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
> > [   10.731005] mmc0: sdhci: Caps:      0x056900b9 | Caps_1:   0x00000000
> > [   10.731211] mmc0: sdhci: Cmd:       0x00000000 | Max curr: 0x00000000
> > [   10.731415] mmc0: sdhci: Resp[0]:   0x00000000 | Resp[1]:  0x00000000
> > [   10.731636] mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
> > [   10.731851] mmc0: sdhci: Host ctl2: 0x00000000
> > [   10.732018] mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x00000000
> > [   10.732229] mmc0: sdhci: ============================================
> > 
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > ---
> >  hw/misc/Kconfig               |  3 ++
> >  hw/misc/cv1800b_clk.c         | 89 +++++++++++++++++++++++++++++++++++
> >  hw/misc/meson.build           |  1 +
> >  include/hw/misc/cv1800b_clk.h | 24 ++++++++++
> >  4 files changed, 117 insertions(+)
> >  create mode 100644 hw/misc/cv1800b_clk.c
> >  create mode 100644 include/hw/misc/cv1800b_clk.h
> > 
> > diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> > index 99bdf09219..42cdf771a4 100644
> > --- a/hw/misc/Kconfig
> > +++ b/hw/misc/Kconfig
> > @@ -254,4 +254,7 @@ config IOSB
> >  config XLNX_VERSAL_TRNG
> >      bool
> >  
> > +config SOPHGO_CV1800B_CLK
> > +    bool
> > +
> >  source macio/Kconfig
> > diff --git a/hw/misc/cv1800b_clk.c b/hw/misc/cv1800b_clk.c
> > new file mode 100644
> > index 0000000000..738f0910db
> > --- /dev/null
> > +++ b/hw/misc/cv1800b_clk.c
> > @@ -0,0 +1,89 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +/*
> > + * Sophgo CV1800B Clock Controller
> > + *
> > + * Copyright (c) 2026 Kuan-Wei Chiu <visitorckw@gmail.com>
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qemu/log.h"
> > +#include "hw/misc/cv1800b_clk.h"
> > +
> > +#define REG_CLK_BYP_0  (0x030 / 4)
> > +#define REG_CLK_BYP_1  (0x034 / 4)
> I suggest using the REG_BYTE_WIDTH macro instead of the constant value 4
> here and elsewhere.
> 
> #define REG_BYTE_WIDTH    (4)
> #define REG_CLK_BYP_0     (0x030 / REG_BYTE_WIDTH)
> #define REG_CLK_BYP_1     (0x034 / REG_BYTE_WIDTH)
> 
> You could also use `RegisterInfo` to define these register operations, so
> we don’t have to manually define these helper macros. Since this hardware
> is relatively simple, the current implementation is acceptable as well.
> 
Noted. Thanks.
I'll make this change when I respin this patchset.

Regards,
Kuan-Wei

