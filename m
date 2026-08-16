Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85834C5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:46:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvc7y-0000NC-9G; Sun, 16 Aug 2026 10:46:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvc7n-0000BC-3k
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:46:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvc7k-0000bP-Hy
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:46:09 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDlKgO3215381
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:46:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 g4REnGqu8ycIztFn7FSAwvmzN93LAzmsn5+R5Xus7/M=; b=R7KyYi/66giORQFv
 BSVKts61J9D/3I2nJDoyELtIxdsrIlqkwry0L3m2gtDOeDGmn1OXox+5f8zScx+3
 rb6Xub/q49Vu57diNLdIcRUfMt28EG+Uz/Hb5xmSm0vawbgz4j4rGQzqbxPasJZ4
 BhrPWI9J7FJWCQ34IJv/5yGqroUvAUwZnfTWWurtf1bDyABXn/n+hUwe80RQfuUW
 vdLLg4aR7l+dKBjZKs4D5o9wEmHdxz6dWDjEIUX5wfpxE09zanNp3dzzSuWDh6G2
 KSA8SmmAn4Uf32219IFTWehuB94L7MT9A6VpJHkH9ezYFZJSHcJXNjA1Qja2ORVG
 cd7cBA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghfbn3q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:46:07 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-936d067836eso255733785a.0
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786891567; x=1787496367; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g4REnGqu8ycIztFn7FSAwvmzN93LAzmsn5+R5Xus7/M=;
 b=MlCT/ocZQ87b7bDmEcf1E5zXDjP2j6ZHGOowZTRB1vLvHNKXHislX3Jy3pFQEAv1b/
 sjyTFcN07zvvHDwnRYduddbdOHs/f7ffo7gPjJNwl5US+41EMi22VOJ2zxDliY1MbhWr
 oVJwye9HPanrktF9ZHUUJeoeQHq8gRMbyQEMS3Suo2Ts9kKQbwqjHYDTBe0P3lj52S3d
 LxTFDMK/+0FSi5bYGGYAscBNqf4LQv8g1LK7+IOZmKCkJ0XiBP7uPJaWHfDVAmIqH1kX
 XgFSP7Xo2cJbpTAQxGF/I5FSflUit9BYEZfij3q/XMW7MoZQ1XUuHaOoRhg3PP3uq8wf
 +hkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786891567; x=1787496367;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=g4REnGqu8ycIztFn7FSAwvmzN93LAzmsn5+R5Xus7/M=;
 b=YhDtmIJ9ntqEMcHPSkyk20HyerWLK8R0mZ/8uPtTTP+bfNwKMBL2ovwBi7cgj7tXqA
 mFaaVmouI+BEuv93SGLJqc/MG3L6hMZsPEcZZJpZvKWPtIYjfXmddmdErSd0m44rK9Bt
 PMg6re6gA0GQRmPm8JZB2+9k0sC3zw3qYv0MGrcKABOIui2X5Nw+bCIdWLfUnzwJvyWk
 usQFrSf9CFvpWWKHtQvFfp0UgMtX6eNpv2J/D4xcJyQ9oaqou+EibUhqsI6QKRPPCg67
 7P0Uw9vC8S63Ja8SliH4h2+KW0vCNYnD1Ele/zd7iUuYBvMBuw1L2B16hfLqaNN/hvEB
 No0w==
X-Gm-Message-State: AOJu0Yynz51vh0q3z21k3DByMVmjjV3zHYrFk5JMSxM6ORqg+ivg76Oc
 Ocwo6MXg6N8m4OXr6eHp6spY5ZwHVBw5Y5bSH7J9RjY03fZg+mXHZ081n/a7vVRP7VkAjEDgFGF
 ou6z/YdN9oDS3lxFgtFpPZi828ni3rO/Xd+QkbZUEy2XDCg+wtQZar7/u8Jl+3T3+Bg==
X-Gm-Gg: AR+sD10sZRFlh3AUW3bYs2LW/5fAOGcaa+UKdi+PlkO4CQIM/rBwieZRiG+byeEuhoP
 neMd0NaaR56NZpbISax3lGWdATN2WpS/+Jvw4TkYZwgwx9Z4R5dhLmv/6OWu5t7sPtBWUW/PR0w
 32MXIVI8UGJEVGlG8eSoKgEMfHmMnEnpOABnyTDL1+9EcplHERLJXG23YLMp7bnyhLiYbsVXK8Z
 sqgOmUJTsUBySLlV31bO+oiPkbUvIlaqVxi8fIYHEm8g6reU4nC5fBuluK1eBfs/Hg4h3oDvJdq
 DPynB6SfA6753+Vjp2eztXaDcIcbdUVgQPx9qn0blNbuC+ondgeh+Ngdlex97sryW2dDWF8J9q6
 WDSlWhufpbsTMzn7eBKjvArKUz2J5mOXBVRJURrFoLw==
X-Received: by 2002:a05:620a:8812:b0:936:d2a2:5fe with SMTP id
 af79cd13be357-936d2a24ffemr2037459985a.6.1786891566975; 
 Sun, 16 Aug 2026 07:46:06 -0700 (PDT)
X-Received: by 2002:a05:620a:8812:b0:936:d2a2:5fe with SMTP id
 af79cd13be357-936d2a24ffemr2037455685a.6.1786891566437; 
 Sun, 16 Aug 2026 07:46:06 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499960fef95sm62372555e9.1.2026.08.16.07.46.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Aug 2026 07:46:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/56] hw/qdev: Remove DEFINE_PROP_DMAADDR() and 'hw/qdev-dma.h'
