Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA37F606A31B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=L159TJFg;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Cs4Q977l
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHx8-0001Up-Dv; Fri, 23 Oct 2026 12:17:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHx2-0001K6-4l
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:17:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHwz-0002U7-Oi
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:17:03 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE5xvx4072871
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:17:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ycC2gMtcG9Wzp1/amAgDkmEAcStuQd7OBl95GDUGwqY=; b=L159TJFgQODWpfyl
 OXRyGDT/Ppn+8C8QxXwk9AUejiQFGsLCCDVT68uvxXr+o9QUhBy6bNSOTSyi1JOL
 5JGpxWGzP/78DLKgOaQPocMF0l5OYyBPJi17pBowZO9FMKJQTMZ8l3K6DsRyMHo+
 zhsWYIml0Y4XoLSnYTpR7mthW0xAnQxp78H2Jrb/7lJ5Sr6xIgU9jVd+lbm2nZXi
 qFNiLXeeNFUaSgAle/uUNcelJbtlw9IlOjC2mWYdfqCR3ItniXh5mQib9GTbj2ij
 CMeBWBF5wYHIxH4eKIXEA5Vchwv4mILTDiLk5jeTypvl+l8ZggpImGbKnypWhMdW
 Da2Emw==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hg7bw0x5f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:17:00 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-9907539aff7so934765241.2
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772219; x=1793377019; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ycC2gMtcG9Wzp1/amAgDkmEAcStuQd7OBl95GDUGwqY=;
 b=Cs4Q977lG/AVfM1eKJMuACN9lMtz/IhS4/F85cvc8JXtXXkekQVZjE127SUi2akjQb
 y8xKfjjc9ZbJFDlzaHU7zV/Fn80YNYQe3NuBXvZfZdlo4HqJ9064SdqFURUoUUSft4gg
 Kv3GOrPySlrQCZAOC0NOFpJvqAeymvcUQ7pCWRgLPTuMm5TDhnzCqhEjvFCfzi0Ytrj8
 FzcRmgDbjQVaCqfvHVzJPlK7AEX3QTVsYJusTp3dfFSw7X0QWx/UkmKFDB5NJma1VdHB
 Gb5g5FwgXeJLiaCASHlGWIXYFmsP6S6WlSKVwu6zLyL1FmnaHVBYe2A5nZRyhXn4zA8y
 wlLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772219; x=1793377019;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ycC2gMtcG9Wzp1/amAgDkmEAcStuQd7OBl95GDUGwqY=;
 b=Rr7DCxV2zmqu0JRfkQTONlDX4SwVeMT21xQdG7msojuCQhmi8sJAbqu6LIyHhG8Obm
 QhgSVor05jd3UhDKH1K5s5/qhBmdtX5501/C78lrOaT51fjqo7hQnJIEW7ZFkh9eJ4jN
 pZkDHq1Krz+jFuI2WN2aFrX/UL7sVUnRhlx7iYrQjMvEmXyFiXIzbCSv0qNPK7TL3sGP
 uKgwurS8PPweg4i2aPkULhRoLLrK5BLTIZ3ad1/vz9PHj6o17jimjOdIMHCzAr9fhAiN
 6yzWeaYf9v3QfvAjYwbR0TD3TFStB5badwHO+OoQiiRY5RSkoogjpXdBaOCP1jOJla1w
 7AAA==
X-Gm-Message-State: AFq9FYKfXsj/CAyAwkzUeuWnW+A4pobQlUwQ1ehytWq5NZcp/O8Lx2/i
 9u95BMd4Tq1UmA6/RObdHUgCJbP70IDq27OfP9bzjdYIUq06iWiwF93h2nBso28Mvx8Mw68oNgT
 qrwFtUUCmGttfErzPVXoCItIIgrQ48/1Gp73rQsZwxsmR1aCKDFV/4OCzLDqD/cUveea9
