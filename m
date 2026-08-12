Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44971C5CFCF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:23:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8qU-00016Q-T5; Wed, 12 Aug 2026 09:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu8mF-0004EZ-ID
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 09:13:54 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu8mB-0006u8-EJ
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 09:13:50 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CB46Lu3265804
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 13:13:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lnwwQTsj4uykQtQK5I2PSMwd23zuzWxOWZdTcugtZPU=; b=UHqJtlJs/9/p8o3A
 RmB7KUjSt2dU0pO6lbpSIOBUa1sVkZa5QGHsmbe5YrmOk4pMSNHk6CR7jnv7ZG3e
 3VNCpfJXPlwyhvA7bpXYwSq2gSW/GgDs5G50w7vNBdfwoX1mGVG3CVP5l/BuSNIt
 v/GzlCzds4gXsml6CznKbyU/Z6gXYzehXYgn879nznFhDihQCHUq3XjQXrLWImnQ
 hWn+bIr/PlcMKJP10bcfqfNfAamOghm5BMZ6DNAYiIgvSB4HTVVOdVWxSYOHxnkE
 WYFIFfr70IYJi4RUVMqHQbhDInZjz2oaQ7iMvye0nSn1/RZBbh3HypaBmCQSx142
 NCjnow==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g08jrky00-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 13:13:45 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c0408254aso28878191cf.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 06:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786540425; x=1787145225; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lnwwQTsj4uykQtQK5I2PSMwd23zuzWxOWZdTcugtZPU=;
 b=dKvYTu8XKxj7bcezFylO44nVO30DOPZaC7GY+aOmJkIksxe5aLMnYupu7no2uWN7es
 02i3rSHuMXHEgwI8Viz+7TOKnZt6sfWeyJc8+lKaplA/xR40Za1ylK3xaEFaavqZ/tkk
 Em1JkHAOPqjS4/tGG7iL4FTFP/iIyqNR+/3w9KrTfgSzOmL822sj1n02F8HNTqpHK4xH
 L0BhcZrJG2xLQ4OnXQTOjEk5Dqopf9LQ3lvqOu1RIag6a99rZG/OtkC1FzZ7g1yHPmqF
 J+JAkqUh9ZU0Xy2FxrWL7ajBOPZ7+cgN2Gz36UgKnS+bd/qSaGLBR7h8xv/E+S7eNz9m
 Qy7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786540425; x=1787145225;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lnwwQTsj4uykQtQK5I2PSMwd23zuzWxOWZdTcugtZPU=;
 b=KrjDFGlHdpJn2Osq/kAqNr6p/uxWLX92nQqulb43+Mz/r202ac99UD1Qo5JHOZKBvM
 7ugXsj9bcWop00/c1ow0d1QZ2iD0BYeVDGC8BMeYKzZGfvecCzhd7TXVvy44SfFhU7LS
 dFEZMenLJ6lSJ8cIRS35e+mdCdS+kOSEjs6dnIpa1dFaF8JlXanviGs7yDjUBwf4ZC0i
 L8tY7aHOAB7yFxrF/adRxYaV9wLJOpob+qe361gEvs579U4gYpap2biUHh6en3TSfcsO
 F0O6bCEsx6ZddqXS52VDBpt7QH5Vbd7TUckNzY5CFQFG6C0xuAEQvn99oLgGui1YCOJi
 F7DQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr5fbc5mCsd7o91rqbH4N/kmmebK7RjCNIN1TjSHefMIFy0hVaORNxDaXGkUDHLyxML+DCOeIOcOJql@nongnu.org
X-Gm-Message-State: AOJu0YyNnt4JG8CUH5rQL3cCLwzCTbM5zJ6yCr209tABuTr++Me0SqhF
 Ba0Up0Ey0PjOMTEZwKRLVkXcqRp63/sVPHDOFqnZJlcxmiJcRuY8MZX/JreDkvp6+XbwVHqaevv
 /dGRG1ts88Cme6f4YGbF4fbuSuCHCzPb8x/cZP2ZCI1TdGgHyJ/ixbUAqvg==
