Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1EC606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 17:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TCil3oGC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLOqi-00013y-2E; Mon, 26 Oct 2026 13:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1xLOqX-00010F-Hb; Mon, 26 Oct 2026 13:51:00 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1xLOqT-0002pv-Dl; Mon, 26 Oct 2026 13:50:56 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D52E743F3D;
 Mon, 26 Oct 2026 17:50:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A081F031E0;
 Mon, 26 Oct 2026 17:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793037044;
 bh=OsUzAaztv8+DNd0+U8o1DRpV8XN2OhUvK06yw9kM6LY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=TCil3oGCLGCpJUmGBB+DfM80IxyTNjGOHNObNoNnMwYPxTTEjaE39sKe4L9Bdy3Z/
 3QNChrRReE+QHR8dEFUPN15j6rshCR49XPEWghv7Y9LK43Yg36Gj+tPi+V5k0ypk0G
 +PT7N8UswZkamQCRDh+7n3tgIJLqsTtp9nxtYrXIBC2fvnzXTfE8TdGWSAkbYkWG8/
 wfhbtucukVjlvbeuL3ghOD4tLqdqRx4wLLmJj2rqPhpT2E9cwNqwbGgzMn2g5CoyTj
 DPzLnP62Fy0K5MMXSu9QdosJhge46Hn7/vUedwGsvwJHshKy2A5BJ+UOV4Bw576G1D
 5xMgwG4YF2GBQ==
From: Drew Fustini <fustini@kernel.org>
Date: Mon, 26 Oct 2026 10:47:25 -0700
Subject: [PATCH v6 5/6] hw/riscv: add CBQRI to Kconfig and build if enabled
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-riscv-ssqosid-cbqri-v6-5-1a367a35cd0e@kernel.org>
References: <20261026-riscv-ssqosid-cbqri-v6-0-1a367a35cd0e@kernel.org>
In-Reply-To: <20261026-riscv-ssqosid-cbqri-v6-0-1a367a35cd0e@kernel.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Sunil V L <sunilvl@oss.qualcomm.com>, 
 Anup Patel <anup.patel@oss.qualcomm.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Nicolas Pitre <npitre@baylibre.com>, 
 =?utf-8?q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
 Atish Patra <atish.patra@linux.dev>, 
 =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <radim.krcmar@oss.qualcomm.com>, 
 yunhui cui <cuiyunhui@bytedance.com>, Chen Pei <cp0613@linux.alibaba.com>, 
 guo.wenjia23@zte.com.cn, liu.qingtao2@zte.com.cn, 
 Drew Fustini <fustini@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1579; i=fustini@kernel.org;
 h=from:subject:message-id; bh=yHxzWB225Q8PzqLO26MdPGwK3INMpfNuJTcsSLODWkk=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWTdn/Sp4pq0hrXtoYVax2ct7jmyj7/a7YBX9Uq7XP32w
 1JTm1J6OkpZGMS4GGTFFFk2fci7sMQr9OuC+S+2wcxhZQIZwsDFKQATsZ/IyLBxU3+zdkxRmmOF
 693rSipsm77+yWJOdE5VNXOdEfBby4CRYaEh14pdR5XWW+3K5dng/ePAwWdCqqyNFbfvTlJ9WxX
 +igUA
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=fustini@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Nicolas Pitre <npitre@baylibre.com>

Add boolean property for CBQRI and imply it should be enabled for the
RISC-V virt machine. Build the CBQRI controllers when RISC-V CBQRI is
enabled.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 hw/riscv/Kconfig     | 4 ++++
 hw/riscv/meson.build | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index d89fdfcc8671..98bdebb4b814 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -1,3 +1,6 @@
+config RISCV_CBQRI
+    bool
+
 config RISCV_IOMMU
     bool
 
@@ -68,6 +71,7 @@ config RISCV_VIRT
     select PLATFORM_BUS
     select ACPI
     select ACPI_PCI
+    imply RISCV_CBQRI
 
 config RISCV_SERVER_PLATFORM_REF
     bool
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index 6bdabb954473..c7952d67755e 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -19,6 +19,8 @@ riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files(
 	'riscv-iommu.c', 'riscv-iommu-pci.c', 'riscv-iommu-sys.c', 'riscv-iommu-hpm.c'))
 riscv_ss.add(when: 'CONFIG_MICROBLAZE_V', if_true: files('microblaze-v-generic.c'))
 riscv_ss.add(when: 'CONFIG_XIANGSHAN_KUNMINGHU', if_true: files('xiangshan_kmh.c'))
+riscv_ss.add(when: 'CONFIG_RISCV_CBQRI', if_true: files('cbqri_capacity.c', 'cbqri_bandwidth.c'))
+
 riscv_ss.add(when: 'CONFIG_RISCV_MIPS_CPS', if_true: files('cps.c'))
 riscv_ss.add(when: 'CONFIG_MIPS_BOSTON_AIA', if_true: files('boston-aia.c'))
 riscv_ss.add(when: 'CONFIG_K230', if_true: files('k230.c'))

-- 
2.43.0


