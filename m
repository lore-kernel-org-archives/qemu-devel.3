Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33AB4CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:54:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEOLT-0000Jw-AK; Wed, 07 Oct 2026 05:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEOFX-0000HQ-7T
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 05:47:52 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEOFV-0000pm-F8
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 05:47:46 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6977jWUA2481343
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 09:47:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Zec22XIpZC7LYEr8bbO40y7WNo9YYUOyNn4kGa6ypW0=; b=H4Nc1B7kYVjiUQaz
 Umq56f+5iP2iDVwa3enf+9phPRGbqVmuuhX5Z/n9U7VsXkYQvnXi7QJszrOGVIBQ
 fdOhbimAkE9cywy/Hx7olBsEIWI27BGvdLTjasMnBVjh0QVSzrFKTYqB+r9Xmi8/
 FJhbGzBUNmoAPUkx1Z2z3xOVtvl20I+eet4PMtpjfdq69LOY3+x9R+f/GJZy31XU
 pFeuyVR99sf9f7xnppJ8v4DqQvo+T7fjBhEGFGC19B1ba8cP2ySi8qJzKVAgM0ML
 PudGNahyuwG3yOyv39G5hwv7YEOyV8fKtSur7xOzlChGl4W0DyMQBH4KqU3PeQ7V
 2U71Ug==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5c6u1hds-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 09:47:44 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93a1de6d5c3so818596485a.3
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 02:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791366463; x=1791971263; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Zec22XIpZC7LYEr8bbO40y7WNo9YYUOyNn4kGa6ypW0=;
 b=i2VidjNkYKb/5pL2KgL0iTuYXCKSb9YyQkMfEq4suzDtqQXxzXG1O1Ccv+89oAZ1Vd
 pUxDqVUVJA9aN3xARTvTNN+HDC9HcszedHfnnFolorI3mRX/xs+w3Jfij70IJ+hcyWO6
 vLk6c98VOxYMs9H7GPXqYUnRKryuVkIxk4RVAW06lcvSn06g2a3ENxUfoPJUbpvL2OoQ
 6Mwhb1sZTa6eLrqTrnAVXNyB131Jq5vR5Iat8teoI5vE3zbWH2sKkGMvkN8zCZJ4Vfjk
 9y40aLSBD0gJd7oUYEb8Db0CD0v6DSJStdLWPXKw1/CXXho9xjxQ30kO+lKSglEFPWs6
 1sFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791366463; x=1791971263;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Zec22XIpZC7LYEr8bbO40y7WNo9YYUOyNn4kGa6ypW0=;
 b=dIE69EhCUZiiZvBBc7CDMI93mDPQi+/6Z44zbTmOnklGPPp5EtJE8NFBFI/XSbuYb2
 VrXy2AvQXcfDzkhXj6tdlksuK/4gcc9aGKx3aFux189aceXEeEH0vRuQjyKqT8AZ6HUm
 0T0jVu6xZVQ3arr0yEXjjfi3g5Gibju6bh3C0n/Hr370wX/LJPd71BPXU+5wsYc4WsnM
 egQq0i1PYxoIUj8h4WB9Tvovcce596DyshKzSNIWRVzZeecwPaYhvWw0ovntxqqRLLqC
 vBzNgUsZRfqMJkFD6/ZZAaw4S4RPpX8EVSuHKrmw90+6S4nyERlSTcxJlgHnHefVsiel
 Ingg==
X-Gm-Message-State: AFuF++l4Ff1EtH8SgeL2yHz8ulJhGHp1sd1wjtLuLs9U2uI5cOnfdAO3
 bUrQ8E6ZJ27aAla1qo3ZHljaTyMxGvlLJ4VX39iIxDlgsAtnMiprNPKCz/W5PXq/ZctfVJ8t5cp
 DCXg3+VKXBqY7FWfEWPio03vxEW6QKCXPeeTsv+zSwMqW4B6C3vx/YxvgMWZzkjDYfv32
