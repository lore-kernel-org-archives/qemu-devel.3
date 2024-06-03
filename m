Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE61C25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 03:48:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sDyfW-0000y7-2g; Sun, 02 Jun 2024 23:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1sDyfT-0000wU-8f; Sun, 02 Jun 2024 23:47:31 -0400
Received: from 60-248-80-70.hinet-ip.hinet.net ([60.248.80.70]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1sDyfQ-0003ri-4L; Sun, 02 Jun 2024 23:47:30 -0400
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
 by Atcsqr.andestech.com with ESMTP id 4533DGrc015663;
 Mon, 3 Jun 2024 11:13:16 +0800 (+08)
 (envelope-from ethan84@andestech.com)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 4533Ctcq015602;
 Mon, 3 Jun 2024 11:12:55 +0800 (+08)
 (envelope-from ethan84@andestech.com)
Received: from ethan84-VirtualBox (10.0.12.12) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Mon, 3 Jun 2024
 11:12:50 +0800
Date: Mon, 3 Jun 2024 11:12:44 +0800
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
CC: <qemu-devel@nongnu.org>, <pbonzini@redhat.com>, <palmer@dabbelt.com>,
 <alistair.francis@wdc.com>, <bin.meng@windriver.com>,
 <liwei1518@gmail.com>, <zhiwei_liu@linux.alibaba.com>,
 <qemu-riscv@nongnu.org>
Subject: Re: [PATCH v6 0/3] Support RISC-V IOPMP
Message-ID: <Zl00rIvxrkLohQi6@ethan84-VirtualBox>
References: <20240207093444.249112-1-ethan84@andestech.com>
 <6e46adc9-9e0a-4488-938f-fbf781e72996@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6e46adc9-9e0a-4488-938f-fbf781e72996@ventanamicro.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-Originating-IP: [10.0.12.12]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 4533DGrc015663
Received-SPF: pass client-ip=60.248.80.70; envelope-from=ethan84@andestech.com;
 helo=Atcsqr.andestech.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, RDNS_DYNAMIC=0.982,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, TVD_RCVD_IP=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Reply-to:  Ethan Chen <ethan84@andestech.com>
From:  Ethan Chen via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Dainel,

Sorry for the delayed response. I've been busy over the past two months.
I plan to submit the next version of the patch within two weeks.

Thanks,
Ethan Chen

On Mon, May 27, 2024 at 09:09:49AM -0300, Daniel Henrique Barboza wrote:
> Hi Ethan,
> 
> 
> Did you send v7 already and I somehow missed it? This is the latest version I
> have for this IOPMP work in my inbox.
> 
> If this is the latest, do you plan to send a new version? Most of the comments
> made in patche 2 are simple code style changes and there's no technical reason to
> not get this work merged for this release.
> 
> 
> Thanks,
> 
> Daniel
> 
> On 2/7/24 06:34, Ethan Chen wrote:
> > This series implements IOPMP specification v1.0.0-draft4 rapid-k model and add
> > IOPMP device to RISC-V virt machine.
> > 
> > Patch 1 add config STREAM make other device can reuse /hw/core/stream.c, IOPMP
> > implementation will use it. Patch 2 implement IOPMP deivce. Patch 3 add IOPMP
> > device to RISC-V virt machine.
> > 
> > The IOPMP specification url:
> > https://github.com/riscv-non-isa/iopmp-spec/blob/main/riscv_iopmp_specification.pdf
> > 
> > Changes for v6:
> >    - Rebased
> >    - IOPMP: Fix MDLCK_MD and ENTRYLCK_F did not lock correspond registers
> >             Fix iopmp_write for ENTRY_ADDRH and ENTRYLCK_L
> >    - Refine coding style (Daniel Henrique Barboza)
> > 
> > Thanks,
> > Ethan Chen
> > 
> > Ethan Chen (3):
> >    hw/core: Add config stream
> >    Add RISC-V IOPMP support
> >    hw/riscv/virt: Add IOPMP support
> > 
> >   docs/system/riscv/virt.rst                    |   12 +
> >   hw/Kconfig                                    |    1 +
> >   hw/core/Kconfig                               |    3 +
> >   hw/core/meson.build                           |    2 +-
> >   hw/misc/Kconfig                               |    4 +
> >   hw/misc/meson.build                           |    1 +
> >   hw/misc/riscv_iopmp.c                         | 1202 +++++++++++++++++
> >   hw/misc/trace-events                          |    4 +
> >   hw/riscv/Kconfig                              |    1 +
> >   hw/riscv/virt.c                               |  110 +-
> >   include/hw/misc/riscv_iopmp.h                 |  187 +++
> >   .../hw/misc/riscv_iopmp_transaction_info.h    |   28 +
> >   include/hw/riscv/virt.h                       |    8 +-
> >   13 files changed, 1559 insertions(+), 4 deletions(-)
> >   create mode 100644 hw/misc/riscv_iopmp.c
> >   create mode 100644 include/hw/misc/riscv_iopmp.h
> >   create mode 100644 include/hw/misc/riscv_iopmp_transaction_info.h
> > 
> 

