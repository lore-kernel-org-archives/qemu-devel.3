Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B46C5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:46:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvc8A-0000be-66; Sun, 16 Aug 2026 10:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvc89-0000ax-BF
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:46:33 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvc87-0000dh-SA
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:46:33 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDknIH3631363
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:46:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PyVVkPq+vWQ95qLp+r7QgINem/ADI6tAGQamAcld+mg=; b=keSBYE+45ot9tHzg
 93AvPgZhoWk2OiB2nMiI19hffISLLMpOxXXtQPc407LjDgLqK56nAZ/tm+NH0tHd
 r2fRCk68m4ma+BXrc+tqgZffquEwTalf56dQWs74IouwiLwbxXhewRZsro+yRX05
 fjp8ixt8/YxkLZiOdq+yNkLLW3UIPG+bUiT/bAKWmB5ndGyhpL96StxRZmZ9vQro
 NZxejAzpS2B7kt35tSPVnuOBW1I3IEn2nj/Dp0DhtAQkMgl0METpAOBlAu1ygR+1
 jYi39AaJmH5q4cBUfrx55DkELDOYTz9bvm0feIHEyq/8xyHmSFGVgT2koOLEBhik
 DUCECg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghekpxq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:46:30 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e5e38fbc5so270100385a.2
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786891590; x=1787496390; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PyVVkPq+vWQ95qLp+r7QgINem/ADI6tAGQamAcld+mg=;
 b=I6K5x8g9qVtlRGyWgBikzuAB+oA6NZPz5IwATogrEuindwz/w5SU2LUzkd5/DQA0Pw
 5tfRDe8P/UdjE+IgoroKS8YNvk7fHTQei4QaFutrnJm4+3MWehd+wJ4n7i3qwFQIPemK
 20HmAVN/EbwR6sOhdI3LpR8s2TRscECo7Btnfd6zOxvlfwW3GhCiSM34XnNKyN3WD0+5
 dQQ3vB8iTp3SbnoYzYIYWMAqInlkoY3XVVm0H20SGVaQD/K9MSCnqFdRu8NbkRD/qutK
 SlgpKrsSjE3KBGK4Ur4JoI+4Qbl3zLF4ASxZqmcloVveabheQgS3h5qmSYuuZ0O3pLKv
 yNWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786891590; x=1787496390;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PyVVkPq+vWQ95qLp+r7QgINem/ADI6tAGQamAcld+mg=;
 b=N83Mly5oDcmJigLizAvy2uDbbcsVJCnJaX6xu0N2W+hPWDNJPH4BIuHGEhIBT+G/e9
 z1egumj0CPUIcXSjp4I+9nXd2NiMzIpXfRdDgXyM8O0R433vVa0zUW3j9AH3TS6kbjgL
 DLLH+9rN+uwOiYRdAwCWst671/7pUEP8okV6OxFQjbXhz/zxWrjV1l/+u3A1t5rPhc8D
 TD+qAw1mzABwRHTIr3fF0G/opvGW/P7SwpOkLedjKdpsKKzJPzIG+rwXiArYyInYQa7D
 q+HsU5007wcQSwNLf2Fs6HTJKhFf5lUr0a16yWM9b3/jGe8uEl1WrUstjYUqWVsJanNB
 iX/A==
X-Gm-Message-State: AOJu0YzJ/Zbcwdk7fs+B++iSNZU+xCGL/DLm9UsEZ/9SH9L4WPKIOsXK
 pxde/Ucnc1CqOuKtwXHmatmkwl2GFQeWFz88qI73KMrTebbysvcdpRyHLPb8nb41ca3ZKvnYSF8
 1iI823ksMwmi/SyaLSQwtaD/S/H9gbXQ8k5jqwtqRFkcB6yERaBMBaWfUxKmaLyV5uw==
