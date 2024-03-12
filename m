Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97546C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 13:53:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk2ZF-0002KZ-IK; Tue, 12 Mar 2024 09:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>)
 id 1rk2Z6-0002JU-Sr; Tue, 12 Mar 2024 09:53:14 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>)
 id 1rk2Z1-0005hK-O4; Tue, 12 Mar 2024 09:53:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710251587; x=1741787587;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=UTJ/1KarSJsJzZhRUcRQWAkNz/PWZmJh7c4kynJCQ1M=;
 b=mjruuAZy0rks2wQ2k63HX6FDM3oS/zYDSZbPtD6YcpYNsTZeQSR/XLIS
 5r097m1lYR+Xb/UYh4LxQwssXlqZewhw9IbHVKVq4zqnsCHZQiobe9tXE
 Tf53ppIxxJTc3rN/IhipoZyxsj/QsXzT5LlLLFZadYGfE6n2PUZIyomzv
 I2RuzRA+Knldu9oDe6tbfmjBigO/YNoz3iMav/TgeXNqrvlYAy+3Zof1z
 XYnHudUgxCKYHrc0LOVVzlDIf6yZBDYAB4h0Est7FMCV+rlnzn2oX9Okk
 TFPhu7oVLtT04cFOh3Q6N0cbmBBUj/pXLjoWxNeT/WMi1iCTuFpdM5byR Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="4887893"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="4887893"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2024 06:53:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; d="scan'208";a="16148402"
Received: from wufei-optiplex-7090.sh.intel.com ([10.239.158.51])
 by fmviesa004.fm.intel.com with ESMTP; 12 Mar 2024 06:52:51 -0700
From: Fei Wu <fei2.wu@intel.com>
To: pbonzini@redhat.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 andrei.warkentin@intel.com, shaolin.xie@alibaba-inc.com, ved@rivosinc.com,
 sunilvl@ventanamicro.com, haibo1.xu@intel.com, evan.chai@intel.com,
 yin.wang@intel.com, tech-server-platform@lists.riscv.org,
 tech-server-soc@lists.riscv.org, atishp@rivosinc.com,
 ajones@ventanamicro.com, conor@kernel.org,
 heinrich.schuchardt@canonical.com, marcin.juszkiewicz@linaro.org
Cc: Fei Wu <fei2.wu@intel.com>
Subject: [RFC v2 0/2] Add RISC-V Server Platform Reference Board
Date: Tue, 12 Mar 2024 21:52:19 +0800
Message-Id: <20240312135222.3187945-1-fei2.wu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21; envelope-from=fei2.wu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


v2:
- move cpu definition the 1st patch
- replace sifive_test with power reset syscon
- add versioning scheme to fdt
- integrate recent changes in virt.c
  - use g_autofree
  - create_fdt/finalize_fdt
  - riscv_isa_write_fdt
- some cleanups


Fei Wu (2):
  target/riscv: Add server platform reference cpu
  hw/riscv: Add server platform reference machine

 configs/devices/riscv64-softmmu/default.mak |    1 +
 hw/riscv/Kconfig                            |   12 +
 hw/riscv/meson.build                        |    1 +
 hw/riscv/server_platform_ref.c              | 1276 +++++++++++++++++++
 target/riscv/cpu-qom.h                      |    1 +
 target/riscv/cpu.c                          |   61 +
 6 files changed, 1352 insertions(+)
 create mode 100644 hw/riscv/server_platform_ref.c

-- 
2.34.1


