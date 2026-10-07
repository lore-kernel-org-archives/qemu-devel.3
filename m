Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21EE4CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:53:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEOJy-0005KT-RU; Wed, 07 Oct 2026 05:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEOEy-00007p-Gq
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 05:47:13 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEOEw-0000le-65
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 05:47:12 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6977jf7R1873620
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 09:47:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6l6SvOC1GslcljU7R4v9NfiXLQcg5BVEJeG1+ZSdvVY=; b=BZLri7BW0adPa4BZ
 /WOJrZGOH+kzvo4Ua11fIsBU0t1dH5KzOySEkBnZOsMc7bHqKW27BgY96qIFqtRT
 PoLbSq5kfH+gkgAz91W2UO+1A9LX1jbL8KcvHkIUSgH4vQz5fDdsTqJsHTDp4o9k
 dKdrcus1ZuHrutGz8WHTUs8lvUuftUTg5ufxQwaau91Y941OTI1/azeLp93G+Kho
 zMHzD5Hm5oG2xn3I6WEEeEOcC8MR+2phUtKPbwd5uFPfWYNMSp7jBmhtC7ACel10
 KcXBY3120L2NG0cM8qwvTtEYf5y0ND5x188vf+SqHvB6dOaLehVCUYGwm+8VP1FM
 YNlvCg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5fw8rtkx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 09:47:08 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-934956beec8so833073385a.0
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 02:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791366427; x=1791971227; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6l6SvOC1GslcljU7R4v9NfiXLQcg5BVEJeG1+ZSdvVY=;
 b=JGYAl4flLGqChC42AiKl2j9PyRU54Cy5+VjpMFSPcMqr+tJo/O0xpWv8xN6G2SV7bb
 p7Z88G4QXy3/e0D1tc2cgOUP7jIaz8yd1Xuv25VDM3/QdKq41CH0SKbTgdUHtgBh4XrZ
 TNNpn4flIFpX4lw2U93MtIO2FnWDhXObDcpBT70FJxh5TQrmT/+SglqzZlPHva172y2r
 LDdXnTF922jGhtX0NvUNbCgDAf8NYd//6ca6pHwfgC/k1Ku6cNENgtzcXu5j0zMiudkF
 bMEEHphcd1Juni5bIXGbv5mbGHuma/gni7jeXQj5uwE/18TFYwKadb3kx0FeOvdhX5bC
 o6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791366427; x=1791971227;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6l6SvOC1GslcljU7R4v9NfiXLQcg5BVEJeG1+ZSdvVY=;
 b=Oh4QHDmOCQIZV2Bh23T8ZlcfU4aPoGYVkFGPbas/pMjC2MKhnzPOgYgL5hVkYwGYUa
 RHMswEOysckPvjHiKzu0VIDhzNvL6ogkZZnWPrc3yFSAWw735Chn9HKEr36i9C43u7AF
 BrRzgpCU6DIoHG1PyX4HT6016eHmlYxeSr3/RWfUkoqJlTPFqXWJMGCDoBojCTRXc0WL
 /4HJYAKh05fbxrf02Jv42+T1qzCmsyEj12EJ4QVf/a8sRPjFUlRazR+YXK8xfAjFPGUA
 9B/x9S9WJ/Bdmi5Lox8MEYosLRhQcCHSTp6w5uJRqsz8Bto4d+6vjl1f5AQ/0AKryghi
 fCcw==
X-Gm-Message-State: AFuF++nI+dJoRxXZIiM9ihMUyDAjYkwvGXsXHclwbJhfv8d+9ZHjHU5x
 byOQFR3uhjwUS6ac3oFYeaGr7w3+SXXD41a6mzt9mnX+QX+xnAC0dnQFiJeQ5nGRvahZxcoJIW2
 mNprYaqY9bkqbyZoDR39fQm3ZKhYJw8a9MlpSobxYo/5HsHKsA6GcckBbeqT4bPHubU59