X-Gm-Gg: AR+sD13y9bob2Boll8FPH05qKV7TVgdLgrkRr477KDD6eW1r5O6cLnjbVFlKJek9TMR
 Pnao6cooCM/nulAMrblDrZy5uA0r3jKn6B49VpeWHIz82f9dE11gD/iTNlUNCqUELlqY2cNsTEw
 OOO/Br17qomdQVeJqoFv0ABX5e/5hB2PC6XANypgwx5EZDisg9mH6ykC4qWSz8d691lWNGNnyTE
 mJ+MHm6cQHFfeVhZkBKQcCv9kgwGhwS8JDTo/l6hsqguUqtsib6WtzBoBOnaMiPdJxiKY6DmfEg
 3LkU9NnrBFfWyKPb4HtuHX5H02k2zLWoQYkG6F1AdR9edZRmnplKeVGpggDPNAs/zIgv7v3j4rG
 tYsDa4Ed4egzYzMW8JvDYV6IsaDfCNN9MjJvZ1ALiKA==
X-Received: by 2002:a05:622a:48a:b0:51c:1f35:4638 with SMTP id
 d75a77b69052e-52d60365125mr67869891cf.21.1786540424849; 
 Wed, 12 Aug 2026 06:13:44 -0700 (PDT)
X-Received: by 2002:a05:622a:48a:b0:51c:1f35:4638 with SMTP id
 d75a77b69052e-52d60365125mr67869071cf.21.1786540424176; 
 Wed, 12 Aug 2026 06:13:44 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997c94d159sm43959605e9.7.2026.08.12.06.13.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 06:13:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH v2 16/16] system: Move runstate-related code from cpus.c to
 runstate.c
Date: Wed, 12 Aug 2026 15:11:47 +0200
Message-ID: <20260812131147.83188-17-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812131147.83188-1-philmd@oss.qualcomm.com>
References: <20260812131147.83188-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Az5OlNe2pBrmnKg_KIhh8kD7-XR4TiHr
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEwNyBTYWx0ZWRfX5sDzsm8gSljs
 ugBO8b86sFWKq8YExVSNJ/RVktq9UN8FgCZWh7TfFQWn0d0KJkiBKkscvTBod7oSzmSLihZ8V7z
 NR6cDrFYdlmmN31lTqKGDJ2Fe7cvyys=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEwNyBTYWx0ZWRfX979nDfQvyGXu
 pGgtUWG8R6JXwyff8MOchhaOni0Xro4eIKpKuZwYjkXV4a0GEesRzivBuWIlWc24VX4ymr751Im
 SUZjc/J5Ftd+lhOFkeJClgHYbAPfehB/gZlk/f5oTSRKlufEjfufcR0zKLDewL7RVCu30ANoan+
 c9rBC3j71po9CaOpwLRd8yCtlsseB7fKX2Qp27w19LYkNZFpz/CDEzVyYPz7AxntI2fWiQ2eUlz
 8AYQsKxMaspXGPmhCfcniS2KtxyxXcgip4spgY0yOXlTRuhI2ttAjFWoI60WOuwzCKDK+v2FBzw
 q2adz8K8uA/jjpdPrBmenVGFDAzpJAXgFy2Doklx2uLbXfY294xhGW9GpF9dRgmcNZKwWqkz5t3
 6hgCLXbCZIWBF+ww8kD3iehwu6PTQVzCmRv6aiZTqHTq0JpYBXcsPURUiTr48Gty5k1ERdq1tKN
 5qm4Sia4oNlENkGdhbQ==
X-Authority-Analysis: v=2.4 cv=Z7Dc2nRA c=1 sm=1 tr=0 ts=6a7c718a cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=QK4PlI00PMcCPjLnJOMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: Az5OlNe2pBrmnKg_KIhh8kD7-XR4TiHr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120107
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Keep cpus.c focused on vCPUs handling, move code related to
VM state to runstate.c where similar code lives.

Fix few checkpatch.pl warnings:

  WARNING: Block comments use a leading /* on a separate line
  WARNING: Block comments use * on subsequent lines
  #327: FILE: system/runstate.c:541:
  +/* does a state transition even if the VM is already stopped,
  +   current state is forgotten forever */

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 system/cpus.c     | 147 -------------------------------------------
 system/runstate.c | 154 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 154 insertions(+), 147 deletions(-)

diff --git a/system/cpus.c b/system/cpus.c
index 43ff10cf008..f37e215c586 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -25,7 +25,6 @@
 #include "qemu/osdep.h"
 #include "qemu/coroutine-tls.h"
 #include "qapi/error.h"
-#include "qapi/qapi-events-run-state.h"
 #include "exec/gdbstub.h"
 #include "accel/accel-cpu-ops.h"
 #include "system/hw_accel.h"
@@ -272,58 +271,6 @@ void cpu_interrupt(CPUState *cpu, int mask)
     cpus_accel->handle_interrupt(cpu, mask);
 }
 
