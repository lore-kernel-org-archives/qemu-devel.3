Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3940C98315
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 22:06:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhauS-0005tN-1e; Sun, 18 Jan 2026 17:06:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhau6-0004o3-6j
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:05:50 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhau3-0000xf-N9
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:05:49 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2a0833b5aeeso37526925ad.1
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 14:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768773946; x=1769378746; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=85REHlkWJDtWsilQDfbxqyO96MGCDiDn4G3cKbUWWrA=;
 b=aoWiqvMPahZmYcfY5uWL7HMtIC9A+c5N0VXmi5pwnzVFoWqBKUkvC5kH4ZssFihSk7
 tGccM5cXXv7sd05pvqPLnPMxhGG8HMvMmEYley8YNtMmE76sSuop+10uVDSQAvVxzKTX
 RbDuWG/UrAS/X4lG2qnifkKDJA1CJX6zFYPT/4TUcC7CW6J5ULP8iePoIyMpre7+0pbQ
 QJ6npJ7Nt0gtSXBlZhW7AjAwUeRXhAtCYy0tQJrx8EoQAlRpSYpq3K2H9WjXt9k9OsnO
 Z39CnrDywR0uMkJPLtytFcO8yAakjRXtipa9dthPF/L9nQ839D9OKi+tPVWPcfGG8NjT
 d9+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768773946; x=1769378746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=85REHlkWJDtWsilQDfbxqyO96MGCDiDn4G3cKbUWWrA=;
 b=TUf9Gq/DZkH2mOfe44zhNTCXCUH2Bu8Nya+GXuqmF0a8htx0XH3Ac+JfmX172H7Z/l
 hk2fEiVR61dcwL/jvzbAgnpDbmc2F4KeAIco3CNcyYbnov/6iHkL7zLF66ARcC3IVmFh
 n7YuDDJv2qa8X7xxGFpoWm9CO/+gGiyqaxWDI9myHQ7E/O5LqBmSnh/FInSXslL5teuC
 ZTpgimX1cNH2JSGrFdVmfSfqkPqbOvG7OFIg/yOPM7urp4VQ8P9lMAlyk3QApEBkcyj1
 h5VW0ZdyoeRYajmM5gmtbsUeyrkj2NFfFJVuLtP//XkonM7ln0MFYkaq5RjityzvevYj
 3EHA==
X-Gm-Message-State: AOJu0Yz1oRUdQ0vvjbwpuwR7EFj4PECCJW/0LyauoymZL+ArfZEi6zcB
 8718ojqqX+VxKNsv3gaLWSlAiQMY8hgCKRhyFl4KIz8tuDAI3GOSYoW9QJGTsh6ZQF1TKOe3bn1
 dceAwGuj6Nw==
X-Gm-Gg: AY/fxX7+UHI3fGHjn1nIGtmyqPAGWhVw/eHp4DJ+vKReZrOJPQiIHmMOHqys2HR3Qg0
 i7kftKDy+KHhYxRluRI7CTUbyiYY8uhTDrl8WHcL4AogfySM6GDA9HUEN2kT1gMeBKjJUKwU/PY
 fZKBDm+PGvMoA3FgsSXDjUkLTawaTffhfWEiY/kjr7vx3ULWoC8gQqX9Y38V9RNMNKCF53e3reF
 Jde05cik29Qn5Am+IUtdud6OOnby5yC7nVPkaADGRyWeFPjlzRWUbxontlTj23WXnnNAK1dLYgq
 gZMnfo3V8QFrBQD3m+//xHXLUakx4YId1sUnCNjeIDVwDY+aEr7JMg9YIr/2wvDv3hQAEllc4QK
 X5dw3V9Sm9UR2Lk2r/uXmC9MJA2EECeLyurrEozTh3bolXLpnJuOsMGJ6CQAggUottCZ3sUz7PL
 jzubsioxNIfuO3UqQFrg==
X-Received: by 2002:a17:902:d48e:b0:2a5:8ee5:2981 with SMTP id
 d9443c01a7336-2a7188f954fmr81999215ad.32.1768773945882; 
 Sun, 18 Jan 2026 14:05:45 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7193dbb74sm74402865ad.56.2026.01.18.14.05.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 14:05:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 36/54] target/riscv: Drop TCG_TARGET_REG_BITS test
