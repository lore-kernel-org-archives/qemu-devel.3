Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E030ACA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:54:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEOLM-0007y2-HK; Wed, 07 Oct 2026 05:53:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEOEN-0008Hv-9B
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 05:46:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEOEL-0000dg-Db
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 05:46:34 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6977jnNA152120
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 09:46:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KsKZjEpW9HZ5leca60dNK4s28m8H0COg7g//cfPmZUg=; b=b/i1Jsn5X6c1trey
 UG0hzbtvePTxGVpDtrrd4Pm8bxJJ4p2sKyHE+NYxy5hpWCF7cpl9+Ephe3Jsv2nm
 1DO7G4AJZ8i227bqdbhvujwZyU5DDn0GR1m3NaQIiHPCqcU375Ycchgx3ZMKg+nb
 NW1h+nGvTaiR6wqHGGjCYUp22RpDf/NdwiqMaF5sROebf2LkSyk8BJvGLCV1K5uD
 SNLY+RB/08F021VKVl9WAq3z8rrAytx4nHFSZOZJKNYdSGFOcxNTdN1b8w5EjfXk
 O4Y/MHXBpbK8QTbdcIdnZr4sTOeCsWQ6KNh4nwMPHkLI9UbS1+lPbT/lokWs5idq
 1GlDcA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5c719h65-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 09:46:31 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93e46c120dfso404172585a.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 02:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791366391; x=1791971191; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KsKZjEpW9HZ5leca60dNK4s28m8H0COg7g//cfPmZUg=;
 b=b3rUKtNqu/mm/UBOQp1Sa4Wccbe5bBT9ARO7r+n+RdnK8F8KDSIEHkqEVJ1s/HkxH/
 fi/WiEUWbGNnVWS45a6WR9cWC+SzTmwJNp+q7T/KAAWBs/ODGq6n6iq51PtK1PEXlDxP
 Nxnn0L0sS+/TKGwcH5XZjSTwuvYr8TUzt75qHjRSJgy1I+udzNKBAz24T34ZyxgNgAwW
 a8whjJc7wzWf2NvszKP4b6O2rfGJpGeDzUvHB0+bPENo9Lo4M2TCsspKPQbyCiW17uxg
 IWQPjI01tr32Xx4Shc9+dFiI9ZjQzJGfISZd9rh8ngszkhjAzDbbxUXcVOyO3XNV65N+
 EV4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791366391; x=1791971191;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KsKZjEpW9HZ5leca60dNK4s28m8H0COg7g//cfPmZUg=;
 b=oA0vMEIcn+fyW1yLLzPNk8kmsMUYuBjTv7rEDKkCX3LgUeWh+QggJh7xVftBXXT73d
 BkDe0qGajk/zSKY6IGaBYnVPyJ8MTvMhV2gFqYeTeIBQBDOXTuQmWDEc9+UvSlfMCK9s
 Jhfx3jfhfOsi0xeWrDSiIYPxcLHddr40Hxj9/JmpKTYU44BotwD2s5sRaF+q2NNpVIZC
 7BKOdWFgSDQT4rhCuJKXWEDJqIT4uKrfEWN5zshLvUEXCWXyaNWnLGZk1ZnVxgLLbOFg
 2GkK1WheE3bU3FPwm70Ae6j2vV9rh0d9CJ51K5eMxVHGjDaLHl15gABh/zSDElNSojCh
 rnGw==
X-Gm-Message-State: AFuF++kr8y/aD4stqMZ6FJFtmgB2woN2FwwUUktb/XJk90KNqQpGCWZi
 KTLq6esR0oICsTQeWvWqTl5XxhUEfCbuBTw6Mtyv0mkWwUKa2Bj06M3J56nzW4fwXlYuFR7pzik
 aGY8gjJGelIIjYq23WtMCV70m/Bp+Mepyd7Jepupv5X4CJjXi8Fb38a8YUWSIhPS47BVS
X-Gm-Gg: AYBFou0IECdDIPcFkLoS581hSnuAJBISBmqDcedm+kiSr0edpVlhO7Tqt1+hi2iPHX6
 ZTJZjmUmAXceJ41ZT9WPMfmSV/d7bdhAbDTPcMtGzEaKGSmmek5HEfXmqMnkjcNIDLosbfziKUy
 QIUpEGG9IKt8Kxsr2t+uLRcTPlHzdjwUc4KYS1rZQbzyD8xMmCdosIWQklV16XM7h739kp0HVPe
 my1wawqkZnpBkyGEkRIeXRn12tKEv9ZggVmrZeR96duH3LspVrjrOMQZXjnXbjAIimDOL1xH1r4
 Esv2vbc1f54ydzC1LiutnS9SLDG8W8JEhubyORzcS5cHNMAEGigP+r88Rbmgkmdkj7bJn52BtJf
 fy2hYxiuDVvM4efF7ElvkVdVEoHctsdy/pZSgZO2f