-/*
- * True if the vm was previously suspended, and has not been woken or reset.
- */
-static int vm_was_suspended;
-
-void vm_set_suspended(bool suspended)
-{
-    vm_was_suspended = suspended;
-}
-
-bool vm_get_suspended(void)
-{
-    return vm_was_suspended;
-}
-
-static int do_vm_stop(RunState state, bool send_stop)
-{
-    int ret = 0;
-    RunState oldstate = runstate_get();
-
-    if (runstate_is_live(oldstate)) {
-        vm_was_suspended = (oldstate == RUN_STATE_SUSPENDED);
-        runstate_set(state);
-        cpu_disable_ticks();
-        if (oldstate == RUN_STATE_RUNNING) {
-            pause_all_vcpus();
-        }
-        ret = vm_state_notify(0, state);
-        if (send_stop) {
-            qapi_event_send_stop();
-        }
-    }
-
-    bdrv_drain_all();
-    /*
-     * Even if vm_state_notify() return failure,
-     * it would be better to flush as before.
-     */
-    ret |= bdrv_flush_all();
-    trace_vm_stop_flush_all(ret);
-
-    return ret;
-}
-
-/* Special vm_stop() variant for terminating the process.  Historically clients
- * did not expect a QMP STOP event and so we need to retain compatibility.
- */
-int vm_shutdown(void)
-{
-    return do_vm_stop(RUN_STATE_SHUTDOWN, false);
-}
-
 bool cpu_can_run(CPUState *cpu)
 {
     if (cpu->stop) {
@@ -734,97 +681,3 @@ void cpu_stop_current(void)
         cpu_exit(current_cpu);
     }
 }
-
-int vm_stop(RunState state)
-{
-    if (qemu_in_vcpu_thread()) {
-        qemu_system_vmstop_request_prepare();
-        qemu_system_vmstop_request(state);
-        /*
-         * FIXME: should not return to device code in case
-         * vm_stop() has been requested.
-         */
-        cpu_stop_current();
-        return 0;
-    }
-
-    return do_vm_stop(state, true);
-}
-
-/**
- * Prepare for (re)starting the VM.
- * Returns 0 if the vCPUs should be restarted, -1 on an error condition,
- * and 1 otherwise.
- */
-int vm_prepare_start(bool step_pending)
-{
-    int ret = vm_was_suspended ? 1 : 0;
-    RunState state = vm_was_suspended ? RUN_STATE_SUSPENDED : RUN_STATE_RUNNING;
-    RunState requested;
-
-    qemu_vmstop_requested(&requested);
-    if (runstate_is_running() && requested == RUN_STATE__MAX) {
-        return -1;
-    }
-
-    /* Ensure that a STOP/RESUME pair of events is emitted if a
-     * vmstop request was pending.  The BLOCK_IO_ERROR event, for
-     * example, according to documentation is always followed by
-     * the STOP event.
-     */
-    if (runstate_is_running()) {
-        qapi_event_send_stop();
-        qapi_event_send_resume();
-        return -1;
-    }
-
-    /*
-     * WHPX accelerator needs to know whether we are going to step
-     * any CPUs, before starting the first one.
-     */
-    accel_pre_resume(MACHINE(qdev_get_machine()), step_pending);
-
-    /* We are sending this now, but the CPUs will be resumed shortly later */
-    qapi_event_send_resume();
-
-    cpu_enable_ticks();
-    runstate_set(state);
-    vm_state_notify(1, state);
-    vm_was_suspended = false;
-    return ret;
-}
-
-void vm_start(void)
-{
-    if (!vm_prepare_start(false)) {
-        resume_all_vcpus();
-    }
-}
-
-void vm_resume(RunState state)
-{
-    if (runstate_is_live(state)) {
-        vm_start();
-    } else {
-        runstate_set(state);
-    }
-}
-
-/* does a state transition even if the VM is already stopped,
-   current state is forgotten forever */
-int vm_stop_force_state(RunState state)
-{
-    if (runstate_is_live(runstate_get())) {
-        return vm_stop(state);
-    } else {
-        int ret;
-        runstate_set(state);
-
-        bdrv_drain_all();
-        /* Make sure to return an error if the flush in a previous vm_stop()
-         * failed. */
-        ret = bdrv_flush_all();
-        trace_vm_stop_flush_all(ret);
-        return ret;
-    }
-}
diff --git a/system/runstate.c b/system/runstate.c
index 08acf801b0e..d3e64d2b625 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -52,6 +52,7 @@
 #include "qemu/thread.h"
 #include "qom/object.h"
 #include "qom/object_interfaces.h"
+#include "system/cpu-timers.h"
 #include "system/cpus.h"
 #include "system/qtest.h"
 #include "system/replay.h"
