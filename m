Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57DC5C44529
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 19:25:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wltbS-0005Gn-8M; Mon, 20 Jul 2026 15:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wltbQ-0005Fi-Vs
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 15:24:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wltbP-0000Ew-7o
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 15:24:36 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KHC5ht137594
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 19:24:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=HXibsLbq1eNHg/KEZ2srTMftmDT6exvhPjO
 HSQmRglw=; b=BfxwtX4wucnF0nN40Vb5sbIcznHlqZMFk2+NTdWttuRUB9UiRPk
 6wtF8UacLZdCHIo1TtjSyQGx9uzNRcs0rwIW62pvJKp6JgSygt3sKiyqn5u5UHFL
 YVY3QZaeTzgfIAkrjW8YcDEM4tjrxHOO3lR292IC7BvvoN2pYtP2oKEFfaXzv5GP
 y3f3uZad4+YJVpHa/2U8yVXbPk2zDIqYbowqMzXaKFTRBZX3RJTFWxq5or1Cbrzl
 iAZD56UJYA2c3Tvp5oSheqGsAdZ7IszFCVNSFEKzF+pWCWlCXvf6k0gz3UjBtk2x
 zZDVYJeBZXmiRBJDHaQUIE0ztwx3DRRvY1w==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhqv5rh94-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 19:24:33 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cbb6433e9d4so66965a12.3
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 12:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784575472; x=1785180272; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HXibsLbq1eNHg/KEZ2srTMftmDT6exvhPjOHSQmRglw=;
 b=S/21dcVy9cIdfBWMgNPb0kz/T3q1Jbltkb3hy3xsBoCdndU01K+osiNt08AQRC3axo
 wRynV081uBxRoOxoLpQ+rFrNZOxfDj96sWU6igHWLUYXH+/C2yH4UDkWCx3EllhGorJg
 cXeJNvPsnDtanBQUBRDnM8GGB4GmyvtBECIhOzULUPS5YYwIVKM72YLJ/wVUjWGOqWQK
 2TPff+8SqsJ27kr91SDuE/EzZy1e/EEG3XMCIUolRW+6PkIxRkCEVuM+3FSY2xTYim6L
 NXiY6wPSI87PRDYR1gSvFi91v6mgxCwDCXnntg6kwE1CTubjfAA9n7qJlVYaP8JRYXIV
 uESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784575472; x=1785180272;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HXibsLbq1eNHg/KEZ2srTMftmDT6exvhPjOHSQmRglw=;
 b=lGbjSJ8Zw5SOVbf+GZbYYf1Jj5gDQPE490jrDGuTZgXLzFaozo1eGS0foCOZGPS37c
 z/g2yEEs5MhiDuV/srNL1iDDDLI7vigtPCc1KENdlulcGvlpR7Kax6kvIbKOn0qT29Uq
 XYw5RgI8aoH6Yp6s0TarI+bYQVK2r8xK58aKEZBxAu2lmzhFFrUaJv888vs9lOPviIMM
 2uPUWMWbFDB0Ay/rYzNZ1z0hTZAGcBupmsGJneHt7mVO152Qv98MWXOY/Rq74GwahKyq
 23VlEfrAvC2Vh0VGDuQZrVhRLGw/jz8f/HXSFV4gwkV6OHLAgmZDGKxqD0qqagYHZgMM
 zeUw==
X-Gm-Message-State: AOJu0YxqYeg4n7vJoTTzHWlilv2DsUxFTfV3ZYEfUYss16+fQxennpMj
 gql5kCg0YPaLw3D/hQYh6DXZgObMJ7KW2W9aouKpWUgvTduJIwXUMGzXdA2FW366vZLYN4B/K0R
 8xtSe7yGeBogxeKCACzGMPyAFcztEESGn0HrexTWP32ZbHnZcSjO0nCnCCv0+wLtOeA==
X-Gm-Gg: AfdE7cmmJYjBMY813PCdwwfrG9lugUvQe9yZDNCGuLg2HoStBu/qOLtW4JT0FWBg90h
 ALjW4R/BP59uDCNzHRb8Cfh9WH3totYowqMzRToRoOokoDb1raGk4WH0sRu4UBgICZ5nNU+GxFt
 cd3rHEXcRb9qxg917WTSGcr4c1IpKt+DdOqHE3jMW7n3c2N/JYM/d25WNMVjGiQ40WFNq64SemZ
 n8Okm5CgqjrQ+8IyLLAh6dIRgzPGhy4U4Lpy57jUy8pLBY2MLcffIUslw5I8dLtA1k+1Tix7DQM
 bFR4SzT1OV8W6XrZJewrRaPFjf81i01KpuSKvLS51lu5ANWpGHyyjYdAvNlfPk4ZUvDtx3QOEUM
 uNAXmjLxDnYjQclI7dW+/EweJwr/lEmQH110x7/bVGUccni1U8RWzoJXZnMOhU9N3/hPie3o=
