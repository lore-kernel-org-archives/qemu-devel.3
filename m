Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23F48C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:25:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu81E-0000PD-9s; Wed, 12 Aug 2026 08:25:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu81B-00008A-D4
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:25:13 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu818-00027c-KP
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:25:13 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CB4X5I4182207
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 12:25:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 G3/uehJdNH9zZRBgHnixk0NHozaRKYR4BaE3OQl6QZc=; b=CspZh2kA2gsyB+5r
 mAMD+x7WqBcbt3iV8WTfdNo45hRPFfUa6o63t9OV2bcUv4tJBLv0qXeftuYt3zla
 hW1yutggchSg9Lmtix/LtJrK8Y0X1ha/urROvFY22ZTvpVKj4J94GNJaAwOf29E0
 +YrH1JsITJnbcJuy1zD7xIcXrEu1i6ewb6BLtR9hZ7BOHUDs2LR2S/VKadMWrOYL
 EwDNSYEpAGC3f+X+lx7Abdj1Fk7fUthqPTARv3wC3AsOcKIN8zk3VCY3Fn/iZTqN
 29hM04Tj1HB70cC+qudo9tR1eHMVeFtA4/2SMof0PrsB5hJzV9Cb305ujgAAJ4jr
 noDBcA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g08j5kskg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 12:25:08 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51bff5c7035so17199351cf.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786537508; x=1787142308; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=G3/uehJdNH9zZRBgHnixk0NHozaRKYR4BaE3OQl6QZc=;
 b=LM2RZf1beZG1aF17gydVlavedug/QZTQU+eVRySdTidEN+Fblq3oTMeSpBgKEguEXM
 tKEa/PJOZvrDxkNWdqWXFa/0ZbJVKs89MHpL+Uv73n2FzdZkDqtMrdSpsJI2DMmDKbkh
 jNLWP1ef432y4NPJ7XUbPSD2BKbDY7JLcnfcJ8z0UHntVVaPZrVb0eTG7kqAPrhfzs0u
 knwBosRHsmbKdKVLFT+u8rH0a/lzckoHBFeI1SZ2juMtum/SXjfiO7bcIEMJ6NC1X5Iy
 wuPVsXPFoa1LoiEOM9z9L0RMFC1YI2k3y2BNyHBMvKKSOEAYBuwKLrWEW96iso4w+aoA
 2pbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786537508; x=1787142308;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=G3/uehJdNH9zZRBgHnixk0NHozaRKYR4BaE3OQl6QZc=;
 b=ZOLxPHvCMOotWd1LpY1jNLA8Q9/j7SLjoJUoQIW3ncikbiajRl+FmX+66139dmWn8T
 2rLvs+Lbe01Q32qVGje7BRx0xs3pI9ruRiV/+FMxF2LafJOi0fF+57YmUpT4n+S+2Mpl
 PIDoX1hZxvU7xSGPiTgz+KH6vaxgPYXJGr4AG67Owqz6r+QVGmdqxYuCLeeTkOPqxiTM
 ge/HpZkl8csjXKzqZ6dzuqD6bjEm2cgbxINIssptil7+RfqAIRej66yjrOqWbxEXsuQn
 X5LVvDEx+TAe5p71VKw4EIcpwutJuwmRHYp00jFFNZ0yKuKD+ym1TF1HMOnINgkbnkLh
 lyWw==
X-Gm-Message-State: AOJu0YzavzswOR5s1+24uLGTgeJsIwY0OLp+3b/h3dJWtSMDDzqg6b84
 u3M8T3DywOTdBpUCRNEeQWAbapturgZloBNWSSysccW4c3o61GyA1l/PS/zmCBbYuGwfF2xhrwO
 YFPXfDTtYS2fJ9JstYGlVzVQe6QWPotKxDz1Clc8LpOg2ALBpJOOZSL1K7N6ZLesRwA==
X-Gm-Gg: AR+sD1278QMYxKIHtUK8M9cb3TAwUmywVCmaerRsse7aPeUIb2iTC7Q1F9+BMxxXjFJ
 Pk/kL384+tSQAevwnQcWaOySY/1z08t4fetUix/su+CtPec0eU2ON8HcIhQxXjwTvd1B7kCzXYh
 oHmg2GDoW3JvbQO+TMhrZgz05RFeQqRxqNgL9ka4l1XZFOGtm4oY69Hdhb5wKA4dmzb11eUecnG
 2uIg08aLgZMARDv2HuJCVUgAv9WLMBcn9a4IW6qiCBkVREzPqdwAE9Wba3GD5HGalIEKCDqzF7I
 jJ8dRB+y0l8IW4A2uJ8R4IAh/dE2NT7zFOT03T5tuPnPUHo1nzXiuL8R84XnSBWXA1yOSU+N9vQ
 x2tDteHz4A5ZO2d/5AQM12Nv9FZ5dqWa7Zg2ydkLe4g==
