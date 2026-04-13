Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF579F531CE
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 22:31:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCPo6-0006Ab-Gg; Mon, 13 Apr 2026 18:31:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>)
 id 1wCPnr-00068n-Jx; Mon, 13 Apr 2026 18:30:57 -0400
Received: from smtpx.feld.cvut.cz ([147.32.210.153] helo=smtpx.fel.cvut.cz)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>)
 id 1wCPnn-00049I-Sk; Mon, 13 Apr 2026 18:30:47 -0400
Received: from localhost (unknown [192.168.200.27])
 by smtpx.fel.cvut.cz (Postfix) with ESMTP id 315A51D761;
 Tue, 14 Apr 2026 00:30:38 +0200 (CEST)
X-Virus-Scanned: IMAP STYX AMAVIS
Authentication-Results: cerokez-250.feld.cvut.cz (amavis);
 dkim=pass (2048-bit key) header.d=fel.cvut.cz
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (cerokez-250.feld.cvut.cz [192.168.200.27]) (amavis, port 10060)
 with ESMTP id 6pGXoF2YCln6; Tue, 14 Apr 2026 00:30:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
 s=felmail; t=1776119436;
 bh=ytsv3OaWJupADmi9crU4Hx02RH1WhyA+ZtWFnpTotgo=;
 h=From:To:Subject:Date:Cc:References:In-Reply-To:From;
 b=sfP2okAo1FJRtAvxmj83iLJcFDCWv+RZuqJX/qVDbOYSsVn305XYBDoVujoGSMyO+
 t9sjtz3z+if+7woFxo7w/Lkfx/Ydj8qBNefZ7DRxX3n6KDN64hq9HQqCcAT0B5Yvu9
 6yHkBmIXhIErjUqM/NbJuepYRS87YMAKqHUymt0d7xCozuLRQyBXqfn8TmYgli9n6o
 XY/4qIwOMQF5N2gLoFIM2Y4Q0AziQQMczVmCIi4XxCgm03OxzSLmaFNT42IZguwuQf
 rgNat2pMZLma/U2LVvokAkGSrhqtI2mb3yNK5K9u3iQXQP5EwEna/L7I+YvwN/kw8a
 FAu18vkskhYkw==
Received: from baree.pikron.com (static-84-242-78-234.bb.vodafone.cz
 [84.242.78.234])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pisa)
 by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id 670B11D86B;
 Tue, 14 Apr 2026 00:30:36 +0200 (CEST)
From: Pavel Pisa <pisa@fel.cvut.cz>
To: Bernhard Beschow <shentey@gmail.com>
Subject: Re: [PATCH v2 4/7] hw/net/can/flexcan: NXP FlexCAN core emulation
Date: Tue, 14 Apr 2026 00:30:35 +0200
User-Agent: KMail/1.9.10
Cc: =?utf-8?q?Maty=C3=A1=C5=A1_Bobek?= <matyas.bobek@gmail.com>,
 qemu-devel@nongnu.org, Matyas Bobek <bobekmat@fel.cvut.cz>,
 qemu-arm@nongnu.org, "Marc Kleine-Budde" <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <cover.1773866323.git.matyas.bobek@gmail.com>
 <e790990bfaaebf2c1dd884c2c2f4eab5de6d4076.1773866323.git.matyas.bobek@gmail.com>
 <9c21bd91-3732-4438-9b83-dc36e09f9ec3@gmail.com>
In-Reply-To: <9c21bd91-3732-4438-9b83-dc36e09f9ec3@gmail.com>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <202604140030.35350.pisa@fel.cvut.cz>
Received-SPF: pass client-ip=147.32.210.153; envelope-from=pisa@fel.cvut.cz;
 helo=smtpx.fel.cvut.cz
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, NICE_REPLY_A=-3.135,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Dear Bernhard,

thanks for time for review. I agree with all suggested
changes except one where I express soft opinion
to keep code as it is, see below.=20

