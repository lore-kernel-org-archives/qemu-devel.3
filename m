Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D3A606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FepbZUtX;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=h4Br2Dsl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0jb-0002Zn-CV; Thu, 22 Oct 2026 17:54:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0jV-0002RE-RG
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:53:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0jT-0007gh-O2
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:53:57 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MHt0Lf860184
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:53:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BODzv/jcZo4K11FLZy7PcI3KT8rwTrB/RGx2VhuOsmQ=; b=FepbZUtXQMHLrSQY
 SYXKdRNUvGrbNg2gc6TjLFMkUqTe05YIm6Kvnc+qe4OP4Fe9qwPAEjsS98xhPMMn
 rtADKsOfIJAZQSdEmZNuJhQLWYQAadCoqxM5qeYvGT6LjCjlzJsJzb+OvmvUr70q
 IMewnXmtrOeHp42MVmyNrgu3Ep+6iPYMuIhiKXH5KGT3blp6sWTRK/3RogdeRAMy
 FmKVeqQyBUIaiDabHW5O0UDgee4tYsp/Iu1xQRPfZoD/1Cc91xK6u1PXofDAnLye
 qXHSfejg7rf2bgxy3aEB0WttQVpyyOTmNyNZQKCaH6z2nbVqm6hpXtvgYD21TOWi
 qNkOPA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfnq0h9kg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:53:54 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93ecdc701a2so33660185a.3
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792706034; x=1793310834; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BODzv/jcZo4K11FLZy7PcI3KT8rwTrB/RGx2VhuOsmQ=;
 b=h4Br2Dslt37AiFtIMOlMIfDSXfDGOkRf+NoKKBnnk9MT27SKkZ8GpUNKr0bg2wlxK2
 //gdEVRkdwlBsG/LfL4ZaDOXNLYlatJmueJFe4w10WX7QROcSQ/QF1zFmkfIZmaYGaL6
 Ao1EfY2eEq3QAbEopt+77dMolqHwrezseVhPNRUrbuBWxIjdMP/X+isRmb6siNqSFicC
 Tr/vyhqobgZMUnzn2/B5Rm0BVW3pd/2/CTdryaelQXsGHPpW8ny7mCBa3XHb1bGU9Tkh
 tV1G1ZYRTKK9ZO3xC92sxZJ9Bs6aclAwMyIO0KuLWqZA/NKszHLF+ADHZNdzRjfqo+d6
 5GpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792706034; x=1793310834;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BODzv/jcZo4K11FLZy7PcI3KT8rwTrB/RGx2VhuOsmQ=;
 b=qIb0HOr8ioaMfy9tzckIk9eEHRq+OspwtZZqeSD0tlLxUxVCKGYojOsTKJ7pGmeL9A
 KQNRkOEKh8i/TgK7AqJHXhbMBv0IKIxTriGty3zLKaG+exn9fOktz3owswQzcjS/ICIO
 WJzYdtsm0Q2t/sqYcsrsImlARUQBGl9+LsJR4Avh3kAvMZoyP4PC5pXeguqPa7t4J4IS
 /1suKB6FBudFBJL22+jqi9UFLyOFCUgdGaPSiehXWIAgzsVO0yUb4CHsxJu+ak3L+Won
 7hK8OpN5poXMUupYer4dVwxKm8XyFTS04UO8ibg1WfDO3rRjVn6lcuees4ewAa66Deuf
 pTxA==
X-Gm-Message-State: AFq9FYL83kJ1zlj0T+IS2hnXBLSBs9a4d7ZHXbfzXayiG3iVS+E6vajx
 16humP887yDv2Rby52kejlAoLHGyY+gS7oq81DbSVmC42hBAtur8WBOLMij0LQP08ZRhI2a8jg5
 HZ+NeiQV4EU1uXMgs/xerr25As7oa05S/0wKo8T9pfp2hynVjhOu7fj6sdSxqFXRgmQ==
X-Gm-Gg: AYBFou1TlggW7iWMASNp5y1s3EwkaItJi1w06ML/A9IXfQRu5mm/n/hpUa8lmWo3mEw
 x+DXI4yd+JTfdTJCTnXjG9z2Txg4I8hb6fnQerIBUPGJhTmaY/MvMKKoD/zrjaNsEoTxS6tq4i+
 7d9NpuQS+AJB4JDHbafTsOqdaq+186vRANCPZbJ0UxooUNRU9UpqbOCXjCFf9rMa9UIQP4906Ei
 ADra86AHVajYQxqQ/+7OwtEyRbQ4+5heUFltmMxaR4bIvJWv+nYJu3XJ30RMax1r6AF4vWFBlfd
 nS6UNe755S5qvFixYGuCWS7spha77DUtwwV1ygeVEyuExZ4OEI0ioPfH7crHmQVYhk6W2TUJOQ3
 /TS7nCNM5pIUPzZsdL9AS1GJCb2MknTtN+7j1tKya
