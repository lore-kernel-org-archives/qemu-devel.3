Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC19AECE57B
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2024 02:28:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sn7da-0003fc-Gm; Sat, 07 Sep 2024 22:26:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sn7dY-0003ZD-VL
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 22:26:48 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sn7dX-000533-6I
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 22:26:48 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2d87f34a650so2200908a91.1
 for <qemu-devel@nongnu.org>; Sat, 07 Sep 2024 19:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725762405; x=1726367205; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pIGeU99kdWDiGBR1KxE6USqh+y8O9jN60zcDlRwe3e8=;
 b=oZt8LoTxyxCms6BNI1DsNTDdUz1tE2HztUlbF7ZAhU0QutJJi/+xlFFY6qv7CoQelZ
 +GFzcv4zLDG3Y9BZFdfrvDaiUpsf3fnV6/UStHGeGPxaSbPp5Eg4DgvOgfCIVMzvq/Jr
 FsykJlNBPorJTEIDObuDxERD6WtLJ0mDtdpcfPBHePO0SOpAWw2R7SJ+r3mPQlx1Tyrx
 48c+fWbXQY9hnigoEuMSXSKAEdNTvBInHIR+7WdMrPcKWB/zWlkzeApQoEGCcim8ZAL3
 14qTyd+D4/4yAV+QWNwDJfnsuDe0B+FgzzSd/0Cq/9kFOUHOBT3tdEYIAZ5WnoF0k4Jf
 Oudw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725762405; x=1726367205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pIGeU99kdWDiGBR1KxE6USqh+y8O9jN60zcDlRwe3e8=;
 b=L7E6cMmHa+IV+yWaC+6Ol0JSQa7ZVKeHDjS8pdS6oQIgC9SHRtuA0eQ5Ybfj0Edlut
 9chbVM11kkRbrsFNKX80tZVwazTNTWh+/DBWVrBaqrutEyUz6jhLZIUqOl4Q0+DvlfGQ
 MHknS3of7b3Pdh7iBMfmq/0446rE2EYnx5v5MJNS4vIjdJmhkcJHEdq0j7kYbxRvia3f
 dNr/qH1a6rFX5MNqK3F8p7m60F7sJ8xSYqI/jO6nDa312Lp8AbV5AZWAcufJN/KP9Lh1
 MDYr4WfA8CtqgZeqKR4ci8Lh9RwKmvan3kNAcUiXShzMGKHxL5BiDDYVPAhIrYEjk5A6
 +kzQ==
X-Gm-Message-State: AOJu0Yxv9Fod/b6xpeMZ2Icuo6f7BskXKm8ZUtbeesF71bn+2aQ3dlNl
 HrMF0sVMtL/Up/hDEHhJhxYS1nazZWMP95b8ME2e6JTxh02Jj+jpwSNef75NBW+GMgL8/dlzYZb
 m
X-Google-Smtp-Source: AGHT+IEvOOFA+fL2q+Z/JXJP/ZVVW0sv1v+INMjkuvbwp/v7Cpjkv+Dp+uFPszi+KNqCmqkqwbkmTQ==
X-Received: by 2002:a17:90a:c296:b0:2da:88b3:cff8 with SMTP id
 98e67ed59e1d1-2dad50281b4mr11244110a91.6.1725762405078; 
 Sat, 07 Sep 2024 19:26:45 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2dadbfe46d4sm4084019a91.1.2024.09.07.19.26.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Sep 2024 19:26:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: zhiwei_liu@linux.alibaba.com, tangtiancheng.ttc@alibaba-inc.com,
 liwei1518@gmail.com, bmeng.cn@gmail.com
Subject: [PATCH 10/12] tcg/i386: Implement cmp_vec with avx512 insns
Date: Sat,  7 Sep 2024 19:26:30 -0700
Message-ID: <20240908022632.459477-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240908022632.459477-1-richard.henderson@linaro.org>
References: <20240908022632.459477-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

The sse/avx instruction set only has EQ and GT as direct comparisons.
Other signed comparisons can be generated from swapping and inversion.
However unsigned comparisons are not available and must be transformed
to signed comparisons by biasing the inputs.