On Monday 13 of April 2026 12:56:40 Bernhard Beschow wrote:
> Am 19. M=C3=A4rz 2026 19:13:11 UTC schrieb "Maty=C3=A1=C5=A1 Bobek"
>
> <matyas.bobek@gmail.com>:
> >Added the FlexCAN2 emulator implementation core, with
> >CAN_FLEXCAN Kconfig flag and MAINTAINERS entry.
> >
> >FlexCAN2 version can be found in i.MX6 SoCs and others.
> >
> >More information about the implementation can be found in [1].
> >
> >[1]
> > http://dspace.cvut.cz/bitstream/handle/10467/122654/F3-BP-2025-Bobek-Ma=
ty
> >as-BP_Bobek_FlexCAN_final_4.pdf
> >
> >Signed-off-by: Maty=C3=A1=C5=A1 Bobek <matyas.bobek@gmail.com>
> >---
=2E..
> >+    flexcan_irq_update(s);
> >+}
> >+
> >+static void flexcan_mem_write(void *opaque, hwaddr addr, uint64_t val,
> >+                              unsigned size)
> >+{
> >+    FlexcanState *s =3D opaque;
> >+
> >+    flexcan_trace_mem_op(s, addr, val, size, true);
> >+    flexcan_reg_write(s, addr, (uint32_t)val);
>
> The contribution of this method is now only to add a trace statement. It
> can now be merged with flexcan_reg_write(), keeping the
> flexcan_mem_write() identifier.
>
> Note: I suggest to call the trace function just before the switch
> statement, i.e. after the variable declarations.

I would suggest to keep names

  flexcan_mem_write()
  flexcan_mem_read()

not to change one to flexcan_reg_write. The flexcan_reg_write()
can be absorbed into flexcan_mem_write() for now but for longer term
I would like that message boxes (user memory) writes are separated
from  register access though overlay structure describing registers
and in addition even reads from registers are separated from memory
area. That would better fit newer version of FlexCAN controllers.
=46or example on the imxRT there is FD capable FlexCAN and ranges

 0x0000 to 0x007f (used up to 0x53) is range for registers
 0x0080 to 0x047F is for up to 64 frames, data 8 byte (16 bytes each)
 0x0880 to 0x097C is range for Rx Individual Mask Registers (RXIMR0 - RXIMR=
63)
 0x0BF0 to 0x0D2f is again registers area, i.e. enhanced CAN bit-timing=20
 0x2000 to 0x204f is allocates the Enhanced Rx FIFO output
 0x3000 to 0x31FC is enhanced Rx FIFO filter element

So this is mix and may it there are even more variations between
different versions. So in these cases I would prefer to keep registers
block as separate structures, which needs RO/RW masks side effects
handling and memory areas in between as more regular RAM with no
masking and simpler side effects rules.

But I consider as the priority to have basic support which passes
review, is mainlined and can be used for imx6 developmet and CI testing
now. When we or somebody else find somebody with interrest at university
(i.e. final thesis, GSoC project) or some company willing to provide
some their developers time or funding, it can be base to move forward.
But there is no plan on my side at this moment. All my organization
and conceive of the QEMU CAN subsystem is personal activity without any
income and I have lot of other much higher priority projects for teaching
and even use in the the wild including space, so I cannot promise anything
nor predict any dates when something is ready...

By the way, I have noticed that you invest time into ESP32 mainlining
support. If you are willing to discuss that, I would open another
therad. I have tested original Espressinf QEMU version and tried
yours but end by segmentation-fault. May it be incorrect arguments
to QEMU.

The ESP32C3 QEMU support could be interesting for RTEMS community which
included basic ESP32C3 support in mainline

  https://users.rtems.org/t/rtems-support-for-esp32-xtensa-existing-bsp-wor=
k/660

and I have tested Michal Lenc's contributed RTEMS SJA1000 CAN driver
with real ESP32C3 chip up to detect and configuration phase and QEMU would
be great for CI and Espressinf and Yours QEMU already maps SJA1000/TWAI.
The RTEMS ESP32C6 support has proposal for this year RTEMS GSoC.
The ESP32C5 and ESP32S31 are even more interesting because they provide
motion control, CAN FD and the last one even wired Ethernet.=20

Best wishes

                Pavel

                Pavel Pisa
    phone:      +420 603531357
    e-mail:     pisa@cmp.felk.cvut.cz
    Department of Control Engineering FEE CVUT
    Karlovo namesti 13, 121 35, Prague 2
    university: http://control.fel.cvut.cz/
    personal:   http://cmp.felk.cvut.cz/~pisa
    social:     https://social.kernel.org/ppisa
    projects:   https://www.openhub.net/accounts/ppisa
    CAN related:http://canbus.pages.fel.cvut.cz/
    RISC-V education: https://comparch.edu.cvut.cz/
    Open Technologies Research Education and Exchange Services
    https://gitlab.fel.cvut.cz/otrees/org/-/wikis/home

