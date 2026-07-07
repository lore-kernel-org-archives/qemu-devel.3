Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1170DC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:16:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh5eH-0003UW-Rv; Tue, 07 Jul 2026 09:15:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5dj-00039u-21
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:15:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5dh-0000dR-DO
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:15:06 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667C8sZQ3768510
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 13:15:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xW2W2CaLt5ue0nvSEVBxu64kgHg6gz2jW97XPN0ehCE=; b=C7CzVWqwqdHZZKVD
 sz7XblS1lIELGTQ2jfR7MZ4JP7kbHnO1tVH90aXbdLA7MHr4KCHQl2SRhBDZfCOo
 KigGbo0am0P9m17FADAzxGYuwxJXto5JXUC00vb2iWivthKFxprOfYjYPY/IbUlz
 E7kGrOSZWf00XoTPbLZ3WSyQVRQCG1FZ1NrCC4tWmau+mBUGPg5pJ1LgMMHiOgkl
 iOn5P32FUdVjk6pK1xZJuCq/hsxNCQsJjeNL1N8b2dNC9J+nHmBOuG+q855kK1/w
 B2Rzxgzuol+MNe/zu4mGzGO/EyNxc7mNFMvviCL/+91LxdF86eALJA2HEsSQ186d
 O5u4hg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8qj7ak6k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 13:15:04 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c01ff996dso56811661cf.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 06:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783430104; x=1784034904; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xW2W2CaLt5ue0nvSEVBxu64kgHg6gz2jW97XPN0ehCE=;
 b=AYAXn7SWyNIClTvcdh2NVp688/js0xoK7NxdAct+fr3Y5wFtow2Wx4fZZP859IPWi5
 gy4KRaE+c+FB1f8R5YqX/fCUycZxAqdF0YReOGMogX445NP37XkQxT1eetFk1yJJX2PJ
 4+xciz/ogCI1O+H+hupd+u+tvgVinBYzJ9XbeRPxDhN72ZDxa/T8hNKONrqNXTKCxO5I
 1Xpr5vvo2cBL8fM8T5OgTNhM4p6oNISpsdfMYfsJubQh+1ZfwfqXIk5zJSGCHUXp36nT
 H9VsVVd9xiCLB22z7eYzwH69aC14bzofcWyIQ48Tl02R6hA8o8YJY6dNbJIScCczY/Kx
 wruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783430104; x=1784034904;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xW2W2CaLt5ue0nvSEVBxu64kgHg6gz2jW97XPN0ehCE=;
 b=rgph5ECybwp/7+1m6h87jKqKDkywytjTtozaLUHZ1Lixr+gFbOT32EsI817zxOg+ft
 5cNNf04FuYekVm5/JhdXh1rzRlFbgJ9/1jGTXogZat7hjR50kB57O/s4aDxKYq6ZfseL
 /V/dtkq8/VMRpCX9CVyXCB6PN5EIi8tBjV/0QmJJoj1tmwCPHRhdCR1j6nfN7IpkQYVM
 Pn7x3AhSL0y/WXjcZUqTPlsuIhGMvNOdX5yk2TurpiDOLFlusPnounOfvxOhwQwZQI3o
 QEOttYNYfg3Cy8tzX/kC2gabK0g11xJX0Ks4fGKHCXjIRWEsGHOoUk8qeFWQzQaN0LGm
 Cl0g==
X-Gm-Message-State: AOJu0Yyc21R9QdXVQNpfCqOEb4LTNiQjjQuSW1Pldy+fO8Z9Ha424GKg
 JkxZfTckLrcXqrBP50LSzMnCS8MLdQrD4Tq/pUc5jQpKzrW07y7gb2bFM22NyupB34xdQ2lLNVp
 TVbdLezMlEwoQnD05ZKT14D9tBg/9bRcO4nSyQ6Dr9TGT9UK+MQE7uBq2pfNpRNp4wQ==
X-Gm-Gg: AfdE7ck+kAAGpvaYijI7zpYo9+X/7k71KZh4mNZWdL0V3rsT0eSIxma3L4fYZ8NDhm+
 UO2dxqp3NmJhwErDhOKXzQteO3zDv+qBJcPsvBLglBQXgiecpiq2raK5zJS4HHYfZZSdjRzx0Tz
 Yo8Hz2O2JGqJ2/I7kR+pTHW2cuj/u6R5ZDenxwq2TpivINSNf9kRKOWZoc2+aEkahUVGvcxtTiB
 0LaPumR59SJmZazvUs4RKykE3VrlGZK50KAT71KzfDTLTq0nrdQKB1qNXNHSvtqL6zE+fLgYLj6
 7O8sZ/r6Wn/Khx+tnK6ucjb/xY/0uLB6DhW9eC96CG9sv3s8dyUuLjcnssPrxyzbXMvfj0ZEdbt
 ubwEF7AXrsF4CUA133ZXzFAQa4AFtGwG7YTkByJMWVv4msiNtEBIWTIw6agORUsIhLKru
