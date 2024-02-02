Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76CE6C4828E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 10:17:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVqZa-0001Mj-Uk; Fri, 02 Feb 2024 05:15:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1rVqZY-0001Lw-Bz; Fri, 02 Feb 2024 05:15:00 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1rVqZW-00044I-Ih; Fri, 02 Feb 2024 05:15:00 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a26ed1e05c7so280905366b.2; 
 Fri, 02 Feb 2024 02:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706868897; x=1707473697; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Ry9PYc6sMm5TnaA8Q8rZF9TTTMN6jBPA3BQkVRB0OM=;
 b=Pa7paSoDt1yFbslX/9vcQco3j149w3aWZzIPMOJQOr8RjxH/Hyr9l8+jmZrd51vEQO
 VcM1yR3eBzXCiNmj2h8icoBJQTPXC+zQuEMJ8r84W8Ee/VpE0gR1J4UbEXg/G2ssYC0p
 YpSFnymOzGZvh9EHIWg9JFp1K5B3g5Rox7/tBP4K0lyZrXxyi1TAJyh3RNGhPal5zN79
 i97tgG0N45LnM3LiSVwzGMNJhkK1G0arDBG8et4OfKHnqH1MckopG+k4asHSwsa17tdy
 LPBQPpd2rD+JsozPowIWjjMb56BZK8ZlZyRdjny5D/ssIC/ktNY/1hyGOQ/dV6PZWKhx
 KEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706868897; x=1707473697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Ry9PYc6sMm5TnaA8Q8rZF9TTTMN6jBPA3BQkVRB0OM=;
 b=NyhoUN7XEnq+89ndJQLSd/3ZUFVZ2r2d1CJmL0WCWccWTaPBTENPoKplIW2Zi3sA/+
 vTqre44EFS+HYxTi59bWGyuAVE/k4tJhIyrqJKpE3r/zjHifGs/vR7/QEghr69Y4MxDB
 jUiF7YIYj2IoJ5sjYZ/tikXNtaouplZLIKYvGBRFDf17W2dbNgbvrqjlZdI8vYQ9PAtP
 YQN046yKY89GWHIrrC0MBYn60le347KNfKyxXy/OG/AHgUGzYjYnytr1lnoH50pfwvn8
 vikhO5QxqZiWxR2sjrmhMTG5FnOj4GTP+RkJ8HVTzUZEf1aYAcZbGVWp46MsTEMWnSWb
 ZBOQ==
X-Gm-Message-State: AOJu0Yyt/wYFyt461Z3fkfOdXBNcrndZgwRVQo3WVh0tNJk26JTDJ79J
 tX9CT5ZLCZUwNgTn3H768x3UWzYlZMakncyzE58e/54EuxU8r68g
X-Google-Smtp-Source: AGHT+IGqkM5eUgoYRIeBgr1BGw2D83Qay6tr6Qp26JpNszdrP1ssZ711DjiTaFymyHndAgF4Yb4JFw==
X-Received: by 2002:a17:906:cecc:b0:a36:5b1c:fb4b with SMTP id
 si12-20020a170906cecc00b00a365b1cfb4bmr3564722ejb.13.1706868896412; 
 Fri, 02 Feb 2024 02:14:56 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUY81vYDPXiAMETeMf3GJo69ce41Fyny+ASRDoEvTUdnZxtGsdUOLTirpilQxpCLIdIRC0iRnKw7ft6XQtuICxKfSxm4YZoyfQbk3/C3cnY8XYJvQXaER5eB0KpaQW1kQedZV9RTEuADMRytuglf8fXe0QUv6TXpgrL4zn8kxScfBeDw59oAcr26W3aOJ3rHCQva7uQMsBvHV3/6jCHU6H2VI/g1JHz4KgHQNftj7Lh/WQ2Tabwl2bz70QqD4wlTp2TzJS5oF5NhMRei6MjV6neJ8K8VG6FsubMb7m6c6kbLYFYaBVAGG4lY9aRAAZ007MUz0kXPakPSn4OD8g3VpJDu5r9WG10vIUwRH3XqqmnejdtMGrDN/wvIeg=
Received: from freya.midgard (broadband-188-255-126-251.ip.moscow.rt.ru.
 [188.255.126.251]) by smtp.gmail.com with ESMTPSA id
 ll5-20020a170907190500b00a36fe6fe976sm579722ejc.190.2024.02.02.02.14.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 02:14:55 -0800 (PST)
