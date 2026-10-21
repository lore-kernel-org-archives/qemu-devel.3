Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465C6606BECB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 03:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lLCZ8DCO;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jGrMHKgK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJMrA-00014z-DX; Tue, 20 Oct 2026 23:19:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJMq4-0006wf-Tx
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 23:18:08 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJMq3-00038B-3l
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 23:18:04 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L2Es4o3420597
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 03:17:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 p7RQ7yiqg1Ox1Ti9CPFcdqZ1SQNOTHd0iyzgVVE7fmg=; b=lLCZ8DCOxUTygjmo
 1Yyc5WEPSY7jMdIe+SQLWmIBncvPiTrZAHGqVOg7uG0qwM6FXZYOL7OPefKRpjZu
 z0veRimutgoRMP7CVOEm6kzwrVWpFKcRgZ4ESOfcFNeq3Rl+oVv9nQjO8N2hO6is
 +fCG8vcMMc1qZtOAUUhF6zIIMhszruFbR6YjhiU6S80P7lgAX4eYvjE2uR/iZeS2
 2xSPL1uEc1BFbBvMnipCrkolisOV4Z1JFqyto95GluQF8mBo0Xm98HfEXaeU+vkZ
 SI/Qdg113V1Ei5AeSTzVKI6+eSo8uyfAZjakZM7N8Nm0A5jelDmda6VJnrpAIPcW
 GXRHSQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heh5r0ufv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 03:17:52 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93caf6c528aso52882385a.0
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 20:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792552671; x=1793157471; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=p7RQ7yiqg1Ox1Ti9CPFcdqZ1SQNOTHd0iyzgVVE7fmg=;
 b=jGrMHKgKIpu2WPptTNkqBAYf5DZY+6PYYju1Nn0BaSk39bmOLfRecD8bpC4qrNzOL0
 TReQ0Ok2LPcrAJ8VHWylJNx/1kVS9tPyzJjO+Nc94drod4jYPBspHyJ8+dzVLRB6BOF/
 5N50DAaXstbb3+runYDD5ZZ82RrdiJ1e5N1gwoV6DibKHDN4AN3WTtLhHeHvxL3kje/E
 Qp2yGfpQnNM4y1u8F9nAi2YoEy2tYFCB4kOEsPIp3mMW3y+4brQW7PqcW52cxGlapftb
 SO8cb8T/Ywdcwh52aiFgP7OGWZ6E4ReMWX+49oEFuwprNVOx+tcgcyQCTBJCNhfy6kEl
 KwzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792552671; x=1793157471;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=p7RQ7yiqg1Ox1Ti9CPFcdqZ1SQNOTHd0iyzgVVE7fmg=;
 b=JDd7nHWhjKoDDqjLi8DU65uQSW0XMuRfcRqzuF1o3sGlO52JfPQj1+SD1PvaAkxFz7
 H5zUXzSyj2zocE3n0+JiU2tc+g2TQLUuEUY1n3qHjjCJWE3cxDyROvwoFulOphjRgCvb
 I3UkfccCewpH/M1/JGOVvAENerkXbA7HmIVjEi7v1U7kPlxR1WPO2a2Qr/MaCn6DIC2h
 7UX4Qhu9vH98hVrn61ou2r4Ia4/M/Lga31KpFgrLQgh7TFJj/epTxkO5q1pTFeX4Mvd6
 P4Mj50ijRh4FLkapNcYkivwt3ilZexSaqhDZVkNp5HZRy4wPLJv4y1qBOzP8SqPxxcHi
 F69g==
X-Gm-Message-State: AFq9FYJLk/T+IOMfcExZVf3n1wGWgR6DGYAJXaNZ88w+ESeLh4P9q/A0
 hPuCoaahZzJWdwTH2SxWjbVX75RrIOaqM3FHdQfFUsLSrZglgbrUF9NLGNTjgfNQ9iDu0hsAt8z
 z6IcYcBZCdljZva4uDBhXtI3Z/teY7fdOrtwh/r1pqSrABGAr3uwHKSP3RRjAar1WtC8k