X-Received: by 2002:a05:622a:144b:b0:51a:8c99:1f11 with SMTP id
 d75a77b69052e-51c748af0d5mr53589591cf.64.1783430103490; 
 Tue, 07 Jul 2026 06:15:03 -0700 (PDT)
X-Received: by 2002:a05:622a:144b:b0:51a:8c99:1f11 with SMTP id
 d75a77b69052e-51c748af0d5mr53589031cf.64.1783430102992; 
 Tue, 07 Jul 2026 06:15:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15ad9bcc26sm131739566b.34.2026.07.07.06.15.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 06:15:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 22/32] hw/rtc/mc146818rtc: convert date from object prop to
 class prop
Date: Tue,  7 Jul 2026 15:12:12 +0200
Message-ID: <20260707131223.51505-23-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707131223.51505-1-philmd@oss.qualcomm.com>
References: <20260707131223.51505-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: fad-KFsJHIUKAsIfVXJ_cDY9WPQaedMp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEyOSBTYWx0ZWRfXyJ4sXOUUkO+6
 JuyPP8fwHdTGseRyWxM5MUFXw8gPnYxuCQBYMW3CqZyDNtUxoS2pTqCu3uhCX3zELLtM0nPOmhP
 eMmDdAzKBBh0W7DNGvciq65/xrAezM53XsGwJhw4/S2xcoXbCtfRqjxGdrDa1pRkJeLmSFD+1mm
 qkA2uWXsmiHgWJPaMDVmPvKu9gLkeWX1DgFgpLk5UJTDKiD8h+r2s1kzbgX/9/7aaQuW6FoBuJk
 h+a06qZQW4cL+gTcAbD0wbJDf9w54WnmzaEZp6nUpm51S4MpJDAaDArJ5v2KgtPrHVRBxfl8NnX
 s9LqUucZXVe8VjQKcwaUYw9fTa/buTnm9O2m7rT0VfuMTh1eqqufpTig1YyG6mCqcxOPUI/qrqE
 TK1GfEqkZoHbkc5SARqW+Vw+LBSnlOBmtuopjRh+iqDujmAgXUlndIW2Kr5pkYG7oWvNpm4GJyp
 2KEQvqX3M7WrnBHeL0A==
X-Authority-Analysis: v=2.4 cv=PIM/P/qC c=1 sm=1 tr=0 ts=6a4cfbd8 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=64Cc0HZtAAAA:8 a=EUspDBNiAAAA:8 a=jAp_HAs5kC137pZsH9gA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEyOSBTYWx0ZWRfX/2U8Qv6sTHGo
 yq1qFA32u6gtncpw+x4fQrmH02m6K0P/vOyDbgtxvG0xGMz6EH4nuTn175VTCuYlN+fQvGd5sh7
 Wk0gFZ1D2y6kWeLuQBaWooc9mjhb+Nc=
X-Proofpoint-GUID: fad-KFsJHIUKAsIfVXJ_cDY9WPQaedMp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070129
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

From: Mark Cave-Ayland <mark.caveayland@nutanix.com>

This is to allow it to be the target of a class alias property.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260703090814.2993188-6-mark.caveayland@nutanix.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/rtc/mc146818rtc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index bcab018c7cd..ba396435d1a 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -920,8 +920,6 @@ static void rtc_realizefn(DeviceState *dev, Error **errp)
     memory_region_add_subregion(&s->io, 0, &s->coalesced_io);
     memory_region_add_coalescing(&s->coalesced_io, 0, 1);
 
-    object_property_add_tm(OBJECT(s), "date", rtc_get_date);
-
     qdev_init_gpio_out(dev, &s->irq, 1);
 }
 
@@ -1020,6 +1018,8 @@ static void rtc_class_initfn(ObjectClass *klass, const void *data)
     adevc->build_dev_aml = rtc_build_aml;
     device_class_set_props(dc, mc146818rtc_properties);
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+
+    object_class_property_add_tm(klass, "date", rtc_get_date);
 }
 
 static const TypeInfo mc146818rtc_info = {
-- 
2.53.0


