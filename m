Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CADC0D42BB5
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 17:39:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAupg-0003Kp-2G; Tue, 12 Nov 2024 12:37:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rakicaleksandar1999@gmail.com>)
 id 1tAtyO-0000LV-5R
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 11:42:37 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rakicaleksandar1999@gmail.com>)
 id 1tAtyK-0007NM-5U
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 11:42:35 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5cebbbbaeceso151336a12.3
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 08:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731429748; x=1732034548; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vgup44yY9AzwZEVS1bUWUEFU3T5oYiAM4TzncaEuWhY=;
 b=KO9dqpuWlRvL1/Z32AzVagNn5Jma3G39o1HnM73kWREs6Z1FelkRFI6Ep3bSjtivtK
 ccLQByFssLsJh4GMlAPHM6AvWJqzOMaU4Ayml39WMwBWk8Kz2F6z8kRJQCSgV03Xz07A
 6XhfeJ+w8yxDlWPrQCEtz//RS6Hz+BhvSEL9YmQDUK3G/0B7ovDfUwrkHT9BGpnUMgKd
 A01cwJbk4AYSq2WFbZWoYOCjhNO6Sfvibwm+c3g6ZjSg4n6vycIM3vOOVonJLAVnTzrQ
 Sye9LchpZD6zYMnYu+sxDZ+4DNYyrpASOeSnZNv9az7MoaOuLOv+xR6WhrlWzspL19N3
 9KHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731429748; x=1732034548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vgup44yY9AzwZEVS1bUWUEFU3T5oYiAM4TzncaEuWhY=;
 b=NLxacTOJOGAALgkDKv2LXc8ebiRPbZTK+kjBFg1rp5EGXc0SIVybUTMf16ddzKOBO/
 DFdLR/VnrowXoNFP4+rceUeKRvK1YOOm2azPXxUmBbPuT2RS/HYIVnCUHWBkNj0xdH9V
 YTaQLfX70rXNyEWfnDFvuhLdCb+mhGXHSLb/xFbuHOwSWDNRwwdu+UuIg8nhp6/9YNgK
 ETQdY1TxNie7kFlos+S3JkqJIHuH/vLACwNKERatHxMjKho0TpZABUxXkORN20bAL1Gn
 qftqzcjGAefxNdM0+Fr2UZSqDw8oU70rUUCvmbvyISCYuxWLYDlLySKSGW2i5/wd7+pS
 SAkQ==
X-Gm-Message-State: AOJu0YxLNb19dwW+EDKP5W+UU9QpP+bsaeEg4HU8TMYfhn/KXux7DnJP
 RYAExWk3cSt9RCYvJ+P1kGp08PzHla18PlpoBQUWBGLNPu0ELSPwigMD/TC+
X-Google-Smtp-Source: AGHT+IHhX+C/lp1sAo0GZbwBR0i23l0Jcn66J0OZJfXehj8od43wXyo0aKSbyX/QAJ7at2NrQvb2eg==
X-Received: by 2002:a05:6402:5213:b0:5ce:fa24:fbaf with SMTP id
 4fb4d7f45d1cf-5cf0a45c722mr5456318a12.9.1731429747584; 
 Tue, 12 Nov 2024 08:42:27 -0800 (PST)
Received: from L-H2N0CV05D839062.. ([193.104.68.137])
 by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-5cf03c8130dsm6137004a12.88.2024.11.12.08.42.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 08:42:27 -0800 (PST)
From: Aleksandar Rakic <rakicaleksandar1999@gmail.com>
X-Google-Original-From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
To: qemu-devel@nongnu.org
Cc: aleksandar.rakic@htecgroup.com, djordje.todorovic@htecgroup.com,
 cfu@mips.com, arikalo@gmail.com, peter.maydell@linaro.org,
 philmd@linaro.org, aurelien@aurel32.net, jiaxun.yang@flygoat.com,
 kwolf@redhat.com, hreitz@redhat.com, pbonzini@redhat.com,
 alex.bennee@linaro.org, pierrick.bouvier@linaro.org, berrange@redhat.com,
 Yongbok Kim <yongbok.kim@mips.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Subject: [PATCH v3 1/4] Add support for emulation of CRC32 instructions
