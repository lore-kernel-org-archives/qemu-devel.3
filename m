Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADBD0C43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:36:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgru4-0003nY-4U; Mon, 06 Jul 2026 18:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrtz-0003VU-Me
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrtx-0005fU-TC
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:59 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KEJMP1567205
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:34:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=9cZdkGcIAW7
 VYhT6sLcTaa/0DQ6cEtXZl5XFGyYs4vY=; b=JkS3O5RR9npMIdtZFHhmsjQqxFa
 09UNhTTUrPK0tZZcxgvvMHE0xJZOS3U7xfvtU24kaPnDmjb2MtUgiGYcSEAUUPul
 oqV3NoP6R6FihPQDzQlFrfjztVn1kGnnm8vMs1bmmWkBwX/vwY5wr9CeCAfOMBmg
 hUX38KxVcRmypKb6B+XmHXiKXRjwkFkZ6pUpqbHmTR0RODKD7/Pl2Hg7bBqfLedE
 QKualnoszlu2/aBaB1pULtRSYWCJBWfswM/WYSfEizHJJgDNU1lI8Z/N59hmhvo/
 G3wplB4OSbQqkK5LwN+tfwSPcVia1mO7rMLWo8o5z484SyvZXny6E6+8sPg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f87q7kthu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:34:46 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c89956023dbso4721414a12.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377286; x=1783982086; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9cZdkGcIAW7VYhT6sLcTaa/0DQ6cEtXZl5XFGyYs4vY=;
 b=B1GERjcPsROJ2KZK+tRQgogqUU3HTtqxEZH4xx+PiF+saNJZnVV+GeMpLYkAf/TQo/
 bbGqjcciDwFuNgTmmDE+MjQTMsH7nkKeu+9xb7/ftibEKNNPGRtZ0avK9ecB8woc9GF6
 6MwnqOiHMwiQnp3vVOkBSglAq3U82nLzXNG5TYjeTPLIV2SozXrgwnKJeluJxoaN09eq
 AJWYlu+DEAl6ne9OXqZx5Mzy6zeL1k6KIOjj4NMIDBXN4LdPiAsOln+p50j+y82hA/lh
 xIin12DzOugIUH8QH7ksRioX2/DPs3N85ztJxD9wl3lLDn9/LBazHWnwp4Fxj3rMesdh
 HmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377286; x=1783982086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9cZdkGcIAW7VYhT6sLcTaa/0DQ6cEtXZl5XFGyYs4vY=;
 b=AXpA1zaILu0sHL3VJr+oPBWCT4hiU4TWxxXUbCQkIrr/JM2vXQqZ8jtBQk5akPcXcr
 c+V8thONlO0URH2EYjczCYdHdRwWVfXbBItf8pIpRMSArNacEK1FjHN9IoksH09e3paA
 k++ksUNV0hjB0aFuzofHSOZO8r00lo04cyTFdA3mbGO1qzHaCdabHjkqfHIEtX2tQn6h
 RS24jZCzx4P8tSjxkhaCSeBtBNyfxlvsZfLqxX5YV37FEE+jRX2XwJm1CqU261+wrMID
 4xT4suyA9ZLzkZq5T+w5LJkHXVTIdZ8bvvL2IYCF+F8N8WYHMJ3wzQPYPos0lkweRzra
 ZVuA==
X-Gm-Message-State: AOJu0YwQABFH6pXu+5fcC5qVmTMy5oKetaA/1gKPc/h1bmR9xpuitiYg
 8GLeDs8ygklS+gibdp64mFVDbcK1T68AT6Tc702aTtUw45AQepjjcCC7PJszKqP52ExrKKH5U2+
 Oy5f+InaxilI+hI2hF5+QfB1zbA2GQrZryRdFEm0q+wOpu1vYotZmTQaRC/K2Z8EnNg==
X-Gm-Gg: AfdE7cnuDJiOQVu9f/E+ftufrs54DSP1t3oOY+7qkn19PwV6uzLpHlbwzM6zb+E4aMw
 CbtYe/VItvqXZpqqio7j3ulINsobEKcnJzhGCWu/8qGGE5lZjQREvMMDn42HqhhJs2RTipJRgfS
 VaE1ZHxIaxgaVu6w4yveo3ilVc65MhGZ1tyIYLf1AOyhFTTers/cwLiJDn9QV14AYIM5iVhD93W
 vlCkKnH5nQGonnhgDCv7qY5zXA3txckq4GFUKj+mdLwF4loSwYpCgELlp49fLqKWqUEuEakj1St
 Gq9Ra382cMgt9ZPz1MtQ0cfjx03pCrmycLE7ApYkY7MQ4RBstOuO6sRKcTjJDuvIc0v2WOp9G9+
 0xttK8pCNis045fUh7FDhkdNeD/Giv1fVjBfrBBvTDOb08KfAldlaDQs2x9mcmPFWFHU6582eU8
 r+B38GgA==
