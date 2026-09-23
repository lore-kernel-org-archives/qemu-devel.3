Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67447C98302
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 17:16:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9QVs-0003gQ-QV; Wed, 23 Sep 2026 13:12:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9QVV-0003TD-Uv
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:11:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9QVU-00013V-8h
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:11:45 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NGTqX5741302
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 17:11:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HjtG4nBnBjHP3J7mmX5f2+INYZmR70rs4qc55y42Quc=; b=bDq2X2PbCzU42CWu
 OCy24izNHNr2V3bCqCIyzM6ipTncVeeyl5BvpBxuY7H9Xw7JzholTVLIVPCE52iC
 FkeVhOtF9JXDW/ZC+SmaC+fdIefcoPQ1XnOK5Ca+eyCc1aWrGlZ2kQb+wv4xIMAZ
 FUCNnzMKS94caIScslRf846o95hzA4SXlQ4fgDmTwIC+DTxQoWhUTFXtltXoxdqL
 rHXedrlUEkahNW7JQdZCs0HYoKqk8PELsESffyTvKFXg0lxXELtIQyfJj71oyN0W
 5VhMHXpV4dpwRSRG/Mx++ix1cJwlfvo/d5yo7SFSrGdWPbVX+5vKrzaJKkB4ec3R
 EtPcrw==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvfjsh39e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 17:11:42 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5c83007a11cso482252e0c.2
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 10:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790183502; x=1790788302; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HjtG4nBnBjHP3J7mmX5f2+INYZmR70rs4qc55y42Quc=;
 b=IovOGKS+wrgFKDJ60LoXMlJlLWCvLCn572dkckWKFYZA3P1R0vBCf35KpPAUzolgUr
 1kIFUbZzgY89WxPwHponmbRaQrqOrjbqH6cg6WL/tHywiuJOPBvRaKFPpUIAJlHi/99w
 Bhj0o9pdxSvIWob/lHb07lyHWc7xxhhpB3QZ9QSdGGsxQv2N12lXcWo3Xzs7ygdDt/H1
 tWEV4+QQBRvLIgdW+5T9ICgMcssiDIkhV+KfVvJbskF/JMg3LbrVXbIGWZYBIjzbj/wQ
 +pQzsIMgx8xHI7YvIoQZeERvtM/MkN3qArk+mrL18vtZ3ni3bQqHBRwQ/zRsStTU//TP
 ZUdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790183502; x=1790788302;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HjtG4nBnBjHP3J7mmX5f2+INYZmR70rs4qc55y42Quc=;
 b=wi3bwNFHyyT3frdtm+DIoaq58ItYv4DX2h7hzHGk4om6iaa64uWwcy66TzvgrEfleW
 N8/m6xxV1gBwCpVfz6GcJT+xiTCRMZSgAkm0pPpMUjhv/6s2VZ086ZQHKhrlSyLE5o50
 OYmXCqzGoh/+FceVJJily1cfdyAhj+wsuqZMj9w/SBkp+aMC9T4JX/fApjrAo+ge1jJY
 2g0pnZZ+oBhvmzf8prVtZ0mQuWr6XpmqTbxC1v17KAIhbNUS/PKyl3DgZtlOoPXgt5mn
 pPrr63XX23pKixZ6YTUdlTlnOjCGgfCPjp7EtIJOyt5sCvv3Y3F1FZmlrq6VT8apLyyx
 xU8Q==
X-Gm-Message-State: AFuF++l9xZ2HJCLwu5Td2ciSy0CX2Pcut0b2TWs+wYZsD3iAB0d7MAsT
 MLrHJRqr5GUMazSCF23Co3kzX5T0GYo4q466tnRAB7NfzoKyHwO72MyHSx6rVDrDmr5j8wf9Y4A
 dDVBvD78fRj+b/RW/oCba7j/xpAdj4Ir07i/PHy251qNJo68UgAYH5PihpJVuxVlvQgUg