X-Gm-Gg: AYBFou2v6O8sux3y9WRkfVX33v49CMcoE3+ZeMrWO+Fh7IoCw8NIdtpY/0URvVCLRza
 VUqeu2zmF4MQLk+gvWY/auMhnXGRzl8BRlu9lSCXpq4gH2BFMOqxCv1yLitZBATAQdEASfovIzO
 DG3eX0iGk7P7qhCFL1HtG1PvIOQv/aGw666DOBPjEEtN3imQisEIyycw9gDp6HJTL3QolmbmcCq
 AhGzN7TxU+4/7Owqphe/dQkwpKYRegR9vAMDdLGzY8zssWn3+1r6erRaDfioZHPqgBb+zd+act8
 hZ5+SHl37vUzDAyIXt7D4+pYZ/s4O0OMkP3Smd+q6rLO0fAyjy6JfIuMMzC0tLclvQuQwHH7AS6
 fIfQWkdCkDfdvAA9dY9sboSxUGqomUkb6INq4+Cek
X-Received: by 2002:a05:6102:3f0c:b0:7cc:115:ddf1 with SMTP id
 ada2fe7eead31-7ccc32f23bdmr1102438137.23.1792772219137; 
 Fri, 23 Oct 2026 09:16:59 -0700 (PDT)
X-Received: by 2002:a05:6102:3f0c:b0:7cc:115:ddf1 with SMTP id
 ada2fe7eead31-7ccc32f23bdmr1102429137.23.1792772218623; 
 Fri, 23 Oct 2026 09:16:58 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a2d6d13c7dsm12633435e9.4.2026.10.23.09.16.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:16:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 28/83] target/hexagon: Register CPUClass::exception_name()
 handler
Date: Fri, 23 Oct 2026 18:12:36 +0200
Message-ID: <20261023161332.60153-29-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: yCT_PGashC3YJmSoi6pdP-fjR5LJLVz-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfXwch3nYnYay8g
 eqLZsoUjGh2BPol8vaIjPlDD03BpFaN2H+4EHuLxb200u+IQ1ctTCFM4h7Lp9OR0g/MjsPgXYrv
 jKY+w5v6tmCtSSfc/wa10wTX/3/vGxo=
X-Authority-Analysis: v=2.4 cv=QdTzLcbv c=1 sm=1 tr=0 ts=6adb887c cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=gOtg6PG78Z4vFrgGvpEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-GUID: yCT_PGashC3YJmSoi6pdP-fjR5LJLVz-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX/KiAK3CBnLgC
 jrwhAkFpjiPoLQ9KunPWtFWpWXoaYG8UwGkQLsDFx4aNDGWwbtWVDvcoVwnFAr+zMbIWC8/Wui2
 iy7OpIivEPhYNW74tNUejU5HI1XlJygFX5yfcyKB/+CfWchzAge1BMH0dZoa3O5LoXQ0eMJs1/s
 XE77+pzw76aWy9ASXNzPEnaHSOLGNCz49SXFCD7YJKOIBg72ikBlx5zFnJ+IA2rv2FDujGUDhZA
 S0pzuPAs8a7CBnnk7/9Q0kZo6MpWShH8jgB0W3R768tcXI9ZDauweJyuHTy/BDLVzTIQZ2SBWsZ
 4OlDQxJlA7rijtC0jUljC41otCDw0ttF9/C6r2U0OrCNhR7wzSRRvH6UTaUW+vgSN2shLE7ONY5
 yX5ZRBFyFwM1eMuHc1xGF/IVH2ebM1a9HaKuw43o8cXBRu69Xl9mBWpnQTdU4oshTdFepkFGfU8
 0iOjmJoMcTQDhofJQJQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230063
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

Expose the hexagon event_name[] array via a hexagon_event_name()
helper and register it as the CPUClass::exception_name() handler,
so the common exception logging can resolve Hexagon exception
codes to names. Make the table 'const char * const' while moving
it.

