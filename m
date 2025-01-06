Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52982E77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 20:05:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUtJr-0002aJ-92; Mon, 06 Jan 2025 15:03:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUtJo-0002ZZ-72
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 15:03:21 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUtJl-0003Al-Gw
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 15:03:19 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4361b6f9faeso89226975e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 12:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736193795; x=1736798595; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xubr80DdDK1TQnuEw657hT2ILmCSL1Bi/K/I0ME5hpI=;
 b=xF7qbtvWNIykbu1ysX4Uc7/rJdNjL2LLtaLRDO1qre/XI6xhi3MWttFHLtMzJDMzD+
 NYCAlgS0wsZGGObsIXojRlTCWC1q494MK5OfpdG82RsHbPVwI6WyjaX/xFmrEfLbudmY
 IQDWee9q07bb3mSb7Hsg3vZ+M5HvDKfWay9TM3MZWqMP26PgjD/eMdWwUdpGER2JUkJL
 uq1bGtLr9DnLPMlDHhdvD55YkceSUFaetnc6WBVK3J4F4lzqDvoUaJGuGLvYa4OYKey5
 cgFQwSGzbehZvaJQ8kz0eJ57cEjBaiWJXX3k55ZefN1xBQznK6u6FytEhoS4Rqf4aphS
 0yAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736193795; x=1736798595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xubr80DdDK1TQnuEw657hT2ILmCSL1Bi/K/I0ME5hpI=;
 b=sqEeviWFk+xNbGOYUa3DPyMVxVGyDbuWORjNEHqe2vxMk92QPJEHBNwar1omFBptEn
 4zNZwIMFM737xjdOkGi0ognvC7LFeDkyUjKOKW5+N17dSRiiSDG8zoUqGfQ+1/Wj1AFY
 6Wiepo+p5SU7/2TWgCRhBEtn7yfTlSLlj5PIDHadR0c7qfnCl5VyjdXHsj3IrL0ma32r
 qmOsfBLTjg2WHc0Y7d7Farf3D58u8q4rPU5a0G1LThEJferlq306AhMJ9UzZoXSM+QHC
 pLAf5QMydEuIxya4zZIX8a1WNzcFjan4rOR00PGxi7/C1ecTRzHbzH6NDS+BgmY8VEYH
 HMzA==
X-Gm-Message-State: AOJu0YzLlMrTKUltUITW+z6AMIrWqA9Uko55h6QgeJh11gAwc7EKwxFI
 f2Rsmvb0DY92qsBlmu6wF2haSUw7rV9/PEQ9AMwuW/3V5ejM2lBfrLDUdU7jP1ibIvqANjXACR/
 iRZg=
X-Gm-Gg: ASbGnct3rEzuPrWWBistgJs4Z12tCy7fs8soiVckhVINGHJ4IstWX5NAx2Gm+uiuFcm
 Uojj3q2ifIXy3lstBOLTfqUsM36yWp0BO33/aqOj8PQWjwA0VpFITO8p4sqnZJakYQMK5639yJ5
 A1qQO7/TdhXywxDW1gXb2tSHkUtplc+LXgsUVQQwOXb/rLLvfUlNrlcYbF0dDcD07B6BLmosWxG
 RyQsPjzI0y0Td09jJ908NFopPzlmHYyQQ/160/Uor5ikawM2ruwrkHmxkvWkmGIZWRBl1ldlCuF
 pyO9peimPgYN9DaFBYZzoVqdRd47BIw=
X-Google-Smtp-Source: AGHT+IG6hn6gQ1rEDpo0RUo5rK6HsOddWfOpcS85mXtVNMxlfkCCUdnnKaA6rQB2Q6OTZ5JLDkEevw==
X-Received: by 2002:a05:600c:1d12:b0:436:1b86:f05 with SMTP id
 5b1f17b1804b1-436dc20b0c1mr4405765e9.11.1736193795597; 
 Mon, 06 Jan 2025 12:03:15 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4366128a353sm577748615e9.42.2025.01.06.12.03.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Jan 2025 12:03:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Cameron Esfahani <dirty@apple.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Alexander Graf <agraf@csgraf.de>, Paul Durrant <paul@xen.org>,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 xen-devel@lists.xenproject.org, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Reinoud Zandijk <reinoud@netbsd.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org,
 Riku Voipio <riku.voipio@iki.fi>, Anthony PERARD <anthony@xenproject.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Zhao Liu <zhao1.liu@intel.com>, Phil Dennis-Jordan <phil@philjordan.eu>,
 David Woodhouse <dwmw2@infradead.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Anton Johansson <anjo@rev.ng>
Subject: [RFC PATCH 2/7] cpus: Introduce AccelOpsClass::get_cpus_queue()
Date: Mon,  6 Jan 2025 21:02:53 +0100
Message-ID: <20250106200258.37008-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106200258.37008-1-philmd@linaro.org>
References: <20250106200258.37008-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We want the ability to iterate over vCPUs of a specific
accelerator.  Introduce cpus_get_accel_cpus_queue() to
be used by accelerator common code, and expose the
get_cpus_queue() in AccelOpsClass, so each accelerator
can register its own queue of vCPUs.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/cpu.h      |  8 ++++++++
 include/system/accel-ops.h |  6 ++++++
 accel/tcg/user-exec-stub.c |  5 +++++
 cpu-common.c               | 10 ++++++++++
 system/cpus.c              |  5 +++++
 5 files changed, 34 insertions(+)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 48d90f50a71..5ae9bb64d6e 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -591,6 +591,14 @@ static inline CPUArchState *cpu_env(CPUState *cpu)
 typedef QTAILQ_HEAD(CPUTailQ, CPUState) CPUTailQ;
 extern CPUTailQ cpus_queue;
 
