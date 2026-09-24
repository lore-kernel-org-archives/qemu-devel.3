Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C711C98318
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 15:26:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9lKv-00031Q-H7; Thu, 24 Sep 2026 11:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9lKM-0002Hg-Iz
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 11:25:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9lKK-0000Tg-6D
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 11:25:37 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OC4kFb2385712
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 15:25:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1T2E2E4LzVsurXQ5tc5NvsY62ajqbiRq/66FwyhTEe8=; b=HXmJUazHqh1PWDoc
 y7Th/0YeHq3Om6d62zCVI45JqnUJDsh9q/4k7LuNERmgLLdZw82ikqAsLwkHSECL
 0T2On71BSAYpmSN8SU1KCqqIVRA371oDoO0qYHXinuaCzywXuudx4sIFqxyJHvvL
 A89T7x8xunLrk3eT+coLnQ12l5Ykq1l4b0H5LbLy5R9o7hllgsStp5uu9x7Z4Qdc
 Nh0rlwExK5lA33Y5pbFfepaYTSQrCtvXVYsTqbtoq1Q8ZgVAEKCabw6tksPNCALV
 39iAjoQrqkov9hRqv8CIAX8534kPjWMgpccYJiEUknU65LWMJDFp+OVJy8PUFbBP
 /CRz9w==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvsfgu7h0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 15:25:33 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-9806756ea40so1683787241.1
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 08:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790263533; x=1790868333; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1T2E2E4LzVsurXQ5tc5NvsY62ajqbiRq/66FwyhTEe8=;
 b=Vv66oUnFOO8XFOy0o3BSXoKSyoHX7e+WinzWFrakDpsnuBxmRR4tAOFWCLX/riJG8q
 bQULJwpae97eCgkguFSyKD8md5EGwYxNrKhUNRlfU8kideBDtTWDGi1CBEqBfV+N3sTh
 rmt5TrIp1koXiZ/NIoEY/0PdsdA7ivAomI0Uf0xaD20W7nJMp0noouSM1bR7TJQ0jw0q
 81hgjeNPM+VNw5sVtmai7/kvHkcLPl79QFQRLeUdXCDm7lfPI5ysChtr8N+VzdyEHzW8
 ebTE7pjTF9g5XltxxBpMZ6xTI+CxEooFr4evG7v0Ms+6l/GXAhDm8dUSAMg7vsuZ7Hlp
 /BaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790263533; x=1790868333;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1T2E2E4LzVsurXQ5tc5NvsY62ajqbiRq/66FwyhTEe8=;
 b=p1jjJGCPeBUgufECXFG+0F4ciffIcWVp9+3ScQCXNjRbPZRFLlI9HenW5klNHdLH9M
 lTyTvXSN8PoOdBcXx5cYNDnZ0UhesaLkiZpiUDDRZQdZK83r8jnsvwEXuxo+h/m6CCyc
 018IvG7c1SySLrckw0L41JaKfthGhdVp593KCZBTpmSet+/184dlebKYFZjcTLo+8EEp
 AjT+lYdENkO9ncqzRMwZJkZ5TVkRLY9KJSZ+9K6G5wIsmpqTi9EdUcQagr7hOisa4Jj4
 oHcsrVNbrrYsI7AgmBtzxj8fJnUrv/8KtYhZhQkZa1tGt5ty0nJ4kruDUyBAkf7pzUk2
 1PZw==
X-Gm-Message-State: AFuF++mt1DMr82CXOnUXIL6+S8/wGSmfHLPUa12ZNWVjvNYZSwDk9DOo
 HYg9zUWBgnAXhodh7hBaqnKGFciGjcrBBs/k7oHnjERbHVzJdKepBsUuFfZUum9S21lhIr1vinH
 tiulJiA8rzNJXZZVx/IeWDMfq/yJ0hZ6yPkRN4JmDwxpEAky6ReUTq1Gw+YIfk8Pb5w==
X-Gm-Gg: AYBFou0Rxh9r5QjrIQDR+M3vlTiVSAvJ7kijZc1KxCESaRXAuRS/FNVF80s3DwACqEl
 XHH49rbwJKq/6Rl5b5i/HnNRgfBM8RalmlXd8cdk14Q6mZfgHiCKnVAFJk7hUanrUyX/4xYD+x7
 KfF6KBtdHURgCbspXq93u1SUmDv8gMffOlxnIbWk9emjFVxLUCAzuViwgC9pC3aJkyaixIYIafk
 hyVDnPZwNBIQXPghQxq/FBxxLiVZorOU4SPh7t5F6UJp9nYa7czj4M1hK7sRgV1NQmE67sjtSoW
 pXZNpqpyYKPWToiCq6WP7OXmcj24Q5bzdsEoHPvlJHd0KAKA5vzcaCpExNarDIAxUes2agmgKB4
 WXqQZzkMGJ3oVz/9Yh4pSVEViLeFokAGYUTtkBUow
X-Received: by 2002:a05:6102:390f:b0:7a5:7282:1998 with SMTP id
 ada2fe7eead31-7af1cb9c29emr1466360137.11.1790263532890; 
 Thu, 24 Sep 2026 08:25:32 -0700 (PDT)
