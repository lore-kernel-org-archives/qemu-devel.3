Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE30BE87823
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 12:58:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnFxM-0004Zv-8s; Tue, 03 Feb 2026 07:56:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vnFxJ-0004YE-NM
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 07:56:34 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vnFxH-0003xB-RE
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 07:56:33 -0500
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-2a07f8dd9cdso38531965ad.1
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 04:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770123387; x=1770728187; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cqj0jfOXkBAj9g8wl+2YSDp8ZdRFnZcfo5Q+3ASyXgo=;
 b=G0o4wdbbhVBCEyyl+hzcsp0aDYcDj/MyT4/wqjxifOlOUUiRezSVDYjmJkr0Io77ed
 yRvPZnHwZcvXkObp3rNCHlhvEFWAxSJqWPscRWiZP2jCHK284SfxuR53KFEXiCAf40yN
 Cy3tntYjhos3P3ecErCw67XKRPBCro0HSqvMMo5znfM/NSdGTyQqn6k5gq5bCYFdUdTO
 zynCC3JPPMCQHe0motWLfE/Nrdzp5+MlQUoGHyCBB6N0RITJjwINW2hX1vyQn3wXZDZB
 A0z4QNuT+/ecFz7DjpuJ48Uu7baTQ4SwV4KD75a5YVbyl8BUmc1TSjX3kTquDFGavL/7
 AaAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770123387; x=1770728187;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cqj0jfOXkBAj9g8wl+2YSDp8ZdRFnZcfo5Q+3ASyXgo=;
 b=Uu+ZaEgJJ7e4SIxpaCu2Cgo39KqK6VjtzybgHNFbHZ/Wn3QCh4Qx+DFJF9ydGc+ThP
 x0EnlCy5U+i7wnWRskjD7COe++Cia2bIx82CI7HubUm284+aVyzBwV3JjNn9RkQkDTbx
 gWgVD/XYehfWxv+LG8mKMQu79yhWcBN2j1B1xc19VJKebV668KhInIIfUehDYllJ3BW+
 XezbrVmCOLz+lfNZBR1DGauM6a14x9dZQ2Gp50iX2tiDUAFNwBbbqlfjFliRPcW2AeZg
 Jkm7oWqJX3SdkfIqk0sLw8QPFpTx4pwMyUHjVZXhZBanNsJnhpz3ePgtbL9VVeKs08Cb
 MATg==
X-Gm-Message-State: AOJu0Yw7FF0rsXxzmOEIs8iUUWe158smNAxkHiOX4TL7Kq5wBnqwDkr5
 ZLDVD1pGu4k3p1JMLSlV8cYhSys72zU26onJLO43y72/jPNsjH5TfJCo
X-Gm-Gg: AZuq6aJWsFyNAY/K60aulCOuH4UjA5vPIFerRDB5+5x+5HQl7EqOoiunismtFFCGXYr
 cKw48EDHB7REsxc56QV+M3oMu8zYG0e6mNUCt9Hq8WkpQ8bew6hypm185jFZnpWQ1OUCtQP8Xr7
 LOaW4pGtJvyPQ/Zjt6+IPviFlE1yJyDuyDwTkywbe888t6HstYXLP1Aw78D8hW28V9StySRCeCe
 W+OoLJTryYZX3aMaHX5ijROWbqC3sXF8EA1HF+y/pYIhC7oo7P4xuL9P+xzYRPMHNKYr5U4Stbz
 X6uSPMRYXeEdlphzab59SVKVX+Gpo8Wl9UdXyOa20KrSi/C58EDuK+FF0VwctjP3bSNvlVNx55q
 9gKmHttQ3sJPJ2yqdfadYwYKRyffE/l0M90jGaGpCUhZsWyCgD03xdyKnpF/e8jdWQME/kJQ8a8
 aJe4g3Gg5bJVUyvVeqSFDfKEYQ/mP4L3504tLYf7bxceW6Z0P0o/jv5jKO
X-Received: by 2002:a17:902:e78f:b0:2a1:388d:8ef3 with SMTP id
 d9443c01a7336-2a8d96a2b73mr154378325ad.18.1770123387325; 
 Tue, 03 Feb 2026 04:56:27 -0800 (PST)
