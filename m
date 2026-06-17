Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F39CCD98F3
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 16:05:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZsku-0003OL-Ux; Wed, 17 Jun 2026 12:04:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZskp-0003MU-UX
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 12:04:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZsko-000135-GH
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 12:04:39 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65HFpSho3284174
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 16:04:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YZ+Ev2WRhSxP7ZXHSchj+hbSuXr0qGteQZo4u3bwnS4=; b=cLDwDV6hMDoYZ4F6
 dUfRgpYI0APdghiVh3JPZGOw5SAUqwYJasVagltSbdmQyt17UaDYFjSWcb4j0rFs
 HH0cCH3/x5E3vHnXPahZEyGEojCBdDq1F2tEtODUTOWgIfDfvS58u5mYMx8bq5rz
 OEXYHGSV54xZSj7J6MSpxH0SqQP5RKlJP7YPspahdcmstBRINjgsQRM5jrwJBHSV
 zkpTl/kAsfl4hHyOqndItG56+15G/7yOk6EBXbYJlMdTYRs8ZWCgBjn1R7eeE5OE
 DIwpVx7oODKwa7rnzPU+Zwbo1+0a0LkINpaWUuQreCIxOMpfygjy6NQE6+HQoa2m
 pBbgOw==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueevm5ca-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 16:04:37 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-48637dce961so7100638b6e.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 09:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781712277; x=1782317077; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YZ+Ev2WRhSxP7ZXHSchj+hbSuXr0qGteQZo4u3bwnS4=;
 b=HlNflYkqLpnSpyysnXF2ukM01uf3eAXbS0X5Vjrm1pkxRGQF+k01Bi9bAMJhNON0RO
 StNuxCQdbVHMPvz9IB/9fgZSpXLWh42yA7dAFTVtY8//4Y6aWfvvpe9kt3Oe9G4s0+zV
 zG6xVFkFRVvf6HIWRmZ/ZnEQHBx4/aJUF2TM4CssiUvNtXd0wrOJ4VxpL6Ih+D/3oL1m
 2nxQSGMY5mOdv5KULN41nV7sCC5RZ7X2UZGgLlVH7KN5RBnnT/zwn9vvEXrRVOYWOILR
 yTMfaIgXblTlQEMX0ictknW56Y/m64vHJB8W92QA/4vk/Lug4iVgW50CSVVJaTIBs3Rr
 h8IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781712277; x=1782317077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YZ+Ev2WRhSxP7ZXHSchj+hbSuXr0qGteQZo4u3bwnS4=;
 b=qY3WHCunCHtXufZLIfRqdf/O2KsJn70Ovel8OJ7NAa+1CThv4COW7AoGCVQ8cbgR2o
 QzqBvwS2vgDI8jP7a+vRzkj99XD11Y7JSEfS5W19biT7CuDGTBPvPaPxhRT5RlPdxM+R
 WK03vXFZ37VUMrst+++rop7ssK0Zcs70vZu5B8vCT6NyDTs4cm0jJ9k4zmCsxF0Yan2s
 G1tiUKKTNJOHkGKhAEtJ4NxMO1wIku3TT/6VfsXcvzZ0WRKPLPOUJysTQ6mcB1Vm9mre
 ZUFfDwl2sivu+wuzpBGAqrPofVzQ3IZkmPAC/Cz0Wt0kWZkc7aftMtzDvZZcUeJVDTw+
 yG4A==
X-Gm-Message-State: AOJu0YxKNi0qnohjxs6ENNmRHuv5lt5pA/Bxx2KMzR4L6j7wOsqmAvEN
 y90+guSRIdMjh8X9Unllg0EQQ6YMAHXQi/3rwtSYeJcQNj4/KfaN+9GCABtag3zeG00Ygy+b/ln
 DL9Afov93+DQai9BW3huQrASs/AcxQxSsdx3mRpBpGO2uWt/BP082dNTg9Q2sUMg4pw==