X-Gm-Gg: AYBFou2fT2hzGpx1b9qcHQBkWh3yaQxN9bkTFAM6d6vwy5H1QUId31uEyxut/4kOEp3
 F6lKv5gR1MoLobgAeewVI3anhcx3Nw/RXJthrofD9DkhZ9elUiJL+kpWgO/rNQ0TlE5hVYS+t46
 W1HBIx48q74HzgWasrm1qJj56JRqIa16Ly9xDr8s4Dej8k8gzmobD3iCu44WCZG+UFpNdtlInd3
 CPJxhPuPq2yYkCLW2BuQMh16x6TfVfouCcd3V3boRsmiVnGcLz4n3VoEqW8Sx4U61rLB+pGvi1W
 cY6kvgVHOuKWDBHnebUuuy8YYUHOFIzj3wQF/9zEkH1Wr+0g600uojwfa03G8yn25EmSNdNSjVs
 4FCSMEbyt73834bjS8nMLzrgI6eDKFaWAuNkTYgII
X-Received: by 2002:a05:620a:2788:b0:93a:13aa:1b9 with SMTP id
 af79cd13be357-93f57f1c945mr220871685a.30.1792552671537; 
 Tue, 20 Oct 2026 20:17:51 -0700 (PDT)
X-Received: by 2002:a05:620a:2788:b0:93a:13aa:1b9 with SMTP id
 af79cd13be357-93f57f1c945mr220869485a.30.1792552671048; 
 Tue, 20 Oct 2026 20:17:51 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e254f0bc2sm2442908f8f.1.2026.10.20.20.17.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Oct 2026 20:17:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 28/33] target/sh4: Register CPUClass::exception_name()
 handler
Date: Wed, 21 Oct 2026 05:14:01 +0200
Message-ID: <20261021031407.24862-29-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261021031407.24862-1-philmd@oss.qualcomm.com>
References: <20261021031407.24862-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aI5lOr9m c=1 sm=1 tr=0 ts=6ad82ee0 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=1bLhyRm5UWLPkFMrcSkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: kk3oVmrc_PEmF1XYKk7ALEiAPZjaZnRO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAxMiBTYWx0ZWRfXyGKqG3GrLXlK
 eJlN4e0VeVMiTYHKpXkaTmPEPumjxgR/9GZiGTGZaeRW8Th9iN17BbFou0sEvgEAoaaL3AMZWb/
 eGL/qwwTuc/IJVKBRIk6WR9EskCh90Bu76we84hhlSkm/B9OCl72EtAYN8VgvDI+YVbFJQSiAgx
 hY01OkqxHwzKcetMnAhpd63IPNqkROsq/zmqGse+rdrvdTSFdCZZwGLZdg9MrMtIxbGA7ztAn1o
 EWnw+EXEeSdPxDxecVUX56f2UOfwg8NIQI4frd13v7U77hrz1a3fuhBwY6qIazEP4ii51fKmUJz
 MN6Cu1LmZVf5rL4XI2NQHV61wIbla2RZ1xtkYwIApz3SBxRrGJaY2d7CcSLXIWJ/81jcwQd88BS
 sfEJ476ENs6eGFZG3pi3zQ9PAXk28P4sdrC0jtVBQIseEySqZx2XXYIYZn81jUNbkD0aMIfZtdv
 Cx+mMBy8lQ2HsKy9OrA==
X-Proofpoint-GUID: kk3oVmrc_PEmF1XYKk7ALEiAPZjaZnRO
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAxMiBTYWx0ZWRfX/l7BDWSYTi/F
 mieTLL4PfgFlkqLQ61zF8hMqDRkSmbqf5dOy/Vz85bYxY3kgafUYl0YBy9D16VJVPFUxYXnSlsS
 hcYNAzz4tARbeae+VOuGN8Sk819r1k0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 spamscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210012
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Factor sh4_exception_name() out of superh_cpu_do_interrupt()
and register it as the CPUClass::exception_name() handler,
so the common exception logging can resolve SH-4 exception
codes to names.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/sh4/cpu.h    |   1 +
 target/sh4/cpu.c    |   1 +
 target/sh4/helper.c | 101 +++++++++++++++++++++++---------------------
 3 files changed, 56 insertions(+), 47 deletions(-)

diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index a1e9049b7be..94f2f1278b9 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -258,6 +258,7 @@ struct SuperHCPUClass {
     uint32_t cvr;
 };
 
+const char *sh4_exception_name(int excp);
 void superh_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 int superh_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int superh_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 3bbdee301d5..97a718c3911 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -334,6 +334,7 @@ static void superh_cpu_class_init(ObjectClass *oc, const void *data)
                                        &scc->parent_phases);
 
     cc->class_by_name = superh_cpu_class_by_name;
