Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84E2DC98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 16:51:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x93hJ-00043d-OH; Tue, 22 Sep 2026 12:50:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x93hH-00040B-OV
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 12:50:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x93hG-0002Rv-1U
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 12:50:23 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MEjVpx1058319
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 16:50:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LmAYAv4MmXNPysrlCBEQ9Xi/U5G6KHBy5hspKYOHyfE=; b=dP/KHzYaQCYlTT3i
 KVITpjHfDLk+aJnNbwG7R+Uyvl63Ps9IEGGtaaTa+FVtLusE3oMr2rwvllCkhOR9
 df94lhfL3RkP9YTRd6Q+XLILeh/GFa+Y1UiOUMZECgcEkVNMX7DiS9y+JYHzqyhl
 CzQyIUlDGuXm+YK7Ql5W4Prkr6W2CCRR7pJwBtZvPi1gzJcU9vhMvkbM/QpkHe/V
 /tTijooHWNiyGzE89qNhbPBykzhWpEj8oPxxo0A7yfN0vRI4aTVMFpWt9QvdzT29
 PYCedgHHUDxepLVz2OwCuVSQ9PiEoEEFs2a+G4+QIPQJgc7tugDDLOx946vklGVH
 NnKBLQ==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4guha5uguk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 16:50:10 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-7915a83539fso1076137.1
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 09:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790095810; x=1790700610; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LmAYAv4MmXNPysrlCBEQ9Xi/U5G6KHBy5hspKYOHyfE=;
 b=Z1J86MhIYepZcLP6fWVo1acoPBS10KOlA3MrU8miO5ZgPB50Vo7C0kSoNRMKgUSTKO
 LRX1H9rJbQojqI+BYCPXf1Fnxpp7uUlRus/n0wRGfgeUxImdv5Z+FkoFttQEQR0k19HT
 fwd0lnrJtAUlyoD5GZ67+rE7y0RguntD9rhDzhT4jOgczhRSZdh7HoBnN9nwBIYGLDTm
 JaEfULAjrJwgCEcRfa6dL1/S13FoEUM+9+pxyQPeL1ecao9qVRcFX/av5UWdd23Djsrw
 c6PkSnzXLu5OlxpO0XBvaJX61bjBZ2YpoWIaE0h+KdMQK7vuhsYSCnr8pDhQ20g16A0n
 0a/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790095810; x=1790700610;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LmAYAv4MmXNPysrlCBEQ9Xi/U5G6KHBy5hspKYOHyfE=;
 b=ikZUWZk/iCz1opdjmf2r6Pki1cAOSmEpOuUksvpnY7c8CFtDctpzY1oBcMRqaM7TEF
 d/sRxmfhDl24RdzWAFzEAjn1yHZyFncFak6SECMCq3FHKXCvx5rdlsHejcQyvVKcl02w
 gzbEHdiEGU/U1YNJOAyKxvWxrvs7DJCvMu/wG+eOcIGjJIfcTHdNXMUHWUoQdvrS3+O7
 xZNSr5Hb0G0xQvjvZH4JWf0FBlsoz7VSm6RghBUcRreo8WEJoiXawtOxlbThWwXAIl3W
 OgCs9493tnaKkAq+0d+UZeD3nvjoQJ3CGYICHx4uBO+awPBnOfgLmC8NykUTVXa0dkCQ
 YfTA==
X-Gm-Message-State: AFuF++kXLWCfHsoYq3KxprZOFnDnCohPZ0dxRBj60wknH/Mrk7s4bs2W
 RB8bNazwDrAFmlAkb+1TMb2zsaWLml59/QbXGlfOWuo6BXL4Fh8FgxXWexHTE+51VSzsK6V0cPe
 pikIBRNLP94ndYK4xcxYafEXIoJBpAEPgIxB+WaFQdQiBTkxgSrR+jsk1MiIkArYm0Q==