X-Gm-Gg: AR+sD13/SRRQvGXcjsH3voQ6I/ocDbE3siEd3n/X49KN1jkBDHX1T1Nep72AoyzH++Q
 4aAsiuj0vU/0vLQRUNkBTW20V7nVIts7cym55klXlG/Un6YOVd0FGlBZOr8NgOHATJ+3cCiMMFa
 206zupVLRWTMcANFH7JsNfxhLh76rvZ29IHCacUWPJuGRJk88mOElw+7ykSTUMfDcwIR1Knz//m
 2z1+PM680YMdG81EVloDSY7kTCRHYQwct5b7GcjK+WVt2ZjpXS/4UoBdZ2Hgt5nIEDuZdPUQRrC
 qoq52ZB7UtjVdxlwQOv8lLx0B73W8Vsazv7nPh8xb7slOokNtnLz5U0x7seAgeBdOD79JLwQ2Xy
 QVueDNh1+qoNsqBkh5MAzkieQdkrW2atKCT9V0cxofA==
X-Received: by 2002:a05:620a:6f88:20b0:936:a407:98bb with SMTP id
 af79cd13be357-936d2278950mr1451679685a.9.1786891590284; 
 Sun, 16 Aug 2026 07:46:30 -0700 (PDT)
X-Received: by 2002:a05:620a:6f88:20b0:936:a407:98bb with SMTP id
 af79cd13be357-936d2278950mr1451676385a.9.1786891589673; 
 Sun, 16 Aug 2026 07:46:29 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499877d5548sm172078745e9.1.2026.08.16.07.46.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Aug 2026 07:46:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/56] hw/hyperv/balloon: Use qdev_is_realized()
Date: Sun, 16 Aug 2026 16:45:03 +0200
Message-ID: <20260816144556.69009-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816144556.69009-1-philmd@oss.qualcomm.com>
References: <20260816144556.69009-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=EKc2FVZC c=1 sm=1 tr=0 ts=6a81cd46 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=uRxLgUfnyXHAhkBXUOAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfX8mrfyjssQk9i
 5tJcsdHe7G2pd21DY7NKaeLbk0eWNshjYUBqNeQxRyeAq4xKFPGRgapAUW18gnjr+i2jjWcOx7b
 FiRX3SdYnPOCBPQ1MdpYhlodLKqEdkc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfX5OnFhoLG+aM7
 FwKeEMHKUyXBOu2+ybFr4OONNYCkPUACMqcyAkzORmPQya0JlgpyG7f4JQczTuSq1ecrOgO+GIa
 z7Zmz2nj/TauvE0bSIjruPM9apU24NAGMNVX3NLwo2/d2E1+fn6/GN5gbugfB6Q1thkvT0Uec6X
 iv8v8kTytOeBxwphPihsbuNEBAxtlWO+8meojO7uQSAtrNWToUsFXjB1lKIwNwj4q9KpA2TiBnc
 BArNBJCv7R4V/w3wSBJYpQQ5B4mti/07Ds9FbP1P0XAwXQbfGkbWyZeJYhdBZzm1+wqmxZh9pXN
 UmnorYFeILhwcGHO+yKNwe5Y9tXVxQjgYbDLbeCUa9PvePbdXSnjEH0/DRwELHiWMJqYpo5HLdQ
 TQJJyhCydQwU0VPU9qY8tmlGxmOYTxZOxjdRG+ln+zoeVSfxhqdF6A6N32sTF38lamuDWYgAo6U
 XOZAMgToKv+3NcX8/Dw==
X-Proofpoint-GUID: wJWaFOjwTrFTVCtFb5Pj3901i6oqBNwr
X-Proofpoint-ORIG-GUID: wJWaFOjwTrFTVCtFb5Pj3901i6oqBNwr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608160118
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

DeviceState fields should be accessed through qdev helpers rather than
directly. Use qdev_is_realized() instead of reading
DeviceState::realized directly.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260721-qdev-v3-3-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/hyperv/hv-balloon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/hyperv/hv-balloon.c b/hw/hyperv/hv-balloon.c
index 9dd759f11e8..b8664a246b4 100644
--- a/hw/hyperv/hv-balloon.c
+++ b/hw/hyperv/hv-balloon.c
@@ -197,7 +197,7 @@ static int build_dimm_list(Object *obj, void *opaque)
 
     if (object_dynamic_cast(obj, TYPE_PC_DIMM)) {
         DeviceState *dev = DEVICE(obj);
-        if (dev->realized) { /* only realized DIMMs matter */
+        if (qdev_is_realized(dev)) { /* only realized DIMMs matter */
             *list = g_slist_prepend(*list, dev);
         }
     }
-- 
2.53.0


