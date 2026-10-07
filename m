Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B5C1CA6007
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:50:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEOHE-0001v0-7w; Wed, 07 Oct 2026 05:49:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEOEG-0007vx-I1
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 05:46:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEOEE-0000Z7-AO
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 05:46:27 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6977jeLv3334684
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 09:46:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XlsMhz1Ps+iY9VkTYFoUNMlDQESnDlY0XcqkOTADSVs=; b=Geg/8+G7G1Ns+7i4
 Mg8Gww33OmvOiaqQ617jdNHQ01Wwnka1Eg/R7Pcp3C3AM6Apoiltsv5/3o6Ct3xD
 4Vhd+m9ojcMxOj4VpgF4bQ7MYAWtup23EMAHuej2gTIJCs4/wxBnAnBkoOEm0aWT
 jrZwdIyba/8fnNz/lX8vmTPu6vXos8eUCKBixFwjvvnFBuPQeCyIIsmAvbGWP6Cy
 JXaLOJeYfbwulq+DBq32d+wfj+akA+SIzuVq3liKunR8XiNtX6DBX0lljCmttNh3
 eEpb/Z465pDcWTxp7H4J7j9mzv9tdnTadnw3qJdkf72y/B1MeQ4mvcVkLTfjOJrB
 OHWBOQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h54623fve-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 09:46:24 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93cc5f70c8dso427156585a.3
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 02:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791366384; x=1791971184; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XlsMhz1Ps+iY9VkTYFoUNMlDQESnDlY0XcqkOTADSVs=;
 b=Dd4YhRaopoYKTOhln3eazfW66sk/YL0WpNqvtUcD6Ib/8xzQZciL92zns3vnBqBWqB
 cBoPtRfzNPeEFrlujfLjfnI7FqDxQdoylWUCNb+JgTngqc3URtPe/1AQImi7Fwg9aCVl
 CE6SZjAXML45xOkBLDOyahPdQmE/bmLIBuqSq9F5XhRWd9bubZjELgERgABBoPPXMF3R
 cHDbB0YnJPxN67t6E4KMBM46IwWDpZDsUJygeB3ftD8s8FfgnIcjlRR6mwf3Pot+msTR
 NAoUvNILgpP/htrXpIzEgF0KWVoj8nf1wuc82+8ZNeCJgUc105FpDoiAzWeVAENqCb/S
 qWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791366384; x=1791971184;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XlsMhz1Ps+iY9VkTYFoUNMlDQESnDlY0XcqkOTADSVs=;
 b=1QLU+3f3h7hVldbpukRmUtWm5Yk6U9IPj+eHinKe8OxP9XLMDxn4HqqMNlEYzWjyjo
 h4l1s26cB9v3OSP8lnHBT1/4Dd/JEend/W3ZO+84j/hTkbcYGtqVfzj4C0mJ6+amlUJ3
 v6Q68H47siSSCYfk11xUGv8C+iS0Ufvs3Ql9eU3+b4/LBjwTqqOp2RfzznlGec9mF61I
 iw1RVqTsuWHxnbCpP8xQNzQJPN5FbakmB/7k+ikTqyjYO+P+VB4eLcLwqahAF8tXAl3Z
 8BoBn1P84ju4cSqzyKUfcJyZ0RN2oEJd3wh3BXyZDRKYPaM/I6zc8Fkrv8DYagoHbPGG
 HV2Q==
X-Gm-Message-State: AFuF++lD/X4SQm4ZUNAZ2zGvqhGRZkogryPorzzMPcoqIY+SPBEDlsKN
 aw7wGsVe6sI+7CFBwxSpj+te9j+aikfzP/HviXaFIvYp0AqMAghpRkvViqL5aj4eKvDUY4KfRT5
 ftNncZXisD0OSbLegqBVmjSVW2Rh98BZejV0B57q6d/F+CQ2n10JcNPyfm1SEBVVa/TIF