Date: Sun, 16 Aug 2026 16:45:00 +0200
Message-ID: <20260816144556.69009-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816144556.69009-1-philmd@oss.qualcomm.com>
References: <20260816144556.69009-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExNyBTYWx0ZWRfX/DKFBFnBSJPT
 BbGpWLp58EvqtEITNklLwH34OgnGEDwr96p3TD/faNaYwwYajwdIewVbt5nEAKW97zokqBwlX/h
 dmOjgHJbGZlTnXUjha1mPlYqRPlaw+k=
X-Proofpoint-ORIG-GUID: Fd9QdIiNFeh4YOvqT4L9ZNidi92P9U-4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExNyBTYWx0ZWRfXz0Tu7rG5Fd0C
 YH9XtCHe6UDDpwJevgQe1SkXaXV75UIDxMEqM2FYqgmzBZD9LFJC/+032HwqcyIeNfhhuyw1DbH
 GNJgXX1vKpUqqQzKbFc8z7qnpd8RMSiKMwwtdXyF6jc52e7anXpvEtmeUm8gc7VRdatTT/5xQGm
 SnpbTXvvXVEslh278PnKbKXfkpwt6wuQYOM5Gt5iopgCMhPK6uQSX8bqmO671eToo1Q2XJXazZ2
 h9uCJiycxttgh3WSO0sf6TbW6HraS7B6vwzMWPsnSHqjE+OKSWTnkPqSsRPKT/0zgWJm2BTVooi
 Q7Z9Q0WBy5C0yJNutIpfGICK5nwRuKwKALbK9YuNtbGzWa7H6igtZu0l4cxod59Ru37OF5Xazmf
 Hr0X55Jh84T6t5wXj8b1q+l2SFXXlKgaN53HQuELfEtb/I4eFtMGuhNPUaAlnrbMmImZP3HcR97
 y/W7caGWsBZjKB0HQrg==
X-Proofpoint-GUID: Fd9QdIiNFeh4YOvqT4L9ZNidi92P9U-4
X-Authority-Analysis: v=2.4 cv=I/dVgtgg c=1 sm=1 tr=0 ts=6a81cd2f cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=ofTg0gqHf28Bx6alXq0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608160117
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

DEFINE_PROP_DMAADDR() is only used once. Since it doesn't
add much value, simply remove it, along with the header
defining it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20230203145536.17585-14-philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/core/qdev-dma.h | 16 ----------------
 hw/usb/hcd-ohci-pci.c      |  1 -
 hw/usb/hcd-ohci-sysbus.c   |  3 +--
 hw/usb/hcd-ohci.c          |  1 -
 4 files changed, 1 insertion(+), 20 deletions(-)
 delete mode 100644 include/hw/core/qdev-dma.h

diff --git a/include/hw/core/qdev-dma.h b/include/hw/core/qdev-dma.h
deleted file mode 100644
index b00391aa0c3..00000000000
--- a/include/hw/core/qdev-dma.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/*
- * Support for dma_addr_t typed properties
- *
- * Copyright (C) 2012 David Gibson, IBM Corporation.
- *
- * This work is licensed under the terms of the GNU GPL, version 2 or later.
- * See the COPYING file in the top-level directory.
- */
-
-#ifndef HW_QDEV_DMA_H
-#define HW_QDEV_DMA_H
-
-#define DEFINE_PROP_DMAADDR(_n, _s, _f, _d)                               \
-    DEFINE_PROP_UINT64(_n, _s, _f, _d)
-
-#endif
diff --git a/hw/usb/hcd-ohci-pci.c b/hw/usb/hcd-ohci-pci.c
index 18b58f5fcbc..70c9e9ac4f5 100644
--- a/hw/usb/hcd-ohci-pci.c
+++ b/hw/usb/hcd-ohci-pci.c
@@ -25,7 +25,6 @@
 #include "migration/vmstate.h"
 #include "hw/pci/pci_device.h"
 #include "hw/core/sysbus.h"
-#include "hw/core/qdev-dma.h"
 #include "hw/core/qdev-properties.h"
 #include "trace.h"
 #include "hcd-ohci.h"
diff --git a/hw/usb/hcd-ohci-sysbus.c b/hw/usb/hcd-ohci-sysbus.c
index 1a2cf29bed8..4f51eebccb2 100644
--- a/hw/usb/hcd-ohci-sysbus.c
+++ b/hw/usb/hcd-ohci-sysbus.c
@@ -26,7 +26,6 @@
 #include "hw/usb/usb.h"
 #include "migration/vmstate.h"
 #include "hw/core/sysbus.h"
-#include "hw/core/qdev-dma.h"
 #include "hw/core/qdev-properties.h"
 #include "trace.h"
 #include "hcd-ohci.h"
@@ -61,7 +60,7 @@ static const Property ohci_sysbus_properties[] = {
     DEFINE_PROP_STRING("masterbus", OHCISysBusState, masterbus),
     DEFINE_PROP_UINT32("num-ports", OHCISysBusState, num_ports, 3),
     DEFINE_PROP_UINT32("firstport", OHCISysBusState, firstport, 0),
-    DEFINE_PROP_DMAADDR("dma-offset", OHCISysBusState, dma_offset, 0),
+    DEFINE_PROP_UINT64("dma-offset", OHCISysBusState, dma_offset, 0),
 };
 
 static void ohci_sysbus_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index c4a9741bd42..23990115abe 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -34,7 +34,6 @@
 #include "hw/usb/usb.h"
 #include "migration/vmstate.h"
 #include "hw/core/sysbus.h"
-#include "hw/core/qdev-dma.h"
 #include "hw/core/qdev-properties.h"
 #include "trace.h"
 #include "hcd-ohci.h"
-- 
2.53.0


