Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D63DFC98324
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 07:34:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAjN9-0007Mf-Ua; Sun, 27 Sep 2026 03:32:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAjN2-00077T-0C
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 03:32:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAjN0-0006Ue-5b
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 03:32:23 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68QNBSTL2196059
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 07:32:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PtAkygZ0Bvn6wTQ/CU3tqWA1BcZzlgCTjGQS9l5/rPo=; b=lxtRQC2qPzJgZ+ou
 3udCJgHq9GdrTV1Hfdfl56d8Q38ntY8zIlL4UKJwv97AmpjxVYVpoa71W1ViUlJY
 G002hAMl5hwtuZdb4gTnhsGJXnaycGLxynBzLJYn8zESM1qK9E6w8yef+yKZTEvi
 91a7keIE9696OQ9m7AKnxvvne1q3Xu9s/jVLFJ+1as4DjaxACfYMpn00txDNTV1Y
 Fuz0T9zAJbSOys/oHYB6rSuXU3tW0hex+5IrsW4qXES0mYgtmP+7Pi9TzufTTUN1
 DzA/qHXYgt3Lws4rqofAXIO18k4Q3TCcR8nOn7IDVGHM5Okz1VBZid1ZcAkrhS72
 hA04lA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx3rfttc5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 07:32:20 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-939f248907fso211217185a.3
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 00:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790494339; x=1791099139; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PtAkygZ0Bvn6wTQ/CU3tqWA1BcZzlgCTjGQS9l5/rPo=;
 b=ddDDZLEuDv01I3aR03EhcEqhN3LGlS3HrdvosIilYrUkNEb594hMgivWX5zmLZaI49
 tAJImaKeNLYA5kqR/vOXl/dNVxCHhQwABaWg0R0mVLeIe1irgNzh19mkb0n4w4TP46Np
 U2gWoQlUqpFqdO3OTFmur4gxoqfwOztZXzGwRkLQ2Mi6sL/JXRdI/9McRSS3VNzLfczz
 DKQ02B1Vpb21cjJ709YGUkQtVFJAPC0tAt+ma19wL6UZrwwJmyPAPVtTeraNWEiLoLXN
 DAnrPwwUXJ3NyGe51w1aR+4DKFvAG4Ex/tYFgLxd+yKcvmMqfgOd/5O7oT1wpoyL1RuR
 sZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790494339; x=1791099139;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PtAkygZ0Bvn6wTQ/CU3tqWA1BcZzlgCTjGQS9l5/rPo=;
 b=BuxpsE9CwMfY22NXMLx8pyBvn4sshscQ9L3ml2XRZ9YZq8nu/MKW0Sv0MVEB3+sx7r
 WzjbA0r4TkRDTqM0fO1kkn6TwSRinZkvaEW/NlZIpoL2VsY+rE9XlvAuShMGZzBPoZeN
 Tn8BSHDAwEOA2C8DxIin1ajI9tzr5LDB8RHs8fDeLfACZaemIaAWxf7SCaVJwg1bw9z2
 vCfG6tTpKTXt84AoUH875bTTl1+fktMVem3bOZQxn7TNb3Ys0tQqjFVcur55HlMvhfRj
 Adgab3WhftBlEbMuZB7GoSS/tltxH+TOhD5P4JPZLh9nhVAx8IRtZPoNsYWaWNcnqbBm
 w89w==
X-Gm-Message-State: AFuF++mwd+VQi3qgBZzA+LnBc5+7otx6tLofFgtKgTTen3oWxjVwmE4W
 O0kiW/lQ0ar76ilecsCJ+BhHoKtsWC3+0wU2qz08kn4a9JA+gj69q144OCPduEaAuFg5ukQK0n6
 nq6h1kzKjUgzkPua1miKKDY0qk00LXMDSsE1p2csqBGEz5oAYhJmsfLVSTxIityLBjA==
X-Gm-Gg: AYBFou1N09ICUAy+DkEl2gBmSKR/hZJOJSMmSTLsOXinB0tOm3YFf6+Ojji6FS8UHT8
 v8ZE2Md0+OA+H/Yhh66pbFguUWWP9qHT6HhweFADkS4SwZGB3NE95xcNQ4/jXmfw3RA0r3sKxkC
 bEKx9Kr6nCVzM71aIIjY5cVLRS5PqZWYXCvude8+28O7Akx1M0PwUAg3Jg3dCC3848V8IuSHOyQ
 +emTcsPwRxt3/ARrL2YmQsDOrRU3ocnGyzn3+4oTo7uSUlhpDaAEWfArDL1Tw5ltPJHO2EdmygQ
 p+fKXhm239yXOXMdZyFn18a6XQ4sYUaoJ/35v+iku/GxvsDPOLiUgcJSepTjVhM2p7FHNMRazwe
 8a7bLBCo0hIgHNiTtdcyGgSVFdZWz4KyRamSm35gt
