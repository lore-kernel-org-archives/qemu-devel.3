Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E884C5AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 21:19:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuGMM-0002Ue-Mi; Wed, 12 Aug 2026 17:19:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuGM1-000253-9Z
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 17:19:21 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuGLz-0007sv-7b
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 17:19:17 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CK2P1b1743540
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 21:19:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cGRVAiRqF+IabBCiB6j4AzbKv01hLh5mnem5PrgK5/4=; b=Mamb9ayo9PK4/+gd
 QAjyvEJLkZPQ6aGTZNrMN3lBTJWRs/YNJhCmL4+TNov4vsVoUGDpOuBlOqNUmgJo
 gNfZbWgldhfiN2xHnWmGpwFLoRW36VUa772kqiOMCWcMR4PYxiKBMB9uleKF6eNz
 tqcnMoe3QM62r3QkgjVecuuqNx5QWhmRVoMxd8vC/V9Q5LhTiXn7BDnjvYfMIYrr
 yBbHWdl8nY12+0NC0McEDK5ha/AYKY9ELcdAvoNJ8RZ0bOeEkqsLEdM+HBdzX51l
 fhxihE0Lbu9m+FlAe7hTQF5ZqINKvLsz6/+0VvW5rCdQYL1tCoAQQ22cYs57+MOL
 zw4yEw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0nutb7fq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 21:19:13 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-90410c668adso14894156d6.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 14:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786569553; x=1787174353; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cGRVAiRqF+IabBCiB6j4AzbKv01hLh5mnem5PrgK5/4=;
 b=Kz8qxMQ+Ffekiu0LpTiGZkWjWuc8cYCHvqo+ijxcBV9rQlg63GpaFNzOsDk+obN23i
 2x23uY7n6ypPdT1owyZuL6qvEQTrfdWGvHx6PRg4mmZwpyB+dAfLHP/OycLHcTLxWIa5
 n/AGHXl9cQwFWw7zYmG62cnHuoIwrLVvtFU4WslGRBmmDvBXm+a6wkPgipKwQrstDUtI
 o5S8gjDJ4IcEyKA1CaJceKNiNAu0CV5RPVXgDbXawhehLPc3xhXYE9Kmum4UYwAmfaIp
 /Ia0kCEjXvIiXmAWfUWllKSfpdeGV+OifVvUhBH8D//y11kx+agPJh6fJ0xmPw1u4a2/
 C5Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786569553; x=1787174353;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cGRVAiRqF+IabBCiB6j4AzbKv01hLh5mnem5PrgK5/4=;
 b=YcymmHcw2C5zcSbxdj7WKzyp/n1tHDxvgQQHqAAStDkhyOl8cwI7TP4HaM8dciJ8CC
 ZgEXl5WI+H/3YbaKlibblA1UvqxEq9ewfG0onc+5mPeZD3CQPuX6LPN8J/FY3G+q6hh/
 cAtJCD/NI71QOih0zrfNKkMjQ+ZIB5xyq6jixHzyaWQAr4kRMQobIJb5W9HJbVNtu8xH
 hxh5G8o50r8ftqrXBmPz121e7X7e5dz0qeVUwJJfQMR59yKDrZmtbSuUFvkctsruj8mP
 +7kzgTxja50AByGL2UgPIb8X3B7j8hOuPsFvEjvuTg5NJSf1/Qr9GlDrX1g8JuCWDrKY
 9Wig==
X-Gm-Message-State: AOJu0YzqqZqnm/9aLC5peUR1s0jBOPjGTjI6QEdYCeOTWmwScKsVHRxd
 n+31nJ9+IyvNNyNsImdR/HGjud4yxMHVbgSAf/1VrRRqKPasv5JnGwb9HdSJZfxeSZ3b5Rx4Kof
 Bzh52tRqZGIoBEsbWHGPm34N9ngRs7YwoRq/kHPeEOX2fY0Uv2c+ZKbsbidFGi7ZC0g==