With '-d int', hexagon_cpu_do_interrupt() used to index
event_name[] directly. Codes without an entry (table holes, or
values past its end) are now logged as "unknown", instead of
passing NULL to "%s" or reading past the array.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Message-ID: <20261022215115.19680-10-philmd@oss.qualcomm.com>
---
 target/hexagon/cpu_bits.h |  2 ++
 target/hexagon/cpu.c      | 35 +++++++++++++++++++++++++++++++++++
 target/hexagon/hexswi.c   | 30 +-----------------------------
 3 files changed, 38 insertions(+), 29 deletions(-)

diff --git a/target/hexagon/cpu_bits.h b/target/hexagon/cpu_bits.h
index a8fba4aa188..7d1bdfcbc71 100644
--- a/target/hexagon/cpu_bits.h
+++ b/target/hexagon/cpu_bits.h
@@ -61,6 +61,8 @@ enum hex_event {
     HEX_EVENT_INTF = 0x1f,
 };
 
+const char *hexagon_event_name(int event);
+
 enum hex_cause {
     HEX_CAUSE_NONE = -1,
     HEX_CAUSE_RESET = 0x000,
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 304031e97f0..8df63e43260 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -18,6 +18,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu/qemu-print.h"
+#include "qemu/cutils.h"
 #include "cpu.h"
 #include "internal.h"
 #include "exec/cputlb.h"
@@ -318,6 +319,39 @@ void hexagon_debug(CPUHexagonState *env)
     hexagon_dump(env, stdout, CPU_DUMP_FPU);
 }
 
+const char *hexagon_event_name(int event)
+{
+    static const char * const event_name[] = {
+        [HEX_EVENT_RESET] = "HEX_EVENT_RESET",
+        [HEX_EVENT_IMPRECISE] = "HEX_EVENT_IMPRECISE",
+        [HEX_EVENT_PRECISE] = "HEX_EVENT_PRECISE",
+        [HEX_EVENT_TLB_MISS_X] = "HEX_EVENT_TLB_MISS_X",
+        [HEX_EVENT_TLB_MISS_RW] = "HEX_EVENT_TLB_MISS_RW",
+        [HEX_EVENT_TRAP0] = "HEX_EVENT_TRAP0",
+        [HEX_EVENT_TRAP1] = "HEX_EVENT_TRAP1",
+        [HEX_EVENT_FPTRAP] = "HEX_EVENT_FPTRAP",
+        [HEX_EVENT_DEBUG] = "HEX_EVENT_DEBUG",
+        [HEX_EVENT_INT0] = "HEX_EVENT_INT0",
+        [HEX_EVENT_INT1] = "HEX_EVENT_INT1",
+        [HEX_EVENT_INT2] = "HEX_EVENT_INT2",
+        [HEX_EVENT_INT3] = "HEX_EVENT_INT3",
+        [HEX_EVENT_INT4] = "HEX_EVENT_INT4",
+        [HEX_EVENT_INT5] = "HEX_EVENT_INT5",
+        [HEX_EVENT_INT6] = "HEX_EVENT_INT6",
+        [HEX_EVENT_INT7] = "HEX_EVENT_INT7",
+        [HEX_EVENT_INT8] = "HEX_EVENT_INT8",
+        [HEX_EVENT_INT9] = "HEX_EVENT_INT9",
+        [HEX_EVENT_INTA] = "HEX_EVENT_INTA",
+        [HEX_EVENT_INTB] = "HEX_EVENT_INTB",
+        [HEX_EVENT_INTC] = "HEX_EVENT_INTC",
+        [HEX_EVENT_INTD] = "HEX_EVENT_INTD",
+        [HEX_EVENT_INTE] = "HEX_EVENT_INTE",
+        [HEX_EVENT_INTF] = "HEX_EVENT_INTF",
+    };
+
+    return STR_ARRAY_ELEM_OR_NULL(event_name, event) ?: "unknown";
+}
+
 static void hexagon_cpu_set_pc(CPUState *cs, vaddr value)
 {
     cpu_env(cs)->gpr[HEX_REG_PC] = value;
@@ -840,6 +874,7 @@ static void hexagon_cpu_class_init(ObjectClass *c, const void *data)
                                        &mcc->parent_phases);
 
     cc->class_by_name = hexagon_cpu_class_by_name;
