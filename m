Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70DE0E77170
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 11:41:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJAED-0005eR-Nu; Thu, 05 Dec 2024 06:41:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leif.lindholm@oss.qualcomm.com>)
 id 1tJAEA-0005e9-QO
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 06:41:03 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leif.lindholm@oss.qualcomm.com>)
 id 1tJAE9-0004zD-1J
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 06:41:02 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B56CUOk023344
 for <qemu-devel@nongnu.org>; Thu, 5 Dec 2024 11:40:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=M7KTB/IZkCpYGb7gNadiTGKEepS2Ge0Fwmc
 RjKncmnE=; b=IW2sRFYw1B6OOSqcXOq/dFZ4oodha/AMTTSBeU8XLZkQkp4pFAc
 36KJ6VYUq7+ArQsL3ZmmOO3A27YLKVDE6e/kfN/EAA7vrXm9JVF78jyrHURrHEWS
 UC4lauHw35ZZLmNXOCUVIra9dpsJdyHQnTkJlTvB8JzPMViCCwFM83e1DXpjl0jI
 IasqdHYZOmIJG0A5BD1KEOR9Jm/q7olldBB4LYht0nPwm7Bl6wktoQ8cmTG8VcI8
 xLJI0GgNyR5LcSHwfnQjdXYkjsfonidKMXIPsr/OMXbwfxl7uFSQIAQaXu+WgLn2
 Za/FeTDnlnGOcY+Vj4b3AJUA12aUnozoFYg==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43aj42c415-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 11:40:50 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-3ea3f5aff1eso781134b6e.0
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 03:40:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733398850; x=1734003650;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M7KTB/IZkCpYGb7gNadiTGKEepS2Ge0FwmcRjKncmnE=;
 b=ugTvlbIWjl9DLCpBDVRT1CRuG9pdctGnXpULlItf6Kxa/XIQN/b5AQyn8ulLO6Avek
 n/mhhu6S+gdj4Nm9FfetdO33UASzg0SacAxlh4pBOixTcgaBakBS807BZhL+hFbt4XtO
 eyx677U09PXWsRyVToybHp91ca1x3Q6jvRSkbYX7zJUxqsMSzV1IhYh7dQ/lAlmxf5mC
 w4FQIEGmvCB824UaHTN+JYieiBW7V40lj0FAsRGG08zfEA1fImIprM16wk1+r+SpnI3X
 6846daOE0MBXlY0TFcez7qF14KrCZE3KRn/88GHNHXTefKQxP0y7eWtlbd+rQaHWnHgR
 WIJA==
X-Gm-Message-State: AOJu0YygHhhi4mEpZwooZ/38wLZQeP2bYtyuvvwEl/CQVMYDK4/y7CSJ
 EK4KSweETrywImkG6HkigbLgyRLIaA0eSSnddJhFx4o2oruoOAaBrTjBVY4E03NwJtUveykagfO
 JIpVDCi2TjLwyjrfm/W+eCjSL1H5Jw869KbALomBLw4rtSzRxUTaLw5g9qJ58Lg==
X-Gm-Gg: ASbGncs7cKpdFBH+FkkcDv282j1VW8B6DvW/gaks8KgVzUojK2RIC8DvHWXlK8bV511
 UtBw1XeUkhdZmEU22i8RdhpvUYihLfeBQv+cdk8RCEVo1AWUq9AzfQE1x+j9zTzB5H5SCbvvnaW
 aA2GD50+EVPuJmbJbdXWouH+XjtwAvqptzW6sePpm4mNalxCYQqj/rRvMXjKIxnk6ug8g9jcgIS
 a0W/+bDuMEozVb2epghsPUpkUY6wqd+BcVISZiKCaHx+HdL4fZ+MG9ti5sCXjUUIjAJAewikHvp
 FXF9Lhl6ItA=
X-Received: by 2002:a05:6808:bcb:b0:3ea:4c1c:50fc with SMTP id
 5614622812f47-3eae50cf17amr10556207b6e.37.1733398850007; 
 Thu, 05 Dec 2024 03:40:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFr5yiW5kQcZ09nTRlFIpDLWf+CVjdNLSJfqfM3EnszmabOz3i1rvolnoNhUO5yXPoNFvo1zA==
X-Received: by 2002:a05:6808:bcb:b0:3ea:4c1c:50fc with SMTP id
 5614622812f47-3eae50cf17amr10556194b6e.37.1733398849653; 
 Thu, 05 Dec 2024 03:40:49 -0800 (PST)
Received: from leviathan.hemma.eciton.net
 ([2a0d:3344:101:e800:f22f:74ff:fe21:6f68])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434da119a96sm21434155e9.40.2024.12.05.03.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 03:40:49 -0800 (PST)
From: Leif Lindholm <leif.lindholm@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>
Subject: [PATCH] MAINTAINERS: update email address for Leif Lindholm
Date: Thu,  5 Dec 2024 11:40:47 +0000
Message-ID: <20241205114047.1125842-1-leif.lindholm@oss.qualcomm.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ncSEAd23LqHjIoeyPb_zkXtGZlFfKSyx
X-Proofpoint-ORIG-GUID: ncSEAd23LqHjIoeyPb_zkXtGZlFfKSyx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=689 lowpriorityscore=0 clxscore=1011 malwarescore=0
 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412050084
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=leif.lindholm@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Leif Lindholm <quic_llindhol@quicinc.com>

I'm migrating to Qualcomm's new open source email infrastructure, so
update my email address, and update the mailmap to match.

Signed-off-by: Leif Lindholm <leif.lindholm@oss.qualcomm.com>
---
 .mailmap    | 5 +++--
 MAINTAINERS | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/.mailmap b/.mailmap
index 727ce204b2..5f6df414e1 100644
--- a/.mailmap
+++ b/.mailmap
@@ -87,8 +87,9 @@ Huacai Chen <chenhuacai@kernel.org> <chenhc@lemote.com>
 Huacai Chen <chenhuacai@kernel.org> <chenhuacai@loongson.cn>
 James Hogan <jhogan@kernel.org> <james.hogan@imgtec.com>
 Juan Quintela <quintela@trasno.org> <quintela@redhat.com>
-Leif Lindholm <quic_llindhol@quicinc.com> <leif.lindholm@linaro.org>
-Leif Lindholm <quic_llindhol@quicinc.com> <leif@nuviainc.com>
+Leif Lindholm <leif.lindholm@oss.qualcomm.com> <quic_llindhol@quicinc.com>
+Leif Lindholm <leif.lindholm@oss.qualcomm.com> <leif.lindholm@linaro.org>
+Leif Lindholm <leif.lindholm@oss.qualcomm.com> <leif@nuviainc.com>
 Luc Michel <luc@lmichel.fr> <luc.michel@git.antfield.fr>
 Luc Michel <luc@lmichel.fr> <luc.michel@greensocs.com>
 Luc Michel <luc@lmichel.fr> <lmichel@kalray.eu>
diff --git a/MAINTAINERS b/MAINTAINERS
index aaf0505a21..9ae6a78ae9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -915,7 +915,7 @@ F: include/hw/ssi/imx_spi.h
 SBSA-REF
 M: Radoslaw Biernacki <rad@semihalf.com>
 M: Peter Maydell <peter.maydell@linaro.org>
-R: Leif Lindholm <quic_llindhol@quicinc.com>
+R: Leif Lindholm <leif.lindholm@oss.qualcomm.com>
 R: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
 L: qemu-arm@nongnu.org
 S: Maintained
-- 
2.45.2