@@ -408,6 +409,159 @@ int vm_state_notify(bool running, RunState state)
     return ret;
 }
 
+/*
+ * True if the vm was previously suspended, and has not been woken or reset.
+ */
+static int vm_was_suspended;
+
+void vm_set_suspended(bool suspended)
+{
+    vm_was_suspended = suspended;
+}
+
+bool vm_get_suspended(void)
+{
+    return vm_was_suspended;
+}
+
+static int do_vm_stop(RunState state, bool send_stop)
+{
+    int ret = 0;
+    RunState oldstate = runstate_get();
+
+    if (runstate_is_live(oldstate)) {
+        vm_was_suspended = (oldstate == RUN_STATE_SUSPENDED);
+        runstate_set(state);
+        cpu_disable_ticks();
+        if (oldstate == RUN_STATE_RUNNING) {
+            pause_all_vcpus();
+        }
+        ret = vm_state_notify(0, state);
+        if (send_stop) {
+            qapi_event_send_stop();
+        }
+    }
+
+    bdrv_drain_all();
+    /*
+     * Even if vm_state_notify() return failure,
+     * it would be better to flush as before.
+     */
+    ret |= bdrv_flush_all();
+    trace_vm_stop_flush_all(ret);
+
+    return ret;
+}
+
+/*
+ * Special vm_stop() variant for terminating the process.  Historically clients
+ * did not expect a QMP STOP event and so we need to retain compatibility.
+ */
+int vm_shutdown(void)
+{
+    return do_vm_stop(RUN_STATE_SHUTDOWN, false);
+}
+
+
+int vm_stop(RunState state)
+{
+    if (qemu_in_vcpu_thread()) {
+        qemu_system_vmstop_request_prepare();
+        qemu_system_vmstop_request(state);
+        /*
+         * FIXME: should not return to device code in case
+         * vm_stop() has been requested.
+         */
+        cpu_stop_current();
+        return 0;
+    }
+
+    return do_vm_stop(state, true);
+}
+
+/**
+ * Prepare for (re)starting the VM.
+ * Returns 0 if the vCPUs should be restarted, -1 on an error condition,
+ * and 1 otherwise.
+ */
+int vm_prepare_start(bool step_pending)
+{
+    int ret = vm_was_suspended ? 1 : 0;
+    RunState state = vm_was_suspended ? RUN_STATE_SUSPENDED : RUN_STATE_RUNNING;
+    RunState requested;
+
+    qemu_vmstop_requested(&requested);
+    if (runstate_is_running() && requested == RUN_STATE__MAX) {
+        return -1;
+    }
+
+    /*
+     * Ensure that a STOP/RESUME pair of events is emitted if a
+     * vmstop request was pending.  The BLOCK_IO_ERROR event, for
+     * example, according to documentation is always followed by
+     * the STOP event.
+     */
+    if (runstate_is_running()) {
+        qapi_event_send_stop();
+        qapi_event_send_resume();
+        return -1;
+    }
+
+    /*
+     * WHPX accelerator needs to know whether we are going to step
+     * any CPUs, before starting the first one.
+     */
+    accel_pre_resume(MACHINE(qdev_get_machine()), step_pending);
+
+    /* We are sending this now, but the CPUs will be resumed shortly later */
+    qapi_event_send_resume();
+
+    cpu_enable_ticks();
+    runstate_set(state);
+    vm_state_notify(1, state);
+    vm_was_suspended = false;
+    return ret;
+}
+
+void vm_start(void)
+{
+    if (!vm_prepare_start(false)) {
+        resume_all_vcpus();
+    }
+}
+
+void vm_resume(RunState state)
+{
+    if (runstate_is_live(state)) {
+        vm_start();
+    } else {
+        runstate_set(state);
+    }
+}
+
+/*
+ * does a state transition even if the VM is already stopped,
+ * current state is forgotten forever
+ */
+int vm_stop_force_state(RunState state)
+{
+    if (runstate_is_live(runstate_get())) {
+        return vm_stop(state);
+    } else {
+        int ret;
+        runstate_set(state);
+
+        bdrv_drain_all();
+        /*
+         * Make sure to return an error if the flush in a previous vm_stop()
+         * failed.
+         */
+        ret = bdrv_flush_all();
+        trace_vm_stop_flush_all(ret);
+        return ret;
+    }
+}
+
 static ShutdownCause reset_requested;
 static ShutdownCause shutdown_requested;
 static int shutdown_exit_code = EXIT_SUCCESS;
-- 
2.53.0


