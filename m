Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D90CD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:34:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waBwv-0005Vf-FZ; Thu, 18 Jun 2026 08:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBwu-0005Qa-49
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:34:24 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBws-0001qr-Be
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:34:23 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IArhtK2611781
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:34:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NFbaCLSy5+AZ85esJqaVPEbG7dVdvQ8YPRsNSgPsDbA=; b=DdkkrVHIiRLPPI83
 2O7JO27ZPpmRMDfppCmCt9PVa16RE+ptarzg16JabsYmmCToTTEvyt6VvpFEivNi
 R05JqPYnc9Y1IWrwrAdBHzktxw0X5W+Dd7udrVOhERx7cAKW6DqfVRUwFqQy1l/+
 YV09mebFvXBjVIkU3rAXToYn6SFvIfecyAN+E5svOUD8vl2GH5zXsi2Nmn2qqdYd
 Z+80oAiqMiRA9j1XsamlhT1kxl1BTsT8MLr/O9Zl+sYumO4Qkoo58s8JiCZCva3p
 bjNaykt1z5NYdi9uKLpsRSnnWQmV1jzIfFjX54tCT7hI74r1pmNHY+G5d9r2Qr36
 tsr9og==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4euw9vmv0h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:34:20 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-963bc9a24f0so996260241.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 05:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781786060; x=1782390860; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NFbaCLSy5+AZ85esJqaVPEbG7dVdvQ8YPRsNSgPsDbA=;
 b=Q+zMgr5LieWVgn4zXTqnv/0LI0EienZJ63/SBSUdyPjuYosfLZW9zPVRp2r5P4bFlD
 X3YaMQLlme5ZgRnCDGza4Rgref7g90X7abd1eb0tQn7+xIchKh4X+j2G6i5qzycG1PL6
 gUTafOFs3hU7Xbx3yKtAOsD+wYoEl0k6x/aLxdE3vjn4OymRzsona01k8li/btzNZhd4
 FNqp+yNqQWim83ICnVK2F7GjNogvdBpe/mCraTX2rmFLnwC+BZXYjO1N9Aisnc8a+4EY
 p14E79g7cG6J4ZiDa0eUkENBt66MZU0Hh6/MqSRaSAXfam6CS/JfO4poIGyUnnnn1az7
 BLlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781786060; x=1782390860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NFbaCLSy5+AZ85esJqaVPEbG7dVdvQ8YPRsNSgPsDbA=;
 b=pWHLZ3gB24EKGakeyPjIvkB5732iKvSclmLZAZv7fboyiUOlsmbUtqXp/lQwmGP1rr
 yylveqDQl8z/RP8bNeD7QIchg0U7Dprk8oVDpMrZyWh4KPYrOA15mYMuUXNGXMFBu7gP
 5hyoH4TkXvOzcQ3R+YCM1vXQc7L4pcbxKNF3tnPRsq4FOdcJVlX7+C46yDJJXv0lb14z
 a1RcWuSKJqYa2I/r29ju1JhPawaEUmur6KiCvm+45Tb2RrTd6nqPQrv0i9woEWJdh/4f
 jA3MBrVGJEVXtLefj3EwDrvo4mlrjVNKidp9c3y2Z3/F+pzyyKAN7zlZIn0OpUB0+657
 VUBg==
X-Gm-Message-State: AOJu0Yx7FVM+eRnB/2gkTaU+T4sw4LQATs/WVXcq80aXn72hlsHmF4zK
 EEdswDC27KEnVywhLC9H3SQuO9afswabPg4xU+nSPEstJ4VxAEGqh6ifoGyNY+yB5aPuFT171qW
 fn8bSqwXlfm4NOFU7JKR9BoRfcKkUISAuDrwhsn5HzBVWzzVzGnbz1JSpGVR4iy2UGA==
