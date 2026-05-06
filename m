Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D382FF8855
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:00:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcn9-0003mV-7Y; Wed, 06 May 2026 10:00:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcn5-0003jR-Mu
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:59:56 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcn3-0000FZ-Rm
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:59:55 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-48896199cbaso56985295e9.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 06:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778075991; x=1778680791; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5ef0JMGJzLVkl819dhHRCN59pW8hGuKmoFkI/orJyaE=;
 b=lRBWTT6DmL8RBwSwHUaYAJpEsirk3ICQmC/+gZy8XYEuoYHeO22LB8igsheUI2VJQp
 /TK7CdwRc4hxhTF7rZVt8Ms60sdu92ZavQd+8joUqhNuupqKcCSuKKk1CMaGP+0y7q1U
 Ev6DH950giNJCXKzKyRU6VITnUcKoKr5Rj6ugWeRPStowFY9GSNaU4/J37qWdqaY3t7X
 lAF9NOrxvP7GwabQ6RE2CpgI2Xn8coi3Ppl2lYaOFXCwDTa4zyC7tIIoWaZuWweChnKS
 lREbB8cnXgNXpUxum6E3nzGZFcEp36Au1zW4Be+Pv5h7Kti+xxoyD7ZopI/LtMqq5Ap9
 68Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778075991; x=1778680791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5ef0JMGJzLVkl819dhHRCN59pW8hGuKmoFkI/orJyaE=;
 b=FVcW3ypq0d5I+CUZI0d6mfR9dcN0IDFf9O0t8lQU7+6c556sjjXtqBt1xZNldE0U+Z
 KInYAmZSnpVCQUD+siL2PnRUdLWI5kCN846mU+SRK8oOyq+BrQBYg2euVA03O0ibX+eF
 gmgj9tny/yHFrawq3jC2+L45owgKq3dhemxErRZeB0qGddCBKKnDWOhBv8IyTQ89IBdd
 ednspGdruayWvM5ODRkDFbx8hWAm1X4sB+ZNMcp/JBi7F0N15ApqnXD0Q/eTI8oxq8of
 1dgYyEWTNfacTsiOxOBIXz+BSLJiOue0jgy7CtqpXa0hKPxg/gNJZrM2rhFEkgt6MGMT
 c1Bg==
X-Gm-Message-State: AOJu0YyYcxhtT1WpPlE9wIcA7SQNLPgz+YjQHgKVQtMzNbkUtcIGjYVt
 5qCMNIehFsGWuOvLotlf9gnfWXOT9tuh2cC8pNTFam2fwSW4HskQOwZKyv/yBxRcafTTqaxheL9
 Lzvjrf8c=
X-Gm-Gg: AeBDiev9Lv5miqCDQqLuLA4FVFQ1uFVGBiDmrSLIgYMI1mVGVWdAkV88lRGcpG2vkuY
 jXsD4uxp67+HfVW6ND/JNB2q63feQkxKOIBARWCSCI1RjuxkPlErUOL+l/ib99Btm4tqXu2T75Y
 M8zRWkk4biRfRzJc3FX6TQaTWQXPRWtRQ8Cx+SJlQpmsQO+DA34CikTixKc2TJ8Y639SDuOD9Iu
 Lq7GbOB6I1jx2QyGwXwBD1bVQdRj9I+gLEs2QJI/qkBa9U/tIqnoNrTx+vFzkh9XKLt8PWnCPiR
 u+MBK2lNqQofsscO3jK4m6qlpzmiFZPzXy5SrRgLD30OmXNO0rbnFhU+iEUL6IqrGFmmtTILKiq
 vlN+eC3upkcjyiOk8Q4T1gIfXDMQS+fNQz8gKG2usrLnP7BSd9htnvnCMLmd72gdmv+hhkEqMad
 qPWSftNQWopCS2lyLsHVAVFm2W3ip7/aFpX4DuRUhsYFuIYeB6ruwyXl0Nxd0+nSXR1XJD2oKvt
 GzJpu5NRZE=
X-Received: by 2002:a05:600c:c11c:b0:48a:52f2:a0f1 with SMTP id
 5b1f17b1804b1-48e51f46d48mr42633685e9.18.1778075991360; 
 Wed, 06 May 2026 06:59:51 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e52f5c1cfsm35974615e9.0.2026.05.06.06.59.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 06:59:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 035/110] cpus: Remove CPUClass::init_accel_cpu() left-over hook
Date: Wed,  6 May 2026 15:54:07 +0200
Message-ID: <20260506135524.20617-36-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Commits f50d0f335a6 and a522b04bb9c ("target/riscv,i386: Remove
AccelCPUClass::cpu_class_init need") removed the last uses of
the CPUClass::init_accel_cpu hook. Remove it as unused.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260412212547.29645-1-philmd@linaro.org>
---
 include/hw/core/cpu.h |  6 ------
 accel/accel-common.c  | 13 -------------
 2 files changed, 19 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 207a7a1becb..c9fea797435 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -186,12 +186,6 @@ struct CPUClass {
     /* when TCG is not available, this pointer is NULL */
     const TCGCPUOps *tcg_ops;
 
-    /*
-     * if not NULL, this is called in order for the CPUClass to initialize
-     * class data that depends on the accelerator, see accel/accel-common.c.
-     */
-    void (*init_accel_cpu)(struct AccelCPUClass *accel_cpu, CPUClass *cc);
-
     /*
      * Keep non-pointer data at the end to minimize holes.
      */
diff --git a/accel/accel-common.c b/accel/accel-common.c
index eecb2a292af..9c5b4111c8d 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -37,23 +37,10 @@ static void accel_init_cpu_int_aux(ObjectClass *klass, void *opaque)
     CPUClass *cc = CPU_CLASS(klass);
     AccelCPUClass *accel_cpu = opaque;
 
-    /*
-     * The first callback allows accel-cpu to run initializations
-     * for the CPU, customizing CPU behavior according to the accelerator.
-     *
-     * The second one allows the CPU to customize the accel-cpu
-     * behavior according to the CPU.
-     *
-     * The second is currently only used by TCG, to specialize the
-     * TCGCPUOps depending on the CPU type.
-     */
     cc->accel_cpu = accel_cpu;
     if (accel_cpu->cpu_class_init) {
         accel_cpu->cpu_class_init(cc);
     }
-    if (cc->init_accel_cpu) {
-        cc->init_accel_cpu(accel_cpu, cc);
-    }
 }
 
 /* initialize the arch-specific accel CpuClass interfaces */
-- 
2.53.0


