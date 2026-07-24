Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F30C531CC
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 00:11:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn3UI-0004gb-IK; Thu, 23 Jul 2026 20:10:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wn3UG-0004g2-Fi
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 20:10:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wn3UE-0005tZ-Ro
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 20:10:00 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66NLeQ4d948638
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 00:09:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=XDejMCGub+n
 GkeqaCpvmWomnFERZGv7JTc+lL2UActA=; b=GqfATCrDuDVfAM1VuqSoAz8A1ku
 PmL46XzrapXdf00sheuhaJHShlUMB0O1NGn81KNck0T7yoDNqoLYieJVcE/Qqnxx
 fGSw8w3z9lohaTvQJOG1pByneLSqjVOH+Md5PIONHENc+E+wRgKyvKuNpMbPMH2v
 Jvncd5nMT33CliYO7wbwuBUdO/4pZenAT0KzMHDEFN/J0+hz3ktAOif3JENg80HZ
 iSiy6PxplGpvJ/dqY4ALR4KLtti2ZhBFH1KcFDfK5DJUb9nWdTTxaCcuqUiVri9s
 u/Ucp2A2CtI+XDhP+rZ4d4948OhLeodhGY+uH2RflZaNZAIsUxPSfwD//0w==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fke0kv2es-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 00:09:56 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cb48f41343aso761393a12.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 17:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784851795; x=1785456595; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XDejMCGub+nGkeqaCpvmWomnFERZGv7JTc+lL2UActA=;
 b=EwRn4fhjoKycuurs2vQ2pigowc9G/CVbhsrf516gRBx0VQiJmpVKksixXGG44FibRX
 SNmk+hyVC7C0/Vx8SvXVkqq/WaxcgMxRb+G3DSWa+/qeUUNriaYYuxOyfh63PQtXEIE9
 kyRJE8xln6G/04XbWYy1Ic8mwTKzIwbwRWTUC19WI2PzKfSf0xY+d+82pvaDJJmCNWoj
 HY2J6zhHzww5poOGmVz6lMgcKjjpGK7szxZigHLkI8ASs4nf585cbKQHneHhbU5JG6Wz
 p1202lbM771UoCzL7XWmj6Mx9zAon2P5OrDfRzMaLxPSNFdA9jf6c8gE+aRE+IX+JMyx
 MfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784851795; x=1785456595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XDejMCGub+nGkeqaCpvmWomnFERZGv7JTc+lL2UActA=;
 b=UGK6f51b8eNbHSk2nY0iFYNg4kX9xx84KcTe2AkYYuzTZJlcKGfRKGaSxV1dOBgbzS
 ktNAmdzOsTqUGPjVnY2GBjRlpL6s1wyD2967IEpq5MvsIulgcU+LCyl1iJFjtVIbhBTX
 lDr0IufI/A9y8DbhQKhq1jc4zzTUGm0QxG7mV2NjZqGj9rhSkwwsjTkjtg7dILvut56L
 6lXJfYpql6oZ2Q8LvftFv56Aq/l2xEEwC2RoUMKjBFQJX0lgk0Q4fgsWfhMMnYaq6fCx
 xeEjXr+OjA4T/3sKZ83jdTBmwy2suqZR6OfEMoYluPHr3Ri7GxI4bK3wGLwlglekQW27
 rzWg==
X-Gm-Message-State: AOJu0YyIaBI21OKdnt3LqGjdsu1yUJwsdveb1jTV5E9jZR7xguGVShOW
 t4GTe96ei2bRZasFSDfcEfp9fJI412oM3udp3BIf3qCtSQnBjQczg5RK3SqcVOwCxUXmoJzWmge
 NpTFntUhx7EF7UUUjVro1mjBHwU4ABn2x9eanysBxu0X1UUxGHGqydWFr4TYtpMZ47A==
X-Gm-Gg: AR+sD10tDoZ9EVn4R9fJXyMNNpy+B6E7htcaHsqUMNl47QjMZhUNx37ngdlBlzSmMMA
 9Hyre7Lil63gTpT0Z9J200tfrmmnrIaSP8Y/3FaRtWwA4yh2hQ+fEso1N+Gp31kkwTHoC8f/H5I
 0uhbgFeHo7BOyUaIN58hQCg+loBO2Ro89D34VIr0Z18HOX4OczsGLz6kiZ/r4W5PwODekxl72XS
 L/ifNI79jtmAdB2zzwCKbvWaZV8HqYmxqy9J4/Z0XckdzbQw2L+5BPIVXZaqwEZ8ezVCS8eNRZC
 GLvC/WQvzpGIoIAv+7TpW+YjbBssdt6FTwBZ1pxXqCYGwg19KNNaKahjR1FPPG22WBOZhiCekNb
 +wlbUAsudkjLrs1FixneMsy2JW8y4hzoCA7wWFf16tcLWlgPZrrUUpta1qEZ29xMFRZXGhlI=
