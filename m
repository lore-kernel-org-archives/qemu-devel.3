Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708E0606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=liSizy1u;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=A/CN1n03
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHzf-0007hw-AR; Fri, 23 Oct 2026 12:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHzK-0007Lb-BD
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:19:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHzI-0002fQ-CY
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:19:26 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE6NKR3000254
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:19:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Q+Jn4P90k5BkoWw7BkBHvfklqyTI+AfT7svvmOsAV4E=; b=liSizy1u9vOsLh0+
 0uPUIeDlh7oMcaaOSQu/wp5BYzcYkAHGrWwj9xbNkxsxaBAhPsNZe/XwHMTwBrjX
 gPN+9zCvOI4WpYnCMlI79+vqpZSImO4Vuyxm8Z+z6jyzd2hVpKqRmfNmcwsR6zI3
 klRyEwCJ4TZNJbKo2FFUoH8sH1ls++J6Gg0m1ed9jHFMxjBe4UGTXBnUTv8o9NEz
 YnGZ0wRQwKqOpyt1uEUtu4Ejhm5Ro4q9m5SFVdbwV5ubVh80wmQMQ/HzQ+fXVDWD
 TlXcTdjd+eXhKFsUBUvVFDIIqAJSqYfxAD6Eq2OmnMTEDBax62x6fBszzPio0r0t
 /w3Vog==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hg7cn0w6g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:19:23 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93dd3c3badbso266069785a.2
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772363; x=1793377163; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q+Jn4P90k5BkoWw7BkBHvfklqyTI+AfT7svvmOsAV4E=;
 b=A/CN1n03Gauk0rHHYkjw9qTYzvQod4vI4MLnC0obOGzlYVb7z6EHphdl93yFcBDR0n
 8BsHSlP+i79dl/jjfT6778mZkrymzNEBa7R/Wi2JDcSGRLO38djsmUJkEV90mK5HRxei
 gZ3o/CytbdE4ldl1BLUhygVGBHHKa1rh7qbr9Xd2LmUEbFM+VO2WySqeuV0rLsp4CpSW
 lqCJQz8Uk/DEAoSmgGmuR9DoRc1H2yt6ouV9s7IjGyT1R3vg0B9zGNQl2Qp+EGUOuCl4
 k8TgY5QdVFGGVP/6zDGaLAfBYRsKUZFchL3xy1/PUH9pQ8FpYSturGsEDLwP4zlgkGLY
 n6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772363; x=1793377163;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Q+Jn4P90k5BkoWw7BkBHvfklqyTI+AfT7svvmOsAV4E=;
 b=sAdumbItmBRXWbZ8Mk2hV3DrFseKd3bW3henc91ntzBSSbuXyqmc2oKE/1fpbr/9tH
 n4SYY/oHI41gAWVM7oZiIaXn7yXvhG7rzVgwSXlrd9lX1MvwE8jb6M4OBXZrVyYyReCR
 Hp9zEgrz7003r30qRnt8gWE/8ggTAgWCd86weAxdcvZVqeTXy7kKPnZ76KOmTFfJdfHU
 fUCIBJaykUDodVztZ2sker0FiIWUyTQhMIJG7TYv8w8o5bwtdsfbYZKvywolLfnUlLOU
 OU5Di2aTE41zAelkVZ6yil1HtWFT/KGGqoMRCGnI6DNfqyHRy8vK8ZxorveZenBrao1E
 bDrA==
X-Gm-Message-State: AFq9FYL/wkkScCV3Pgir6D3zt0ZZOLuz8toQijZaScvkofOpGvj7kDeP
 GmAiPjtsECJQAkMGvU1LHvZWjP2H1c3ecu840TFEQ7xvJYBhygR4/+lRvuFBOyPs5CAy3Eu+YoU
 7TUrHXIAL24lZ+4M+ziDR/CWnoqXxBDeyU31SngSIy+E9KX513dhZ94hBorShnONfffEN
