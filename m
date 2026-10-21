Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22388606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 03:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YbK2MoVA;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KqPcjbw8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJMr8-00013W-Sb; Tue, 20 Oct 2026 23:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJMqC-00077W-HI
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 23:18:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJMqA-00039a-Cs
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 23:18:12 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L2F3ka3256697
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 03:17:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 31qHRvuCzQ9K6ePd7hfaaxt30CRwnArdLmjIbTE9sdI=; b=YbK2MoVA2iAxu2mI
 i1OcKZIQYiunADMGklvayunO7PIwCg0lhRHxan5EKZNViJPdwn2iv/642CGcxTwJ
 k5t2Xr+o4wAgwpKKLMrzhHX8vyWpYkK0vXT+Om0V5y2M2I2XWwHU/4xpi/jpqj4e
 cuacg3Xr/C/Wr+FA/lEqBV/FouWp6PhDI9divKp/rifnvpANoL/DTxMQGQRIrby8
 EsfGr0Uvf9YaZE47b1u1jigv81HKxGSIzaBWTRkZy852ZbgDuWlOQ4f0O/BXS2rc
 xEysIkQlR20GM3L+lUHPGwU5+ulAMhdOJPin3ak2epIxMGzWsU+/+VkDWbk/1VwQ
 6A93fg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hed9v1rxy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 03:17:59 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93cb7f9bb86so67088785a.2
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 20:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792552679; x=1793157479; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=31qHRvuCzQ9K6ePd7hfaaxt30CRwnArdLmjIbTE9sdI=;
 b=KqPcjbw8AXu0r+ugmxG/aP4t/uiaXscTnOIFeBBXo2QWReIYKxXwbc7CJ1ILG8qP/d
 RJJqu6kY6cW4vmoJESRqiwrkCZyjXaKH9/fdkDoi/E4EoSvVkWRdfEWtbtCY7l24TCIc
 fAqbRIt9NcYrnzCyPQJ9sF9r93phcsE9Uj+WuSmj7welyo9gnMQO3fQeU88M99wv1UpL
 KS7/RU+7W0RhaII200pTdGw/RKOMNG1Uitf0pnDEFK9EG8xP4+knT5OcIzYYoJjvbyKD
 3kEzF30gx8PF0f1uxz4SLuqfMaQiVVN5CC2Cr8wvGDLRQ68ud8IE0Gd8LYEeq8WhDily
 I5Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792552679; x=1793157479;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=31qHRvuCzQ9K6ePd7hfaaxt30CRwnArdLmjIbTE9sdI=;
 b=o+T2OgpOLr5WOLLBZBF7H0hFBI0euDHZRhMq5M5vyPM7MwSTuCZcIrLUTsRkPz3Lph
 pJydSMkWS712zcsqGw+cHIoIFRcWL6akd8cyBogVBYoF3bgwxoTuMIH7WUI6BqAgndGM
 i7l0ylCoDm+pgj8pfZeR52Mhd945rMu9R9laArVmL5amSlLE8wz7DvyppnkO7Moea7vO
 MgIr4Lwf3Ubhb2FnYuAk3+/bF4/Y1pmmaUZ3cvMLm1+14d4Wo03UrlFT2kWpVzuwiDM8
 SoLJT3cPCYbon6Tvpd/4AcGpiKt324fDHJcfY8av0oQmxj+VI1MWAVusnwmckvHUc/o9
 TiJw==
X-Gm-Message-State: AFq9FYLPDOarJQ644TaIvJNfoDMRjbb4apdTi+AT9W+ISaSfJwQ6fI8F
 EOyAjKFG6BiIclxdFw29hTsCMOSGgJwDOgiBl6kJn6RvQZyqSwmlzafYUFSbd3PZb+DIRAl4LDT
 GzTxPDxvznc982qbFabCLPDcKSaqd+z/Ky061dBDifd0qNw9PrNxB1GjfpC8lt/2Iitv9
