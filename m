Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2999C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 01:37:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjS5B-0000w8-8o; Mon, 13 Jul 2026 21:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wjS59-0000vx-Gd
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 21:37:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wjS57-0007EV-I9
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 21:37:11 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DNnCoV2857112
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 01:37:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=Kd8Eb4TPq6TGCmHISZIVWz
 J/bylj6u/N6Ma63Q1ymtc=; b=GKLAd8RGmoQdQ1hmj0tnqxGHa8CmJKDiMjk6sU
 gQe7q6VsAiyTfamnyY6okMIWeWLqoERCLtjf9W5NlLCbRFY6c6CrOWTysoR9p0vl
 V/X60JdKVmr2GEI+Sg7Xm7qPkFpZ6h8iZurAIOHiYcayWbd63nwcLlvj9llq/hOw
 qOswjyHRUAhA+/15ZorJ/B7iLQAR7CWe3LkGLJpdkls8K32bb/k0BTkHUqnbBnnH
 CZXN4YHJYCwyMb/6rK612DbvvjrSB7KXazS26jwWzQ0Un6/LupLneuPwFH4IZr6+
 Wp7wAc+1ihP8YmSJUo6QBHp5Rmm4eDVCtAsVgtllhDdfu1aA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwk9u6rg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 01:37:06 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c8924f4d0a4so5642528a12.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 18:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783993026; x=1784597826; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Kd8Eb4TPq6TGCmHISZIVWzJ/bylj6u/N6Ma63Q1ymtc=;
 b=TbEtgGAJyB3nj6smjogTt41XETS9JgNFDVhxr7FWLqBMIQVY/r/R1L+kRBssnSEkj8
 kDZLMV9KFTgNscAbWnLuGdYvpwEIVC96pjb7S2Eo2+OSY4h/norZfePxMnUX34jZMzj3
 hv4sEd9fPRqRDxGXHeVBOzIax9hNxAOaMjSfsbHPtLu1q0UFkoiyQHv4TxJB6m0SjvNi
 TVB4i5hPHz6OIX6ftYvjjiEp+FOiJC6EbDLoxF3bszcM0PLOmUYpdKu1j0RYL8SayqtV
 Za9WJ7cC+qW0wO2RUtR5uuEcyQgbw342f7fv7xzQPoosdFIXXgU8yz5vlPf8zOSrWNlp
 pDcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783993026; x=1784597826;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Kd8Eb4TPq6TGCmHISZIVWzJ/bylj6u/N6Ma63Q1ymtc=;
 b=o00zrMHLP0uUSsBnSaY6W/oRgJNbKXpWUl5Vm2T37//r0Fs2nKDqiX1CzFbEFZIXxQ
 lVcFZSMTFsx6gf6Lb7hp9kyd+H+7DdNg1IWtqdii5z4u43KMb8eYnDaHMB3uSy76gXvQ
 BnfsjE2vjpcChvbiVKmUXWEmE7mSqLBnfMLyMvMKqOyctB1WseRQdMGAq1KVnbBaUejK
 q1BqTOFZreZhgkK/5BkLzwB/nrV0tBMmyuMZnB9R83NLd2+APDmaVRH5X459VSvTRvd5
 ZfrfPvqn0OcrqZNpEmLhI3Z3uQU2B/su+Ao/9bmAwTATm3fju3rZQ9Y4hb4MEiw0mxsF
 zu/w==
X-Gm-Message-State: AOJu0Yzr6lHF+s7Fczi270VgaP1rIPyPMx10Tw1UKKgakbpHMUI2eMYm
 MErkAqcBs78B0jI8iWjUlDj45xE8fZF4vwqIcO7CtWviLHdswBHyvLl3uZ0S0P9SuItl4X+SESA
 CXjMqsB9fdtogFezdjC1KIFfpvCCQ8QOkH3spKnIiXWzX2hKfvfqO++ndu60okGuB0g==
