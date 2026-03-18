Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7192FEDA17
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 01:38:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2frc-0000s1-HB; Tue, 17 Mar 2026 21:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1w2frX-0000pe-9p
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 21:38:19 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1w2frV-0001tE-Lv
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 21:38:19 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-35a1230c60eso3299345a91.3
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 18:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1773797896; x=1774402696; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hAi/I+xZNYQnUCvv34er/GB0MqxllKg2X616+n0zgEo=;
 b=GxpsitzF/6XL7narFvGhDZl9Ob+KwRNiFtcj/MHsc3lbmHHA2DNmNa9eLGxIbiOR9C
 Bhxm+lg+1YD/VAucilkKuUDIjispuh1nOck/+/WEd9Qtm28UEyTvHpnvAsgB7tY/8ZX5
 nmGT12CUr6LYRyKwMwdGIqcW63Ej17vc14ECdPOT6Op/gIeJxrlmdKTg/foNtdTUv8bd
 /J9GmV+le7pbpD/aonAIo92QInMIlH6phpURya8GfAeHiUOEvVCSu+FqG7eXAkR/FSYj
 cDCjNw0hY1u30AnIriuEGwNtS93+o+JeGAcJ0NJTVG307AqioYElABMJsWS3ZIprHAJU
 pScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773797896; x=1774402696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hAi/I+xZNYQnUCvv34er/GB0MqxllKg2X616+n0zgEo=;
 b=V7Gw6OvYcLnDaGclvjIBkNCFdclef6AFCMKCb5dmwtCR48+nWWyRzLOGaqp74Ghfw1
 wwZABgfX8bhOW+99aXJ1hXygbmQFGsO6QeVWlavMweTFOxy0vN3PnX1yYZ1lHWrxeUy0
 Tquuel1R5oKyaVSwB1JEjUIwL9j01fc6R4PVP3hWRZLZuI1PWGaKG0wjZHqffuSy3Ncz
 DUBv9QDH9nZ9GrR0M/hIh9grmyb/nXJX6Qfx/9hnD3AK3JeenkDqGxeMq4U97apa2YQQ
 fIDToese8MI8HiD570xNSSU17rCm7nX7vTve2K+gH4tOahlENynAobf5gLgzxWjNZuUC
 VZ8w==
X-Gm-Message-State: AOJu0Yz1mEGqRTgoH/3+SwLLgCCkpktlEhCTiwxuZl2nI8hnkc4eeW6C
 h4ioo8VE7TgRs7wM0JOkckDDOs/lyJYPW1xWyAJRRnQPFvJhnmIQE+ln5itkDyDRWzh7JLCGFdI
 FQ0uvObU3dEbR303UjL5s1C/s8Agih/mJherUw6irOkxfDgOQB1kRjsVl+suLtNi2a/+1dVSs6L
 aG9IeCdTGThdhTbHS52A9O3I1MC1DcJ8fWu4ZW8j6ePQ==
X-Gm-Gg: ATEYQzx20PORMi39woZ0dcp68hfMZyAp877MIOHrTyY+AoRAszvZRHpbSWN614D12Qw
 z0cOHWe0vU7R/UpoCBapbYl+rlQp072mxDeU4gLdSqPFaCkKn24ib0gtTDcwY7pYn+UeJ+5r0lj
 KKSMOylLhhaa7y++s7IBbMG/1KQeNMi167lN6Vz9DVNskBCQTd4QMXEl9VupTc4bwwwFn7nSNfL
 r+7+YEqV5GYJHFpeYz0IxnSQ6f3NxyTnr4f+yRra8Ls6KzGbpk4WsXb8CCB7bDXR0jqml+8gFex
 JKfWxbcRWW5uExiPI88HtSY4wwt5+1FGU9VIPFL7peiCt05a7By0SPaN7N3ziUm5+XfISBMfraD
 vCm49MBGx4nrnA73oLNrqAGux0kKOVdJybvZZZ3qd+kE0PSy3aypuqGSf5YB4bf+RMHvmxwwBym
 +gzYB5Vc7csRCEtiXlHk4EmnxahUvrYlMNJMDab5XT8PDCv1J17dsqE1YNPunpEAhk1BnQw8RJH
 r+9v++smvokbVe6eBR0dkfxgcI=
X-Received: by 2002:a17:90b:3dc6:b0:359:87a8:e65c with SMTP id
 98e67ed59e1d1-35bb9ef6088mr1194601a91.17.1773797896007; 
 Tue, 17 Mar 2026 18:38:16 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35bba4f2321sm788462a91.2.2026.03.17.18.38.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 18:38:15 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH 2/2] target/riscv: rvv: Fix page probe issues in vext_ldff
Date: Wed, 18 Mar 2026 09:38:05 +0800
Message-ID: <20260318013805.1920377-3-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318013805.1920377-1-max.chou@sifive.com>
References: <20260318013805.1920377-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Commit 17288e38bebf ("optimize the memory probing for vector
fault-only-first loads") introduced an optimization that moved from
per-element probing to a fast-path broad probe. Unfortunately it
introduced following bugs in cross-page handling:

- Wrong condition for second page probing: checked "env->vl > elems"
  instead of "env->vl > elems + env->vstart", failing to account for
  the vstart offset.

- Incorrect second page address calculation: used
  "addr + (elems << log2_esz)" instead of "addr + page_split".
  For segment loads (nf > 1), this would probe the wrong address,not
  at the page boundary.

- Wrong second page probe size: used "elems * msize" (the first page
  size) instead of calculating the remaining size as
  "(env->vl - env->vstart) * msize - page_split". This would probe
  too little memory and could miss faults.

This commit fixes these bugs by leveraging the probe_pages helper
which automatically handles cross-page memory accesses correctly.

Fixes: 17288e38bebf ("optimize the memory probing for vector fault-only-first loads.")

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/vector_helper.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index a74ce70943..f038997095 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -772,9 +772,9 @@ vext_ldff(void *vd, void *v0, target_ulong base, CPURISCVState *env,
     uint32_t esz = 1 << log2_esz;
     uint32_t msize = nf * esz;
     uint32_t vma = vext_vma(desc);
-    target_ulong addr, addr_probe, addr_i, offset, remain, page_split, elems;
+    target_ulong addr, addr_i, offset, remain, page_split, elems;
     int mmu_index = riscv_env_mmu_index(env, false);
-    int flags, probe_flags;
+    int flags;
     void *host;
 
     VSTART_CHECK_EARLY_EXIT(env, env->vl);
@@ -788,16 +788,8 @@ vext_ldff(void *vd, void *v0, target_ulong base, CPURISCVState *env,
     }
 
     /* Check page permission/pmp/watchpoint/etc. */
-    probe_pages(env, addr, elems * msize, ra, MMU_DATA_LOAD, mmu_index, &host,
-                &flags, true);
-
-    /* If we are crossing a page check also the second page. */
-    if (env->vl > elems) {
-        addr_probe = addr + (elems << log2_esz);
-        probe_pages(env, addr_probe, elems * msize, ra, MMU_DATA_LOAD,
-                    mmu_index, &host, &probe_flags, true);
-        flags |= probe_flags;
-    }
+    probe_pages(env, addr, (env->vl - env->vstart) * msize, ra, MMU_DATA_LOAD,
+                mmu_index, &host, &flags, true);
 
     if (flags & ~TLB_WATCHPOINT) {
         /* probe every access */
-- 
2.43.7


