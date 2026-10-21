Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E95606E87D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 03:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UL6IpIKD;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QO6RNLXw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJMqX-0008Ns-4C; Tue, 20 Oct 2026 23:18:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJMpg-0005dy-Az
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 23:17:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJMpd-00034C-5M
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 23:17:39 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L2EvXS2562752
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 03:17:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +EK3zscJwoQQDbnM5hHAO2MOpUzNFtj5kae7Svd/g0k=; b=UL6IpIKDVMK/gvjs
 5Zn1/Rps2XWNe8tZ7wTd7wYlVYop6wZGa5afRzFe8zqm9JqnZHdUQlOJQFnF3rd7
 u6yaFa0kOwYlVc9zi6+vPOSFAHtuIsGVZDnCEohHuAMUAtU8AgWikTy5zIVLzfbT
 L4A9zyrDzDZhBoC69URi76pENbTYDJjtJNB3nZUo/NqnY8WwLAqV9dSrdQiEDWvg
 5D+PEV1K8vgY4AFMohXOmFVmOLR0PfykRlhtj+PLuZs8lpNXXFW3frkDqFkScQZS
 ovJBT2e45aPTbJOvUXPcm3BQK59PeEbLSU8SZUp5sU1nIthTVsS8u+JPEW/aleat
 zT9r9g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hebyd23we-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 03:17:25 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93caf7856ffso76185685a.3
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 20:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792552644; x=1793157444; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+EK3zscJwoQQDbnM5hHAO2MOpUzNFtj5kae7Svd/g0k=;
 b=QO6RNLXwCrALX/JJS7vVPfNeuuH0duS2lq84pL9wp1wcI62+j7RZJm2H6u9lKqNIaH
 MVEwCzfZHFysi+AMiQUlcP+TooqaxMp+BvLDfFbzMyDVJ5gHOpRMfJwKbSx7r7p7Y7q0
 w0ZN8AcbU+WUCZkbt5diV687R5wNg8pfEdV+z5gLiTn3YemdLoH21zzq41LQxeNClokU
 KnBuNlm/7iXvPOzWANlYslIsaajB+SGbRDMRAz+DwN9+QOMAwieJeMI9gscO1U4q95c5
 agblS8RMX4nQQEM7cLlhIfUkoNq/O7k6/KzcjYM7CFz7eB/qL1N2JbWq6hpmwS7Zq2X2
 AHxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792552644; x=1793157444;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+EK3zscJwoQQDbnM5hHAO2MOpUzNFtj5kae7Svd/g0k=;
 b=mqGwVM7+IUy38XGNEPrDcL0KTz1pb9M+vst+UWNg3Nxj5Rn///g5KJfkksnmh6b049
 56/5V0yU3PZHASG7UpSm+fD1/EQWgrfw4JfXnwINOcwhSdOIBGM8IafwnlRVgE6AQAKU
 COgU0MA+2pubhdmnv7UbbtRCv7/WnTVurK/YkbMW3vWxofi+KaYYrko8g4HIfjrk10aM
 cJCzHMifpubdIVIhTVd6vtTcgBsWrXN2wO4j4h23UZIJDa4TjtrHcIXfB1/t4fxlHCIi
 BjRgxvo3CDuUYrL227CTk8NhV8UmlyrbqIurw4nX7J4Li/ljvl6N6bLBBdzgQXURB86s
 Wjfw==
X-Gm-Message-State: AFq9FYKwLOnnaWVzRGSWHKlKQ/6c6dYYiQsx8iLhO05R95uWqnDyRzgi
 Z7qDyeIa5XDiNnvV0JWS97Ihx6hiHnyKAtkM/91siGIbUAs2PXtnL7bDYkHyVnbsYXfYvmaWVmb
 gZ8ywCLstNlJhUABiKQLS4pvL2PZVX/Tuf3XPG1lc42VclgnSMJVmGuHHvkaE28fHfvF3
