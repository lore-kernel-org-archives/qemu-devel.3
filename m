Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1FC606A31F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=N4wpWuOS;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dZrMM4Z+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0i8-0006DK-Hf; Thu, 22 Oct 2026 17:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0hk-0005Zj-UO
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:52:10 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0hh-0007UY-CD
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:52:08 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MIHHKD1509990
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:52:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0EV9em1HixdBMA3GBQrswIS2/AAPII9gs0iab3BukLQ=; b=N4wpWuOSq7pqaHCq
 DG4TocsRD6fvgLLm+WrIIFNFQTEUzvTilq+XMNU9JAmdzcDP8d0Ot352YykB9x+q
 mIzhnCVbFgWCBCLCkna+ypjxMYgvZYuo9YzINrsGrBWJAgVp768JqxVRf6DqGo3s
 c78jVgtxvoKhoG0N3I1BPgp7p3xpzlpUgh5NJFyu9s1d6fJT48NvPlWHGqJsMLJa
 2k3JUaF/3jdOWysw6t9qkWRZjZBmYhqZ8c0c16FSQgX649Z1+/cV4BYVycRsUQdZ
 CUCa1FgRnja4Ueptoa038HN4JrJ5crtS0+C1CGr/gW9yXko98DWZYCnOEISnBseV
 gG0Dxg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmp8qea-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:52:03 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f32050e72so76566485a.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792705923; x=1793310723; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0EV9em1HixdBMA3GBQrswIS2/AAPII9gs0iab3BukLQ=;
 b=dZrMM4Z+4mcMcdPGiuyiI4TmaNh3zxvRttvnc6mSauWFiRZEcuds7726MwtZk4hgTU
 HqUD1zLbNQxqAibe72Fxa+/N8t0dpj776ij++K0hHdHWpffbbWvO5gHSmYUSCK4FPvXN
 xDFsjrqWiID0YdgXYElti5gfXIdf+fNoNZpQ1NU6CONDPRM54RBWFwQAS8Y2vFvYEl3g
 BZwg0RwTmufF/ricBSmLSyr/4/YrLbtm1H/dITbKhXJqWUmyb40lN3a9jCFeCF8OVHZm
 aZUGc0mIw8L2KFVmrkWtsVNQC+ZI/9nhg+/rM62mcG10bCqu6EQ+p6GxPWQSacnn9bdF
 kFMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792705923; x=1793310723;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0EV9em1HixdBMA3GBQrswIS2/AAPII9gs0iab3BukLQ=;
 b=uIMKX66xlm5WQE49HoB8aFJ7PXEsaK1+JFH2dsn7xWrSNqDUzkdAK2GI+W3NzE8AME
 IqAJMvSU1jFOUIzgPXx2WW+p1VAw2HvEXQ/I9+9J2eJePA7SEwCHlowb+jVLzDoHWmLQ
 H2x0kBxTCHLrUiPGnAoucZAFraoLBZHWFibX+DPQ2YuN04BP+cplOMS5cX/FtTACIuPJ
 k/mccFggnwj9AfGZs/j5F45PYqZgzp5EpP4CHYKkAjksPvOERSLYt4t1h4Gz7rVsuNCb
 sEq9dcO3Obd74j9QOqaN0H3me9ayv37zXiYt5iasjGRFtNY7Eo8Z7sAvITUzFh9pVi3s
 CQHw==
X-Gm-Message-State: AFq9FYItpdLVbkUlfwSPN9vhf8SNDF3m0LhRGBXSxO5ALxQcHJ3yZQYv
 0tShKwz8240ytvjbfLS0fK894Zv8Sm2x0eaZwuNc2LTs+2VNHRwx1DO4UXPA++KAuYqAAMQA649
 4UtRTyra7F41k8lizuQor+5HlV182vnTbVC4Luck6Aj0N0TPb+r7IiePpLNjLEayp+g==
X-Gm-Gg: AYBFou23A0wYbnT/YI1yslJrq079+du2zwMafz6MJO5JV/NIKExD6qYSp4pVD6GXjlk
 C/9ivPZZHBKiGTIOR8qj14Yw3HoV+vv4lEgQIMCpESHqhLCWxh4hEFCNZf9kyYLSINkoNWEZx8t
 oa71dNqnUMluZywvWmeGN09DOHVifiAhQ/wy04qiigXMApN5YMjYS3aubLD1NGAGzSaMnB5ro2Y
 a06k7qrH3NcxIeK7UF6KmXDvphJINJBUzMhh9d6Ej7ahh2r6eE+OEdIk2OGc7ybTBv0ZkT+1/Tp
 fcmAP69J/1d2NSUl20BJcQRZU7LgFJSgi5P6qvyNZHRAmtl+7t+OWHjklCoXvvS66eFQAIzvZz4
 mF+Ip1MEdLUL8Mat4yuFQCbhFH6VYxWc9T/RVXO5+
X-Received: by 2002:a05:620a:1793:b0:939:f49c:1b30 with SMTP id
 af79cd13be357-93f6f91b8eamr145393885a.13.1792705922474; 
 Thu, 22 Oct 2026 14:52:02 -0700 (PDT)