X-Gm-Gg: AR+sD13vEsmC6UYoCh1XwbG3STGQdAwMuKqPUy7h6i+0bW+O8Tcoidn6oHiAiQKUBUy
 IIh+N6CF7CH9rKtkIngk0yluQ8IbH/B1o8NVyaT6kUbAbIX9KhzIg1O/jaH5s+zaM0QmG5LclIt
 v+nt1Lpvc5B3qJacMgplyGVo9fg1smFJgm9PDxmkNf5ZO/Hwu/x0KAWCCVthI5gZtbVFfnHSpbG
 vY2W2vk2gzA1lUBdYtvsVV8DWknMoqWfuPVOnBz0ZEfwoqqhkL6rOPUFs6GDbF5SKqgbwrwWUt3
 sU+9hbADwsusuL2CGT62J9HOBti/LY8JnEjSOTFSZw6KwxX3diE4njw5xqcqWOLIFF5SY+Ysv1F
 mj35yGaIi2yCr8pK59PkNLDMiUqIDP1uyidPh3vltrg==
X-Received: by 2002:a05:622a:1a9b:b0:52d:41d0:89e0 with SMTP id
 d75a77b69052e-52d73e3c8a6mr9553571cf.40.1786569552501; 
 Wed, 12 Aug 2026 14:19:12 -0700 (PDT)
X-Received: by 2002:a05:622a:1a9b:b0:52d:41d0:89e0 with SMTP id
 d75a77b69052e-52d73e3c8a6mr9552941cf.40.1786569551757; 
 Wed, 12 Aug 2026 14:19:11 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49981b03e70sm16511765e9.3.2026.08.12.14.19.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 14:19:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH v3 16/23] system: Move runstate-related code from cpus.c to
 runstate.c
Date: Wed, 12 Aug 2026 23:17:00 +0200
Message-ID: <20260812211708.92824-17-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812211708.92824-1-philmd@oss.qualcomm.com>
References: <20260812211708.92824-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE3MSBTYWx0ZWRfX+GA1RL431cUu
 BzhC7Rfcq/nU7yQDD20ShdNArffF8q1sgJAiafT6EMCs6S1k0biQBTblcIaJCcznBVhSUb4EYHi
 yIpDjPDmnGcYVDVeTdbmiE6haNMpFC8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE3MSBTYWx0ZWRfX5V24ZypqSUuT
 wTVlwvsyK5KRH0iL3qCbE7fjPQ3bxAhzUCYUp/ry0r6VDUx3bWJUMRXjZYMFsbJYf7N3dL20I9Z
 dWXEGxfX5zQ8sSWHFz3NDuPcDsErknhIa67WpehuwqjQKc89ZLQN09O6/APC4DOA5Lzp08P83oA
 u6t6yaQ+zKnqQpfKvkIILkxosK71yfsQrebFoDdlfr233hZRTHvzFELh8JPhJQq1V/VxnU69rOQ
 of97K1QM6iMGDpfhO5Xe3KWVhS79wt2XQXbo9qqEq9NZVhW52npA3XDdGH2tij/UcU3l5rE5pYt
 f6gT2BQmIoVlOdG3CoBRjjLz+rG3chbG5GUn7M5XLA3JNIK73F4eJHY68KSMLO7tjhsfOCEr+7e
 7qPCwb7XFNJWxyXGHzANVSljtIzUi7HGXOlCaDjk+SRna/iA4lMkyqfJj0DW+74cDTRnhkI54CN
 TX2vd05GhfFG2JDNQ+A==
X-Proofpoint-ORIG-GUID: E97Pe9neoKgDgIbR16Y4JAb5Cfi_Oz8j
X-Authority-Analysis: v=2.4 cv=POA/P/qC c=1 sm=1 tr=0 ts=6a7ce351 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=QK4PlI00PMcCPjLnJOMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: E97Pe9neoKgDgIbR16Y4JAb5Cfi_Oz8j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120171
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
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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


