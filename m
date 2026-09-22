Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBCC1C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 16:52:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x93h1-0003iB-6q; Tue, 22 Sep 2026 12:50:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x93h0-0003hp-8l
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 12:50:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x93gy-0002Ii-A2
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 12:50:05 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MEjNMf318307
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 16:50:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zB9WBbNZHM6m2phYTFE/2aurRaYcx6r0ryBqsnQvO6o=; b=AxR3mFZI9DkmVHx4
 7C6jxFrlHvgtvULEfkziLD8lhFa5sVlpBfDJkZZGdiINjhsNcgJ2h31XVgTNl5bV
 opwFvPdXM489Emy+Xut2eDZutP27lL4fNesmTKWDgmxp6z+DHyQAFfsm1lEf1Jl9
 BM8F7vHkvJ6o0VLNm/RVDz5fqNBQnTGMxm49i0wcJ1rSrGesNz/ADzrE8OUw7Ox8
 LWKPAheaoGarv1yjcZcCxcEE1Zvcauq2xlA7DETKbA8jgRtZsvPKdVwkZrPiuZGr
 KO6ZgPoF1QX4fcIGt6gksc64Nb4NqPbJrKnAbaukINGuKj+nOtH5f5XEiq+ZKGtS
 +UkG4g==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gupbqj7ea-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 16:50:03 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-98513b850f1so6187241.2
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 09:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790095802; x=1790700602; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zB9WBbNZHM6m2phYTFE/2aurRaYcx6r0ryBqsnQvO6o=;
 b=hB+c5UWBogNSyevI78N5z4qCMYm90rN33zYxLpgNCef7JdxK2yXL6PGtO0dvMxO07V
 rSvnSKp/A17+0fHShoXGO0xo//sVMgI3wbFpI4Rof/VgTpLgILZ53WHR90syf8pCKfeR
 AedJADQiji0rIcqBMOjhoYwFnlDiO3EprD7Aa5jiNIooQ/i3373A/AfO3zujgDM08uYv
 azkfYAUPnpLFOyx0NhLUo7JBqtcLJR7oXrUdxmQM7rkuhf4c6xzbNh2f6y/wMrAXoJNY
 khbRa1xzX96NU5p9ZyIXuptnk5Qf5Ku0pcqwAJgKvI7jtZGynjXPnVp0y7wp/ksdQugy
 eiOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790095802; x=1790700602;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zB9WBbNZHM6m2phYTFE/2aurRaYcx6r0ryBqsnQvO6o=;
 b=q6Re/HKEjzdQ1BTRtlYbY6b4m0aB0sakXXqhkkR+nDEsSxpLHafQRXmb8BpVzjIEPY
 ySetJqq+/E3SrHknTkPk25XO6WyQx6ixkD6aubz8x61ChRFBKX1u4tZqfUqo+cnXNEck
 RaNbvRsqqsQ0KHAn0LJybxzYromLveKSBRNeVLDJRtNSLFbKdagtxG+fybsve4PWgAze
 +yzs1qwzElHkdi6TFw47iKdxfxrtxKPl/T1Qs81redmPsTB43TqInhUN488MdMM/3s8K
 pnv6pUSIwfbbYeNzFbFVnL4Fax5ie7Ha/AbqhRBd8LRZEhd72DQz2N8iaQMTbRjH9oRo
 MN4g==
X-Gm-Message-State: AFuF++kqjr6Wp/EHCZ737+AQZnXmve++JJzz2GiuPK5hkrT5tGVb+qYR
 stYQEFzjYuPJ3GE7bI3aohlHC9qJVK2itkU3KSrCzOQ5iXpY/CxV2gVnSSWD4G3UaFd1QtJqEND
 CC1TzgbX2M0oa/jGyPYAIivq/XwIqXOQmPAiMmAhyjL98Tpl15yi91wKAMTeIFdrsgQ==
X-Gm-Gg: AYBFou34pEF+0+KDvFHmWSCH4jWPlY6rcUbx40zC3V/tJ+WD8wAaXZKlSjh4BffFOKF
 DCMSrZmx0O2G8Hmmb0aki9O8w9moLGqUpLXIFzRswRI52udYwvvmqau0BNDMXZuwqGy/tUMX3cX
 03IgOobvTPp3luQxl4Kuk2IAe6Ppo6aTK5+kbOlbLqxB4I/c7NOloTK1UqxQVuX3Bxprqgnkh05
 UabRLT6kU/D1JMK2Q3TSxe7JQhenzrybMKdF6nT2kU3GuB5rqVVN6gnV0SgITeFp4Lzm30/BUff
 /UU1nWi01s1KL4Vy0g6hYHmVQ+24CzHL9VAAL8yZK72ax5sFTs9NUvJiRlT+CJkvLuwpGmOxZPt
 vA/5x9cHXpCSbhPw90pwNKg225xzFVGKbYtXcoyfs
X-Received: by 2002:a05:6102:3ec3:b0:7a6:cd3d:4990 with SMTP id
 ada2fe7eead31-7a6cd3d508fmr7311123137.1.1790095802457; 
 Tue, 22 Sep 2026 09:50:02 -0700 (PDT)
