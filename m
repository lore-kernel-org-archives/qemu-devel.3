Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C790B606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 06:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iCxQpncK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLagm-0002wv-BM; Tue, 27 Oct 2026 02:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xLagh-0002WP-FO
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:29:35 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xLagf-0008De-IG
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:29:35 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-cd69954c755so2512826a12.3
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 23:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793082572; x=1793687372; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+AfIKFCkiUxJR1oRF5Aar/tEUUTGji12OqpqQQZ3ljM=;
 b=iCxQpncK224nPsN3MRUimo65FkscxcAWQmCwcoFt3Kf6eYJl38C/R01HMAu9/fAJ8Q
 hGkBFU2MCoL76AfivSf683bhe7nKwm0L0gIA9RhfFQbad/mZ3TN6IzHM4mF6VDyUKaQh
 MRbUUUGena2Chr+uPZlOMIVXKHxvGkhbJSJl76UFp+mypYWMmdWhd2TWmE6GGvxBW6lc
 lni4OwGZvbF9Y4kMW7JVfAj5v0jbrfiu/RFJhm1S9TcsqNlQ9JS+CXAFt9VKPPrxq6ct
 ufVH0rNwxfV4ISnf9qU1SyKk8haCv14tWQhrD+bs4NakTnxfcYj275/uvhHbaTEll8HG
 L2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793082572; x=1793687372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+AfIKFCkiUxJR1oRF5Aar/tEUUTGji12OqpqQQZ3ljM=;
 b=V7LO+/KyP/TGxOetQs57JUkV+DHNXNZI83AapviiiMP5LjcIz7U+UnY8o/S/iVwBU4
 gR+41KL4V4VDfBNkPuRBVupTHYHrak7MuMoqNxtcf5iALH9r3X+RoIb4SjtX4GbF/xgW
 UMTrFI/eLayBgYNaRb8FX2RzGSJ/grlVVuv07I165zuIFw7g0P9vsBaX7QXcj2sH6XyP
 BAt4ifyW0cQhKmOMCMd2xYafPQxzkwhqpqk2ktsm3Ld/jfj4berT/ejjGra6xnbZNyVx
 zQUmQOo7Cxyqv0NgNpBNGxxOXR35I1BC3yZvy0yq2ZEG+BDDyHZSpP64ND/Vx9i9QETI
 U97Q==
X-Gm-Message-State: AFq9FYKY2kIyYRYoVpBzPgQx6Q/yAOCQwthGgrdlUC77Lxvc4eXWB8wp
 xLbAZGmRZHl30GzcuuoRxQ/ofqiDsOijKee+7zW9T06RFImQFcE/8FUDgBcM1w==
X-Gm-Gg: AYBFou3qzXflpuUIORAAf7maP6p8kUf0uT1NcSq9C1kw0PP8gtcSapVBcZFufIjLMqC
 TZQ6COhxb7207YdNFRxMTCh1SWdYq049otqqJK9paV/lH736KkLyU+nZlj0AvNrrVGgWtAo74jL
 fhYe0FZi67QIEeZm2u8REvzXHQzDKs0ExHNg0fg5aUQ59q5P/pL/nAUgJ7EPV27TnGue7j0rs9q
 2FqazRM0PSZ9lGUyDqY8lMIqxOJENIwh2vbmr8OKBfFNfQ+nnss9yxwOmld/EJA8ehvD/+8awAr
 5Kppc5fNswO8zpT4djSTwFRp29yn3cQ+K+a8VMqyWA6GXzrl8W7IrHaIoV47i218NZQ2CU3gbkh
 EfkOJSuutrXMbFyjjn+SkBqI5yLAJD91XY6fK83o5ah249+WllHJdhbLpqN+7uhmGw+iMOibEOc
 L20eKh3tGIAvvKXgM9PlqvTr3plr2WFhc6rjxuyWSsZ0sXXSioS6pqW/JO9onc1ZWwTJCiMaelG
 EBDA6KAGhrA1KRY0wJvnGMM3EN6kHQtwQtFpf5Vk5aCQ4SDYVhrR1jQ2ZUTm9n17SeLAMEmWYEX
 ochIAe5CpPmzEIpI4l0jXJ94dz/ZfvEJq197YMCE4xv0W3E=
