Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A0E4C5AD55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 21:38:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtXgh-0003t8-5Z; Mon, 10 Aug 2026 17:37:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtXgg-0003sv-Fi
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 17:37:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtXgd-00080s-SB
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 17:37:38 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67ALXNJ62542025
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 21:37:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ol77T8GehyKLtS9AocZPaQqwE24TlcK48M7K2nWNaHw=; b=Xu5laDj49pqQVthN
 6ZbwbYLasEYOkAf+EzIkwy6eCSTddMlTS2J8KYgbkD1+pC/dhrupJU06IoZZ54vT
 7TLsWHKw4pplhtxmuMMWjT+b44JbVYQl46H8Fsxq3Ohges9GyDdQXyzp9KLPq2cA
 8v743AFbN1sC7E3nYljSAaGHQJlRTNUuF+qUfLpwPYJQKVszb1f1Et1buTPOm9Rs
 dahbqFFbhMZLumOoNL1ClNbyOOwjP5Cl2rWIhCrEbCeWw/dDwK+EHsqyzByZ2IfO
 qjoeoE7gf5FySSDvHRiXeKGLLLZ4DpX0zfxNdRl/MQhRQ6xh/taJTKj/vgSna5qk
 Kvpc1g==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjk61494-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 21:37:33 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c21c01cf3so43696051cf.2
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 14:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786397853; x=1787002653; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ol77T8GehyKLtS9AocZPaQqwE24TlcK48M7K2nWNaHw=;
 b=eXE9LU/1kilb+WJnRxtNQAf3CHa/RYs2OTOfbNAD66BZpP7fSW/xNSB+a26Q9yozJh
 GnDAujH2HwKypREBj/FPC7sGJiYaiLbB4KCjMn9N7fvrkP4YNeFfVeJ7pVvFTM01mYez
 mYr7KYxnRJg2O/f9tUqY4n2GqT3HFq2cYpWKxYuL1cUnKDt8jva7B3+L0Ir4bWpfeqGS
 Zv8HcSyqEIMXc6VtcPJfaH86AUMz7Bp5cigbCSjMH3dOL+j9d9WJ6Y98LTxuyqfozXfE
 Wpiv74MzDcrZ2rXnGcJI7oB9Y3KEpkc3w8p7nbqDMlPIpgwmsayHy/4FrYoMryLEVbmZ
 22xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786397853; x=1787002653;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ol77T8GehyKLtS9AocZPaQqwE24TlcK48M7K2nWNaHw=;
 b=snghwvn5zjB0KVElvJFElRxh/vLDEyfKrQ7wMbGELmeto3Gm1QtSWUCZ0IIqIndZ8A
 ln+DPBkdIKtSnm+1NGPSuRqhbpw/bbJCSdv5Yq0y6R1Qb8jkuzfHBD5WZSuiGL8shxii
 22tUY2qCvGNCZRQbCmIbeRFHMpyWrOdxiYzDjTV+h8E+xWvG5JZbNaZYrAgazmtDZt5I
 ubCtrWGaaE+0lDnKihiV48yfUaKz1oiri+HjB8FwrbRDJhLx5IkhjLY/bULX0wf185Pw
 pQRLfurftHrN0SHDkcTvfu2Ajlds65/nDgi0EjdjUolrKumUExiFi3aOzw4my+jeG5Tk
 nZ7Q==
X-Gm-Message-State: AOJu0YxSHi/8iNeijxdu2uspWEHS9wqsXjd7wPkiYJUq1ztIsj81LesZ
 Sm1+cObyEz1dNgaPL2064eVorKxKDozIDyZGKnPhOdGP37/DDvv/BN8paAnxDxaHjdGByrWCpra
 3gR0Us6nlAwxfVKQn/DVO7vwNKpXaqsFuvPwE/HbCEtzjUKqgPBkx6GSa07yMOp24Fw==
X-Gm-Gg: AR+sD11Sj6rslDJqFL4+MwYaSKgsB5sHcsocjHAYwLrMb0sCaEFI0VNkvkKnzOq8mnq
 2zU09FvAuP+x6YDnOeRaLywe1UqPeEux5Ltn2h3EISAxW5ipmm+5PPeVegPGJnKRvVueba7JNGN
 JZ/EXtEH5vupTzZP1X54o0k47cJqEJp6tH3+FDHoZ/gz4HbRkUqAzTXIVzijwPdjJFPheQOeuef
 oBfxw6018zucIuJTaL40wQF4mgAYK9A1k7eKs6diEgU9HU7npzdg7FM+EKoU8Ajc+/cp2xnsMZf
 0xYl/YJIAC+drDuDweEIhtki99OAk9j2+36TYb3Yf9EZzRlwmlqSBzs8l0SAFASRyuZwMhv2qNJ
 d9HqjD+KR8BqY1fF0otcT6SU+tgtV5bFTLAe7hKtYnU5JM/E=
X-Received: by 2002:ac8:588c:0:b0:51c:1291:911c with SMTP id
 d75a77b69052e-52d0b070becmr345851121cf.14.1786397853241; 
 Mon, 10 Aug 2026 14:37:33 -0700 (PDT)
X-Received: by 2002:ac8:588c:0:b0:51c:1291:911c with SMTP id
 d75a77b69052e-52d0b070becmr345850691cf.14.1786397852819; 
 Mon, 10 Aug 2026 14:37:32 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995c69c777sm333715155e9.2.2026.08.10.14.37.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Aug 2026 14:37:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Corey Minyard <minyard@acm.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-s390x@nongnu.org