X-Received: by 2002:a05:620a:271b:b0:93b:d7a2:dd32 with SMTP id
 af79cd13be357-93e9b81982dmr317536785a.66.1791366390861; 
 Wed, 07 Oct 2026 02:46:30 -0700 (PDT)
X-Received: by 2002:a05:620a:271b:b0:93b:d7a2:dd32 with SMTP id
 af79cd13be357-93e9b81982dmr317533985a.66.1791366390395; 
 Wed, 07 Oct 2026 02:46:30 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c71c0b60fsm4450934f8f.8.2026.10.07.02.46.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Oct 2026 02:46:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Song Gao <17746591750@163.com>, Bibo Mao <maobibo@loongson.cn>,
 Xianglai Li <lixianglai@loongson.cn>
Subject: [PATCH 10/27] target/loongarch: Register CPUClass::exception_name()
 handler
Date: Wed,  7 Oct 2026 11:44:58 +0200
Message-ID: <20261007094516.75732-11-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007094516.75732-1-philmd@oss.qualcomm.com>
References: <20261007094516.75732-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAzOCBTYWx0ZWRfX7smSb2+dP5EC
 PYelPwKSOnPvwHsaCLVwFI7Vu4QeUYWm0GDHJw2ubstPagSQOefVd8dUNEqHrDm6hICGp0Q6d7W
 kqB4N05w4hNOsoDLTYbw8fxs0E82qx8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAzOCBTYWx0ZWRfX9QIO6zqgkTeF
 BDv684gNJwpNwqcvnv6SqKAkCcO66dVp1lptGBP9h6+s87g3ak/VN9zKEf60+UubQqkyHHS0Pb1
 HAdbwbiwCMA2WjK/9OzOjVmu93nACOxy7Bkk4sv2KREjGu10iIc59m2rWsdbv8eChV6/S1x5LKd
 d499BRkvaxq3TybJV4creNDixxOd2pb88q1AAHNHDAZD0QzAtaSWku5vRlEU0aYYjZcQO5X9TTx
 JW90ttuMxD2swwOX9v80+05XP+qT/P13Q2j233/xpLTM3x1mb2g6MIRCn8lL2La/mIp/4bT5LtH
 VhK8gvZeMpxq/DFNA2+WCHbBBZ/NdWms072vUCrPmiZEF50k+HW3SXXJaz0YIhN85YTkssLsqfo
 UElvDyJlOhCb0oC5PLLggg5VkIjT2ncuQ4Q6sYbkUplq0enwnneXpyWWohxVK33gdhda12Tm1WK
 v2wKiVvodoJ8+5KVeeQ==
X-Proofpoint-GUID: O_vUbHkljEgjNUHqHYe9qYr1AZSvEt6x
X-Proofpoint-ORIG-GUID: O_vUbHkljEgjNUHqHYe9qYr1AZSvEt6x
X-Authority-Analysis: v=2.4 cv=LvYHWXdc c=1 sm=1 tr=0 ts=6ac614f7 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=nrwLMCx1wy8-tITOK3kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610070038
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

Move loongarch_exception_name() out of tcg_cpu.c and expose
the prototype so non-TCG code path can access it. Register
it as the CPUClass::exception_name() handler, so the common
exception logging can resolve LoongArch exception codes to
names. Remove the qemu_log_mask() call in do_raise_exception()
because it would duplicate the one in log_raise_exception().

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/loongarch/internals.h   |  2 ++
 target/loongarch/cpu.c         | 38 ++++++++++++++++++++++++++++
 target/loongarch/tcg/tcg_cpu.c | 45 ----------------------------------
 3 files changed, 40 insertions(+), 45 deletions(-)

diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
index ff956823fd7..e7fed3afde5 100644
--- a/target/loongarch/internals.h
+++ b/target/loongarch/internals.h
@@ -42,6 +42,8 @@ bool loongarch_cpu_has_work(CPUState *cs);
 bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env);
 #endif /* !CONFIG_USER_ONLY */
 
+const char *loongarch_exception_name(int exception);
+
 uint64_t read_fcc(CPULoongArchState *env);
 void write_fcc(CPULoongArchState *env, uint64_t val);
 
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 54c26998979..fc9c5ab5ac2 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -835,6 +835,43 @@ static void loongarch_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     }
 }
 