X-Received: by 2002:a05:6a21:4902:b0:3b2:8674:9830 with SMTP id
 adf61e73a8af0-3c44c9c4d3emr5561580637.14.1784851795429; 
 Thu, 23 Jul 2026 17:09:55 -0700 (PDT)
X-Received: by 2002:a05:6a21:4902:b0:3b2:8674:9830 with SMTP id
 adf61e73a8af0-3c44c9c4d3emr5561549637.14.1784851795020; 
 Thu, 23 Jul 2026 17:09:55 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e1bc886sm24359478eec.26.2026.07.23.17.09.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 17:09:54 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bernhard Beschow <shentey@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 01/27] include/qemu/target-info-qom.h: declare
 TYPE_TARGET_SPECIFIC interface
Date: Fri, 24 Jul 2026 00:09:21 +0000
Message-ID: <20260724000948.234657-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: -EcfeTGPod45bJ1V8lXprwnvbWTPGSEz
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDIzMyBTYWx0ZWRfX/n8SHh/lS8Yp
 2ZLyaQEVAY37WX/W2pHUgpsjS4L+JQ00HbGUtcpWL7umdBLTdRHL93Cdxxjgc9TakmM+KKt7RwV
 arQDenKVI8igqxuT+J5PSu1RAtF3no0=
X-Authority-Analysis: v=2.4 cv=S7DpBosP c=1 sm=1 tr=0 ts=6a62ad54 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=8RmDvF4nTs18L3LhoagA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: -EcfeTGPod45bJ1V8lXprwnvbWTPGSEz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDIzMyBTYWx0ZWRfX2zNKS/fbh3Hm
 BmfjdaD9NghP8bf6R+FCu3wjPMIaq5iZVF/APy0WEhkSXbuM/3EGCQOTzU3f65E/eyft0H+0G2D
 2RLIpnPgZL10XlwLZTU+CJKUNtRqRCt99GLU+RTCMlJzMh/Y0wnt6xibZ9jZtLUb+9F0togAmI/
 VtkvLxieHIA1N7hjqlvQvs2SXIa6zkdxWhU31RIOjZfqjD8VwYowxCr3RT7qJE0HYAqbwHhTIEm
 nBSD4YXXBlUbyoWr37pDBt1hFJvpwjbNYyi2XQuJUokKf5imABPQMvSpNb1FYtwqpV6sHoiP7Tv
 Wslso/6N8amJC8RKtMzLpMgeU2q3J4iugAg7gwjcxmXnR0l5D+4ezn7OPgNezpafA3IOD6dBfr8
 GkPRWUxuUHhqg66ffwjb4fZyuNbk9S1hZxHhj+QyQPDlrnSt4KU6fb/QldJFtz+Me0X64z0bzU2
 O+l4i1KxquRc5IfijgA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_07,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230233
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

In the next commits, We'll replace the logic to filter QOM types per
target from a static one (based on INTERFACES) to a runtime one, based
on is_available() function, that can be overriden per class.

Introduce the new interface we'll use for that.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/qemu/target-info-qom.h | 15 +++++++++++++++
 target-info-qom.c              |  5 +++++
 2 files changed, 20 insertions(+)

diff --git a/include/qemu/target-info-qom.h b/include/qemu/target-info-qom.h
index 91be415ed33..83eb537333b 100644
--- a/include/qemu/target-info-qom.h
+++ b/include/qemu/target-info-qom.h
@@ -14,6 +14,21 @@
 
 #define TYPE_TARGET_INFO "target-info"
 
+#define TYPE_TARGET_SPECIFIC "target-specific"
+
+typedef struct TargetSpecific TargetSpecific;
+
+typedef struct TargetSpecificClass {
+    InterfaceClass parent_class;
+
+    bool (*is_available)(void);
+} TargetSpecificClass;
+
+#define TARGET_SPECIFIC(obj) \
+    INTERFACE_CHECK(TargetSpecific, (obj), TYPE_TARGET_SPECIFIC)
+DECLARE_CLASS_CHECKERS(TargetSpecificClass, TARGET_SPECIFIC,
+                       TYPE_TARGET_SPECIFIC)
+
 typedef struct TargetInfoQom {
     Object parent_obj;
 } TargetInfoQom;
diff --git a/target-info-qom.c b/target-info-qom.c
index 7958a5cc685..1388691657c 100644
--- a/target-info-qom.c
+++ b/target-info-qom.c
@@ -16,6 +16,11 @@
 #include "hw/riscv/machines-qom.h"
 
 static const TypeInfo target_info_types[] = {
+    {
+        .name           = TYPE_TARGET_SPECIFIC,
+        .parent         = TYPE_INTERFACE,
+        .class_size     = sizeof(TargetSpecificClass),
+    },
     {
         .name           = TYPE_TARGET_ARM_MACHINE,
         .parent         = TYPE_INTERFACE,
-- 
2.43.0


