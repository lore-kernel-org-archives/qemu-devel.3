Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1FB606A322
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WkJyqz3C;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LR0+OT3k
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0iT-0007ff-Tk; Thu, 22 Oct 2026 17:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0iR-0007W2-Ax
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:52:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0iO-0007Zh-VN
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:52:51 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MKk0kS723622
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:52:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aqtluyIZK8bWmJJkBCwBr75uP3XNpIGHW4EwpASJcn4=; b=WkJyqz3ClQtRi6Qx
 hXyyWuNcVQuMuAWdMbZqFlmFd4KK3cM2BeXL406r0ociT1d3zktiG4mKbFI/5QGd
 kFASch24WXmW4wv5rNNO5vVMOqOcImtPydSLFqqVDeeesm0JPhnvP5kUuomrzAus
 2rZhWgbkbTZTdEiFdvy0nx3aE0jj3k64mHVSX+wd9uGWSNrWgYdT85GDFlPF0LJP
 FmFhC5upKCcrf6zTns1yl/KCdblrIY6uKdNwdfzgF1TduVuJZLRl4qxI0H+bMCL0
 //tr5q1c0zpaNOy17/KYbLdlrrC9WduD3NJ+wYP+8wzpUrQBmAtGODsXXHQvRqEg
 IQKz1w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfnyw17n3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:52:47 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f5844cb60so50431085a.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792705967; x=1793310767; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aqtluyIZK8bWmJJkBCwBr75uP3XNpIGHW4EwpASJcn4=;
 b=LR0+OT3kt3amZ5jxUsc3xx31scYEhxqVdaDbjqsfNnCjDduf7W7utOu0I/phPv2Yji
 NVPGb+LRCp7bo+Xx0eTrv1qkb38Y7zXvW1ECtwS2k3wgjqthrvfYswTFEyD17rEmbva2
 SSn/o2SUg5/j7dq42gQvczarUsZkOis2wMZlVNhsJ8ObJDOq/FT9kJbS82qFbcyKXvha
 iWzmJwikjqWa0Qt+h/sl5p+nO3ob1GmCm3acZpqK2UUvQo7Uj3yDuJmZxVU3RqvZ0+nl
 EJdyFaZzNSuVZVQiFsRtAJ2A7dlOu0GLB8PZilot67tFkYkb/9eHCRd/U6G5nTIpE0rH
 fZ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792705967; x=1793310767;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aqtluyIZK8bWmJJkBCwBr75uP3XNpIGHW4EwpASJcn4=;
 b=XdJ2eQ0++Ytyar02dJCs1/tm59NctYdzzFFtiDQ2S6m5UFSjtr4gifMALXnuzUcBek
 0z7zTeZWK7QtxJdw0WqKGW4p0VI31Poc3Zsz8fUFi3RzVlnZ8yKZ8JN8qSRux/VBNcUi
 Ot8xGelNRRPzoxcTeHZUd9214dn9mzZjqDHo7iFvQMMbtpyiWbX8IK2Yfw8HMBpOW8Eh
 ZzIz3PTV9Ylz3oaXoj4cEQ2QlntjAl9QGBMWCy6gv3P5G8AWxZ2resou/uAbp8XCtUt+
 o2FpuFuqQ/eTXQgnnEmOINKXQ9bGyRO1k1HdL+cVFAkPWMBGqlAN9e7ainaLxk9aFstJ
 afMA==
X-Gm-Message-State: AFq9FYIzrRgEW/TebaespDqKCPgy6OthYW28fA1CbDnSaUr8Z0wUWdhw
 oXxZdB8DkiPveOVkRpO0NaczBKnOBYcer9paVaTVCz0iQGhLltoTsq8qX5acOMIl/499+nB4d/k
 edJ/w+jpwZEGoxbVfAHDgt3InuE0o4vc/oOPoYahzURzlT0mV8EYJlUEvN4nUuFF/Rg==
