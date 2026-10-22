Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA19A606A31B
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AVVq8f2A;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MXhXxlgm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0k9-0004FQ-Po; Thu, 22 Oct 2026 17:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0k7-00046U-36
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:54:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0k5-0007mZ-9L
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:54:34 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MIHeAs1495663
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:54:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 V0/VeE8BYAg+/5Y8HZhqr2s4fjW9TWzHZFXGzYefJDc=; b=AVVq8f2Awv9z7nTR
 K+i6lEl3Xjol27RUcqbmJ7tzCbe2X9zBKM4rJIfnK9v0teRdzmlQDuLGo+5PmEN7
 lQ5n+R1R4nJNM4hkpLzEhJpzn3p4EcZxSr80HjWLZOPveudL5HYvAGGmpk9aASHA
 qQEIwu/TdU6/BPtLmhEpOKz8ldIToyATx0TfAHnpzBIUt2J/RiRH7/NTQfHkkisY
 0WnSoFB0S7u4ACrTJ8Xb0ktQQi38EaDnVsqRQn5UZa/p0Ea353Trk4qNuhH6JK+i
 7aQ12FlGXBjcD2xBl1zBk1dZbwZ0DjsYo5hhV3fiR4Ynwt1JVwfeIEeVOfzYaw4m
 8nosxw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmr8ppf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:54:31 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-934963b2bc0so48557485a.3
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792706071; x=1793310871; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=V0/VeE8BYAg+/5Y8HZhqr2s4fjW9TWzHZFXGzYefJDc=;
 b=MXhXxlgmh4mMXKSv6WuJKxZYDsjmeq+lxN6WMm00fhNyn/RBMPs2CUDZ0itJGrEkC7
 k/wOoqPwIJ3WsxWK6+T+LumOMpjZT7SPxuNYIUtSIS1vx0k046JLAg5ujFwI79ZlUiD/
 /JKo5RyFw4wy1GUBlbCClBvzIWFVwAS8hVf/LvRcaGw/aphaSaD+mpXPZHScHEkGUUY9
 LSB72S0zLQSSDdhtun5OUbDR+jBaDbkcI7+qTfzsKAkpZmc9YW6e/Rr3pb2mXytTyF6f
 mAgFsk8lTCoYjjkU14E66EjAtiRYNg/SF9gqWlo9uG8PQb1rSLu1OTjEVpjMZKwhK0sj
 N1Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792706071; x=1793310871;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=V0/VeE8BYAg+/5Y8HZhqr2s4fjW9TWzHZFXGzYefJDc=;
 b=VpCicLBKBBMl8hPEwj3SP0rCXjrTQz4m+UzhRBL541TdSK20VNvQwxvb14MwL97LvY
 v0StaOzqIlV2mcuThuKs0Q5qG7iaHY58FuhyljjWwohGC/w4m/FGPoiiIFBwGINOdp+M
 /gASqL3A1QXhbiedOqt/9v7+gsaXWNAopC/yuoqo2ANQiYIt+dDCDwBmKtBgdPhksuWB
 PgymCvDwfVKAExOVU0GHjRxoEXXsSS2h/rZMW9EINUYydnQNve++W3H74OlUxtruLx/9
 m8RVMjRzC2TwwUOLh/5jRNbt0EBDfAUIh4LEbo0IqPSm4JuD3vY2h/AS3kSauU/CkaJU
 EJyw==
X-Gm-Message-State: AFq9FYKQIWFD0pNH0ECEawhE/lZIPLdSNjenM/J/rTQPF5r/nSpqZdiQ
 DdwkZm4jR5ACv5zRtDIjxDIiNz4DpdELVSYKLfuxzyjOWdmMvyluIuSt+6UCgppM3PwcPWRYr8l
 QNQ6H+zWgmSybTEkwkqmOyqGU+CIeolJuF3u+rkWcIIeZGT8XgYnqAhacPk7CLNuUvQ==