X-Gm-Gg: AYBFou3crhOEE2b5nlX5wZ5/oK2GAALsR1fWSSSnukTBBCDRUETui+a525/MgCc0mDv
 bmw0AmFTju5DB97L6Ls1mUXJU4V9jtvZ2fg3yYF0NXeD/FXWIMHOJWKS2zU+laABrKWbo7tJkNx
 8lDsuvX0mKaG+kZT9m5wy18N5GHnUAWxR9rwm06GZGrml6P6IamTeF0eIs5nxpPJLInywKdgzoJ
 fpZrlnfkJqxCT5a5QIMPJoAADoSJgJgeoygRg2Fcrl1mysldOGxJ04OhIZinJ4z2pI79ryuwXSX
 C7Cm9KzddsAbzkabqKFYlpW8NTuFAcrYaD5kxnkN2gVC+AAndo13t9Bs9ioqssmnDO/PHtg9WAL
 8CPpisOy8x7I21elEfrwaCrJrdYg7rA1OO8NxPKEy
X-Received: by 2002:a05:620a:261d:b0:93e:fd69:9a93 with SMTP id
 af79cd13be357-93f57f84f2fmr203776185a.31.1792552644468; 
 Tue, 20 Oct 2026 20:17:24 -0700 (PDT)
X-Received: by 2002:a05:620a:261d:b0:93e:fd69:9a93 with SMTP id
 af79cd13be357-93f57f84f2fmr203773785a.31.1792552644023; 
 Tue, 20 Oct 2026 20:17:24 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fcd70027sm11156995e9.0.2026.10.20.20.17.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Oct 2026 20:17:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 25/33] target/rx: Register CPUClass::exception_name()
 handler
Date: Wed, 21 Oct 2026 05:13:58 +0200
Message-ID: <20261021031407.24862-26-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261021031407.24862-1-philmd@oss.qualcomm.com>
References: <20261021031407.24862-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAxMiBTYWx0ZWRfX6FSNj9m9qGKj
 vh8Prb3UwUHlCVSzuy2CjcqPX5L33Z3lEb8G34RLErHgLlaSzhka6/dKHNMYL7U+BRAo6Pm13o/
 +tEDBmBjydb5KQYGx0NgYe640C5IzNBK/byOsRmfWs9Iivd0dyAHip6SBby5QnhphAeht1Of5it
 WWCRbSxHsaZu2f/E+TNyAYkpzc3AZQaphFrbXQ+4sc+LR0Qql6RofICMqEqmp8Kr4WenUgCPzjc
 0Rywz8BjIBWzfxcptQX8ZXTQCmIqTUZfIaEX+qgQ5en+7hP6oGbMWarVOljDKAxxrcKIUO95lZi
 F+tuLxm62Kpz8iPo+KigRGjoDKVVy7/oGcw9s7c9W6AiKMetVtVdXjpNNZQiwZbHoIRQKF3haBD
 qTm6hskEStoS4WspBJOItt54bX/ObARmEIFiFXQs4fNdrtAAfJEL3eboiDIdIzWNbgks9Zf7iAe
 PVxe7KcJAAzHRgo/V5Q==
X-Authority-Analysis: v=2.4 cv=TdsDJhQh c=1 sm=1 tr=0 ts=6ad82ec5 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=7bFQwIbWrMmj_3m7X6gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: QkPhJ3kFFK54jmyI28TL-Yz-hOsW2KJh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAxMiBTYWx0ZWRfX0JliFme8tHe6
 ifE5ESVjlKGUZvnwbShCPthXWRs4lkV+ZkiCPgXzTraeNnPNjrgZ0omqahcqXN0+/g9vGr2gP9B
 qLa8Cgpo3kgkC2sCyH1O5LSWf9OXwEA=
X-Proofpoint-GUID: QkPhJ3kFFK54jmyI28TL-Yz-hOsW2KJh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Factor rx_exception_name() out of rx_cpu_do_interrupt()
and register it as the CPUClass::exception_name() handler,
so the common exception logging can resolve RX exception
codes to names.

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


