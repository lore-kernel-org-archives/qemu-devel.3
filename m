Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3421BC61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:48:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24zo-0006SO-8Q; Thu, 03 Sep 2026 06:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24zn-0006SC-Cg
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:48:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24zl-0007vb-5t
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:48:38 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AHCtB3204013
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 10:48:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2QmxAHslsMVVO7vZIIhDNu6DarVmqq7mCxKoaRSZYL8=; b=V5VzdrrvGGHZbvlx
 VCIwmgBwRgHJwMAMby7RwWxVRaH6kesaLE42vBbsIlGd8T332f1TUimUaUyKTG5j
 FNRkkY2LfJVUS09wcoxir5+u54SPFKN+8LNqe3T/BhQHUVD7vgu9D9EahZpBR4BX
 9BMOVmpEd7wDL+76Qu3nVxfyNS69BhlhBXBAi/aVAlS6NbnMq6H85WfQGtq5m0ND
 H5R4Tie83X8Bh1hjjwMSwJe02Dr7qIq6FuFqmvFXvxx40X0IUiJ2z75w1uCeOeMr
 6YL04esDmU3CwsplZvuSSneCAQiYJO90yEMuommxE46na6+U9brAKAwzuzzb8LXr
 Zsd0Wg==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf5d10j1y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:48:35 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-4b28deb7ee3so2221354b6e.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788432515; x=1789037315; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2QmxAHslsMVVO7vZIIhDNu6DarVmqq7mCxKoaRSZYL8=;
 b=UTAedju9IiKgGfqVptWpZZiBs0p4AxIGlAAqxrnD5NDtuwNdzUNZ/H1zX4mS13YB8e
 KHI41zNlzKw1fhE+8q1W3cQVubX6swOvDRVpMCd8Bs3+N6VnmYVIxvdoc0mc/SsInwi9
 ax/RNq63HQpyV9nRJKgbv9AUpaqMzaqMEsS8LQ86SMH5/2JG9l2pL0YflMuulWyMhys7
 8ztR4txzm136cWETyOnlSvYkjSXkgNvCpyupWOaGhC1Az2zO/Uryc2MdvJlWYdIEIlhD
 7HYgv4b43ynVLJxSHpk8FH16sDS88H0aSXlgL07Ho6wejtKsnd8mRm9b28bHM88w9PZe
 cijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788432515; x=1789037315;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2QmxAHslsMVVO7vZIIhDNu6DarVmqq7mCxKoaRSZYL8=;
 b=QNoro6rgop7UJjmRlNlTIy8KRPLubSQOYq3aLDa5L6v//tOTQ0gy3CMHO8DmApTZSr
 4QMQveyZrMOquxs2LJPkP33HIvZzmSDeFvAEFhc/TntEp47dGYkxAzbcwayyBDgZ51jw
 IK2iNsXT/YyMufxMCAN6wfLnRqDOpGtFddXtVg5m8sYn7ekrXyZU/wbS6owJvNqEZRRj
 hE4H8y/t2zuO4YSKKoOPIZXoYWDAeEyaCTC+B4BUP22t+k3/5OE+TVDpMOMm6YJxtE25
 hGOX+DQwcQeqL3NxfZPoXAgqibuTsCX76HYfQbSO6wN54jF+Sch3gTEAayYYNHKO4y3O
 iIXA==
X-Gm-Message-State: AFuF++nPXJq4Xc9B7LnjBr88S56vkmUEHifgMAm5Q9KoYEXEIAR0bzjk
 ytEXtJpwiz9jY0q0P1xy+ZLdvoEcGTGetDJkxPPTIEZjBFsKrreIfYZDszc7npWrIF4ZP3YD51T
 p29LYvIY3hw0LvtKjbGotNIwjf0rer9qvsvIw7hvfSGDRnCTwayCw19r46gu7VburBQ==
X-Gm-Gg: AYBFou0YNQPQI7Q45thaG+4wck50ZOye1i+ddkYQKuapnvuPohiOWLzsQdd0pfhtTvG
 K1OW+BxJgt92Ki4l2guyDg2toi7EVZJAwLbDdoUM1IIcdxWs/CfaN8fLmQyfhSJvCw6uA1fB/Ef
 IO3BxzxCBKZhJLosSrDSqaU7rx8M//D8HRzZQoIG0XHjOqNvM8Yp7FFjOhtxDI//boH2Ua6ACvR
 w+1R33wsPcqXOi8cNXqFjZq0vgdWzenIwTjfRvMyGZZ9GqGiS00yFPxuXiwBbZUwyyOdi5Z/JaC
 ALBCAy1iICd8CfXYR8lD8s3kSDXULAXxCrsFqEIvic4HoI85CW6Mi+GpHj1UdHOvSwcbJjFySvh
 xW7IHLcfcbpZq817UqJ+WZLi+axQN10a57nX8i5lX
