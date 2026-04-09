Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EAE4E98FD0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 06:42:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAj4V-0007tf-5O; Thu, 09 Apr 2026 02:40:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangruikang@iscas.ac.cn>)
 id 1wAj4N-0007qr-P9; Thu, 09 Apr 2026 02:40:52 -0400
Received: from smtp81.cstnet.cn ([159.226.251.81] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wangruikang@iscas.ac.cn>)
 id 1wAj4H-0004PV-FD; Thu, 09 Apr 2026 02:40:50 -0400
Received: from [127.0.0.2] (unknown [36.110.52.2])
 by APP-03 (Coremail) with SMTP id rQCowABnht3aSddpeI91DQ--.34096S6;
 Thu, 09 Apr 2026 14:40:27 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Date: Thu, 09 Apr 2026 14:40:14 +0800
Subject: [PATCH 4/5] hw/or1k: Use hex unit addresses in FDT CPU nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-fix-unit-address-v1-4-946840930af2@iscas.ac.cn>
References: <20260409-fix-unit-address-v1-0-946840930af2@iscas.ac.cn>
In-Reply-To: <20260409-fix-unit-address-v1-0-946840930af2@iscas.ac.cn>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>, qemu-arm@nongnu.org, 
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paul Burton <paulburton@kernel.org>, 
 Aleksandar Rikalo <arikalo@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Jia Liu <proljc@gmail.com>, Stafford Horne <shorne@gmail.com>, 
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-riscv@nongnu.org, 
 Vivian Wang <wangruikang@iscas.ac.cn>
X-Mailer: b4 0.15.1
X-CM-TRANSID: rQCowABnht3aSddpeI91DQ--.34096S6
X-Coremail-Antispam: 1UD129KBjvJXoW7KFyUXF1fZr4UKF1rJr48tFb_yoW8Wr4Dpa
 97Aa4UtryxtrW7Ga9avF1UC3WrtrnxXr47WFZ3uw48Arn8Xry7WF1Iy393tryUXF95tF4a
 qFZ3GFy0qw1vgrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUma14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
 kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
 z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
 4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE
 3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2I
 x0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8
 JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2
 ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
 z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
 AF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
 IxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
 4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsG
 vfC2KfnxnUUI43ZEXa7sREBOJ5UUUUU==
X-Originating-IP: [36.110.52.2]
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/
Received-SPF: pass client-ip=159.226.251.81;
 envelope-from=wangruikang@iscas.ac.cn; helo=cstnet.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

These unit addresses should have been in hex, not decimal, as per de
facto convention [1]. Fix them.

Link: https://lore.kernel.org/devicetree-spec/CAL_JsqJFv3+UJ-bjLGk0i7Wc+spsowCrqQZ_s3P4gN8r1W-Q-w@mail.gmail.com/ # [1]
Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
---
 hw/or1k/or1k-sim.c | 2 +-
 hw/or1k/virt.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/or1k/or1k-sim.c b/hw/or1k/or1k-sim.c
index f1b1f63274..b851e48c16 100644
--- a/hw/or1k/or1k-sim.c
+++ b/hw/or1k/or1k-sim.c
@@ -138,7 +138,7 @@ static void openrisc_create_fdt(Or1ksimState *state,
     qemu_fdt_setprop_cell(fdt, "/cpus", "#address-cells", 0x1);
 
     for (cpu = 0; cpu < num_cpus; cpu++) {
-        nodename = g_strdup_printf("/cpus/cpu@%d", cpu);
+        nodename = g_strdup_printf("/cpus/cpu@%x", (unsigned)cpu);
         qemu_fdt_add_subnode(fdt, nodename);
         qemu_fdt_setprop_string(fdt, nodename, "compatible",
                                 "opencores,or1200-rtlsvn481");
diff --git a/hw/or1k/virt.c b/hw/or1k/virt.c
index 39f54058ab..ac644f128e 100644
--- a/hw/or1k/virt.c
+++ b/hw/or1k/virt.c
@@ -162,7 +162,7 @@ static void openrisc_create_fdt(OR1KVirtState *state,
     qemu_fdt_setprop_cell(fdt, "/cpus", "#address-cells", 0x1);
 
     for (cpu = 0; cpu < num_cpus; cpu++) {
-        nodename = g_strdup_printf("/cpus/cpu@%d", cpu);
+        nodename = g_strdup_printf("/cpus/cpu@%x", (unsigned)cpu);
         qemu_fdt_add_subnode(fdt, nodename);
         qemu_fdt_setprop_string(fdt, nodename, "compatible",
                                 "opencores,or1200-rtlsvn481");

-- 
2.53.0