X-Gm-Gg: AYBFou0dqaGb+xkPr1ZoF7+S9UEeu4Ukj/Yey7q06iEx2mPwJcF4h1d1/qvKd01Z4JK
 6nkR5Uqf91roiLTBtR2vzjgRHFfydJkRWl8MNHDeyAXQR0Xt+FvueejjAAFmjZ2mZrwccroNZVu
 nQeGGVswQyWnP+OU8uAKSReMZVwtTuPFLK2oPc12/3xyCfkKKMZs8tYD46Ey/3SAe40zfR09N+a
 GIv/bUhEPr5nBPrMAW9S3iYjILci6IGrFlAcHwd3b/vk/xVt1y0Nh4c9HS0XiMZi+ZEqfShX0HR
 CKmELNaWDmaRs8Gzf2fo7pnLZOAbNEJ4whUBbNSWq1PV6s6HPduxnP+cVJlDRgI93YeRl9kJqdb
 HaJEdnbjX2QzUvZx/2e3UQoda/TKOvgUKvUYXJGoj
X-Received: by 2002:a05:6102:5cc2:b0:7a7:1b62:2d3 with SMTP id
 ada2fe7eead31-7a71b620fb6mr6991070137.37.1790095810271; 
 Tue, 22 Sep 2026 09:50:10 -0700 (PDT)
X-Received: by 2002:a05:6102:5cc2:b0:7a7:1b62:2d3 with SMTP id
 ada2fe7eead31-7a71b620fb6mr6991002137.37.1790095809491; 
 Tue, 22 Sep 2026 09:50:09 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fde17dab9sm5101265e9.2.2026.09.22.09.50.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Sep 2026 09:50:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, Jason Herne <jjherne@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 04/17] target/s390x: Use S390CpuState for CPU state APIs
Date: Tue, 22 Sep 2026 18:49:22 +0200
Message-ID: <20260922164936.15189-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922164936.15189-1-philmd@oss.qualcomm.com>
References: <20260922164936.15189-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: _BIEXrMV9utHztIPlqrfOht-xzSg9Wrm
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI0NiBTYWx0ZWRfX/7uZLQs9tLTG
 8mTQ4nOyRFBAsnv7YWUmwO6kzZ8ui9uDsb1uiBssyfuvJi/gmq8nxYy9JoC8/h8R1fVkg3uFwBE
 mAMtGNXz75oVAXrZK4HPYRcZy8/JpFE=
X-Authority-Analysis: v=2.4 cv=U+4Hnuru c=1 sm=1 tr=0 ts=6ab2b1c3 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=J-bIcBNL7rHnt2l8aaoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-ORIG-GUID: _BIEXrMV9utHztIPlqrfOht-xzSg9Wrm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI0NiBTYWx0ZWRfX2j7QiKGsIKHE
 Iz08nHEtqKFtFGJ1tU8t5C0tj5ENbY2GyUjr2m2Nx/AyA+sEwh/HOXudLH3rMBN7TS5qSW01H46
 iZ4p2lslUZ/dBIYI4NWRWMmwHHMn5qTUl+jw7wle2H0e4aJFLORQ0FcY1Fb/yuDwrAvufho0d2q
 wo7u/Gk+15Fr7lamUazc1Ix4zOlodK2YefF1Hnq1znQHhJYR2P1Xw5kpweK9QqPYAZrXCHBYgLM
 V09GJ3cWJXEI5NDmKP9RLxsauzjItv3WgevBuGkIOrcqsL/fqspXEMHZJtIbhfht7YGOnPLGyrh
 Y5TH6KxKUayAhgAzJJKkLDtBNAtB1DclS/dXprAgvUcWLlLQoqVV2TbO2WvPhI1jPLly8g5gXf1
 aK8rx+ibjbjXhXuvKubiKrWFOJ+9iUAyHNlAPq1He5zo+jTEjqI4zLkRWOAUhzPGxy99R6BXAnc
 emXQVnn9esniNPUqXCg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220246
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Use the QAPI S390CpuState enum for CPU state accessors instead
of uint8_t. Handle state checks with switch statements and assert
unexpected states in SIGP restart and stop handling.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
FIXME: g_assert_not_reached -> break?
---
 target/s390x/cpu.h           |  6 +++---
 target/s390x/kvm/kvm_s390x.h |  2 +-
 hw/intc/s390_flic.c          |  7 +++++--
 target/s390x/cpu-system.c    | 18 ++++++++++++------
 target/s390x/kvm/kvm.c       |  2 +-
 target/s390x/kvm/stubs.c     |  2 +-
 target/s390x/sigp.c          |  6 +++++-
 7 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 2d1dcc7045c..bf9f6ed1de2 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -847,13 +847,13 @@ void s390_do_cpu_set_diag318(CPUState *cs, run_on_cpu_data arg);
 int s390_assign_subch_ioeventfd(EventNotifier *notifier, uint32_t sch_id,
                                 int vq, bool assign);
 #ifndef CONFIG_USER_ONLY
