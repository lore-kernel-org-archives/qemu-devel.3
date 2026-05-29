Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E647CD6E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 19:52:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT3Er-0008Jy-4Z; Fri, 29 May 2026 15:51:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wT3En-0007u4-L3
 for qemu-devel@nongnu.org; Fri, 29 May 2026 15:51:21 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wT3El-0004xQ-CD
 for qemu-devel@nongnu.org; Fri, 29 May 2026 15:51:21 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-45eedcdaeaaso1374853f8f.3
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 12:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780084277; x=1780689077; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xN08zAfKjwU0dgbBSed5OKjgOJn32PYWdXU4H33xVTk=;
 b=Twx78MLvbHTNBgn+nVgvrdi0XaxIPzijUJdFqzfLIowrtbO0VxwLS2bqFsCX4J27gn
 1Tcj5GM6bX//b2Vyy5AG+M88jAzfzlXPwGnQPINFjlC150sMZxpa4PPjaTT9OkQTrqnc
 PZ73BH9X4IErGp2CFjHEuId8B/ZmARRq/5yRxEGtsF7cV+C3CIdyFJf6MjeNRddP5kgD
 Tn/bHD9pNq/XAkG9twpBFMEcrgoGyAv2CZlL+4TIrZFph3kkXSk4aj3rMzLhOoh7ecve
 +9aAwu96L0HBX2xpTiIG41lw3rECCCTzqpIU/qhAsnpYQZyehWYYiKPNuY7ar+5bdeeO
 hUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780084277; x=1780689077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xN08zAfKjwU0dgbBSed5OKjgOJn32PYWdXU4H33xVTk=;
 b=cXBd7082uViA/QvwYen8Vhr8pOmW+N17ZyfYh0Bp2TU5PBg28+j6Z9oi1sS2MXkcYP
 Iph+qyFKYbY1XBy9gq1wajmG17LTmwWCZI+uthWnKcjmp6ITxce+/vzHdYhmwMTcoLEr
 DLtfoshUg6mPDYvZ3P3RspeIQk/y65pr1VXxa5l9Oj7UBMwWhK9O27M9B5s3448j5P2x
 xhcjGcgOOP1eIxflqGdzb/tNg19fPexJ381n6jj3mT3I1TAdIrTlrrEQRoh/QJjZwG/b
 tU0T3EbBIWmUOskRs2UL5kOFcEiI7MS3Y3Nl51XSpNHNiYN772wnMVw4IHEgaX056Xex
 /fWQ==
X-Gm-Message-State: AOJu0YwupGgF6k9rQar1EqoJQ8gh6r7KTYes25KndPEDo6ipQ1/5YvDf
 +NWiETnvUIiQT89ikrNlFqobejlftARyD1WVs3FiBitv4w1FSuOZe1GXjEF6dpDUh18WFlkMpeh
 kHjRqm4p4uQ==
X-Gm-Gg: Acq92OHxhIemsHk2CNoT4qLsgdv4BAfvnqMq9TkdvJcLIK7G7yctEmU2BNllvUNKCDh
 6expBrKkaGFE0GxDFad21fNmh8NIiJY95dZok2eHVKxB6Nt3icI3aazwIQBJzQp72ZvEmlmVEur
 ZR1Wg8bmgIyctXfZoYKjc640H5jKBhnSdQq+UlTh7sUqYQ1D9glWbysoG/Nz+5McP+VtOHjaswk
 UCeu5MVGTFnAo/VISbSP8uaJ27U3GRQ19f8VehV4hm1V3F1P2VKsaXeGmoCM+R3i9fQCTVUzYfU
 fxtliNgiKSFaGSaKGQC6NMvRBfUbWp3wjeGCMuEy+bBEOdTrFQ9BdczmRBw3An2i0qa6SYqU41d
 BtACuG6P+os59dskcVwrY9Angtx7gFQscF3agOoaMuUqtMBAKtXa5xnQMtsxFbQnLho9qPog0Y0
 nvlBSlj/+z1AI1gmLw39lcbwaIfKrHaqvAiuZKjpttgvHoTut97Ie3uLIx9NpeCcYOkPzUGJt5Y
 Nl5
X-Received: by 2002:adf:ed43:0:b0:43d:7dcf:ae26 with SMTP id
 ffacd0b85a97d-45ef6b78552mr1840866f8f.34.1780084277341; 
 Fri, 29 May 2026 12:51:17 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef34bcc30sm5738817f8f.12.2026.05.29.12.51.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 29 May 2026 12:51:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Weiwei Li <liwei1518@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 kvm@vger.kernel.org, qemu-s390x@nongnu.org,
 Chao Liu <chao.liu.zevorn@gmail.com>, David Hildenbrand <david@kernel.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Anton Johansson <anjo@rev.ng>, Claudio Fontana <cfontana@suse.de>,
 Eric Farman <farman@linux.ibm.com>, Alexander Graf <agraf@csgraf.de>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Cornelia Huck <cohuck@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Reinoud Zandijk <reinoud@netbsd.org>, Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 11/17] accel/tcg: Convert AccelCPUClass -> new
 TCGCPUOps::cpu_instance_init
