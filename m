Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94393C44532
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 10:41:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm7u8-0006NL-Tj; Tue, 21 Jul 2026 06:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm7u5-0006Gd-A5
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 06:40:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm7u1-00036Q-B9
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 06:40:48 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LARJcq1385792
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 10:40:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nKCCKA0zIRI8NXWmmd7NgkQLUbPoU/2z9XYlcCoNbTY=; b=jLeHQ1rehMUeRn7K
 1alHth9tWsPDToZBnVsTFwzIjrPQI8SpeczCgVIAtmqVcfJr9UqKQOZl+doWMV/6
 Ct6+9fI6i0i39ku3oLYWNaSdyvh9kT3TaP31+YvgOLxHaS1AnToB9nh2w7WwHVwf
 kUW0TaSPEn4lhgIqY7RM5UjSFoywfBtVGbPpvxnFrFi6uTKVT4Y2dKL44ay9m5V4
 7LDQuAyi0ByXeXWYfVzy70Gwqb3D2cdmhZtL+tBXOE+S3UpMRd15V0f16Y6HnD+I
 kUz5z6zjV/lcH2IgURI9MVelB3n6Q7N/mNFgpLRh7V3kujUE/SI8bI+AgRv06d5C
 WtG2zg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj1se1n2m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 10:40:43 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51bfe3fa93bso228780561cf.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 03:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784630443; x=1785235243; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nKCCKA0zIRI8NXWmmd7NgkQLUbPoU/2z9XYlcCoNbTY=;
 b=dvaGmznmilLMYSu8XbXCFvHAamiEZcy7oytvd6QzbzZ2wIEw7aveCsNmOiF8Vb15tz
 Q55U70qc/RylmTFyP6mR31iUBg4Fna8D7XFDEEcNE+fqD6YBJfa/FG7Rt2ucpybwD/dI
 pWnflRG3qPMX+C7v+wgjZgtfnHkxXJLf/azB8taTSl2b6oXntiJMs9Q7KjvatKzSMJwz
 eOpzMA2CxGTNZ3ij41y9qJaJzN1TdBata7ybCUlB+2lgVuthKRFOIjySwqLSqbMDv//G
 RAMql/Exhiel+e+WrKz/RYLbC9XCs0FWozthF0yHqaiEApkq/1OnDcKozysH6LgTiVgh
 aqsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784630443; x=1785235243;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nKCCKA0zIRI8NXWmmd7NgkQLUbPoU/2z9XYlcCoNbTY=;
 b=LNopMsarnPmxGhzIDzIIRzCf1Y2cATmf6dPaC1ts7C9WIs3RrFaaP5l2XccbxkpM4t
 nxnAXNSGYj5hsQFVS6j/ixcMq4UEfE0CXZ3zUFOfwroWQ/IGFnPCh8yWmQUKscDIGJpv
 nfGrCRIrEr371F94YGkePDF/1ojS4YYr+z1xv2fr9OQhvVCXpPGpAXnc6bpmvcIwXmYS
 Dw3DysqBiC09ZUYw4UfhP4nc5u1X1RBK4DS3IziV2ncKvTVjnOIfaqUSBtVWII3cx3W/
 yiGSDJfztENTx4Rr4xv7Bbukk2rspcSgtPWn4ND2hmkmNx6Z7uCPPEMxdJFgBXKNmXnv
 2wNg==
X-Gm-Message-State: AOJu0YzLuE2ZuIAZT2lsFszJ2sBgq+SI4pFeHFQs1Gj8nfboULlyg4kS
 rAa94WcIx+JlDvZ1fX5bu+7BDy8GdbZwbUpV3LQHziY867t1mO/rBa5J8uHvdwRtjxogLFD9zq5
 JBAm14oFWoJwhShoaPLfWgAnqh2bPFHWm7dE/k8r9b24DasAkt6YxuKo/Ridg+XjoMw==
X-Gm-Gg: AfdE7clHkZXH5Fb2Mg/T80+ykF7pdIfxV6EMt8RKDKoTz14qtq5a65ZsChuL20R8R0O
 t9nJIgIdCFYY4myLhmrpKYedJZyiwFtZ21YiyQzvMTZ4fu5lEUpLvpfV7TeiWoASIxj/Bu5AWIb
 OFVypKuCwmbDUsuhyldFNDHRFCXPLx+CGZkkPXBHR0guHzJJ0ibyE5FbZ/tWsDCQWE44naFEix5
 Om16uoRbaSc/oTLzWNcY9+RDBwynOOaBQIWyfmmCNlwt6cvbIErXbaPgiti05aPVg2wSqGQACRo
 RYU6rj4QG/JekJBA5NeKRAVXv0VveUPtj5wt842o2ECN4YRv0JGqTHtplXit/DqUOJRki0+1Qpt
 qg9Ut5XulOUKAF55flnW1b3myK4DhqgT/UnfZAWHMu6QJn1tDZg8SmabWig==