X-Gm-Gg: AYBFou0AH3uB3S0gpdXqDyfR1hIMkHyy86mAc9ApIrTB8mazpDugXLK5HYVX2lRX/+O
 1coIPznsq44TuyIOXWcqMAtPpGKqwFGk1fFvZA2aM9XHGfNT42D677m6lV6jM8kM3l9OVTDnINh
 fOO451mIP0l8WyKaW+EuVztbE43PAAEBVIqXRqsQiuRzbJVm326KtLO7J0PLLTj3uuw1VxlK03C
 rZR/ZgbI3QR45VTrp7t7MaKj7gzNI1eN+dZNUqTrasrnGU1nEXTxbRRZLgn+d5JHMYrlWMyMkxr
 V2Coy/3Ht/bpN0XiaXkN8YGyeuBPIiPyWMPArq2U8I2Nnk47S83CZucoPL8rPDAbsSTEwQc7pf2
 PhlfE9CEhHpVt/IuBLSPAYXLt6KKh4/c/Dt/WIRoP
X-Received: by 2002:a05:620a:4727:b0:93f:5a85:cf9 with SMTP id
 af79cd13be357-93f626db890mr626734385a.7.1792705967248; 
 Thu, 22 Oct 2026 14:52:47 -0700 (PDT)
X-Received: by 2002:a05:620a:4727:b0:93f:5a85:cf9 with SMTP id
 af79cd13be357-93f626db890mr626731085a.7.1792705966760; 
 Thu, 22 Oct 2026 14:52:46 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e38025c72sm511451f8f.18.2026.10.22.14.52.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Oct 2026 14:52:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 12/33] target/i386: Implement and register
 CPUClass::exception_name()
Date: Thu, 22 Oct 2026 23:50:52 +0200
Message-ID: <20261022215115.19680-13-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022215115.19680-1-philmd@oss.qualcomm.com>
References: <20261022215115.19680-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Osv3yeOyrOf6kpA0RdfODQsEX0u91woH
X-Proofpoint-ORIG-GUID: Osv3yeOyrOf6kpA0RdfODQsEX0u91woH
X-Authority-Analysis: v=2.4 cv=dphOmFg4 c=1 sm=1 tr=0 ts=6ada85af cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=Fd9WCTdBRaK1f7vQhjgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX12XDd01+mmZj
 iOKmTKEGjpb35qJgnQmJ7xTze1rvEJhWs6VlUrIqPKZ1+1VXFDMT3Bq8p9L9v6CjXN0S7c94p6P
 bKnDEAmRyGGXSWat78PJvHs7kSTmJWs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX7C1/N2IfEeQG
 HdYHQy2r6sL29wjR0eLuFjHjdLRlqAnSvPFOF1+AUGAU3mSsSJ2w9LaZ4vU2GKYVT/hpq10u7wv
 RUOePBTL8KLFQVgmGuQgndRAbXUkcXdA087I0ZzVSUiKLR+nyvUfdNaBsJN0eCKBErHOeP7lj2E
 QW6IIEZ+76HVriG19LIWW+M004HQDDLWSOIony/Zn13t0VTmairir2netAsctX1qI66rN3feIDY
 taJpnACF8SAkbDuih2sn+TlaFBSfS8h+lrCvbWzmCrm+Gg6kSlX+Cq7/6Cxrd5cKmA0uJgEWmdK
 5ARkhiO0U3jE23u/iDec3pZx4883sLJFGV45yXQb952jdDZMrNjHc6aScf7PxBuJLrto8tBw7r+
 lqNEymIxCg20AIsQonT7v/db3v8HUjobAXVaJHBs+ayU331SQbxO1eq1YDmQskDZ2YXlP7Z1+yz
 G+7JIiYXON3uGF5k0vg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0
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
index 5da80ade70e..e971402deee 100644
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
@@ -10946,6 +10975,7 @@ static void x86_cpu_common_class_init(ObjectClass *oc, const void *data)
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