X-Received: by 2002:a05:6a21:3b89:b0:3c3:64cc:311a with SMTP id
 adf61e73a8af0-3c3ad64b57emr16978687637.22.1784575472503; 
 Mon, 20 Jul 2026 12:24:32 -0700 (PDT)
X-Received: by 2002:a05:6a21:3b89:b0:3c3:64cc:311a with SMTP id
 adf61e73a8af0-3c3ad64b57emr16978662637.22.1784575472102; 
 Mon, 20 Jul 2026 12:24:32 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a1bb770sm42709799eec.16.2026.07.20.12.24.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 12:24:31 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org,
 Chinmay Rath <rathc@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH] target/ppc/cpu_init: make cpu listing determnistic
Date: Mon, 20 Jul 2026 19:24:03 +0000
Message-ID: <20260720192403.66694-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 20thZxwF1q0iU5aZF7MEbEUW3q5Pb4bv
X-Proofpoint-ORIG-GUID: 20thZxwF1q0iU5aZF7MEbEUW3q5Pb4bv
X-Authority-Analysis: v=2.4 cv=e+U2j6p/ c=1 sm=1 tr=0 ts=6a5e75f1 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=r3LtdbDxSBjJ6MmgX84A:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDIxMCBTYWx0ZWRfX9Wv4rNuCq1g4
 WyN577/KEUs/A8NGkZzD128Gpxrp5YBh1jOvz/Ym75TiMmzk2BRTSrZIQ8jUKdhP8VOvVwsAPxb
 9zczrJvkTFbnvMFSnOuU/qfH0pfl4gA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDIxMCBTYWx0ZWRfX0rOMy71nv6wL
 1vT+/mzkgbf/3L0RVawEoP6zl4vwhckuB0Ch8fKG4odldU2cQHrwPfE1IBb4NV7iU1Q7lEv/FJG
 aYBndpI+h0+OBcMIZWt2N2UuP1VYzeHahIiINFBxebh4A13kmc1gQGbY4x0fmSzVqVt83OQRMTD
 c+fJbaapmet9arMbVyMcaitz4n6WXf96utasbYv9bVmo18aBF99oX2XnWo7nv8O9laYIfsjDtML
 xqsBaaDyZzYDT9PHl4wc5Mq3GNJPwEdhjUQO8NQFfhRcydsjQMo9V39sZ0gN9DzkJc8x53fUpUO
 IhKqql3ZV5FcQo6Ephoq1sIc7sWEfaBahkwHtUOmlxYEiPzrOLxmcqCPe/JvUAGIhZRTzVSS0Uu
 YHqwbufq2AMH0tKNCzK1HvB+gqWrLdAjISw7Vhaxaw5XXftXQaWFDe5viZRo02gTvTTbgsvnF0m
 22nCBpxH8q0oKzmTqFA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_04,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200210
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

The existing compare function only make sure that we list cpus with PVR
order. However, we never compare cpu names.
As a result, while cpus are grouped per PVR, the order within a group is
non deterministic. Depending on QOM type initialization order, we get
different results for -cpu help.

For instance, previous output could be:
Available CPUs:
  755_v1.0         PVR 00083100
  745_v1.0         PVR 00083100
  755_v1.1         PVR 00083101
  745_v1.1         PVR 00083101

While a sorted output should be:
Available CPUs:
  745_v1.0         PVR 00083100
  755_v1.0         PVR 00083100
  745_v1.1         PVR 00083101
  755_v1.1         PVR 00083101

Fix it by comparing cpu names to have a stable result.
This allows us to record and compare various command line results across
versions to make sure we didn't break anything while working on
single-binary.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/ppc/cpu_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index f404c7e549d..3443dbeeb01 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7130,7 +7130,7 @@ static gint ppc_cpu_list_compare(gconstpointer a, gconstpointer b, gpointer d)
         } else if (pcc_a->pvr > pcc_b->pvr) {
             return 1;
         } else {
-            return 0;
+            return strcmp(name_a, name_b);
         }
     }
 }
-- 
2.43.0