X-Received: by 2002:a05:6820:1789:b0:6b1:b23c:2142 with SMTP id
 006d021491bc7-6b47bcc15a6mr10105209eaf.1.1788432514621; 
 Thu, 03 Sep 2026 03:48:34 -0700 (PDT)
X-Received: by 2002:a05:620a:f0c:b0:939:6dec:55e7 with SMTP id
 af79cd13be357-9396dec71a6mr574645085a.48.1788432102472; 
 Thu, 03 Sep 2026 03:41:42 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448eeabbfsm12264807f8f.31.2026.09.03.03.41.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Sep 2026 03:41:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 17/51] accel/tcg: Rename for exception codes named @ret as @excp
Date: Thu,  3 Sep 2026 12:39:01 +0200
Message-ID: <20260903103936.62355-18-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903103936.62355-1-philmd@oss.qualcomm.com>
References: <20260903103936.62355-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5MyBTYWx0ZWRfXyWIJSGOFGjsC
 wwc5JW7FKyJtuOmBWKLfnXCzZpqHlatYIiZkMi12E5RTp/Wy1VcQ1Bc3GCw+3NuWoVW07EeDV5Z
 BjHTJ/EPKlB9jRS75xucngG/5W5mkjqS8ovN3JmactzXAR6DPlMuiFKXr4fhXi4msYyBOEwiNC6
 VgOeefb7gp+PGviecQXjBj6crbP7CMkco6j1SHlH68uiPEWr17UThVeXhNsVYn0FoI43NZm1tt2
 KbwAkUV5ohn1HuI+HF5BKfIoJGx2zJSB4X0SGOG0C3EtPHJ4qVsSlt9pL9ReB7VFIsyJEN48/ow
 goJ2N9INBX/BoqHXu/Ksqrnl266lWbN74pO5weSPd+2fZKtjnkH7BpNWYN33KMU/sk4ygKfZgSM
 VHZFUST3xHOG23cG+nxpBrSxt3+m3zqGWX1/ekViQSl9I/2+RwbxdUlLd7cHxYagkXpEbG+2YUe
 WYhCmROwEKpB660I2bQ==
X-Proofpoint-ORIG-GUID: vGKIxq-KyR0KjMnJ3z__9k9qywwAUjVS
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5MyBTYWx0ZWRfX9Z1eGYhAO6yQ
 Se4XwHZLhEuBaiFeKFG0X3+OAc3djmMaZF0qH36i7h9WTI/6RfReMrazz2e5eppGq3782V1KGVq
 cc0/93hY5nlRVrQB7ByxT+kj7RA06Mo=
X-Proofpoint-GUID: vGKIxq-KyR0KjMnJ3z__9k9qywwAUjVS
X-Authority-Analysis: v=2.4 cv=J4GaKgnS c=1 sm=1 tr=0 ts=6a995083 cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=_j5oqwj-hJjEN08MGkoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=efpaJB4zofY2dbm2aIRb:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030093
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

Rename meaningless @ret or @r variables as @excp to
directly denote the value is an exception. No logical
changes, purely cosmetic/clarity improvement.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260819145649.23439-2-philmd@oss.qualcomm.com>
---
 accel/tcg/cpu-exec.c            | 24 ++++++++++++------------
 accel/tcg/tcg-accel-ops-mttcg.c |  7 ++++---
 accel/tcg/tcg-accel-ops-rr.c    |  8 ++++----
 accel/tcg/tcg-accel-ops.c       |  7 ++++---
 4 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 257211235db..53d90c400d5 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -687,7 +687,7 @@ static inline void cpu_handle_debug_exception(CPUState *cpu)
     }
 }
 