X-Received: by 2002:a05:620a:2851:b0:939:3fcd:4c3a with SMTP id
 af79cd13be357-93f6f908edemr131453585a.17.1792706033782; 
 Thu, 22 Oct 2026 14:53:53 -0700 (PDT)
X-Received: by 2002:a05:620a:2851:b0:939:3fcd:4c3a with SMTP id
 af79cd13be357-93f6f908edemr131450485a.17.1792706033258; 
 Thu, 22 Oct 2026 14:53:53 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a21047b2absm26241175e9.13.2026.10.22.14.53.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Oct 2026 14:53:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org
Subject: [PATCH v3 21/33] target/ppc: Use a static table in powerpc_excp_name()
Date: Thu, 22 Oct 2026 23:51:01 +0200
Message-ID: <20261022215115.19680-22-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022215115.19680-1-philmd@oss.qualcomm.com>
References: <20261022215115.19680-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: xwuS5T2_jzPs-m73INdh6MC_n7LpwpJa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfXzbGUt9YWJ6Qc
 mNEa61DcZbmhIwJjq5DvoOw0BmvDqto8UuDpDDg6hGfzZVWlzXQIU7wpTIWe0RLt27lhpVuScrd
 FDRcuug7XnhaLvaMs5kRdUc7aUztxHaKQJ1yRIFCRG9bsqCSHDkui2w5mqUQ8/hkBAn+AR+NApD
 +M+fhyqa7gZy7LrsjVHOf4Ws5IROfpi64JRte1g+obwk54Phzi0q+gicGeSM1Qc5s23irdQFDEd
 hr6fDvXWrFHKQN2nNI6b5E1OCmZI/ucpiU+zUOTNDQ3f6Fqt9HopHaxZ786qRWlG6zpUYWfI/29
 42ms7a/WW0kdXlNUQ2QDUUCYQftDZ0cDoIrGMLqKGpq6GK87mNMOA+NeQwMGrBWdabqCz7C2m91
 0nfDnQU6xBzkphLmu2zIlC7WNBcjZEkO7BZXY94OZ1JZFr+x3EwDYzMJWPpORW1m7oQTfNLGLSi
 ivPoDpCaeUUY9qeVH5Q==
X-Proofpoint-GUID: xwuS5T2_jzPs-m73INdh6MC_n7LpwpJa
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX6vjDX0yIYlDW
 R3yx3TwBt/VhvkY92UEu8uqxM+eJQopEOksO3W1zIDXxhCjA/p1+mjIEH1yV7Ealjp78OeQK3ud
 NcodZ9XhXTtlMO6BMfy6jFzPi6K7qJM=
X-Authority-Analysis: v=2.4 cv=UaHE26SN c=1 sm=1 tr=0 ts=6ada85f2 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=ToDOQhdInOzr0WCV1tUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
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
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace the switch statement with a static lookup table.

Unlisted exception codes now return "unknown" instead of reaching
g_assert_not_reached(), so with '-d int' they are logged instead
of aborting QEMU. Do this before registering the function as the
CPUClass::exception_name() handler, which must accept any code.

Suggested-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/ppc/excp_helper.c | 137 ++++++++++++++++++++-------------------
 1 file changed, 69 insertions(+), 68 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 895127fb2e6..4892cbaeb07 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -19,6 +19,7 @@
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
 #include "qemu/log.h"
+#include "qemu/cutils.h"
 #include "system/memory.h"
 #include "system/tcg.h"
 #include "system/system.h"
