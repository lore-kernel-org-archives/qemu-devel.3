Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37397C25B77
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 01:31:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9ELJ-0007jJ-BZ; Mon, 20 May 2024 21:31:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s9EL4-0007ei-M1; Mon, 20 May 2024 21:30:52 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s9EL2-0005JE-C3; Mon, 20 May 2024 21:30:49 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1ee12baa01cso100633675ad.0; 
 Mon, 20 May 2024 18:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716255046; x=1716859846; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d7DjxgiD7bWPAbcsJtjRKCQRkvkfUf5f4ixXD/z1Ahc=;
 b=RkpAp23k3MOpK41Vt7mU3x0YoYYdHvuOLnKR7E8QV7JYtbvHzlKII/j+HY+cv/1r2s
 FHWBkEHv/4pwI9WcHYhiG7qiDhvSE0GwCb4sXhBgK6NO10NxCZes5IkGd0iS57p5Mf3W
 njlllXI5IyTf5QleSn+asI11rmECXL1rXj3oOYA3JIVf8YAsejI0yeY9hvoegIe9xthr
 pz7uXGXLdC1BotSTdmm84wAbnzas5Z9iAKPswMmE9kQLwJgsHFh/P+X2DZXK4xOAse8L
 3ZxlN/hCZuYUS+zMwnxk/TlV3ZCxxhPPqeCjQO6pf44UsFWifSe6B5gUc6VPY+0lm5LH
 k3Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716255046; x=1716859846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d7DjxgiD7bWPAbcsJtjRKCQRkvkfUf5f4ixXD/z1Ahc=;
 b=cvTxE6Y7423lgJrdiFkCYgnWQ4jnH7bqXxMOH7ACI9Hn0gCRXhyJG/ONCqVYA7SPGr
 mkPQcJ5whN0rK4upr9DgeoJcQXYA/JRn6XmpgiTg+vIFLrRWvjNT/vKWCu47+2TC3Pv6
 9lhyGfihgBEo5F8dz2n8sBp4jaNeXoLdAEMMrnRzpd+y8kF6fEt3r2Mck6IWp8laEzHJ
 VzjFsFJNovrZCh5k3AtQH254odYjiZwd36lRPIiN3t2egEN1e7mlmHXH4d6oyRqVwA0i
 Tf3Or2SoT7DFx3nj6BTDGriSOav59CzcieNNts4NIThl7II/V1pohCreQK/ahY0CNWN6
 JzNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbPiQHXb0/dz4IceUhP1SKx/Joj6xsDmrOQ1NoadxiGtp9Yu8fA2sGZQy+XCRvRYoil9v3bNdZZ8tp4V+NVZzYwntoxLY=
X-Gm-Message-State: AOJu0YxlgljlD/Eu6QThCz9KoLoqvfTRHi2VCpiAWTDOL99Q+hVA5Qo6
 DtRTgmEgvmstWdYyMPKsjM7gRJe+GildWta1QSKvWKWSH5TeFualUgnw/A==
X-Google-Smtp-Source: AGHT+IFWi527TyuchW5RRd5ValpciJ5XybjYTfYTj4KEtNvzR61MKZMT8gzgGM9IiTgNYkN+ORBOog==
X-Received: by 2002:a17:90a:5781:b0:2b2:6ede:5ce0 with SMTP id
 98e67ed59e1d1-2b6cceef30dmr25227028a91.39.1716255045848; 
 Mon, 20 May 2024 18:30:45 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2bd7f0cd400sm2514953a91.31.2024.05.20.18.30.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 May 2024 18:30:45 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH v2 02/12] target/ppc: improve checkstop logging
Date: Tue, 21 May 2024 11:30:18 +1000
Message-ID: <20240521013029.30082-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240521013029.30082-1-npiggin@gmail.com>
References: <20240521013029.30082-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Change the logging not to print to stderr as well, because a
checkstop is a guest error (or perhaps a simulated machine error)
rather than a QEMU error, so send it to the log.

Update the checkstop message, and log CPU registers too.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/excp_helper.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index b2b51537b7..17bf8df9d7 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -430,17 +430,19 @@ static void powerpc_mcheck_checkstop(CPUPPCState *env)
     /* KVM guests always have MSR[ME] enabled */
 #ifdef CONFIG_TCG
     CPUState *cs = env_cpu(env);
+    FILE *f;
 
     if (FIELD_EX64(env->msr, MSR, ME)) {
         return;
     }
 
-    /* Machine check exception is not enabled. Enter checkstop state. */
-    fprintf(stderr, "Machine check while not allowed. "
-            "Entering checkstop state\n");
-    if (qemu_log_separate()) {
-        qemu_log("Machine check while not allowed. "
-                 "Entering checkstop state\n");
+    f = qemu_log_trylock();
+    if (f) {
+        fprintf(f, "Entering checkstop state: "
+                   "machine check with MSR[ME]=0\n");
+        cpu_dump_state(cs, f, CPU_DUMP_FPU | CPU_DUMP_CCOP);
+        qemu_log_unlock(f);
+    }
 
     /*
      * This stops the machine and logs CPU state without killing QEMU
-- 
2.43.0


