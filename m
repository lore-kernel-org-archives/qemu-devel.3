Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2529DC98325
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 15:27:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9lKx-0003Hn-PF; Thu, 24 Sep 2026 11:26:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9lKi-0002fg-5X
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 11:26:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9lKf-0000WD-0j
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 11:25:59 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OC4d461437085
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 15:25:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iDSXtdj6wpqBdHZ9WTpReBMYjE3hBC8Iom2zWJALQjA=; b=Z+Kk8Zml9P/0uV3z
 oRSnWEU/vnY0Zo3nBa8xLHSROh6wwWC20LtK8kS9rdsbi+Zv3TNNo7lvl2L2xOpS
 qG2V3mQBAcRPFLO1b3F0Ic4XtlDR/Z9CmJti+oL6piUBeVntdwunBKLYGgNbJbsu
 iChXwcr/oQL7463/1/lBA+P3fvwQHycTxsMvTc0f4aX8gukMZzsQFfwbX2ewPK8G
 CfLC3PCAHpToc7kaBmWBSyLuwYqvbsSyCC1v72AhZhmoUxXd9n/VcjkJpeB1seC4
 xBn69+GgRriE1Br1PkvKR7zt8rC3o5lYM1hAB7eq4XidoyEDlTiw7S8uyumsCvEI
 xEFb2A==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw1t7s9r4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 15:25:55 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-79285c98038so1896461137.1
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 08:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790263555; x=1790868355; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iDSXtdj6wpqBdHZ9WTpReBMYjE3hBC8Iom2zWJALQjA=;
 b=LG95nAg+0k3zSIoPD4DPx1wWgrpY33FnYZPNO667Rlj92LaI/49wZ83/l6Xgw8GglR
 Cp0OmA+DASTjknCqrppnDzKnOmnO/Ir5roY/Ij3DqL8RbFstc/OXyxN6NLhxSVBgoElX
 Yz41k9re+e43rkbDKz5RHc1PGAcToJjtX+Fia3Pivkmt2euSSuhukaZDRTvMu2T0muND
 36zFE40PJV7fiDreX1HXzgI2SiFousl+8MDx+D2K7qPGyFFSF0UXWnQMeOzI7VYCQy+7
 N6ZPLMhy/DQ3owCtmXz3YinSSumktQKjfmFGaju3VOG7Du8AJSgoeuS84MPHoLAu8K3N
 zsog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790263555; x=1790868355;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iDSXtdj6wpqBdHZ9WTpReBMYjE3hBC8Iom2zWJALQjA=;
 b=EbqKsq7xixLXU5H3jxnIffm9Y5ICRjUIcn9HdwbqKyOZVcZoAMM7WQZ9Pmeqi4+V9p
 8r1wb3HEjs3Xxta2r7m+O6Fb8jCzetxL4ALhvBqOZox+0kQwNQzJjRg8vu0T3XkiVsPw
 VJL/DrXvTVMiDFeH2KojnV+/XDh4R/sZOobr09csZR2ySyuKA+ibvMjRkDcysGcCadxE
 Msw1qJRHwTlEynF5kSVemSkkTzbNaTGJ6HSp1MJ32jRsVuZMRyvE0UezH9z6mzjJW17+
 kh5XvtBtdPLX3nJHeAycspO+YWOgb+ghf2/yYUxHeJgdn7AfEQKjrFdtvTeE6QPg0jqA
 NyPQ==
X-Gm-Message-State: AFuF++mhGBTpjLiRDctFCtRO3/tFek+tpPs5mb9P6imfuJ4+NjFKYJxM
 XieekzoxprEKwmYUy54cGs/a4OezhO0Y/e5AkN3W3lGvB9yrQsJlRpVjzEB1xhE6jRUFbsEfXmR
 cMhiJfHSbQrNKhTDxZ4xkVUxRrXhNs7/MojN4A7cD9PJBXkTCw82wW0QDQ+WwCLtP7A==