Date: Mon, 19 Jan 2026 09:03:56 +1100
Message-ID: <20260118220414.8177-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260118220414.8177-1-richard.henderson@linaro.org>
References: <20260118220414.8177-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 54 ++++++-------------------
 1 file changed, 13 insertions(+), 41 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index caefd38216..4df9a40b44 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -1181,60 +1181,32 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
      * Update vstart with the number of processed elements.
      * Use the helper function if either:
      * - vstart is not 0.
-     * - the target has 32 bit registers and we are loading/storing 64 bit long
-     *   elements. This is to ensure that we process every element with a single
-     *   memory instruction.
      */
 
-    bool use_helper_fn = !(s->vstart_eq_zero) ||
-                          (TCG_TARGET_REG_BITS == 32 && log2_esz == 3);
+    bool use_helper_fn = !s->vstart_eq_zero;
 
     if (!use_helper_fn) {
-        TCGv addr = tcg_temp_new();
         uint32_t size = s->cfg_ptr->vlenb * nf;
         TCGv_i64 t8 = tcg_temp_new_i64();
-        TCGv_i32 t4 = tcg_temp_new_i32();
         MemOp atomicity = MO_ATOM_NONE;
         if (log2_esz == 0) {
             atomicity = MO_ATOM_NONE;
         } else {
             atomicity = MO_ATOM_IFALIGN_PAIR;
         }
-        if (TCG_TARGET_REG_BITS == 64) {
-            for (int i = 0; i < size; i += 8) {
-                addr = get_address(s, rs1, i);
-                if (is_load) {
-                    tcg_gen_qemu_ld_i64(t8, addr, s->mem_idx,
-                            MO_LE | MO_64 | atomicity);
-                    tcg_gen_st_i64(t8, tcg_env, vreg_ofs(s, vd) + i);
-                } else {
-                    tcg_gen_ld_i64(t8, tcg_env, vreg_ofs(s, vd) + i);
-                    tcg_gen_qemu_st_i64(t8, addr, s->mem_idx,
-                            MO_LE | MO_64 | atomicity);
-                }
-                if (i == size - 8) {
-                    tcg_gen_movi_tl(cpu_vstart, 0);
-                } else {
-                    tcg_gen_addi_tl(cpu_vstart, cpu_vstart, 8 >> log2_esz);
-                }
+        for (int i = 0; i < size; i += 8) {
+            TCGv addr = get_address(s, rs1, i);
+            if (is_load) {
+                tcg_gen_qemu_ld_i64(t8, addr, s->mem_idx, MO_LEUQ | atomicity);
+                tcg_gen_st_i64(t8, tcg_env, vreg_ofs(s, vd) + i);
+            } else {
+                tcg_gen_ld_i64(t8, tcg_env, vreg_ofs(s, vd) + i);
+                tcg_gen_qemu_st_i64(t8, addr, s->mem_idx, MO_LEUQ | atomicity);
             }
-        } else {
-            for (int i = 0; i < size; i += 4) {
-                addr = get_address(s, rs1, i);
-                if (is_load) {
-                    tcg_gen_qemu_ld_i32(t4, addr, s->mem_idx,
-                            MO_LE | MO_32 | atomicity);
-                    tcg_gen_st_i32(t4, tcg_env, vreg_ofs(s, vd) + i);
-                } else {
-                    tcg_gen_ld_i32(t4, tcg_env, vreg_ofs(s, vd) + i);
-                    tcg_gen_qemu_st_i32(t4, addr, s->mem_idx,
-                            MO_LE | MO_32 | atomicity);
-                }
-                if (i == size - 4) {
-                    tcg_gen_movi_tl(cpu_vstart, 0);
-                } else {
-                    tcg_gen_addi_tl(cpu_vstart, cpu_vstart, 4 >> log2_esz);
-                }
+            if (i == size - 8) {
+                tcg_gen_movi_tl(cpu_vstart, 0);
+            } else {
+                tcg_gen_addi_tl(cpu_vstart, cpu_vstart, 8 >> log2_esz);
             }
         }
     } else {
-- 
2.43.0