X-Gm-Gg: AYBFou0wMsBsq6BaLp2J12t8i4BGOn4+7N2/h/GRwLpDK2PUa18E6DVEck2xsgSSRqj
 LCdxtS6hOJESswgUUptXyjEYPfSFtZs0ZVPu1EXc8gjeTYBr1ySxyjHWfUYn9CN2Yd1UYpWfwDT
 afBmkSkKeBdJwWDXWUw4Q21iMEO+SoDN604iQ9e+9CY1pn2kGGtF9wvO7B7iPJVl5PAUs4XAdco
 FOT210AyPpbOT7tK/h0HE8IywD92AWT43rbuOEJ5+2wr5+g/Ofqlz6snV2eh/E0Zow1MdQJolA0
 dS+NZgYB0t/V0z3bavZPd4P+VF/4HMeUuOlvxGfM6mFpH9uWv8K9rE+lEIKOrcnIoLUIDB7Z7YZ
 5JO71RoGCyM6mtPjQWQ3dt+Sf2FgEMP6IscbtZM8K
X-Received: by 2002:a05:620a:2984:b0:93b:d7a3:45ce with SMTP id
 af79cd13be357-93e9b828cc9mr305831285a.55.1791366427564; 
 Wed, 07 Oct 2026 02:47:07 -0700 (PDT)
X-Received: by 2002:a05:620a:2984:b0:93b:d7a3:45ce with SMTP id
 af79cd13be357-93e9b828cc9mr305828685a.55.1791366427094; 
 Wed, 07 Oct 2026 02:47:07 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c71d2e2e9sm4434133f8f.46.2026.10.07.02.47.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Oct 2026 02:47:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Stafford Horne <shorne@gmail.com>
Subject: [PATCH 15/27] target/or1k: Register CPUClass::exception_name() handler
Date: Wed,  7 Oct 2026 11:45:03 +0200
Message-ID: <20261007094516.75732-16-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007094516.75732-1-philmd@oss.qualcomm.com>
References: <20261007094516.75732-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAzOCBTYWx0ZWRfX0x9wf6HLO8z5
 OqzNQ5sGDn4b4v91d+jl4gExL+x66MEEijt7bqii6265tWWxCMOD/uQySC5Lnxp/CH0sL41fBVy
 nljlGLZCPcliAcSlF8hofmR3tFA7CMU=
X-Proofpoint-ORIG-GUID: bAeNm7BKlkDoovvloUDpf-euMxZFi2km
X-Proofpoint-GUID: bAeNm7BKlkDoovvloUDpf-euMxZFi2km
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAzOCBTYWx0ZWRfXwmKFD/celtEf
 bHqz5ECCYmHw1sseCeAQu80KMfmT0VszSzb/Rf3+ru9rxRnUZQ83naf/xx19gyCuBrzvNck+rMK
 LjJb0G7nsH893KlwdQlR2EircHU+mhrsQ1eJgKZG1MFdew3pMFGHwm9e2XpwH4Frhij87IgtaBQ
 3xx4lUbs/K+jvDAmS4Fd9FnbtM9dAOiqNkIGLOpl+ej0aGQGLBkS/J/Q4zLJEWcoEDbkIg+SL7Z
 f/FvlmAIdIEgkYPvdX7oAG8lPsPZVrynDOk5PjETtjtWvzGMcS8+eg1h/a0auAxAImkMOZfi4Yp
 vDeyYTK8rOwTTVAf2HC5ZFF8P8gjdBs5jDa/Ic1rz7i8QLsb6vGn1c7YTh2xBMOzee4Tiiy/50I
 y9da0Gkgi272Z62Rnrm8Vt6HulqpQFNsrfe1mGNohO5QJbnfttpXnDjSqg08jyvNRqKMmlqHZIK
 mgp4dtgv4jd8xyZa3Qw==
X-Authority-Analysis: v=2.4 cv=Af0kjHXG c=1 sm=1 tr=0 ts=6ac6151c cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=slxP8ohElPSaHwuvTCoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070038
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

Factor openrisc_excp_name() out of openrisc_cpu_do_interrupt()
and register it as the CPUClass::exception_name() handler, so
the common exception logging can resolve OpenRISC exception
codes to names.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/or1k/cpu.h       |  2 ++
 target/or1k/cpu.c       |  1 +
 target/or1k/exception.c | 24 ++++++++++++++++++++++++
 target/or1k/interrupt.c | 19 +------------------
 4 files changed, 28 insertions(+), 18 deletions(-)

diff --git a/target/or1k/cpu.h b/target/or1k/cpu.h
index fc4387ce7ae..96ed1779fae 100644
--- a/target/or1k/cpu.h
+++ b/target/or1k/cpu.h
@@ -155,6 +155,8 @@ enum {
     EXCP_NR,
 };
 
