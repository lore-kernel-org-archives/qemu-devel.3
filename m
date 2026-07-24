Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2934C531CC
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 00:12:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn3Un-0004xf-Pq; Thu, 23 Jul 2026 20:10:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wn3Um-0004xC-2z
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 20:10:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wn3Uk-00069l-Lu
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 20:10:31 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66NLemvd1175201
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 00:10:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Epx1rInf6Cz
 DiZVyajb0rXR/6RFyqeyp4pwcRaHoCi0=; b=iOO9WBfMFuvxE2p1TJQmc/x1nuL
 Ur7CMLZ71ATyWL8DMs1Gv+AaIWGcl43tUVLojas7WRyUE69WH5jTVfpUsI+N1iX2
 ZvexC3Iz14h/EdwfgqmLhisbFWWyAzHkjhtjTCgABTbcMujDzUHbCSgKsHMISz3G
 Pw4Yq+VZRWTUxN7TPhz3rs+uirYwDjbKlOaFS2U7iJHkxN84lWa8N005FHAlxSkb
 8kX6/BE31IXKuqO4MnrKt/GmUcKR324xFQGD3YlJY9xC/pYVefY0zpwJ4njOBUBZ
 k6PJI1V2d1wJ2gW2OP3Uwiz/xFHXyrr3iewwNvpFTu8Hm4BDJRd85YFTDzQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fktahrhdy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 00:10:19 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c89704da8c7so1823364a12.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 17:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784851819; x=1785456619; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Epx1rInf6CzDiZVyajb0rXR/6RFyqeyp4pwcRaHoCi0=;
 b=fNX8Z3EB3Bf++ZeHxd9s3+/zAUpRSR9ponkH/cPuevLNGuCRLqLJcNcTB8lT7sfjAQ
 ROh0pSnvsjmCpcirhya6SvOiODfYLjQV6xzyxbkDqkCFoIhzagf/wc/58ECU5+6B+YzW
 Tixx1Kea7Gf/ErK+rn6DCFdk9sIyA47FFA+ilNbUTTUPXAALp7hROXG7tzzpzGdjcPE6
 hjvDYHEPzigrTyRSLQiJpTF53m2q+ynyIWhJ2GZEeZvhdxzz309/2Eb15vTNkoM25zXS
 Zyj7UWbu3DnVJ+Q6qHtH/BgJGk5bRz/dVbru+4Zrq3F1z42FRARQeKbPcClFTi8OHuzF
 YHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784851819; x=1785456619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Epx1rInf6CzDiZVyajb0rXR/6RFyqeyp4pwcRaHoCi0=;
 b=ajGlNhvaqdy6EdkFUT8y1QF15Gdy/BSO0DzwxVH51t3Osv7vlRXXH3HGLSbvFO1hFJ
 ZloYAe55QSQ0BpvFCIGLcyB6TFfJ86cfjMA9T0agqi86ZxTrrrRhN8yCESs8TvRyaGMK
 ZbkFP5A2mgdVXCkjqtR3ONH/D9dUVT62ufFbXr9454tdcphaM7yJbgu2Ydk/bXxCbTKX
 yhpcMa1S66J/dDuB1NOSlU6KTo1aTTx+eQ7+yfBW23A8QaA86d3tz3wankWUARRBVFkj
 i4/gqDozjk/ksgHdB5lQoRQb2Ep9lzz7unTG1Q6yt2DdY14JzaHYaY6gRCnql7QMxuBg
 HukA==
X-Gm-Message-State: AOJu0Yw30xUq/RT/QZ34vT/7dPiqSyKrY1dBAJk9fY4pFvnqQtTs8rwM
 Bprp2BNKWs/slIzWCmPeUT13FRHxFbl2ByH9IyC5QRjvcnOLZOOi73kZ540rijBWg2itesnNE8w
 T6d0YCqBJg+NPSOBpUKqOxkyTGKOLDGCbC4HNZFvYo3zVje2bOnkkOUCmOsdPuNhuuA==
X-Gm-Gg: AR+sD10Qwy7Z68Aq/jXLtKvqTKMbB5Y7v5z7Z2zsDQ8yiT/mjdWS4yNaf82cPkcQkCd
 yloPnG+Fgb0skMV2b6h7ZYb515e+BvWIKBrJ2S9r56KdSqYfIZZ0nptBHzoduqPRJ8gkwYmUGlK
 JBZU9otBS1QnSaGJX10iCeHiJZ3Q1DB3w2xQK0/CMAjnOVFm1MhX8bDJQzEQhvCucs/C0htPHpL
 djiUiGOFgY4MTrM52E7dw54P8n5pWV2UPKkBTq10t3xfwIFIHxTgFTToLVDgbfEq81xAoBfpZHf
 k+4RbTefIA5EPthycMvxVkkTXTpbD0L4s5Ezbt8PmnXbxbOWY+4D7M4QR3dV+0ynjAhv2A+7QIN
 4ctNUdOOovhbMb9NU76KSYz0rdhytmg6idQkyKzx+tX9C/B6nC4o34gif3brzyB34x3zAOpo=
