Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C9C7CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:08:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQgG-00058e-7D; Tue, 16 Jun 2026 06:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQgE-00055u-L7
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:06:02 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQgD-00035b-1F
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:06:02 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-c85d4b4245aso3171087a12.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604360; x=1782209160; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W5pd4s8M+D8lyoy8burkmKdta0a2rE+rkKlyPaexZRo=;
 b=lFWUMYsFtfC2NT3BhXTAzb6xJjDQ4xCqpDyG93zDyofPFgDxP0NvRz82P2/DumBxs4
 KkwE251BQMbGV3oHnXvzZMsO0W3Sfg5PCqAt+TDqXWFbRrX7gkAjHRQr/QyG4t1tecZV
 yZv3e7MohY55IY6ivMpAfhqcZuof1BAR6WWwBNRMymj8p2AfRLY4j2t+Ou7T3OHP7/cD
 Ga0z8Y2VuYGSctbfcjSsC5OHumLiMe4hIqkGFYgvoUyR8upwiY+KBjFwX+O+bS8FTfln
 WwOrg18UHV7MW3L7smU4IbxZvnzUenoQ2EeTIJhiwlO0HfyGWt6Pr9KvHeJ/O+/wwGE5
 5esQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604360; x=1782209160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W5pd4s8M+D8lyoy8burkmKdta0a2rE+rkKlyPaexZRo=;
 b=U0eb32uDGtjBL+jOviWe0ZJwJsXG7zMgbKTcnFYbnRgXUjb9DM7U44QYBZ8oefHCJ2
 I45IEeYjadNHHAjjNuVpsqckUBD7EWCz18CM7rINKNf19qzXD4nL+96CuiTB3MNypDp8
 80K9i9bDU4jkLcMnOpKTFWKF4SyODIFDBAjKCLaKLiPxnwfph27Q3Wq9/4x41nWJ6T/m
 QbGOEuybO+rqChVs9Iqu/38WZqGR/xt2RqMAq8hhF5Cpvd/fJRScv46i1kc98Mh4oFJ0
 IerJItzVO0rV4JIJ72oPuAsPvjH/Gr5exxaeoaMrQCzJao4MDxSVlNoRoC3k5EGlyb6S
 ehUg==
X-Gm-Message-State: AOJu0YzSicinfWa/jERP/BwN8e+OuT1hsaFvd9NsB5G5zcOBTASkp1Kb
 FDEjypvB2lMhJ/8m4iYuA+vOjPElklAiO+TPfsUCIhGRKIeBzd9k6iQholspCeNf
X-Gm-Gg: Acq92OGw1U9zHLd/kT+295vc17dl+4NukcEY9EAtJUJmsSUw49BsjNqqlaSmUy3J3FB
 ugWuaLRJFC8YjK7obem6TnfsgyqyYCbRwwQSRnyStxO3soxdhWVgMlY3hGwFMET1hrm/4cm7cpf
 rogd1YfgQ3cGnuqmYyXy8hhE2mRGDq+e/VgbowmW99Fz0TF84XQCCp/2Ng8MyHZze9b2Ti/pRPg
 Npt/43y7AtnasuSw5nDw16ZuQrfk9oprSphW1E2S680dJHo1tLaHlodhjzlPR0ii6MM7SWIgvSY
 qgd+ruGxHXpPUMx2i819KfnmH1ZZqWJrGbgXtjj0sFyt2nhyyIL+T07R0UCmohBbVUAz5FJdL81
 EM1T4Dz86zsZt/hm4MXgh5rZA9nQ9N8YHug/+vTM/xpJSUH+Bd7BSPAa0R6P4Q4KOj5vn4zeqEy
 vu7/9gPoOaz6foJ0GvxLJTjpIfJgVhTX0ZRXmk21NAduz7TcH8yg4=
X-Received: by 2002:a05:6a20:d52d:b0:398:7ed3:a001 with SMTP id
 adf61e73a8af0-3b7961e7d9bmr17464899637.2.1781604359653; 
 Tue, 16 Jun 2026 03:05:59 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.05.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:05:59 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Zephyr Li <fritchleybohrer@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [PULL 07/83] target/riscv: Do not hide Sstc CSRs from gdbstub
Date: Tue, 16 Jun 2026 20:04:10 +1000
Message-ID: <20260616100527.1939565-8-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Zephyr Li <fritchleybohrer@gmail.com>

The Sstc predicate currently checks both ext_sstc and rdtime_fn. This
causes the gdbstub CSR XML generation to skip Sstc CSRs when rdtime_fn
has not been initialized yet, even if the CPU supports Sstc.

As a result, GDB reports $stimecmp as void with a CPU that exposes the
sstc extension.

Only use ext_sstc for the early existence check, and keep the rdtime_fn
check for non-debugger accesses.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3496
Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Message-ID: <20260525024220.39027-1-fritchleybohrer@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index d004a4bfb4..2e81221b1d 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -590,7 +590,7 @@ static RISCVException sstc(CPURISCVState *env, int csrno)
 {
     bool hmode_check = false;
 
-    if (!riscv_cpu_cfg(env)->ext_sstc || !env->rdtime_fn) {
+    if (!riscv_cpu_cfg(env)->ext_sstc) {
         return RISCV_EXCP_ILLEGAL_INST;
     }
 
@@ -607,6 +607,10 @@ static RISCVException sstc(CPURISCVState *env, int csrno)
         return RISCV_EXCP_NONE;
     }
 
+    if (!env->rdtime_fn) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
     if (env->priv == PRV_M) {
         return RISCV_EXCP_NONE;
     }
-- 
2.54.0


