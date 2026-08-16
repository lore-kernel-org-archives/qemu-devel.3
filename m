Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E08C1C5DF6D
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvcEg-0002VU-AU; Sun, 16 Aug 2026 10:53:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcEd-0002OU-KL
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:53:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcEb-0002OR-Hk
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:53:15 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDlfU03215986
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:53:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 y08fCN7Tzn5n0sn65TpnLdI9L9dwvew7wRgc5Ixvhf4=; b=K4Y6015a+g0fPWKO
 q1m2uw3T1En8cLXqwSHbWsoPSvvJcnGbOjcna0jZEqpUJsujTVpg82C7e/98vloJ
 YawgBajJQJPzBG6wmljD5tUR9iFBp34Ef4jlOoCI3jdvwFsF6XQJsAdOj/7XOhDU
 orIM/absvwUb9gjh1ItO/ZDKcSINaBkJ54ZEHwCbtxQ/FzZF5t4G5RX3KWjB/4gk
 nl5g99n+lUzepikDAUIjKCadEYoqA0vYN94Ohg+p5rOxV0S6ivcIlOtt/L1UyG9U
 tGB3vInn2vv+mXZxbdx072u6/8q0hW804EG0MvdNUaiJCICow22ah8YnEUr8uC7P
 jCWuDw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghfbngy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:53:12 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-9087f2fe592so13862506d6.0
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786891992; x=1787496792; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y08fCN7Tzn5n0sn65TpnLdI9L9dwvew7wRgc5Ixvhf4=;
 b=HFicMqrUT4dPlC0gax03+9MYxjCYJ0Yv4EC8CoiMM3TAYDU7wmS5byAYgugnevQv33
 0EUnk98aoOWPjUPsQDUehyOXSREnDmiqcZuHPvE7tJ9Gmd5hniH4yFkiqhtRgSPbe/O3
 cjyVH1s0jTMBFdmcqfbwGetmqrihKWeBL6avWNgLMt4TPoRSEuXNYqK9cz70UOHXdGvk
 V8IM5tzeKaBZuT8nYu+7j2RznnFev58Y6ku9nZttAsoFBkY1etnY3QSprFaJrDaiCSRI
 CwRnDyQyaNoMGv1T5ttY1mXDoq8ygOkE8CB3TAOUyol49d3SMcKlAHLyZeCdy63+B3q7
 qJWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786891992; x=1787496792;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=y08fCN7Tzn5n0sn65TpnLdI9L9dwvew7wRgc5Ixvhf4=;
 b=dXiOTAN0+nMQqS3rduJpT3K9nV4816TJf3OLYsuICLZO9jTrFKVQEbCMyTsznfUWSh
 EUr8U18gg4Wr4hVzEc41sRAXlgJI29LhIYZmmt8bD7MsM1+1Wp6BIA3vI2I7vQQyhio3
 xsBHZGiuCa0VJuW3XkRiooPce9CsA56FjpPb8vv0gBbech7MzDHvUGeZk//GZYXxoOMH
 kWx1+YYrrzEhKA6Vwm3zUDOK2IpDTQ1xZvU0kUeMStKeFKrEHRGiSWPqFwRbL/KfKk4E
 bAW1h/25s/gyfoc5XA3ev3nit6SceAnfHSB3yql09Be+kw2mmQyVltP+17uvQhRcL23R
 J+2w==
X-Gm-Message-State: AOJu0YwIs679Me61Pa0/Hm4Rz13u9j//3nY0ucl4Ha+jwkq7bD/bSG8z
 rhJYI4bzNrOwwCpQB0HpFj6GWg2qb9FaPArJcxH8Zc2WyVH0nRxVaFVGQbf0Hys+cU0a0qewWGc
 h+dGd4qPnDywQB0C1jBass7PNCShX/zbSUkcMGcdhH5uCyrRGUBZgxY3XzsQn0NEU3Q==