X-Received: by 2002:a05:620a:1793:b0:939:f49c:1b30 with SMTP id
 af79cd13be357-93f6f91b8eamr145390285a.13.1792705921929; 
 Thu, 22 Oct 2026 14:52:01 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a21046b92esm24878425e9.10.2026.10.22.14.52.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Oct 2026 14:52:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 06/33] target/alpha: Use a static table in
 alpha_exception_name()
Date: Thu, 22 Oct 2026 23:50:46 +0200
Message-ID: <20261022215115.19680-7-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022215115.19680-1-philmd@oss.qualcomm.com>
References: <20261022215115.19680-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX8F2eNRP3QhG/
 7a7flrpHPLe/BbwAiXtuXEu47v+inmOqtrtV/DDpRU6L5ZPUbH+mU7EK+95McedZLvKkVKG0zOD
 VaGu9FfzNWK0Yl1yLbo1a89zBuiYKnc=
X-Proofpoint-GUID: S5vcSjt6BPj9ClJKy3UwNz9edZkcK-vv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX5R8n+wKuJWQ1
 5/SX2rvGM2HHdvAuWhtA8RJNl/ajOgzdoZ5wUvwP2wNFnsPvTPhzu5yYn8X/EzzoFDff1UEPVzr
 t2jDZpTkKqOCV7O0PuJx+h/55HetbMzxWa7xn7Rc+wVD2NA4UuMAGQzESh4Y3xg3qWXSF3M9M+s
 jgJOpxexrIP0ZeofvhqD7r3z1t95JL79NjX1b5ZHrYorDRCIX2JW+4ufluKvXuo89rk78aglGfJ
 gY2OSOl/rBEv3H+DsDdobieC+eeHTis/mcNs/b41NHWEcfBR7qf3lKImhpEqSFyPsX+9OY+rG29
 jSDADmvqHUiR7AxzRZVA4p8zHWlAvdPcQKOzMgE5bFdxd6YQFkbQNg/AR3zm1T1d1KLL2emDEn2
 EkwejhK4ifEJ3OK1RMCPm5YDfPWfN+pRBFRsL8wvYS2j/WZ1zTf309pkQp/9tuIJ7EZS58SpeLN
 BhbXueFTix/8JRuIAXA==
X-Proofpoint-ORIG-GUID: S5vcSjt6BPj9ClJKy3UwNz9edZkcK-vv
X-Authority-Analysis: v=2.4 cv=BdBNQbt2 c=1 sm=1 tr=0 ts=6ada8583 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=-Zoeorw8py2zlXck_4IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220087
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
"unknown" instead of "<unknown>".

Suggested-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/alpha/helper.c | 55 ++++++++++++-------------------------------
 1 file changed, 15 insertions(+), 40 deletions(-)

diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index cedb0006892..84997ef3a99 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -19,6 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/cutils.h"
 #include "cpu.h"
 #include "exec/cputlb.h"
 #include "exec/page-protection.h"
@@ -37,47 +38,21 @@
 
 const char *alpha_exception_name(int excp)
 {
-    const char *name;
+    static const char * const excp_names[] = {
+        [EXCP_RESET]            = "reset",
+        [EXCP_MCHK]             = "mchk",
+        [EXCP_SMP_INTERRUPT]    = "smp_interrupt",
+        [EXCP_CLK_INTERRUPT]    = "clk_interrupt",
+        [EXCP_DEV_INTERRUPT]    = "dev_interrupt",
+        [EXCP_MMFAULT]          = "mmfault",
+        [EXCP_UNALIGN]          = "unalign",
+        [EXCP_OPCDEC]           = "opcdec",
+        [EXCP_ARITH]            = "arith",
+        [EXCP_FEN]              = "fen",
+        [EXCP_CALL_PAL]         = "call_pal",
+    };
 
-    switch (excp) {
-    case EXCP_RESET:
-        name = "reset";
-        break;
-    case EXCP_MCHK:
-        name = "mchk";
-        break;
-    case EXCP_SMP_INTERRUPT:
-        name = "smp_interrupt";
-        break;
-    case EXCP_CLK_INTERRUPT:
-        name = "clk_interrupt";
-        break;
-    case EXCP_DEV_INTERRUPT:
-        name = "dev_interrupt";
-        break;
-    case EXCP_MMFAULT:
-        name = "mmfault";
-        break;
-    case EXCP_UNALIGN:
-        name = "unalign";
-        break;
-    case EXCP_OPCDEC:
-        name = "opcdec";
-        break;
-    case EXCP_ARITH:
-        name = "arith";
-        break;
-    case EXCP_FEN:
-        name = "fen";
-        break;
-    case EXCP_CALL_PAL:
-        name = "call_pal";
-        break;
-    default:
-        name = "<unknown>";
-        break;
-    }
-    return name;
+    return STR_ARRAY_ELEM_OR_NULL(excp_names, excp) ?: "unknown";
 }
 
 uint64_t cpu_alpha_load_fpcr(CPUAlphaState *env)
-- 
2.55.0


