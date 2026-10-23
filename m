Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EE4606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=psUdwn9J;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ojch1K3z
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHys-0005ow-Fh; Fri, 23 Oct 2026 12:18:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHyD-00051D-CS
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:18:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHyB-0002ab-6P
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:18:17 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE6Cbl2462547
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:18:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gf3nV51IHCES/sR28++evayAqXGfMFfu3J0g9pt+Hq4=; b=psUdwn9J6sgIT+qe
 EOWP8jbn2oUd7JKIBuLIOzZG6SnjOvxTc7YX6hOMKTYu6TvTXQqQhpuV+ar90jZC
 cA21678vP5/hwW0ndBy0Yp0+S8LwiS4iVg0c0fKnoRJ8jaArr5MTI/1kJHv8W6U4
 S/15uuc8bzCPfrHlt92PKW2R+Bou4hJCxxrr9lsDJRy3MkAPdpgUiuCwa1D3H8g8
 Ifr6AmVro45vrZaOpGp2PdYpVfXYPK3LySrmXhpXb7dS8t1a5m4Z15kTZUIlVIe9
 xJsJdD6wveUEqyl8/ztBxQ02UTCWdmJ4dRSkN0KzhgrTLZC/9Kb7Pkt37MOv1giT
 ra7X1A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmtvjcf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:18:11 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f20addba1so202067885a.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772290; x=1793377090; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gf3nV51IHCES/sR28++evayAqXGfMFfu3J0g9pt+Hq4=;
 b=Ojch1K3zcf2Lg9vWAyEj0zuK1l3GYlhbhn4MZtx0j1SGtJmXNUDKlvHcVIDM9pCRhi
 t9ovrUO0pVX8L2Ot0+UJtpWD2LTuVhZ3kLg30+aR9at0hsOVGOIc5kGs6scs2RrzN41m
 4ghXRLLO5qTUXPjc4u3RWjJ2BMIxNWGiA64TWXN8AgpLwezzsbhp1Ny8aI4vejVSFAFl
 wSZgL1Uiop135o4DoMy26ACv6O+udz3OUkUOBtk4bzStP2Ry8fg7aGRPE4Jw3PdPXBYc
 KKermF2//6LDEvoQ4JTOpI4uRlhUpVZTWU7wr5ElyqZad7nmQ/llmGWiOXK8XRneg8/v
 UfGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772290; x=1793377090;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gf3nV51IHCES/sR28++evayAqXGfMFfu3J0g9pt+Hq4=;
 b=OgllAR+GH6ioyz4F2CFVEc3DJ6ZF861FvseRqnJqHfJQehIdVXVPSN51X6dFqx5lSh
 iKoBcKSxFig+zDdjnsjBQLAu0J4c+g1PlWngEZ+Pfhtayq4Eph4FFeiVY2vqN3sNYCkw
 H7ij1LuhgQJZ2U8+viQN9cBeRtT8SIEUaBDzekOZV7h7Q8EuwP0tQLVHNUGiUXGUeYd1
 bM2zds+MgKuSFtieNrtsz4WBLP86idhnoJIm1OPYpEkiP6MAFxM7cpqNmh7Xi3jsnmqv
 kEmGOeKMWaSALwEVvG4N8QP9K1jF5egSWcECvVcDDZz4q/upQ3YxHy7ggVDcQRNv/De+
 cYqw==
X-Gm-Message-State: AFq9FYLw69rZuVPGDUFYom5CgDyr8GENY40Np1XFSvgrWVIu61K0ag/y
 fZtw53ckm9WCsJAYsMhfM7X0QPXW26OI3kKFqf+z1Xg0biba342bRp8jrB+LmSg/Elj4Xn3cyD0
 PgDZ+hlnpaqC/lilW2NOB7NWjWe73WdehPvXRkBgCI8/O5QFDow/FfgF8irM6pVI2jVm0