X-Received: by 2002:a05:6102:3ec3:b0:7a6:cd3d:4990 with SMTP id
 ada2fe7eead31-7a6cd3d508fmr7311073137.1.1790095801988; 
 Tue, 22 Sep 2026 09:50:01 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fdaa544e5sm50831325e9.1.2026.09.22.09.49.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Sep 2026 09:50:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH v2 03/17] target/s390x: Make s390_cpu_set_state() return void
Date: Tue, 22 Sep 2026 18:49:21 +0200
Message-ID: <20260922164936.15189-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922164936.15189-1-philmd@oss.qualcomm.com>
References: <20260922164936.15189-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI0NiBTYWx0ZWRfX9xWgkl9a9vt1
 6kDrJc5uQ+2PwmKydyjUodoO8UFJ88cHVRsitQKEk73qNw4ZqwhOtThp+QaTldn4blDPzG/w7nL
 PnV9oNyVGZAkyR9Me0CkqIJZNWB+7yCvQcoa4VbYyCIsr53DV/sc5NM8u2bFPuS0G+zNqgttz02
 JJFgIK2NAH+yX2q5V1V1CwGjBaVGKJzsbsrLvSGxHZdw+MsuNcetsL/PCRcoUk7UzK41WYPUskj
 xEvpwEgED8lX34/CjrfPjZPFl2nZITQ89A2GWLGGn2g/pNXDKOPVhepq3hARAGI1u76kIzI3z9F
 oKHRRdJwWfCZEZwWoiYIZwcXzZEuH3NkcJrWZULcke3yD4+fzdmWLwG0aMkzU1KvwboaCOyVkKI
 5Xx83T5op1EWkaO22Mo02YbWTubvTIBdUbaz76duZheuKMyoqKU0hZs2adLfE3/JJDD3kofRdWD
 guLMRY4cfc4cBhTLMWg==
X-Authority-Analysis: v=2.4 cv=FdaiV5+6 c=1 sm=1 tr=0 ts=6ab2b1bb cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=otiJeUf2ZByGLVp8V8QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-ORIG-GUID: prnKaTxnxNgx4MnlHJJAhuuRjhK06q_H
X-Proofpoint-GUID: prnKaTxnxNgx4MnlHJJAhuuRjhK06q_H
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI0NiBTYWx0ZWRfX5iPU396HpD/v
 g8TzXAu6GpJ0XN2NaqCdFdDgHlGLKmkbxHaew8gzxuyCElqb0ukCFyom6pia7STxWxugEhp2pYT
 a+wy2JwrNRWfwqWGMCCqkODOQVbvXHI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
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

The return value of s390_cpu_set_state() is only used by the STOP
interrupt handler. Make the setter return void and count running
CPUs directly at that call site.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/s390x/cpu.h        | 5 ++---
 target/s390x/cpu-system.c | 4 +---
 target/s390x/sigp.c       | 3 ++-
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 998bbb0d7ff..2d1dcc7045c 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -847,11 +847,10 @@ void s390_do_cpu_set_diag318(CPUState *cs, run_on_cpu_data arg);
 int s390_assign_subch_ioeventfd(EventNotifier *notifier, uint32_t sch_id,
                                 int vq, bool assign);
 #ifndef CONFIG_USER_ONLY
-unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu);
+void s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu);
 #else
-static inline unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu)
+static inline void s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu)
 {
-    return 0;
 }
 #endif /* CONFIG_USER_ONLY */
 static inline uint8_t s390_cpu_get_state(const S390CPU *cpu)
diff --git a/target/s390x/cpu-system.c b/target/s390x/cpu-system.c
index c938c77d0bd..52561fffa3a 100644
--- a/target/s390x/cpu-system.c
+++ b/target/s390x/cpu-system.c
@@ -236,7 +236,7 @@ void s390_cpu_unhalt(S390CPU *cpu)
     }
 }
 
-unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu)
+void s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu)
  {
     trace_cpu_set_state(CPU(cpu)->cpu_index, cpu_state);
 
@@ -267,8 +267,6 @@ unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu)
         kvm_s390_set_cpu_state(cpu, cpu_state);
     }
     cpu->env.cpu_state = cpu_state;
-
-    return s390_count_running_cpus();
 }
 
 void s390_cmma_reset(void)
diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
index b6d44c5c31b..1801b8caa6e 100644
--- a/target/s390x/sigp.c
+++ b/target/s390x/sigp.c
@@ -617,7 +617,8 @@ void do_stop_interrupt(CPUS390XState *env)
         s390_store_status(cpu, S390_STORE_STATUS_DEF_ADDR, true);
     }
     env->sigp_order = 0;
-    if (s390_cpu_set_state(S390_CPU_STATE_STOPPED, cpu) == 0) {
+    s390_cpu_set_state(S390_CPU_STATE_STOPPED, cpu);
+    if (s390_count_running_cpus() == 0) {
         qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
     }
     env->pending_int &= ~INTERRUPT_STOP;
-- 
2.53.0


