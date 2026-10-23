Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992B9606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=G7QV7Azh;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=g9G05m6T
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHxc-00032O-Vi; Fri, 23 Oct 2026 12:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHxN-0002lg-IZ
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:17:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHxL-0002VT-79
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:17:25 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE5vmm4063370
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:17:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IfoKac7+X6HFzNtpeSY6wixaiOq9cgwLiWAR7KmvaDc=; b=G7QV7Azh7UucjP7N
 GV6KjpkGblQn//NYPjyLOd/nP7ImzIoVnQfm37Mf9qwiX0EY8T3GBVHwv44dSEUT
 RXhXCNzYN5BB9xbRzbJZ5GdP0SiCD1SKyNX+Htv+lkLJXAEG2POofNe3tiDexxsL
 fe6FmlmPF2QsQ3iSYvTO0Ye4KmrQ6PQbsxR2wKxO5981T9wyb4ac1HU5XLyPYqcG
 GhXFQ1xRlhjzMXN5MedkHu9Jz1cGM6+yPWd/5oa3ikL7aL+Ir/3q4wYMEMS9Hzkx
 faNvHaAgXpgmTnAQ/RHAruUVBc9Hhuq8Rdkk5dxhd1FnG//snDyCNa39ds5cez9Y
 yrd6HQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmrcgtm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:17:21 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93cb7f9bb86so197600985a.2
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772240; x=1793377040; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IfoKac7+X6HFzNtpeSY6wixaiOq9cgwLiWAR7KmvaDc=;
 b=g9G05m6T2ci/haVpAlGFZHouE2XuPLYCOlVQfOQjwrKsbM2h67L1ledy13nBBH1IPn
 O+GNlCzocLheX/+AHMoXkkrZhO0PvZ4+fN3bpSiBeAAAZNGpecnjMtcRKHcet9Rq7VoM
 NX2qO4SOj6LlUf1SZkGrdEvcA18gi5fHk3BIhCuIW7y/ILxce/GJcbaHiOXDIhl6lAQ/
 pXo4k5ou453QhJIysvTsZcTetaE0crEdHevn+Qjkug5myQM4PE3wYQbN0d+9qP/Z2axT
 xu8YbwnRCbvoYOoaqQMDr8jWhUir9rLL73tCvHcY7BvEXpOtBXJrBMLFIGP9g62EzFXl
 MMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772240; x=1793377040;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IfoKac7+X6HFzNtpeSY6wixaiOq9cgwLiWAR7KmvaDc=;
 b=FWKPg6JlVEVYGrB0N8Ur1Ls1USiI3bO6fSobA2ElU2cN5E23SPj0Wh2dcNKvRtAu9P
 UbTbyDa0JMFpRu/0nRcYo9ZLcxWlGTjYc9Soz9llihi5aAAzzqjngEhcE7Asldgt6M3t
 kLoiX4cOdPwuDl7vuvEH8+6K3B2Hzod4TAnPw1zJoAtrqdqfV10ZRpQ0rsS0z/6eUVOz
 v7QjqYO0qWjhn0R9RHP/+ToPB9Pgn8iXUpS0hSy4OzBskqDc0JE6K72sYU/El9WHesQD
 ZYuhTWHUWnrkUEUcvHSIAQtqmhk2B9M2eS+e/IZXlP29ZNCu9aHLgyclvYl4eqdh0ZAp
 nhWg==
X-Gm-Message-State: AFq9FYLuYs+mOVKbkYemQoOAy1P5GTJ1zznrtds0SGEAOxFf3DC0CAah
 cswXd/UhwycGYYqPoGahGubOQ58Ll2sGnAKJ9CwJR+DQyg0EJjbwg5zz01yeeM1TeTqSpXRXd9G
 zekZ8o+1XGKEMGBJm9IG80XKGTprT5qOxEJioDO1GE6xsCXTvYMlj/+veA8wvdWRWwOnp
X-Gm-Gg: AYBFou0hgbZawrZQYRsDQ5JBX3/NydOgyu+dMrdRwMiVbJCe4clMvEHniVS6Jh3O/VC
 VXzZ8KJ6b3sh453XG0a+iedpVVuJe2d49dTN0mTd7TbIvaJ8q5OVXgLVnV7PEXoAcBXs4xwk4gl
 A4LUG55xCSZGAFmPYH3gqXyWEas3mmSTi44w13Bem7L7VexgZ8l0rUQWHITeFvozbrGSt0S0oZ/
 4v0ws/Sv/IzPpzKia/gHEBLRhL8FzdNDb7nL24kty32WL+ZUftvuK6Sxiv72eCg4JlaShYS2D/C
 g90BJOuYz3WVpfhXMmpVaTZJUZkMVeJfNH6K8q4zQWPJ8M5PlKP1hsE/av5ED8W1HF4aWz4WzIg
 tT5lEfmdQVeu9wIc4Vhy6lxt28G9HpVhC0XOjRFNW
