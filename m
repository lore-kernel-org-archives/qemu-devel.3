Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EA0FCCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 04:16:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBmk5-0001Bq-C5; Thu, 23 Oct 2025 00:16:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBmk2-00018p-Rt
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:15:59 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBmk0-0007Ov-RQ
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:15:58 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-77f343231fcso222676b3a.3
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 21:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761192955; x=1761797755; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=riF1OaGE+fNwJAOX1ym6t4MAWgEY0zdDMEdQC2WHtn8=;
 b=hfrgBBt1+fq5re9J7XeEMSSPah/d5L+nnWImT8XetvZyEj+vyix5vaOCVfwLILLG/F
 AbC5pQaX420NAAuvjSGZq3195IUjKDpCVTN5z0zJ4pN5I7xePH/YwewCKkvc54wT3TpZ
 CJX9o3c1sTx7NXSdph/yrILRhLAgZ9L3DGfxG/2hSvGvXddIxEEuVBRINXMnGl/lpGxI
 FsHJ0U22y+EHEg2wB/pUXlKK5pN7OTdv4LFRs8eFeVx8plVo76JpANL38KZV0CxVutHJ
 98LQmP+BytfqA4GpHwRWPUX3rinRWcnS3NAAFs96d3LHzYl8yaWaSybJxLUW00b+KKK6
 Dgmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761192955; x=1761797755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=riF1OaGE+fNwJAOX1ym6t4MAWgEY0zdDMEdQC2WHtn8=;
 b=DQ88KoZybcS8xOiO71TmZ3vTAy7lmGYH1WrrvgRX2CGNF4RbQIw33courSGIRoJMlU
 lTpkcD7AWZIYSiAnMfPY1JqxNsZYdK/n2REYl0w4C36TSuN218R5NY7SyemjkYiC8EY6
 Uyw/wOgTvl3gFOaUfuxfdw9KDwodknmRdVKO205OR3+FGMu0MtdqofT6xXxa/lvVh+jq
 t0TtGXOHeKPETKx+bmd+YPilqX0/jsRAdqast0pQ4FewqFI7flKq4t/S3WIOD+dNS7Q1
 xX15Env4AEZIxgIWiazFXJkBvBomO9HIaKyVFz/fo31rKwjt6p/GX7qyGfZ5PaWW1fAR
 uBsQ==
X-Gm-Message-State: AOJu0YxZcGtNWnYix7PRQY3MZTczOFABSpViuX0gxX6jiJWWVvnGVzYV
 IAZtu2JpQtWkbiovFouEjG/vlpMSHgX/8A9zeXZNrPBVZrvmwf2UdI/c+AOd6A==
X-Gm-Gg: ASbGncslZ008aFMCRPwYpiB/s8NC5RkC8kQ+GI5WhxA380XGIEW0MbpQnrBkcQXJq5U
 nL4pix1Wlaaz9Lyhd6bdsBPzETMsymg/MQcFh1CMnuzo694FxfpRMDq9nKqdloXeeMM54Qp0MTf
 iKzfu8Yo30SHBgcheW0msoEhkcSNJQnMEzhqVSfeMXnN5YRv+AatnmzdmAFQL9GexSqQxwKvGOL
 AND+tesT2EglDpB4Rtv2uol+IxKoi2hGgrxU1aTIGb+CNB1nYkiOFfPTjnADXlZOBYewjsy1Quj
 pzHKw2Ax1AL7E/H/mgBB8DqyXV+qKAz/mTzMp0+WbSw04fy73bmJ43w8BUXfevzYW3vvgs3c9jq
 lyR+C7zI+CYj4kKqrJVKpssKBUQspzMaMdG3btTNflKJ+0Vb6CCho4A9huXe8okKnkXeQwNDOae
 n/vGLEc3MMTp77DRvH++vIP1ZlNb+dbdhOeKY8Gd+z50f7nUm6tu8GgDroj5NLueCqLOneREpeN
 KBB5YyiiA==
X-Google-Smtp-Source: AGHT+IGpDuVh+7j8VIwsaPXjRFtdvxJkRo3Z6s78B0uzPKVfxu7lrgDWEWBdQhs8HVQYgNTGsM1IqA==
X-Received: by 2002:a05:6a00:21c9:b0:781:24ec:c8f4 with SMTP id
 d2e1a72fcca58-7a220a5e59cmr24184764b3a.3.1761192955116; 
 Wed, 22 Oct 2025 21:15:55 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a274abe5f0sm961640b3a.34.2025.10.22.21.15.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 21:15:54 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Chao-ying Fu <cfu@mips.com>,
 Djordje Todorovic <djordje.todorovic@htecgroup.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 20/37] target/riscv: Add cpu_set_exception_base
Date: Thu, 23 Oct 2025 14:14:18 +1000
Message-ID: <20251023041435.1775208-21-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023041435.1775208-1-alistair.francis@wdc.com>
References: <20251023041435.1775208-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x432.google.com
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

From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>

Add a new function, so we can change reset vector from platforms
during runtime.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20251018154522.745788-3-djordje.todorovic@htecgroup.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h |  4 ++++
 target/riscv/cpu.c | 16 ++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 4c13012442..0ac31e5c61 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -673,6 +673,10 @@ G_NORETURN void riscv_raise_exception(CPURISCVState *env,
 target_ulong riscv_cpu_get_fflags(CPURISCVState *env);
 void riscv_cpu_set_fflags(CPURISCVState *env, target_ulong);
 
+#ifndef CONFIG_USER_ONLY
+void cpu_set_exception_base(int vp_index, target_ulong address);
+#endif
+
 FIELD(TB_FLAGS, MEM_IDX, 0, 3)
 FIELD(TB_FLAGS, FS, 3, 2)
 /* Vector flags */
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a877018ab0..2b655371ad 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -73,6 +73,22 @@ bool riscv_cpu_option_set(const char *optname)
     return g_hash_table_contains(general_user_opts, optname);
 }
 
+#ifndef CONFIG_USER_ONLY
+/* This is used in runtime only. */
+void cpu_set_exception_base(int vp_index, target_ulong address)
+{
+    RISCVCPU *cpu;
+    CPUState *cs = qemu_get_cpu(vp_index);
+    if (cs == NULL) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "cpu_set_exception_base: invalid vp_index: %u",
+                      vp_index);
+    }
+    cpu = RISCV_CPU(cs);
+    cpu->env.resetvec = address;
+}
+#endif
+
 static void riscv_cpu_cfg_merge(RISCVCPUConfig *dest, const RISCVCPUConfig *src)
 {
 #define BOOL_FIELD(x) dest->x |= src->x;
-- 
2.51.0


