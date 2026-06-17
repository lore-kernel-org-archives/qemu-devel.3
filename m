Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DFB7CD98F3
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 17:15:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZtra-0000WJ-R2; Wed, 17 Jun 2026 13:15:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZtrF-0000Ro-BR
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 13:15:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZtrC-0006ty-UC
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 13:15:21 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65HFoawg083451
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 17:15:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 d1qcnFgIJS/s8/eMiv7yW5TdwLgkeVqMxZf31gL2MIM=; b=ZWxTT6X3FDhDPxK4
 0pQD89rhSfqzjTv2irTUXGmZjxIrMM6myQS9nVLxAkSGifgncU7leCGFkol6wVJr
 VDFjDamovlCRrsvBEc6eQhL61YMOKkDd15MZBS0TGbcsKn86vsGYkKBjsAv33Ocz
 93Sy+GXlhJAG4x/xO5S43tRdrPtjhJbh95bndPCXoxW/Sn9rdQ+eORQAqrwMpO/3
 QcVLR3oWbf+6JgZYw5sqU7P6+2tM07jifckQ3BZw8a1GAeXDEQWfmo6cIJiatOwE
 kb3wD13l2nSAj7pyzy9V7uKzNHwlMPbBFUhC3em3B2a7H78JpoxQepigrewokjRp
 TAd1hw==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4euw9vh14x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 17:15:16 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-9638fe9399dso2605613241.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 10:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781716516; x=1782321316; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d1qcnFgIJS/s8/eMiv7yW5TdwLgkeVqMxZf31gL2MIM=;
 b=K8nD3PVuCm4YGANHvnU7xJxHmzYgIyzvzl8G+DH62Mtxp7f80CIayWovcAhewD20GV
 VU3NAMlfTaVNABJxXiOrnUpvQtm18w3Yr1DA075xXJ2c/c53evvWvl8zT5TKQhnr4Ain
 cQj1MIH4DzZsRAw6Hy6UHeB4gMO5r770KFQt1JAGQsp7fHDQ3/10IjACCg7R0HjnGdQc
 2adMaUaDsNN8jxqeAzAJrXyaS8nWu93TsJbtOxVkbfFbEqrAnztcQKhUY7HXeRC2wQKX
 caDm24OQRV/i0SlilUxLoSKy7LMVxXCFSbYW98c6Q39PmVoE3CMw0wy3nOQVLL4459t+
 hS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781716516; x=1782321316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d1qcnFgIJS/s8/eMiv7yW5TdwLgkeVqMxZf31gL2MIM=;
 b=A7+lP/efjToTkX6GPVnFKnkIIByt8L1NQO5AYbjp4ENYH8q6AHqMTTqoBIQ5pTx2Qn
 l05bJTg4pa3G27M4Hzu89v+XcudyQyUqcckq+4JH2BUMcjKRawXNnNWGPaljqeBncJT5
 AM3iQscyIC9MEwSTPodmctOSdh2UggOxKCujlkZXu+e5LL2jLeORwhTJ5a0ozMQCHddj
 aeRScmM0kg03YIOrX9DglYuYQoLWypnx5iPdZ/RUsh4KPvXjXFh7Yx64sWaHnpocWh3l
 MbAw8wi4urEiCco5/4vqFv4uiK3MRlpx9SxFE4jN9+Tp6ZlA+6wO5CdfYQEx/NpXqn0L
 eUQA==
X-Gm-Message-State: AOJu0Yy9ILhTboylZdr7K+0P//1S3UyYG/4T9dorrVX8bkZM2OPPiiEi
 ovA10Ty+zetJTxT96hShUtD1G0bMZLkPPKc4Q8vQvYk0VE1j/ZOjXzqtBuBxe2g1kSpihYhX8qn
 zBEv/LCHXL76PfQlxLf5QZ8e+MYHB3N/EqFx8g+KmlBkdtVjuX7NoHTJ2AGTdR3/H9w==
X-Gm-Gg: AfdE7cnyLOA2rrJJFyXhR4uM86oGCS8Ou1xorWeQIDNlbis73/quuSTBkht2PlW85Q0
 neWueNqI5iSXTXl/Kd88IH+yqfVMpK0yUzAqOA2sZB9Hhig7PwuZFMFhKawOQ9BImJZYmCqR9e4
 WotPC8t2PzNhhiP8Nzke4PSzmP0VuElOzllIsZDvQFc5SNxjLIg0qTk5zX8ORUmYDcVeH2LMBdZ
 5Oc/1pvAsf+x4C3TcfmN13NMYMCExQhcH2MoOJMJr2DYyXL0nIobT0HO/Zlzz+GKrqm1CMX8Pf2
 7xCog9MW+rvcjtzJyraWb2RFpFM3CZ4kjdV6p/VMfMPHX76PLtxF7IafH4RHLuhZsu3dtU5u6zO
 YxAMoQPF1r3LIVX02Of1FieJ6YdtSpi0+2/KEZC5+N3Tx/G9YarNhqv+Y7RhGmGndDIQy