@@ -37,74 +38,74 @@
 
 static const char *powerpc_excp_name(int excp)
 {
-    switch (excp) {
-    case POWERPC_EXCP_CRITICAL: return "CRITICAL";
-    case POWERPC_EXCP_MCHECK:   return "MCHECK";
-    case POWERPC_EXCP_DSI:      return "DSI";
-    case POWERPC_EXCP_ISI:      return "ISI";
-    case POWERPC_EXCP_EXTERNAL: return "EXTERNAL";
-    case POWERPC_EXCP_ALIGN:    return "ALIGN";
-    case POWERPC_EXCP_PROGRAM:  return "PROGRAM";
-    case POWERPC_EXCP_FPU:      return "FPU";
-    case POWERPC_EXCP_SYSCALL:  return "SYSCALL";
-    case POWERPC_EXCP_APU:      return "APU";
-    case POWERPC_EXCP_DECR:     return "DECR";
-    case POWERPC_EXCP_FIT:      return "FIT";
-    case POWERPC_EXCP_WDT:      return "WDT";
-    case POWERPC_EXCP_DTLB:     return "DTLB";
-    case POWERPC_EXCP_ITLB:     return "ITLB";
-    case POWERPC_EXCP_DEBUG:    return "DEBUG";
-    case POWERPC_EXCP_SPEU:     return "SPEU";
-    case POWERPC_EXCP_EFPDI:    return "EFPDI";
-    case POWERPC_EXCP_EFPRI:    return "EFPRI";
-    case POWERPC_EXCP_EPERFM:   return "EPERFM";
-    case POWERPC_EXCP_DOORI:    return "DOORI";
-    case POWERPC_EXCP_DOORCI:   return "DOORCI";
-    case POWERPC_EXCP_GDOORI:   return "GDOORI";
-    case POWERPC_EXCP_GDOORCI:  return "GDOORCI";
-    case POWERPC_EXCP_HYPPRIV:  return "HYPPRIV";
-    case POWERPC_EXCP_RESET:    return "RESET";
-    case POWERPC_EXCP_DSEG:     return "DSEG";
-    case POWERPC_EXCP_ISEG:     return "ISEG";
-    case POWERPC_EXCP_HDECR:    return "HDECR";
-    case POWERPC_EXCP_TRACE:    return "TRACE";
-    case POWERPC_EXCP_HDSI:     return "HDSI";
-    case POWERPC_EXCP_HISI:     return "HISI";
-    case POWERPC_EXCP_HDSEG:    return "HDSEG";
-    case POWERPC_EXCP_HISEG:    return "HISEG";
-    case POWERPC_EXCP_VPU:      return "VPU";
-    case POWERPC_EXCP_PIT:      return "PIT";
-    case POWERPC_EXCP_EMUL:     return "EMUL";
-    case POWERPC_EXCP_IFTLB:    return "IFTLB";
-    case POWERPC_EXCP_DLTLB:    return "DLTLB";
-    case POWERPC_EXCP_DSTLB:    return "DSTLB";
-    case POWERPC_EXCP_FPA:      return "FPA";
-    case POWERPC_EXCP_DABR:     return "DABR";
-    case POWERPC_EXCP_IABR:     return "IABR";
-    case POWERPC_EXCP_SMI:      return "SMI";
-    case POWERPC_EXCP_PERFM:    return "PERFM";
-    case POWERPC_EXCP_THERM:    return "THERM";
-    case POWERPC_EXCP_VPUA:     return "VPUA";
-    case POWERPC_EXCP_SOFTP:    return "SOFTP";
-    case POWERPC_EXCP_MAINT:    return "MAINT";
-    case POWERPC_EXCP_MEXTBR:   return "MEXTBR";
-    case POWERPC_EXCP_NMEXTBR:  return "NMEXTBR";
-    case POWERPC_EXCP_ITLBE:    return "ITLBE";
-    case POWERPC_EXCP_DTLBE:    return "DTLBE";
-    case POWERPC_EXCP_VSXU:     return "VSXU";
-    case POWERPC_EXCP_FU:       return "FU";
-    case POWERPC_EXCP_HV_EMU:   return "HV_EMU";
-    case POWERPC_EXCP_HV_MAINT: return "HV_MAINT";
-    case POWERPC_EXCP_HV_FU:    return "HV_FU";
-    case POWERPC_EXCP_SDOOR:    return "SDOOR";
-    case POWERPC_EXCP_SDOOR_HV: return "SDOOR_HV";
-    case POWERPC_EXCP_HVIRT:    return "HVIRT";
-    case POWERPC_EXCP_SYSCALL_VECTORED: return "SYSCALL_VECTORED";
-    case POWERPC_EXCP_PERFM_EBB: return "PERFM_EBB";
-    case POWERPC_EXCP_EXTERNAL_EBB: return "EXTERNAL_EBB";
-    default:
-        g_assert_not_reached();
-    }
+    static const char * const excp_names[POWERPC_EXCP_NB] = {
+        [POWERPC_EXCP_CRITICAL] = "CRITICAL",
+        [POWERPC_EXCP_MCHECK]   = "MCHECK",
+        [POWERPC_EXCP_DSI]      = "DSI",
+        [POWERPC_EXCP_ISI]      = "ISI",
+        [POWERPC_EXCP_EXTERNAL] = "EXTERNAL",
+        [POWERPC_EXCP_ALIGN]    = "ALIGN",
+        [POWERPC_EXCP_PROGRAM]  = "PROGRAM",
+        [POWERPC_EXCP_FPU]      = "FPU",
+        [POWERPC_EXCP_SYSCALL]  = "SYSCALL",
+        [POWERPC_EXCP_APU]      = "APU",
+        [POWERPC_EXCP_DECR]     = "DECR",
+        [POWERPC_EXCP_FIT]      = "FIT",
+        [POWERPC_EXCP_WDT]      = "WDT",
+        [POWERPC_EXCP_DTLB]     = "DTLB",
+        [POWERPC_EXCP_ITLB]     = "ITLB",
+        [POWERPC_EXCP_DEBUG]    = "DEBUG",
+        [POWERPC_EXCP_SPEU]     = "SPEU",
+        [POWERPC_EXCP_EFPDI]    = "EFPDI",
+        [POWERPC_EXCP_EFPRI]    = "EFPRI",
+        [POWERPC_EXCP_EPERFM]   = "EPERFM",
+        [POWERPC_EXCP_DOORI]    = "DOORI",
+        [POWERPC_EXCP_DOORCI]   = "DOORCI",
+        [POWERPC_EXCP_GDOORI]   = "GDOORI",
+        [POWERPC_EXCP_GDOORCI]  = "GDOORCI",
+        [POWERPC_EXCP_HYPPRIV]  = "HYPPRIV",
+        [POWERPC_EXCP_RESET]    = "RESET",
+        [POWERPC_EXCP_DSEG]     = "DSEG",
+        [POWERPC_EXCP_ISEG]     = "ISEG",
+        [POWERPC_EXCP_HDECR]    = "HDECR",
+        [POWERPC_EXCP_TRACE]    = "TRACE",
+        [POWERPC_EXCP_HDSI]     = "HDSI",
+        [POWERPC_EXCP_HISI]     = "HISI",
+        [POWERPC_EXCP_HDSEG]    = "HDSEG",
+        [POWERPC_EXCP_HISEG]    = "HISEG",
+        [POWERPC_EXCP_VPU]      = "VPU",
+        [POWERPC_EXCP_PIT]      = "PIT",
+        [POWERPC_EXCP_EMUL]     = "EMUL",
+        [POWERPC_EXCP_IFTLB]    = "IFTLB",
+        [POWERPC_EXCP_DLTLB]    = "DLTLB",
+        [POWERPC_EXCP_DSTLB]    = "DSTLB",
+        [POWERPC_EXCP_FPA]      = "FPA",
+        [POWERPC_EXCP_DABR]     = "DABR",
+        [POWERPC_EXCP_IABR]     = "IABR",
+        [POWERPC_EXCP_SMI]      = "SMI",
+        [POWERPC_EXCP_PERFM]    = "PERFM",
+        [POWERPC_EXCP_THERM]    = "THERM",
+        [POWERPC_EXCP_VPUA]     = "VPUA",
+        [POWERPC_EXCP_SOFTP]    = "SOFTP",
+        [POWERPC_EXCP_MAINT]    = "MAINT",
+        [POWERPC_EXCP_MEXTBR]   = "MEXTBR",
+        [POWERPC_EXCP_NMEXTBR]  = "NMEXTBR",
+        [POWERPC_EXCP_ITLBE]    = "ITLBE",
+        [POWERPC_EXCP_DTLBE]    = "DTLBE",
+        [POWERPC_EXCP_VSXU]     = "VSXU",
+        [POWERPC_EXCP_FU]       = "FU",
+        [POWERPC_EXCP_HV_EMU]   = "HV_EMU",
+        [POWERPC_EXCP_HV_MAINT] = "HV_MAINT",
+        [POWERPC_EXCP_HV_FU]    = "HV_FU",
+        [POWERPC_EXCP_SDOOR]    = "SDOOR",
+        [POWERPC_EXCP_SDOOR_HV] = "SDOOR_HV",
+        [POWERPC_EXCP_HVIRT]    = "HVIRT",
+        [POWERPC_EXCP_SYSCALL_VECTORED] = "SYSCALL_VECTORED",
+        [POWERPC_EXCP_PERFM_EBB]        = "PERFM_EBB",
+        [POWERPC_EXCP_EXTERNAL_EBB]     = "EXTERNAL_EBB",
+    };
+
+    return STR_ARRAY_ELEM_OR_NULL(excp_names, excp) ?: "unknown";
 }
 
 static void dump_syscall(CPUPPCState *env)
-- 
2.55.0