X-Gm-Gg: AR+sD11Q7v9TLEKPt/Kd5YRyO4zq/lIdbbltyyYwssSTMr2cgSex54fcz48JhDi1tIs
 H8g42QCcP7P5a1g1PzEPbBsahSKPpY5cCA1AM4w/DQTIJl34VrWclhjFyhxYITo54N220MIecMX
 V3U/VA4NHEsVf+xtO2mQmfp8AJNLX3MlDtigkDJVlehWnye/06eYishldtjheeY+Fts0DPfvPar
 jzR/Ms1+hd4N9vinD5984BxFr7yUmU3aPeM2fUQwkHnwaw6gUTZEONWqb5959X/HJLO3ry3ukVT
 IadYVHShyZakuAKLw93nlc48qjWe2/sp9nxVkaKCnpJLYs9g+94D0cZ4EP2eUYOswk8PaYwTN3H
 d+Lqw/VSrF6dMcj+oZktLvtY4MAzhAYVELiN1cF8bpw==
X-Received: by 2002:a05:622a:4c15:b0:51c:805:1be3 with SMTP id
 d75a77b69052e-52d8556685bmr229490351cf.31.1786891991867; 
 Sun, 16 Aug 2026 07:53:11 -0700 (PDT)
X-Received: by 2002:a05:622a:4c15:b0:51c:805:1be3 with SMTP id
 d75a77b69052e-52d8556685bmr229489681cf.31.1786891991260; 
 Sun, 16 Aug 2026 07:53:11 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996108141sm47159255e9.6.2026.08.16.07.53.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Aug 2026 07:53:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 51/56] system: Move runstate-related code from cpus.c to
 runstate.c
Date: Sun, 16 Aug 2026 16:45:50 +0200
Message-ID: <20260816144556.69009-52-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816144556.69009-1-philmd@oss.qualcomm.com>
References: <20260816144556.69009-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExOSBTYWx0ZWRfX0ftN0W+OTr+J
 NUvMN5XD7/0e3vAk2W2QqNKajeUe4p5Lvaci4BwpGAs+XrIdzYJGCKOR0nyccrL70pHgx41DpGk
 lRJItOTNK5A257IFZBOnur0SK/UtXcY=
X-Proofpoint-ORIG-GUID: 9stavbOdDDbyAGDqydVIq08wECC3CSFD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExOSBTYWx0ZWRfX9Q2P4empzvKt
 PL/wXz/Qd4QFY7t1x7kSo+CmzQML0Ji86l3QaJKlbXVFJVLvicpbPVVI79YHmwd1qd/6KePu8lZ
 b3AvLAWLziYtUrfoOjYuuXvG0ViAdKN9juU69DQX1yZB/6gTrdPHnmaDknQI30Ks+W5ABwiMqPo
 s2u5FKivC0su05BiG7wsXfawF8dxIXe4GmR59YimNA6QBKtPZF1nKqgRgqHQ7/VLSTmJoDpebVb
 DZXQjuk3jJHr4sbAvpnoS2hI374yuaZwTVHT8oEMgE18ZUH0Yn8zk+lWQB4XjZU4TqpgP0KOxDy
 DXg2rmt1riJLLWdHHlxi28Kanb4hGL9pVuFsuQyiLKr+XtOEN4gD9re+chskLePBsYo/ABrPiY1
 0Jdyrgq5A74K9hRWzShnBeigPBVyzgUG+np8smV0Vj7MgJL4U3FYOXLJ4WWGw486GolVwBoWfyF
 Qbe+2qT3Y0mnikXJQkw==
X-Proofpoint-GUID: 9stavbOdDDbyAGDqydVIq08wECC3CSFD
X-Authority-Analysis: v=2.4 cv=I/dVgtgg c=1 sm=1 tr=0 ts=6a81ced8 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=QK4PlI00PMcCPjLnJOMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608160119
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
Message-Id: <20260812211708.92824-17-philmd@oss.qualcomm.com>
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


