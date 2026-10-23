Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09116606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LUqLEnDN;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=b+huohZC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHz2-0006u9-Mj; Fri, 23 Oct 2026 12:19:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHyz-0006lE-TE
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:19:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHyx-0002e7-Uq
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:19:05 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE6rYv1492211
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:19:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XFmqOrUwfsQuMPiyPh5TP4sIOt+boNYJeHuGOv70aLY=; b=LUqLEnDNHXJrnGlh
 xgY11qLO0gCeSTuPWuOT07cQ7EIbiydg6Ah9XdDFzY2do7SgcQHj0KQo5yUg7oqn
 iwqYvCf+EKaEt1K+fYLsVlKxp634PkJMZqHwn47VhyYZ3zXTNdiBhLyYZ2Lyayek
 DFNUMAD8+1g11TyZi0aYkF/piR8HZLrpah7FVuBzMq5QildfF7vfnyJFq7oU8YCe
 HiUmCr+teE54hfERyjuyMkwz6v97fDyZ6od6yz5EDX1G5Nmiw9ltS25Sl0wJk+/K
 D8t9Gw0jEq+Q5HLzVWhhW1I3jnXi7ScCMC9OiRbwNB0LniOthv4vQmQNFvcUYEoZ
 enx4YQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfsmauyg1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:19:02 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9308eafb465so307994685a.2
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772341; x=1793377141; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XFmqOrUwfsQuMPiyPh5TP4sIOt+boNYJeHuGOv70aLY=;
 b=b+huohZC68unfGaZoM/lBw4k/Pqx8evsG/TUkt/PoSdGRVkrHPjzCkORLbpJAnQRp6
 uYRGQZIO1FWBhS7IGUlgHADxK/QL40xFJVMslNGmM8nstWodu0doCuK7qcWHIB5bK9z9
 M0M7TE08grU7iUkNiG9GAL/j6wfRrtV38GjGlvbZj4VFb3JfOSA6yvvk7yhVo1mD6DSc
 SJi6smELz9O3oSovqhc2AtOLFKi1oBsHouKn4l9b6kzVEugyGvRTQ7rT37CkLR0Ejkmt
 6KgJ+CG8GgErngJ30dDbuGE9IU5GwHFS/rUuaMKmmQK+9T5D32jkaMRFeXoV+iKdbwXp
 104g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772341; x=1793377141;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XFmqOrUwfsQuMPiyPh5TP4sIOt+boNYJeHuGOv70aLY=;
 b=gzJBbGnoDr6fxkn3+BAG7g9Bn5hRZrN+Z+OtCAB9XmPgeMweY/VhtzwF6Lhdlg977C
 x/ntAnHC624nzwuQWz/mn79Dtccus3leCGK+jB4Sy0kFwsv0H/hFQqxgX127yEC5GO1n
 rsbTF+R2mCNnJiGAWj4OHtpnmjNOUZoPp4/88WdF3abzEXGkDl13IOkKwef0oCb5gkoC
 NZUrtK0GOIQk7aBUrQf4w/+DDkbEVVlNeN6jMWD9WYavQBURq3fiQH1y/rM4h1MxddnA
 r0MtpLS6A5jmBr5R4HaMkaae5MjxEXOtNaC/ybxm6EfEcZ/KlQbKT6LyjsHzMUq2XBMz
 y1ow==
X-Gm-Message-State: AFq9FYJXV5tDRpd2RIDHhdrnssMpDJxHbXa7GjoVh/Mrz6mO0pLh0IWq
 RRbx1KRIDm9d/DaR3Rel50w4+Cms+elNKOnWCIwgkLnS+3WIBi/XAhgxL5/p+KVzy9gczqGm18q
 eeIL5BPPy2Qc9iOgquDnC7R3O/nXPG8kgHeISmRju/Y7glmsl1LpHGPpGU+D/sNliJKa0
