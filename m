Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2DE606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 13:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=nNHsQtxo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMmTV-00045W-Mw; Fri, 30 Oct 2026 09:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMmSr-0002jG-5E
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:16:18 -0400
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMmSi-0005VK-8d
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:16:08 -0400
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-4a755bbe158so473280fac.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 06:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793366161; x=1793970961; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HNTd1g80+YDEGB6ituftaPpJ1wOUyR7NzGt5BUdivzo=;
 b=nNHsQtxonVA2SO4Q3T52lMVOB1+ssLkP5CMV232ZCtk/UetA9k0Bj31vlDpqi40hZn
 ttWmpA5O1dNbxRpRbu0TM0PcOMUhKa9X3UAFsZ/tdFp3QW3yzMelCuulnvZsQjSi7kRu
 O24oLGRM5fV+4sBzfyZjIm/MQtlEMAaqBrl9trDMKFVaGk99wyQZkPKHhoQD5pZ/03U4
 uTPbY23bGxGqlYJK9FxR7W+6mDoIlZF8aY/znY54liRZd4Q/oKaIG6pXMChfclEaF/ZX
 LSzM4W77SAjGZk+NdbHbPMWZ+CJsss+NhfFrs89lsmcHpvnX0UvAEvspnycsIRZBLYO0
 3ldA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793366161; x=1793970961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HNTd1g80+YDEGB6ituftaPpJ1wOUyR7NzGt5BUdivzo=;
 b=zDi6xskLv/tuAmsl2msKijOv5/B7rD9aNjbjeQdSmD0nEjcnTscI7bhzsNkZPozaV6
 uH+Vk5QHT3gX9OR7bIdO1qFp3nO2RhXdFK9g85bOO6v0DIAnYmoMHE4XXdKbGRmFBOCu
 2s/WzStSJhT/ba/ungK4FUgY+9yvUIxvTQtq4VdzdDnjvgpZnmdbJM49idZ6Yz/XBNvb
 o19Ic9TnABFzTZDPqSZCUY75b9ZJNByKQeEkGAalRheh4xegN9jXwfAyj56PeAatDyAv
 R5v7ufUMHZ6OCAx7i3GgSbeE1BFYbjj8yLK9yot70RJ2KltnIUsMwmSWr2jDp1At9/u8
 uO9g==
X-Gm-Message-State: AFq9FYLHP9EL9ithu1j5vW+9gs/VmJo8GiWOExKPFFPaM1/Ao3HcsXxL
 rZrh06ivT5z+j+chfHjSpzRpx/FbCS50lv4lN8bTdLmQ3oTiJJvio6C+X8rNE8zB8h7vNVoID5j
 N+hch
X-Gm-Gg: AYBFou1/NuHJ+voXMJwEZkwqqxlrPRoehWObtsj3n7jnA5rM00H292fEWjN8xzg8znA
 Om5mQ/Gi58TOQ+yNgYbYvl3B4MHNHdSmwVJVY3llYy1rJHzxjsr1iLCe8ZCLoaNSfs2VOjq+5vJ
 yQAsHMxeSG62Hin3I6P/hHrsFIL6uUPwAytzAdPT6N5OIIRGkOEorXYh53nK4QUhvO7Tms22zNr
 JqqOtr6jAfugefgymj3JX6PBN0HjnfEkEd4EM2DJLv4GSADlKsV/Nrsh8pMG/3UnKJkFSRWxeeB
 liNehb23tJfTfWV5bn8TrmO4irTgScEau6+zWKA3xosvHRAnD/mvwmG6TlxbvZGpNgiIFMMv2Xx
 OL2vlaLW5JYYkRjtHXNz1Oi/Bq/t4udCOwCerGkpfkgJil+EKSMIyOEQPXFqGID8wr1r/Smxk9W
 pFH4QIWrd4O2mJOctVnajZPIoKQzzHtn0klTdKQptm/vHdK3jOFnsZYrfAcoYDRlV/r5oTFFkKV
 PDmrgPvdrswoAy55P+RWuYwqilNM3jTpMoJ3Ad9+E3nxyUNnyB62Jaw+63tnoV3wVNLf59eVWVw
 hMrtS3YRny6ycYj5KyApA6IQINGNZJABbgTDdxiTRtQEFLLDBw0=
