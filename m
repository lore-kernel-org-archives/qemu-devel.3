Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76214606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=B6P/nr6/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXGN-0005fc-OX; Wed, 21 Oct 2026 10:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXDa-0001rm-S5
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:23:04 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXDY-0002Ek-AT
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:23:02 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-487049569b6so548466f8f.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592579; x=1793197379; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gjTRE9/rOI8xxBC5pn3gNvpwGYvb7MSKbkFeQAlAGaI=;
 b=B6P/nr6/ZCnBqwzs/O1ao2ZlGuscMFHJR0+6S0Y/X++5xFZTZpx23wp0Jtox3d7bjE
 uxjtdaod+hAEmHu1LdVeT+HIzGM2+h4NZvJViwavjetPdARWis3PAgkgc/dhW7y2Y7jJ
 DTwov72xyFKPjVd1tK169owxSJqIRFVIsDh/TLSXaBJl8l+FtZF2RjOoGnjvv6MeRTBZ
 L4wyH+qpIrSfrB5J2W1eWCwC4VUphUcNyD2QvZ8feuEwYNSMWV26YO01Bge2WakvmTfh
 bucModvzcKq1XQwBUNIOU30TEB1Vw5dNurcnnQC/qxviKIGu4X5sCrdhK2/sBiKOG8ho
 +4Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592579; x=1793197379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gjTRE9/rOI8xxBC5pn3gNvpwGYvb7MSKbkFeQAlAGaI=;
 b=LaUvUVbqhDN2tAlAiU+tWwrBVZtNSTpYAEQS33x3oWDVsBJ6hndYJ2MnbdMsRU351Q
 4Tc0wta+FqneCuGBdr/rdYuf+qZKghsQceueMSgtTZKkHQN+nWsKfGR3gnusB95C6Yxs
 X6Jf64Z4Udl6arEhD2FKDVxSEf6iEenmgC29RaBOpbEzf1u9hvGYAo43dpjef97ONU8B
 DY2sMeaGqsKLozBDOnKVt3u0ulPG47SD3pbP2E3XlBpcAGOwAf9SsC6gV5j0tUKpy6rR
 XLH3JrUcab2ItUEUEN5AW1gfzC4cWJ6GGQH+fejXE/n6em4bHfv9cemRjaw6LrXm0ezL
 PRAw==
X-Gm-Message-State: AFq9FYK5zMdjZt3UsvNEpYxGm7T32madc6FaFcn4OpN22cd3ljY0tbli
 7JxjhJv8Pln+ro27gXZDIcF59ik2Ofw6Ouc26C3TPNvA0+zssur06wv5kgALK8wIYfw6Yeextsp
 /KnWBgnU=
X-Gm-Gg: AYBFou31vVlCyR7QwHAHDhj5oYfVAwxipiFSpnjCSrIzQwXQ3DNdjBr7i5l2GLsaAqc
 x+41+yKZHX1nUgU2rsKyImdB+PVjLpauOnaoQ8ieqWkdjBxL142G3IzkIkO2AXYn2WzlmOIfJ+J
 5eqk7nThXi/DdBq84x/4z5zMEqARIPZZsgaSq7d2hpjXeahFhiaNqSFRVBRz8b2TaAjEj8T+mWs
 40xfCFR+v62vx0xSQ5o5DHhAD3Rb4+fMd4WJ0hUSznyH59ttHRegh2XuivHoljAfHtGk+DNbCy5
 9t6JN7WqG0c1LZ4lsSn44iHks5xQqQUSZNo737L+32YcSRX0BXA4ZQMwkIxuLXR3WAmaBomnlBL
 VCWM8FAfwZ2HkYfSQzhLJQR2z+m5ohqZz2G2Ftuom59h+f8yKGR63b9Ua5sqT7WLcPt9nEM71uN
 QkGy1RmdIuyseE2GyKxMpBd1IEv90L8qdYvKKeFM+ZpvrP9TylmVvqK2ckdLB200QlIo2kEb9le
 L8JVpS0RmO+f7/ATI5yyteVIAvLJY9DRu/EsJ8rYcvEGlPKXkTaWojWPwKH5HaHkHVY2jidIMOv
 YdetUTCk3mXUUp9bG4eTZxsNWhE=