X-Gm-Gg: AYBFou2z8m8sEt7CMGg6lN5Jv+kzfX7GMbOX6nHvmMm9YzbzRlBScxpoZP49TdY2vAE
 PXwE1+Kz5bV5D4I/XssksOHcc+L1DVP7Q4a69U/tN2su8mvZanDFGvoeub7nvgCTONbroUjT2vJ
 la2kVUGZ8z4gxB1PU7wJoxJc5JH+NPNDCm2nPMzEhwA8EBoioOLKQvZjeQNYg9yC5293clYCQVY
 CMhWBaECfyuF4HrhB/Si7UZIPMusDDqBtCqgWK46vrCjwiYfDiD7n/Jvy2Jqh+IwX6z+tHXIv4D
 vSFo6cbswRN/8K9IntpXHuih0RCbL9oRayfZW6qUixfDvh3gvF+sX+MXby0+8IVP7Re4uZsl9WH
 CZ3JWkMO/ewCOv33bYC0iO2Pf5BLtw9l3H1vm19BH
X-Received: by 2002:a05:620a:4725:b0:93f:2b23:4824 with SMTP id
 af79cd13be357-93f6f7c4217mr506823285a.34.1792772362471; 
 Fri, 23 Oct 2026 09:19:22 -0700 (PDT)
X-Received: by 2002:a05:620a:4725:b0:93f:2b23:4824 with SMTP id
 af79cd13be357-93f6f7c4217mr506818985a.34.1792772361859; 
 Fri, 23 Oct 2026 09:19:21 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d37c677sm779257f8f.3.2026.10.23.09.19.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:19:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 48/83] target/sh4: Register CPUClass::exception_name() handler
Date: Fri, 23 Oct 2026 18:12:56 +0200
Message-ID: <20261023161332.60153-49-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX2woSqQ0PcEZM
 aV3iqGd6xq6LE8cUVAhHEVWmHOcFIzd7ZeoRfPgsY+iI52DHAm0qbxhOcb0Xl/RjDPYBdECA5th
 3LrHDV5X4tL38Yxdt8A2OiwXZMwd+KulhEBa4GaCju4SYo+G1/LkWFsWDBTMMkrLaJlGw202Cid
 63Yxp50/mTYr/okOOuK1eKWqo/ER+79rGBiL8crw9AjpH64vkmPUAe0XL9R5PZBCYIjyjxgILKq
 Bs7MySPnNubH+Iw8aG5QhigIo5qMLo5xPGGtFQ+8k6cSntMrfga8jJWNbeknE0O63U2mQyAjoFj
 777+I5dwT43FJW5zE14vmn24/+F/sRf0EsqLe+OCQdbzUHgRZmR9YKiWRmplEN4CodL7lokm4Au
 Kjh7jnw7hhEx18A8yLbctk5k9ZOfBXvGp1M8BzSfMGIRbrdERo//u1RlNX3UtWQ0qP05UBJha9M
 xK4o/vIUDNW1vM1vM4w==
X-Proofpoint-GUID: yz0KHonJ-f0o9RGZAmiP98s8EoYSqb8J
X-Authority-Analysis: v=2.4 cv=a9mlZkSF c=1 sm=1 tr=0 ts=6adb890b cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=1bLhyRm5UWLPkFMrcSkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: yz0KHonJ-f0o9RGZAmiP98s8EoYSqb8J
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX0lOM1i8EYawy
 8pQyzICR5w/JdbXYd3OwZtMOBdwji9ZTDDEOUcjy0KcBcOPgSQqbh3JCWfge9F7Az/w/YFxbrmF
 hJZcwqCnKQ1aflY8ieyS7sl91JouDDo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230063
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
Message-ID: <20261022215115.19680-30-philmd@oss.qualcomm.com>
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
index 55c73a1da35..17731935779 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -333,6 +333,7 @@ static void superh_cpu_class_init(ObjectClass *oc, const void *data)
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


