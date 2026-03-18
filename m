Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0737B107760E
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 19:45:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2woY-0005vu-Hy; Wed, 18 Mar 2026 15:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luisccunha8@gmail.com>)
 id 1w2w1J-0002Zd-R2
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 14:53:31 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luisccunha8@gmail.com>)
 id 1w2w1H-0006B1-VG
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 14:53:29 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4856cd3f1ffso1763495e9.3
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 11:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773860006; x=1774464806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vqGv6FVLTonOExL81okKQ24PXUVEVEL0h321keC4CZ8=;
 b=O0eWkqFp2ZHbl4AoLGXk/neo0uX28hUgTdXDwJpmDoBbqZCiaw4y0mukMCOqM3DwHQ
 +0BFPHqL9iekURaCmhu9Y9kV+1lOgSBcGKTqYlanz8ruPEK8OJGuB981jkBdykKRm+b+
 lDM4NEFzhzteNVjnB+eOVYCiGtEGaZL3yJYPuVaFPDXRyIHQqgz9kesThOgs9QvVzkQ9
 KAOF9wuOXfYpbu90Pk1lWC1nZi7lBMfvmMppvjm9HFEkK1jPVvwO8bdyVJQ0w15pdlrC
 8oVUGmcOockt/ym9Svz4Z73uLf2KUfjaO12j+rxiGZUznm2mBfeIQ6+UxDwFb3VrP7bT
 ZwiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773860006; x=1774464806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vqGv6FVLTonOExL81okKQ24PXUVEVEL0h321keC4CZ8=;
 b=OnMqJMvJJmBWHloDJt2x0HDmos9tVbuviFC0p5ALcoPX4/8hJeldE13U/XS44DIK/y
 XSci7XcfMK21xJGeU9nyRp6dG1DPWW/T1YPXcISHxdOMZvjcJcJSDedksn4yEDCUrFZs
 5GnJha+9zt3/KpjyXXK8jCi4vtHVt+x29JjkrAY9b1w2G/+YCFnfbtE8G0jYH9Mw7Yy/
 DDwzd45oAj7W6OIOWucQU9Pq8z7fkwYGvbwxGEFCHDKseKOj+ofqS588o1yDDlKZYR2+
 JnmhZKEa0qVD2AJnM3YKZ6ayf+e1YS0mYtzoL5aUPsDibSdZziM5j8aFeO1yRFpC7onD
 tCWA==
X-Gm-Message-State: AOJu0YxE48EPUd+WeYD2Gmw6EhSki4LK8c5WUAULlOezO28R9ypEITMv
 MpxvC5iu4zM1NOEkwZo/wWDXrinNkFJU/3hLQKcOcYfLqi7N1uy2h3AivVXBai3zxdc=
X-Gm-Gg: ATEYQzyyCDoImRAZJw6/JZEqMEU3tVhqz0v3IkZmkdErcnWoL1ySOwolaCfMkaRNVu5
 HFq+wY57Ox/Z7BsBwtH7dGJJi8x0QrWaZ8y87ZWo/4XR1czHeRv9J+7FflHp09LzEHIbxwmGYg+
 YO30zM0KpSlmnLWqxm9Ob63D8zwAdExt47K0ywygLG93uKTcnG73PFwAqGkQ3O125K3lHJULjoz
 /LeN+9HD5EtCmd/JP3N4na7WFukdTvHdsWqF+sXhybG4M9krf2KUPqCSp2IceKpfmussHUPWQRM
 k/ZG8sJ6UeCzl6VKOt4kLj6HB8YZZwBen/EB7g3vQva57NXWTsxfSVjZnaR/BZPA+QgxZ6NRhYg
 xKDUREEsOkmtUDW/IhLfhKSPX5+tg/+t/rzuvRwCZS30sjZ0VL2pvm0xV1/FpPzVVHKDwgVgzRH
 LTjSavMC+3Lg4ugcYMNK/C1UhRatgTP6GFpICRIPAOeO2HUAaIie1LBBkjkSCQp1dgj0uXtYT3B
 FU4prIy6RAehGngYv0Jnea2VMNT/NGOj+Uzk/c=
X-Received: by 2002:a05:600c:3f14:b0:486:f8d6:5dea with SMTP id
 5b1f17b1804b1-486f8d65df5mr7046805e9.19.1773860006159; 
 Wed, 18 Mar 2026 11:53:26 -0700 (PDT)
Received: from luis-IdeaPad-Flex-5-14ALC05.. ([148.69.202.102])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f8b0bc58sm16135905e9.3.2026.03.18.11.53.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 11:53:25 -0700 (PDT)
From: luisccc <luisccunha8@gmail.com>
To: qemu-devel@nongnu.org
Cc: luisccc <luisccunha8@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [RFC PATCH 4/6] target/riscv: Implement extension for Optimizing
 Context Switching (Sspmpen)
Date: Wed, 18 Mar 2026 18:52:34 +0000
Message-ID: <20260318185238.99143-5-luisccunha8@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318185238.99143-1-luisccunha8@gmail.com>
References: <20260318185238.99143-1-luisccunha8@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=luisccunha8@gmail.com; helo=mail-wm1-x333.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 18 Mar 2026 15:44:18 -0400
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

