Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC4ACD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 12:59:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXIWN-0000zp-Ch; Wed, 10 Jun 2026 08:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cp0613@linux.alibaba.com>)
 id 1wXIWL-0000zB-7g; Wed, 10 Jun 2026 08:59:01 -0400
Received: from [115.124.30.124] (helo=out30-124.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cp0613@linux.alibaba.com>)
 id 1wXIWD-0007iJ-Sk; Wed, 10 Jun 2026 08:59:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1781096314; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=vpU7ZNjHFA9icKkFKSMunHnmJ4XPHPbRqufEXy/icBo=;
 b=B+r8JinLQKpMIRN8HlTiSwR69Spch7LzC1syMPA1myW4NqX4I1Fg/8qgtRUh4HknKbIIg3r/C/K+pTp53TdLERujLq9HKiD36YR9xlccKgvhDAOn/UFdsPszvUOIIwgSijWHHRpbtj6xsGZAjHCM/HCaJHVjaVLxTsLs9/G571w=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R931e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037026112;
 MF=cp0613@linux.alibaba.com; NM=1; PH=DS; RN=17; SR=0;
 TI=SMTPD_---0X4ajqa-_1781096310; 
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com
 fp:SMTPD_---0X4ajqa-_1781096310 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 10 Jun 2026 20:58:33 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: jic23@kernel.org
Cc: alistair.francis@wdc.com, chao.liu.zevorn@gmail.com,
 cp0613@linux.alibaba.com, daniel.barboza@oss.qualcomm.com,
 dave.jiang@intel.com, guoren@kernel.org, imammedo@redhat.com,
 linux-cxl@vger.kernel.org, liwei1518@gmail.com, mst@redhat.com,
 palmer@dabbelt.com, pbonzini@redhat.com, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, sunilvl@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com
Subject: Re: [PATCH 3/4] hw/riscv/virt,
 gpex: Provide 32-bit MMIO window for CXL host bridges
Date: Wed, 10 Jun 2026 20:58:29 +0800
Message-ID: <20260610125830.133654-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609135611.307122c8@jic23-huawei>
References: <20260609135611.307122c8@jic23-huawei>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.124 (deferred)
Received-SPF: pass client-ip=115.124.30.124;
 envelope-from=cp0613@linux.alibaba.com;
 helo=out30-124.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

On Tue, 9 Jun 2026 13:56:11 +0100, Jonathan Cameron <jic23@kernel.org> wrote:

Hi Jonathan,

> > CXL component register BAR (BAR0 on CXL Root Port and Type3 device)
> > and the CXL device register BAR (BAR2 on Type3 device) are declared
> > as 64-bit non-prefetchable memory.  A standard PCIe-to-PCI bridge
> > exposes a 32-bit non-prefetchable memory window plus an (optional)
> > 64-bit prefetchable memory window, but no 64-bit non-prefetchable
> > window.
> 
> When you say 'standard' do you mean that is all the PCI spec allows
> for?

Yes, I confirmed against the PCI-to-PCI Bridge Architecture
Specification, Revision 1.2 (PCI-SIG, 2003). Relevant sections:

  - Section 3.2.5.8 (Memory Base Register and Memory Limit Register):
      "The upper 12 bits of both the Memory Base and Memory Limit
       registers are read/write and correspond to the upper 12 address
       bits, AD[31::20], of 32-bit addresses."
    -> The non-prefetchable memory window is 32-bit only, and the
       Type 1 header defines no upper-32-bit extension for it.

  - Section 3.2.5.9 (Prefetchable Memory Base/Limit Register):
      The bottom 4 bits encode 64-bit support: 0h = 32-bit only,
      01h = 64-bit (extended via 3.2.5.10).

  - Section 3.2.5.10 (Prefetchable Base/Limit Upper 32 Bits):
      Optional registers that hold AD[63::32] for the 64-bit
      *prefetchable* range.

So the architecture only allows a 64-bit window when it is also
prefetchable; there is no 64-bit non-prefetchable form. PCIe
inherits this Type 1 header layout unchanged.

Public mirror of the spec text (Rev 1.1, identical wording for these
sections):
  https://0x04.net/~mwk/doc/pci/PCI-to-PCI%20Bridge%20Architecture%20Specification.pdf

Official Rev 1.2 page (PCI-SIG, member access):
  https://pcisig.com/specifications/conventional/pci_bridge_2_1

> >  Linux therefore places 64-bit non-prefetchable BARs in the
> > 32-bit non-prefetchable bridge window, which requires the bridge to
> > own enough address space below 4 GiB.
> > 
> 
> This sounds a bit like the issue that Dave Jiang reported with recent
> EDK2 on x86 (fedora upgraded).  We don't see it with the older EDK2
> that ships with QEMU. I haven't yet figured out exactly why.
> Arguably whatever they changed is a regression but we don't have good
> enough testing in place to have detected it early enough.
> 
> I'd like some input from PCI / ACPI experts on this. +CC Michael and
> Igor.
> 
> Like the previous patch we'd definitely want some testing around this
> to make sure it doesn't accidentally get broken in future.

The symptoms do look related -- in both cases UEFI's
PciHostBridgeDxe ends up not giving a 32-bit non-prefetchable
window to the CXL host bridge (ACPI0016), so build_crs() in
gpex-acpi.c returns an empty resource set. I haven't dug deep
enough into Dave's case to say whether the underlying trigger is
the same as on RISC-V virt though.

Would appreciate input from Michael / Igor / Dave on whether the
approach in this patch (carve out a dedicated cxl_mmio32 range and
emit a static _CRS for ACPI0016) is a reasonable shape for a
shared fix, or if there's a preferred direction on the PCI/ACPI
side.

Best,
Pei

