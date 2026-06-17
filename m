Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE87CD98F3
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 16:05:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZsl9-000418-J4; Wed, 17 Jun 2026 12:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZsl5-0003to-Kw
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 12:04:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZsl3-00017Y-W6
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 12:04:55 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65HFolBV1236094
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 16:04:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 D/M1lQxPEI+VR7ALOMKHxiFyxAkDv0dopmC3PrZlQnM=; b=SwYDnbkqwayB/f1c
 r2FUqRZ60mGeUS3c9KBKrctnt9ZS4beJeGbQ2ezNWfhWGHzNLLUtxVzEUlpBqoBG
 gV6A+MuamIXH++lAPuiZSnE2izZpC0HFe3qAvPHE/d4x22V7dhzEvo6lorAPgkKQ
 NPUY7b51xTqSlwcrJvJUjak+UZPdKJPKqwziBA0S0xl+HQrzikHGXW3XX/LKVDKh
 yxISaoMzz26ueXCDhYpkuV4RDLiN1m9665aAaBYCfasYUVNPak1tGrHHug3JrU+x
 rNIEVg3IJzGqBC4VioBFcBDHJY5/vSQRUDgAqWtsbT6eQ0k+p//NU7J8PL8FwR8G
 GJRpzA==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueepm1ce-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 16:04:52 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-7e6dd5840c1so10076025a34.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 09:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781712291; x=1782317091; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D/M1lQxPEI+VR7ALOMKHxiFyxAkDv0dopmC3PrZlQnM=;
 b=RrOZgQ1FLga+ZKkx34BdqId7pJmYSLqzHHxTruLXPcjOLGXddMc/j68eG2LhUcRu59
 gPFUClazLXSuSPP7d19kd1LnWviJ+Wj+UE/3voeifYGms13hoBVqGmh31vTWsGy0u3+l
 y7WdELOzyTM47QVi155SmPSVgEf3HcmUtxrpk2wla2GdSmM/eSndXHwmPIkIbq32eD2A
 RxDLLi43TdwcBsawqH2KmkCE6pW3uf6sBkkcPxBvOxyhCoLn85kSpD8FB6uuuT755TOU
 gFRCEfMnNcj2vi1GFDqp5eLZMTacerzUw9JnalG7bmJLotKwMJ4JmKAGAy8D+EDKzKX3
 trZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781712291; x=1782317091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=D/M1lQxPEI+VR7ALOMKHxiFyxAkDv0dopmC3PrZlQnM=;
 b=A7fdBO5K3NsTcqTUEsUu8rptmwCUvfWCFK4KNRxbk2V3+yk3FzhZX3tSIC82o3BNT4
 ISLoSZiUIxEHSDEHGFghpHM6C7ZDqJ/aYiCwetWL1uylCsNbM8zOmX2IaI3fGzYLSlre
 12L/oEckqlJpTySlhEAd0EuRr2aKUadmP0I6ZU/WOWCkMRzFu1MH6RKvc+tQW6q2q/Xg
 vPuMvqsjg2mCIaptbHMPqSXh4gyQWt4llPALBkcF1HxNokGgRk3WD3sZz+hBI0NqEdwx
 c8Urakkfll/t7RkhAWSqENhe6HaMiAptLAnvg4ny5EXpiIFukOR1DzrwDD0OYZ0ttg/C
 WACw==
X-Gm-Message-State: AOJu0Yxr3feepdDEipIDrpvWYzild1d8gjL78iy2l46scLA0McR76Y9R
 2b2FeVPFKWRGvrUkU2hSfRLRJ6qqb4vz9WMwVbtO3kkmoQu2o93UiRv/6lreVgoGqUUPW2MKTL9
 VAIhv7t458JF5RUDQxv6yy60dtRL7hNHo6CWlL+XTTBlwQxpIVkrn549RfnQ5uc94IA==