Signed-off-by: Luis Cunha <luisccunha8@gmail.com>
---
 target/riscv/cpu_bits.h           |  4 ++
 target/riscv/cpu_cfg_fields.h.inc |  1 +
 target/riscv/csr.c                | 67 +++++++++++++++++++++++++++++++
 target/riscv/spmp.c               |  6 ++-
 4 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 36f7c1e873..0a8cfedc5d 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -255,6 +255,10 @@
 #define CSR_SCTRSTATUS      0x14f
 #define CSR_SCTRDEPTH       0x15f
 
+/* S-mode Physical Memory Protection (SPMP) */
+#define CSR_SPMPEN          0x183
+#define CSR_SPMPENH         0x193
+
 /* VS-Level Control transfer records CSRs */
 #define CSR_VSCTRCTL        0x24e
 
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index 772cc176d0..88edac21ca 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -120,6 +120,7 @@ BOOL_FIELD(rvv_ma_all_1s)
 BOOL_FIELD(rvv_vl_half_avl)
 BOOL_FIELD(rvv_vsetvl_x0_vill)
 BOOL_FIELD(ext_smpmpdeleg)
+BOOL_FIELD(ext_sspmpen)
 /* Named features  */
 BOOL_FIELD(ext_svade)
 BOOL_FIELD(ext_zic64b)
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 4b9fa11540..a11d7e6704 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -769,6 +769,16 @@ static RISCVException spmp(CPURISCVState *env, int csrno)
     return smode(env, csrno);
 }
 
+static RISCVException sspmpen(CPURISCVState *env, int csrno)
+{
+    if (!riscv_cpu_cfg(env)->ext_sspmpen) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    /* SSPMPEN can only exist, if spmp exists */
+    return spmp(env, csrno);
+}
+
 static RISCVException have_mseccfg(CPURISCVState *env, int csrno)
 {
     if (riscv_cpu_cfg(env)->ext_smepmp) {
@@ -5389,6 +5399,61 @@ static RISCVException rmw_mpmpdeleg(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+static RISCVException rmw_spmpen64(CPURISCVState *env, int csrno,
+                                    uint64_t *ret_val,
+                                    uint64_t new_val, uint64_t wr_mask)
+{
+    uint64_t new_spmpen = (env->spmp_state.spmpen & ~wr_mask) |
+                            (new_val & wr_mask);
+
+    if (env->spmp_state.num_deleg_rules == 0) {
+        if (ret_val) {
+            *ret_val = 0;
+        }
+
+        return RISCV_EXCP_NONE;
+    }
+
+    if (ret_val) {
+        *ret_val = env->spmp_state.spmpen;
+    }
+
+    sspmpen_csr_write(env, new_spmpen);
+
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException rmw_spmpen(CPURISCVState *env, int csrno,
+                                  target_ulong *ret_val,
+                                  target_ulong new_val, target_ulong wr_mask)
+{
+    uint64_t rval = 0;
+    RISCVException ret;
+    ret = rmw_spmpen64(env, csrno, &rval, new_val, wr_mask);
+    if (ret_val) {
+        *ret_val = rval;
+    }
+
+    return ret;
+}
+
+static RISCVException rmw_spmpenh(CPURISCVState *env, int csrno,
+                                   target_ulong *ret_val,
+                                   target_ulong new_val,
+                                   target_ulong wr_mask)
+{
+    uint64_t rval = 0;
+    RISCVException ret;
+
+    ret = rmw_spmpen64(env, csrno, &rval,
+        ((uint64_t)new_val) << 32, ((uint64_t)wr_mask) << 32);
+    if (ret_val) {
+        *ret_val = rval >> 32;
+    }
+
+    return ret;
+}
+
 static RISCVException read_tselect(CPURISCVState *env, int csrno,
                                    target_ulong *val)
 {
@@ -6388,6 +6453,8 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
 
     /* S-mode Physical Memory Protection */
     [CSR_MPMPDELEG]   = { "mpmpdeleg", spmp, NULL, NULL, rmw_mpmpdeleg },
+    [CSR_SPMPEN]  = { "spmpen", sspmpen, NULL, NULL, rmw_spmpen },
+    [CSR_SPMPENH] = { "spmpenh", sspmpen, NULL, NULL, rmw_spmpenh },
 
     /* Debug CSRs */
     [CSR_TSELECT]   =  { "tselect",  debug, read_tselect,  write_tselect  },
diff --git a/target/riscv/spmp.c b/target/riscv/spmp.c
index 85c5259b33..1615c207df 100644
--- a/target/riscv/spmp.c
+++ b/target/riscv/spmp.c
@@ -147,7 +147,11 @@ static uint8_t spmp_is_in_range(CPURISCVState *env, int spmp_index,
 
 static bool spmp_get_spmpen_bit(CPURISCVState *env, int index)
 {
-    return true;
+    if (!riscv_cpu_cfg(env)->ext_sspmpen) {
+        return true;
+    }
+
+    return (env->spmp_state.spmpen >> index) & 0x1;
 }
 
 /*
-- 
2.43.0