X-Received: by 2002:a05:6102:390f:b0:7a5:7282:1998 with SMTP id
 ada2fe7eead31-7af1cb9c29emr1466345137.11.1790263532223; 
 Thu, 24 Sep 2026 08:25:32 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fdf99df60sm113775895e9.1.2026.09.24.08.25.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Sep 2026 08:25:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/18] target/s390x: Use s390_cpu_get_state() consistently
Date: Thu, 24 Sep 2026 17:23:44 +0200
Message-ID: <20260924152353.36209-10-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924152353.36209-1-philmd@oss.qualcomm.com>
References: <20260924152353.36209-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YfoodARf c=1 sm=1 tr=0 ts=6ab540ed cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=z94vmTcaOVfBjqTZL9kA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-ORIG-GUID: xv_h02ZFiWIB5A-9zLqgjDoBlRO-0Ukx
X-Proofpoint-GUID: xv_h02ZFiWIB5A-9zLqgjDoBlRO-0Ukx
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA2MyBTYWx0ZWRfX94yS8lwRHNa4
 tKRvfS3A5yFtz76cr6LQsJ0udPBi0aK7mG4UKBDcimAl1dSrxvAUWos0XQYjEjPWhG3pRrZtpyt
 WWI1fJJQaSEaJ0lo6oS18nhK6Nsongg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA2MyBTYWx0ZWRfXzMn6RYM0Dq4g
 03D/rAmL/5njp4SQcum86o35yyk60Ib+pvHuy4U/chuij1KEXd0J5KkINfvziiRp1kTCClDylQ9
 eQikdqWmH8IRj/R7qiQ2qtszgkwpiY2RtwQbmTZgh9kxE7HAGZPTj+ixMAz7ak3ueIUYHncAlmO
 f0B+il5kBJh4961XXBB8Jq7d+NF8a/Svt9DOLJm38lsFxT54dI5qJfFZRwyja9djMRtdEOmC041
 hwNfAPNwWqbtyeHQLP8BFw9YRm6U5wKQp3g77GxOIcgVCvVBSgla3FquUBlCqh71gmGk4ZK3ZiM
 itHPySFQo9U8+DlDurwuEVqdvNshL0UqPLwzByQLDqnJTEQ118oTDrcP6xJaitIr/x+p+vdkvP2
 8UxOy0S0Nyo/3c2NsB19/XII4pvs5UAmOu0b90N+puahxBjzoMbf50nA5oWQ7xnl/WC6+hnMHAH
 fIIZDxrnvYWMyQHVfJw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240063
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

Replace direct reads of env::cpu_state with s390_cpu_get_state().
This keeps CPU state reads consistent across CPU transitions.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Message-Id: <20260923171116.31276-3-philmd@oss.qualcomm.com>
---
 target/s390x/cpu-system.c | 2 +-
 target/s390x/cpu.c        | 2 +-
 target/s390x/kvm/kvm.c    | 2 +-
 target/s390x/machine.c    | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/s390x/cpu-system.c b/target/s390x/cpu-system.c
index cc9685221ae..c938c77d0bd 100644
--- a/target/s390x/cpu-system.c
+++ b/target/s390x/cpu-system.c
@@ -263,7 +263,7 @@ unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu)
                      cpu_state);
         exit(1);
     }
-    if (kvm_enabled() && cpu->env.cpu_state != cpu_state) {
+    if (kvm_enabled() && s390_cpu_get_state(cpu) != cpu_state) {
         kvm_s390_set_cpu_state(cpu, cpu_state);
     }
     cpu->env.cpu_state = cpu_state;
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 7c725b8a4a4..85afc5dec9a 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -130,7 +130,7 @@ static void s390_query_cpu_fast(CPUState *cpu, CpuInfoFast *value)
 {
     S390CPU *s390_cpu = S390_CPU(cpu);
 
-    value->u.s390x.cpu_state = s390_cpu->env.cpu_state;
+    value->u.s390x.cpu_state = s390_cpu_get_state(s390_cpu);
 #if !defined(CONFIG_USER_ONLY)
     if (s390_has_topology()) {
         value->u.s390x.has_dedicated = true;
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index b34a9127141..6622886032e 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -407,7 +407,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
 {
     unsigned int max_cpus = MACHINE(qdev_get_machine())->smp.max_cpus;
     S390CPU *cpu = S390_CPU(cs);
-    kvm_s390_set_cpu_state(cpu, cpu->env.cpu_state);
+    kvm_s390_set_cpu_state(cpu, s390_cpu_get_state(cpu));
     cpu->irqstate = g_malloc0(VCPU_IRQ_BUF_SIZE(max_cpus));
     return 0;
 }
diff --git a/target/s390x/machine.c b/target/s390x/machine.c
index f714834a98a..b44fba43f14 100644
--- a/target/s390x/machine.c
+++ b/target/s390x/machine.c
@@ -32,7 +32,7 @@ static int cpu_post_load(void *opaque, int version_id)
      * than via cpu_synchronize_state, we need update kvm here.
      */
     if (kvm_enabled()) {
-        kvm_s390_set_cpu_state(cpu, cpu->env.cpu_state);
+        kvm_s390_set_cpu_state(cpu, s390_cpu_get_state(cpu));
         return kvm_s390_vcpu_interrupt_post_load(cpu);
     }
 
-- 
2.53.0


