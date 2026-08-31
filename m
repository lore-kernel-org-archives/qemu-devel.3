Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65FC9C61DE2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 06:38:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0vfH-0004WX-IS; Mon, 31 Aug 2026 02:38:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1x0vfF-0004WC-JK; Mon, 31 Aug 2026 02:38:41 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1x0vfD-0003uy-V6; Mon, 31 Aug 2026 02:38:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788158320; x=1819694320;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fzD85mNTmOhXLNv5Q6BGfESrnPdcRp0mrvjC7CGcgYc=;
 b=dKD+f5rRpg7XmuQ2s5DUaE04kgRmyLpVEKQSTUC36BWCQqKdnefXQGiM
 pBJZd9cfNdJxPYUG9r5cJNf5UJvQRCvNtzxPIsIqyKDJoT649C2/4xd6E
 1fp/+lxyrBe/WcK++3abjTR3T5puvL/N1wzjR3Usr8gEBWwRQEjZltp0L
 zlp2fR3ShvXSRn+0SbW3HWFwVlBgCXIAWZV8TYAUc5ZnNMi4uv4kZyQBr
 4ydqXfXSf2oeSfnUO2M6TaOx8/2r3KIOfUAO7WSSkOEWUeOIRxaG7g97Q
 7lhFGxKtadJ/JdUT8eClUeQHMmm/q5ExhPK66HirpZlrKQ3EUwtWc2PQx w==;
X-CSE-ConnectionGUID: EWPVKKknRbe9WtQUrM/C4Q==
X-CSE-MsgGUID: GJ02F//JSYqz629FbBrl9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="88679799"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="88679799"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2026 23:38:37 -0700
X-CSE-ConnectionGUID: SbHStBUYRdS4kFerkD7cDw==
X-CSE-MsgGUID: PlMtVdZJQBC2oPntlw5Hdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="292212170"
Received: from junjie-desk-dev.bj.intel.com (HELO
 junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2026 23:38:32 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, mst@redhat.com,
 imammedo@redhat.com, sunilvl@ventanamicro.com, sunilvl@oss.qualcomm.com,
 jic23@kernel.org, pbonzini@redhat.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, anisinha@redhat.com, dave.jiang@intel.com,
 alison.schofield@intel.com, guoren@kernel.org, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v4 6/6] tests/qtest: Update RISC-V CXL ACPI golden master
 binaries
Date: Mon, 31 Aug 2026 14:38:24 +0800
Message-ID: <20260831063826.409086-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828151317.815-7-cp0613@linux.alibaba.com>
References: <20260828151317.815-7-cp0613@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Hi Chen Pei,

On Fri, 28 Aug 2026 23:13:05 +0800, Chen Pei wrote:
>         QWordMemory (... 0x400100000 .. 0x40020FFFF ...) // 64-bit MMIO

This one fails for me on d2e570cc0f with the in-tree
pc-bios/edk2-riscv-code.fd (edk2-stable202408.01):

  not ok /riscv64/acpi/virt/cxl

Regenerated with TEST_ACPI_REBUILD_AML=y, the file differs from the
posted one only in the length of that window, 0x10000 here against
your 0x110000, plus the matching shift of PCI0's second 64-bit range.
The 64 KiB is the root port's own BAR0 -- this firmware degrades the
Type3's 64-bit BARs into the root port's 32-bit window. The extra
1 MiB in your file is one bridge prefetchable window, which fits the
edk2-stable202602 you mentioned on v2: that release carries f6489621
("PciBusDxe: Degrade MEM64 to PMEM64 when bridge lacks MEM64"),
reverted again in March (defbd14).

A golden carrying the firmware's allocation is the same situation as
the q35 CXL golden with SeaBIOS, it just has to come from the blob the
test boots. Regenerated here it is also 6331 bytes, sha1
20608434d5b8c7e06d24a59e3a366cb23d1b0238. CEDT.cxl matches.
Re-running this on v5 is no trouble.

Many thanks,
Junjie