X-Received: by 2002:a05:620a:280d:b0:93f:53d1:54c7 with SMTP id
 af79cd13be357-93f6f8249ddmr521968285a.70.1792772240400; 
 Fri, 23 Oct 2026 09:17:20 -0700 (PDT)
X-Received: by 2002:a05:620a:280d:b0:93f:53d1:54c7 with SMTP id
 af79cd13be357-93f6f8249ddmr521962685a.70.1792772239751; 
 Fri, 23 Oct 2026 09:17:19 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a2a9062ce5sm18271655e9.1.2026.10.23.09.17.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:17:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 31/83] target/i386: Implement and register
 CPUClass::exception_name()
Date: Fri, 23 Oct 2026 18:12:39 +0200
Message-ID: <20261023161332.60153-32-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 5leX6oUfhcaA-jxwXDamZv5LpMun6YtE
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX1okencmrg6kw
 AWpXFwlWESxpFQ4QGtGw34+BFMw9fMDtgX854JXThLIujJ7IHky+mSvVk4Xur//7XivA0dZ2hlR
 ssqJIkBW2RYjXkxewa1Q9KZlRriHsOw=
X-Authority-Analysis: v=2.4 cv=VNZIDNPX c=1 sm=1 tr=0 ts=6adb8891 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=Fd9WCTdBRaK1f7vQhjgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfXyV1g4UnG8sMb
 GXGJV1ns81ieUojjo3HwXHqzbVHBeQIcAPdy6dcZ7lvDKrD6ZbRIhl24uGA+Np8tXke0GWF187A
 AtuZjp5GbSjMu7vpoVlQYF8vrsg2qeDc/Li89pGQxR+Tjv8+nTIhr30nN4iwMcd0SusexiPtZ8T
 zMn+/lBT4IWTVF4sWBUbT4AbYjmy5zzJUWnzKifpEW6pIycCIoj5NoT7n8/adbAD3GQP0C8V1cz
 M/kCacrD2bjXTCGlOeeGz8jQwtXqUrSHNKC6AF8vEU5LPi9zeqk205L07HSaNpmjCXAFJmCfhJy
 LXjmVj4yKRPCSG77v1T3sJFghFVHFjDhYRLwZGoWZab0A9G/NKRQDpaQ4scMpuM6fADCG+0vVei
 YKawLA1S1oeXL/AvDKgxaBGaZQ2mcAxzVbCmZYlPYbyPXzPueheaC9DcHcyGwg0y8eDnxGui2mt
 8zjfnPLqO1/SWdnJpdQ==
X-Proofpoint-ORIG-GUID: 5leX6oUfhcaA-jxwXDamZv5LpMun6YtE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
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

Implement x86_exception_name() and register it as
the CPUClass::exception_name() handler, so the common
exception logging can resolve X86 exception codes to names.

Use the new helper in check_exception() and do_interrupt_all().

With '-d int', both now print a name in parentheses after the
vector number. do_interrupt_all() labels hardware interrupts "IRQ"
and software INT n with n >= 0x20 "INT", instead of looking them
up. check_exception() shows "none" when no exception is pending
(old_exception == -1).

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20261022215115.19680-13-philmd@oss.qualcomm.com>
---
 target/i386/cpu.h             |  2 ++
 target/i386/cpu.c             | 30 ++++++++++++++++++++++++++++++
 target/i386/tcg/excp_helper.c |  7 +++++--
 target/i386/tcg/seg_helper.c  |  9 +++++++--
 4 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e7a88074c07..3945e90371b 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1517,6 +1517,8 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define EXCP_SYSCALL    0x101 /* only for user emulation */
 #define EXCP_VSYSCALL   0x102 /* only for user emulation */
 
+const char *x86_exception_name(int excp);
+
 /* i386-specific interrupt pending bits.  */
 #define CPU_INTERRUPT_POLL      CPU_INTERRUPT_TGT_EXT_1
 #define CPU_INTERRUPT_SMI       CPU_INTERRUPT_TGT_EXT_2
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index dd9cd7c5625..e65eca0459a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -9372,6 +9372,35 @@ static bool cpuid_has_xsave_feature(CPUX86State *env, const ExtSaveArea *esa)
     return false;
 }
 