+/**
+ * cpus_get_accel_cpus_queue:
+ * @cpu: The vCPU to get the accelerator #CPUTailQ.
+ *
+ * Returns the #CPUTailQ associated with the accelerator of the vCPU.
+ */
+CPUTailQ *cpus_get_accel_cpus_queue(CPUState *cpu);
+
 #define first_cpu        QTAILQ_FIRST_RCU(&cpus_queue)
 #define CPU_NEXT(cpu)    QTAILQ_NEXT_RCU(cpu, node)
 #define CPU_FOREACH(cpu) QTAILQ_FOREACH_RCU(cpu, &cpus_queue, node)
diff --git a/include/system/accel-ops.h b/include/system/accel-ops.h
index 137fb96d444..fe59f728bfc 100644
--- a/include/system/accel-ops.h
+++ b/include/system/accel-ops.h
@@ -12,6 +12,7 @@
 
 #include "exec/vaddr.h"
 #include "qom/object.h"
+#include "hw/core/cpu.h"
 
 #define ACCEL_OPS_SUFFIX "-ops"
 #define TYPE_ACCEL_OPS "accel" ACCEL_OPS_SUFFIX
@@ -37,6 +38,11 @@ struct AccelOpsClass {
     bool (*cpus_are_resettable)(void);
     void (*cpu_reset_hold)(CPUState *cpu);
 
+    /**
+     * get_cpus_queue:
+     * Returns the #CPUTailQ maintained by this accelerator.
+     */
+    CPUTailQ *(*get_cpus_queue)(void);
     void (*create_vcpu_thread)(CPUState *cpu); /* MANDATORY NON-NULL */
     void (*kick_vcpu_thread)(CPUState *cpu);
     bool (*cpu_thread_is_idle)(CPUState *cpu);
diff --git a/accel/tcg/user-exec-stub.c b/accel/tcg/user-exec-stub.c
index 4fbe2dbdc88..cb76cec76be 100644
--- a/accel/tcg/user-exec-stub.c
+++ b/accel/tcg/user-exec-stub.c
@@ -18,6 +18,11 @@ void cpu_exec_reset_hold(CPUState *cpu)
 {
 }
 
+CPUTailQ *cpus_get_accel_cpus_queue(CPUState *cpu)
+{
+    return NULL;
+}
+
 /* User mode emulation does not support record/replay yet.  */
 
 bool replay_exception(void)
diff --git a/cpu-common.c b/cpu-common.c
index 4248b2d727e..ff8db9c7f9d 100644
--- a/cpu-common.c
+++ b/cpu-common.c
@@ -82,6 +82,7 @@ unsigned int cpu_list_generation_id_get(void)
 void cpu_list_add(CPUState *cpu)
 {
     static bool cpu_index_auto_assigned;
+    CPUTailQ *accel_cpus_queue = cpus_get_accel_cpus_queue(cpu);
 
     QEMU_LOCK_GUARD(&qemu_cpu_list_lock);
     if (cpu->cpu_index == UNASSIGNED_CPU_INDEX) {
@@ -92,17 +93,26 @@ void cpu_list_add(CPUState *cpu)
         assert(!cpu_index_auto_assigned);
     }
     QTAILQ_INSERT_TAIL_RCU(&cpus_queue, cpu, node);
+    if (accel_cpus_queue) {
+        QTAILQ_INSERT_TAIL_RCU(accel_cpus_queue, cpu, node);
+    }
+
     cpu_list_generation_id++;
 }
 
 void cpu_list_remove(CPUState *cpu)
 {
+    CPUTailQ *accel_cpus_queue = cpus_get_accel_cpus_queue(cpu);
+
     QEMU_LOCK_GUARD(&qemu_cpu_list_lock);
     if (!QTAILQ_IN_USE(cpu, node)) {
         /* there is nothing to undo since cpu_exec_init() hasn't been called */
         return;
     }
 
+    if (accel_cpus_queue) {
+        QTAILQ_REMOVE_RCU(accel_cpus_queue, cpu, node);
+    }
     QTAILQ_REMOVE_RCU(&cpus_queue, cpu, node);
     cpu->cpu_index = UNASSIGNED_CPU_INDEX;
     cpu_list_generation_id++;
diff --git a/system/cpus.c b/system/cpus.c
index 99f83806c16..972df6ab061 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -209,6 +209,11 @@ void cpu_exec_reset_hold(CPUState *cpu)
     }
 }
 
+CPUTailQ *cpus_get_accel_cpus_queue(CPUState *cpu)
+{
+    return cpus_accel ? cpus_accel->get_cpus_queue() : NULL;
+}
+
 int64_t cpus_get_virtual_clock(void)
 {
     /*
-- 
2.47.1


