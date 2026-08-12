Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 023ECC5AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 22:09:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuH7b-0004fl-Ig; Wed, 12 Aug 2026 18:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuH7Z-0004fU-Q8
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:08:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuH7W-00065u-0X
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:08:24 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CK2v7L521345
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 22:08:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=l2pHtcw6cs+AKkY8B0JFNG
 +8j0VxM5TQggghtzM8jss=; b=EkDWcHkPp7HqSZimlxUcBdM4fUqFO00eBoh2P3
 tAvab2adzawzS+k3rNHn8j6Q3oTdC35uX+lynpjGDTq8UpU615C1mmNo779Xza1n
 vBbsxn3CECYxw6C6ckRPhRkhoMl0z2C1MenaiJ+WGIxcq1yTdbO0f2cqIp90ncVX
 Vy2D+SRM0VEUGk9nmngSrbmNLrMu8VCDQUWopp3FKuwO8J1mVulxfZX5X3ZEB+Yh
 zr5oGWVEtFVKZ9YfwQ5neobcZ2pY0fkAi9V9V+/ZInDbjJC9604XOPP38VvgTFdx
 Bo7wb+cs7dp8zQOKJRwEBIFw/hQO1B9Zks/3E0xYT0+sPLDg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0xx1rjqv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 22:08:20 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-529ae8e96e8so14850651cf.3
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786572500; x=1787177300; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=l2pHtcw6cs+AKkY8B0JFNG+8j0VxM5TQggghtzM8jss=;
 b=KShLO+7C8FMKhw5nsn5N4RTNSk49tdieQj0ZnkSsbRGAQ1QdWXDlYpoxfBfaxwGZtR
 mpXmTEDgP1o+3jhjr9Vky5qO4xMhp39RvzsKUifIpytZ+TzC/mesCTPT60dExF51dg8t
 NpISbd88KsBP9/m/MTktR+gotbQhTHGSwV+ZOm7toDEmgXXJ9aTSG8dTrTqfCbEgwsDI
 ul1OR00M76PHQiRUBBQp1bo9fQWqi2FpbgtXTp+GG5RBitUsQYDY1ZoCHYOJlIfXdqzd
 6dMnuep7PTrw/jkZr28CQVGabotPcfucDo3XsC7OoJs5Bfou2XCK/MOOYmUVw4D3Lgxu
 b8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786572500; x=1787177300;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=l2pHtcw6cs+AKkY8B0JFNG+8j0VxM5TQggghtzM8jss=;
 b=tVPou12d2gIolQVDXSPLCTOoUFmJECTvIhALt3L6xH+jEQNDgWS3kTOtmoGpxhkUEs
 z6DrdiAEk8VUL6ZSI7+Qbt01RDstavnE4BNXNhXxmIJDdXCOsyia4n/WW5EHzLd/7xbk
 Xw+WoPw2M9dWTerWVWU1f9noVKjd9QsY2JvXCCcP0VEIvuY7UtV/1xt88c2ke3sWuy8w
 fEYNv3Ktu7viHU7RPNDBXB3RzxvspoTz6/pL20UQ3xiU00AxcqJsgXU90Eiaaoanng8Y
 lG7Ow47ksupwAqA5h+yhljsae4lP8q+g1g0X3gnNR83bol9utVBH5qpW3PQUnzs1DBlB
 JbOQ==
X-Gm-Message-State: AOJu0YwQTZ7KNfvYsRrIi53Jc625aHRFt/5hyh1jiEluhCQH+WayeVON
 7snR9npxxtYgj5g8V/SIEqYsFizV1BwfgV8JDny9TDcP3bEPVLcg3FcPVx8UAQ8ILXtYGejRKXS
 ripAiU54K8JCYxw+58/P1ZRMdXRih/GaOYLmNZ3wb7uCdlFzPBhrlCYXnIKQR0g6xxw==