X-Gm-Gg: AYBFou1n6PaP0SOJIS+syKk0GYIrEF2e1/407Zheb7wtvDFYJ7QAoxB7rChfKsMOHmp
 +m9AOfVhzGbYL36VUz7lVmWW4ow1pJTOJWoiMKnYZVSoO+27KaK4SDcQtbqkJlyRsZzXZUj9Vle
 INrugg2jjL5gPZtMqXfm8QTTiaIhQ+nem/Gv2QtXyDNC4keDB3YBgPt39+GxBg/pDNfcVAiQHVr
 oEofyGz6wv2lPtx8UkMAWsU2A17QcJoamZ/CVf5KpbuwcFf3cB6pm16djCP3o1arFHOeMv3dOYp
 E4yhhU/2lj1tZMzGZQyRTLpsPDe6GveCaL4W1uDsVL7UWUcEeuujep0ZokCBz2IBl9iL/tChz2H
 YXscNd/m6+JecKoCNgC39FLRUoAonuiNIUzAdfA1T
X-Received: by 2002:a05:620a:444a:b0:93d:23b3:507b with SMTP id
 af79cd13be357-93e9b80306cmr303986585a.57.1791366462943; 
 Wed, 07 Oct 2026 02:47:42 -0700 (PDT)
X-Received: by 2002:a05:620a:444a:b0:93d:23b3:507b with SMTP id
 af79cd13be357-93e9b80306cmr303983785a.57.1791366462547; 
 Wed, 07 Oct 2026 02:47:42 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c7256434bsm4204084f8f.15.2026.10.07.02.47.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Oct 2026 02:47:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>
Subject: [PATCH 20/27] target/rx: Register CPUClass::exception_name() handler
Date: Wed,  7 Oct 2026 11:45:08 +0200
Message-ID: <20261007094516.75732-21-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007094516.75732-1-philmd@oss.qualcomm.com>
References: <20261007094516.75732-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAzOCBTYWx0ZWRfX1o4KJ5CtU2yd
 ck9JIHdNxJtcE4+QcwWe+38r/1RKQxUrMpBh5VbMwE36IrpETLFvyNZAkxzPReP2Aj9M1UxtKlM
 LIzPzZyn8XFOYhg2tbjex5IFbyQPmwc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAzOCBTYWx0ZWRfX28BH2ipqCnwn
 PdF0l2RuDjF3DPdxaMXlWXVrTs5gBG1k6oexkt+jaqy7PzqBwIYocqMOnJJdZij7pHBiEVTMQne
 4nLG9OFxdpTuAY/H3HcLY1yB4ktZA3rASLQTimKsZZno7fvXdPMNYHEBNcovjRbMrq391OtenjR
 MKmg5ri/O7hvfepH4Noo+VlXJAKiJb/R04UnNjmKn4a+fvigpkHvcQUlv46hAbQ9tKTZe3RiM/5
 HVDq2tIZgLZPJiR7Twtfb4dEI6lCGEnmzBn39iNJKFLFDlOXp3JQ8dvPKkv1yBf8bWRFaih++9m
 gnRwPQPksL3/F702bRyImj/NiDMT2DUdTIUzl47ZIiooZSIVr8esBKXu6jW6jZFQUnGT4zLdo/Z
 J894BttaMYEalqqJOQI8FV5bwf3nbeG/e3FTX7M3kMjHarthY1LdiBq1/v8kDvVq8CY1eYL6ca4
 c8tZgHvEKwVoNW/9ZCg==
X-Proofpoint-ORIG-GUID: 7sgrFZWRnijasUAud4BS5R0hjX4BCXqO
X-Authority-Analysis: v=2.4 cv=T5EZ3PKQ c=1 sm=1 tr=0 ts=6ac61540 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=7bFQwIbWrMmj_3m7X6gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: 7sgrFZWRnijasUAud4BS5R0hjX4BCXqO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070038
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Factor rx_exception_name() out of rx_cpu_do_interrupt()
and register it as the CPUClass::exception_name() handler,
so the common exception logging can resolve RX exception
codes to names.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
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
index bc76dd28ab3..fd662b1b5b9 100644
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
+        name = "unknown exception";
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


