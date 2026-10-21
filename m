Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C610F606B54E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 03:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Vqa8IO10;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QzvybeWH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJMpy-0006kS-Aw; Tue, 20 Oct 2026 23:17:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJMoq-0004dV-QH
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 23:16:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJMom-0002vj-8q
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 23:16:47 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L2F2So2898058
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 03:16:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 I3wILwR/tNUL0fg3Ffio7HD+ewVrrBD4+JMHrwT71Xw=; b=Vqa8IO10MZLRu0lN
 V76WsPjMU/+nKAaFKZB23mDFrjNvFsp6qXiKeaJEBps501gJ+PAgbRQbMe6Fljgk
 tEKKEH9G9HI3cPMyL/cOo22nISJ2mjXzmF3VEPAfChXUO6QlE5Vrtz7O18SPzhT9
 jmCYCK8HRAfqVZZiO3M6r+Lz9HWovTJclUuQhFLVr9UwJESCWX3HhZR4pI2wBHz8
 uegyyS4XSzEX6DaMWzyhDPydroleXIlhdhMoLQfa1xRNpBDGhtew48RZp2D+48E+
 4xECIvfl3l+6Ri1++i86yfW14eungKEIkJ+UF/VyGUgPaSeHhglp7zjxsCiee5ha
 ZCDG0w==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heda0hqat-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 03:16:32 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-91b4bf686ceso11025486d6.3
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 20:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792552592; x=1793157392; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=I3wILwR/tNUL0fg3Ffio7HD+ewVrrBD4+JMHrwT71Xw=;
 b=QzvybeWH5cjAAP3OvDOHAsKJ3WRJ1brvYfKzA1JosHCkatplaCd65D/E91TslUAO1M
 a4BkaGqCErQ+Cbdz9zy/YQ2N5Q+8GFIt4ZOBxRkfEHl8mcZ2lfXYrayEe7gFIHXvSD7N
 4MpnY1Hw7bc91tvSDc6BT/xNVjEYZQunQJ1QbwO+tdSugM59Ugqhi5/N7B+cvEag1CdO
 tGXIHsdhjDzt51d24FObVBSTROWwqRnZE9octT1HjGPNQbktwWjp03v3eHc5eLAhemm5
 8k4637miGlA2HsD9if7BlxRMaaZDChiDZb+5hOGvSaolRVebk+G+IgCKuX/NxcDbYpcm
 rByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792552592; x=1793157392;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=I3wILwR/tNUL0fg3Ffio7HD+ewVrrBD4+JMHrwT71Xw=;
 b=dimpqqh/y7BY4NxNb6NH0xmZwOhDH+4bPzUq5HvlUCkIhU/iBYXyhFgMFIHaJdAxBQ
 2kSP784KsyQynU5tIn/+CYGsDwZrR9fn3MH4NhrPBxbnQR6+7tMKWLuTxl6BT0NX2Sxg
 krIaow/zay2BaNOvi7ZDsgtRyQlMTF2KZtQeHRg/DE918JBSYyqQW5rIfJDS+viUqJIm
 OB7nvqJ0PpekRPOlAdnWjPgnqN/arddg5L/B+5Ylgs8iuiIMtIAyt31XZ6ZgrdTWCFHf
 b4BxjzIgEGB7lEWhral3ccvHBWk3mgF1f5SdbQ8K8J5RJwlKCwAOotMBkHKAz0zKmYcP
 X9uQ==
X-Gm-Message-State: AFq9FYJ/A0GckoEnDb/pi5wIhPWjx4AbmHh3yJZ4R+fSBoYyEfB6d1Ma
 jP3mf1QZC21z+i5mltPeysPxY61xDev+UWOWoGRqL7yehsGGQ1O5oh7G+s4aSYWsGZCIVt9TRfh
 OmkC0PzYebGOIa6scoxm0BCdyioVX/Eb8BodMr0tNtg5qx0OBlklrmxUCa6rHOMfrN/rC