Received: from ZEVORN-PC.bbrouter ([183.195.22.5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c642aaf1308sm18214796a12.30.2026.02.03.04.56.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 04:56:26 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 hust-os-kernel-patches@googlegroups.com, devel@lists.libvirt.org,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [RFC PATCH v5 4/7] target/riscv: add dret instruction
Date: Tue,  3 Feb 2026 20:56:03 +0800
Message-ID: <ced4ee87cad3ede716b0ca55d6ef9047eb6ba2dc.1770104280.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1770104280.git.chao.liu.zevorn@gmail.com>
References: <cover.1770104280.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pl1-x641.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

RISC-V Debug Specification:
https://github.com/riscv/riscv-debug-spec/releases/tag/1.0

Add DRET decode/translate and a helper to leave Debug Mode and return
to dpc. Executing DRET outside Debug Mode raises illegal instruction.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/helper.h                          |  1 +
 target/riscv/insn32.decode                     |  1 +
 target/riscv/insn_trans/trans_privileged.c.inc | 18 ++++++++++++++++++
 target/riscv/op_helper.c                       | 16 ++++++++++++++++
 4 files changed, 36 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index b785456ee0..6140b6340d 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -131,6 +131,7 @@ DEF_HELPER_6(csrrw_i128, tl, env, int, tl, tl, tl, tl)
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_1(sret, tl, env)
 DEF_HELPER_1(mret, tl, env)
+DEF_HELPER_1(dret, tl, env)
 DEF_HELPER_1(mnret, tl, env)
 DEF_HELPER_1(ctr_clear, void, env)
 DEF_HELPER_1(wfi, void, env)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 6e35c4b1e6..4db842d5d9 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -118,6 +118,7 @@ sctrclr     000100000100     00000 000 00000 1110011
 uret        0000000    00010 00000 000 00000 1110011
 sret        0001000    00010 00000 000 00000 1110011
 mret        0011000    00010 00000 000 00000 1110011
+dret        0111101    10010 00000 000 00000 1110011
 wfi         0001000    00101 00000 000 00000 1110011
 sfence_vma  0001001    ..... ..... 000 00000 1110011 @sfence_vma
 
diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/riscv/insn_trans/trans_privileged.c.inc
index 8a62b4cfcd..f8641b1977 100644
--- a/target/riscv/insn_trans/trans_privileged.c.inc
+++ b/target/riscv/insn_trans/trans_privileged.c.inc
@@ -125,6 +125,24 @@ static bool trans_mret(DisasContext *ctx, arg_mret *a)
 #endif
 }
 
+static bool trans_dret(DisasContext *ctx, arg_dret *a)
+{
+#ifndef CONFIG_USER_ONLY
+    if (!ctx->cfg_ptr->ext_sdext) {
+        return false;
+    }
+    decode_save_opc(ctx, 0);
+    translator_io_start(&ctx->base);
+    gen_update_pc(ctx, 0);
+    gen_helper_dret(cpu_pc, tcg_env);
+    exit_tb(ctx); /* no chaining */
+    ctx->base.is_jmp = DISAS_NORETURN;
+    return true;
+#else
+    return false;
+#endif
+}
+
 static bool trans_mnret(DisasContext *ctx, arg_mnret *a)
 {
 #ifndef CONFIG_USER_ONLY
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 6ccc127c30..99736bbebb 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -454,6 +454,22 @@ target_ulong helper_mret(CPURISCVState *env)
     return retpc;
 }
 
+target_ulong helper_dret(CPURISCVState *env)
+{
+    uintptr_t ra = GETPC();
+#ifdef CONFIG_USER_ONLY
+    riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, ra);
+    return 0;
+#else
+    if (!riscv_cpu_cfg(env)->ext_sdext || !env->debug_mode) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, ra);
+    }
+    target_ulong retpc = env->dpc & get_xepc_mask(env);
+    riscv_cpu_leave_debug_mode(env);
+    return retpc;
+#endif
+}
+
 target_ulong helper_mnret(CPURISCVState *env)
 {
     target_ulong retpc = env->mnepc;
-- 
2.53.0


