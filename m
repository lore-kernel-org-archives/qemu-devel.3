Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E24E0C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 09:16:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6liw-0001xp-Sh; Wed, 16 Sep 2026 05:14:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1x6liQ-0001HH-DC; Wed, 16 Sep 2026 05:14:07 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1x6liO-00089B-O6; Wed, 16 Sep 2026 05:14:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=TbZb94MuWzbziXvToTjwlOx61+5F1jk2mxBbl666i1Y=; b=nEBnGsVIlEqHNkh
 qLlYlCQhOMXM+o5/z2sXyWJzaZDOpcOyvx9eTHJV3VN6rpO1bCXDfCh3RcjxJazLhB+25JvmW82AY
 eDzmi1j/VPNs0uSa/yDBA47Yx6a+Te+ze459JDG0+HNp+cNg/sz3+F0Cz9sy/6Ogx16S8VZUnhSE+
 3g=;
Date: Wed, 16 Sep 2026 11:19:07 +0200
Subject: [PATCH v4 12/12] hw/riscv: Compile once
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260916-hw-riscv-cpu-int-v4-12-babc367b60f5@rev.ng>
References: <20260916-hw-riscv-cpu-int-v4-0-babc367b60f5@rev.ng>
In-Reply-To: <20260916-hw-riscv-cpu-int-v4-0-babc367b60f5@rev.ng>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, qemu-riscv@nongnu.org, 
 daniel.barboza@oss.qualcomm.com, philmd@oss.qualcomm.com, 
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789550353; l=3555;
 i=anjo@rev.ng; s=20260210; h=from:subject:message-id;
 bh=9j6u0VO1MNm6eSXRDfR+CmzXxXhtVlrF3pwysoMdPag=;
 b=uLv0kr7Bf6QgPKi0S654IAPVe1xY0YN6FEcsO8SGh9/Igjm90s9J3qtThQCUBVRjuvTiq9K0s
 3iRxviG6BXiA7zBJGz91r/QhL1DWFm8AD04GM9EI6B4qGWKsDXgug92
X-Developer-Key: i=anjo@rev.ng; a=ed25519;
 pk=dKsZvj/g3kgDxnV1/SWg8a0YNGSpWtFGNsWIepQYKow=
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 hw/riscv/meson.build | 47 ++++++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index 7aa3c1578d..b53661cf31 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -1,25 +1,26 @@
-riscv_ss = ss.source_set()
-riscv_ss.add(files('aia.c'))
-riscv_ss.add(files('boot.c'))
-riscv_ss.add(files('device-common.c'))
-riscv_ss.add(files('fdt-common.c'))
-riscv_ss.add(when: 'CONFIG_RISCV_NUMA', if_true: files('numa.c'))
-riscv_ss.add(files('riscv_hart.c'))
-riscv_ss.add(when: 'CONFIG_OPENTITAN', if_true: files('opentitan.c'))
-riscv_ss.add(when: 'CONFIG_RISCV_VIRT', if_true: files('virt.c'))
-riscv_ss.add(when: 'CONFIG_SHAKTI_C', if_true: files('shakti_c.c'))
-riscv_ss.add(when: 'CONFIG_SIFIVE_E', if_true: files('sifive_e.c'))
-riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('sifive_u.c'))
-riscv_ss.add(when: 'CONFIG_SPIKE', if_true: files('spike.c'))
-riscv_ss.add(when: 'CONFIG_MICROCHIP_PFSOC', if_true: files('microchip_pfsoc.c'))
-riscv_ss.add(when: 'CONFIG_TENSTORRENT', if_true: files('tt_atlantis.c'))
-riscv_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
-riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files(
+riscv_common_ss = ss.source_set()
+riscv_common_ss.add(files('aia.c'))
+riscv_common_ss.add(files('boot.c'))
+riscv_common_ss.add(files('device-common.c'))
+riscv_common_ss.add(files('fdt-common.c'))
+riscv_common_ss.add(when: 'CONFIG_RISCV_NUMA', if_true: files('numa.c'))
+riscv_common_ss.add(files('riscv_hart.c'))
+riscv_common_ss.add(when: 'CONFIG_OPENTITAN', if_true: files('opentitan.c'))
+riscv_common_ss.add(when: 'CONFIG_RISCV_VIRT', if_true: files('virt.c'))
+riscv_common_ss.add(when: 'CONFIG_SHAKTI_C', if_true: files('shakti_c.c'))
+riscv_common_ss.add(when: 'CONFIG_SIFIVE_E', if_true: files('sifive_e.c'))
+riscv_common_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('sifive_u.c'))
+riscv_common_ss.add(when: 'CONFIG_SPIKE', if_true: files('spike.c'))
+riscv_common_ss.add(when: 'CONFIG_MICROCHIP_PFSOC', if_true: files('microchip_pfsoc.c'))
+riscv_common_ss.add(when: 'CONFIG_TENSTORRENT', if_true: files('tt_atlantis.c'))
+riscv_common_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
+riscv_common_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files(
 	'riscv-iommu.c', 'riscv-iommu-pci.c', 'riscv-iommu-sys.c', 'riscv-iommu-hpm.c'))
-riscv_ss.add(when: 'CONFIG_MICROBLAZE_V', if_true: files('microblaze-v-generic.c'))
-riscv_ss.add(when: 'CONFIG_XIANGSHAN_KUNMINGHU', if_true: files('xiangshan_kmh.c'))
-riscv_ss.add(when: 'CONFIG_RISCV_MIPS_CPS', if_true: files('cps.c'))
-riscv_ss.add(when: 'CONFIG_MIPS_BOSTON_AIA', if_true: files('boston-aia.c'))
-riscv_ss.add(when: 'CONFIG_K230', if_true: files('k230.c'))
+riscv_common_ss.add(when: 'CONFIG_MICROBLAZE_V', if_true: files('microblaze-v-generic.c'))
+riscv_common_ss.add(when: 'CONFIG_XIANGSHAN_KUNMINGHU', if_true: files('xiangshan_kmh.c'))
 
-hw_arch += {'riscv': riscv_ss}
+riscv_common_ss.add(when: 'CONFIG_RISCV_MIPS_CPS', if_true: files('cps.c'))
+riscv_common_ss.add(when: 'CONFIG_MIPS_BOSTON_AIA', if_true: files('boston-aia.c'))
+riscv_common_ss.add(when: 'CONFIG_K230', if_true: files('k230.c'))
+
+hw_common_arch += {'riscv': riscv_common_ss}

-- 
2.52.0