+const char *x86_exception_name(int excp)
+{
+    static const char * const excp_names[] = {
+        [EXCP00_DIVZ]       = "DIV#0",
+        [EXCP01_DB]         = "DB",
+        [EXCP02_NMI]        = "NMI",
+        [EXCP03_INT3]       = "INT3",
+        [EXCP04_INTO]       = "INTO",
+        [EXCP05_BOUND]      = "BOUND",
+        [EXCP06_ILLOP]      = "ILLOP",
+        [EXCP07_PREX]       = "PREX",
+        [EXCP08_DBLE]       = "DBLE",
+        [EXCP09_XERR]       = "XERR",
+        [EXCP0A_TSS]        = "TSS",
+        [EXCP0B_NOSEG]      = "NOSEG",
+        [EXCP0C_STACK]      = "STACK",
+        [EXCP0D_GPF]        = "GPF",
+        [EXCP0E_PAGE]       = "PAGE",
+        [EXCP10_COPR]       = "COPR",
+        [EXCP11_ALGN]       = "ALGN",
+        [EXCP12_MCHK]       = "MCHK",
+        [EXCP_VMEXIT]       = "VMEXIT",
+        [EXCP_SYSCALL]      = "SYSCALL",
+        [EXCP_VSYSCALL]     = "VSYSCALL",
+    };
+
+    return STR_ARRAY_ELEM_OR_NULL(excp_names, excp) ?: "unknown";
+}
+
 static void x86_cpu_reset_hold(Object *obj, ResetType type)
 {
     CPUState *cs = CPU(obj);
@@ -10948,6 +10977,7 @@ static void x86_cpu_common_class_init(ObjectClass *oc, const void *data)
     cc->reset_dump_flags = CPU_DUMP_FPU | CPU_DUMP_CCOP;
 
     cc->class_by_name = x86_cpu_class_by_name;
+    cc->exception_name = x86_exception_name;
     cc->list_cpus = x86_cpu_list;
     cc->parse_features = x86_cpu_parse_featurestr;
     cc->dump_state = x86_cpu_dump_state;
diff --git a/target/i386/tcg/excp_helper.c b/target/i386/tcg/excp_helper.c
index d6410d6fc11..f1b9b188ecd 100644
--- a/target/i386/tcg/excp_helper.c
+++ b/target/i386/tcg/excp_helper.c
@@ -56,8 +56,11 @@ static int check_exception(CPUX86State *env, int intno, int *error_code,
     int second_contributory = intno == 0 ||
                                (intno >= 10 && intno <= 13);
 
-    qemu_log_mask(CPU_LOG_INT, "check_exception old: 0x%x new 0x%x\n",
-                env->old_exception, intno);
+    qemu_log_mask(CPU_LOG_INT, "check_exception old: 0x%x (%s) new 0x%x (%s)\n",
+                env->old_exception,
+                env->old_exception == -1 ? "none"
+                    : x86_exception_name(env->old_exception),
+                intno, x86_exception_name(intno));
 
 #if !defined(CONFIG_USER_ONLY)
     if (env->old_exception == EXCP08_DBLE) {
diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index c89d97e022b..d75ee54f9e8 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -1207,10 +1207,15 @@ void do_interrupt_all(X86CPU *cpu, int intno, int is_int,
     if (qemu_loglevel_mask(CPU_LOG_INT)) {
         if ((env->cr[0] & CR0_PE_MASK)) {
             static int count;
+            const char *name = is_hw ? "IRQ"
+                             : is_int && intno >= 0x20 ? "INT"
+                             : x86_exception_name(intno);
 
-            qemu_log("%6d: v=%02x e=%04x i=%d cpl=%d IP=%04x:" TARGET_FMT_lx
+            qemu_log("%6d: v=%02x (%s) e=%04x i=%d"
+                     " cpl=%d IP=%04x:" TARGET_FMT_lx
                      " pc=" TARGET_FMT_lx " SP=%04x:" TARGET_FMT_lx,
-                     count, intno, error_code, is_int,
+                     count, intno, name,
+                     error_code, is_int,
                      env->hflags & HF_CPL_MASK,
                      env->segs[R_CS].selector, env->eip,
                      (int)env->segs[R_CS].base + env->eip,
-- 
2.55.0


