Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 525C6ECE57B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 08:33:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snZpK-0004E2-LO; Mon, 09 Sep 2024 04:32:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1snZpI-0004C9-E3
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 04:32:48 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1snZpG-0008TR-KH
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 04:32:48 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42c7b5b2d01so47042075e9.3
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 01:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1725870764; x=1726475564; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qaZQYz0SvX+ateb02T1sX7QlYRxIfBB8EH9iwlM8BWE=;
 b=cGzvVR05YunBOVkWL8BBXvGQjnaYt0O5+hTtW6VEAVWGlB4AEsV/UtD24ld4Uw0MBr
 H6gTzBUpUsBKVw036+qM7j3h7ONiuGfVP5dpP8KmwxA75Lp84LKj+8cm4tCEOpTm5yR9
 XciXsJxwAujt2QdHlb4p+mqbxmucTNW/AYaZopCKmVs03jFXkjSuEY0WQi8FARA08U+I
 AZp672nR1Zo9TqZ8iovSSvwN2ZeKIBl+3dPsI9EpeaxpEmq6yHoJL1TNoAHtDBvg/D4r
 VdkuAGLbVh9nP5Ithgfti9jklR+0wHw/1ZrQGcc61O8rM3uCejvCBLsCvm7fJYlQnq7q
 Ce2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725870764; x=1726475564;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qaZQYz0SvX+ateb02T1sX7QlYRxIfBB8EH9iwlM8BWE=;
 b=L/FP8XNvSTNROvKQsjEzWqo2foWq35yYImCxhxEsiAR/2I4C585ghcYjLJAVWSWrtx
 jWdZAH628Bp6OlqgkASV+o1qAuOw195bjOHQ7s197LrqZ/gN/MnbTm2gJSzr8DRUWSg+
 RwxksEhN/zW8XuA5GLkF/ben1C3Jc7QhgbvLkIpy6pUmZngHxGo2ijAsPWJ+4DnflrFO
 UbxEM1U5j40Fc0vI8QccYhwTkmr2SUKrHl7fNyynrEbikS9+BasiOOIgkwXBioUZFVJc
 9uSwVoypcrvuaZf5h7NcW2zBZb3mhEyb8QtneGjx84Pnsw0Nas1lcJx2zmq98qtUZBnN
 CzUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5pTahVUOn9NiqHHqzo1apTTqZvrs0K5eaBpWfVYVd0YAKrE8MEdWL+lC6vcz8hH7cQZo17WFlnFs4@nongnu.org
X-Gm-Message-State: AOJu0Yw5Nd+jIiKaHyCxdwryDg873IOFzhJlaulUnxpZ7tgU9QfP9/nD
 GAY9uf1E2eBalBY90v47hqt77FGQ79KFkQLSbmXU9n3zfKiY5wslQgUrhTPiTm0=
X-Google-Smtp-Source: AGHT+IEA1cN72rSRhwl/iZZZqgVhUKgbjBg9EjiAhQbZH1jrWALTHPiukfU1ftJN22vbx6ApTh+4fA==
X-Received: by 2002:adf:ea0e:0:b0:374:c05f:2313 with SMTP id
 ffacd0b85a97d-3789243fa0bmr5826589f8f.45.1725870763618; 
 Mon, 09 Sep 2024 01:32:43 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37895675b8bsm5413517f8f.54.2024.09.09.01.32.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 01:32:43 -0700 (PDT)
From: Andrew Jones <ajones@ventanamicro.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bmeng.cn@gmail.com,
 zong.li@sifive.com, liwei1518@gmail.com, cwshu@andestech.com,
 dbarboza@ventanamicro.com, richard.henderson@linaro.org, philmd@linaro.org
Subject: [PATCH v2] target/riscv32: Fix masking of physical address
Date: Mon,  9 Sep 2024 10:32:42 +0200
Message-ID: <20240909083241.43836-2-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

C doesn't extend the sign bit for unsigned types since there isn't a
sign bit to extend. This means a promotion of a u32 to a u64 results
in the upper 32 bits of the u64 being zero. If that result is then
used as a mask on another u64 the upper 32 bits will be cleared. rv32
physical addresses may be up to 34 bits wide, so we don't want to
clear the high bits while page aligning the address. The fix is to
use hwaddr for the mask, which, even on rv32, is 64-bits wide.

Fixes: af3fc195e3c8 ("target/riscv: Change the TLB page size depends on PMP entries.")
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
-v2: Switch from signed long to hwaddr

 target/riscv/cpu_helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 395a1d914061..4b2c72780c36 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1323,7 +1323,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     int ret = TRANSLATE_FAIL;
     int mode = mmuidx_priv(mmu_idx);
     /* default TLB page size */
-    target_ulong tlb_size = TARGET_PAGE_SIZE;
+    hwaddr tlb_size = TARGET_PAGE_SIZE;
 
     env->guest_phys_fault_addr = 0;
 
@@ -1375,7 +1375,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 
                 qemu_log_mask(CPU_LOG_MMU,
                               "%s PMP address=" HWADDR_FMT_plx " ret %d prot"
-                              " %d tlb_size " TARGET_FMT_lu "\n",
+                              " %d tlb_size %" HWADDR_PRIu "\n",
                               __func__, pa, ret, prot_pmp, tlb_size);
 
                 prot &= prot_pmp;
@@ -1409,7 +1409,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 
             qemu_log_mask(CPU_LOG_MMU,
                           "%s PMP address=" HWADDR_FMT_plx " ret %d prot"
-                          " %d tlb_size " TARGET_FMT_lu "\n",
+                          " %d tlb_size %" HWADDR_PRIu "\n",
                           __func__, pa, ret, prot_pmp, tlb_size);
 
             prot &= prot_pmp;
-- 
2.46.0


