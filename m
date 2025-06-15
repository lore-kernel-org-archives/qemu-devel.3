Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41EF3C7115A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Jun 2025 22:31:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQvsQ-00021y-Kg; Sun, 15 Jun 2025 18:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>) id 1uQvsH-000208-M0
 for qemu-devel@nongnu.org; Sun, 15 Jun 2025 18:30:51 -0400
Received: from smtpx1.feld.cvut.cz ([147.32.210.191])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>) id 1uQvsE-0003dY-TO
 for qemu-devel@nongnu.org; Sun, 15 Jun 2025 18:30:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
 s=felmail; t=1750026640;
 bh=Z0nWrGDUNIDaHZmGn6XZ8SP7SgWOUC3qySfpIjK0Nps=;
 h=From:To:Subject:Date:Cc:References:In-Reply-To:From;
 b=qc6/o0qpdkoTYE7RSDEczKd2IpEZbPH9mTiR91bK7DRr6uqDAbHqVg5YPGCuKoH/b
 AgiIbD6KBTgOkXzjFcOnptg0cSLzdddlzHj3VN85xS43mRU2mOIlxwtYVLZz7qaMx9
 mwdfwgUJckHGH6PHCmqoLBx3kZnwbnZKO6ftOX4bjeYjGxZBEpvnqNLBOmdcglvYJG
 FBiA+Sa5mpnHvTWNGPbQkvwvUGj4hfxQKizv6fRlcMQcwmWKU8zUuDRLOJpZXpWVa0
 lxmfKLCQMzjcLWqyq1oLlxyHK038lvba+Zy9YVLnyEwiEGVLrP+gpZLWDPDfB0eLSn
 3OUnK/6f4rw7Q==
Received: from smtpx.fel.cvut.cz (smtpx.feld.cvut.cz [147.32.210.153])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtpx1.feld.cvut.cz (Postfix) with ESMTPS id 274B533A77;
 Mon, 16 Jun 2025 00:30:40 +0200 (CEST)
Received: from localhost (unknown [192.168.200.27])
 by smtpx.fel.cvut.cz (Postfix) with ESMTP id 1C05D2F751;
 Mon, 16 Jun 2025 00:30:40 +0200 (CEST)
X-Virus-Scanned: IMAP STYX AMAVIS
Authentication-Results: cerokez-250.feld.cvut.cz (amavis);
 dkim=pass (2048-bit key) header.d=fel.cvut.cz
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (cerokez-250.feld.cvut.cz [192.168.200.27]) (amavis, port 10060)
 with ESMTP id ygR14AuQQAMd; Mon, 16 Jun 2025 00:30:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
 s=felmail; t=1750026638;
 bh=Z0nWrGDUNIDaHZmGn6XZ8SP7SgWOUC3qySfpIjK0Nps=;
 h=From:To:Subject:Date:Cc:References:In-Reply-To:From;
 b=o+mgDzS2CQ527a6NgEQpdyXfEU4mXc5J6ecs0yanOVsNIykzmvDu3sGlNrXJJIDAH
 v50mb2YJJTfUmDa+FFBqlZse5A6MV4m2+9QtZ/W06XkzNO7EUzbDuY7vu3MP4j3/5B
 s4AKLzmrXsXYZ6X590V1tCbGl2DbjHGYFT6FYCebp7Ij4OmWMSSa5XSp3PmDYBkCSx
 qQ4paMNNDMtMlFPUhYze4OM0DYwxRSdaD4YoJHdGjxiJxEdrTlEOQF6P7OpsvuBqjh
 1s4ku5dovQjZGPzr2Cb7nm8I8RVqD/vohPfOOLtui3BWqTdGqOnA1HyHNfPiYGI5ez
 ErwBbt224SKQg==
Received: from baree.pikron.com (static-84-242-78-234.bb.vodafone.cz
 [84.242.78.234])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pisa)
 by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id E4F532F74F;
 Mon, 16 Jun 2025 00:30:36 +0200 (CEST)
From: Pavel Pisa <pisa@fel.cvut.cz>
To: qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v1 1/3] hw/net/can: CTU CAN FD IP core mapping to the
 platform bus
Date: Mon, 16 Jun 2025 00:31:21 +0200
User-Agent: KMail/1.9.10
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Ondrej Ille <ondrej.ille@gmail.com>, Jiri Novak <jnovak@fel.cvut.cz>,
 =?utf-8?q?Maty=C3=A1=C5=A1_Bobek?= <bobekmat@fel.cvut.cz>
