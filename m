Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF125606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pt7efJTZ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Z1j5PCNA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKI00-00084S-Ab; Fri, 23 Oct 2026 12:20:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHzW-0007Rz-CQ
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:19:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHzS-0002ff-D2
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:19:36 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE6Dno2462566
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:19:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nlXX0rf5CQ1pxteRHWpFuXwp2h8i7GjWHY2M8nDV7Kc=; b=pt7efJTZ/jG3vbL2
 X1cnLmaOXTBjoZjVujjMIpspq5fr+L9XRY9GJEupTRd1+d4KZVSzSZKIFHoNcDBW
 NCGWaC6meTlv53fr/abP6T9stK/1wO4VF0kMf2kzoOKC+/kIc7nW7M9oRDUTbv5M
 c0l4llPvNaF8Q1AioFKuXG513XzbV9g1XWSMU7YOZ0pr7+KrGzEnhKF34vCYWTUe
 Si6qEyTfj2bBX8ZdeCkM32sMeXWSiyGwrj5KGLzvaZTgBQGpXIPvIU0O9JVMSK2M
 9XEYlCx2LqChpgjQ13ZfyTFcncET01/8GtZQL0eb/OkvoaGwNUWfKfpa/g9J+S8U
 BBYlYw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmtvjff-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:19:30 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93909014c85so209681585a.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772369; x=1793377169; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nlXX0rf5CQ1pxteRHWpFuXwp2h8i7GjWHY2M8nDV7Kc=;
 b=Z1j5PCNANu5yfSKIzhz9Z/yDzok4Zv/gLDyNQeZatL/KPUOzb8ew8eeBkz+OCuP2pS
 S4NhOe72DwkUQmzs9YtWw7e2zr27BH3T67D9zFfBl2m4nBp/6zgmzVXAQLt5TiKGRFKn
 gbzu+XOUl6vjwAlO/G5FW4mEoaOeEqqSjvwfux5jyRMIe3nGqA//A/QJTRDhTDIfC5UR
 MvMzUJha4IQV06TsY2uNblIKDLpGJuF3jt1AKFErLLSQ1s7NWWuPEET1XpPQfZpEVIkG
 HY5/WwKDl+tbSKaai0s4iY6rvQDnvNin5aqvGIXtjXMgisF2mrrFB/IEIp7pM61lAVV+
 gJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772369; x=1793377169;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nlXX0rf5CQ1pxteRHWpFuXwp2h8i7GjWHY2M8nDV7Kc=;
 b=UiCTjUlPBjH3QZRotNyRgOgfrBM6+TYyvOJuCv0dkmu39hXKXy3F1GXFU+MxvU9IIF
 13wub4SHd74mWRwpwecUN8LkydKSRZpCR5jmUi7IdVvjx4724lHG0OiNfAC2B2I//zLL
 YJe47Yhr3vTSuMAS4X+reuwKJ/BX+TZeVo0Z4YnQGFdvNnNOw1S08BvfygKmUtqgJLiJ
 dxMRo/7odB/xb6dIQDRJj6hMMr9Z5yHXarSdrYrhtyLd7dJtsWZTngW8OAbflUaeXn/y
 31Xb3vjSJdrOPEAkujw0oEmClKNqQiiuisd8AVox5HiKiPRGMl5UdfojRlQJf5dzDdfQ
 6TAw==
X-Gm-Message-State: AFq9FYJzNEZ1ESO9PvVkWPlUj8Q7TB0JJcn5qywwtVxQBPSJjg9EVAtJ
 88MF6aQ9RA353IB+xpsl0QzYRRwEHlyK1HmCHJlVEXTHS6LN/tRTGDHR2gBqVyH+nCuAI1ZArhR
 ITlW5WeWz9XdtOQivnIVGi8sRRRVc5867UHtOQGmrQM7AwY1SlodoUe1hUBthTKLxxQKj
X-Gm-Gg: AYBFou37DvC4CWCplAPetIAPvwyNdpsv2eyVwlaKlacMSpfNpxpBA9HHgmZ5GNvg60O
 FDf76Flhoo88zhw55tPnVOXwNd83U+O7ntK7jUuqdLHHIFMOI9b+Tz2n3pTELQVkjfgE7R3rq3O
 BfFJlQG3zzKGBIjkjaRLTZiXexrXp69JKTBXIqUl/v8B+NTWDpoXvX7pl4G6A8Ew7N4BXeiLxaA
 GFcIKp4lVcr4I5chhejNjdKAofsEN9XOI6nuGIAGrSHyRvL9zAKlAC2Hfc/ZUDOlNQhWyqUqvmU
 GkJxQXVZt51dkDTFSodvhHeh8OH6d7d1bn5tIsHT2SOSp0kCxp8UFNjQwb4VQ4aWWZBWcGmTtmd
 +hmzmZPASEtghn+u9Fc+hmAcWYRrD7VeQQuozo+LD
X-Received: by 2002:a05:620a:370b:b0:93e:4e27:359b with SMTP id
 af79cd13be357-93f6f7880e0mr495657385a.24.1792772369469; 
 Fri, 23 Oct 2026 09:19:29 -0700 (PDT)
X-Received: by 2002:a05:620a:370b:b0:93e:4e27:359b with SMTP id
 af79cd13be357-93f6f7880e0mr495652185a.24.1792772368909; 
 Fri, 23 Oct 2026 09:19:28 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d3ee71dsm1037768f8f.16.2026.10.23.09.19.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:19:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 49/83] target/sh4: Use a static table in sh4_exception_name()