Subject: [PATCH 1/4] hw/nmi: Allow delivering to first available vCPU (not by
 index)
Date: Mon, 10 Aug 2026 23:37:19 +0200
Message-ID: <20260810213723.58467-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810213723.58467-1-philmd@oss.qualcomm.com>
References: <20260810213723.58467-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Nb3WEWD4 c=1 sm=1 tr=0 ts=6a7a449d cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=7d5GJacPjx8SozUiw04A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: wn2Qm3np2ADDlVc2gkpEh299I7FlPzVU
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE4MiBTYWx0ZWRfX8pcSPHC6NCgs
 k4CWchPzk4xp6EyEXiS0XuZgqHqxu4bKXL1xX5yuHwSKrLh3wqVHpsIS+/HIe2yxhE2oiRYtP6E
 YrCBClwnBFMc8lkl3niKJb2s1At/Id4=
X-Proofpoint-GUID: wn2Qm3np2ADDlVc2gkpEh299I7FlPzVU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE4MiBTYWx0ZWRfX6qZPTer0/PIg
 KAPNI3FH8WDXtp7NzyzmXkeQYdDgh+RNsoDWZQxHjylRLbpPo8z4L9/8P94/nm7dZufRYfRGYQ2
 XibGch/mkupPoKFppbuye44d0oKNUmZa14aRbhQfyOCgr9sMO9XCPwKLbAeDIW3GqusYp0zVym/
 m6V7nGDPDBb7JWc6aUuXebCroEbqqqx6h62sTV5OCVksPyMnyo0M61crMRAQUAQTEHYpMEhZJ0G
 1GK1wChuF0PuCL1iTO4Z6ysK4TbLPQU/t2h3rXrL1mmEbLGxdZTBLwvj/Gk03XMslj/JGBFIu9T
 4jnv/JAa+ixiBpPazJZdzyFRlAYcQcORBm3VXbzUOeY9DHsvXurpuU6pOncV9SPbD9xHCseJsa7
 zTig4JMsKeY6vnLk3G0dTXNr3FGMFa9EcmuUpkAky9/IqIH1IUkrvwyLkb2t/uZsSi6BRYFfIQh
 gez1nKg4OcS7rk5qDRw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_05,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100182
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

Allow callers to deliver on any vCPU (for example when
the vCPU index is not known).

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/core/nmi.h  | 7 +++++++
 hw/core/nmi.c          | 5 +++++
 hw/ipmi/ipmi.c         | 2 +-
 hw/watchdog/watchdog.c | 2 +-
 4 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/hw/core/nmi.h b/include/hw/core/nmi.h
index fff41bebc69..6136290f4fe 100644
--- a/include/hw/core/nmi.h
+++ b/include/hw/core/nmi.h
@@ -40,6 +40,13 @@ struct NMIClass {
     void (*nmi_monitor_handler)(NMIState *n, int cpu_index, Error **errp);
 };
 
+/**
+ * nmi_monitor_handle:
+ * @cpu_index: Index of the CPU to deliver the NMI
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Note: cpu_index = -1 can be used to deliver to the first vCPU available.
+ */
 void nmi_monitor_handle(int cpu_index, Error **errp);
 
 #endif /* NMI_H */
diff --git a/hw/core/nmi.c b/hw/core/nmi.c
index 4b447e126ba..67213631c04 100644
--- a/hw/core/nmi.c
+++ b/hw/core/nmi.c
@@ -20,6 +20,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "hw/core/cpu.h"
 #include "hw/core/nmi.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
@@ -42,6 +43,10 @@ static int do_nmi(Object *o, void *opaque)
         NMIClass *nc = NMI_GET_CLASS(n);
 
         ns->handled = true;
+        if (ns->cpu_index == -1) {
+            /* Any vCPU is OK, take the first one */
+            ns->cpu_index = first_cpu->cpu_index;
+        }
         nc->nmi_monitor_handler(n, ns->cpu_index, &ns->err);
         if (ns->err) {
             return -1;
diff --git a/hw/ipmi/ipmi.c b/hw/ipmi/ipmi.c
index 74818ff3cea..8c492271f90 100644
--- a/hw/ipmi/ipmi.c
+++ b/hw/ipmi/ipmi.c
@@ -60,7 +60,7 @@ static int ipmi_do_hw_op(IPMIInterface *s, enum ipmi_op op, int checkonly)
             return 0;
         }
         /* We don't care what CPU we use. */
-        nmi_monitor_handle(0, NULL);
+        nmi_monitor_handle(-1, NULL);
         return 0;
 
     case IPMI_SHUTDOWN_VIA_ACPI_OVERTEMP:
diff --git a/hw/watchdog/watchdog.c b/hw/watchdog/watchdog.c
index 0842fe373ae..0c1b94a62f3 100644
--- a/hw/watchdog/watchdog.c
+++ b/hw/watchdog/watchdog.c
@@ -81,7 +81,7 @@ void watchdog_perform_action(void)
 
     case WATCHDOG_ACTION_INJECT_NMI:
         qapi_event_send_watchdog(WATCHDOG_ACTION_INJECT_NMI);
-        nmi_monitor_handle(0, NULL);
+        nmi_monitor_handle(-1, NULL);
         break;
 
     default:
-- 
2.53.0