X-Received: by 2002:a05:622a:8c8:b0:51c:1c73:5945 with SMTP id
 d75a77b69052e-52d647fa1ccmr36466371cf.24.1786537507879; 
 Wed, 12 Aug 2026 05:25:07 -0700 (PDT)
X-Received: by 2002:a05:622a:8c8:b0:51c:1c73:5945 with SMTP id
 d75a77b69052e-52d647fa1ccmr36465541cf.24.1786537507139; 
 Wed, 12 Aug 2026 05:25:07 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48150d5dfadsm7391086f8f.29.2026.08.12.05.25.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 05:25:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH 13/14] system: Move runstate-related code from cpus.c to
 runstate.c
Date: Wed, 12 Aug 2026 14:23:30 +0200
Message-ID: <20260812122332.72975-14-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812122332.72975-1-philmd@oss.qualcomm.com>
References: <20260812122332.72975-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEwMCBTYWx0ZWRfX/icnzA1kuN8a
 XEupJcNDPXMu+RnHu/sS3JvRrXvc1dFOfES+5SVDKde2IoIIUTLWRSKcllT1rB6FsAgiyTmahNT
 0VMERLsEVChoMMx7q9vp33KxWOBJIX4=
X-Authority-Analysis: v=2.4 cv=evHvCIpX c=1 sm=1 tr=0 ts=6a7c6625 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=NuyixWhdxe7Kj01NWqEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: UClJ94g8xmXeNJ0xZr0ntKhQdgmhYRLl
X-Proofpoint-ORIG-GUID: UClJ94g8xmXeNJ0xZr0ntKhQdgmhYRLl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEwMCBTYWx0ZWRfXzb1BPDOWOB3Z
 ivJ0Z1/bv+xXNGhrKGWUhQ1aIkZpaXpI7aZOZ8ctLQDqNXfZc0dmO3CCmB5esoVmq4tnWa6nrME
 yOfD5WBHa66pUIb1LJcAvt/7Y0EjdUoZBVPs14vpCSgEXjzQGjYbiFQybMg6amv//X79ZU7Pdaw
 bLm2cBFgzdPiVEBR3DYjH8jlmm+5spnSoAUyiDA66qn9Gmal2LQC8f5zHsKmVqb61+nflipnmBp
 jWSPENANamtdyYQlFSuoL/H6he8uLWEOf2iM/7DptjCoQIDrtnIutpBc61zwcKGKm0dRiwdGsF8
 EXFVn3bQQTNWwar8Gh4L5vRmI0lVGO+L85ldNidnQtLsOsDhRaX1nJTA9Vi4QFp0CmGgVM+v2ra
 LVj6ASvZUMziNu4UMQfk3n1uAGS/4e1Acrn9OppJu3tQhuSsqDoAGwlTVY2EFVGbBHNFbdI+2mu
 z7GHQCddpTscdcEhslg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120100
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 system/cpus.c     | 146 ---------------------------------------------
 system/runstate.c | 148 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 148 insertions(+), 146 deletions(-)

diff --git a/system/cpus.c b/system/cpus.c
index 9758cda4636..f9f1b297d1c 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -277,58 +277,6 @@ void cpu_interrupt(CPUState *cpu, int mask)
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
@@ -740,100 +688,6 @@ void cpu_stop_current(void)
     }
 }
 
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
-
 void qmp_memsave(uint64_t addr, uint64_t size, const char *filename,
                  bool has_cpu, int64_t cpu_index, Error **errp)
 {
diff --git a/system/runstate.c b/system/runstate.c
index 08acf801b0e..79bf21d93e2 100644
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
@@ -408,6 +409,153 @@ int vm_state_notify(bool running, RunState state)
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
+/* Special vm_stop() variant for terminating the process.  Historically clients
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
+    /* Ensure that a STOP/RESUME pair of events is emitted if a
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
+/* does a state transition even if the VM is already stopped,
+   current state is forgotten forever */
+int vm_stop_force_state(RunState state)
+{
+    if (runstate_is_live(runstate_get())) {
+        return vm_stop(state);
+    } else {
+        int ret;
+        runstate_set(state);
+
+        bdrv_drain_all();
+        /* Make sure to return an error if the flush in a previous vm_stop()
+         * failed. */
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