X-Received: by 2002:a05:6a21:689:b0:3b3:fdb0:2288 with SMTP id
 adf61e73a8af0-3c08eabffc0mr3032555637.0.1783377285952; 
 Mon, 06 Jul 2026 15:34:45 -0700 (PDT)
X-Received: by 2002:a05:6a21:689:b0:3b3:fdb0:2288 with SMTP id
 adf61e73a8af0-3c08eabffc0mr3032529637.0.1783377285525; 
 Mon, 06 Jul 2026 15:34:45 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174ac0557sm977244eec.26.2026.07.06.15.34.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:34:45 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 35/91] tests/tcg/aarch64/system/gpc-test.c: remove unused
 variables
Date: Mon,  6 Jul 2026 15:32:47 -0700
Message-ID: <20260706223343.988769-36-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX9zqdriJ2Rv/p
 LGMXyBG/CipYuAFqlAc8/r1f2tLWEJTd6UrUTvbNPWZ8X9fWzrKqacuzLahNIJ0Wnrs8iO3jlMz
 REhPanbyRsrhVGatGKzPX2xRCJOcM2aO/Qx09s8OuLIpXYHUmVa6P2Wu6HYJeLQtD5Rmq1jMOEe
 P2FxotAEGXqpj8IxWCVn7TRytjA+GqgpbD2E6iIfRZ1KB2UkUWt1K6I3OGF9wHOJmyb4iIThZw5
 FMWrGmXijN3Su72OudRUNHKvri+tHA4ZnjXflChC/PRimxCPiWxRCHL5tbbT0eW/qdZnqdiubv5
 3TW/i1u5SBKc/zHRqg86GIqsdQJ9wAqEi3dV8CEsBvdXa5EbEx5zJbLmJFkVaeFFzQw0RBAc+vN
 NPI/tcRB/WKr9rKO3+GtoowgBo09ulNmGODsNxV0PtGwdmD/odxUuJlF7/Qh4TfDTYrebaqkxoK
 8nz5uOqjuCkqaRSmH+g==
X-Proofpoint-ORIG-GUID: YOcq7mBiE2nxqmJ4NP3-loh8TN9zsDb_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX1DW7jfRW1EP6
 AYpMm95SW3XjJ6MW7geZi6doDaiHTun97I4HXZiFuQe6noODoR31Lg4GXAqblsd/hB+LHWwmTz7
 p68PLDkTNLdccj98OI3j9Se32tWlimc=
X-Proofpoint-GUID: YOcq7mBiE2nxqmJ4NP3-loh8TN9zsDb_
X-Authority-Analysis: v=2.4 cv=f9N4wuyM c=1 sm=1 tr=0 ts=6a4c2d86 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=4Gh5T0g__NNyS1BPEC0A:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060227
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/aarch64/system/gpc-test.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tests/tcg/aarch64/system/gpc-test.c b/tests/tcg/aarch64/system/gpc-test.c
index f26b23efafe..0ce0ffea277 100644
--- a/tests/tcg/aarch64/system/gpc-test.c
+++ b/tests/tcg/aarch64/system/gpc-test.c
@@ -28,7 +28,6 @@ const uint32_t gpis_per_64_bits = 16;
 
 int main(uint64_t sp)
 {
-    uint64_t out;
     uint64_t pfr0;
     uint64_t gpt_base;
     uint64_t rme_status;
@@ -38,10 +37,6 @@ int main(uint64_t sp)
     uint64_t gpt_table0_addr = (uint64_t) realms_gpt0;
     uint64_t gpt_table1_addr = (uint64_t) realms_gpt1;
 
-    /* Mask is FNG1, FNG0, and A2 */
-    const uint64_t feature_mask = (1ULL << 18 | 1ULL << 17 | 1ULL << 16);
-    const uint64_t in = feature_mask;
-
     get_sys_reg("CurrentEL", currentel_raw);
     currentel = (currentel_raw >> 2) & 0x3;
 
-- 
2.47.3


