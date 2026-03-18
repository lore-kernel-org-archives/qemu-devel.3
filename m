Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8622107760E
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 19:46:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2woV-0005uq-1G; Wed, 18 Mar 2026 15:44:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luisccunha8@gmail.com>)
 id 1w2w1C-0002Yh-BQ
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 14:53:22 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luisccunha8@gmail.com>)
 id 1w2w1A-00068A-HL
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 14:53:22 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4856cd3f1ffso1762615e9.3
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 11:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773859999; x=1774464799; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MgUU3ESREZdS9sq4yVbWG85T8VnRxWZzI6/tT8ASiHg=;
 b=coG49HqMrKmTA0jyUutXwe8paDbJFZ63ApvHlBJCaV9K1MINesm5pKngfDuJ3LXC7S
 sZhprDSVWOouK+JrCrfnlEhXUA0I53poT+i4S9N3fMVjhUgnr93Rjc3G5kvJiFegZCC4
 5jv2+DPTVDpxuBWzKJx6p6qVmZFVMZllKPV9i/Eo429w1Mjh3QYKuGf7IamYRZ2bhyrZ
 3FQaexRs6aW9ro0CjocBdK1V8f/WaFd44HG7U6dwvwP9JFopiGOaIxdNK366tQfwu13r
 3kazQ9BTzRoZDtFBYlMHhARtXA9p34lhxOOfZ1rWtaNO/59PPEUsvxU9h74irDeZNE3F
 GTdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773859999; x=1774464799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MgUU3ESREZdS9sq4yVbWG85T8VnRxWZzI6/tT8ASiHg=;
 b=iM8ugPS8srtJiSIS14Zcc1pRYIfcaHcAQpqLnC2JnuFtn4rPVb76CGRi37xCxsx+x3
 Gg9PFH2RIfNI+anwIQOvxVeLj1rXUqDFbu+fzAC2XY7Mi8IYjDegOydu5CUj15ozCald
 /fMIDkxff0zFWZ+VDCNd4YACa3gj5aIGM1pT/TPzs47dnUjJ6U4Bf1IbRfKRp9W1j0BS
 kYUhmLGUqwzf0Glsstyo9mqiT8NMQtOuUYfS9k3i0OeasZnryJgQ36D+rfoJnNxL22xM
 MYSSTaCWb1kDGLixJAxTbQj2SYmWMgIAROnXsawLrycllTsmLiof8euhBxQBCFBEM2+i
 iUsg==
X-Gm-Message-State: AOJu0YyZfkUr6nJxMgjDhMSee+4oSB4mR9KEZV7tR/HqcpFFhOH0OPZA
 fTRZotVowsC36SMSMG18m/xw+aM9XEtjMgdmjv9rHwaPgT3Q1cgZg81BUQaJi9kFPGY=
X-Gm-Gg: ATEYQzyrl+kjLEEJJG6Hb4q1Gg/J4aNch8KBFtvJADfDEbDtzOLoXg9Ym3jOfNiiaXe
 zYOe0qnCOeXT0cvY4xO4P3EX2Fcnia/h8I8KNXr6TlLJp5USXY4Sc4tsZFXaXseYkEUcUuZDdKl
 6oacoz91iTCR9iTpNsp0NeUO7I3MJY1sgaXlze6B1YpXWJ0XgEolE9J6jc5dlTo41Cus1pM9KAI
 PvOnhBDw8VN4rPWJu/UeSMQtf5wmZHQ/qXJNLHIIGiXhud3GoNDEcWPBOn+qMUt82EuxkCwcaow
 4Yrf1sdVbtKgoVj1OXy1YBMAK8zXyGDyx+gwtFdxThH47r+QE6yelFlvXXtrZo2JaMfVV+GQ6oB
 qEuJ7uQq99k8iMgfSA7CUJ4Js73iy1RSABXdtFU3J3ni5OdkyipvjOSdYKpsm4ooqqVT3bEG2Hk
 Is62CJHq58Dli3zJ5IzYJ4xazgvNlA3tm/xklnreG6750CMKiy8sChK+dLMl6lzi1JqstZNJ0Cb
 FcXkhlEYM3L3t/3/8mrLompxZGpZNOPVdcXsYI=
