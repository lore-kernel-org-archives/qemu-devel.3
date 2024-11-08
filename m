Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85E80D5D69F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 01:48:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9E6F-0001xl-5m; Thu, 07 Nov 2024 20:47:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1t9E6B-0001se-T3; Thu, 07 Nov 2024 20:47:44 -0500
Received: from 60-248-80-70.hinet-ip.hinet.net ([60.248.80.70]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1t9E68-0003R9-U9; Thu, 07 Nov 2024 20:47:43 -0500
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
 by Atcsqr.andestech.com with ESMTP id 4A81GtZ6064481;
 Fri, 8 Nov 2024 09:16:55 +0800 (+08)
 (envelope-from ethan84@andestech.com)
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
 by Atcsqr.andestech.com with ESMTPS id 4A81GV5i064385
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 Nov 2024 09:16:31 +0800 (+08)
 (envelope-from ethan84@andestech.com)
Received: from ethan84-VirtualBox (10.0.12.12) by ATCPCS31.andestech.com
 (10.0.1.89) with Microsoft SMTP Server (TLS) id 14.3.498.0; Fri, 8 Nov 2024
 09:16:31 +0800
Date: Fri, 8 Nov 2024 09:16:23 +0800
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
CC: <qemu-devel@nongnu.org>, <richard.henderson@linaro.org>,
 <pbonzini@redhat.com>, <peterx@redhat.com>, <david@redhat.com>,
 <philmd@linaro.org>, <palmer@dabbelt.com>, <alistair.francis@wdc.com>,
 <bmeng.cn@gmail.com>, <liwei1518@gmail.com>,
 <zhiwei_liu@linux.alibaba.com>, <qemu-riscv@nongnu.org>
Subject: Re: [PATCH v8 0/8] Support RISC-V IOPMP
Message-ID: <Zy1mZ+yc+3j9keP3@ethan84-VirtualBox>
References: <20240715095702.1222213-1-ethan84@andestech.com>
 <b8e239d2-e0d5-4cac-a074-cb1ed277a08a@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b8e239d2-e0d5-4cac-a074-cb1ed277a08a@ventanamicro.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-Originating-IP: [10.0.12.12]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 4A81GtZ6064481
Received-SPF: pass client-ip=60.248.80.70; envelope-from=ethan84@andestech.com;
 helo=Atcsqr.andestech.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_DYNAMIC=0.982, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_RCVD_IP=0.001 autolearn=no autolearn_force=no
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

On Tue, Nov 05, 2024 at 03:36:07PM -0300, Daniel Henrique Barboza wrote:
> [EXTERNAL MAIL]
> 
> Hi Ethan,
> 
> 
> Do you plan to send a new version of this work? It seems to me that we're
> a couple of reviews away from getting it merged.
> 

Hi Daniel,

Thanks for checking in! I do plan to send an updated version, but it may take a 
bit more time.

Best regards,
Ethan

> 
> On 7/15/24 6:56 AM, Ethan Chen wrote:
> > This series implements basic functions of IOPMP specification v0.9.1 rapid-k
> > model.
> > The specification url:
> > https://github.com/riscv-non-isa/iopmp-spec/releases/tag/v0.9.1
> > 
> > When IOPMP is enabled, memory access to system memory from devices and
> > the CPU will be checked by the IOPMP.
> > 
> > The issue of CPU access to non-CPU address space via IOMMU was previously
> > mentioned by Jim Shu, who provided a patch[1] to fix it. IOPMP also requires
> > this patch.
> > 
> > [1] accel/tcg: Store section pointer in CPUTLBEntryFull
> >      https://patchew.org/QEMU/20240612081416.29704-1-jim.shu@sifive.com/20240612081416.29704-2-jim.shu@sifive.com/
> > 
> > 
> > Changes for v8:
> > 
> >    - Support transactions from CPU
> >    - Add an API to set up IOPMP protection for system memory
> >    - Add an API to configure the RISCV CPU to support IOPMP and specify the
> >      CPU's RRID
> >    - Add an API for DMA operation with IOPMP support
> >    - Add SPDX license identifiers to new files (Stefan W.)
> >    - Remove IOPMP PCI interface(pci_setup_iommu) (Zhiwei)
> > 
> > Changes for v7:
> > 
> >    - Change the specification version to v0.9.1
> >    - Remove the sps extension
> >    - Remove stall support, transaction information which need requestor device
> >      support.
> >    - Remove iopmp_cascade option for virt machine
> >    - Refine 'addr' range checks switch case (Daniel)
> > 
> > Ethan Chen (8):
> >    memory: Introduce memory region fetch operation
> >    system/physmem: Support IOMMU granularity smaller than TARGET_PAGE
> >      size
> >    target/riscv: Add support for IOPMP
> >    hw/misc/riscv_iopmp: Add RISC-V IOPMP device
> >    hw/misc/riscv_iopmp: Add API to set up IOPMP protection for system
> >      memory
> >    hw/misc/riscv_iopmp: Add API to configure RISCV CPU IOPMP support
> >    hw/misc/riscv_iopmp:  Add DMA operation with IOPMP support API
> >    hw/riscv/virt: Add IOPMP support
> > 
> >   accel/tcg/cputlb.c            |   29 +-
> >   docs/system/riscv/virt.rst    |    5 +
> >   hw/misc/Kconfig               |    3 +
> >   hw/misc/meson.build           |    1 +
> >   hw/misc/riscv_iopmp.c         | 1289 +++++++++++++++++++++++++++++++++
> >   hw/misc/trace-events          |    3 +
> >   hw/riscv/Kconfig              |    1 +
> >   hw/riscv/virt.c               |   63 ++
> >   include/exec/memory.h         |   30 +
> >   include/hw/misc/riscv_iopmp.h |  173 +++++
> >   include/hw/riscv/virt.h       |    5 +-
> >   system/memory.c               |  104 +++
> >   system/physmem.c              |    4 +
> >   system/trace-events           |    2 +
> >   target/riscv/cpu_cfg.h        |    2 +
> >   target/riscv/cpu_helper.c     |   18 +-
> >   16 files changed, 1722 insertions(+), 10 deletions(-)
> >   create mode 100644 hw/misc/riscv_iopmp.c
> >   create mode 100644 include/hw/misc/riscv_iopmp.h
> > 