Date: Tue, 12 Nov 2024 17:41:27 +0100
Message-Id: <20241112164130.2396737-3-aleksandar.rakic@htecgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112164130.2396737-1-aleksandar.rakic@htecgroup.com>
References: <20241112164130.2396737-1-aleksandar.rakic@htecgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=rakicaleksandar1999@gmail.com; helo=mail-ed1-x531.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 12 Nov 2024 12:37:38 -0500
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

Add emulation of MIPS' CRC32 (Cyclic Redundancy Check) instructions.
Reuse zlib crc32() and Linux crc32c().

Cherry-picked 4cc974938aee1588f852590509004e340c072940
from https://github.com/MIPS/gnutools-qemu

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
Reviewed-by: Aleksandar Rikalo <arikalo@gmail.com>
---
 target/mips/helper.h             |  2 ++
 target/mips/meson.build          |  1 +
 target/mips/tcg/op_helper.c      | 26 ++++++++++++++++++++++++++
 target/mips/tcg/rel6.decode      |  5 +++++
 target/mips/tcg/rel6_translate.c | 14 ++++++++++++++
 target/mips/tcg/translate.c      | 25 +++++++++++++++++++++++++
 target/mips/tcg/translate.h      |  3 +++
 7 files changed, 76 insertions(+)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index 0f8462febb..752748d5e6 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -21,6 +21,8 @@ DEF_HELPER_FLAGS_1(bitswap, TCG_CALL_NO_RWG_SE, tl, tl)
 DEF_HELPER_FLAGS_1(dbitswap, TCG_CALL_NO_RWG_SE, tl, tl)
 #endif
 
+DEF_HELPER_3(crc32, tl, tl, tl, i32)
+DEF_HELPER_3(crc32c, tl, tl, tl, i32)
 DEF_HELPER_FLAGS_4(rotx, TCG_CALL_NO_RWG_SE, tl, tl, i32, i32, i32)
 
 /* microMIPS functions */
diff --git a/target/mips/meson.build b/target/mips/meson.build
index a26d1e1f79..d2d686fc0c 100644
--- a/target/mips/meson.build
+++ b/target/mips/meson.build
@@ -7,6 +7,7 @@ mips_ss.add(files(
   'gdbstub.c',
   'msa.c',
 ))
+mips_ss.add(zlib)
 
 if have_system
   subdir('sysemu')
diff --git a/target/mips/tcg/op_helper.c b/target/mips/tcg/op_helper.c
index 65403f1a87..22600697f0 100644
--- a/target/mips/tcg/op_helper.c
+++ b/target/mips/tcg/op_helper.c
@@ -25,6 +25,8 @@
 #include "exec/exec-all.h"
 #include "exec/memop.h"
 #include "fpu_helper.h"
