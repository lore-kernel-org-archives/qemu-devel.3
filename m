Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5705AC3DA5D
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 02:16:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUGbi-0005ia-8s; Wed, 17 Jul 2024 22:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUGbb-0005Vw-Hk
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 22:10:53 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUGbZ-0003PZ-TO
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 22:10:51 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1fb0d88fdc8so2066675ad.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 19:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721268648; x=1721873448; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VkUhjdCMVR9iGt2QFAMwHKiejIZAdYuuJCQxNaY/YDY=;
 b=KJuOTVcr3Z8bccsJifKz+SXx7xbfruzreKNbZxUcdV/OZtdHRr/AootvrR1EOe1q7q
 NhqJDfsqi3JXjoiuU1uII59qKwwxTjbMmyl5M/FN5rXv4bOPfkwpsLzwlvImqBE0/ljp
 V6QNG4H/wMsOlFxx3fKOUnU5JhwkfJEJWqQzlX9/n6dBpRzuXsiyRdJvkKBtA14QU/CR
 Mgw7a9H3H/sUL0KtCHAIjkaDwkiIAdcyVdb5cIa+zxhyIuC9dLl3Jc6tgy60XEu49Er7
 cmyjXcmky6hYbt5+Cg5y5rxv+kNX4rxmY++tyafDntfnzi+YuwMtiJQI+tHv70uPDUb0
 tYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721268648; x=1721873448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VkUhjdCMVR9iGt2QFAMwHKiejIZAdYuuJCQxNaY/YDY=;
 b=LL9ga2PxDnVNApkZK5PeT+1hMUOOcPJ+OvqatKuJLUpkGglUkbySgvmSTi4x/vKJYV
 owsTk//lBnQRlji6m1yomcrKVvaGq4P2FX5yE6/Ny/SW2OLzGVgEB4N+oNPqh3VdQiS6
 l/1tTeiCdLjAulKZcGGOHxXUDpVBGjifmsAUsrcwhzGplhlfdH4sSH3jEGqDyzpwzMB+
 BTvqHBPJJv+r68uWMK96Jh3SaJvRDzanAlCBnV69ykidqaJv9DWslL8XGAONcx3Eg9r0
 Qk5Wte8Fl4PP1nnbbtrI3CIpWpuw90dE5ZxVk9SwdT0MPQxvkjbK9iDxSxSPrnUwCozG
 +nuQ==
X-Gm-Message-State: AOJu0YyG/UR+FSAMDuE8njRcG3Ok5Nq6VIkHsicV73A0rTSJUjafGNlT
 0rVDTctZhT9pZKBPsQMJz8EZkgLxZj88Hd5ZoVaWll1T75a7nMUuu+StoLW/
X-Google-Smtp-Source: AGHT+IGDMsjA49BbaSClE+hGFa56vUJiU5J8V/cjI91rk5ni4z5xzbeYKXqXY3b0lAGio0mCsRL/Rg==
X-Received: by 2002:a17:902:dacc:b0:1fb:de19:fefc with SMTP id
 d9443c01a7336-1fc4e5667dbmr32989145ad.30.1721268648356; 
 Wed, 17 Jul 2024 19:10:48 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fc0bba949bsm81999385ad.69.2024.07.17.19.10.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 19:10:47 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 08/30] target/riscv: Move gen_cmpxchg before adding amocas.[b|h]
Date: Thu, 18 Jul 2024 12:09:50 +1000
Message-ID: <20240718021012.2057986-9-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718021012.2057986-1-alistair.francis@wdc.com>
References: <20240718021012.2057986-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240709113652.1239-9-zhiwei_liu@linux.alibaba.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/translate.c                    | 13 +++++++++++++
 target/riscv/insn_trans/trans_rvzacas.c.inc | 13 -------------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 4a3e786560..acba90f170 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1099,6 +1099,19 @@ static bool gen_amo(DisasContext *ctx, arg_atomic *a,
     return true;
 }
 
+static bool gen_cmpxchg(DisasContext *ctx, arg_atomic *a, MemOp mop)
+{
+    TCGv dest = get_gpr(ctx, a->rd, EXT_NONE);
+    TCGv src1 = get_address(ctx, a->rs1, 0);
+    TCGv src2 = get_gpr(ctx, a->rs2, EXT_NONE);
+
+    decode_save_opc(ctx);
+    tcg_gen_atomic_cmpxchg_tl(dest, src1, dest, src2, ctx->mem_idx, mop);
+
+    gen_set_gpr(ctx, a->rd, dest);
+    return true;
+}
+
 static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
diff --git a/target/riscv/insn_trans/trans_rvzacas.c.inc b/target/riscv/insn_trans/trans_rvzacas.c.inc
index 5d274d4c08..fcced99fc7 100644
--- a/target/riscv/insn_trans/trans_rvzacas.c.inc
+++ b/target/riscv/insn_trans/trans_rvzacas.c.inc
@@ -22,19 +22,6 @@
     }                                     \
 } while (0)
 
-static bool gen_cmpxchg(DisasContext *ctx, arg_atomic *a, MemOp mop)
-{
-    TCGv dest = get_gpr(ctx, a->rd, EXT_NONE);
-    TCGv src1 = get_address(ctx, a->rs1, 0);
-    TCGv src2 = get_gpr(ctx, a->rs2, EXT_NONE);
-
-    decode_save_opc(ctx);
-    tcg_gen_atomic_cmpxchg_tl(dest, src1, dest, src2, ctx->mem_idx, mop);
-
-    gen_set_gpr(ctx, a->rd, dest);
-    return true;
-}
-
 static bool trans_amocas_w(DisasContext *ctx, arg_amocas_w *a)
 {
     REQUIRE_ZACAS(ctx);
-- 
2.45.2