X-Received: by 2002:a05:620a:29c6:b0:93b:d7a2:dd2a with SMTP id
 af79cd13be357-93c43d2d07bmr1406998585a.58.1790494339189; 
 Sun, 27 Sep 2026 00:32:19 -0700 (PDT)
X-Received: by 2002:a05:620a:29c6:b0:93b:d7a2:dd2a with SMTP id
 af79cd13be357-93c43d2d07bmr1406996685a.58.1790494338620; 
 Sun, 27 Sep 2026 00:32:18 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a64ef3asm18939019f8f.30.2026.09.27.00.32.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 27 Sep 2026 00:32:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 5/9] hw/intc: use kvm_enabled() in APLIC AIA helpers
Date: Sun, 27 Sep 2026 09:31:36 +0200
Message-ID: <20260927073140.41422-6-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927073140.41422-1-philmd@oss.qualcomm.com>
References: <20260927073140.41422-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDAyOSBTYWx0ZWRfXzFOoBOSRGIrl
 KtdSGVkteiAAXZitePy3hw7q0lrer3EGbiStkeKupTGabYMuGkZOcxqDFWQ9JZGxiZ5Ie/oMx0g
 puc/inb4ukcf2zoO9XWrQJF2hbYQDcI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDAyOSBTYWx0ZWRfX3glcP9Aj0Wui
 ei5h8g72Ddi7QsozkhA3t3QNqzVyqp7QOANQmiC0a6MsYO8edWAN3vUnt+5y2DIXLKdgLzr5Bik
 hSpoNb0emRqXY0HIzTmwpimxG94yfmycUpBUqu6plKI6ocKwiI8EFTWkebRVIcyhvmz/ZqWtkUT
 fFSMfITq7NlfTY12jttsLyZ3wpJDgKlV+i0OH6M4R4M/G/sm4Y2J3n+S/6qnHeG9AqHVxWara0N
 HC1BuE8+eszIBFe9Va0DgQKKEb+0w01ihiIlNSnV1rP2n/KWBgzSBydUJEtjepo0KzKyyGVco2l
 a04TD2VmxvjHeRnk/BdKVhs4N8zcKO5BID9iNR1hwFgJUNTld/2XrwIuatPUpHRdRwl4N4EdEOm
 qJfYYr5qmwsGybn525iAH9r4aCKt2lIJMuSYK2OuciWg5RjTIXKM4vlO9h9XamYUe5oYQ7VdV1y
 KNaAS8EU5iMRwdaSLRA==
X-Proofpoint-GUID: 4yD4RkSAKg5dEV93jSu1ntroSb10Nhwe
X-Proofpoint-ORIG-GUID: 4yD4RkSAKg5dEV93jSu1ntroSb10Nhwe
X-Authority-Analysis: v=2.4 cv=K6G3jCWI c=1 sm=1 tr=0 ts=6ab8c684 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=aK4Vr543ky-C4wP0_eYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270029
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

From: Yonggang Luo <luoyonggang@gmail.com>

- Replace CONFIG_KVM ifdefs in riscv_use_emulated_aplic and
  riscv_aplic_set_kvm_msicfgaddr with kvm_enabled().

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260923131635.1894-29-luoyonggang@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/intc/riscv_aplic.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index d8e25bfda14..03a0852b8b8 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -167,7 +167,10 @@ bool riscv_is_kvm_aia_aplic_imsic(bool msimode)
 
 bool riscv_use_emulated_aplic(bool msimode)
 {
-#ifdef CONFIG_KVM
+    if (!kvm_enabled()) {
+        return true;
+    }
+
     if (tcg_enabled()) {
         return true;
     }
@@ -177,21 +180,20 @@ bool riscv_use_emulated_aplic(bool msimode)
     }
 
     return kvm_kernel_irqchip_split();
-#else
-    return true;
-#endif
 }
 
 void riscv_aplic_set_kvm_msicfgaddr(RISCVAPLICState *aplic, hwaddr addr)
 {
-#ifdef CONFIG_KVM
+    if (!kvm_enabled()) {
+        return;
+    }
+
     if (riscv_use_emulated_aplic(aplic->msimode)) {
         addr >>= APLIC_xMSICFGADDR_PPN_SHIFT;
         aplic->kvm_msicfgaddr = extract64(addr, 0, 32);
         aplic->kvm_msicfgaddrH = extract64(addr, 32, 32) &
                                  APLIC_MMSICFGADDRH_VALID_MASK;
     }
-#endif
 }
 
 /*
-- 
2.53.0


