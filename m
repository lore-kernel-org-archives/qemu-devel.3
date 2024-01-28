Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04AD0C47258
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 04:44:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTx0w-00059V-9p; Sat, 27 Jan 2024 23:43:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTx0t-00057j-2D
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:43:23 -0500
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTx0r-0004O0-CR
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:43:22 -0500
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-59a146e8c85so791288eaf.0
 for <qemu-devel@nongnu.org>; Sat, 27 Jan 2024 20:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706416999; x=1707021799; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h0D5wvbqCBKDS3PIRJ2u8mID+Ysdp5Zl/usWtkQWmMI=;
 b=XVvQXq9b9AZgSDqXxGtk+ZbtbxJxcjbkTID/4TV8dAJ7BFKYSMO+wee1yKBF8zX9AX
 0EsL8coekG18V3DienXN6MZLia0u53pO1Uv0Yv2D92AmQuumR44SFO97rZtwlHTDpBmi
 ST2kBZcvnS/JLitBaR11cSE2BljB/gSjivCKrxGlEUngJYFdl+7BemmMLV1sbCah/rq9
 oqGl/BKIsPV6cSSmR1744IETlwxrlX2eK9fTHTwjEMqn1doKP6g/5rKjyxF54rKmP9Cf
 u3j9OeZW9AceSUYUps4uGltEOo6qWTE8RYa1/bEBSCV5irwsg1K/n0+9b3pkOFWB9+Jj
 uUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706416999; x=1707021799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h0D5wvbqCBKDS3PIRJ2u8mID+Ysdp5Zl/usWtkQWmMI=;
 b=koI6B73XJYppZ56VElRXGlRNk1BzWXaKeFYXfquSJTrsnRGldD77naxUw917Yh+NEP
 ocAT5R7l57AfBQFoKGEg/nr6/jTzPX/0IQMqe6BNWGL07B/trMSICTwY63b24/L/yZ7f
 ye9owoYuOwT/gq/Nbw3/iPfQ8KrsqCb41eYeIilwLySom0ZsI8uza+G3TJc8hwEkSlur
 ZN7ZT83FN2kyzmVUJhd2ss031s0rRkKtYA1iM+KvwdpjP5BbHjWPK4KvrWawWH8z/oCx
 aCXIIBpRCy1r7McJz5HXDirVnND9BwPbcOaz2YJOXd1U4coZ2cuQ6QnmkxQCBYP8i4/H
 mvnQ==
X-Gm-Message-State: AOJu0YyUmDbQqO1P/mXQLjbRfADhj5zxhRQXO03E5iW7cwXvguoUJlAN
 Vh6oVCyVdQ57kWEeHA2T4H9xf77mHOEp9Ew/aFAkY4PV8XY/wdtWT5do+dDhY7Yfp4Nnb3yFe7T
 nZnkvlA==
X-Google-Smtp-Source: AGHT+IHYzL/aBOCLYjBLQ292BGC5ogjO6YZiEBee4x3+woyQD1QpkzzHqB35QvJSUMG64YX+FaxB1g==
X-Received: by 2002:a05:6358:9490:b0:170:e2dc:3e19 with SMTP id
 i16-20020a056358949000b00170e2dc3e19mr2487468rwb.43.1706416999172; 
 Sat, 27 Jan 2024 20:43:19 -0800 (PST)
Received: from stoup..
 (ppp121-45-131-89.bri-pow-que-bras31.tpg.internode.on.net. [121.45.131.89])
 by smtp.gmail.com with ESMTPSA id
 w24-20020a17090aaf9800b002906e09e1d1sm5631873pjq.18.2024.01.27.20.43.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jan 2024 20:43:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH 24/33] accel/tcg: Rename tcg_cpus_exec() -> tcg_cpu_exec()
Date: Sun, 28 Jan 2024 14:42:04 +1000
Message-Id: <20240128044213.316480-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240128044213.316480-1-richard.henderson@linaro.org>
References: <20240128044213.316480-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

tcg_cpus_exec() operates on a single vCPU, rename it
as 'tcg_cpu_exec'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20240124101639.30056-4-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-accel-ops.h       | 2 +-
 accel/tcg/tcg-accel-ops-mttcg.c | 2 +-
 accel/tcg/tcg-accel-ops-rr.c    | 2 +-
 accel/tcg/tcg-accel-ops.c       | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops.h b/accel/tcg/tcg-accel-ops.h
index 17c7ed00eb..44c4079972 100644
--- a/accel/tcg/tcg-accel-ops.h
+++ b/accel/tcg/tcg-accel-ops.h
@@ -15,7 +15,7 @@
 #include "sysemu/cpus.h"
 
 void tcg_cpu_destroy(CPUState *cpu);
-int tcg_cpus_exec(CPUState *cpu);
+int tcg_cpu_exec(CPUState *cpu);
 void tcg_handle_interrupt(CPUState *cpu, int mask);
 void tcg_cpu_init_cflags(CPUState *cpu, bool parallel);
 
diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index bcba314a65..c552b45b8e 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -92,7 +92,7 @@ static void *mttcg_cpu_thread_fn(void *arg)
         if (cpu_can_run(cpu)) {
             int r;
             bql_unlock();
-            r = tcg_cpus_exec(cpu);
+            r = tcg_cpu_exec(cpu);
             bql_lock();
             switch (r) {
             case EXCP_DEBUG:
diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index 0617f66b5b..894e73e52c 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -258,7 +258,7 @@ static void *rr_cpu_thread_fn(void *arg)
                 if (icount_enabled()) {
                     icount_prepare_for_run(cpu, cpu_budget);
                 }
-                r = tcg_cpus_exec(cpu);
+                r = tcg_cpu_exec(cpu);
                 if (icount_enabled()) {
                     icount_process_data(cpu);
                 }
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 9b84b84218..9c957f421c 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -68,7 +68,7 @@ void tcg_cpu_destroy(CPUState *cpu)
     cpu_thread_signal_destroyed(cpu);
 }
 
-int tcg_cpus_exec(CPUState *cpu)
+int tcg_cpu_exec(CPUState *cpu)
 {
     int ret;
     assert(tcg_enabled());
-- 
2.34.1