X-Received: by 2002:ac8:58d5:0:b0:516:e974:6f72 with SMTP id
 d75a77b69052e-5213e082509mr172566241cf.50.1784630442806; 
 Tue, 21 Jul 2026 03:40:42 -0700 (PDT)
X-Received: by 2002:ac8:58d5:0:b0:516:e974:6f72 with SMTP id
 d75a77b69052e-5213e082509mr172565941cf.50.1784630442261; 
 Tue, 21 Jul 2026 03:40:42 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495653c98ebsm53232485e9.13.2026.07.21.03.40.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jul 2026 03:40:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 5/9] hw/misc/applesmc: Fix a typo setting MSSD key
Date: Tue, 21 Jul 2026 12:40:00 +0200
Message-ID: <20260721104004.84934-6-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721104004.84934-1-philmd@oss.qualcomm.com>
References: <20260721104004.84934-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: IJdwoj2sh6eKHmntRlgRj8SOAW0zT5l4
X-Authority-Analysis: v=2.4 cv=TIZ1jVla c=1 sm=1 tr=0 ts=6a5f4cab cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8 a=Kxu_bcSrytRNNWQTdi8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDExMiBTYWx0ZWRfX9eZ4EYGFn/Gu
 KMlinC2sl829hQg6dbUfkxeJdUHAznBADhzTCgsecxETiRcBoxZOG2n4KE11Ag4xmZ6ryABGDJu
 4uAor2M1DHWLqpL/TMRtyfgsOilD2PE=
X-Proofpoint-GUID: IJdwoj2sh6eKHmntRlgRj8SOAW0zT5l4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDExMiBTYWx0ZWRfX3oYRF4eMW5YE
 mseiY4UkNH19qRiyf/ZeJYHPjVlPt1XX4nQv5FzlfGbK8L0RrjaKqOl0+IrbASFPsjEfG3OC8/u
 Xc1hCUtpj7y75b7RnUiWDMBMVCk4mIJeqKfJG1fEgosSKYz7Z8JzEVbOghdCoWi/SPA7Bwn59FC
 8to0nWhT1WQznbd/m5KDAOHqGzkNNc2kwhmGE9nIQtdnsXsvTi6K8CpKFegJ4/CJFaDuzTJH0b4
 1xqIswhDjBkEBfiv0GO6Nrmm8AV0AQ/KyptrvK9FCB5TrJ0De8Vnj55B6tGpxfiMY3xzYgrvikl
 nisFZN3zAa9dm5g1fvtPchyvnTAPVwB4TC2Y3yGaNykDRuwuBWeyzpSHyYWydzvOQ7D0ikQCDIu
 xpd8Zx7o9CUDKyGozeyAt8DlEF/NJ7OEDmgcVJxEkRWr3DpTj9abMZ3oxVLLIlmiRdcFtqP7gKv
 dpwg2plXnYaD6lWnnbQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_01,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210112
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

In commit 1ddda5cd364 we meant to set MSSD=3, but due
to a typo we ended setting MSSD=0. Convert the two other
NATJ and MSSP keys to use hexadecimal notation to avoid
similar copy/paste typos.

Cc: qemu-stable@nongnu.org
Fixes: 1ddda5cd364 ("AppleSMC device emulation")
Reported-by: Matthew Jackson <matthew@pq.io>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Alexander Graf <agraf@csgraf.de>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-Id: <20260720115336.75063-1-philmd@oss.qualcomm.com>
---
 hw/misc/applesmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/misc/applesmc.c b/hw/misc/applesmc.c
index fd96f5f245f..d004e8b4431 100644
--- a/hw/misc/applesmc.c
+++ b/hw/misc/applesmc.c
@@ -333,9 +333,9 @@ static void applesmc_isa_realize(DeviceState *dev, Error **errp)
     applesmc_add_key(s, "REV ", 6, "\x01\x13\x0f\x00\x00\x03");
     applesmc_add_key(s, "OSK0", 32, s->osk);
     applesmc_add_key(s, "OSK1", 32, s->osk + 32);
-    applesmc_add_key(s, "NATJ", 1, "\0");
-    applesmc_add_key(s, "MSSP", 1, "\0");
-    applesmc_add_key(s, "MSSD", 1, "\0x3");
+    applesmc_add_key(s, "NATJ", 1, "\x00");
+    applesmc_add_key(s, "MSSP", 1, "\x00");
+    applesmc_add_key(s, "MSSD", 1, "\x03");
 }
 
 static void applesmc_unrealize(DeviceState *dev)
-- 
2.53.0