From: Alexey Baturo <baturo.alexey@gmail.com>
X-Google-Original-From: Alexey Baturo <me@deliversmonkey.space>
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, Alistair.Francis@wdc.com,
 sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v7 2/6] target/riscv: Add new CSR fields for S{sn, mn,
 m}pm extensions as part of Zjpm v0.8
Date: Fri,  2 Feb 2024 10:14:35 +0000
Message-Id: <20240202101439.3714106-3-me@deliversmonkey.space>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202101439.3714106-1-me@deliversmonkey.space>
References: <20240202101439.3714106-1-me@deliversmonkey.space>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=baturo.alexey@gmail.com; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Alexey Baturo <baturo.alexey@gmail.com>

Signed-off-by: Alexey Baturo <baturo.alexey@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h      |  8 ++++++++
 target/riscv/cpu_bits.h |  3 +++
 target/riscv/cpu_cfg.h  |  3 +++
 target/riscv/csr.c      | 11 +++++++++++
 target/riscv/machine.c  | 10 +++++++---
 target/riscv/pmp.c      | 13 ++++++++++---
 target/riscv/pmp.h      | 11 ++++++-----
 7 files changed, 48 insertions(+), 11 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index c64ed19741..4c0d7142a5 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -122,6 +122,14 @@ typedef enum {
     EXT_STATUS_DIRTY,
 } RISCVExtStatus;
 