+static const struct {
+    int32_t exccode;
+    const char * const name;
+} excp_names[] = {
+    {EXCCODE_INT, "Interrupt"},
+    {EXCCODE_PIL, "Page invalid exception for load"},
+    {EXCCODE_PIS, "Page invalid exception for store"},
+    {EXCCODE_PIF, "Page invalid exception for fetch"},
+    {EXCCODE_PME, "Page modified exception"},
+    {EXCCODE_PNR, "Page Not Readable exception"},
+    {EXCCODE_PNX, "Page Not Executable exception"},
+    {EXCCODE_PPI, "Page Privilege error"},
+    {EXCCODE_ADEF, "Address error for instruction fetch"},
+    {EXCCODE_ADEM, "Address error for Memory access"},
+    {EXCCODE_SYS, "Syscall"},
+    {EXCCODE_BRK, "Break"},
+    {EXCCODE_INE, "Instruction Non-Existent"},
+    {EXCCODE_IPE, "Instruction privilege error"},
+    {EXCCODE_FPD, "Floating Point Disabled"},
+    {EXCCODE_FPE, "Floating Point Exception"},
+    {EXCCODE_DBP, "Debug breakpoint"},
+    {EXCCODE_BCE, "Bound Check Exception"},
+    {EXCCODE_SXD, "128 bit vector instructions Disable exception"},
+    {EXCCODE_ASXD, "256 bit vector instructions Disable exception"},
+    {EXCP_HLT, "EXCP_HLT"},
+};
+
+const char *loongarch_exception_name(int exception)
+{
+    for (size_t i = 0; i < ARRAY_SIZE(excp_names); i++) {
+        if (excp_names[i].exccode == exception) {
+            return excp_names[i].name;
+        }
+    }
+    return "Unknown";
+}
+
 #ifndef CONFIG_USER_ONLY
 #include "hw/core/sysemu-cpu-ops.h"
 
@@ -875,6 +912,7 @@ static void loongarch_cpu_class_init(ObjectClass *c, const void *data)
                                        &lacc->parent_phases);
 
     cc->class_by_name = loongarch_cpu_class_by_name;
+    cc->exception_name = loongarch_exception_name;
     cc->dump_state = loongarch_cpu_dump_state;
     cc->set_pc = loongarch_cpu_set_pc;
     cc->get_pc = loongarch_cpu_get_pc;
diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
index 4b1d44a1644..933b9b2d221 100644
--- a/target/loongarch/tcg/tcg_cpu.c
+++ b/target/loongarch/tcg/tcg_cpu.c
@@ -18,57 +18,12 @@
 #include "tcg_loongarch.h"
 #include "internals.h"
 
-struct TypeExcp {
-    int32_t exccode;
-    const char * const name;
-};
-
-static const struct TypeExcp excp_names[] = {
-    {EXCCODE_INT, "Interrupt"},
-    {EXCCODE_PIL, "Page invalid exception for load"},
-    {EXCCODE_PIS, "Page invalid exception for store"},
-    {EXCCODE_PIF, "Page invalid exception for fetch"},
-    {EXCCODE_PME, "Page modified exception"},
-    {EXCCODE_PNR, "Page Not Readable exception"},
-    {EXCCODE_PNX, "Page Not Executable exception"},
-    {EXCCODE_PPI, "Page Privilege error"},
-    {EXCCODE_ADEF, "Address error for instruction fetch"},
-    {EXCCODE_ADEM, "Address error for Memory access"},
-    {EXCCODE_SYS, "Syscall"},
-    {EXCCODE_BRK, "Break"},
-    {EXCCODE_INE, "Instruction Non-Existent"},
-    {EXCCODE_IPE, "Instruction privilege error"},
-    {EXCCODE_FPD, "Floating Point Disabled"},
-    {EXCCODE_FPE, "Floating Point Exception"},
-    {EXCCODE_DBP, "Debug breakpoint"},
-    {EXCCODE_BCE, "Bound Check Exception"},
-    {EXCCODE_SXD, "128 bit vector instructions Disable exception"},
-    {EXCCODE_ASXD, "256 bit vector instructions Disable exception"},
-    {EXCP_HLT, "EXCP_HLT"},
-};
-
-static const char *loongarch_exception_name(int32_t exception)
-{
-    int i;
-
-    for (i = 0; i < ARRAY_SIZE(excp_names); i++) {
-        if (excp_names[i].exccode == exception) {
-            return excp_names[i].name;
-        }
-    }
-    return "Unknown";
-}
-
 void G_NORETURN do_raise_exception(CPULoongArchState *env,
                                    uint32_t exception,
                                    uintptr_t pc)
 {
     CPUState *cs = env_cpu(env);
 
-    qemu_log_mask(CPU_LOG_INT, "%s: exception: %d (%s)\n",
-                  __func__,
-                  exception,
-                  loongarch_exception_name(exception));
     cs->exception_index = exception;
 
     cpu_loop_exit_restore(cs, pc);
-- 
2.55.0