X-Received: by 2002:a05:600c:1d10:b0:485:3eba:ab96 with SMTP id
 5b1f17b1804b1-486f4421c4cmr79350895e9.3.1773859998687; 
 Wed, 18 Mar 2026 11:53:18 -0700 (PDT)
Received: from luis-IdeaPad-Flex-5-14ALC05.. ([148.69.202.102])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f8b0bc58sm16135905e9.3.2026.03.18.11.53.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 11:53:18 -0700 (PDT)
From: luisccc <luisccunha8@gmail.com>
To: qemu-devel@nongnu.org
Cc: luisccc <luisccunha8@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [RFC PATCH 3/6] target/riscv: Implement extension for Sharing
 Hardware Resources (Smpmpdeleg)
Date: Wed, 18 Mar 2026 18:52:33 +0000
Message-ID: <20260318185238.99143-4-luisccunha8@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318185238.99143-1-luisccunha8@gmail.com>
References: <20260318185238.99143-1-luisccunha8@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=luisccunha8@gmail.com; helo=mail-wm1-x336.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 target/riscv/cpu.c                |  8 ++++++++
 target/riscv/cpu.h                |  2 ++
 target/riscv/cpu_bits.h           |  2 ++
 target/riscv/cpu_cfg_fields.h.inc |  1 +
 target/riscv/csr.c                | 27 +++++++++++++++++++++++++++
 target/riscv/pmp.c                | 14 +++++++++++++-
 target/riscv/pmp.h                |  1 +
 7 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e56470a374..5383e07dbd 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -760,6 +760,14 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
     }
 
     pmp_unlock_entries(env);
+
+    /* Is SPMP enabled? */
+    if (riscv_cpu_cfg(env)->spmp) {
+        env->mpmpdeleg = MPMP_DELEG_DEFAULT;
+        env->spmp_state.num_deleg_rules = 64 - MPMP_DELEG_DEFAULT;
+
+        spmp_unlock_entries(env);
+    }
 #else
     env->priv = PRV_U;
     env->senvcfg = 0;
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index c265098324..e19c1216ea 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -179,6 +179,7 @@ extern RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[];
 #define MIN_RISCV_PMP_GRANULARITY 4
 
 #define MAX_RISCV_SPMPS (64)
+#define MPMP_DELEG_DEFAULT (64)
 
 #if !defined(CONFIG_USER_ONLY)
 #include "pmp.h"