Date: Fri, 29 May 2026 21:49:33 +0200
Message-ID: <20260529194940.97143-12-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529194940.97143-1-philmd@linaro.org>
References: <20260529194940.97143-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Introduce a TCGCPUOps::cpu_instance_init hook and call it with
tcg_cpu_instance_init(). Register tcg_cpu_instance_init() as
AccelOpsClass::cpu_instance_init.

At the same time, convert X86 and RISCV AccelCPUClass hooks,
after forward-declaring each target method (to avoid moving
code around).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 accel/tcg/tcg-accel-ops.h   | 1 +
 include/accel/tcg/cpu-ops.h | 1 +
 accel/tcg/cpu-exec.c        | 9 +++++++++
 accel/tcg/tcg-accel-ops.c   | 1 +
 target/i386/tcg/tcg-cpu.c   | 5 +++--
 target/riscv/tcg/tcg-cpu.c  | 4 +++-
 6 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops.h b/accel/tcg/tcg-accel-ops.h
index aecce605d7b..be712c02efd 100644
--- a/accel/tcg/tcg-accel-ops.h
+++ b/accel/tcg/tcg-accel-ops.h
@@ -14,6 +14,7 @@
 
 #include "system/cpus.h"
 
+void tcg_cpu_instance_init(CPUState *cpu);
 void tcg_cpu_destroy(CPUState *cpu);
 int tcg_cpu_exec(CPUState *cpu);
 void tcg_handle_interrupt(CPUState *cpu, int mask);
diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index 5950cdcaab1..d7d329e419d 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -48,6 +48,7 @@ struct TCGCPUOps {
      * Called when the first CPU is realized.
      */
     void (*initialize)(void);
+    void (*cpu_instance_init)(CPUState *cpu);
     /**
      * @translate_code: Translate guest instructions to TCGOps
      * @cpu: cpu context
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index ad94f96b252..ef44c12b601 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -1045,6 +1045,15 @@ int cpu_exec(CPUState *cpu)
     return ret;
 }
 
+void tcg_cpu_instance_init(CPUState *cpu)
+{
+    const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
+
+    if (tcg_ops->cpu_instance_init) {
+        tcg_ops->cpu_instance_init(cpu);
+    }
+}
+
 bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
 {
     static bool tcg_target_initialized;
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 3bd98005042..381f1614923 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -219,6 +219,7 @@ static void tcg_accel_ops_init(AccelClass *ac)
         }
     }
 
+    ops->cpu_instance_init = tcg_cpu_instance_init;
     ops->cpu_reset_hold = tcg_cpu_reset_hold;
     ops->supports_guest_debug = tcg_supports_guest_debug;
     ops->insert_breakpoint = tcg_insert_breakpoint;
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index 6f5dc06b3b9..04bb9787575 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -157,6 +157,8 @@ static vaddr x86_pointer_wrap(CPUState *cs, int mmu_idx,
 }
 #endif
 
+static void x86_tcg_cpu_instance_init(CPUState *cs);
+
 const TCGCPUOps x86_tcg_ops = {
     .mttcg_supported = true,
     .precise_smc = true,
@@ -165,6 +167,7 @@ const TCGCPUOps x86_tcg_ops = {
      */
     .guest_default_memory_order = TCG_MO_ALL & ~TCG_MO_ST_LD,
     .initialize = tcg_x86_init,
+    .cpu_instance_init = x86_tcg_cpu_instance_init,
     .translate_code = x86_translate_code,
     .get_tb_cpu_state = x86_get_tb_cpu_state,
     .synchronize_from_tb = x86_cpu_synchronize_from_tb,
@@ -237,8 +240,6 @@ static void x86_tcg_cpu_accel_class_init(ObjectClass *oc, const void *data)
 #ifndef CONFIG_USER_ONLY
     acc->cpu_target_realize = tcg_cpu_realizefn;
 #endif /* CONFIG_USER_ONLY */
-
-    acc->cpu_instance_init = x86_tcg_cpu_instance_init;
 }
 static const TypeInfo x86_tcg_cpu_accel_type_info = {
     .name = ACCEL_CPU_NAME("tcg"),
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 3e22e7ed53d..703c2d9bd0a 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -268,11 +268,14 @@ static vaddr riscv_pointer_wrap(CPUState *cs, int mmu_idx,
 }
 #endif
 
+static void riscv_tcg_cpu_instance_init(CPUState *cs);
+
 const TCGCPUOps riscv_tcg_ops = {
     .mttcg_supported = true,
     .guest_default_memory_order = 0,
 
     .initialize = riscv_translate_init,
+    .cpu_instance_init = riscv_tcg_cpu_instance_init,
     .translate_code = riscv_translate_code,
     .get_tb_cpu_state = riscv_get_tb_cpu_state,
     .synchronize_from_tb = riscv_cpu_synchronize_from_tb,
@@ -1678,7 +1681,6 @@ static void riscv_tcg_cpu_accel_class_init(ObjectClass *oc, const void *data)
 {
     AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
 
-    acc->cpu_instance_init = riscv_tcg_cpu_instance_init;
     acc->cpu_target_realize = riscv_tcg_cpu_realize;
 }
 
-- 
2.53.0