The avx512 instruction set has a complete set of comparisons, with
results placed into a predicate register.  We can produce the normal
cmp_vec result by using VPMOVM2*.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 64 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 63 insertions(+), 1 deletion(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index c63c3faed8..839384885b 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -413,6 +413,14 @@ static bool tcg_target_const_match(int64_t val, int ct,
 #define OPC_UD2         (0x0b | P_EXT)
 #define OPC_VPBLENDD    (0x02 | P_EXT3A | P_DATA16)
 #define OPC_VPBLENDVB   (0x4c | P_EXT3A | P_DATA16)
+#define OPC_VPCMPB      (0x3f | P_EXT3A | P_DATA16 | P_EVEX)
+#define OPC_VPCMPUB     (0x3e | P_EXT3A | P_DATA16 | P_EVEX)
+#define OPC_VPCMPW      (0x3f | P_EXT3A | P_DATA16 | P_VEXW | P_EVEX)
+#define OPC_VPCMPUW     (0x3e | P_EXT3A | P_DATA16 | P_VEXW | P_EVEX)
+#define OPC_VPCMPD      (0x1f | P_EXT3A | P_DATA16 | P_EVEX)
+#define OPC_VPCMPUD     (0x1e | P_EXT3A | P_DATA16 | P_EVEX)
+#define OPC_VPCMPQ      (0x1f | P_EXT3A | P_DATA16 | P_VEXW | P_EVEX)
+#define OPC_VPCMPUQ     (0x1e | P_EXT3A | P_DATA16 | P_VEXW | P_EVEX)
 #define OPC_VPINSRB     (0x20 | P_EXT3A | P_DATA16)
 #define OPC_VPINSRW     (0xc4 | P_EXT | P_DATA16)
 #define OPC_VBROADCASTSS (0x18 | P_EXT38 | P_DATA16)
@@ -421,6 +429,10 @@ static bool tcg_target_const_match(int64_t val, int ct,
 #define OPC_VPBROADCASTW (0x79 | P_EXT38 | P_DATA16)
 #define OPC_VPBROADCASTD (0x58 | P_EXT38 | P_DATA16)
 #define OPC_VPBROADCASTQ (0x59 | P_EXT38 | P_DATA16)
+#define OPC_VPMOVM2B    (0x28 | P_EXT38 | P_SIMDF3 | P_EVEX)
+#define OPC_VPMOVM2W    (0x28 | P_EXT38 | P_SIMDF3 | P_VEXW | P_EVEX)
+#define OPC_VPMOVM2D    (0x38 | P_EXT38 | P_SIMDF3 | P_EVEX)
+#define OPC_VPMOVM2Q    (0x38 | P_EXT38 | P_SIMDF3 | P_VEXW | P_EVEX)
 #define OPC_VPERMQ      (0x00 | P_EXT3A | P_DATA16 | P_VEXW)
 #define OPC_VPERM2I128  (0x46 | P_EXT3A | P_DATA16 | P_VEXL)
 #define OPC_VPROLVD     (0x15 | P_EXT38 | P_DATA16 | P_EVEX)
@@ -3110,9 +3122,59 @@ static bool tcg_out_cmp_vec_noinv(TCGContext *s, TCGType type, unsigned vece,
     return fixup & NEED_INV;
 }
 
+static void tcg_out_cmp_vec_k1(TCGContext *s, TCGType type, unsigned vece,
+                               TCGReg v1, TCGReg v2, TCGCond cond)
+{
+    static const int cmpm_insn[2][4] = {
+        { OPC_VPCMPB, OPC_VPCMPW, OPC_VPCMPD, OPC_VPCMPQ },
+        { OPC_VPCMPUB, OPC_VPCMPUW, OPC_VPCMPUD, OPC_VPCMPUQ }
+    };
+    static const int cond_ext[16] = {
+        [TCG_COND_EQ] = 0,
+        [TCG_COND_NE] = 4,
+        [TCG_COND_LT] = 1,
+        [TCG_COND_LTU] = 1,
+        [TCG_COND_LE] = 2,
+        [TCG_COND_LEU] = 2,
+        [TCG_COND_NEVER] = 3,
+        [TCG_COND_GE] = 5,
+        [TCG_COND_GEU] = 5,
+        [TCG_COND_GT] = 6,
+        [TCG_COND_GTU] = 6,
+        [TCG_COND_ALWAYS] = 7,
+    };
+
+    tcg_out_vex_modrm_type(s, cmpm_insn[is_unsigned_cond(cond)][vece],
+                           /* k1 */ 1, v1, v2, type);
+    tcg_out8(s, cond_ext[cond]);
+}
+
+static void tcg_out_k1_to_vec(TCGContext *s, TCGType type,
+                              unsigned vece, TCGReg dest)
+{
+    static const int movm_insn[] = {
+        OPC_VPMOVM2B, OPC_VPMOVM2W, OPC_VPMOVM2D, OPC_VPMOVM2Q
+    };
+    tcg_out_vex_modrm_type(s, movm_insn[vece], dest, 0, /* k1 */ 1, type);
+}
+
 static void tcg_out_cmp_vec(TCGContext *s, TCGType type, unsigned vece,
                             TCGReg v0, TCGReg v1, TCGReg v2, TCGCond cond)
 {
+    /*
+     * With avx512, we have a complete set of comparisons into mask.
+     * Unless there's a single insn expansion for the comparision,
+     * expand via a mask in k1.
+     */
+    if ((vece <= MO_16 ? have_avx512bw : have_avx512dq)
+        && cond != TCG_COND_EQ
+        && cond != TCG_COND_LT
+        && cond != TCG_COND_GT) {
+        tcg_out_cmp_vec_k1(s, type, vece, v1, v2, cond);
+        tcg_out_k1_to_vec(s, type, vece, v0);
+        return;
+    }
+
     if (tcg_out_cmp_vec_noinv(s, type, vece, v0, v1, v2, cond)) {
         tcg_out_dupi_vec(s, type, vece, TCG_TMP_VEC, -1);
         tcg_out_vex_modrm_type(s, OPC_PXOR, v0, v0, TCG_TMP_VEC, type);
@@ -4080,7 +4142,7 @@ static TCGCond expand_vec_cond(TCGType type, unsigned vece,
      * We must bias the inputs so that they become signed.
      * All other swapping and inversion are handled during code generation.
      */
-    if (vece == MO_64 && is_unsigned_cond(cond)) {
+    if (vece == MO_64 && !have_avx512dq && is_unsigned_cond(cond)) {
         TCGv_vec v1 = temp_tcgv_vec(arg_temp(*a1));
         TCGv_vec v2 = temp_tcgv_vec(arg_temp(*a2));
         TCGv_vec t1 = tcg_temp_new_vec(type);
-- 
2.43.0