X-Gm-Gg: AfdE7ck6M11KxL5xYBUIqgsn3BD3MyJTNQM9WTi9Cs43bIczBc4QXhJLswz3FCU0NqF
 z2WLefbEpGBeIecyJtYh1cAqS9B0xJzim4ivfEAK9E0HPUMbPay1/D5bhVNFjmISBL44Rwk2z22
 BVaJTDHnwia3P6NlFjWZAgaxuzjqc9uH7YvmrvKwGWUPz8CgGMwiWXWSThOZ2B/IaB4PuHa579R
 UILmdkTswbybZ80XJayJzflHn1b5fCR9lj0UEU1lwWv/5J5Rt9pZO0VlInAWpxBeHXjZKpCtkq0
 MeC/x0KTg+/eSRk01x2NUSrKG5txdiVmmyj+Ihacpq+Nlst4Ys7Bf3Oh5SvKvFwcAYd/d7324Ej
 GwSIOMtSnvfGM02oh0Og1aK2ym4sNBGawu+skx+0glQ+jSPnqGyBTQQjAPYkeylUH0ms/
X-Received: by 2002:a05:6102:4421:b0:65b:47:2c8 with SMTP id
 ada2fe7eead31-727c52cb963mr2053706137.10.1781786059923; 
 Thu, 18 Jun 2026 05:34:19 -0700 (PDT)
X-Received: by 2002:a05:6102:4421:b0:65b:47:2c8 with SMTP id
 ada2fe7eead31-727c52cb963mr2053696137.10.1781786059480; 
 Thu, 18 Jun 2026 05:34:19 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923a1c3c4esm34179245e9.1.2026.06.18.05.34.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jun 2026 05:34:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 48/48] accel/tcg: Restrict headers being TCG specific
Date: Thu, 18 Jun 2026 14:28:25 +0200
Message-ID: <20260618122825.90331-49-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618122825.90331-1-philmd@oss.qualcomm.com>
References: <20260618122825.90331-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: V077wcpcE_TkOFCVchhCg8P-yUpWm1fg
X-Proofpoint-GUID: V077wcpcE_TkOFCVchhCg8P-yUpWm1fg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX40L/+enL+5Ju
 jAml1y3qveMQ8T7x8CwkRA3R59wkTYxvTXUuNBuS3QL2wOLI8gfFVJUKU/oXxzgegcmp7QuSvHu
 T/O2ubepvSxgRguOkLhhdgHTPcbxetzmh6Oqb9Bz6RylG+SmX1kfLMk1tXEUDKl3xoEMu7Miml4
 FQ/OM1uSVfEduYP3ZGCLbjjvs/SiCVWMVz8OsxLOvWjF4g8c0j3QHVbi1wJKkLXbhrnRFVhXttI
 QE6qWptOfQNRZKDwcu6mtZI+dDI8vd6RGW6VqRcn4KH/FpxfJJMaVcFNwyb7eGNwvpzmq3FdGze
 beSvZYF90/8Mux/x4lg3KHqlN7QQ1AbxCPWylLcSTSvGWV668tnXFjHLh9+5t0vsbaiXaN3WE45
 TMLPzZ5uXo9/B9DFhjatR6mrRm3PHfZAFm7rBy58qEd9uKprMXC/DbuOI5m6aWlbRHwxQUJjAxD
 f4d/7Dcb7SaftT4FyWg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfXymft51TiZPY1
 sLlDHnJAf3wZ74vj8/iawBgAaXNEA/gIB6XMqlA4r7LKPvHiy9HC1f0IA/+lAq2YoDQKOxW9RAg
 UkGfZV4vbnMUXgOBBBt9mjhI0jr54sA=
X-Authority-Analysis: v=2.4 cv=YJKvDxGx c=1 sm=1 tr=0 ts=6a33e5cc cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=-SUpAgEnhvh4vktFIKIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=TOPH6uDL9cOC6tEoww4z:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180116
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

Forbid including TCG-specific headers in non-TCG builds.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260617171438.75914-12-philmd@oss.qualcomm.com>
---
 include/accel/tcg/cpu-mmu-index.h  | 4 ++++
 include/accel/tcg/cpu-ops.h        | 4 ++++
 include/accel/tcg/getpc.h          | 4 ++++
 include/accel/tcg/helper-retaddr.h | 4 ++++
 include/accel/tcg/probe.h          | 4 ++++
 include/accel/tcg/tb-cpu-state.h   | 4 ++++
 6 files changed, 24 insertions(+)