X-Gm-Gg: Acq92OGf2hcO1bBGSGnrh96jrWNzs+CCgez1M8VQfJzXHClkUcla+nLKtJGtmX4zscK
 jDlX3g2pLGCvaRIR6/CUBELzQEur6AygkKfMVXqizESgzeSMmY9ynOz4mFauz3OAEIqaAYxOT73
 eGXUjuO0iIEHxoCSzMwpo49kDY0SMaCLY3sABf9SMKI9WQ9JW98NWf59AXltSQbQGdcx18CblGl
 bEuf9qLrTuTAuonZ0dVQQpXrX4WsUbLJ4Rai0lgmI79Co7KxVOwyILmyrB9xx2US7BZssN0huhV
 Ibefb2hTzr7RC4MdNyozBbmn0jfMMpinuXdJz3e8VgDGU0NyPWSHJiCaxxEAllT6c1mdjdezgCV
 MCdPMcLloIrWrDEU5E3DtaiS4dmeFAsLr0DN8GWDRS4PdrgnfoKp59wG2AjUV1g//ZNBv
X-Received: by 2002:a05:6830:6302:b0:7e7:9493:dc3e with SMTP id
 46e09a7af769-7e90b2aeb90mr4023819a34.3.1781712291550; 
 Wed, 17 Jun 2026 09:04:51 -0700 (PDT)
X-Received: by 2002:a05:6830:6302:b0:7e7:9493:dc3e with SMTP id
 46e09a7af769-7e90b2aeb90mr4023760a34.3.1781712291123; 
 Wed, 17 Jun 2026 09:04:51 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f263945sm56921144f8f.8.2026.06.17.09.04.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Jun 2026 09:04:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 3/5] exec/cpu-common.h: Avoid including unused 'exec/vaddr.h'
 header
Date: Wed, 17 Jun 2026 18:04:24 +0200
Message-ID: <20260617160426.64461-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617160426.64461-1-philmd@oss.qualcomm.com>
References: <20260617160426.64461-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=AY+B2XXG c=1 sm=1 tr=0 ts=6a32c5a4 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=F0IBwpKotLoxzzTqpwsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Z1Yy7GAxqfX1iEi80vsk:22
X-Proofpoint-GUID: KTIgY3yqTiYLTnIgSN1XQweAIsFMUIQl
X-Proofpoint-ORIG-GUID: KTIgY3yqTiYLTnIgSN1XQweAIsFMUIQl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE1NCBTYWx0ZWRfX10axz6Aq+QHm
 0qFEYlM7mxYsC2rTIWmJNBvfpaXzNwcJyHhzD5cExGJm00ag/v95yd0N8H15V4EipuDhXbkuF8t
 MR0ZF8XPJ5m6iBhIoe+Q60mzdqlEEkG8DNT9kb8HSVCZINVK0fWqsm/MhR3mE+hBuLxGGzji5ZW
 AcRJUhoGccJtmqkx3ekLUaaJh+H9pOvMUzNlvQrNZDYQoW8eXCONcTOjloZyNHDX3xNGI93X5uV
 KhTjlH0Zuz/sSnRa0NonACPUjOXOI63UpEedi7SM8dss200VPTd7U82v+HkUzFkE2r8HyRaRsVA
 F7iIoU80W/LPJVCGI+GYqZo8LFtQuDOwl/e+C+gl9u5sBfbNlnQ+6p5jCloqAuulMjePC5ZGyrh
 jZjGLGyaavgydGIW8RO53itqU2fezVQAtRi17nO/sVaMOxzt/KenMn9UmJNMwDXwqloLSNdn59s
 bqhZx0HvYFSdS51mvIw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE1NCBTYWx0ZWRfXxfUE88yfPJdU
 K1CK4rdtSrgsuhwE26fA5v3lkRy803x96ZaAQFm5G87iVn4+bjtFMRWbghvHICPBVWYpo51b+lU
 eYKu9K0qM693J+3ZbwiY7VHaB9866wg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606170154
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

We neglected to remove the "exec/vaddr.h" header when moving
cpu_memory_rw_debug() around in commit e9048f099b3 ("exec/cpu:
Declare cpu_memory_rw_debug() in 'hw/core/cpu.h' and document").

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/exec/cpu-common.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 8cddd32ca8b..7dc8cab3263 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -9,7 +9,6 @@
 #define CPU_COMMON_H
 
 #include "qemu/thread.h"
-#include "exec/vaddr.h"
 #include "hw/core/cpu.h"
 #include "tcg/debug-assert.h"
 #include "exec/page-protection.h"
-- 
2.53.0