+    cc->exception_name = hexagon_event_name;
     cc->dump_state = hexagon_dump_state;
     cc->set_pc = hexagon_cpu_set_pc;
     cc->get_pc = hexagon_cpu_get_pc;
diff --git a/target/hexagon/hexswi.c b/target/hexagon/hexswi.c
index e7362b56650..19439658392 100644
--- a/target/hexagon/hexswi.c
+++ b/target/hexagon/hexswi.c
@@ -735,34 +735,6 @@ static void set_addresses(CPUHexagonState *env, uint32_t pc_offset,
     env->gpr[HEX_REG_PC] = evb | (exception_index << 2);
 }
 
-static const char *event_name[] = {
-    [HEX_EVENT_RESET] = "HEX_EVENT_RESET",
-    [HEX_EVENT_IMPRECISE] = "HEX_EVENT_IMPRECISE",
-    [HEX_EVENT_PRECISE] = "HEX_EVENT_PRECISE",
-    [HEX_EVENT_TLB_MISS_X] = "HEX_EVENT_TLB_MISS_X",
-    [HEX_EVENT_TLB_MISS_RW] = "HEX_EVENT_TLB_MISS_RW",
-    [HEX_EVENT_TRAP0] = "HEX_EVENT_TRAP0",
-    [HEX_EVENT_TRAP1] = "HEX_EVENT_TRAP1",
-    [HEX_EVENT_FPTRAP] = "HEX_EVENT_FPTRAP",
-    [HEX_EVENT_DEBUG] = "HEX_EVENT_DEBUG",
-    [HEX_EVENT_INT0] = "HEX_EVENT_INT0",
-    [HEX_EVENT_INT1] = "HEX_EVENT_INT1",
-    [HEX_EVENT_INT2] = "HEX_EVENT_INT2",
-    [HEX_EVENT_INT3] = "HEX_EVENT_INT3",
-    [HEX_EVENT_INT4] = "HEX_EVENT_INT4",
-    [HEX_EVENT_INT5] = "HEX_EVENT_INT5",
-    [HEX_EVENT_INT6] = "HEX_EVENT_INT6",
-    [HEX_EVENT_INT7] = "HEX_EVENT_INT7",
-    [HEX_EVENT_INT8] = "HEX_EVENT_INT8",
-    [HEX_EVENT_INT9] = "HEX_EVENT_INT9",
-    [HEX_EVENT_INTA] = "HEX_EVENT_INTA",
-    [HEX_EVENT_INTB] = "HEX_EVENT_INTB",
-    [HEX_EVENT_INTC] = "HEX_EVENT_INTC",
-    [HEX_EVENT_INTD] = "HEX_EVENT_INTD",
-    [HEX_EVENT_INTE] = "HEX_EVENT_INTE",
-    [HEX_EVENT_INTF] = "HEX_EVENT_INTF"
-};
-
 void hexagon_cpu_do_interrupt(CPUState *cs)
 
 {
@@ -775,7 +747,7 @@ void hexagon_cpu_do_interrupt(CPUState *cs)
     qemu_log_mask(CPU_LOG_INT,
                   "\t%s: event 0x%02x:%s, cause 0x%" PRIx32 "(%" PRIu32 ")\n",
                   __func__, (unsigned)cs->exception_index,
-                  event_name[cs->exception_index], env->cause_code,
+                  hexagon_event_name(cs->exception_index), env->cause_code,
                   env->cause_code);
 
     env->llsc_addr = ~0;
-- 
2.55.0