X-Gm-Gg: AYBFou1ne07G6IFkkwY1Ck1knqNeItwTHX93sUWKVAsgTTqeGz8f3j8HXD6gHQdRCkj
 mpTz6gjn6uDEWbnadZvp0ayuAdQdVe6XF7oIZ+vVxpJzY/ZXUIJDXj6/312Bqa9xffzqTzD/4UB
 a1FDu6eLl7PrYZz4nY3ym5VzJQg8b3Q1FIbVgcJz3rtyPQVw+WxxIRIz8Vlo3d3xsn0Ku9mClB3
 Dvy88/Ht/qQvGi7G0+ZTvkpxqism7uMhIHFBIPlZ8VVZFIPerrcwDicfL+HPZtTSfA1hiv6M5Pq
 T9qKQGewRvVhTTEHlYx7oBXRRZyYlA6hXlTULfxCSW1E1Uefmo+we/EOq1JBdRmU4J5ngwp9y+z
 F/ib2Fz1hX15MU104YyH5nDxCV0mWxwCyncO4jV6Y
X-Received: by 2002:a05:6102:94b:b0:7a6:a24e:8140 with SMTP id
 ada2fe7eead31-7ac1bd45308mr3214267137.14.1790183501703; 
 Wed, 23 Sep 2026 10:11:41 -0700 (PDT)
X-Received: by 2002:a05:6102:94b:b0:7a6:a24e:8140 with SMTP id
 ada2fe7eead31-7ac1bd45308mr3214241137.14.1790183501216; 
 Wed, 23 Sep 2026 10:11:41 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48868889130sm8042797f8f.37.2026.09.23.10.11.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 23 Sep 2026 10:11:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Eric Farman <farman@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH v3 03/21] target/s390x: Make s390_cpu_set_state() return void
Date: Wed, 23 Sep 2026 19:10:57 +0200
Message-ID: <20260923171116.31276-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923171116.31276-1-philmd@oss.qualcomm.com>
References: <20260923171116.31276-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA2OCBTYWx0ZWRfX4sXHSLQ8rMsl
 syZRUf4h36nNv0SmqszSGeOxVlKSZxEe74WtPcRnRMKK7mTCI0ZxWHgu0F/iJFp+N5rEmHXNaTz
 TH7/+fgD6elOZBEdhLXmExEp66Cl0CtE10T8lH5SNarqfbg8lSxTVULDyOm8+8iEFwmbhAnvHin
 pYAPdleiistgk2/+waoolGn2c7qHg0FbXY0TP2QqQ70FqJmhmaCTklQ8NZVxnlWa8z0xXzv2BdF
 6mBlw11DNnP3COYs4rumm82R2lwgonnXXTRIxuMEaKxDhTp2xTcEb/XxGMM/kCZPg/ePZ6TFuOX
 CIu5CYSEM/g41m6CyNmfH6VEfeDCGczMhtzxqqy8DcJDEe1561841Sk9c2goP2zzfNJS2uw79iC
 1Zce/tEhrn+DvmKq68PilFOYwVZPZ+bQcTDdyWrIxARpFwaglQDMDi6PTo+gPCOuSwqm4RIMlRa
 PDBb/+QAKVrdsi+/6pg==
X-Proofpoint-GUID: qbKoQzFGsvDSYSwhJYZ4nujhY-oeoH-g
X-Proofpoint-ORIG-GUID: qbKoQzFGsvDSYSwhJYZ4nujhY-oeoH-g
X-Authority-Analysis: v=2.4 cv=K4+3jCWI c=1 sm=1 tr=0 ts=6ab4084e cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=otiJeUf2ZByGLVp8V8QA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=tNoRWFLymzeba-QzToBc:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA2OCBTYWx0ZWRfX4YeCAJ5wdzv0
 rSXsKcICfyE+6+vxynY7AVHTZ7EqFpI84rM7rBIj6xtLtOzDHFaxSei0Iwqv24KVFPfhJ9sC4t9
 xeZUU5SBfOgH7WjImEdreF58KXFIqJc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230068
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The return value of s390_cpu_set_state() is only used by the STOP
interrupt handler. Make the setter return void and count running
CPUs directly at that call site.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
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