X-Gm-Gg: Acq92OHT1K/olH2ZXTZQq7FM7IQOyzChaSlnUZOn7AZN+L4qhqidHP0rwabJZ7rBf9t
 bcWSaZI0e2nqzn1iqjvpfOAaEBmLIIxlWKChypn+wLCYcyANW4NpwzXHEvpluTIS0zo7YjydDUw
 HORMkbmAodLQw+oxYDwU/tcVqMGyqaXy0Jrk93NGwsXxk4l9RRjJoQM7Mf4QmIxZj83xOxBvkaS
 iB5AvAvyAw9ev3obDMyK6is/5z9RImhyZSlXxYyrqOi7ZAE5K4RTp7CQ6RwjMwvXBIF70VuqcCR
 bjDWRW6TjLBsyGTa3FO+6MJbOL0vZ1/tC4iKYfm4ZyckVs/h4zqKM8ii7jmHSO2pKlFP79MrApc
 wtOq5CvGJ3I1yJWPk3SnNQqE98+YfZar/b7VMEhGGramBd5P5FuH/X1MqF2fRcWGiL4dm
X-Received: by 2002:a05:6808:d47:b0:485:5997:d38d with SMTP id
 5614622812f47-489429d8d32mr3887492b6e.29.1781712276703; 
 Wed, 17 Jun 2026 09:04:36 -0700 (PDT)
X-Received: by 2002:a05:6808:d47:b0:485:5997:d38d with SMTP id
 5614622812f47-489429d8d32mr3887448b6e.29.1781712276277; 
 Wed, 17 Jun 2026 09:04:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a4ff67sm171042245e9.6.2026.06.17.09.04.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Jun 2026 09:04:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 1/5] target/sparc: Include missing 'accel/tcg/cpu-ops.h'
 header in cpu.c
Date: Wed, 17 Jun 2026 18:04:22 +0200
Message-ID: <20260617160426.64461-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617160426.64461-1-philmd@oss.qualcomm.com>
References: <20260617160426.64461-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE1NCBTYWx0ZWRfX8DajCmPihLjr
 Umjb3o2eVAJjqMrOb+BiD3bhiWXL3Zt9vcl1fKAyyXeFBY/F8eTvJsk8HnCv/oD7TEZxLPrHDpP
 rfcM4b4ALmWbdH2c/PocTx10bUv1wEmaZlvDtg8gfSTnNxNHdq4Cc74WJVKdyK5ei8d6+kmcxRd
 iZ/d5nmpI6AfNub+YpY0OS8sDsJBhf/zSCtqg2aUz1ed9KuUbWEu33zNCtHG8BhCGrtOhLGFIOK
 BrZguAE/8U05+bh4DtsXUci7ndFz34wVVhhNbpy7DVzLQSFwikQpvI43NMPuP2FzJCLnInWf6aJ
 Z8NkPCYh3eQtyGa87ePQr3/PmTqUetUlE+sV4o5v/IeRl2drWiPx0d1FjQ5LhsyHw1Ducy0YD2R
 jI7VAfn7oH2G+AIAWjKxDloe2x3W+GcCvHW35bRrM8PUc/Nd+joA0Tf69uVosF4Yw+4tIAngrdC
 FutQoNluHEjs/uM/eZA==
X-Authority-Analysis: v=2.4 cv=LM1WhpW9 c=1 sm=1 tr=0 ts=6a32c595 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=j7ncsyofc2DyooApoPsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-GUID: KA7_4L8IshX5I6-S-d_85GetaonuFKLn
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE1NCBTYWx0ZWRfX8JU4JKAs2B30
 YOXdKdZA3s+TqG/uMRsGAVTI3FgrjHj/y8FwMIY99YlmpDQX3WFqPCAq3cnUPk1DgiG9uUh5Km1
 3UdGeLzA2eHbD2BBECoNQd5C/Ftdtt4=
X-Proofpoint-ORIG-GUID: KA7_4L8IshX5I6-S-d_85GetaonuFKLn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170154
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

target/sparc/cpu.c implement a TCGCPUOps structure, which is
defined in "accel/tcg/cpu-ops.h":

  1040 static const TCGCPUOps sparc_tcg_ops = {
  ...

While this header is currently included indirectly, make the
inclusion explicit to avoid issue when refactoring unrelated
headers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/sparc/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 3df199ada7b..13ebb122a38 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -23,6 +23,7 @@
 #include "qemu/module.h"
 #include "qemu/qemu-print.h"
 #include "accel/tcg/cpu-mmu-index.h"
+#include "accel/tcg/cpu-ops.h"
 #include "exec/translation-block.h"
 #include "hw/core/qdev-properties.h"
 #include "qapi/visitor.h"
-- 
2.53.0