+/* Enum holds PMM field values for Zjpm v0.8 extension */
+typedef enum {
+    PMM_FIELD_DISABLED = 0,
+    PMM_FIELD_RESERVED = 1,
+    PMM_FIELD_PMLEN7   = 2,
+    PMM_FIELD_PMLEN16  = 3,
+} RISCVPmPmm;
+
 #define MMU_USER_IDX 3
 
 #define MAX_RISCV_PMPS (16)
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 4d8e7ea0d5..5b7ab71e5f 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -716,6 +716,7 @@ typedef enum RISCVException {
 #define MENVCFG_CBIE                       (3UL << 4)
 #define MENVCFG_CBCFE                      BIT(6)
 #define MENVCFG_CBZE                       BIT(7)
+#define MENVCFG_PMM                        (3ULL << 32)
 #define MENVCFG_ADUE                       (1ULL << 61)
 #define MENVCFG_PBMTE                      (1ULL << 62)
 #define MENVCFG_STCE                       (1ULL << 63)
@@ -729,11 +730,13 @@ typedef enum RISCVException {
 #define SENVCFG_CBIE                       MENVCFG_CBIE
 #define SENVCFG_CBCFE                      MENVCFG_CBCFE
 #define SENVCFG_CBZE                       MENVCFG_CBZE
+#define SENVCFG_PMM                        MENVCFG_PMM
 
 #define HENVCFG_FIOM                       MENVCFG_FIOM
 #define HENVCFG_CBIE                       MENVCFG_CBIE
 #define HENVCFG_CBCFE                      MENVCFG_CBCFE
 #define HENVCFG_CBZE                       MENVCFG_CBZE
+#define HENVCFG_PMM                        MENVCFG_PMM
 #define HENVCFG_ADUE                       MENVCFG_ADUE
 #define HENVCFG_PBMTE                      MENVCFG_PBMTE
 #define HENVCFG_STCE                       MENVCFG_STCE
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index e241922f89..9e5a089894 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -115,6 +115,9 @@ struct RISCVCPUConfig {
     bool ext_ssaia;
     bool ext_sscofpmf;
     bool ext_smepmp;
+    bool ext_ssnpm;
+    bool ext_smnpm;
+    bool ext_smmpm;
     bool rvv_ta_all_1s;
     bool rvv_ma_all_1s;
     bool svade;
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 32a40f2365..431dc4ac1e 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -530,6 +530,9 @@ static RISCVException have_mseccfg(CPURISCVState *env, int csrno)
     if (riscv_cpu_cfg(env)->ext_zkr) {
         return RISCV_EXCP_NONE;
     }
+    if (riscv_cpu_cfg(env)->ext_smmpm) {
+        return RISCV_EXCP_NONE;
+    }
 
     return RISCV_EXCP_ILLEGAL_INST;
 }
@@ -2036,6 +2039,10 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
                 (cfg->ext_sstc ? MENVCFG_STCE : 0) |
                 (cfg->ext_svadu ? MENVCFG_ADUE : 0);
     }
+    /* Update PMM field only if the value is valid according to Zjpm v0.8 */
+    if (((val & MENVCFG_PMM) >> 32) != PMM_FIELD_RESERVED) {
+        mask |= MENVCFG_PMM;
+    }
     env->menvcfg = (env->menvcfg & ~mask) | (val & mask);
 
     return RISCV_EXCP_NONE;
@@ -2080,6 +2087,10 @@ static RISCVException write_senvcfg(CPURISCVState *env, int csrno,
                                     target_ulong val)
 {
     uint64_t mask = SENVCFG_FIOM | SENVCFG_CBIE | SENVCFG_CBCFE | SENVCFG_CBZE;
+    /* Update PMM field only if the value is valid according to Zjpm v0.8 */
+    if (((val & SENVCFG_PMM) >> 32) != PMM_FIELD_RESERVED) {
+        mask |= SENVCFG_PMM;
+    }
     RISCVException ret;
 
     ret = smstateen_acc_ok(env, 0, SMSTATEEN0_HSENVCFG);
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 9c71a1a22f..75dec28587 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -152,15 +152,19 @@ static const VMStateDescription vmstate_vector = {
 
 static bool pointermasking_needed(void *opaque)
 {
-    return false;
+    RISCVCPU *cpu = opaque;
+    return cpu->cfg.ext_ssnpm || cpu->cfg.ext_smnpm || cpu->cfg.ext_smmpm;
 }
 
 static const VMStateDescription vmstate_pointermasking = {
     .name = "cpu/pointer_masking",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .needed = pointermasking_needed,
     .fields = (const VMStateField[]) {
+        VMSTATE_UINTTL(env.mseccfg, RISCVCPU),
+        VMSTATE_UINTTL(env.senvcfg, RISCVCPU),
+        VMSTATE_UINTTL(env.menvcfg, RISCVCPU),
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 2a76b611a0..7ddb9dbf0b 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -574,6 +574,12 @@ target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index)
 void mseccfg_csr_write(CPURISCVState *env, target_ulong val)
 {
     int i;
+    uint64_t mask = MSECCFG_MMWP | MSECCFG_MML;
+
+    /* Update PMM field only if the value is valid according to Zjpm v0.8 */
+    if (((val & MSECCFG_PMM) >> 32) != PMM_FIELD_RESERVED) {
+        mask |= MSECCFG_PMM;
+    }
 
     trace_mseccfg_csr_write(env->mhartid, val);
 
@@ -589,12 +595,13 @@ void mseccfg_csr_write(CPURISCVState *env, target_ulong val)
 
     if (riscv_cpu_cfg(env)->ext_smepmp) {
         /* Sticky bits */
-        val |= (env->mseccfg & (MSECCFG_MMWP | MSECCFG_MML));
-        if ((val ^ env->mseccfg) & (MSECCFG_MMWP | MSECCFG_MML)) {
+        val |= (env->mseccfg & mask);
+        if ((val ^ env->mseccfg) & mask) {
             tlb_flush(env_cpu(env));
         }
     } else {
-        val &= ~(MSECCFG_MMWP | MSECCFG_MML | MSECCFG_RLB);
+        mask |= MSECCFG_RLB;
+        val &= ~(mask);
     }
 
     env->mseccfg = val;
diff --git a/target/riscv/pmp.h b/target/riscv/pmp.h
index f5c10ce85c..ccff0eb9b6 100644
--- a/target/riscv/pmp.h
+++ b/target/riscv/pmp.h
@@ -40,11 +40,12 @@ typedef enum {
 } pmp_am_t;
 
 typedef enum {
-    MSECCFG_MML   = 1 << 0,
-    MSECCFG_MMWP  = 1 << 1,
-    MSECCFG_RLB   = 1 << 2,
-    MSECCFG_USEED = 1 << 8,
-    MSECCFG_SSEED = 1 << 9
+    MSECCFG_MML       = 1 << 0,
+    MSECCFG_MMWP      = 1 << 1,
+    MSECCFG_RLB       = 1 << 2,
+    MSECCFG_USEED     = 1 << 8,
+    MSECCFG_SSEED     = 1 << 9,
+    MSECCFG_PMM       = 3UL << 32,
 } mseccfg_field_t;
 
 typedef struct {
-- 
2.34.1


