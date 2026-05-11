Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76DD9CD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 13:42:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMQ42-00007o-7I; Mon, 11 May 2026 08:48:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vulab@iscas.ac.cn>)
 id 1wMQ3t-0008JG-8J; Mon, 11 May 2026 08:48:43 -0400
Received: from smtp81.cstnet.cn ([159.226.251.81] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vulab@iscas.ac.cn>)
 id 1wMQ3q-0001KO-Ak; Mon, 11 May 2026 08:48:40 -0400
Received: from yzs (unknown [183.156.89.125])
 by APP-03 (Coremail) with SMTP id rQCowADny+Id0AFq5RuuEA--.1067S2;
 Mon, 11 May 2026 20:48:29 +0800 (CST)
From: Zishun Yi <vulab@iscas.ac.cn>
To: Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Cc: Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Zishun Yi <vulab@iscas.ac.cn>
Subject: [PATCH v1] target/riscv: Add mseccfg to VMStateDescription
Date: Mon, 11 May 2026 20:48:28 +0800
Message-ID: <20260511124828.3210477-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowADny+Id0AFq5RuuEA--.1067S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFyUKF43CF1xJw43Jr45trb_yoW8WF4fpw
 4DCay3GrWkGrWfWw4fJF18WFW5Kws5G3W2k39rCw4IganxGFWSqF4qkay2vr4ayFyrJw13
 uF1UAry5Cr4kArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
 0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
 jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
 1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r1q
 6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
 0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
 0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
 W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1l
 IxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQZ2fUUU
 UU=
X-Originating-IP: [183.156.89.125]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAYEA2oBvJ9bgwAAsd
Received-SPF: pass client-ip=159.226.251.81; envelope-from=vulab@iscas.ac.cn;
 helo=cstnet.cn
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Currently, the Machine Security Configuration Register (mseccfg) was
missing from the live migration state. This omission causes the register
to be reset to zero on the destination host after migration.

Fixed by adding vmstate_mseccfg subsection

This vulnerability was discovered and reported by SpecHunter, an
AI-driven architecture specification analysis tool.

Link: https://github.com/yizishun/rv-isa-sec/blob/a22e4459cd026ae970791dfbd9cfe5d110fbd46b/output/riscv-isa-manual/pr-1879/qemu.txt#L121
Signed-off-by: Zishun Yi <vulab@iscas.ac.cn>
---
 target/riscv/machine.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 09c032a87914..6776e7bf5a11 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -423,6 +423,25 @@ static const VMStateDescription vmstate_sstc = {
     }
 };
 
+static bool mseccfg_needed(void *opaque)
+{
+    RISCVCPU *cpu = opaque;
+
+    return cpu->cfg.ext_smepmp || cpu->cfg.ext_zkr
+        || cpu->cfg.ext_smmpm || cpu->cfg.ext_zicfilp;
+}
+
+static const VMStateDescription vmstate_mseccfg = {
+    .name = "cpu/mseccfg",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = mseccfg_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINTTL(env.mseccfg, RISCVCPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 const VMStateDescription vmstate_riscv_cpu = {
     .name = "cpu",
     .version_id = 11,
@@ -499,6 +518,7 @@ const VMStateDescription vmstate_riscv_cpu = {
         &vmstate_ssp,
         &vmstate_ctr,
         &vmstate_sstc,
+        &vmstate_mseccfg,
         NULL
     }
 };
-- 
2.51.2


