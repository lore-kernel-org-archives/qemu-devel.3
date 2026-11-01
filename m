Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6C4606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 03:16:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNM3F-00036X-0O; Sat, 31 Oct 2026 23:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanchi25@mails.ucas.ac.cn>)
 id 1xNM3B-00033p-6k; Sat, 31 Oct 2026 23:16:05 -0400
Received: from smtp81.cstnet.cn ([159.226.251.81] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tanchi25@mails.ucas.ac.cn>)
 id 1xNM37-0000Js-P1; Sat, 31 Oct 2026 23:16:04 -0400
Received: from k3-03 (unknown [159.226.43.8])
 by APP-03 (Coremail) with SMTP id rQCowAAXJ5jlruZqSD4aAA--.22476S2;
 Sun, 01 Nov 2026 11:15:51 +0800 (CST)
From: Tan Chi <tanchi25@mails.ucas.ac.cn>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, pbonzini@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, Tan Chi <tanchi25@mails.ucas.ac.cn>
Subject: [PATCH 0/5] hw/riscv: Fix minimal RISC-V system builds
Date: Sun,  1 Nov 2026 11:15:42 +0800
Message-ID: <20261101031547.125591-1-tanchi25@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAAXJ5jlruZqSD4aAA--.22476S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFWUtF1kArW7Aw1DWFyDZFb_yoW8Cw13pF
 W3WFZ8Zrn5Gr9IgasIyw4kGr15JFs3C3y5Ja17Jr1rJws0vrWFyrnrK3WrJry7AFy8Jr1Y
 9Fy8KFn8uF1UZw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUPF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
 6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
 4UJVWxJr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
 64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
 1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAq
 YI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4
 AK67AK6r48MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8Zw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
 0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUnYFA
 DUUUU
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

While testing minimal RISC-V KVM builds following feedback on my MSI
address translation patch, I encountered several build dependency
issues hidden by the default device configurations.

The failures can be reproduced on a RISC-V Linux host with the
following device configuration:

    configs/devices/riscv64-softmmu/matrix-sifive-e.mak:
    CONFIG_SIFIVE_E=y

and configure options:

    ../configure \
        --target-list=riscv64-softmmu \
        --enable-kvm \
        --without-default-devices \
        --with-devices-riscv64=matrix-sifive-e

Without these fixes, the build fails to link with undefined references
to APLIC, GPEX, platform bus, and RISC-V NUMA helpers. These dependencies
are normally hidden by the default device configurations.

The first four patches fix these issues by making AIA and device
helpers conditional, moving platform bus FDT creation to the machines
that use it, and passing socket topology directly to KVM AIA.

The fifth patch fixes a separate missing SSI dependency found when
building a minimal RV32 OpenTitan configuration.

The affected minimal configurations and default-device RV32/RV64
builds were tested.

Tan Chi (5):
  hw/riscv: Build AIA glue only with APLIC and IMSIC
  hw/riscv: Build device-common only for its users
  hw/riscv: Move platform bus FDT creation to machine code
  hw/riscv: Pass socket topology to KVM AIA
  hw/riscv: Select SSI for IBEX

 hw/riscv/Kconfig               |  6 ++++++
 hw/riscv/aia.c                 | 11 -----------
 hw/riscv/aia.h                 | 17 ++++++++++++++++-
 hw/riscv/fdt-common.c          | 13 ++-----------
 hw/riscv/meson.build           |  5 +++--
 hw/riscv/server_platform_ref.c |  9 +++++++--
 hw/riscv/virt.c                | 21 ++++++++++++++++++---
 include/hw/riscv/fdt-common.h  |  3 +--
 target/riscv/kvm/kvm-cpu.c     | 10 +++++-----
 target/riscv/kvm/kvm-stub.c    |  3 ++-
 target/riscv/kvm/kvm_riscv.h   |  5 ++++-
 11 files changed, 64 insertions(+), 39 deletions(-)

-- 
2.53.0


