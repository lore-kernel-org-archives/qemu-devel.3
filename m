Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E6D9C48286
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 10:18:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSaJg-0003Fs-2e; Wed, 24 Jan 2024 05:17:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSaJc-0003FQ-VU
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 05:17:04 -0500
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSaJb-0003oy-BR
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 05:17:04 -0500
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2cf161b5eadso17107841fa.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 02:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706091421; x=1706696221; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QCaFP/JCcM9wNK6S/97qMJvFLtrlt8qlwc6m36BcsKg=;
 b=z75ITGLPdKccL7TMKDO/oMH/IW9BWXWuV5maFFOIMUyrrWmcQiQ57AZL2Mm833VMob
 NlNS9QNFuJJhOU240IsHqSwTJ/IIcSEeQNVbkS67TwrDC2ZIvrwzpYeu3nt1EQCU4E7K
 /tXexVPmj1Ix0fONkbOyZcabDW/juXDBPmILKWhhXrjV0R3uC6sRlrYcZziG4Dzt3a7K
 4isKeyYmbwDQX2OKB5CvkR7qTKXEYqj6VCmA/NEnMI50LmKEsjkjCsWLdeEWScbv6zBG
 tZXUVned0OHaDpRAS9/0uZoV3C/W259tYE2tthjIbvyV56W+B8PDNwTjJmEwxXImv9UW
 /Lrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706091421; x=1706696221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QCaFP/JCcM9wNK6S/97qMJvFLtrlt8qlwc6m36BcsKg=;
 b=Kp+nTJFVHdUio2/WGOvpHJjH3SndRQBONmpP5LchaVxIcOA3NFTVJW3W1Pvv/MqE4a
 lxMX7966nW7bg/DkB/vcHqQkPAZCtIFfBHvkGXJEdjZpL4QZowpI7WXhW+YYMqlepgwb
 +v9xV/1uvlBJ4OavmbnD5lJuD0FgbQO+qPD7ttTY3CRoM3kW67ZxT3CvADsbbHln2KF1
 GUzc8yc14AvR3SMFvhFLeUgY1oQzfdkXsRwHeWfhTurtn+ZM98PvEbvEFrsxxCOOLbSf
 2EIdyYRYMJD+Xfo6Noz4ZJfGT0XJsWS/LxMSZppdEW7ksuHo6zLvI7At3fBJeo8/2L+s
 qqPA==
X-Gm-Message-State: AOJu0YzoXgrnZMEiHIY506jmIuKqvUHojCwIAMohsBGst/m0tsnK84bh
 ElihM+yp5t2SYK9RONhxH0en0Ett/V7TcVtjjG60nLUIkvrDIUyOnWFWHeHAzzQQNrexM8pzQBD
 j
X-Google-Smtp-Source: AGHT+IEVG4Ln3bk/nYFNEbNSjklMnjb2JXuXOuKJ3rARoxHbBpuoCuPrWt+0nrivveIK/Qp9qMMPWA==
X-Received: by 2002:a2e:beaa:0:b0:2cd:9f51:ac23 with SMTP id
 a42-20020a2ebeaa000000b002cd9f51ac23mr804483ljr.4.1706091421496; 
 Wed, 24 Jan 2024 02:17:01 -0800 (PST)
Received: from m1x-phil.lan (lgp44-h02-176-184-8-67.dsl.sta.abo.bbox.fr.
 [176.184.8.67]) by smtp.gmail.com with ESMTPSA id
 h27-20020a056402095b00b0055c643f4f8asm2410643edz.32.2024.01.24.02.17.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Jan 2024 02:17:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Anton Johansson <anjo@rev.ng>,
	qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 Claudio Fontana <cfontana@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/9] accel/tcg: Rename tcg_cpus_exec() -> tcg_cpu_exec()
Date: Wed, 24 Jan 2024 11:16:33 +0100
Message-ID: <20240124101639.30056-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240124101639.30056-1-philmd@linaro.org>
References: <20240124101639.30056-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x233.google.com
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

tcg_cpus_exec() operates on a single vCPU, rename it
as 'tcg_cpu_exec'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
2.41.0