X-Gm-Gg: AYBFou0cAUbzTKvfZgrmEqfE5gIFwdL1XZWjM7GbAq7RNhfOVGDaXf2I80WFp/FlEkx
 3Ycdz/LyJ4x4jx84eGeNCOGDoasvNritkC9f/EzmwlDKfR6GVkrzIZEYGpvUsRW1V4Koq1OrQBL
 eRZa2xPiGpQO0KWkx4SaxR/MYDs3xzi8keScsgscqxlCZ0HmbQNG1mrObja3S2VTEshBl3gehbV
 B6ZMRxNhrZFEyU9gvwDipcsTabNyWb2adXeR3DwXXTug0OaDWMn9md1kPbL98FbBV05ltEM7mHM
 t64h7CLG7U/+zt16BGwJpIFKdP8S8oc8kvownvdMsuQ7JQJxOzntpn6KdlxW9N7yD3Q9zpqkvFX
 zvGC/I7Yd6cZRFq1stSWioasY8CnXuSe5CjHXaD67
X-Received: by 2002:a05:620a:1726:b0:93e:56f2:5364 with SMTP id
 af79cd13be357-93e9b2ecedamr311916985a.8.1791366383788; 
 Wed, 07 Oct 2026 02:46:23 -0700 (PDT)
X-Received: by 2002:a05:620a:1726:b0:93e:56f2:5364 with SMTP id
 af79cd13be357-93e9b2ecedamr311912885a.8.1791366383265; 
 Wed, 07 Oct 2026 02:46:23 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a181aeaea2sm27539425e9.5.2026.10.07.02.46.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Oct 2026 02:46:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 09/27] target/i386: Implement and register
 CPUClass::exception_name()
Date: Wed,  7 Oct 2026 11:44:57 +0200
Message-ID: <20261007094516.75732-10-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007094516.75732-1-philmd@oss.qualcomm.com>
References: <20261007094516.75732-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ksEP56CmVkC5kYMfra6obEVrnLadyRbC
X-Authority-Analysis: v=2.4 cv=ZZiIpcVA c=1 sm=1 tr=0 ts=6ac614f0 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=v-QDjpm2zyCjAj2l2PQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAzOCBTYWx0ZWRfXzzJmXCfTcO+O
 nLTEZ9yqpa5+Ou0C0uk2E37FgiScQbFPN56noGGOTWdc7ofxfcnLuPGXw/+00aD/zNXzNQD5nM/
 ecQ+oGozjRXOg7ldBAUwrDhoGm3uI8g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAzOCBTYWx0ZWRfXz2rcjedeolQn
 de1rF1iYJLlgKCboVeoRBIy7tL7Wy34MBsCiUne3TYd04xddKBy7KyG1gaN2C/afvgyhfwopqB8
 Y2vc710iq64tstjVTKFXR0Mip+8MrJP8/Gi2c6nrjcDFTgYfnATdVJnCFF23tJIUWS2stj2ffUN
 pb5IL8HCB0Zfr+XKsKFJEsSc7isQ/rjgZ1A7huzk5WzErYCimL14otSjkB4PriCfGKpuk64r+l9
 As/hQI4/AxkyQXaHmDUhKy7we5r9fwAGJt37L0Ys8tv7dXidxEGXvSyYijTbFjkHwc/FEeE2/Qb
 pyeDw+6S/bPdC5UNUaJbO1Ke0pDvz+TcKd9ExPQzqEO2K3ueV9VG9EUGFHX79nN+u9jjue21+PK
 1Sx9vHmA+QBvMcUT1eZXuvyCV7Hk99LTBmU3UR8LhxNIQ4vLROQko2nOADvUgFLA1JeaphsZgrk
 uUuFIkJm5DLHF7sPHrw==
X-Proofpoint-ORIG-GUID: ksEP56CmVkC5kYMfra6obEVrnLadyRbC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 adultscore=0
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