X-Gm-Gg: AYBFou0pJwKpKr9BjHfKLXbelr9qb8+zWhwyTarafD6KgqMmJrP9QUuxfFKHk4bZcKs
 XZJjfdgXcr/FjClui49bZ+x049g8E2LpVobJ74vIcYlryNCwgmUOAvtKD2y6OcA0UkiGVukxpmt
 ddifNNJeIzfCw6TUXG6HrfYCAr8tTSKVU0HJqa7f7JLLXG6wa6aMjRy1DNvKrx8i4vk9ZW870pv
 GN9Tr/pypswtbQridHlttwpf+oSI9OqNkorn3K7lIk69wJB8xGuaFOd/liyhra6r7rqsbTXZZJz
 LJ3MRwaX87NltwWXYA3LeLI0kLoukl+0mao3mdba3aF72cwaxRBCMeJ9ZQe5nXhkee/rosEVSSK
 swNUfY8/8akVTcd08NRwvqm1QD4dfiltFCNHxx5GE
X-Received: by 2002:a05:620a:44d3:b0:93e:c12c:4402 with SMTP id
 af79cd13be357-93f6f8a71c9mr134455785a.79.1792706070733; 
 Thu, 22 Oct 2026 14:54:30 -0700 (PDT)
X-Received: by 2002:a05:620a:44d3:b0:93e:c12c:4402 with SMTP id
 af79cd13be357-93f6f8a71c9mr134452585a.79.1792706070331; 
 Thu, 22 Oct 2026 14:54:30 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a21034d740sm27901025e9.4.2026.10.22.14.54.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Oct 2026 14:54:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>
Subject: [PATCH v3 26/33] target/rx: Register CPUClass::exception_name()
 handler
Date: Thu, 22 Oct 2026 23:51:06 +0200
Message-ID: <20261022215115.19680-27-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022215115.19680-1-philmd@oss.qualcomm.com>
References: <20261022215115.19680-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 1eVfNd63DQcrRakM6n0F981_BgF2n4vD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX8ranIwsLYZvS
 TxxQkzZDoLfIJQQuOhE2Thiku7gVcMenNRPulvt4yDB/43kwdYDOgwjul2rb80w7vcG6PNyuL8T
 AGP92t+ZmcdU0DZbxwhZ820TlpBFoko=
X-Authority-Analysis: v=2.4 cv=VNZIDNPX c=1 sm=1 tr=0 ts=6ada8617 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=7bFQwIbWrMmj_3m7X6gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX3a3GVWgd4Id8
 7C1t4HwOuLmCOvWWLRsNC0MxJKqTcnmHL9nF+zbj7g+oVzrTNytbcDN3fHuBGavRWEReB8b0DQ9
 sV+D+Cr2Q9VSkJhq0hkc1/NW2n2ZOJ7MSeN4ATiP9VXHEBxYFa6OR7pF38Exg158GRvDcvrNtmJ
 da64ydcsuXp4vpcLOwW/itlWvEJssusuehaqnjwYtVCkOPJwyXRRxxCMXNe30PJ5c47UA9Etk/s
 XPNmq7jEAOTd5+/dvWNPTCEliJWpN2CjKKnzcUT5xBbY+tkvb7HVZZ/u4qmhJMV/s9Wt57m218g
 7k3KBTWB0W1JGAcnEri8jnip8s8FPOw075FT7B8uoCqbJqKhJ9A6xcYUkZd1QebqF8YelDPEzss
 RILHQZaJRTqYbcX7pKUoUwf1iAkhQSll6L5lRuUTcjUhgj+ojk/QahOb7nnNL6Z/aS1m0OROuDK
 BxJOLWfgxtytQYw1p2A==
X-Proofpoint-ORIG-GUID: 1eVfNd63DQcrRakM6n0F981_BgF2n4vD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220087
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

Factor rx_exception_name() out of rx_cpu_do_interrupt()
and register it as the CPUClass::exception_name() handler,
so the common exception logging can resolve RX exception
codes to names.

With '-d int', unlisted codes are now logged as "unknown"
instead of "unknown exception".

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/rx/cpu.h    |  1 +
 target/rx/cpu.c    |  1 +
 target/rx/helper.c | 53 ++++++++++++++++++++++++++++------------------
 3 files changed, 34 insertions(+), 21 deletions(-)

