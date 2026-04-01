Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A65FC107637D
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 13:57:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7w3d-00032p-4X; Wed, 01 Apr 2026 09:56:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebasjosue84@gmail.com>)
 id 1w7oJj-0001PD-Jg
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 01:40:39 -0400
Received: from mail-vk1-xa2d.google.com ([2607:f8b0:4864:20::a2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sebasjosue84@gmail.com>)
 id 1w7oJh-0003rr-PG
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 01:40:39 -0400
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-56b7043c97eso2549643e0c.1
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 22:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775022036; x=1775626836; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yrZz+fw3nJqPlQASaoEkdwkEzy9mvjXJzLjZF79lJHk=;
 b=SYW2nuKqBl18GsScJBJbKbuuSEN5WlATvwRPmChJ8MACXySQNFbQbJOZwA/ck6IxgN
 4pOLN8nY11JoogWImjzwIWlZjGujMDTOqXIs0/Nf0dhvrX30PDE92a6M6BofCvyJ5Fps
 E8zIS+LI3+Y/BDdozlKKuliGxFGHAvwaCYM4Axd7pb/dv6BRFFr7DFsCc+ceiUTlf+lN
 X9SeQ8RGJ6IiLiAaiJ3QiFBCUdnwxSL0TgqifHttYumbJ3qIGTlavJy3YkVOEMWUqGKL
 hJ3EMu/GjXRPE+ZzzSc/wwNjGlE7FLGP6UL8QyiR95hF5NnIUIVL/1MywkD0wSN3mAcn
 TSTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775022036; x=1775626836;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yrZz+fw3nJqPlQASaoEkdwkEzy9mvjXJzLjZF79lJHk=;
 b=MHP1I49opaWsu7MvW+I6ey7GkA9z3uNTM91ewPKR7v3j3M2klcdMiBtXwVTQVAegnG
 psfabmCXTJcpoAaWyq+jvU9z+a6B8Gd0io9A1wdE8pzPMbpssbsidQIjR8bd8vYYOJpf
 wd2E4PivCghO6GLBiuCvGDLSUm67VuAobcAzipzrIp38PPxyYZRlFrgu4Bd0TlCWExVs
 laaGHO+tDkfjbD5eRGVRBnPmDzGQe6NwpuWWlcfCzNjMrllvNVsSPoApUDtHygwLBvWX
 gThuFYDeDz4RVgeV3lPwCHY1B3bUNrr80WcYUUqjK6pla+VoNskwrUqqXAAjDKT2kH+E
 avNw==
X-Gm-Message-State: AOJu0YxoExFzs/fJ28I9YJjhMWXQNI7ZQ7AQwyofc1fgKI89E8VKTmCD
 F8WCfYI9Js36dQ0NKpiVFlE6udPztrkLbg+fE0ePE9mfcYxVIL92S10zrmRu4HFOfUs90Q==
X-Gm-Gg: ATEYQzwgdXShSzanwciFiiSSxfAegdXcXxZcLUvKmAh/XYYrEoAfSUXC57PnIsst8eO
 TU+Ccx149SP3Gjme5SAwzHjI649bpI83L/z1VmFBa7JMP1bxz6+WPlGS/Ju5+7xCVkcbB4PQktG
 XdZxPelQsrQa1pwrNzjL4jCVN7yPZQxZajqw29qYks70W8jtmFKj3vHmOOlbvVlDSV9dViua9Px
 EMujMFMOpSNZKGfZ2dy63MMmxk73NSlxm1LouR/9DP39wKFLROikDATNaP3//c1OBY3ZsGRzS2T
 KV3zmZryCW0PZlRM0q9KyVxrRBZ6Yqvw5RCexydfTzc5Hob/h0Lf97uhlBPXtWFGnPvYc/okEiV
 Ssi2DGrkcB+UrJrrUp8XmApYo0Dejl0NGdBgdwHU5UEhWH7d0oXEklCDCD79fxrEmcQJuboY1vu
 ucjRfARNexk4zOLSUj4T9fvVlzmwfw717/Sw==
X-Received: by 2002:a05:6122:221d:b0:56c:d77c:ff83 with SMTP id
 71dfb90a1353d-56d8a86e495mr976084e0c.5.1775022035769; 
 Tue, 31 Mar 2026 22:40:35 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac6:d6d9:aa::11:1a6])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-56d58a7ba96sm14817891e0c.17.2026.03.31.22.40.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 22:40:35 -0700 (PDT)
From: =?UTF-8?q?Sebasti=C3=A1n=20Alba=20Vives?= <sebasjosue84@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, palmer@dabbelt.com,
 berrange@redhat.com,
 =?UTF-8?q?Sebasti=C3=A1n=20Alba=20Vives?= <sebasjosue84@gmail.com>
Subject: [PATCH 1/2] target/riscv: fix stale ptshift and base on page walk
 restart
Date: Tue, 31 Mar 2026 23:38:52 -0600
Message-ID: <20260401053853.10473-1-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2d;
 envelope-from=sebasjosue84@gmail.com; helo=mail-vk1-xa2d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 01 Apr 2026 09:56:18 -0400
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

When the atomic compare-and-swap for updating A/D bits in the page
table entry fails due to a concurrent PTE modification by another
vCPU, get_physical_address() jumps to the 'restart' label to re-walk
the page table from the root.

However, neither 'ptshift' nor 'base' are re-initialized before the
restart. After the walk completes, ptshift has been decremented to
its final value and base has been overwritten with an inner PTE PPN.
On goto restart, the for loop resets i=0 but ptshift and base remain
stale, causing the restarted walk to compute incorrect PTE addresses.

In an SMP guest with MTTCG and Svadu active, this can result in
incorrect physical address mappings or guest crashes.

Fix by saving the root base address and re-initializing both ptshift
and base on each restart.

Fixes: 0c3e702aca ("RISC-V CPU Helpers")
Signed-off-by: Sebastián Alba Vives <sebasjosue84@gmail.com>
---
 target/riscv/cpu_helper.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index dd6c861..22bab45 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1316,12 +1316,15 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
         adue = adue && (env->henvcfg & HENVCFG_ADUE);
     }
 
-    int ptshift = (levels - 1) * ptidxbits;
+    int ptshift;
     target_ulong pte;
     hwaddr pte_addr;
+    const hwaddr base_root = base;
     int i;
 
  restart:
+    ptshift = (levels - 1) * ptidxbits;
+    base = base_root;
     for (i = 0; i < levels; i++, ptshift -= ptidxbits) {
         target_ulong idx;
         if (i == 0) {
-- 
2.43.0