X-Gm-Gg: AfdE7cmhrYO32j96+R6uXJTYvb6Zxu4h6DVBtYlh6TLoKiDYYGXgcQ1vPs4K4yXvB7j
 d0iTHoE3z1JMrO0blsyVXc6POMA2TSm7NQJxCRI1H97uN6LbkDn2a3AK0edJVXTUeEJ/io9H7RB
 UVdTsKDYqfl2oC5V5TXxK3VKEoF4k5XVZ3uoti6VD+g/8Vf/LiP2DLH4KAWGOY6xnwLCpWwGQqt
 oASHgmc7qhmakDCMuInY2KHlqE7lfYRFMlVqYIb3KWHRoC9DrX23zq0jIS4t+Km+qGcG13Lf8+W
 2A5hqwTYrVz7oPOix/ci2Xv1lSCRS12/5k33CcorJwLfLRPJO5YOcymKRlpwjB+v+z0CqqX74wm
 8x3el4LNRE+kXYy+bk0WHHNkQLIBpgUpAkiah7l708SqJI+r7f2nLgcPD1l8=
X-Received: by 2002:a05:6a21:113:b0:3bc:5284:5445 with SMTP id
 adf61e73a8af0-3c1102894e6mr12418389637.21.1783993025737; 
 Mon, 13 Jul 2026 18:37:05 -0700 (PDT)
X-Received: by 2002:a05:6a21:113:b0:3bc:5284:5445 with SMTP id
 adf61e73a8af0-3c1102894e6mr12418358637.21.1783993025247; 
 Mon, 13 Jul 2026 18:37:05 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311b00048a3sm45014307eec.5.2026.07.13.18.37.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 18:37:04 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>, philmd@oss.qualcomm.com,
 Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH] configs/targets: assert NOT_USING_LEGACY_LDST for
 hexagon-linux-user
Date: Mon, 13 Jul 2026 18:37:03 -0700
Message-Id: <20260714013703.2280824-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDAxMyBTYWx0ZWRfX5cDg4UVp6x4T
 FdzUOp0MdFtExKtAHTNvQbajs2n2MMIB++3PIejwTmWmeujBD5lQ2aZikBB9Yqv7U3xMYKZn2Z/
 yF+dn0Cp8S3BqDNx/bNlxsR1zCOdue+4AEF3XIx1xxMmaHulxHYZZG9EYb27DtrdlCPEe6gq5Oe
 /1bAVlX1p7bF+b8y3a5Qa4J9kDcpxrU9LAYRjf4wpw4CW7V+MwOJpiZS3syUu9OfxRlCDuH1h1t
 1/XAbYF3gahD2+DG8sZqlJObJiOuZGmqGzka9g1v63EZKInFguLhw3Ys+XcRPK+ombNLvoumZp0
 CZKPiCg6LXb7eyKyjKT9FHPtsefOv8eY6wFmSy4S1dFevlSAN1Xhysgkl2xt5d1tSIYjcNLJAZ+
 ymXNZMPiSnvJ803SRCF/fhErms2BP+00qQhTNaNL0L1H8aeLVBSINIGE+347ZzWoDl8DIYEaLhC
 3xyv/qvf/oi2ceoaFaw==
X-Proofpoint-ORIG-GUID: ss7gCFAnzjT6TKky_9fxgMLtHsEjq0Fq
X-Authority-Analysis: v=2.4 cv=UMHt2ify c=1 sm=1 tr=0 ts=6a5592c2 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=8FFOUpvFhbDBBcUsCCEA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: ss7gCFAnzjT6TKky_9fxgMLtHsEjq0Fq
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDAxMyBTYWx0ZWRfX5fr15dAO+o0H
 Dk7rcVzQlb7fvWd1JT1E9aCrr4ukWk8cLZzYAHcH8hfaUKRNZ/IJ2I72M/mo/KnDEzaVH3VLTt1
 wC3pmsnOcuzlJBdgihh2qVWpGapL6QU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 clxscore=1015 adultscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140013
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

This is safe to assert because it's unused.

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 configs/targets/hexagon-linux-user.mak | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/targets/hexagon-linux-user.mak b/configs/targets/hexagon-linux-user.mak
index 51fde5d60e6..7870d17dab7 100644
--- a/configs/targets/hexagon-linux-user.mak
+++ b/configs/targets/hexagon-linux-user.mak
@@ -4,3 +4,4 @@ TARGET_SYSTBL=syscall.tbl
 TARGET_SYSTBL_ABI=common,32,hexagon,time32,stat64,rlimit,renameat
 TARGET_LONG_BITS=32
 TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
+TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
-- 
2.34.1