X-Gm-Gg: AYBFou2bhXjeCYu8kbbISKvkAChLMCGm8gnR5Mx2QhXblJGRB3t1/MLsx+WI1m336UA
 ev6U8Ovb6uEFFERQ7cnDsN0HOZWy+ycIbbKRxLjoa8cDN6XAmTjq7SiomqL+qmQRW8gTf8f8IbO
 8BkUYt821yYv6933qWivzujpjFlmebZZG89kWtt5wMnz6H+SZxVfjyjhBOYT31ZgyjBvfz1IGVh
 ZKWKwIMeMqBIU07yv6JWA515St6zTIGVQte9lRm/6jWCkMOuGeeZvY8e4UA+n7+Zv6rTrL4Ha18
 +E+jVUz3rQE3H0mLicYnd6KVXHzUjyFFe2k/NgPJLhd+vJT38AZ8PDQZsZY8BjBd/Jf/1hsXBVr
 OqzZxeiNVhRprr1JcDLPWz9zmtr4aaEv62Kxz5QgQ
X-Received: by 2002:a05:6102:3ed1:b0:7a6:b18e:6d24 with SMTP id
 ada2fe7eead31-7af1d6c2588mr1559314137.23.1790263555199; 
 Thu, 24 Sep 2026 08:25:55 -0700 (PDT)
X-Received: by 2002:a05:6102:3ed1:b0:7a6:b18e:6d24 with SMTP id
 ada2fe7eead31-7af1d6c2588mr1559264137.23.1790263553628; 
 Thu, 24 Sep 2026 08:25:53 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48868266822sm16805690f8f.5.2026.09.24.08.25.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Sep 2026 08:25:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/18] target/s390x: Use S390CpuState for CPU state APIs
Date: Thu, 24 Sep 2026 17:23:47 +0200
Message-ID: <20260924152353.36209-13-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924152353.36209-1-philmd@oss.qualcomm.com>
References: <20260924152353.36209-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: CrwjTNllNN4b58suNM_13mqUyUyf89_9
X-Authority-Analysis: v=2.4 cv=U/MHnuru c=1 sm=1 tr=0 ts=6ab54104 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=h1LczH6ptyU4K0ekaGAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA2MyBTYWx0ZWRfXyNNwlD0Qfh8q
 +a6VGBt2hJJmDCJfGVEAdiRiS/oPDO0mE1NPlANphoGf2tUPplBkW+XaCUpPbaks0VkZhwcdRsD
 NwgMmxsE9n8X/Xtj2Hz6xCp765P9CoeesvCg7pYshOMryHgP6LHIi2nwdUSl6LoXyI/BDWpQYVz
 AV5XpMaHbJ9Bagds146ArWfmRRNZDrOg+JFCyQhZPB940M+q3yrORPHzP8+oa6fmp1FmXSXLI6a
 vYMg6+5/BZHkwgIgM9WfPfjeNWk3UqDwbNZ8XGtmN5Bk+jdfrGR95GFF4KMoVjDT3Aq1c1HRnaT
 rI7SqCKzIWQWxv2EkaCVxxG+xohjlUA+7FkfPshrKCSDyAnSCo2BV4Jjb8nsMTJ8K0XN33rilrq
 Q/eEouESqIgjA5ri0UpBTfCOaT5BNU4bBYx1SA36i1K88DiX91W6JXCYFlOLKiRcsEFOI+irFNT
 eUD/mmHTr5pkfy01mMQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA2MyBTYWx0ZWRfX1BEC0TQ0Q7zX
 v58UPwZapjnWFmvI7yWp+B6JRd1RiOG0AS1gN696SA3X2Enb6ShSC945L/aR94uQ3OQt5NupWxt
 vfWMdDvKGT5yLymKXlEsCbbkLNgsIpE=
X-Proofpoint-ORIG-GUID: CrwjTNllNN4b58suNM_13mqUyUyf89_9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240063
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

Use the QAPI S390CpuState enum for CPU state accessors instead
of uint8_t. Handle state checks with switch statements.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Message-Id: <20260923171116.31276-5-philmd@oss.qualcomm.com>
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
index e1335d9be66..e15775875f2 100644
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
 
@@ -206,12 +209,15 @@ unsigned s390_count_running_cpus(void)
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
 
@@ -240,7 +246,7 @@ void s390_cpu_unhalt(S390CPU *cpu)
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
index 1801b8caa6e..09004e98a21 100644
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
+        break;
     }
     si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
 }
@@ -362,6 +364,8 @@ static void sigp_restart(CPUState *cs, run_on_cpu_data arg)
     case S390_CPU_STATE_OPERATING:
         cpu_inject_restart(cpu);
         break;
+    default:
+        break;
     }
     si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
 }
-- 
2.53.0