X-Received: by 2002:a05:6871:88b:b0:47b:e30b:893c with SMTP id
 586e51a60fabf-4a8e05ff2d3mr2807198fac.6.1793366160896; 
 Fri, 30 Oct 2026 06:16:00 -0700 (PDT)
Received: from stoup ([50.233.235.3]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a90ae4e6bcsm1796812fac.3.2026.10.30.06.16.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 06:16:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 05/19] tcg: Add tcg_gen_lea_{i32,i64,tl}
Date: Fri, 30 Oct 2026 08:15:40 -0500
Message-ID: <20261030131554.41208-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030131554.41208-1-richard.henderson@linaro.org>
References: <20261030131554.41208-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2f.google.com
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

Reviewed-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op.h         |  2 ++
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 43 ++++++++++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index 3721164236..a7d001c959 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -83,6 +83,7 @@ typedef TCGv_i64 TCGv;
 #define tcg_gen_shri_tl tcg_gen_shri_i64
 #define tcg_gen_sar_tl tcg_gen_sar_i64
 #define tcg_gen_sari_tl tcg_gen_sari_i64
+#define tcg_gen_lea_tl tcg_gen_lea_i64
 #define tcg_gen_brcond_tl tcg_gen_brcond_i64
 #define tcg_gen_brcondi_tl tcg_gen_brcondi_i64
 #define tcg_gen_setcond_tl tcg_gen_setcond_i64
@@ -209,6 +210,7 @@ typedef TCGv_i64 TCGv;
 #define tcg_gen_shri_tl tcg_gen_shri_i32
 #define tcg_gen_sar_tl tcg_gen_sar_i32
 #define tcg_gen_sari_tl tcg_gen_sari_i32
+#define tcg_gen_lea_tl tcg_gen_lea_i32
 #define tcg_gen_brcond_tl tcg_gen_brcond_i32
 #define tcg_gen_brcondi_tl tcg_gen_brcondi_i32
 #define tcg_gen_setcond_tl tcg_gen_setcond_i32
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index e694f0e38c..c9caab2138 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -37,6 +37,7 @@ DEF3(ld8s, TCGV, TCGv_ptr, tcg_target_long)
 DEF3(ld8u, TCGV, TCGv_ptr, tcg_target_long)
 DEF3(ld16s, TCGV, TCGv_ptr, tcg_target_long)
 DEF3(ld16u, TCGV, TCGv_ptr, tcg_target_long)
+DEF5(lea, TCGV, TCGV, TCGV, unsigned, TINT)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF6(movcond, TCGCond, TCGV, TCGV, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 4814a493c0..fced3811c2 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -820,6 +820,49 @@ void tcg_gen_ld16u(TCGType type, TCGTemp *dst,
     tcg_gen_op_tti(INDEX_op_ld16u, type, dst, base, ofs);
 }
 
+void tcg_gen_lea(TCGType type, TCGTemp *dst, TCGTemp *base,
+                 TCGTemp *index, unsigned sh, int64_t imm)
+{
+    g_autoptr(TCGTemp) t = tcg_temp_new_ebb(type);
+
+    if (imm != 0) {
+        if (TCG_TARGET_lea_imm_valid(type, imm)) {
+            /*
+             * The immediate is non-zero and valid.
+             * If the shift is out of range, perform the shift first
+             * so that we can still emit (base + t + imm) as one insn.
+             */
+            if (!TCG_TARGET_lea_sh_valid(type, sh)) {
+                tcg_gen_shli(type, t, index, sh);
+                index = t;
+                sh = 0;
+            }
+            tcg_gen_op_tttii(INDEX_op_lea, type, dst, base, index, sh, imm);
+            return;
+        }
+
+        /*
+         * If we can make the immediate smaller by folding it
+         * into index before the shift, do so.
+         */
+        if (sh != 0 && imm == (imm >> sh) << sh) {
+            tcg_gen_addi(type, t, index, imm >> sh);
+            index = t;
+            imm = 0;
+        }
+    }
+
+    if (sh == 0) {
+        tcg_gen_add(type, dst, base, index);
+    } else if (TCG_TARGET_lea_sh_valid(type, sh)) {
+        tcg_gen_op_tttii(INDEX_op_lea, type, dst, base, index, sh, 0);
+    } else {
+        tcg_gen_shli(type, t, index, sh);
+        tcg_gen_add(type, dst, base, t);
+    }
+    tcg_gen_addi(type, dst, dst, imm);
+}
+
 void tcg_gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (src != dst) {
-- 
2.53.0