X-Gm-Gg: AYBFou2vTHXATnd867anabLKSYkVweNP0bbKkiPvCX707H8kSdCfKOXGoAcUhAv61B0
 Wut8WZduZeyTRAiJH0cdX+r83E4dy8x9dqeUTyd1GO7uKjJ4RTRRR+o9uTplUNSNMiTRNnG9YiK
 aHP3FlPpnYwyYAEyRcw2NMuxBbkzALGYE2eQ7Qjn3VVJvBYOawjKXAqivBH5H89hi1Pao4CGAwZ
 LU9bMUD+pngabuTfbPqB5r151vVXDUDMxqBlRZJc+Yi4lpQBnOAnqi3AELQteXVGf04+5Wdb1BP
 jCnIWKKk2xdXLaI160JY5Or6pj7GoKjthPhDkVIOP79oXMRsjDvEgBI2eWjoPSs344SIlzUmRBO
 cAyXCklPENtT9Tamnn4JrNCk9WW/h1rrWr1zKaMhN
X-Received: by 2002:a05:620a:8002:b0:914:afc1:c66d with SMTP id
 af79cd13be357-93f6f5a3254mr466674185a.11.1792772290337; 
 Fri, 23 Oct 2026 09:18:10 -0700 (PDT)
X-Received: by 2002:a05:620a:8002:b0:914:afc1:c66d with SMTP id
 af79cd13be357-93f6f5a3254mr466670085a.11.1792772289867; 
 Fri, 23 Oct 2026 09:18:09 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d40e830sm783034f8f.35.2026.10.23.09.18.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:18:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 38/83] target/or1k: Register CPUClass::exception_name() handler
Date: Fri, 23 Oct 2026 18:12:46 +0200
Message-ID: <20261023161332.60153-39-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Gt3XaU1C c=1 sm=1 tr=0 ts=6adb88c3 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=slxP8ohElPSaHwuvTCoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: n9Z7Zhuvu4RevaRWOe3rJIfcf0EnJ1Ff
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX0c2P/k4IEgMB
 HYyyriNt/wl6QIIt9Hpk5Z2UYz4/vGJtIKQCrSL5W794G/90juzmYATtRPveSngDyDxqIqYmLIO
 y6yt1R0EVX1zQ/a6iLL7omK2jflVZvUTtPvaRvyhrQ4YwBdxOupxBKVHTCPwVOpCk5bJtIBxkVe
 zoncckGFj1MQZNBq0WBnTKwuUDDdUDzV3xG1DNGgP+18DEMbCkNhEm/DX335XBFCm5T56vWrd2E
 LlSI0chbHCsnkEvPqypNbp/vjWkj1iSPjq+GKstQAwy2oR5lzYEZ8L4RlN5VVLVKDdjw6m5125B
 gEd3BqZd5OsjlVijY2PunAbbIviXFmaJy6e6inMEiXIQRSlJnYR4gqNmkLCbxiVEvFdpgjd2klD
 7HMq7NP/1hYL5dYZ0Xmq88apLzocI+z777NlzHsuO4aRz6V9JoK9w41n8xQngXpCeDH/Ka7ppCg
 t9ZXmaXAVcw56yJfsfA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX1P514v3cV+p9
 X0R34LFaZwdXefsxXPDxJzJxk4M8H6kF8lnHfI4wRqxPzOmFOL51f3dhBe3FQDf8nZX8UjvZb9J
 2cwIJ387Z8o77GVhELxrjgFKdkIJV2k=
X-Proofpoint-ORIG-GUID: n9Z7Zhuvu4RevaRWOe3rJIfcf0EnJ1Ff
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230063
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
Message-ID: <20261022215115.19680-20-philmd@oss.qualcomm.com>
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
index 42d9351b6d7..5aba8a42a95 100644
--- a/target/or1k/cpu.c
+++ b/target/or1k/cpu.c
@@ -284,6 +284,7 @@ static void openrisc_cpu_class_init(ObjectClass *oc, const void *data)
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