Date: Fri, 23 Oct 2026 18:12:57 +0200
Message-ID: <20261023161332.60153-50-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Gt3XaU1C c=1 sm=1 tr=0 ts=6adb8912 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=FjqC8H2jZU1ohCHi5yYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: 3S9TcjQEZgSUiNM5-NJYIC9uI-mlsTsT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX1jmzgT1IQ5Dl
 Q8TFeSzdh98K88WDu6BEFN3tJRBb6n4NhTG1RGm1YDcACC2ax4J2cQ4IKQBRNmONMm5RAGyQhZa
 tpmnhF6M40OZog/EDet3VdlmuTuiTGIR1/EgAka5HxTYIUqqrccOvOiP62V5VO5lIcsiHzL+QyY
 1FU9Q3yAmcMVfgBy28Qoo5dWn4jMTjoSSw9im023EtqXJNugOohbFkHqeqcrcbwfj+d0LHDgYW0
 caQCDoYB2wS/CvpJ1tt2ycFiRomVO+pkutYuvTBbSgk9cyYmoTdz3AH6GWfh4t9qc8lhwVg31Cm
 toY56XgJucMw6hHOB5NVdXyYpRrB+dAinba0/1g68ZRnoCr4mupSv5zmMYjnDG0IomVOrm/z2b9
 dVQAt1ZN8fEsih+o69fGLOCwm4qTgtL0EREGPWgKjd8OwJYG8WC0pvAL3vfv2WSeDGLvBV8SLVC
 O/FGpdJTfVt+gpGt8Vg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX2kaWsuv1C8kc
 Nt6xrKa+TDmcIYJa+BkwB0O1pEk2BWsvkyFffu5qy4bcZUpaRb8OstNi9UbKG/2P2bmn3eF0Ayg
 S/vbRcr933LKNPGm0ouSIoquk9U56B4=
X-Proofpoint-ORIG-GUID: 3S9TcjQEZgSUiNM5-NJYIC9uI-mlsTsT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230063
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

Replace the switch statement with a static lookup table.

With '-d int', unlisted exception codes are now logged as
"unknown" instead of "???".

Suggested-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20261022215115.19680-31-philmd@oss.qualcomm.com>
---
 target/sh4/helper.c | 66 ++++++++++++++-------------------------------
 1 file changed, 20 insertions(+), 46 deletions(-)

diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index 5856bab6983..96465dd94fb 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 
 #include "cpu.h"
 #include "exec/cputlb.h"
@@ -49,54 +50,27 @@
 
 const char *sh4_exception_name(int excp)
 {
-    const char *name;
+    /* Exception codes (EXPEVT) are multiples of 0x20 */
+    static const char * const excp_names[] = {
+        [SH4_EXCP_ADDR_ERROR >> 5]               = "addr_error",
+        [SH4_EXCP_TLB_MISS >> 5]                 = "tlb_miss",
+        [SH4_EXCP_TLB_VIOLATION >> 5]            = "tlb_violation",
+        [SH4_EXCP_ILLEGAL_INSTRUCTION >> 5]      = "illegal_instruction",
+        [SH4_EXCP_SLOT_ILLEGAL_INSTRUCTION >> 5] = "slot_illegal_instruction",
+        [SH4_EXCP_FPU_DISABLE >> 5]              = "fpu_disable",
+        [SH4_EXCP_SLOT_FPU_DISABLE >> 5]         = "slot_fpu",
+        [SH4_EXCP_DATA_WRITE >> 5]               = "data_write",
+        [SH4_EXCP_DTLB_MISS_WRITE >> 5]          = "dtlb_miss_write",
+        [SH4_EXCP_DTLB_VIOLATION_WRITE >> 5]     = "dtlb_violation_write",
+        [SH4_EXCP_FPU >> 5]                      = "fpu_exception",
+        [SH4_EXCP_INITIAL_PAGE_WRITE >> 5]       = "initial_page_write",
+        [SH4_EXCP_TRAPA >> 5]                    = "trapa",
+    };
 
-    switch (excp) {
-    case SH4_EXCP_ADDR_ERROR:
-        name = "addr_error";
-        break;
-    case SH4_EXCP_TLB_MISS:
-        name = "tlb_miss";
-        break;
-    case SH4_EXCP_TLB_VIOLATION:
-        name = "tlb_violation";
-        break;
-    case SH4_EXCP_ILLEGAL_INSTRUCTION:
-        name = "illegal_instruction";
-        break;
-    case SH4_EXCP_SLOT_ILLEGAL_INSTRUCTION:
-        name = "slot_illegal_instruction";
-        break;
-    case SH4_EXCP_FPU_DISABLE:
-        name = "fpu_disable";
-        break;
-    case SH4_EXCP_SLOT_FPU_DISABLE:
-        name = "slot_fpu";
-        break;
-    case SH4_EXCP_DATA_WRITE:
-        name = "data_write";
-        break;
-    case SH4_EXCP_DTLB_MISS_WRITE:
-        name = "dtlb_miss_write";
-        break;
-    case SH4_EXCP_DTLB_VIOLATION_WRITE:
-        name = "dtlb_violation_write";
-        break;
-    case SH4_EXCP_FPU:
-        name = "fpu_exception";
-        break;
-    case SH4_EXCP_INITIAL_PAGE_WRITE:
-        name = "initial_page_write";
-        break;
-    case SH4_EXCP_TRAPA:
-        name = "trapa";
-        break;
-    default:
-        name = "???";
-        break;
+    if (excp & 0x1f) {
+        return "unknown";
     }
-
-    return name;
+    return STR_ARRAY_ELEM_OR_NULL(excp_names, excp >> 5) ?: "unknown";
 }
 
 #if defined(CONFIG_USER_ONLY)
-- 
2.55.0