References: <cover.1748432169.git.pisa@cmp.felk.cvut.cz>
 <db331a037c362f5e9e4f35cf61fc1670aa7c96bf.1748432169.git.pisa@cmp.felk.cvut.cz>
 <CAFEAcA8BpF=gRAfUHk1i8avgsB3Cs7GY=L=S_ANysZApXCHLXQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8BpF=gRAfUHk1i8avgsB3Cs7GY=L=S_ANysZApXCHLXQ@mail.gmail.com>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202506160031.21142.pisa@fel.cvut.cz>
Received-SPF: pass client-ip=147.32.210.191; envelope-from=pisa@fel.cvut.cz;
 helo=smtpx1.feld.cvut.cz
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, NICE_REPLY_A=-2.554,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hello Peter,

thanks for the response.

On Thursday 12 of June 2025 17:50:20 Peter Maydell wrote:
> On Wed, 28 May 2025 at 12:50, Pavel Pisa <pisa@cmp.felk.cvut.cz> wrote:
> > The system/platform bus mapping alternative to PCI/PCIe mapping.
> > In this case, the platform bus is used to match FPGA design
> > for Xilinx Zynq MZ_APO education kit with four CTU CAN FD
> > cores on branch mz_apo-2x-xcan-4x-ctu of repo
> >
> >   https://gitlab.fel.cvut.cz/canbus/zynq/zynq-can-sja1000-top
> >
> > The system is started by command
> >
> >   qemu-system-arm -m 1G -M xilinx-zynq-a9 \
> >       -kernel kernel-zynq \
> >       -dtb zynq-microzed-uart1-2x-xcan-4x-ctu-axi.dtb \
> >       -initrd ramdisk.cpio \
> >       -serial null -serial mon:stdio \
> >       -nographic \
> >       -object can-bus,id=canbus0-bus \
> >       -object
> > can-host-socketcan,if=can0,canbus=canbus0-bus,id=canbus0-socketcan \
> > -device
> > ctucan_mm,iobase=0x43c30000,irqnum=29,irqctrl=/machine/unattached/device[
> >3],canbus=canbus0-bus \ -device
> > ctucan_mm,iobase=0x43c70000,irqnum=30,irqctrl=/machine/unattached/device[
> >3],canbus=canbus0-bus \ -device
> > ctucan_mm,iobase=0x43bf0000,irqnum=31,irqctrl=/machine/unattached/device[
> >3],canbus=canbus0-bus \ -device
> > ctucan_mm,iobase=0x43bb0000,irqnum=32,irqctrl=/machine/unattached/device[
> >3],canbus=canbus0-bus
>
> Please don't use the platform bus for this. Command line
> created devices should not have properties like "iobase"
> and should not be mapping their own MMIO regions in their
> realize methods.
>
> If we have a board that does or should have a memory-mapped
> CAN device, then that board should create it at the appropriate
> address and wire up the interrupt lines.

That is easy when SoC has integrated IP on the silicon,
in our case ESP32-C5. So if Espressif's chips are emulated
by mainline QEMU one day are, then it would be easy to add
CTU CAN FD support into appropriate chips.

My student has defended thesis documenting his FlexCAN
for iMX6 emulation last week
  https://dspace.cvut.cz/bitstream/handle/10467/122654/F3-BP-2025-Bobek-Matyas-BP_Bobek_FlexCAN_final_4.pdf
  https://gitlab.fel.cvut.cz/bobekmat/qemu-flexcan
The code will need review and there could be problems
but there are no doubts how to integrate it into QEMU
supported SoC.

But CTU CAN FD as FPGA IP component is another case.

> We don't have infrastructure currently for users to create
> custom "frankenstein" setups on the command line, and I don't
> want us to add small disconnected portions of it ad-hoc.
>
> I'll let the Zynq board maintainers make the call about whether
> they want to add a CAN bus controller to it.

I do not expect that they want it as the standard component
of the SoC support. The CTU CAN FD is an IP core which
can be synthesized from our VHDL sources
  https://canbus.pages.fel.cvut.cz/
into one of AXI processor system (PS) to programmable
logic (PL/FPGA) regions.

The Xilinx QEMU fork adds support for that with some mechanism
based on device-tree and dynamic mapping of designed IP cores
functional emulation into address space. But that is part
of their fork. I would like to support, contribute and provide
mainline QEMU to Linux, RTEMS and NuttX communities and proposed
solution seems to me as the least intrusive option.

The QEMU use is for CAN subsystem maintenance, development and
CI tests for these systems as well as the option for application
developers to test whole system including CAN communication.
We want to use it even for RTEMS, Linux and NuttX CAN testing
on PolarFife, where we plan to work even on design example
for FPGA soon.

Is there some other alternative how to add support
of FPGA AXI mapped IP cores to QEMU mainline?
If not, is there chance that something else emerges and is
acceptable in some foreseen future?

Best wishes,

                Pavel
--
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

