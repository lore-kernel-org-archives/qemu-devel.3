Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304AA606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Yz2OscAm;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EtDfNGXy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0jL-00020D-U5; Thu, 22 Oct 2026 17:53:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0jH-0001uo-Cn
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:53:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0jF-0007fA-7L
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:53:42 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MJXw0k1148809
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:53:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZKbldnWaAfreODRAJvRU+qjTDKTM/7mho5qnJonXCcU=; b=Yz2OscAmr9ihXGtl
 Zg/sqn3jClOMFUiClvRMLXMb29i8q4P9aW8JT///A0bw2/jYvMapVWJy3gChkMLW
 onBwxXMpzfKe8QX0lJt58k2WwLoqOprAu33KAy1bQkGc0lgt+R2Xrfo20LOOGj3/
 CknQfljiQSZYS4BNwqQX3oAMWJbyyEoKfncsIDbzWx1nnFNXNnSDkY68I44LIDXh
 0l1gSufOFXtaEMYJVmYMMxmLvMsZg4gTHoZXde/gz7gYrFDo2lj5NRqeA3Qfpi6P
 78cmAwMjJ8ORziqYi4l3Ab7nmZfKqK9VevSTACJYORADKEeME7HGJmj5UBYs3uoB
 lufGUg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmj8quu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:53:39 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93ce7a85f04so53199085a.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792706019; x=1793310819; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZKbldnWaAfreODRAJvRU+qjTDKTM/7mho5qnJonXCcU=;
 b=EtDfNGXy5cXQWtGJzRK0pWUSAHIi4eyfvWS4a5Lkf2XkJZ8AGs/+t9GQmpzor9jeMC
 DVm4DyAlwy+7/P2KY1GVxieXm3zd7TihdmtTGseAueB2ag5AGsegN1R+dZZwXD3gdbC1
 buiKizCZI6kq4MLRljAM6QlYv2a6CmynPTqpKWabqz/fZxUZDAZTNV633RxtZSRR3fUa
 NOCZFhde+VcTltIX79anwnV5o/NJy2qIIdPXCJcGx0wI/H5CW2T+jEZwtWykzE1695sG
 N1Mgqx2LxUiq1bc7EXydjNNJXtbBxf/Ur1KZ281j48uPLDepKPJ3ccZnFyCOIrMDZNIR
 dOEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792706019; x=1793310819;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZKbldnWaAfreODRAJvRU+qjTDKTM/7mho5qnJonXCcU=;
 b=EEX/BVk0FbBO4LC8TUvbAix6rKhmOQDnLkYYPVp3jGiYBW2L6muT85RoT5A1/25liS
 NDNBU9x3twOclwwYLF+RYUESHJP9sSze+i8qDi6Ol1pKk1tITBu/kF0jse4gk3lya+TR
 SldHeMkLQnLwEdrlAddv5jF06cMP04OMgevPFSecRawCACCxnoV0DDrN36E82iXfHohW
 oo19Jp/iasX11SgRtT9h/sA7LgOIQhiISW3X0zS0MH5Cf7ejvZGBpVJGGdCzip8nCw/3
 UmtHT+AL/oqriejvz+AJIXPavVxGXjxcW4yeQJUVoinigkJYGLC+QXWBDQdBG3c+UIDE
 macg==
X-Gm-Message-State: AFq9FYKjC0aQMejJuSLYuoLKBn94YnAY12vyEXOHxr8Ng8G4sO09aoDg
 aKOSJsDGwxH2FXPeIHo/PaoqB2Q7lCwLUrlCbyZBrSGZSnzfeqLk1s3wf1Afr34bTullo0QAh8s
 DYPOCvOfAypedowOdTrF7a6/Gex3GkZ7+lT12aHeIkZ99uAIaU1y1QD/tsvKbwr0jjw==
