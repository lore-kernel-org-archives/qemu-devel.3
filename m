Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BBAEFF5136
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:23:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABXc-0000Hb-G4; Tue, 07 Apr 2026 14:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wABUK-0003wR-MV
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:49:24 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w9yDE-0007H5-CE
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 00:38:53 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-c742723c863so3008717a12.0
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 21:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775536731; x=1776141531; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EKKZg8uq7Ld0d9eFV3gGIWh2uTItY5aVTYw1sMKCdpI=;
 b=NTxBsMjctgVPZ8M3E3uFD16vGm+v+b3dYW2GI77K6Lm+7+wquu3B/JJ/dCYS4WjpGo
 wl/kNSB0/aF40FNkLgYsXopSd6syQFTR/uVFtp8cEjG4UEAzKZaf6dIbEZ6vMosg+c47
 NuJ9hsZKXuGRtz6pVgKMSELS+oFvq8Xw3VoSzzyoYB4b9gjC22AcfLq0sQ4neSCXjW0a
 E/1U89TCBVmIYLydn8wCgwrEuHuxuO/6apVFwetksb4iggFA9vu5h+PUkiluSsaANUZy
 uxAjzdJc870g2UwNECoBkX21O1VcH6IBmk6v5yqXPVnftncH8NtncsmelP8qZUxDpRCu
 NT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775536731; x=1776141531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EKKZg8uq7Ld0d9eFV3gGIWh2uTItY5aVTYw1sMKCdpI=;
 b=X1btX+CuodAvvRQvGa1+ZhggFSBZD+dQnMKsMBigKvJwPbDOUWaKdIh1F/SWPFzLPg
 aKeL5o3CM5H9fIwjH3GVy8wbIwP86WErGdGvAe3DSkBGNcMAxT/k6WbYgKxPRosJo+qL
 6MXbhb3oGyyMPRxcdU/TNuE6iHqmOUx8vbUV/NZPTlnn8T3a0nHr8wQOHViC6mqlhbnE
 Bw4ysgDm9VnOZr+mfSC/dX9PRBB5ZI+iH/y+v8fjB42/84JsktdN3maac63ZNKnwLjl1
 LGRgrJ5tqJ827hWE+SzfJZ1HJ7q3GlKSac2wlVxuiyVEDd4BFXdrevPgQXEVd8CHYfR5
 ASDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqFe6fzTl3g6GDoQdRY9MEHrpN7Tm1Mxgy0oj+czIWbkwPKO6IulSSSpxL8ocIMAUX17f4BBR+SboN@nongnu.org
X-Gm-Message-State: AOJu0Yzn+seH5eKpOHOQWLj5840qyBkipJWOYQRF6UX2bVnCglVqr/qK
 EEZ99HO3v2vXdox/Vc6WRKIqa/kL2hj0I4TV2yV1N0H2hJIPuoYJepfk
X-Gm-Gg: AeBDiet8bECBRRNPoyNvPnPXmcKI4c95xkRcEg2EJ1WXwS0IIjrLZNHch8nT0AvwMDa
 kte485V6URFO95kdjTtY5RpBTPK2P0Ip6NRPR1yoiCeopPahZmOt6LvKdmeBSWd/5vBPSYoFeV9
 pJDaIqWRlYwmRHDJdECxKDoF5qofndeIy4RyBkT69oNuBN3Eo/+6dAcdXw9rouAN4/t2T9cnnQc
 3gFdQ0YKD4u5qhXTakEA9axdMUPl0XoGqL0JDaSFO0SnYDwa/jkwl4GG60310QqQwcyx5p+qwL8
 OKzx0wqjpAbjKqIVrdz7X0znN2QsIMpSBXtqvzUYE0aN+s00LlhVZmnmgL50o17ulE+3SB5/xHX
 siKXAXOHjUYzhfAUtbLgsLpeXAUixw4CF+DQdbJGOPLQbX9+Z9jVroIHlwCvE279Rkw/wNeTQXC
 11iUE3wVQPMyMQTrJMu1uoSRDDWDxovNqbJoD6vkWw
X-Received: by 2002:a05:6a20:3d0d:b0:398:787d:4042 with SMTP id
 adf61e73a8af0-39f2f11da88mr14820664637.50.1775536730902; 
 Mon, 06 Apr 2026 21:38:50 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c6491fedsm15809963a12.8.2026.04.06.21.38.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 21:38:49 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 1/5] target/riscv: Generate access fault if sc comparison fails
Date: Tue,  7 Apr 2026 14:36:10 +1000
Message-ID: <20260407043614.372871-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407043614.372871-1-alistair.francis@wdc.com>
References: <20260407043614.372871-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x535.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Alistair Francis <alistair.francis@wdc.com>

The RISC-V spec states:

"For the purposes of memory protection, a failed SC.W may be treated
like a store."

So if the comparison in sc.w fails we should still check for alignment
and do a probe access to check permissions.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3323
Resoves: https://gitlab.com/qemu-project/qemu/-/work_items/3136
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.h                   |  3 +++
 target/riscv/op_helper.c                | 14 ++++++++++++++
 target/riscv/insn_trans/trans_rva.c.inc |  6 ++++++
 3 files changed, 23 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index b785456ee0..af6cfcfc27 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1289,3 +1289,6 @@ DEF_HELPER_4(vsm4r_vs, void, ptr, ptr, env, i32)
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_1(ssamoswap_disabled, void, env)
 #endif
+
+/* Zalrsc" SC write probe */
+DEF_HELPER_FLAGS_3(sc_probe_write, TCG_CALL_NO_WG, void, env, tl, tl)
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 6ccc127c30..b569366369 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -281,6 +281,20 @@ void helper_cbo_inval(CPURISCVState *env, target_ulong address)
     /* We don't emulate the cache-hierarchy, so we're done. */
 }
 
+void helper_sc_probe_write(CPURISCVState *env, target_ulong addr,
+                           target_ulong size)
+{
+    uintptr_t ra = GETPC();
+    int mmu_idx = riscv_env_mmu_index(env, false);
+
+    if (addr & (size - 1)) {
+        env->badaddr = addr;
+        riscv_raise_exception(env, RISCV_EXCP_STORE_AMO_ADDR_MIS, ra);
+    }
+
+    probe_write(env, addr, size, mmu_idx, ra);
+}
+
 #ifndef CONFIG_USER_ONLY
 
 target_ulong helper_sret(CPURISCVState *env)
diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/insn_trans/trans_rva.c.inc
index a7a3278d24..62c0fe673d 100644
--- a/target/riscv/insn_trans/trans_rva.c.inc
+++ b/target/riscv/insn_trans/trans_rva.c.inc
@@ -90,6 +90,12 @@ static bool gen_sc(DisasContext *ctx, arg_atomic *a, MemOp mop)
      */
     TCGBar bar_strl = (ctx->ztso || a->rl) ? TCG_BAR_STRL : 0;
     tcg_gen_mb(TCG_MO_ALL + a->aq * TCG_BAR_LDAQ + bar_strl);
+    /*
+     * "For the purposes of memory protection, a failed SC.W may be treated
+     * like a store." so let's check the write access permissions
+     */
+    gen_helper_sc_probe_write(tcg_env, src1,
+                              tcg_constant_tl(memop_size(mop)));
     gen_set_gpr(ctx, a->rd, tcg_constant_tl(1));
 
     gen_set_label(l2);
-- 
2.53.0