X-Received: by 2002:a05:6102:f0f:b0:631:2dc6:2f5c with SMTP id
 ada2fe7eead31-7245a1ee5f3mr2833450137.0.1781716515759; 
 Wed, 17 Jun 2026 10:15:15 -0700 (PDT)
X-Received: by 2002:a05:6102:f0f:b0:631:2dc6:2f5c with SMTP id
 ada2fe7eead31-7245a1ee5f3mr2833408137.0.1781716515142; 
 Wed, 17 Jun 2026 10:15:15 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a4ff67sm176451915e9.6.2026.06.17.10.15.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Jun 2026 10:15:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 05/11] accel/tcg: Move cpu_exec_step_atomic() out of
 'exec/cpu-common.h'
Date: Wed, 17 Jun 2026 19:14:32 +0200
Message-ID: <20260617171438.75914-6-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617171438.75914-1-philmd@oss.qualcomm.com>
References: <20260617171438.75914-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: h138AydSQPMfOZHyaa9IsWsGpOojvjDa
X-Proofpoint-GUID: h138AydSQPMfOZHyaa9IsWsGpOojvjDa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE2NiBTYWx0ZWRfX3N+erViZlcjo
 5T5I1vhk1h34e/4KmfaXqVzgctHaCL8fJRpw/OPPZnUNFN8TCTzv72UnNehrf6bLBChQncsWGki
 yy5RgXgUhz3crQiT0Zjby/cGTORAYm/CTf5qJxCi1iB12PivqpbZ0kC6PbTenumc38aKl6TzsNN
 BSa4sFuGSpqXSW35dW7umrgJRhohoQLxWY/BzWNR+MbNUfzuIP5ASMtFC/Qo+oIiBq44z+eqRar
 zIcDsEP+kr6ZGphKn+G+d/qmwjLCEgUW41li5AySuawWT3HO+FtoM2drx3nTMbUwLAez4tlvW1v
 LYZLa7xtiDuhze2GOt++X4j5+mZlIWVtJeDksIYuSoZuQsVLccAISzWYQkkwb/FOWkjmngpjJv0
 JYA41haWJyUD/LoUpPbbCknn2ioEL77WuAlHFLkYBk/HjPTjsiZobuFRTbLDN7YfUCHvc4DDTXH
 e/vkpX9l80gTUTGwm1g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE2NiBTYWx0ZWRfX1mOaNCX/TuCI
 o+LZmmEkl9BfmyvgI20f8UhXRFx8yrQeeiH7X17x609jiV/6D40mL0Q11S1PA+iw7dcRNfQZN9O
 P7O3neF56cJ4NMunW3RGM0NNpjlVB6g=
X-Authority-Analysis: v=2.4 cv=YJKvDxGx c=1 sm=1 tr=0 ts=6a32d624 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=xWu8-Agft_6X_INOG6MA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=TD8TdBvy0hsOASGTdmB-:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170166
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

Move the TCG-specific cpu_exec_step_atomic() declaration out
of the generic "exec/cpu-common.h" header, to the recently
created "accel/tcg/cpu-loop.h" one.

Include "accel/tcg/cpu-loop.h" where appropriate.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/accel/tcg/cpu-loop.h    | 2 ++
 include/exec/cpu-common.h       | 2 --
 accel/tcg/tcg-accel-ops-mttcg.c | 1 +
 accel/tcg/tcg-accel-ops-rr.c    | 1 +
 4 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/accel/tcg/cpu-loop.h b/include/accel/tcg/cpu-loop.h
index 528adb5588c..d8a5f98f9cf 100644
--- a/include/accel/tcg/cpu-loop.h
+++ b/include/accel/tcg/cpu-loop.h
@@ -13,4 +13,6 @@
  */
 int cpu_exec(CPUState *cpu);
 
+void cpu_exec_step_atomic(CPUState *cpu);
+
 #endif
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index ac3ab0e1cdf..ea9a49a1435 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -21,8 +21,6 @@
 #define EXCP_YIELD      0x10004 /* cpu wants to yield timeslice to another */
 #define EXCP_ATOMIC     0x10005 /* stop-the-world and emulate atomic */
 
-void cpu_exec_step_atomic(CPUState *cpu);
-
 #define REAL_HOST_PAGE_ALIGN(addr) ROUND_UP((addr), qemu_real_host_page_size())
 
 /* The CPU list lock nests outside page_(un)lock or mmap_(un)lock */
diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index 4160e2ba947..69560fdb9d8 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -32,6 +32,7 @@
 #include "qemu/notify.h"
 #include "qemu/guest-random.h"
 #include "hw/core/boards.h"
+#include "accel/tcg/cpu-loop.h"
 #include "tcg/startup.h"
 #include "tcg-accel-ops.h"
 #include "tcg-accel-ops-mttcg.h"
diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index f84342e0449..5b132d3d5d8 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -32,6 +32,7 @@
 #include "qemu/notify.h"
 #include "qemu/guest-random.h"
 #include "exec/cpu-common.h"
+#include "accel/tcg/cpu-loop.h"
 #include "tcg/startup.h"
 #include "tcg-accel-ops.h"
 #include "tcg-accel-ops-rr.h"
-- 
2.53.0


