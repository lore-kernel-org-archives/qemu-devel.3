Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2459606A324
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RXCpxVUk;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Zt5Avs24
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHyx-0006Jn-KO; Fri, 23 Oct 2026 12:19:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHyQ-00054q-W8
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:18:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHyN-0002b8-E4
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:18:28 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NG2p2r3228243
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:18:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DhLxB7MEJOaltEhJwCEIexGsl9KAJr8R9xhlHNbSuwo=; b=RXCpxVUkOFNtBvzX
 tQBSoi6CRKHIsQixhG1haa/07CdownfieX73vG7Tdd4c8vvfiqjT6ceauzTyQaiN
 TRZ9vdIQ6LOry4e9STLZoahrqWDbcuCG6ZW+uzJ3B3h7q87IjY5sFeS9qdwoeeJz
 BzvWJ42ukf0ZzuS5VLvlfm4VtLQT/PPAZ9isiREnLdWDpFb0SgJxepEAlCHxYf4J
 GVmeL8WieoPkGW/ZRMhpnIWKwCq+O0v+WA6KUxlAMl9Bw4h9sIHY4aGn6xl8e0DD
 nukW/0jAvie48OmQqH0TerfZwX1JaUGlcL8/fyz7ihDHqVa4jkn6WIFJa3J75QXK
 bLFteg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgart0233-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:18:25 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93cb71b1443so218332485a.2
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772305; x=1793377105; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DhLxB7MEJOaltEhJwCEIexGsl9KAJr8R9xhlHNbSuwo=;
 b=Zt5Avs24icWFhP6QosdCTs/tBGNzikO82soUqbEzVgPFlDFhU8F/SF54xSTn4TTu/Y
 9VXpiJ9+M5+NY3Z4s0Wxy+9QdbcNod69PxtXREtOY3EJvwF4t0JLGFo7P0R7oDuQQAJY
 sJ52EdfKbBCFBY7Se1X1qTarEIn/QAM4QLVBDIdaST1BVv6UhdJ0xIOgz9zLSlRgyfOt
 ScSHgNqGKvKKzUPn5i/o4Ty7i/3978zGsAf9rFpks6GOAzNivN50K2rzN/QZjxGusq1E
 UZXHl1U4GI4G+OMkRAlWbgjUHnI4TamVa71tLz2/IIucJHqA4ekTfStkw6QUzeOJCuE2
 pKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772305; x=1793377105;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DhLxB7MEJOaltEhJwCEIexGsl9KAJr8R9xhlHNbSuwo=;
 b=pSfWNqPoW3IbQmJB8pe94OtIaZUVhMkV7eLZ4kVVTars4eSrKGFfXsTwtq8Xzn4afi
 g3CijCzMwVqrYIBD8Z6M+zU/ua2scS5V9GD2Ir8GU2jIZKsDaKnxxoYtQZ1e7MFGOL2d
 vDgEd1L4DPXX0dnImwkVevSmrCLc4zFp+IQegE3y3AAfR/Jume8SJZHqQrKjMmcoZy9U
 0ERrXJyDaEBGUSRrgazjw4ZZUPmiMS8k5FgoLrhsrgJyDGaDxH0zngBdi4LG12XWZhES
 8oEYTQr5KhkdixTAaCYlzQZMXwhOI2NTRdRNqVeY/MI0+V+I3zGXGR451IHGWtwRn0ye
 amaQ==
X-Gm-Message-State: AFq9FYJAhk3sYUE0lYWJrfWV16TwWzbC5ifzQOWtVVUoKtHDhbVyUL2o
 vgHu1dNPqp37cFHQA36v/yGqhoHIQXJeCscoL5Gd+6R3eyZJihaSPXocl4Rl8sHg3x3tIzIQLl+
 jFWPBAUwM4odmrQuQ43JNcBeHfo8+C/jv2pnzZ5Ep5YI3o36uqiu/z53nX/B0Qwa6AIcC
