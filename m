Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13AC1FF886F
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2026 18:04:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJb9t-0003mt-Eq; Sun, 03 May 2026 14:03:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamedaymanworkspace@gmail.com>)
 id 1wJb9s-0003mZ-5O
 for qemu-devel@nongnu.org; Sun, 03 May 2026 14:03:12 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mohamedaymanworkspace@gmail.com>)
 id 1wJb9q-0002xD-R1
 for qemu-devel@nongnu.org; Sun, 03 May 2026 14:03:11 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-44e1860558fso155700f8f.0
 for <qemu-devel@nongnu.org>; Sun, 03 May 2026 11:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777831388; x=1778436188; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yZaXjOogZAqKnBh2asvWhnyIUphHwzyu6TcOV3QYtYA=;
 b=UC9OG2hvb6MbO+HnfyVc/UoVyj9aqLPnIqeiFP3AtVdS0vQvigYQ9zrgVTzwDHLD83
 8ilPw3goHwVYnO6cB6tBoZTyUIrHUSsfRGjdr8ZZwb/MfUfA0MycsAl/2gkT9YhNdH7c
 Xo/QuokBLAP6jWInm4pubj8v/On78m7YYse5Zo/tiT8mhOvFo4hNlTY+CUy4JjSOYBhK
 +Vt+8xG1EckEE6Aku4mxe9U1tRvmTBaKdjhZQUeN+HIkSv8bBLCAMUjtNOzjEpDbE0ZF
 doaMbfrblU8kzkPretsbsCYRSBmroqGVXHUQJhwe/VClqiBXiePRa8VbDzku4hH5kMa7
 IaSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777831388; x=1778436188;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yZaXjOogZAqKnBh2asvWhnyIUphHwzyu6TcOV3QYtYA=;
 b=flG5zaiSx20QJlr8V3t3UUaV5aySI9+3UelZW+9I6htzRd4kLSFCz2pQNL1ctQ6XpJ
 1355QJbAHX3PhjnGYbsgxqc9O1y6d7IrChCzfVQ+genwyz2vpO06nlWLDbMKHAqUQZH3
 gz06N8g8vkVPtDlBIQRUuY0WhzsXT2RGycOpQ5FOjoewzfQwNOdqmCvYiR5nOX08cxo/
 uo4mGLyPwB+jMvNz+uiynUBeU9s6eXwLp4dIJUYfayQWVCtvXhjU8LI3K7mN9kMbmkDF
 x+CAzjPRqRfsO7FHqO3QZTZi0UAbSoowWBhSAS8HWDq51QkDGGw7GFrlm+vMX9EdtoRq
 sgiA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+aS3NS/3hMlH0kfEG/DFl5sbcG7QF2xTdo/3pKt+wyRHXg1zXxhf7SUyI8rmX2XtaA1tvFhw67p8Vj@nongnu.org
X-Gm-Message-State: AOJu0YxIT8tR35jKjzKrdw8bhAhKhpWk+1U3ytqZdx0XFc6guIFF7h7n
 GWHZp/XTj9hb5Z2K7zu3SO21jBInbO49eeWt8/GN1vsTVsImhFSdGzGt
X-Gm-Gg: AeBDieu38d/K0mdMxcfQVSwqEIBmLxiuX3W+vtrm1O68EtyurwCBUQ2igGAy/j8N9k1
 besfNs0E3WPuTE/oUO1DBsOz1Si49D8BAdzOwzIa/fhEZxphqT9KpiN8x0UTG25HxeH2KQUYvvb
 7jNIEpSuhOunG/iSjS4KT1st16gIeclRp0PH0xjEQC4G9RGJM5O80+KpytMNW8y5Z7ZiyG/iL31
 4LRckEyo35BJi1leo469O/+S/l0O3+u32RDmnCCQwfBgpT49htFJOPsxQcO9rxE0Zh8SGZ04W0/
 3BXzir8JHiHo+an1gWaU1P0PjlEciQJG0/7dM7zS3gdRCi8/vSGgQkzuvMsZoO7FHXOZq6Wxw4g
 HlHTZ7qomMJiyTbl7OJy2lCI0z9Bp/POfm+cZC+gDJYpt+f7kxysNpE4G+7/JRvQXF2P8UFck2W
 Q7KqeIKWoOwlNxHBwDbJQVLjY4WXzBEDORQA6gcpL7NCB0rSMe9WA6iB6mF3JS0GTXlbNiFWjF3
 HxbOqeY3KM=
X-Received: by 2002:a05:6000:1a89:b0:446:96b1:f51 with SMTP id
 ffacd0b85a97d-44bb52abc94mr10839783f8f.22.1777831387662; 
 Sun, 03 May 2026 11:03:07 -0700 (PDT)
Received: from ST.. ([196.221.137.242]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-44a8ef52854sm20043078f8f.12.2026.05.03.11.03.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 May 2026 11:03:07 -0700 (PDT)
From: Mohamed Ayman <mohamedaymanworkspace@gmail.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 qemu-devel@nongnu.org (open list:All patches CC here)
Cc: Mohamed Ayman <mohamedaymanworkspace@gmail.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH] riscv: virt: avoid RISCVCPU copy in PMU FDT setup
Date: Sun,  3 May 2026 21:02:52 +0300
Message-Id: <20260503180252.1122776-1-mohamedaymanworkspace@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=mohamedaymanworkspace@gmail.com; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Use a pointer to the hart instead of copying RISCVCPU when
passing pmu_avail_ctrs to riscv_pmu_generate_fdt_node().

Signed-off-by: Mohamed Ayman <mohamedaymanworkspace@gmail.com>
---
 hw/riscv/virt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index a1c323e66d..085971eedc 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -722,11 +722,11 @@ static void create_fdt_pmu(RISCVVirtState *s)
 {
     g_autofree char *pmu_name = g_strdup_printf("/pmu");
     MachineState *ms = MACHINE(s);
-    RISCVCPU hart = s->soc[0].harts[0];
+    RISCVCPU *hart = &s->soc[0].harts[0];
 
     qemu_fdt_add_subnode(ms->fdt, pmu_name);
     qemu_fdt_setprop_string(ms->fdt, pmu_name, "compatible", "riscv,pmu");
-    riscv_pmu_generate_fdt_node(ms->fdt, hart.pmu_avail_ctrs, pmu_name);
+    riscv_pmu_generate_fdt_node(ms->fdt, hart->pmu_avail_ctrs, pmu_name);
 }
 
 static void create_fdt_sockets(RISCVVirtState *s,
-- 
2.34.1


