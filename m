Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E10E937E7
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 21:26:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wC2Jd-0007qY-Bj; Sun, 12 Apr 2026 17:26:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wC2JX-0007qF-Qc
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 17:25:57 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wC2JV-00076R-PS
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 17:25:55 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso40157345e9.0
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 14:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776029150; x=1776633950; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Z8VZn4FxpRf32y6yQiXLMXIl12GmZ01c/kHgJ1+ertw=;
 b=wwzQEL5It95IHu11Sufj603V6bpjQHqEwm7FmK36PT+QjWsFUDEtDsp7vMqn2K3KMt
 t4vl41Lm6N2lUER3wG9EZfaS0JT4PYNMAMl9RoXnLyKeRFXkm2SCT9UEexZMh/izBNoC
 DWOvtEKHZgj3FAltG/lg6IxqI9ZLBscGsZX9WpjH4P5jo7aEwpqqHo3ba+J5td9/obXf
 MgY6UBXdZ7Ca83p4bmUSCllo3YWNXQMKltJXiIEmp4U0bwyjMeUYhTsj/GsUF3qAbsC2
 zyj2SO7h5YI5m8J1D5sw1gyefAqutoWeaUqtn5iL0KxV+s3UTUq5um85W74yLux7r9v6
 mN7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776029150; x=1776633950;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z8VZn4FxpRf32y6yQiXLMXIl12GmZ01c/kHgJ1+ertw=;
 b=IiWPKgOq7MJ7Q6lHY7AgH85Z62DCeGosd5/vqmTlk5xx4euUevZGnTbK5GOYvENx+M
 Lby8IfVd0HxjKISno3JL2SO9gjnhuDmzMbojmZCnhlOp+58Z1Nzog6/z93b+xg3RYbjX
 lvRm+ZMxPPF+xUMs61jTWUdGR9dS7he4oMfU9bfwAwCR1nfqb5wMytgA4OUloLYY9zzI
 pcSSR38ZHlAhV237Qof8Hr8g366Rv2unWh2a4WgdZRkjL2WCYTbhKIh7rd/ATxZgWily
 CkVZTC6+GhCX3BPV1lkHnd/FgRsd6fsuJBjuFIMykGEMYndNh6b4O+G8LNeysGc9iCqX
 h/Xg==
X-Gm-Message-State: AOJu0YwsaAfCm0XJUGRq5adThn+juzOhh44S+Za0BNhfgpeNuCreGAOZ
 cEG9nhvt8VS0zfFO4aYp9uOKQ4qPUSnF176Eu8ZrbjQNzn9jxxA5is19bxweexbsmdlKdwFj4jW
 Jp7KqMVg=
X-Gm-Gg: AeBDiesPace+1G8bS6EXM6Lyd71qqwydTiAt47f83B9hLuCnpBbYJRcHzdSiPy3VvRP
 5leBFFZZaXDZvVY39jbtaw82qHrf8BM8B4FXTIqRR7GheMh2LX3anOcrDDLAfpfevju7K/en5au
 7TmYgpC9LtlV3SGHeYznBdP/QNdA+Y5WKkFksed7Bk01JMe5QyuZ5hqa1MeRU2TjMBkMAQjtAtT
 yL0+KnE2eLQ0U3bWBt+gQsxbNp5YodwbOR4LrTo0Ju5XcU8UXamjucCyZBMablhPumMKC6asWOq
 g+6fCpMHUb98XrWh2UhmGRzge8ECXIONz4sUte6QDVbHSvw1XEwLzJ454a05My87TzszEdA4pMJ
 MZ9+8OwOk9a8fJCAgZ2pbuS2f1CVFdW2CwgNBhKdEQ9oloEnS2+gVbY+alEnpKnBmF4IodQYLRH
 aA1TFyghRGIc3Oj7PVW6WME/3u1SVth8WnSPD5SYdIXtk35coBFGHTHy9YHx4126Y7VaCqXSpk
X-Received: by 2002:a05:600c:c10c:b0:486:faa8:9e4 with SMTP id
 5b1f17b1804b1-488d68cb8demr85362455e9.12.1776029150445; 
 Sun, 12 Apr 2026 14:25:50 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d6864121sm78508835e9.28.2026.04.12.14.25.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Apr 2026 14:25:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH] cpus: Remove CPUClass::init_accel_cpu() left-over hook
Date: Sun, 12 Apr 2026 23:25:47 +0200
Message-ID: <20260412212547.29645-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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
---
 include/hw/core/cpu.h |  6 ------
 accel/accel-common.c  | 13 -------------
 2 files changed, 19 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 04e1f970caf..cd03187e116 100644
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


