Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B526C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 17:57:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6XP6-0007Z6-PZ; Tue, 15 Sep 2026 13:57:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1x6XOu-0007Wg-8H; Tue, 15 Sep 2026 13:57:00 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1x6XOs-0004Fr-8M; Tue, 15 Sep 2026 13:56:59 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D837440AF7;
 Tue, 15 Sep 2026 17:56:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC321F000FF;
 Tue, 15 Sep 2026 17:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789495016;
 bh=XseWBq8izn0Nrmc0zn5blFXPCwaM4UJNp8e2A5vqhqc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=B6AEoLYwWfv/YjRFBn2qURpPFo3w3W+OStjkg9O1CWS1UA/0IQ+pT+wFdsVv0k/6T
 FQZ5SPAseZhnW3ZWVbtjKeHnIWOffVIjRQ2/nGv9cavrIaC/zUly45ixakynQuWq2P
 xHq/vWRr6bIw/s2Pp+wRnAS+u31Aawq/ku69hCJ8lY4cCBapotlPP0JUZrqncA8pGk
 v9EOhqV5PGu2XzS/kHMnHIGT7yaJg05tDyvE+l59f2USnNJPo0YsXiR1G3eEVKuhc/
 J3HVr/7dMU2uccy29uQLppCZVznlxih2iCLFJCpTCM1TIOoOadMqImkiB5iSKTcZ7M
 y7VTP2P/qwhgQ==
Date: Tue, 15 Sep 2026 18:56:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, mst@redhat.com,
 imammedo@redhat.com, sunilvl@ventanamicro.com, pbonzini@redhat.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 anisinha@redhat.com, dave.jiang@intel.com, alison.schofield@intel.com,
 junjie.cao@intel.com, guoren@kernel.org, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v6 6/6] tests/qtest: Update RISC-V CXL ACPI golden
 master binaries
Message-ID: <20260915185650.272825f6@jic23-hlaptop>
In-Reply-To: <20260907093735.2753-7-cp0613@linux.alibaba.com>
References: <20260907093735.2753-1-cp0613@linux.alibaba.com>
 <20260907093735.2753-7-cp0613@linux.alibaba.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=jic23@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon,  7 Sep 2026 17:37:33 +0800
Chen Pei <cp0613@linux.alibaba.com> wrote:

> Populate the DSDT.cxl and CEDT.cxl golden master binaries for the
> RISC-V CXL bios-tables test and empty
> bios-tables-test-allowed-diff.h, following the bios-tables-test update
> process.
> 
> The expected AML added by this series is:
> 
> DSDT.cxl:
>   Device (PC0C)        // ACPI0016 CXL host bridge (pxb-cxl, bus 0x0C)
>     Name (_CRS, ResourceTemplate () {
>         DWordMemory (... 0x40400000 .. 0x405FFFFF ...)   // 32-bit MMIO
>         QWordMemory (... 0x400100000 .. 0x40010FFFF ...) // 64-bit MMIO
>         WordBusNumber (... 0x000C .. 0x000D ...)
>     })
>     Method (_OSC, ...)   // PCI host bridge + CXL UUIDs
>   Device (CXLM)        // ACPI0017 CXL memory controller
>     Name (_HID, "ACPI0017")
>     Name (_DEP, Package () { \_SB.PC0C })
>     Method (_STA, ...) / Method (_DSM, ...)
> 
> CEDT.cxl:
>   CHBS : CXL Host Bridge Structure, Register base 0x800000000
>   CFMWS: CXL Fixed Memory Window, base 0x810000000, size 4G
> 
> Reviewed-by: Junjie Cao <junjie.cao@intel.com>
> Tested-by: Junjie Cao <junjie.cao@intel.com>
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

