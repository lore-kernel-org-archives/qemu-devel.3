Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85C260A2630
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=A+5u5wx9;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=J7/goWMl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0iC-0006Sn-By; Thu, 22 Oct 2026 17:52:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0i3-0005zr-O5
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:52:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0i2-0007X7-29
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:52:27 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MHtPj7861303
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:52:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Tx9V+w0og07P5ZdJiIVdRZmcoXmlQE1OPylFrZhlQps=; b=A+5u5wx9u42K7SwX
 GsvfklSNj3564+zH1/cT+6291qdhQyEbyRYKAOawRdoZ1QvsLLBO6ToNPvkXvjrs
 H1niAyF02OAEEDVhPQb6xB/TsI/+bH5GQxasP8fiJ/bfQpCls0frl3GT+okwMvOR
 8YRIrlTtlcUbUxG31s4nFwKNn2NNxLhO9tNmy7W1IazkN3WcIKonqXTdu+1z3PJZ
 TYWv6oXBUhN9rjUqUSWj2gnhpANkzHEOhyliihOvyO4IT7v6pCCjQCPzbarry4LC
 gVDupTlXP6ef6e4OGoQSgTno5YzgVV7POS8/JQ1rjgE9XL1mtDg2wFn34ECYX8Fk
 g0xpWg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfnq0h9d8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:52:24 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f5844e383so49750385a.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792705944; x=1793310744; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Tx9V+w0og07P5ZdJiIVdRZmcoXmlQE1OPylFrZhlQps=;
 b=J7/goWMl3DDh2pVeK1QOtutPBGADxFdHaXjXS6CFunIRyQJKSezymibbPp7iBWrsBC
 GI0UNjD8PlFwIvYN8xOYVZsP6/66QQp9kV1a4zsDANcYsOCuGQ5OzHJoIEy28Aeyj3Ug
 iMcb5QxEH2PsgYkuzmPQWIMb0tz+L4rewA9E0dOjit1A3DDSiKTwjjPzqSnijY/VpEt6
 hJcY1RzrbxIsIy2Ke8B/IPWJH3/YjDR/htCRf22zgirkCptO+7SoMk4OyDKHbWASZbSp
 XNrLxA2vpyTpXOZXnIpmlxogHeqEYOaqUnaqOY3hGvIAe3yZBfyjVkr5vZvlUwfiQEW3
 2Ykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792705944; x=1793310744;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Tx9V+w0og07P5ZdJiIVdRZmcoXmlQE1OPylFrZhlQps=;
 b=ATB83GNxGA2V1c4AARNjJK0PgCWSQPszT+jHJMImf7M+cuZeBE59BJfrTcWyyZYCPV
 gLU4d0avaXkPY5R0FCG6/8jJvT3VbHV9sgxHTLjF3PDrnzIXlEZKHMIPi2BTs/YX/Ru0
 urYsOIc6NDanGdp6ZxYRlFzRuW63UDNOnA/dOQzXMyuK03moZIFtbesL93njjim6Zt6p
 yFv3B7vg6pESzUZr8eFXO3IzdYaZ7ZQlDd4NwivHUcys4Usxta/QyUQLMixQdgAcNjXH
 UVvRpZtUmG1m6QX8/9DYwn8gp8cMff8+P4f+mdf62FdPrpU4lSr/TuZabj7iyz+7Xeiv
 QDNw==
X-Gm-Message-State: AFq9FYJW06nQBh6imc+FgYaXMYZKklGRxX7Yq4tZ+QHIElWUTvYfKzk2
 LzHozU6h6UX1BL5dTW6Y7hr2tkjVUPajCorUy7O4/asjN1637YQ1i9PwO86pCJMz3Fl2bvurJYs
 9IAwduAlqNxaQrVFhgZSpPePEE7uDGApP6BbzXqusjJC8DaLha13nlN54v8ZfTyKLhQ==
