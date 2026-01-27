Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 402A0D2F029
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 13:18:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkiwH-0007H3-9V; Tue, 27 Jan 2026 08:17:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vkiw7-00079l-Mm
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 08:16:53 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vkiw4-0004b9-28
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 08:16:51 -0500
Received: by mail-pl1-x642.google.com with SMTP id
 d9443c01a7336-2a7a9b8ed69so59826655ad.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 05:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769519805; x=1770124605; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mm/3dAQBor5aHsIKTr1YNKoYJvIqXNWkdCE6WmE7HoA=;
 b=nPvFYAbyq14aZicxHzNSYRMNgaGqNoidfDzhATtLgKm9AkhK7lO7stXiF3WIhbN1jg
 Q4fcTAGi6fwVosGbuWaDVYq9k5X+h6zN/z8+oYFKY57mVSAW51qWe3VU6yinLtqC44Ax
 /6UCGG1fPPoiXWEIjtEhcuMqmIfeVW3TEcKVN1PdBiiXJkVdFps09tUiK8rzFeZooVJZ
 43McAMa1fhBhdHwLs4qzlDy051Gt+/sOlWhjd+jL4/3NmKFEjD8Lz3fWVhkIf+mLmsp0
 dNMbC9IpIArvequsiG/9G9LurtVHmlr9xj9MDFLk9mZMgnvIOlFTGqlK1pv84j3j28FO
 4cxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769519805; x=1770124605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Mm/3dAQBor5aHsIKTr1YNKoYJvIqXNWkdCE6WmE7HoA=;
 b=JFs7jU7IMMvKdm2bDWPtLoX/wSsjfFSQ+aYxIcpTIPNztB41gszbyukN3fN7MFmR4t
 wNi3Tr6nMgaxX6spvyUOjYNrHgYfW0HAApQWwwd3XbhcYXi8rO3RKN5Wex7BU3i18V9A
 uPlZ7qUKkbCIxv2aOr1xnYMrL6TpY9CQ/ejydktV5dJlX5v6a+qljyg8AWIm4KhL3/86
 y1/WaTidlpo72bxxW+rW79euoqr1xsvBWztD5WbHR4pXa20IX65vhN4IPFbmysh1N23V
 PjwjMB+daYbUijJ71Df/A0H8T4sOT7XlGydbybmh4VWn17PKuy0jLN4Va7zzTNLyF/wx
 rlXA==
X-Gm-Message-State: AOJu0YxandXgQs29HYHfxH9kVzGAJsE83WuSzUaRJEzwWXXWdy0sMNab
 dGnsat+CI8d8ku6+znpN2eMTFJJLjpwMTHOXdNCueiBmKFJEnqRwkT30
X-Gm-Gg: AZuq6aLaK5r3OgDaL/apH21u2B0p2BJ6HJ5iqZO4zSi6bKvaH3Ymy7PnKMyIstmSKLj
 oEJw+jZF0TH+6l+81rlhNFTT7jViASVGD6lg8sOxN8QHpqZ6GKbuvyaU8LplkNBNxbjoyyM8yEA
 SyaB3ixzZI5cjDNryy1TjlkG8PWiNqJzN5CnjuY2kVroiSkA4Ojv6a/xWF4DaMilywgWh3b5Q0v
 ThC8QMbLDkhE4mYhROdsvDVGUgpJV/F5uTwDsF122G+32AVOq0CDKe/o4PowH8jdm32gqDnZ+5T
 I2+COKH+U1RiAVbvi4KPlDtQL/tWg+sSQbgjFEEabTzbRbeftudPP4Cv1XqldoYiqGFIH2Khe9n
 SfNrZcPeCc0pf9G2spIYXxaffWm0YVoY8daxdWsoOezlc3+maDZyikI0oOSQFANtNZD6WHp/X9r
 wSNm7WRpbrP2enchywWbBH3uR9oO+XOXcKVXzMkqNReRyVEO2oyWwWFePEb8w=
X-Received: by 2002:a17:902:f60e:b0:2a0:bb3b:4191 with SMTP id
 d9443c01a7336-2a870d7a91dmr15791755ad.12.1769519805099; 
 Tue, 27 Jan 2026 05:16:45 -0800 (PST)
Received: from ZEVORN-PC.bbrouter ([183.195.23.113])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a802fb03b4sm117164345ad.82.2026.01.27.05.16.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 05:16:44 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, wangjingwei@iscas.ac.cn,
 hust-os-kernel-patches@googlegroups.com,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [RFC PATCH v3 4/7] target/riscv: add dret instruction
Date: Tue, 27 Jan 2026 21:15:48 +0800
Message-ID: <83a9bb4ebe16311c007ab4968e7445d121256e02.1769517768.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769517768.git.chao.liu.zevorn@gmail.com>
References: <cover.1769517768.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pl1-x642.google.com
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

RISC-V Debug Specification:
https://github.com/riscv/riscv-debug-spec/releases/tag/1.0

Add DRET decode/translate and a helper to leave Debug Mode and return
to dpc. Executing DRET outside Debug Mode raises illegal instruction.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
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
2.52.0