X-Gm-Gg: AYBFou1/ctMgaFJNXIOoBxSiiMRY9u8rD9lnr958c3inmw4yv8l00G9rfZLj4dL8/T/
 rSp1Yqp8db9RgAFBzqD90Y1qFr+55HzWRbxlzlWw3NVefJkpivrpuGzbiqJNj2KLeToQLBd2HRb
 RopjJC+R5iS/IZygGFrZF49eP9doTDP5oOGMeQIqRSBk/gQsarYZ3hedv1ZV/iUO5qptYKmOMha
 hqacW/DnVTtNKPNgKw84EmEyS4rWXH82zDlLa0/0PGzDnk8A6NnKFBYxNlffrtUrsyP8d+Yx8oK
 f9cKAsTNxMurXQMmqqNDMG1zD+PtP1jzYAv3ysuhIKhaMxPMua6vsNN/jzNbgKCaFL68ALJmp8P
 I4g6opiROI6/IDXBo5LtdT0M0RTYWSa/1qbM65vSS
X-Received: by 2002:a05:620a:2628:b0:93c:b47b:26f with SMTP id
 af79cd13be357-93f6f7fa76dmr499663485a.49.1792772305106; 
 Fri, 23 Oct 2026 09:18:25 -0700 (PDT)
X-Received: by 2002:a05:620a:2628:b0:93c:b47b:26f with SMTP id
 af79cd13be357-93f6f7fa76dmr499658985a.49.1792772304469; 
 Fri, 23 Oct 2026 09:18:24 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d428372sm844143f8f.53.2026.10.23.09.18.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:18:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 40/83] target/ppc: Use a static table in powerpc_excp_name()
Date: Fri, 23 Oct 2026 18:12:48 +0200
Message-ID: <20261023161332.60153-41-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MiBTYWx0ZWRfX1DjXAmtfHx1m
 tH4wQk9V6Coooibg1mNNjHLHGPN4vN1as7vSD8povGjZARuqnxx+NIuOPbp3+5LLHSxc8gNrDtN
 r1tPPN72jd9lkNApTZ8oLvTVK+pjO8+qsw9a4RYOc1Le3EzD+EKaCj5N8f7vqUqC5XoW39z4No2
 WhGMgD3iu5c3NmxEyL0f3sNTCICSQoZFYBUcFXPdYbaVxImDIBvdjFJXC3FVJ8qLZOSuTcIM6v1
 4bcjna4g4+PhAmgvKfu/cNtEEWx8feOkcsUMyseCD7cg/P5ReXzTUIyhMfRaAGBoAfF6orQnZ+i
 5tE12CX7Jv21S7p3zbp3MB6PjstRoNVpqq/CwpDbdtd5FnX79N5MbN1ii9LpgZLmBSLBH2gPiCa
 q1QeESnUVGO0GS0ud+nt1nW7eu2aXox1QerjXQFBzxGl7Hzsq0rDiZFUown4Db6a5Zxx19zwKi+
 /9GLYjh5bX2Dp41mj1A==
X-Authority-Analysis: v=2.4 cv=JI+uIMKb c=1 sm=1 tr=0 ts=6adb88d1 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=ToDOQhdInOzr0WCV1tUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MiBTYWx0ZWRfX0iC3K1eXhvCa
 SJ6AuLihyE68+v9w4BAaBzPnHlt3Xt1u9SuhsKqKVh4eI/QHXHrMkWwuNvpY74LG/azBmx8HpCj
 Uyi6Peov2ZkGY7PW5hU6QF4/zXs0wmI=
X-Proofpoint-ORIG-GUID: K6FqVyEniPVr7KoMpxzHoiMm6g4zyHr7
X-Proofpoint-GUID: K6FqVyEniPVr7KoMpxzHoiMm6g4zyHr7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230062
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
Message-ID: <20261022215115.19680-22-philmd@oss.qualcomm.com>
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