diff --git a/include/accel/tcg/cpu-mmu-index.h b/include/accel/tcg/cpu-mmu-index.h
index e681a90844c..e0fb6ef91c8 100644
--- a/include/accel/tcg/cpu-mmu-index.h
+++ b/include/accel/tcg/cpu-mmu-index.h
@@ -9,6 +9,10 @@
 #ifndef ACCEL_TCG_CPU_MMU_INDEX_H
 #define ACCEL_TCG_CPU_MMU_INDEX_H
 
+#ifndef CONFIG_TCG
+#error Can only include this header with TCG
+#endif
+
 #include "hw/core/cpu.h"
 #include "accel/tcg/cpu-ops.h"
 #include "tcg/debug-assert.h"
diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index 5950cdcaab1..710da12b828 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -10,6 +10,10 @@
 #ifndef TCG_CPU_OPS_H
 #define TCG_CPU_OPS_H
 
+#ifndef CONFIG_TCG
+#error Can only include this header with TCG
+#endif
+
 #include "exec/breakpoint.h"
 #include "exec/hwaddr.h"
 #include "exec/memattrs.h"
diff --git a/include/accel/tcg/getpc.h b/include/accel/tcg/getpc.h
index 0fc08addcf3..8a97ce34e76 100644
--- a/include/accel/tcg/getpc.h
+++ b/include/accel/tcg/getpc.h
@@ -8,6 +8,10 @@
 #ifndef ACCEL_TCG_GETPC_H
 #define ACCEL_TCG_GETPC_H
 
+#ifndef CONFIG_TCG
+#error Can only include this header with TCG
+#endif
+
 /* GETPC is the true target of the return instruction that we'll execute.  */
 #ifdef CONFIG_TCG_INTERPRETER
 extern __thread uintptr_t tci_tb_ptr;
diff --git a/include/accel/tcg/helper-retaddr.h b/include/accel/tcg/helper-retaddr.h
index 037fda2b83d..ebdc8b378d4 100644
--- a/include/accel/tcg/helper-retaddr.h
+++ b/include/accel/tcg/helper-retaddr.h
@@ -6,6 +6,10 @@
 #ifndef ACCEL_TCG_HELPER_RETADDR_H
 #define ACCEL_TCG_HELPER_RETADDR_H
 
+#ifndef CONFIG_TCG
+#error Can only include this header with TCG
+#endif
+
 /*
  * For user-only, helpers that use guest to host address translation
  * must protect the actual host memory access by recording 'retaddr'
diff --git a/include/accel/tcg/probe.h b/include/accel/tcg/probe.h
index dd9ecbbdf11..0b788901ba0 100644
--- a/include/accel/tcg/probe.h
+++ b/include/accel/tcg/probe.h
@@ -7,6 +7,10 @@
 #ifndef ACCEL_TCG_PROBE_H
 #define ACCEL_TCG_PROBE_H
 
+#ifndef CONFIG_TCG
+#error Can only include this header with TCG
+#endif
+
 #include "exec/mmu-access-type.h"
 #include "exec/vaddr.h"
 
diff --git a/include/accel/tcg/tb-cpu-state.h b/include/accel/tcg/tb-cpu-state.h
index 8f912900ca6..1903af4c2a2 100644
--- a/include/accel/tcg/tb-cpu-state.h
+++ b/include/accel/tcg/tb-cpu-state.h
@@ -6,6 +6,10 @@
 #ifndef EXEC_TB_CPU_STATE_H
 #define EXEC_TB_CPU_STATE_H
 
+#ifndef CONFIG_TCG
+#error Can only include this header with TCG
+#endif
+
 #include "exec/vaddr.h"
 
 typedef struct TCGTBCPUState {
-- 
2.53.0