X-Received: by 2002:a5d:5e8b:0:b0:48a:fb3e:d93c with SMTP id
 ffacd0b85a97d-48e2642e974mr4875638f8f.5.1792592578579; 
 Wed, 21 Oct 2026 07:22:58 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828e72sm5393603f8f.26.2026.10.21.07.22.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:22:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 079/100] tcg: Generic expansion of tcg_gen_add2_*
Date: Wed, 21 Oct 2026 16:16:31 +0200
Message-ID: <20261021141652.363109-80-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x431.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  4 ---
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 64 +++++++++++-------------------------
 3 files changed, 20 insertions(+), 49 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 84fdadc63b..109cad57ea 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -132,8 +132,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
-                      TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh);
 void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh);
 void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -160,8 +158,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
-                      TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh);
 void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
                       TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh);
 void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 003384b65d..e9f0b971a2 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -4,6 +4,7 @@
 DEF2(abs, TCGV, TCGV)
 DEF3(add, TCGV, TCGV, TCGV)
 DEF3(addi, TCGV, TCGV, TINT)
+DEF6(add2, TCGV, TCGV, TCGV, TCGV, TCGV, TCGV)
 DEF5(addcio, TCGV, TCGV, TCGV, TCGV, TCGV)
 DEF3(and, TCGV, TCGV, TCGV)
 DEF3(andi, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 51d5f70ebb..ff4dc6c531 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -345,6 +345,25 @@ void tcg_gen_addi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+void tcg_gen_add2(TCGType type, TCGTemp *rl, TCGTemp *rh, TCGTemp *al,
+                  TCGTemp *ah, TCGTemp *bl, TCGTemp *bh)
+{
+    g_autoptr(TCGTemp) t0 = tcg_temp_new_ebb(type);
+
+    if (tcg_op_supported(INDEX_op_addci, type, 0)) {
+        tcg_gen_op_ttt(INDEX_op_addco, type, t0, al, bl);
+        tcg_gen_op_ttt(INDEX_op_addci, type, rh, ah, bh);
+    } else {
+        g_autoptr(TCGTemp) t1 = tcg_temp_new_ebb(type);
+
+        tcg_gen_add(type, t0, al, bl);
+        tcg_gen_setcond(type, TCG_COND_LTU, t1, t0, al);
+        tcg_gen_add(type, rh, ah, bh);
+        tcg_gen_add(type, rh, rh, t1);
+    }
+    tcg_gen_mov(type, rl, t0);
+}
+
 void tcg_gen_addcio(TCGType type, TCGTemp *r, TCGTemp *co,
                     TCGTemp *a, TCGTemp *b, TCGTemp *ci)
 {
@@ -1145,28 +1164,6 @@ void tcg_gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
-                      TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh)
-{
-    if (tcg_op_supported(INDEX_op_addci, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_op3_i32(INDEX_op_addco, t0, al, bl);
-        tcg_gen_op3_i32(INDEX_op_addci, rh, ah, bh);
-        tcg_gen_mov_i32(rl, t0);
-        tcg_temp_free_i32(t0);
-    } else {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
-        tcg_gen_add_i32(t0, al, bl);
-        tcg_gen_setcond_i32(TCG_COND_LTU, t1, t0, al);
-        tcg_gen_add_i32(rh, ah, bh);
-        tcg_gen_add_i32(rh, rh, t1);
-        tcg_gen_mov_i32(rl, t0);
-        tcg_temp_free_i32(t0);
-        tcg_temp_free_i32(t1);
-    }
-}
-
 void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh)
 {
@@ -1654,29 +1651,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
-                      TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh)
-{
-    if (tcg_op_supported(INDEX_op_addci, TCG_TYPE_REG, 0)) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-
-        tcg_gen_op3_i64(INDEX_op_addco, t0, al, bl);
-        tcg_gen_op3_i64(INDEX_op_addci, rh, ah, bh);
-        tcg_gen_mov_i64(rl, t0);
-        tcg_temp_free_i64(t0);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-        tcg_gen_add_i64(t0, al, bl);
-        tcg_gen_setcond_i64(TCG_COND_LTU, t1, t0, al);
-        tcg_gen_add_i64(rh, ah, bh);
-        tcg_gen_add_i64(rh, rh, t1);
-        tcg_gen_mov_i64(rl, t0);
-        tcg_temp_free_i64(t0);
-        tcg_temp_free_i64(t1);
-    }
-}
-
 void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b)
 {
     tcg_debug_assert(n > 2);
-- 
2.53.0