X-Received: by 2002:a17:903:2c9:b0:2c9:cf41:adf9 with SMTP id
 d9443c01a7336-2cfa71cff69mr68919795ad.47.1784851818772; 
 Thu, 23 Jul 2026 17:10:18 -0700 (PDT)
X-Received: by 2002:a17:903:2c9:b0:2c9:cf41:adf9 with SMTP id
 d9443c01a7336-2cfa71cff69mr68919525ad.47.1784851818366; 
 Thu, 23 Jul 2026 17:10:18 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e1bc886sm24359478eec.26.2026.07.23.17.10.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 17:10:17 -0700 (PDT)
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
Subject: [PATCH 16/27] target-info-qom: add type_target_specific
Date: Fri, 24 Jul 2026 00:09:36 +0000
Message-ID: <20260724000948.234657-17-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDIzMyBTYWx0ZWRfX87eI/uGfWikR
 4G/baRn4w4V/AXtw/MfA5S/9jKblU+wnQmmYfkwqvb3+63wHndL/rNmJ3wrDchlzZz46kJlG/dw
 oD4bWPTJ2fAktUcSFVRKDiYzgNAwVwY=
X-Authority-Analysis: v=2.4 cv=TvrWQjXh c=1 sm=1 tr=0 ts=6a62ad6b cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=PrF4plKfy3FfZIZ04p8A:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: -t4MMJ6LWSWTIcwiNsg3kW2NEE9cWHTK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDIzMyBTYWx0ZWRfX/3C7zOzAyDHJ
 k6ivjqrk3Coad0+oH+hXXtisSnmVKq9f+dBsWolDh80q/+W2ZpDfDO/DPDwMdDA6aAv4h8uCeEq
 k7q1NYCTJONpdLB+ZhiPrcDzI/SGYvwWYT1AYuCevZoTrEVMNzAvEEep3NtumCivrH5t8XxGFMx
 Sxm1C2tyKTOawHP3MC/oR5sKFvYag7AtAnsabz2WumG0FIwKy7JAaoIn+BdoQXZb8KgED3oB+V3
 M4AoREYzhpmxNboSi2yVlJyYOJnr7ur1DHgpSk/bZVN+icFTXSD/P/P3Qez1S8sF1BYzlJeaYNX
 ByZd5hDF35IAgErhVChzQMzuisA07gCIwbyEyHJQRDzAXTXzxzzaiM0pEzxpMJU9DiZmxUkKnpd
 hximC7LmZMcN4FjgPwxQ/jSNbi5p8TDwNdLDBEALSkdef+EpPIg4aPDjHLr1z0ab/aMneGbh+q+
 osN0pD9s+wZKY250AwQ==
X-Proofpoint-ORIG-GUID: -t4MMJ6LWSWTIcwiNsg3kW2NEE9cWHTK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_07,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 spamscore=0
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

We'll now clean all target specific interfaces. For this, we need to be
able to replace them with our new TYPE_TARGET_SPECIFIC interface.
Define a global array to be referenced by all concerned types.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/qemu/target-info-qom.h | 2 ++
 target-info-qom.c              | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/include/qemu/target-info-qom.h b/include/qemu/target-info-qom.h
index 9f175bed057..842cf241e0a 100644
--- a/include/qemu/target-info-qom.h
+++ b/include/qemu/target-info-qom.h
@@ -49,4 +49,6 @@ void target_info_qom_set_target(void);
  */
 GSList *get_machine_types_available(void);
 
+extern const InterfaceInfo type_target_specific[];
+
 #endif /* QEMU_TARGET_INFO_QOM_H */
diff --git a/target-info-qom.c b/target-info-qom.c
index 7ee2614b324..9089ef336a7 100644
--- a/target-info-qom.c
+++ b/target-info-qom.c
@@ -16,6 +16,11 @@
 #include "hw/core/boards.h"
 #include "hw/riscv/machines-qom.h"
 
+const InterfaceInfo type_target_specific[] = {
+    { TYPE_TARGET_SPECIFIC },
+    { }
+};
+
 static const TypeInfo target_info_types[] = {
     {
         .name           = TYPE_TARGET_SPECIFIC,
-- 
2.43.0


