Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C202EC3DA63
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 08:32:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWXPX-0005Lv-FH; Wed, 24 Jul 2024 04:31:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sWXPV-0005JQ-5n
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 04:31:45 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sWXPT-0004zo-0J
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 04:31:44 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1fd90c2fc68so13868085ad.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2024 01:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721809901; x=1722414701;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6zBMcgZOuGC9Zq1HFFB8Kq14HtY83XxOhr2ghiK5Hz0=;
 b=03mhbXUAMbXiXH7VGYfcgDzGNR0atkWFA7mKgQ+4aKbO9fsyerCV2M1Wd4orUs6ida
 5QT5IGPAXwlerbwSAt88pv5DV8zVmB1k/LswG8qlbNx0Uy1z0ZXfj8yRPIO99fasV0iR
 FII05mweF/HjsKuUt6rYermBs1QYE/kaD1NJOlUEY6IHWfVtZbcVQ9OYXw8l8N4qH1es
 rkbNOk9HwAL2fTQEdL0GpHJp7HUZXZXvif+hdWbZVGTGrBBFCflI9jIKNUGuu5FqxJib
 NK8nTrnUYG1BAuJ/9pyORXDUy5hCIVCE29zNYjI0rSm/c4qd3W4XeBg52W+Vui3AyBO7
 HZ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721809901; x=1722414701;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6zBMcgZOuGC9Zq1HFFB8Kq14HtY83XxOhr2ghiK5Hz0=;
 b=J34c8Besw5BEx9NamV9pm32W+dr3QZTfba4sMe0W783yeuh1TJkfaDgkNa8u997R3v
 xci5Y53FkPg3+KjeCrTQkF56ii5YR7t94IrzCP64irbMfIH9jyMOrLYw1TPEPj1B6FnC
 tvLos1yD8vdRCHApl37g3eDvzyJMGtMWn7PB3ztNorkCUsEUNdk2SO9smLsRa7I4SdlD
 F6WPTvRwUYKtWIYfgsIdKLgtxRtFWNJxCe8AJpbW8cLn3sY092n3X6QXo1CbAqwckJfY
 NJ7kexhIMfdDyR25fuNHX3NrOPmPdgyI10jHrMoMiJZBir3uwpRl5xgIs2zhW+ke1wtI
 fhLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqJGll62XxsgBpFtFz0Jyx5z15RoqjPdMFw8lz6JmF0SRIt5zX5V66ECVwy3Xvu0OIB4MOtFvwvfJkE10wXMhvqA/JZh8=
X-Gm-Message-State: AOJu0YztDfg4UOdAqiQIORI4hKlf88e7R8dOE7rzo1aaG2V934E0vd7i
 zwmYxaIhgyE0oqmwex99Yp3W8Cf3xQEkyNgt53v0lFXfDh+wzxtf92kjnPAvg9U=
X-Google-Smtp-Source: AGHT+IFJvG5mp9zK5yIlMwW5DUiHSHhgxFOvaRZv+2wbdtiX45bYpRgA0fjkVWIpTuwh68jyjV6cNQ==
X-Received: by 2002:a17:902:dacb:b0:1fd:d4c2:a2ef with SMTP id
 d9443c01a7336-1fdd5512f0emr10667275ad.21.1721809901200; 
 Wed, 24 Jul 2024 01:31:41 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fd6f3181bdsm88455845ad.133.2024.07.24.01.31.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 01:31:40 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Wed, 24 Jul 2024 01:31:36 -0700
Subject: [PATCH] target/riscv: Add asserts for out-of-bound access
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240724-fixes-v1-1-4a64596b0d64@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIAOe7oGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDcyNj3bTMitRiXRNjyyRLI8uktKRkCyWg2oKiVLAEUGl0bG0tAOMVHYN
 XAAAA
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com, 
 Peter Maydell <peter.maydell@linaro.org>, Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=atishp@rivosinc.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Coverity complained about the possible out-of-bounds access with
counter_virt/counter_virt_prev because these two arrays are
accessed with privilege mode. However, these two arrays are accessed
only when virt is enabled. Thus, the privilege mode can't be M mode.

Add the asserts anyways to detect any wrong usage of these arrays
in the future.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
The lore discussion can be found here
https://lore.kernel.org/all/CAHBxVyGQHBobpf71o4Qp51iQGXKBh0Ajup=e_a95xdLF==V_WQ@mail.gmail.com/
---
 target/riscv/pmu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
index 3cc0b3648cad..e05ab067d2f2 100644
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

---
base-commit: daff9f7f7a457f78ce455e6abf19c2a37dfe7630
change-id: 20240723-fixes-439b929bfbc8
--
Regards,
Atish patra


