Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1772A606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 03:17:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNM3E-00034o-1S; Sat, 31 Oct 2026 23:16:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanchi25@mails.ucas.ac.cn>)
 id 1xNM3B-00033k-4r; Sat, 31 Oct 2026 23:16:05 -0400
Received: from smtp81.cstnet.cn ([159.226.251.81] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tanchi25@mails.ucas.ac.cn>)
 id 1xNM38-0000Jx-16; Sat, 31 Oct 2026 23:16:04 -0400
Received: from k3-03 (unknown [159.226.43.8])
 by APP-03 (Coremail) with SMTP id rQCowAAXJ5jlruZqSD4aAA--.22476S4;
 Sun, 01 Nov 2026 11:15:54 +0800 (CST)
From: Tan Chi <tanchi25@mails.ucas.ac.cn>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, pbonzini@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, Tan Chi <tanchi25@mails.ucas.ac.cn>
Subject: [PATCH 2/5] hw/riscv: Build device-common only for its users
Date: Sun,  1 Nov 2026 11:15:44 +0800
Message-ID: <20261101031547.125591-3-tanchi25@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261101031547.125591-1-tanchi25@mails.ucas.ac.cn>
References: <20261101031547.125591-1-tanchi25@mails.ucas.ac.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAAXJ5jlruZqSD4aAA--.22476S4
X-Coremail-Antispam: 1UD129KBjvJXoW7KrWfGrWfCF4UtrWrtFy8Grg_yoW8Cw4kpF
 45Kw4YkFyrJF1SvwsFvr1kuFWxJwn3Cw45Ar1F9w1DJFsrA3yUAasIya12vr9rZa4kAF4F
 vFZ5K34rCr45Gw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUHF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
 x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
 Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
 8EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4U
 JwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
 AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1l
 Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErc
 IFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_
 Gr4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
 WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
 7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
 4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
 42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRRrWFUUUUU
X-CM-SenderInfo: pwdquxrlsvqzpdlo2hpxfd2hldfou0/
Received-SPF: pass client-ip=159.226.251.81;
 envelope-from=tanchi25@mails.ucas.ac.cn; helo=cstnet.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

hw/riscv/device-common.c is built unconditionally, although its
helpers are only used by the virt and server reference machines.

In minimal builds without these machines, device-common.c can
reference device implementations that are not built, resulting
in an undefined reference to gpex_set_irq_num().

Introduce CONFIG_RISCV_DEVICE_COMMON and select it from the two
machines that use these helpers. Build device-common.c only
when this option is enabled.

Signed-off-by: Tan Chi <tanchi25@mails.ucas.ac.cn>
---
 hw/riscv/Kconfig     | 5 +++++
 hw/riscv/meson.build | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index fb05031228..27f03b687c 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -7,6 +7,9 @@ config RISCV_NUMA
 config IBEX
     bool
 
+config RISCV_DEVICE_COMMON
+    bool
+
 # RISC-V machines in alphabetical order
 
 config MICROCHIP_PFSOC
@@ -68,6 +71,7 @@ config RISCV_VIRT
     select PLATFORM_BUS
     select ACPI
     select ACPI_PCI
+    select RISCV_DEVICE_COMMON
 
 config RISCV_SERVER_PLATFORM_REF
     bool
@@ -85,6 +89,7 @@ config RISCV_SERVER_PLATFORM_REF
     select RISCV_IOMMU
     select RISCV_NUMA
     select SERIAL_MM
+    select RISCV_DEVICE_COMMON
 
 config SHAKTI_C
     bool
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index 957031c07d..b60108787d 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -2,7 +2,7 @@ riscv_ss = ss.source_set()
 riscv_ss.add(when: ['CONFIG_RISCV_APLIC', 'CONFIG_RISCV_IMSIC'],
              if_true: files('aia.c'))
 riscv_ss.add(files('boot.c'))
-riscv_ss.add(files('device-common.c'))
+riscv_ss.add(when: 'CONFIG_RISCV_DEVICE_COMMON', if_true: files('device-common.c'))
 riscv_ss.add(files('fdt-common.c'))
 riscv_ss.add(when: 'CONFIG_RISCV_NUMA', if_true: files('numa.c'))
 riscv_ss.add(files('riscv_hart.c'))
-- 
2.53.0