+#include "qemu/crc32c.h"
+#include <zlib.h>
 
 static inline target_ulong bitswap(target_ulong v)
 {
@@ -143,6 +145,30 @@ target_ulong helper_rotx(target_ulong rs, uint32_t shift, uint32_t shiftx,
     return (int64_t)(int32_t)(uint32_t)tmp5;
 }
 
+/* these crc32 functions are based on target/arm/helper-a64.c */
+target_ulong helper_crc32(target_ulong val, target_ulong m, uint32_t sz)
+{
+    uint8_t buf[8];
+    target_ulong mask = ((sz * 8) == 64) ?
+                        (target_ulong) -1ULL :
+                        ((1ULL << (sz * 8)) - 1);
+
+    m &= mask;
+    stq_le_p(buf, m);
+    return (int32_t) (crc32(val ^ 0xffffffff, buf, sz) ^ 0xffffffff);
+}
+
+target_ulong helper_crc32c(target_ulong val, target_ulong m, uint32_t sz)
+{
+    uint8_t buf[8];
+    target_ulong mask = ((sz * 8) == 64) ?
+                        (target_ulong) -1ULL :
+                        ((1ULL << (sz * 8)) - 1);
+    m &= mask;
+    stq_le_p(buf, m);
+    return (int32_t) (crc32c(val, buf, sz) ^ 0xffffffff);
+}
+
 void helper_fork(target_ulong arg1, target_ulong arg2)
 {
     /*
diff --git a/target/mips/tcg/rel6.decode b/target/mips/tcg/rel6.decode
index d6989cf56e..5074338aa5 100644
--- a/target/mips/tcg/rel6.decode
+++ b/target/mips/tcg/rel6.decode
@@ -16,11 +16,16 @@
 
 &r                  rs rt rd sa
 
+&special3_crc       rs rt c sz
+
 @lsa                ...... rs:5 rt:5 rd:5 ... sa:2 ......   &r
+@crc32              ...... rs:5 rt:5 ..... c:3 sz:2 ......   &special3_crc
 
 LSA                 000000 ..... ..... ..... 000 .. 000101  @lsa
 DLSA                000000 ..... ..... ..... 000 .. 010101  @lsa
 
+CRC32               011111 ..... ..... 00000 ... .. 001111  @crc32
+
 REMOVED             010011 ----- ----- ----- ----- ------   # COP1X (COP3)
 
 REMOVED             011100 ----- ----- ----- ----- ------   # SPECIAL2
diff --git a/target/mips/tcg/rel6_translate.c b/target/mips/tcg/rel6_translate.c
index 59f237ba3b..423b323ba7 100644
--- a/target/mips/tcg/rel6_translate.c
+++ b/target/mips/tcg/rel6_translate.c
@@ -33,3 +33,17 @@ static bool trans_DLSA(DisasContext *ctx, arg_r *a)
     }
     return gen_dlsa(ctx, a->rd, a->rt, a->rs, a->sa);
 }
+
+static bool trans_CRC32(DisasContext *ctx, arg_special3_crc *a)
+{
+    if (unlikely(!ctx->crcp) ||
+        unlikely((a->sz == 3) &&
+                 (!(ctx->hflags & MIPS_HFLAG_64))) ||
+        unlikely((a->c >= 2))) {
+        gen_reserved_instruction(ctx);
+        return true;
+    }
+    gen_crc32(ctx, a->rt, a->rs, a->rt,
+              a->sz, a->c);
+    return true;
+}
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index de7045874d..c97d1d37bd 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -13448,6 +13448,30 @@ static void decode_opc_special2_legacy(CPUMIPSState *env, DisasContext *ctx)
     }
 }
 
+void gen_crc32(DisasContext *ctx, int rd, int rs, int rt, int sz,
+                      int crc32c)
+{
+    TCGv t0;
+    TCGv t1;
+    TCGv_i32 tsz = tcg_constant_i32(1 << sz);
+    if (rd == 0) {
+        /* Treat as NOP. */
+        return;
+    }
+    t0 = tcg_temp_new();
+    t1 = tcg_temp_new();
+
+    gen_load_gpr(t0, rt);
+    gen_load_gpr(t1, rs);
+
+    if (crc32c) {
+        gen_helper_crc32c(cpu_gpr[rd], t0, t1, tsz);
+    } else {
+        gen_helper_crc32(cpu_gpr[rd], t0, t1, tsz);
+    }
+
+}
+
 static void decode_opc_special3_r6(CPUMIPSState *env, DisasContext *ctx)
 {
     int rs, rt, rd, sa;
@@ -15094,6 +15118,7 @@ static void mips_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->abs2008 = (env->active_fpu.fcr31 >> FCR31_ABS2008) & 1;
     ctx->mi = (env->CP0_Config5 >> CP0C5_MI) & 1;
     ctx->gi = (env->CP0_Config5 >> CP0C5_GI) & 3;
+    ctx->crcp = (env->CP0_Config5 >> CP0C5_CRCP) & 1;
     restore_cpu_state(env, ctx);
 #ifdef CONFIG_USER_ONLY
         ctx->mem_idx = MIPS_HFLAG_UM;
diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
index 1bf153d183..cb27ae78ae 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -51,6 +51,7 @@ typedef struct DisasContext {
     bool abs2008;
     bool mi;
     int gi;
+    bool crcp;
 } DisasContext;
 
 #define DISAS_STOP       DISAS_TARGET_0
@@ -181,6 +182,8 @@ bool gen_lsa(DisasContext *ctx, int rd, int rt, int rs, int sa);
 bool gen_dlsa(DisasContext *ctx, int rd, int rt, int rs, int sa);
 
 void gen_rdhwr(DisasContext *ctx, int rt, int rd, int sel);
+void gen_crc32(DisasContext *ctx, int rd, int rs, int rt, int sz,
+               int crc32c);
 
 extern TCGv cpu_gpr[32], cpu_PC;
 #if defined(TARGET_MIPS64)
-- 
2.34.1