X-Gm-Gg: AYBFou0r7TUWzRTWycuBUvOfkQKXFYv2wonsQmGDu4fK3+MghJCjfD8Zv/pFf9ERg+x
 KPoGI1v1h7YG9hcfTYnHhb5IW5eZWji5NAOJbovMzMMmAJ5trGCspM8aLO1UE3HyxuSzS0F9Pvj
 vgLloaRWM+w9IBsM3J/jQkFSiqLexxtYKPJasODCshAz5UGU2Q9Dhtq5XnviKggGTpGauUoH0HV
 rzmZ+7pZnRJ2RHTXUaynhvhaU3YkB5jFNKnATJsTUoqDQEBmYnoTc+iPKA5aSoVD70SAJ1eVo65
 t87FlH9w8hucxXtSp5XGvaWlALtPv+bS1yoL3NZfXnaW0S62vUKFzGUlmAW+h1NL4awrTK9BA3S
 BAzJSQBynlPPhIPUXOzQz/549d3yPYdVURPlx5iJ6
X-Received: by 2002:a05:620a:2a09:b0:93e:942f:b8a6 with SMTP id
 af79cd13be357-93f6f9b7400mr508856785a.59.1792772341203; 
 Fri, 23 Oct 2026 09:19:01 -0700 (PDT)
X-Received: by 2002:a05:620a:2a09:b0:93e:942f:b8a6 with SMTP id
 af79cd13be357-93f6f9b7400mr508852785a.59.1792772340616; 
 Fri, 23 Oct 2026 09:19:00 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a2958bf25dsm20223105e9.2.2026.10.23.09.18.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:18:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 45/83] target/rx: Register CPUClass::exception_name() handler
Date: Fri, 23 Oct 2026 18:12:53 +0200
Message-ID: <20261023161332.60153-46-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=V7LoQuni c=1 sm=1 tr=0 ts=6adb88f6 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=7bFQwIbWrMmj_3m7X6gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfXysrFFzkVKrko
 qp7X9PD81IX8nVDLWhxN5RWfiLstYyOG+g0Zik6EsQXU6ABlzTctI5j14R6elLl3MSXnkBdFOnZ
 viWkFvjh+tZLczn6/cRt8fNx4nqZeL4=
X-Proofpoint-GUID: eUP06P8qHAc_x8DaUKGwtpfOl__66LjR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfXy5L8JWkk/L2e
 hXtBmLfx/ilcg6U9kMTAocF5RslPrsk1EN22TxnXczePd2l/0n6r9ZYiIZXzpFfkKVGXOdAnFbY
 GIQ2Lh40smilS1ro11+5yYDMCaE/p8MNTqk6bCA9s0Np9qqANOxjuElVdQlp02xLLGakSNaxO9J
 0wx51wVOeVcVPPSyhv68iNQrdtkVhJ0llZjoYrJSIwR498a1oNMjtolBTV7ZuTHx2FYOlzCKS2q
 kQyjQ0YHJelxR8cyGoD2oneFq0xy1B1Q+uTRFrEPzcVaPwjujWcVnB/4nq2LxGE/LbHoj3YTX69
 yYhS94CfbHS3MqQESXiXaZoXRwST8KmQP3RhQe3o32ZKY0UUfoDeCuQmi/MeTaeguYhM1e9QwIw
 hFBaB9wEFhEHmvPAcWsHD1EybPPKu9bFgEiThNQLYmRFq2MZYUUbhE2m1rQf5rBLo81AC5z5yUQ
 xFvorvh3hUr+pD8A2Xw==
X-Proofpoint-ORIG-GUID: eUP06P8qHAc_x8DaUKGwtpfOl__66LjR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015
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

Factor rx_exception_name() out of rx_cpu_do_interrupt()
and register it as the CPUClass::exception_name() handler,
so the common exception logging can resolve RX exception
codes to names.

With '-d int', unlisted codes are now logged as "unknown"
instead of "unknown exception".

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20261022215115.19680-27-philmd@oss.qualcomm.com>
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
index 69946928995..44ec3c3d62f 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -244,6 +244,7 @@ static void rx_cpu_class_init(ObjectClass *klass, const void *data)
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