+    cc->exception_name = sh4_exception_name;
     cc->dump_state = superh_cpu_dump_state;
     cc->set_pc = superh_cpu_set_pc;
     cc->get_pc = superh_cpu_get_pc;
diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index 0fbd613f333..5856bab6983 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -47,6 +47,58 @@
 #define MMU_DADDR_ERROR_READ     (-12)
 #define MMU_DADDR_ERROR_WRITE    (-13)
 
+const char *sh4_exception_name(int excp)
+{
+    const char *name;
+
+    switch (excp) {
+    case SH4_EXCP_ADDR_ERROR:
+        name = "addr_error";
+        break;
+    case SH4_EXCP_TLB_MISS:
+        name = "tlb_miss";
+        break;
+    case SH4_EXCP_TLB_VIOLATION:
+        name = "tlb_violation";
+        break;
+    case SH4_EXCP_ILLEGAL_INSTRUCTION:
+        name = "illegal_instruction";
+        break;
+    case SH4_EXCP_SLOT_ILLEGAL_INSTRUCTION:
+        name = "slot_illegal_instruction";
+        break;
+    case SH4_EXCP_FPU_DISABLE:
+        name = "fpu_disable";
+        break;
+    case SH4_EXCP_SLOT_FPU_DISABLE:
+        name = "slot_fpu";
+        break;
+    case SH4_EXCP_DATA_WRITE:
+        name = "data_write";
+        break;
+    case SH4_EXCP_DTLB_MISS_WRITE:
+        name = "dtlb_miss_write";
+        break;
+    case SH4_EXCP_DTLB_VIOLATION_WRITE:
+        name = "dtlb_violation_write";
+        break;
+    case SH4_EXCP_FPU:
+        name = "fpu_exception";
+        break;
+    case SH4_EXCP_INITIAL_PAGE_WRITE:
+        name = "initial_page_write";
+        break;
+    case SH4_EXCP_TRAPA:
+        name = "trapa";
+        break;
+    default:
+        name = "???";
+        break;
+    }
+
+    return name;
+}
+
 #if defined(CONFIG_USER_ONLY)
 
 int cpu_sh4_is_cached(CPUSH4State *env, uint32_t addr)
@@ -95,53 +147,8 @@ void superh_cpu_do_interrupt(CPUState *cs)
     }
 
     if (qemu_loglevel_mask(CPU_LOG_INT)) {
-        const char *expname;
-        switch (cs->exception_index) {
-        case SH4_EXCP_ADDR_ERROR:
-            expname = "addr_error";
-            break;
-        case SH4_EXCP_TLB_MISS:
-            expname = "tlb_miss";
-            break;
-        case SH4_EXCP_TLB_VIOLATION:
-            expname = "tlb_violation";
-            break;
-        case SH4_EXCP_ILLEGAL_INSTRUCTION:
-            expname = "illegal_instruction";
-            break;
-        case SH4_EXCP_SLOT_ILLEGAL_INSTRUCTION:
-            expname = "slot_illegal_instruction";
-            break;
-        case SH4_EXCP_FPU_DISABLE:
-            expname = "fpu_disable";
-            break;
-        case SH4_EXCP_SLOT_FPU_DISABLE:
-            expname = "slot_fpu";
-            break;
-        case SH4_EXCP_DATA_WRITE:
-            expname = "data_write";
-            break;
-        case SH4_EXCP_DTLB_MISS_WRITE:
-            expname = "dtlb_miss_write";
-            break;
-        case SH4_EXCP_DTLB_VIOLATION_WRITE:
-            expname = "dtlb_violation_write";
-            break;
-        case SH4_EXCP_FPU:
-            expname = "fpu_exception";
-            break;
-        case SH4_EXCP_INITIAL_PAGE_WRITE:
-            expname = "initial_page_write";
-            break;
-        case SH4_EXCP_TRAPA:
-            expname = "trapa";
-            break;
-        default:
-            expname = do_irq ? "interrupt" : "???";
-            break;
-        }
-        qemu_log("exception 0x%03x [%s] raised\n",
-                  irq_vector, expname);
+        qemu_log("exception 0x%03x [%s] raised\n", irq_vector,
+                 do_irq ? "interrupt" : sh4_exception_name(cs->exception_index));
         log_cpu_state(cs, 0);
     }
 
-- 
2.55.0