@@ -447,6 +448,7 @@ struct CPUArchState {
 
     /* S-mode Physical Memory Protection */
     spmp_table_t spmp_state;
+    uint16_t     mpmpdeleg;
 
     /* trigger module */
     target_ulong trigger_cur;
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 9b7ab28bba..36f7c1e873 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -449,6 +449,8 @@
 #define CSR_PMPADDR62       0x3ee
 #define CSR_PMPADDR63       0x3ef
 
+#define CSR_MPMPDELEG       0x316
+
 /* RNMI */
 #define CSR_MNSCRATCH       0x740
 #define CSR_MNEPC           0x741
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index 72d417c241..772cc176d0 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -119,6 +119,7 @@ BOOL_FIELD(rvv_ta_all_1s)
 BOOL_FIELD(rvv_ma_all_1s)
 BOOL_FIELD(rvv_vl_half_avl)
 BOOL_FIELD(rvv_vsetvl_x0_vill)
+BOOL_FIELD(ext_smpmpdeleg)
 /* Named features  */
 BOOL_FIELD(ext_svade)
 BOOL_FIELD(ext_zic64b)
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 167d84d92a..4b9fa11540 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -5365,6 +5365,30 @@ static int rmw_xireg_spmp(CPURISCVState *env, int csrno,
     return 0;
 }
 
+/* S-mode Physical Memory Protection */
+static RISCVException rmw_mpmpdeleg(CPURISCVState *env, int csrno,
+                                    target_ulong *ret_val,
+                                    target_ulong new_val, target_ulong wr_mask)
+{
+    uint16_t new_mpmpdeleg = (env->mpmpdeleg & ~wr_mask) | (new_val & wr_mask);
+
+    if (ret_val) {
+        *ret_val = env->mpmpdeleg;
+    }
+
+    /*
+     * pmpnum is locked if MSECCFG_MML is set
+     * and if new_mpmpdeleg is higher than last locked rule
+     */
+    if (!(env->mseccfg & MSECCFG_MML) &&
+        (new_mpmpdeleg & 0x7F) > env->pmp_state.last_locked_rule) {
+        env->mpmpdeleg = new_mpmpdeleg & 0x7F;
+    }
+
+    env->spmp_state.num_deleg_rules = MPMP_DELEG_DEFAULT - env->mpmpdeleg;
+    return RISCV_EXCP_NONE;
+}
+
 static RISCVException read_tselect(CPURISCVState *env, int csrno,
                                    target_ulong *val)
 {
@@ -6362,6 +6386,9 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_PMPADDR63]  = { "pmpaddr63", pmp, read_pmpaddr, write_pmpaddr,
                          .min_priv_ver = PRIV_VERSION_1_12_0           },
 
+    /* S-mode Physical Memory Protection */
+    [CSR_MPMPDELEG]   = { "mpmpdeleg", spmp, NULL, NULL, rmw_mpmpdeleg },
+
     /* Debug CSRs */
     [CSR_TSELECT]   =  { "tselect",  debug, read_tselect,  write_tselect  },
     [CSR_TDATA1]    =  { "tdata1",   debug, read_tdata,    write_tdata    },
diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 3ef62d26ad..22d6f1f5b3 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -174,6 +174,12 @@ static bool pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index, uint8_t val)
                     return false;
             }
             env->pmp_state.pmp[pmp_index].cfg_reg = val;
+
+            if ((val & PMP_LOCK) &&
+                env->pmp_state.last_locked_rule < (signed int)pmp_index) {
+                env->pmp_state.last_locked_rule = pmp_index;
+            }
+
             pmp_update_rule_addr(env, pmp_index);
             return true;
         }
@@ -193,6 +199,8 @@ void pmp_unlock_entries(CPURISCVState *env)
     for (i = 0; i < pmp_num; i++) {
         env->pmp_state.pmp[i].cfg_reg &= ~(PMP_LOCK | PMP_AMATCH);
     }
+
+    env->pmp_state.last_locked_rule = -1;
 }
 
 static void pmp_decode_napot(hwaddr a, hwaddr *sa, hwaddr *ea)
@@ -385,11 +393,15 @@ bool pmp_hart_has_privs(CPURISCVState *env, hwaddr addr,
         pmp_size = size;
     }
 
+    /* If SPMP is enabled, use the MPMP delegation */
+    uint8_t max_pmp_index =
+        (riscv_cpu_cfg(env)->spmp) ? (env->mpmpdeleg & 0x7F) : pmp_regions;
+
     /*
      * 1.10 draft priv spec states there is an implicit order
      * from low to high
      */
-    for (i = 0; i < pmp_regions; i++) {
+    for (i = 0; i < max_pmp_index; i++) {
         s = pmp_is_in_range(env, i, addr);
         e = pmp_is_in_range(env, i, addr + pmp_size - 1);
 
diff --git a/target/riscv/pmp.h b/target/riscv/pmp.h
index 271cf24169..3194c6b531 100644
--- a/target/riscv/pmp.h
+++ b/target/riscv/pmp.h
@@ -63,6 +63,7 @@ typedef struct {
     pmp_entry_t pmp[MAX_RISCV_PMPS];
     pmp_addr_t  addr[MAX_RISCV_PMPS];
     uint32_t num_rules;
+    signed char last_locked_rule;
 } pmp_table_t;
 
 void pmpcfg_csr_write(CPURISCVState *env, uint32_t reg_index,
-- 
2.43.0