-void s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu);
+void s390_cpu_set_state(S390CpuState cpu_state, S390CPU *cpu);
 #else
-static inline void s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu)
+static inline void s390_cpu_set_state(S390CpuState cpu_state, S390CPU *cpu)
 {
 }
 #endif /* CONFIG_USER_ONLY */
-static inline uint8_t s390_cpu_get_state(const S390CPU *cpu)
+static inline S390CpuState s390_cpu_get_state(const S390CPU *cpu)
 {
     return cpu->env.cpu_state;
 }
diff --git a/target/s390x/kvm/kvm_s390x.h b/target/s390x/kvm/kvm_s390x.h
index 3c4fa0489cf..b1ff66f04e3 100644
--- a/target/s390x/kvm/kvm_s390x.h
+++ b/target/s390x/kvm/kvm_s390x.h
@@ -22,7 +22,7 @@ int kvm_s390_mem_op(S390CPU *cpu, vaddr addr, uint8_t ar, void *hostbuf,
 int kvm_s390_mem_op_pv(S390CPU *cpu, vaddr addr, void *hostbuf, int len,
                        bool is_write);
 void kvm_s390_program_interrupt(S390CPU *cpu, uint16_t code);
-int kvm_s390_set_cpu_state(S390CPU *cpu, uint8_t cpu_state);
+int kvm_s390_set_cpu_state(S390CPU *cpu, S390CpuState cpu_state);
 void kvm_s390_vcpu_interrupt_pre_save(S390CPU *cpu);
 int kvm_s390_vcpu_interrupt_post_load(S390CPU *cpu);
 int kvm_s390_get_hpage(void);
diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
index 57fd4b2b81c..b5256b3ba88 100644
--- a/hw/intc/s390_flic.c
+++ b/hw/intc/s390_flic.c
@@ -193,8 +193,11 @@ static void qemu_s390_flic_notify(uint32_t type)
         cpu_set_interrupt(cs, CPU_INTERRUPT_HARD);
 
         /* ignore CPUs that are not sleeping */
-        if (s390_cpu_get_state(cpu) != S390_CPU_STATE_OPERATING &&
-            s390_cpu_get_state(cpu) != S390_CPU_STATE_LOAD) {
+        switch (s390_cpu_get_state(cpu)) {
+        case S390_CPU_STATE_LOAD:
+        case S390_CPU_STATE_OPERATING:
+            break;
+        default:
             continue;
         }
 
diff --git a/target/s390x/cpu-system.c b/target/s390x/cpu-system.c
index 52561fffa3a..fffac09f241 100644
--- a/target/s390x/cpu-system.c
+++ b/target/s390x/cpu-system.c
@@ -44,8 +44,11 @@ bool s390_cpu_has_work(CPUState *cs)
     S390CPU *cpu = S390_CPU(cs);
 
     /* STOPPED cpus can never wake up */
-    if (s390_cpu_get_state(cpu) != S390_CPU_STATE_LOAD &&
-        s390_cpu_get_state(cpu) != S390_CPU_STATE_OPERATING) {
+    switch (s390_cpu_get_state(cpu)) {
+    case S390_CPU_STATE_LOAD:
+    case S390_CPU_STATE_OPERATING:
+        break;
+    default:
         return false;
     }
 
@@ -202,12 +205,15 @@ unsigned s390_count_running_cpus(void)
     int nr_running = 0;
 
     CPU_FOREACH(cpu) {
-        uint8_t state = S390_CPU(cpu)->env.cpu_state;
-        if (state == S390_CPU_STATE_OPERATING ||
-            state == S390_CPU_STATE_LOAD) {
+        switch (s390_cpu_get_state(S390_CPU(cpu))) {
+        case S390_CPU_STATE_LOAD:
+        case S390_CPU_STATE_OPERATING:
             if (!disabled_wait(cpu)) {
                 nr_running++;
             }
+            break;
+        default:
+            break;
         }
     }
 
@@ -236,7 +242,7 @@ void s390_cpu_unhalt(S390CPU *cpu)
     }
 }
 
-void s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu)
+void s390_cpu_set_state(S390CpuState cpu_state, S390CPU *cpu)
  {
     trace_cpu_set_state(CPU(cpu)->cpu_index, cpu_state);
 
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 6622886032e..dc67e848864 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -2007,7 +2007,7 @@ int kvm_s390_get_ri(void)
     return cap_ri;
 }
 
-int kvm_s390_set_cpu_state(S390CPU *cpu, uint8_t cpu_state)
+int kvm_s390_set_cpu_state(S390CPU *cpu, S390CpuState cpu_state)
 {
     struct kvm_mp_state mp_state = {};
     int ret;
diff --git a/target/s390x/kvm/stubs.c b/target/s390x/kvm/stubs.c
index ebf3c83994d..c5ec7d3f1d3 100644
--- a/target/s390x/kvm/stubs.c
+++ b/target/s390x/kvm/stubs.c
@@ -128,7 +128,7 @@ int kvm_s390_mem_op_pv(S390CPU *cpu, vaddr addr, void *hostbuf, int len,
     g_assert_not_reached();
 }
 
-int kvm_s390_set_cpu_state(S390CPU *cpu, uint8_t cpu_state)
+int kvm_s390_set_cpu_state(S390CPU *cpu, S390CpuState cpu_state)
 {
     g_assert_not_reached();
 }
diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
index 1801b8caa6e..6e3367e2725 100644
--- a/target/s390x/sigp.c
+++ b/target/s390x/sigp.c
@@ -39,7 +39,7 @@ static void set_sigp_status(SigpInfo *si, uint64_t status)
 
 static void sigp_sense(S390CPU *dst_cpu, SigpInfo *si)
 {
-    uint8_t state = s390_cpu_get_state(dst_cpu);
+    S390CpuState state = s390_cpu_get_state(dst_cpu);
     bool ext_call = dst_cpu->env.pending_int & INTERRUPT_EXTERNAL_CALL;
     uint64_t status = 0;
 
@@ -221,6 +221,8 @@ static void sigp_stop_and_store_status(CPUState *cs, run_on_cpu_data arg)
         cpu_synchronize_state(cs);
         s390_store_status(cpu, S390_STORE_STATUS_DEF_ADDR, true);
         break;
+    default:
+        g_assert_not_reached();
     }
     si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
 }
@@ -362,6 +364,8 @@ static void sigp_restart(CPUState *cs, run_on_cpu_data arg)
     case S390_CPU_STATE_OPERATING:
         cpu_inject_restart(cpu);
         break;
+    default:
+        g_assert_not_reached();
     }
     si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
 }
-- 
2.53.0