X-Gm-Gg: AR+sD100u3irlm+X/oA4/OZ5juGVpEjUjw5PXUG7/k1j5XY36kUUcXfmpYbR6X1T9Qs
 IRJCEIN0GKcTyP4wzVJPQnCoVsr2CB8W7jzX08coz2VSmgDrZ9HmLsO0Uy6QH3OdJnO0WBYEnq+
 VszJiIrrEVo/uc3eHFEkS5LPLUSAqqsMPh+r6QMehq/5yVTBIdqGYWb1nuxTu+VcqydkKfBvVWS
 4YsV8BMkthUtpM1uK1f1wI4CTTZfO6EpBLtfbQRhDpJToowIrrLqbh+w0DI0NeTLOWg6SAwIOfC
 laI1fEoVjuJOoTfpPzl1us09oU2iy0/Dzw1qss2KvaRl2bbxYTFHrFnNYJF4vlIngrmyNrY3kxQ
 9XX+Yg7HpRszgQIa2HegY3sgwIrT8yP+AYnN6F95HWA==
X-Received: by 2002:a05:622a:315:b0:52b:71dd:c92c with SMTP id
 d75a77b69052e-52d73befa6amr14523571cf.2.1786572499782; 
 Wed, 12 Aug 2026 15:08:19 -0700 (PDT)
X-Received: by 2002:a05:622a:315:b0:52b:71dd:c92c with SMTP id
 d75a77b69052e-52d73befa6amr14523241cf.2.1786572499353; 
 Wed, 12 Aug 2026 15:08:19 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815a56133csm943051f8f.7.2026.08.12.15.08.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 15:08:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-stable@nongnu.org
Subject: [PATCH] hw/intc/arm_gicv3: Have GIC kconfig select GICv3 for HVF and
 WHPX
Date: Thu, 13 Aug 2026 00:08:16 +0200
Message-ID: <20260812220816.94034-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 53Xw2oTHKSebEPr78SXGalgt0YapmN8b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE3OCBTYWx0ZWRfX/vuCoST+ydDv
 0KoSnMatafJwr/Xb2dq+RlDLglfF41YVVEYY5F2UBhksqtMDvVdkba8bXAev+DwSleEgTbs00OA
 VKb6j3sYGV86cxr1d1lBPi5xdc7bhNCdlIRlNxyeN672QCKDkLhD0Wf1b7xb6QF7EZ8dNOp2Oo8
 gfCymM/JxKG4K+thLx0BlqitgV30Y9/as9LTqFQ+r+4CNkWMhzclVTNGLRU8HxKQ7j9znMrv7pm
 k0rxRQfR6Mue2aiY9l+9MlrcVUS8eRZ+DL2X09kIC0vEjmEimldKz2A0QmdcWTrGxXivTDI1AWO
 Hn4OMZYSJ1AUjhBkzZgO6SykacuavHJXpjAXb9011pbwYAR/+dXZ2o0G65Q0bMhlKxAEFVcbyYu
 tjugeM54nF0VCRBT5aiwXcEXbrtyZyxB/fy/4KiWeeTbqfyt3XnRR5wCxmLQ6bDiAUw2a2Hv4Wg
 CZvyYB9DfR4JnIqoaXg==
X-Authority-Analysis: v=2.4 cv=J6KaKgnS c=1 sm=1 tr=0 ts=6a7ceed4 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8 a=y3-W-MRV9Z0q8RYWwCkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE3OCBTYWx0ZWRfX5kgjoQJzdZG1
 aY1jc1/G3uOv5924H1ZNVzsT2Ngz65zlJBElXEbJtsoNPpj1NGUiFf93Bo/eu4yj0bn2YDqHCuv
 2szql5c+ZmDPVbg+drA5ibk/DTFo/9s=
X-Proofpoint-ORIG-GUID: 53Xw2oTHKSebEPr78SXGalgt0YapmN8b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120178
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

While trying to fix the GICv3 dependency on KVM and WHPX in
commit 39a8c3941eb, we missed the Kconfig ARM_GIC symbol only
selects GICv3 for TCG, not HVF and WHPX. Fix that.

Cc: qemu-stable@nongnu.org
Fixes: 39a8c3941eb ("hw/intc/arm_gicv3: Fix ARM_GICV3 dependency for KVM / WHPX")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/intc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
index 097de4efc5d..05e697967d0 100644
--- a/hw/intc/Kconfig
+++ b/hw/intc/Kconfig
@@ -26,7 +26,7 @@ config APIC
 
 config ARM_GIC
     bool
-    select ARM_GICV3 if TCG
+    select ARM_GICV3 if TCG || HVF || WHPX
     select ARM_GIC_KVM if KVM
     select MSI_NONBROKEN
 
-- 
2.53.0