Implement x86_exception_name() and register it as
the CPUClass::exception_name() handler, so the common
exception logging can resolve X86 exception codes to names.

Use the new helper in check_exception() and do_interrupt_all().

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/i386/cpu.h             |  2 ++
 target/i386/cpu.c             | 33 +++++++++++++++++++++++++++++++++
 target/i386/tcg/excp_helper.c |  5 +++--
 target/i386/tcg/seg_helper.c  |  6 ++++--
 4 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 786957fadd0..4f5e4f56acc 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1515,6 +1515,8 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define EXCP_SYSCALL    0x101 /* only for user emulation */
 #define EXCP_VSYSCALL   0x102 /* only for user emulation */
 
+const char *x86_exception_name(int excp);
+
 /* i386-specific interrupt pending bits.  */
 #define CPU_INTERRUPT_POLL      CPU_INTERRUPT_TGT_EXT_1
 #define CPU_INTERRUPT_SMI       CPU_INTERRUPT_TGT_EXT_2
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index f3bc6911c10..885fd0ded16 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -9371,6 +9371,38 @@ static bool cpuid_has_xsave_feature(CPUX86State *env, const ExtSaveArea *esa)
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
+    if (excp < 0 || excp >= ARRAY_SIZE(excp_names) || !excp_names[excp]) {
+        return "unknown";
+    }
+    return excp_names[excp];
+}
+
 static void x86_cpu_reset_hold(Object *obj, ResetType type)
 {
     CPUState *cs = CPU(obj);
@@ -10921,6 +10953,7 @@ static void x86_cpu_common_class_init(ObjectClass *oc, const void *data)
     cc->reset_dump_flags = CPU_DUMP_FPU | CPU_DUMP_CCOP;
 
     cc->class_by_name = x86_cpu_class_by_name;
+    cc->exception_name = x86_exception_name;
     cc->list_cpus = x86_cpu_list;
     cc->parse_features = x86_cpu_parse_featurestr;
     cc->dump_state = x86_cpu_dump_state;
diff --git a/target/i386/tcg/excp_helper.c b/target/i386/tcg/excp_helper.c
index 1eaa602c91d..34776de6a50 100644
--- a/target/i386/tcg/excp_helper.c
+++ b/target/i386/tcg/excp_helper.c
@@ -51,8 +51,9 @@ static int check_exception(CPUX86State *env, int intno, int *error_code,
     int second_contributory = intno == 0 ||
                                (intno >= 10 && intno <= 13);
 
-    qemu_log_mask(CPU_LOG_INT, "check_exception old: 0x%x new 0x%x\n",
-                env->old_exception, intno);
+    qemu_log_mask(CPU_LOG_INT, "check_exception old: 0x%x (%s) new 0x%x (%s)\n",
+                env->old_exception, x86_exception_name(env->old_exception),
+                intno, x86_exception_name(intno));
 
 #if !defined(CONFIG_USER_ONLY)
     if (env->old_exception == EXCP08_DBLE) {
diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index 138d2384b18..494898e5caa 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -1208,9 +1208,11 @@ void do_interrupt_all(X86CPU *cpu, int intno, int is_int,
         if ((env->cr[0] & CR0_PE_MASK)) {
             static int count;
 
-            qemu_log("%6d: v=%02x e=%04x i=%d cpl=%d IP=%04x:" TARGET_FMT_lx
+            qemu_log("%6d: v=%02x (%s) e=%04x i=%d"
+                     " cpl=%d IP=%04x:" TARGET_FMT_lx
                      " pc=" TARGET_FMT_lx " SP=%04x:" TARGET_FMT_lx,
-                     count, intno, error_code, is_int,
+                     count, intno, x86_exception_name(intno),
+                     error_code, is_int,
                      env->hflags & HF_CPL_MASK,
                      env->segs[R_CS].selector, env->eip,
                      (int)env->segs[R_CS].base + env->eip,
-- 
2.55.0