X-Gm-Gg: AYBFou1r+cFZEduiI8Ogtf48Eft8EdBgORZk1u0qKSac8UROMfTOg7X9+2z5XVY49Fd
 ZvvebriEuInPt8dLylKNqnlXc+A7OWyR2OrdeCNXMx+xpRyEk9b9IaeTSOC7WO95VIstOhNnUoD
 AHxqyk+cHLx3RVs8+5Tug6dluACa2mOwz9UCpRLQAf2e33g9CJmC4+0SGnSqnTox3FsDhHZoxvs
 wPYniL/obb8tcdJZFizwcwh2hvK2p5PaiNdXJmE5E5+qtknmwh56APUCx1N/0m14UGXEv+tJIBz
 btdVxICmKFUewpUF29t0aMl2nBr3yjE5U7P9a9Lx9LZrYjSaKWpt5ONj1TjkpUuX+0mJq2b7tDx
 6NxvcbA8Avj4GGwLdcCJeMg9XjQGJWIUyVlcP8jHN
X-Received: by 2002:a05:620a:2987:b0:93e:95ce:53c7 with SMTP id
 af79cd13be357-93f57f05babmr192785285a.4.1792552678699; 
 Tue, 20 Oct 2026 20:17:58 -0700 (PDT)
X-Received: by 2002:a05:620a:2987:b0:93e:95ce:53c7 with SMTP id
 af79cd13be357-93f57f05babmr192782885a.4.1792552678191; 
 Tue, 20 Oct 2026 20:17:58 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fb864dacsm41027025e9.12.2026.10.20.20.17.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Oct 2026 20:17:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 29/33] target/sh4: Use a static table in
 sh4_exception_name()
Date: Wed, 21 Oct 2026 05:14:02 +0200
Message-ID: <20261021031407.24862-30-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261021031407.24862-1-philmd@oss.qualcomm.com>
References: <20261021031407.24862-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAxMiBTYWx0ZWRfXw8HgiROLW5Ts
 EPJsIdSKWApY+5QwgVSfQmUr+Ki8KJRSZXUMaN8BztAWEUJae1sQyYbbaF/4VcEmlJzPgshPDlG
 nOJ7YfxYfhq5ummOwM6l2KzRG+txMB0=
X-Proofpoint-ORIG-GUID: FyT7r4-5LZ87rdygucZeryohS2zklkW3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAxMiBTYWx0ZWRfX9haExNjg7YdL
 eWDcnpaVaFgY0jRlXlrmR9FLoxKcnpCpiHLJAMxcpbmX3dKs8eGiE1xTOqEUqy269es8eskWbGs
 38vHzpYwpBfAC6nBxVIKyZthRSIHexk72L8KWkOxlfgz1OGpn1sHk/SGF68pW6nUeeuM+yLU5sr
 5bqMmHMj9Cfjs8tMj/lJY1zcxqmvHcTe/ZQzkJdqiWsq8GWJN+v9pD192zYt92CJGJncbGxzO6o
 nJ1lWTHvJc1aFLLex7r5tT2SSKlP+MIkTiC0Y3XbLaHL1IVtnCbOH37T4oR4SHyCbBsRP2Hu/NT
 sWJ7dX3WQHqqMRHAvOg0VUs7575QS9flffFxatMfGC5W/RIWqnizE6t/YmRXxWZuqfuHsClM8nQ
 Vse92FBDPapcBeLFZzf7J4OgdITmowCUBOQk5bIboOU8hIm197I8ACaglBDYcBU9Kwv5L7vfG4v
 ibd7dhhZNJrSIDD6Qcw==
X-Authority-Analysis: v=2.4 cv=I6zw19gg c=1 sm=1 tr=0 ts=6ad82ee7 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=rdbtYueUxUB_busH31QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: FyT7r4-5LZ87rdygucZeryohS2zklkW3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210012
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace the switch statement with a static lookup table.

Suggested-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/sh4/helper.c | 65 +++++++++++++--------------------------------
 1 file changed, 19 insertions(+), 46 deletions(-)

diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index 5856bab6983..a4f80b10d3c 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -49,54 +49,27 @@
 
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
+    return ARRAY_ELEM_OR_NULL(excp_names, excp >> 5) ?: "unknown";
 }
 
 #if defined(CONFIG_USER_ONLY)
-- 
2.55.0