diff --git a/target/rx/cpu.h b/target/rx/cpu.h
index 0d9f4898a26..06208380621 100644
--- a/target/rx/cpu.h
+++ b/target/rx/cpu.h
@@ -147,6 +147,7 @@ struct RXCPUClass {
 #define CPU_RESOLVING_TYPE TYPE_RX_CPU
 
 const char *rx_crname(uint8_t cr);
+const char *rx_exception_name(int excp);
 void rx_cpu_do_interrupt(CPUState *cpu);
 bool rx_cpu_exec_interrupt(CPUState *cpu, int int_req);
 hwaddr rx_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 9b8473d71cf..bcaf6659ac5 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -245,6 +245,7 @@ static void rx_cpu_class_init(ObjectClass *klass, const void *data)
                                        &rcc->parent_phases);
 
     cc->class_by_name = rx_cpu_class_by_name;
+    cc->exception_name = rx_exception_name;
     cc->dump_state = rx_cpu_dump_state;
     cc->set_pc = rx_cpu_set_pc;
     cc->get_pc = rx_cpu_get_pc;
diff --git a/target/rx/helper.c b/target/rx/helper.c
index bc76dd28ab3..ed9cadc0bd4 100644
--- a/target/rx/helper.c
+++ b/target/rx/helper.c
@@ -24,6 +24,37 @@
 #include "hw/core/irq.h"
 #include "qemu/plugin.h"
 
+const char *rx_exception_name(int excp)
+{
+    const char *name;
+
+    switch (excp) {
+    case RX_EXCP_PRIVILEGE_VIOLATION:
+        name = "privilege violation";
+        break;
+    case RX_EXCP_ACCESS:
+        name = "access exception";
+        break;
+    case RX_EXCP_ILLEGAL_INSTRUCTION:
+        name = "illegal instruction";
+        break;
+    case RX_EXCP_FPU:
+        name = "fpu exception";
+        break;
+    case RX_EXCP_NMI:
+        name = "non-maskable interrupt";
+        break;
+    case RX_EXCP_TRAP_BASE ... RX_EXCP_TRAP_BASE + RX_EXCP_TRAP_COUNT - 1:
+        name = "unconditional trap";
+        break;
+    default:
+        name = "unknown";
+        break;
+    }
+
+    return name;
+}
+
 void rx_cpu_unpack_psw(CPURXState *env, uint32_t psw, int rte)
 {
     if (env->psw_pm == 0) {
@@ -79,7 +110,6 @@ void rx_cpu_do_interrupt(CPUState *cs)
         qemu_log_mask(CPU_LOG_INT, "interrupt 0x%02x raised\n", env->ack_irq);
     } else {
         uint32_t vec = cs->exception_index;
-        const char *expname = "unknown exception";
 
         env->isp -= 4;
         cpu_stl_le_data(env, env->isp, save_psw);
@@ -100,27 +130,8 @@ void rx_cpu_do_interrupt(CPUState *cs)
             qemu_plugin_vcpu_exception_cb(cs, last_pc);
         }
 
-        switch (vec) {
-        case RX_EXCP_PRIVILEGE_VIOLATION:
-            expname = "privilege violation";
-            break;
-        case RX_EXCP_ACCESS:
-            expname = "access exception";
-            break;
-        case RX_EXCP_ILLEGAL_INSTRUCTION:
-            expname = "illegal instruction";
-            break;
-        case RX_EXCP_FPU:
-            expname = "fpu exception";
-            break;
-        case RX_EXCP_NMI:
-            expname = "non-maskable interrupt";
-            break;
-        case RX_EXCP_TRAP_BASE ... RX_EXCP_TRAP_BASE + RX_EXCP_TRAP_COUNT - 1:
-            expname = "unconditional trap";
-        }
         qemu_log_mask(CPU_LOG_INT, "exception 0x%02x [%s] raised\n",
-                      (vec & 0xff), expname);
+                      (vec & 0xff), rx_exception_name(vec));
     }
     env->regs[0] = env->isp;
 }
-- 
2.55.0


