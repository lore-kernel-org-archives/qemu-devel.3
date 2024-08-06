Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D033C52D6D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 06:27:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbDe9-0003Ud-Dg; Tue, 06 Aug 2024 02:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sbDe8-0003QA-0J
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 02:26:12 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sbDe5-0003yx-S6
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 02:26:11 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1fd69e44596so3678765ad.1
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 23:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722925568; x=1723530368; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rIl02MTGpKMjmvTqt9QTISYxUzrPTliJWcVLJpIrITo=;
 b=Tm0mLU3f8U7J3Sr21hd4InKIXhTc9Dh1GI4LDjdHd/Aj4J7KVhhB24eZQ8/23nfnS0
 /Tt7blz1DSaIGVYzO51tQ+ZKlxP90N+s0XRGoHNktm61Tn0jdHI2N6k9S4dT7lYUOyrP
 4V5H39+Hj/VCvjtf31dGMEPjoXD0Xg1EjpQLIs4bMQlKiM0bTos/H5njUx6VSEGXrSMe
 GN1IN2S/5r/jKupkIu7mOsNXDBlvNXTzheXiQxf0Pfxm/KbwnpIBbhCfBz6cOsRV274n
 6XpkK6oV9eGPxDbnP1CqFHcHT8NBT5XRguCH9fb05PWg6xxJJCOfmaURrDsM7e+3mDu9
 lrig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722925568; x=1723530368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rIl02MTGpKMjmvTqt9QTISYxUzrPTliJWcVLJpIrITo=;
 b=QDm4zEhu0RhDMC5gf5wZMfRmSpNd021Gio3VicZ9xNS+56FL5TjJR2iGhKD9zd+/ww
 A+mlwk1XqXN2zTluIQ/SRMh6bZX8bW6hMFHAAMI6a9YFU1OGVDe8IsaeqSnnV0drVUeb
 F6PMDJMIY9qB8BmTOHM60ouVMsP1v6yXpLj5LXfQXasgTbn4fiMxG6vZX0BTIXmb5Ob8
 BoLpzGzmHpLILT1IvmSg0x4OFGCK6SGwXsXbtP0fBmP7k2W1jNikkKmERgwDzCAcEwp9
 LXfUfvTj/Q1mhkI1MR6Gx8IkZLRc7MpN+wFSAKPHzYp4O3hV4a59ANt0RPZcBO9DBnhV
 1SZw==
X-Gm-Message-State: AOJu0YyQgMy5uCrIl9T1wkyK4yo7Qkgl/YV+hacfvvMq3rOUYHJdxDS2
 WXVjfIEoMAGCsE66OA61CeeT7MqdYnmuhLqLPeRwTEfT7TNxGbgv+yMQt1Pj
X-Google-Smtp-Source: AGHT+IF2StyMO+TE6pXy0EkMoCl3aVVqXH7bU7UWvt/7od5BX1lNAvKJ9ZJYokYxPGiegAJObMjr7Q==
X-Received: by 2002:a17:902:dac3:b0:1fa:2b11:657d with SMTP id
 d9443c01a7336-1ff57b827c9mr222497785ad.10.1722925567929; 
 Mon, 05 Aug 2024 23:26:07 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff5927f161sm79464975ad.232.2024.08.05.23.26.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Aug 2024 23:26:07 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Atish Patra <atishp@rivosinc.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 4/5] target/riscv: Add asserts for out-of-bound access
Date: Tue,  6 Aug 2024 16:25:44 +1000
Message-ID: <20240806062545.1250910-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806062545.1250910-1-alistair.francis@wdc.com>
References: <20240806062545.1250910-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x633.google.com
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

From: Atish Patra <atishp@rivosinc.com>

Coverity complained about the possible out-of-bounds access with
counter_virt/counter_virt_prev because these two arrays are
accessed with privilege mode. However, these two arrays are accessed
only when virt is enabled. Thus, the privilege mode can't be M mode.

Add the asserts anyways to detect any wrong usage of these arrays
in the future.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
Fixes: Coverity CID 1558459
Fixes: Coverity CID 1558462
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240724-fixes-v1-1-4a64596b0d64@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/pmu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
index 3cc0b3648c..e05ab067d2 100644
--- a/target/riscv/pmu.c
+++ b/target/riscv/pmu.c
@@ -204,6 +204,7 @@ static void riscv_pmu_icount_update_priv(CPURISCVState *env,
     }
 
     if (env->virt_enabled) {
+        g_assert(env->priv <= PRV_S);
         counter_arr = env->pmu_fixed_ctrs[1].counter_virt;
         snapshot_prev = env->pmu_fixed_ctrs[1].counter_virt_prev;
     } else {
@@ -212,6 +213,7 @@ static void riscv_pmu_icount_update_priv(CPURISCVState *env,
     }
 
     if (new_virt) {
+        g_assert(newpriv <= PRV_S);
         snapshot_new = env->pmu_fixed_ctrs[1].counter_virt_prev;
     } else {
         snapshot_new = env->pmu_fixed_ctrs[1].counter_prev;
@@ -242,6 +244,7 @@ static void riscv_pmu_cycle_update_priv(CPURISCVState *env,
     }
 
     if (env->virt_enabled) {
+        g_assert(env->priv <= PRV_S);
         counter_arr = env->pmu_fixed_ctrs[0].counter_virt;
         snapshot_prev = env->pmu_fixed_ctrs[0].counter_virt_prev;
     } else {
@@ -250,6 +253,7 @@ static void riscv_pmu_cycle_update_priv(CPURISCVState *env,
     }
 
     if (new_virt) {
+        g_assert(newpriv <= PRV_S);
         snapshot_new = env->pmu_fixed_ctrs[0].counter_virt_prev;
     } else {
         snapshot_new = env->pmu_fixed_ctrs[0].counter_prev;
-- 
2.45.2