X-Gm-Gg: AYBFou12Fc6QveMeOgV8xw5sOCUkHRRBt8Ra/ZDkyGD+M8J+yYt4IFFM5VWUZ+0FKVw
 COsMje7dbu0DqLmCJNu45ywLaVyUeQDCTZS6HHg4XnwpqyGqjO+cREMdtTAN2ZIy/lJOKl+nr4t
 EUmcgYBQUSkXMAdWDgbVSlmrqJqmvC2bS19d0NIqNpurPCVG0oYx2z8HdBrBalzwEvj3nt91Din
 NLFSgiwnk2WfT5Y6VM/RYjtQIvRucMuDyuq3zJLiFwsfZRSHfyVBzRfhTC2cFIo01hS/vgHYTo+
 WkP4nQCHh/zYg0inPRgM1G+K14+0HPZ/ijA84bdwqK4TORBEgiwCeJo7+gZ4KKfVuNbezsBJTz8
 xwXC7p41Yo7LjPQfWptOhbgYd5/5dUH5BMlEhe+li
X-Received: by 2002:a05:620a:a888:10b0:93e:b0c3:388d with SMTP id
 af79cd13be357-93f6f54c958mr104505485a.11.1792706019127; 
 Thu, 22 Oct 2026 14:53:39 -0700 (PDT)
X-Received: by 2002:a05:620a:a888:10b0:93e:b0c3:388d with SMTP id
 af79cd13be357-93f6f54c958mr104503885a.11.1792706018461; 
 Thu, 22 Oct 2026 14:53:38 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e380310b3sm716179f8f.22.2026.10.22.14.53.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Oct 2026 14:53:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Stafford Horne <shorne@gmail.com>
Subject: [PATCH v3 19/33] target/or1k: Register CPUClass::exception_name()
 handler
Date: Thu, 22 Oct 2026 23:50:59 +0200
Message-ID: <20261022215115.19680-20-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022215115.19680-1-philmd@oss.qualcomm.com>
References: <20261022215115.19680-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: re6sWZd2Ab0jl4v-Qy-acJ2p19-Qi5RS
X-Authority-Analysis: v=2.4 cv=cPR1IVeN c=1 sm=1 tr=0 ts=6ada85e4 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=slxP8ohElPSaHwuvTCoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX1zNOcBkRGMsq
 WsZ8H915iGzGbFaMQoQb/DzRkDFTkIuIQ47+DSCCeNGvVFq+sc+RV92jV1LExLFnuk1KLSchcZ4
 SkNeZkDf+4K6VEFz5lMXI34mRkrhmgM=
X-Proofpoint-ORIG-GUID: re6sWZd2Ab0jl4v-Qy-acJ2p19-Qi5RS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfXx55sj/HLejt7
 ZVKJM4col6K/4tkO3Jlo2xvKnpVNYA0ZvEAYBZBLBJ7x80NvolGmeXZN1T4wP3tlTfI6rFCGxj3
 ZiLL0pv8WUVU2e3YN4DZkg9tRDF+Uhs+hPr6ShRQEAOzfXqCgXT9g7PqCvqBZdRCYIZFdii4THI
 p5oW76hUGQL3AuROae6b6eD4LXGVmJBoptZCSi3muBT9vzVPoPSWNun46d+EMV+dM8xw+97FSCd
 hy5rbTsHkW4fj6zM0thzXHq+vpFSRQDTHurADvcOJ6onQIXhsWD4x8ZlA1bBZO11BCQoCimnnM8
 UFIdLIR2zV5KTZCJvcxbHMDFRf8HAHMgUVr1fQOVgm1o48lYv/N3aVdCKySd//GRUrkZOyUBNz9
 tL15kkgz68KAVrPZYX3dJNaAxDBywPju2eanLBc45gBQxapaj+hYI+GQYuefSekSLhj+SUcMRSW
 Y5dhunjydoKOzzy3qLQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220087
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

Factor openrisc_excp_name() out of openrisc_cpu_do_interrupt()
and register it as the CPUClass::exception_name() handler, so
the common exception logging can resolve OpenRISC exception
codes to names.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/or1k/cpu.h       |  2 ++
 target/or1k/cpu.c       |  1 +
 target/or1k/exception.c | 22 ++++++++++++++++++++++
 target/or1k/interrupt.c | 19 +------------------
 4 files changed, 26 insertions(+), 18 deletions(-)

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
index 785181ef2ed..55c539a86db 100644
--- a/target/or1k/exception.c
+++ b/target/or1k/exception.c
@@ -18,10 +18,32 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include "accel/tcg/cpu-loop.h"
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
+    return STR_ARRAY_ELEM_OR_NULL(excp_name, excp) ?: "unknown";
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