+const char *openrisc_excp_name(int excp);
+
 /* Supervisor register */
 enum {
     SR_SM = (1 << 0),
diff --git a/target/or1k/cpu.c b/target/or1k/cpu.c
index 66c00c0930c..e15f6bb5e71 100644
--- a/target/or1k/cpu.c
+++ b/target/or1k/cpu.c
@@ -285,6 +285,7 @@ static void openrisc_cpu_class_init(ObjectClass *oc, const void *data)
                                        &occ->parent_phases);
 
     cc->class_by_name = openrisc_cpu_class_by_name;
+    cc->exception_name = openrisc_excp_name;
     cc->dump_state = openrisc_cpu_dump_state;
     cc->set_pc = openrisc_cpu_set_pc;
     cc->get_pc = openrisc_cpu_get_pc;
diff --git a/target/or1k/exception.c b/target/or1k/exception.c
index 0479a069592..388bf6dbab8 100644
--- a/target/or1k/exception.c
+++ b/target/or1k/exception.c
@@ -22,6 +22,30 @@
 #include "cpu.h"
 #include "exception.h"
 
+const char *openrisc_excp_name(int excp)
+{
+    static const char * const excp_name[EXCP_NR] = {
+        [EXCP_RESET]    = "RESET",
+        [EXCP_BUSERR]   = "BUSERR (bus error)",
+        [EXCP_DPF]      = "DFP (data protection fault)",
+        [EXCP_IPF]      = "IPF (code protection fault)",
+        [EXCP_TICK]     = "TICK (timer interrupt)",
+        [EXCP_ALIGN]    = "ALIGN",
+        [EXCP_ILLEGAL]  = "ILLEGAL",
+        [EXCP_INT]      = "INT (device interrupt)",
+        [EXCP_DTLBMISS] = "DTLBMISS (data tlb miss)",
+        [EXCP_ITLBMISS] = "ITLBMISS (code tlb miss)",
+        [EXCP_RANGE]    = "RANGE",
+        [EXCP_SYSCALL]  = "SYSCALL",
+        [EXCP_FPE]      = "FPE",
+        [EXCP_TRAP]     = "TRAP",
+    };
+    if (excp < 0 || excp >= ARRAY_SIZE(excp_name) || !excp_name[excp]) {
+        return "(unknown)";
+    }
+    return excp_name[excp];
+}
+
 G_NORETURN void raise_exception(OpenRISCCPU *cpu, uint32_t excp)
 {
     CPUState *cs = CPU(cpu);
diff --git a/target/or1k/interrupt.c b/target/or1k/interrupt.c
index 6e89157639a..399c98e3881 100644
--- a/target/or1k/interrupt.c
+++ b/target/or1k/interrupt.c
@@ -66,26 +66,9 @@ void openrisc_cpu_do_interrupt(CPUState *cs)
     }
 
     if (exception > 0 && exception < EXCP_NR) {
-        static const char * const int_name[EXCP_NR] = {
-            [EXCP_RESET]    = "RESET",
-            [EXCP_BUSERR]   = "BUSERR (bus error)",
-            [EXCP_DPF]      = "DFP (data protection fault)",
-            [EXCP_IPF]      = "IPF (code protection fault)",
-            [EXCP_TICK]     = "TICK (timer interrupt)",
-            [EXCP_ALIGN]    = "ALIGN",
-            [EXCP_ILLEGAL]  = "ILLEGAL",
-            [EXCP_INT]      = "INT (device interrupt)",
-            [EXCP_DTLBMISS] = "DTLBMISS (data tlb miss)",
-            [EXCP_ITLBMISS] = "ITLBMISS (code tlb miss)",
-            [EXCP_RANGE]    = "RANGE",
-            [EXCP_SYSCALL]  = "SYSCALL",
-            [EXCP_FPE]      = "FPE",
-            [EXCP_TRAP]     = "TRAP",
-        };
-
         qemu_log_mask(CPU_LOG_INT, "CPU: %d INT: %s\n",
                       cs->cpu_index,
-                      int_name[exception]);
+                      openrisc_excp_name(exception));
 
         hwaddr vect_pc = exception << 8;
         if (env->cpucfgr & CPUCFGR_EVBARP) {
-- 
2.55.0