X-Gm-Gg: AYBFou1CRL1i/98uWchd98QXdo8ISDRrM6VB0mYJv6ag/gkXOAiint6SCUl/fR+hWsE
 f3R17G5KnyqPmDFu93FK5qfo1gJ/a4pPvD63cHBT8P7ODxKVe6/Zfi1+zNs7qVn4JfI6GeM6zXk
 59yTQ1Hhiu5qIKjk85HntqUUdTh+hwfln9Gy1x8itBV/qVkPibOHuFWcnWdaPTAZ7MNyKRwRIqc
 7ObhlGClca2oRsq90Vb08X089jjvw7lT/gujvxOEHBvYrCxqFmeNhhmvafGJCg9KaUTPe4FWVwk
 gF7XIG/HL4CFi9retWc9WcaOdvGb7QsJzSPwDIyU932fNZbjQxGC285YRS+3V2837hq1QnfSL8s
 y5CU+HeRb+XNUuLJSppkmZzab+32sqdfTYrGKGdlV
X-Received: by 2002:a05:620a:3956:b0:93c:6f06:8f2 with SMTP id
 af79cd13be357-93f6f9934d8mr116158785a.48.1792705944209; 
 Thu, 22 Oct 2026 14:52:24 -0700 (PDT)
X-Received: by 2002:a05:620a:3956:b0:93c:6f06:8f2 with SMTP id
 af79cd13be357-93f6f9934d8mr116157085a.48.1792705943624; 
 Thu, 22 Oct 2026 14:52:23 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a211bda212sm9425105e9.12.2026.10.22.14.52.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Oct 2026 14:52:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v3 09/33] target/hexagon: Register CPUClass::exception_name()
 handler
Date: Thu, 22 Oct 2026 23:50:49 +0200
Message-ID: <20261022215115.19680-10-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022215115.19680-1-philmd@oss.qualcomm.com>
References: <20261022215115.19680-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: dR3ripJQEIKajBzFhwyYoHqg47lcvrPw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX0Wq/q+AXS3Uj
 urhrJ2utE2q6ao4H9IMJYHIPVbtBhyUorloyQeA9qqSUcOJ/QK0avGyxuangfL1W2991Qfj/EvD
 sdREwdb7vvcblLdpq0ibppEzu0S/Hq6Y1rP9XHqhxYzK8Ucr6/7QdYQxxUXyKnTv4XmMpdnuU13
 kMwXtRsexxGRXx6SWwWWWVWcVkcjneNWJclXMpRhUANgucpiLQyGVLjOKYOBlKuEQXkKRNbCbwQ
 vHTRwmCQ6mwwpFa0x5a0PzIjTF0YhykqmuZ5J6d2mdTP8V8ga3jOvG5D8rv4GyqjuvZrZFUtJ2X
 FqJfet2unpBJ0NbejlfgNlCngZH4AWyF4G1s8qMD3aaveKXW//+iMjnUYKha9VJJS8ZdEPILTJ1
 BLfdMVIFkrsaJLy2aqFP2Mv8j7Qt7aFEUGAa/XAj0fblTKTNOKfg9yDJx1whIiwrPoCkGyqoZ3O
 gFwmiDVw/n/tDC6DYJQ==
X-Proofpoint-GUID: dR3ripJQEIKajBzFhwyYoHqg47lcvrPw
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX9Qu2y+rU+MBe
 rmpx7b4nCkyrXOGDfNvudAZxoJ+DFP2gse3U04or314dK41avtyRHPm2iuGp75OlfS1r698Szsu
 7u6/jo7gzkN6ubxvE4J/cbYuQ8p3ibs=
X-Authority-Analysis: v=2.4 cv=UaHE26SN c=1 sm=1 tr=0 ts=6ada8598 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=gOtg6PG78Z4vFrgGvpEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 spamscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 adultscore=0
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
index f20d6de6f63..c7779e6b8dd 100644
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
@@ -841,6 +875,7 @@ static void hexagon_cpu_class_init(ObjectClass *c, const void *data)
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


