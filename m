Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD0CC5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 10:27:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh5XD-0007Le-RC; Mon, 04 Mar 2024 05:27:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>)
 id 1rh5X7-0007Kv-9b; Mon, 04 Mar 2024 05:26:59 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>)
 id 1rh5X4-00019m-1L; Mon, 04 Mar 2024 05:26:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709548014; x=1741084014;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=RjqI07vbLQ0IUKCg22TtRZDI1v3stVkgQcLQM8Pd6Tc=;
 b=jt53X6TfnOTyY6bQ0ziH9HQFl0g4PETq+DDq2qArFxbhQLMZjp0kFeGh
 POXYwlMw/1ZFj9HR/NiVE58LgoFfLHY9WLo7kDYf+YsmKDTAGXLYMtnXW
 WWt9znuCYYMmWezdHZtufzl9cAm7euGFoBXvyfkbtPrTykcGiKJ5quTqT
 zplQO+fTSAaxYLsPSGJI6kt3lWtL1RtmUx/BX7N6OV8XWMUWDJor2w9bv
 lgIaWS7MCOpoQx2CtOC5dTymrmeASaKkhuSJMpECYsKu6qJypVOpRbNnG
 O3Nw01g++Cvr9F6ie+n01ivbYxr6K8Jgl8BBOkXOI8TN3ZL1ojutc5RhE g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="4194807"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="4194807"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2024 02:26:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; d="scan'208";a="13509284"
Received: from wufei-optiplex-7090.sh.intel.com ([10.239.158.51])
 by fmviesa004.fm.intel.com with ESMTP; 04 Mar 2024 02:26:36 -0800
From: Fei Wu <fei2.wu@intel.com>
To: pbonzini@redhat.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 andrei.warkentin@intel.com, shaolin.xie@alibaba-inc.com, ved@rivosinc.com,
 sunilvl@ventanamicro.com, haibo1.xu@intel.com, evan.chai@intel.com,
 yin.wang@intel.com, tech-server-platform@lists.riscv.org,
 tech-server-soc@lists.riscv.org
Cc: Fei Wu <fei2.wu@intel.com>
Subject: [RFC 0/2] Add RISC-V Server Platform Reference Board
Date: Mon,  4 Mar 2024 18:25:38 +0800
Message-Id: <20240304102540.2789225-1-fei2.wu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15; envelope-from=fei2.wu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The RISC-V Server Platform specification[1] defines a standardized set
of hardware and software capabilities, that portable system software,
such as OS and hypervisors can rely on being present in a RISC-V server
platform. This patchset provides a RISC-V Server Platform (RVSP)
reference implementation on qemu which is in compliance with the spec
as faithful as possible.

The reference board can be running with tag edk2-stable202308 in
upstream edk2 repo[2].

The qemu command line used:

$QEMU -nographic -m 4G -smp 2 \
    -machine rvsp-ref,pflash0=pflash0,pflash1=pflash1 \
    -blockdev node-name=pflash0,driver=file,read-only=on,filename=RISCV_VIRT_CODE.fd \
    -blockdev node-name=pflash1,driver=file,filename=RISCV_VIRT_VARS.fd \
    -bios fw_dynamic.bin \
    -drive file=$BRS_IMG,if=ide,format=raw

Since there is no ACPI table generated in this new machine type, a
corresponding EDK-II platform (WIP) is needed to provide related ACPI
tables.

For testing purposes only, we used a workaround to generate the ACPI
tables in Qemu with a dedicated downstream patch.

[1] https://github.com/riscv-non-isa/riscv-server-platform
[2] https://github.com/tianocore/edk2.git

Fei Wu (2):
  hw/riscv: Add server platform reference machine
  target/riscv: Add server platform reference cpu

 configs/devices/riscv64-softmmu/default.mak |    1 +
 hw/riscv/Kconfig                            |   13 +
 hw/riscv/meson.build                        |    1 +
 hw/riscv/server_platform_ref.c              | 1248 +++++++++++++++++++
 target/riscv/cpu-qom.h                      |    1 +
 target/riscv/cpu.c                          |   62 +
 6 files changed, 1326 insertions(+)
 create mode 100644 hw/riscv/server_platform_ref.c

-- 
2.34.1