-static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
+static inline bool cpu_handle_exception(CPUState *cpu, int *excp)
 {
     if (cpu->exception_index < 0) {
 #ifndef CONFIG_USER_ONLY
@@ -703,8 +703,8 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
 
     if (cpu->exception_index >= EXCP_INTERRUPT) {
         /* exit request from the cpu execution loop */
-        *ret = cpu->exception_index;
-        if (*ret == EXCP_DEBUG) {
+        *excp = cpu->exception_index;
+        if (*excp == EXCP_DEBUG) {
             cpu_handle_debug_exception(cpu);
         }
         cpu->exception_index = -1;
@@ -720,7 +720,7 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
     if (tcg_ops->fake_user_interrupt) {
         tcg_ops->fake_user_interrupt(cpu);
     }
-    *ret = cpu->exception_index;
+    *excp = cpu->exception_index;
     cpu->exception_index = -1;
     return true;
 #else
@@ -738,13 +738,13 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
              * raised when single-stepping so that GDB doesn't miss the
              * next instruction.
              */
-            *ret = EXCP_DEBUG;
+            *excp = EXCP_DEBUG;
             cpu_handle_debug_exception(cpu);
             return true;
         }
     } else if (!replay_has_interrupt()) {
         /* give a chance to iothread in replay mode */
-        *ret = EXCP_INTERRUPT;
+        *excp = EXCP_INTERRUPT;
         return true;
     }
 #endif
@@ -935,10 +935,10 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
 static int __attribute__((noinline))
 cpu_exec_loop(CPUState *cpu, SyncClocks *sc)
 {
-    int ret;
+    int excp;
 
     /* if an exception is pending, we execute it here */
-    while (!cpu_handle_exception(cpu, &ret)) {
+    while (!cpu_handle_exception(cpu, &excp)) {
         TranslationBlock *last_tb = NULL;
         int tb_exit = 0;
 
@@ -1006,7 +1006,7 @@ cpu_exec_loop(CPUState *cpu, SyncClocks *sc)
             align_clocks(sc, cpu);
         }
     }
-    return ret;
+    return excp;
 }
 
 static int cpu_exec_setjmp(CPUState *cpu, SyncClocks *sc)
@@ -1021,7 +1021,7 @@ static int cpu_exec_setjmp(CPUState *cpu, SyncClocks *sc)
 
 int cpu_exec(CPUState *cpu)
 {
-    int ret;
+    int excp;
     SyncClocks sc = { 0 };
 
     /* replay_interrupt may need current_cpu */
@@ -1042,10 +1042,10 @@ int cpu_exec(CPUState *cpu)
      */
     init_delay_params(&sc, cpu);
 
-    ret = cpu_exec_setjmp(cpu, &sc);
+    excp = cpu_exec_setjmp(cpu, &sc);
 
     cpu_exec_exit(cpu);
-    return ret;
+    return excp;
 }
 
 bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index 69560fdb9d8..e7edd1945f2 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -90,11 +90,12 @@ static void *mttcg_cpu_thread_fn(void *arg)
         qemu_process_cpu_events(cpu);
 
         if (cpu_can_run(cpu)) {
-            int r;
+            int excp;
+
             bql_unlock();
-            r = tcg_cpu_exec(cpu);
+            excp = tcg_cpu_exec(cpu);
             bql_lock();
-            switch (r) {
+            switch (excp) {
             case EXCP_DEBUG:
                 cpu_handle_guest_debug(cpu);
                 break;
diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index cdaa3e11808..d6c2fc019c9 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -277,22 +277,22 @@ static void *rr_cpu_thread_fn(void *arg)
                               (cpu->singlestep_flags & SSTEP_NOTIMER) == 0);
 
             if (cpu_can_run(cpu)) {
-                int r;
+                int excp;
 
                 bql_unlock();
                 if (icount_enabled()) {
                     icount_prepare_for_run(cpu, cpu_budget);
                 }
-                r = tcg_cpu_exec(cpu);
+                excp = tcg_cpu_exec(cpu);
                 if (icount_enabled()) {
                     icount_process_data(cpu);
                 }
                 bql_lock();
 
-                if (r == EXCP_DEBUG) {
+                if (excp == EXCP_DEBUG) {
                     cpu_handle_guest_debug(cpu);
                     break;
-                } else if (r == EXCP_ATOMIC) {
+                } else if (excp == EXCP_ATOMIC) {
                     bql_unlock();
                     cpu_exec_step_atomic(cpu);
                     bql_lock();
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 560fe2554ba..9c3d2214162 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -77,13 +77,14 @@ void tcg_cpu_destroy(CPUState *cpu)
 
 int tcg_cpu_exec(CPUState *cpu)
 {
-    int ret;
+    int excp;
+
     assert(tcg_enabled());
     cpu_exec_start(cpu);
-    ret = cpu_exec(cpu);
+    excp = cpu_exec(cpu);
     cpu_exec_end(cpu);
 
-    return ret;
+    return excp;
 }
 
 static void tcg_cpu_reset_hold(CPUState *cpu)
-- 
2.53.0


