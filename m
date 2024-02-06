Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F2BC48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 13:20:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXLMT-0003i0-Qn; Tue, 06 Feb 2024 08:19:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1rXLMO-0003fs-Q0
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 08:19:37 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1rXLMJ-0005yB-CD
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 08:19:36 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5cddfe0cb64so4380842a12.0
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 05:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1707225567; x=1707830367; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GMvi22rkrBmsZVwZknytn23922K4Y1Z689E1EhIiGOc=;
 b=Hcqr4uCGAGuDP70DhZPuPQaTfMGcqFW90vsvqtVLOKqsatxnEtgxZIUxKK0VvLzabL
 5fYypeN2fPq2SOx4PIjdQ8gXfKkpn5Doo9UDR/Ft9pIeQz2/VCDluhZ7v7JUmbhoOJPX
 1CFf2GyfaCXeQKmKxcrmJ7K6FuL+hFXxwIKeD7WbraYOLFBusE+LZM/XjmB/2/Y0MbEh
 2RVhmbQtTvkLoCeTxuMPmSzq2OM54h0LvtTNlcA0/4Rx1CPVPfyvUKQm4D7lmqfy6sjH
 lq7juArQT2wJ2ZmfMMhTkDBotj3P9VkULOFOjHD9B/VU6O3uqu7MXfrEsGfmw/BTcVob
 lwng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707225567; x=1707830367;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GMvi22rkrBmsZVwZknytn23922K4Y1Z689E1EhIiGOc=;
 b=YDw1iJM3O4tXOCv+sKH35vtqVhTWQYW6rhTwWbdNlgLMyz1xCNcKMF9p73CGA5e/hO
 6NANnYtHVPFXGx+uqs/XZXJ+vp0KSlts0YhEAwox5TdoqAB5+6tUzdsCCI/QzlFFclhy
 SAN9Y/Fnz4D4rJAkx6WtvvbQAygad8sWY/7p7TfwHtrE/8Y5Hb9kOtA2VFNOZ2wcPFIv
 lZtmjix2YR7v0uwWtWGXPgiKw8rGKzeHHe8k7yeCDtpngQX8KbL+odZ6hKA6Z8Su5rAK
 lBejWZNqe+6nEyhQppmuSVmAXUrp9EigFvCLGhiGmzY6waNfFZas0KbWoULv1a9l5W5Q
 3X8w==
X-Gm-Message-State: AOJu0YytPE7L7/VzS0gY6A3BGHQw5AQhxTa0AB9C7QRTC9QA5FdPdBmS
 4h0slNrD0RQDPkRFJpmvwFuy9O2jc4lVUjTawRfhKAQ9qLFj7cyGbx9TWEbdJvIXiwFa7EmoaC9
 MNPVa2mXUkH6iy3Y3rF+JMwSwZgqLXcQS4z2AK9lyubqvDhy+ZoT5vbXAoaRRjPc/hwVzC7iCAy
 DqcUWQCTytqQl34ywa1AhejUgFyBqaUC72dyytNyk=
X-Google-Smtp-Source: AGHT+IGK05hxnLosC4RZVktCIsUlf65XRFm/EGNDcVQpcrKir8UrYZ5T/PAeDySXuKiGn46NSVD+mg==
X-Received: by 2002:a05:6a00:9a0:b0:6db:d59c:a5b7 with SMTP id
 u32-20020a056a0009a000b006dbd59ca5b7mr3317383pfg.20.1707225567203; 
 Tue, 06 Feb 2024 05:19:27 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUjUImBatw7bAKJ5cUfYtKwc2S7NnfFZOd0Pl5sDSdoys1vyScsAAHFP0A5s6j1zuwi2yuetV9kv2mU3ujsrptfE2UwCeF/DgTMdMLk05GQhM078Be248qo/y+U2FXvE02ufdi+WO9BKzq54ZPiTQ88q1u4KHW/PhqeY45ehLHTOTdklpD2Fz7IC0imdQ+b3zxmASjgmzbg2jmHeHt6CUAEptRkpQz1ply0YFg+FHxyZ6zMYITHrHEcnYSwoqeLQE6nYDLbWWVhDzB6HWWK9qnxYsRG+ZN2Q1nIPt7Qxw6z4s4lkmHgAxleFuOzaL/awwfDz0wscDDLKGnzTkxljkA2KD5XQThDZ2VjBqTJrvEaRyNT
Received: from hsinchu16.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 e11-20020aa798cb000000b006e04ddf97f7sm1837105pfm.107.2024.02.06.05.19.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 05:19:26 -0800 (PST)
From: Jason Chien <jason.chien@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Jason Chien <jason.chien@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Junqiang Wang <wangjunqiang@iscas.ac.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH] target/riscv: Update $pc after linking to $ra in
 trans_cm_jalt()
Date: Tue,  6 Feb 2024 21:18:42 +0800
Message-ID: <20240206131911.10998-1-jason.chien@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=jason.chien@sifive.com; helo=mail-pg1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The original implementation sets $pc to the address read from the jump
vector table first and links $ra with the address of the next instruction
after the updated $pc. After jumping to the updated $pc and executing the
next ret instruction, the program jumps to $ra, which is in the same
function currently executing, which results in an infinite loop.
This commit reverses the two action. Firstly, $ra is updated with the
address of the next instruction after $pc, and sets $pc to the address
read from the jump vector table.

Signed-off-by: Jason Chien <jason.chien@sifive.com>
---
 target/riscv/insn_trans/trans_rvzce.c.inc | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvzce.c.inc b/target/riscv/insn_trans/trans_rvzce.c.inc
index 8d8a64f493..a185e2315f 100644
--- a/target/riscv/insn_trans/trans_rvzce.c.inc
+++ b/target/riscv/insn_trans/trans_rvzce.c.inc
@@ -293,13 +293,6 @@ static bool trans_cm_jalt(DisasContext *ctx, arg_cm_jalt *a)
 {
     REQUIRE_ZCMT(ctx);
 
-    /*
-     * Update pc to current for the non-unwinding exception
-     * that might come from cpu_ld*_code() in the helper.
-     */
-    gen_update_pc(ctx, 0);
-    gen_helper_cm_jalt(cpu_pc, cpu_env, tcg_constant_i32(a->index));
-
     /* c.jt vs c.jalt depends on the index. */
     if (a->index >= 32) {
         TCGv succ_pc = dest_gpr(ctx, xRA);
@@ -307,6 +300,13 @@ static bool trans_cm_jalt(DisasContext *ctx, arg_cm_jalt *a)
         gen_set_gpr(ctx, xRA, succ_pc);
     }
 
+    /*
+     * Update pc to current for the non-unwinding exception
+     * that might come from cpu_ld*_code() in the helper.
+     */
+    gen_update_pc(ctx, 0);
+    gen_helper_cm_jalt(cpu_pc, cpu_env, tcg_constant_i32(a->index));
+
     tcg_gen_lookup_and_goto_ptr();
     ctx->base.is_jmp = DISAS_NORETURN;
     return true;
-- 
2.43.0