X-Gm-Gg: AYBFou31Hz+Daa6Ui9HwKjElA5NzRB6NY9AE4MSidhZfq4ey0HMoCFVsbGEwsGptnMZ
 1/ytr3e6K22mpcclwtB9ByVcUTBXsyLXHLcVZsEXb6J8zdWbUpaazG0JNLi32PQdHILkIQcMAIW
 ShLzaSnZ4K586KKoHY7YB1e15RiMWXRQx1F6xXdkXXeG8XBsOWvBMvTSq7QiwD58V9h4yfDJiyO
 Pmlu4/yBsGc+gGKdq221DdFzeiIq/+tXRjuMB0bVhGENjjOlhttsZ7OOO2FSXSfshtEzwdMp2zc
 xbAYXQCGEq6EauqYrRz7Ujqh/CjSRpSLn006zr55AB9iNRoFU6vS9ya0PFzlkGH0KpzXI9C2vl0
 IdPhkyDK1fwZhjWpigzvxsV3C8sivL3//Zc1tXMJv
X-Received: by 2002:a05:620a:178b:b0:93f:23ef:d6ad with SMTP id
 af79cd13be357-93f57d6fdbamr226925185a.0.1792552591795; 
 Tue, 20 Oct 2026 20:16:31 -0700 (PDT)
X-Received: by 2002:a05:620a:178b:b0:93f:23ef:d6ad with SMTP id
 af79cd13be357-93f57d6fdbamr226922785a.0.1792552591317; 
 Tue, 20 Oct 2026 20:16:31 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e254ef1bfsm2580046f8f.6.2026.10.20.20.16.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Oct 2026 20:16:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 18/33] target/or1k: Register CPUClass::exception_name()
 handler
Date: Wed, 21 Oct 2026 05:13:51 +0200
Message-ID: <20261021031407.24862-19-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261021031407.24862-1-philmd@oss.qualcomm.com>
References: <20261021031407.24862-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAxMiBTYWx0ZWRfX2/eOs5G0j36/
 WLwJDIX12w+56Q8J49m/oadRR4DGfcpUQysrokkFbuFPdhHeFTWCiUe8FpOpRFGVZuc314qnuvx
 /iTOlwCdQjLwyzcQ0gbygLzSq7b3bfywNTFOdRfTwc9Qcjq91gIRwi0dVijfDmXPL1nnL1t8mzZ
 L22dMpTai0nXIRzTdeXhg3Lyj0p7M7VPKJtzWkaFm/rr/V/6ss6IvokQ+8+zGrzeOt367UnI5VI
 eaB6DrDYzA6ULNISKL8xzXtehX/UvLRlshSPqqjeEL2CRfog91KyymQ8UKCng1joci6lAilAA0n
 vsbvpxgjesmhWcA8M71H1r6EIFtMsbDzXGtZJyXnqo6+VNSIIriI5mTnaIpTao0wNpeC2zwmt4H
 7b30rUbus1GQIaTJPTpOJOzTQuoxpubBG4FpLju+LvkFuG3vMOqWPQUJjhwn6TvMI8jtfUnbsjo
 MyLT8Mf2MiJ4jm+AkxQ==
X-Proofpoint-ORIG-GUID: 9m0118fefKQBb8MxN3Uy33Usp9wfvoGs
X-Proofpoint-GUID: 9m0118fefKQBb8MxN3Uy33Usp9wfvoGs
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAxMiBTYWx0ZWRfX2tlUhvOffirj
 k5OjM62BHygX4R6kGGFqgNs2Fco8kFLbHH+Iyxo95FFtzdz/w//mli6fCaSJcXR8z3VQk7aGWUb
 Gp6yH4StG9mO8agB8e5sOKGhFUj7p/k=
X-Authority-Analysis: v=2.4 cv=HL5WhYtv c=1 sm=1 tr=0 ts=6ad82e90 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=slxP8ohElPSaHwuvTCoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210012
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Factor openrisc_excp_name() out of openrisc_cpu_do_interrupt()
and register it as the CPUClass::exception_name() handler, so
the common exception logging can resolve OpenRISC exception
codes to names.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/or1k/cpu.h       |  2 ++
 target/or1k/cpu.c       |  1 +
 target/or1k/exception.c | 21 +++++++++++++++++++++
 target/or1k/interrupt.c | 19 +------------------
 4 files changed, 25 insertions(+), 18 deletions(-)

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
index 785181ef2ed..ca5e8a3134b 100644
--- a/target/or1k/exception.c
+++ b/target/or1k/exception.c
@@ -22,6 +22,27 @@
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
+    return ARRAY_ELEM_OR_NULL(excp_name, excp) ?: "unknown";
+}
+
 G_NORETURN void or1k_raise_exception(OpenRISCCPU *cpu, uint32_t excp)
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