X-Received: by 2002:a17:90b:3846:b0:3ac:945c:7f69 with SMTP id
 98e67ed59e1d1-3adeb162362mr7300139a91.66.1793082572081; 
 Mon, 26 Oct 2026 23:29:32 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae401bf352sm2358541a91.0.2026.10.26.23.29.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 23:29:31 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: wangyang <wangyang25@otcaix.iscas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 21/29] target/riscv: gate envcfg CBO fields on extensions
Date: Tue, 27 Oct 2026 16:28:00 +1000
Message-ID: <20261027062808.1995205-22-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027062808.1995205-1-alistair.francis@wdc.com>
References: <20261027062808.1995205-1-alistair.francis@wdc.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: wangyang <wangyang25@otcaix.iscas.ac.cn>

The envcfg CBO fields are provided by Zicbom and Zicboz. Keep them
read-only zero when the corresponding extension is absent in all three
envcfg CSRs.
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4225
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: wangyang <wangyang25@otcaix.iscas.ac.cn>
Message-ID: <6AD08960.0F1C24.05843@cstnet.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/csr.c | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index 242f5caa0d68..13675b4a8439 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -3388,10 +3388,19 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
                                     target_ulong val, uintptr_t ra)
 {
     const RISCVCPUConfig *cfg = riscv_cpu_cfg(env);
-    uint64_t mask = MENVCFG_FIOM | MENVCFG_CBIE | MENVCFG_CBCFE |
-                    MENVCFG_CBZE;
+    uint64_t mask = MENVCFG_FIOM;
     bool stce_changed = false;
 
+    /* CBIE/CBCFE are read-only zero when Zicbom is not implemented. */
+    if (cfg->ext_zicbom) {
+        mask |= MENVCFG_CBIE | MENVCFG_CBCFE;
+    }
+
+    /* CBZE is read-only zero when Zicboz is not implemented. */
+    if (cfg->ext_zicboz) {
+        mask |= MENVCFG_CBZE;
+    }
+
     /*
      * menvcfg.LPE (Zicfilp) and menvcfg.SSE (Zicfiss) reside in the low
      * 32 bits and are defined for both RV32 and RV64, so they must be
@@ -3492,8 +3501,18 @@ static RISCVException read_senvcfg(CPURISCVState *env, int csrno,
 static RISCVException write_senvcfg(CPURISCVState *env, int csrno,
                                     target_ulong val, uintptr_t ra)
 {
-    uint64_t mask = SENVCFG_FIOM | SENVCFG_CBIE | SENVCFG_CBCFE | SENVCFG_CBZE;
+    uint64_t mask = SENVCFG_FIOM;
     RISCVException ret;
+
+    /* CBIE/CBCFE are read-only zero when Zicbom is not implemented. */
+    if (env_archcpu(env)->cfg.ext_zicbom) {
+        mask |= SENVCFG_CBIE | SENVCFG_CBCFE;
+    }
+
+    /* CBZE is read-only zero when Zicboz is not implemented. */
+    if (env_archcpu(env)->cfg.ext_zicboz) {
+        mask |= SENVCFG_CBZE;
+    }
     /* Update PMM field only if the value is valid according to Zjpm v1.0 */
     if (env_archcpu(env)->cfg.ext_ssnpm &&
         riscv_cpu_mxl(env) == MXL_RV64 &&
@@ -3550,10 +3569,20 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
                                     target_ulong val, uintptr_t ra)
 {
     const RISCVCPUConfig *cfg = riscv_cpu_cfg(env);
-    uint64_t mask = HENVCFG_FIOM | HENVCFG_CBIE | HENVCFG_CBCFE | HENVCFG_CBZE;
+    uint64_t mask = HENVCFG_FIOM;
     RISCVException ret;
     bool stce_changed = false;
 
+    /* CBIE/CBCFE are read-only zero when Zicbom is not implemented. */
+    if (cfg->ext_zicbom) {
+        mask |= HENVCFG_CBIE | HENVCFG_CBCFE;
+    }
+
+    /* CBZE is read-only zero when Zicboz is not implemented. */
+    if (cfg->ext_zicboz) {
+        mask |= HENVCFG_CBZE;
+    }
+
     ret = smstateen_acc_ok(env, 0, SMSTATEEN0_HSENVCFG);
     if (ret != RISCV_EXCP_NONE) {
         return ret;
-- 
2.55.0


