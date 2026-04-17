Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77315F436BF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 19:47:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDp8v-0005Zq-00; Fri, 17 Apr 2026 15:46:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wDp8t-0005ZX-0u
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 15:46:19 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wDp8r-0000YD-DA
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 15:46:18 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63HG4A553929269
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 19:46:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=j72Eye/A1LUJWfaARKpY4r
 js+hz3+kK9w1WcQcEWxkQ=; b=KQ2wsB+xC54EERJqEnJkCcdX3E06L53SeH8Ecp
 0OmtSE1EwNa7VsMjVutLoI/qSi2MmBF951tgOTNu/BODOAaRgQyEqD9wMZqTEQYH
 anaB2+AMhEnTS875/Ynjl1OmKLFk+DempIWVDH4XT2dBV/Q3vWOIe3xalWP2y9Iz
 cK5NFiAu0+XnFm3rpu9QLZChR1DMYqbalFw+XBljFYhHNyVeeUDU14moYo/j6wSR
 xknG+PUqVZkWi6YQjoXGbtPAUULAi5Yf6IGVEP8ltoyjPuxU90rdPttu7N3+WNG2
 QGHGWtahRVpRnUnLmCZ3TzlYi+NdAQPJhco72VPpK0gzQ4TQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dkqujgpsv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 19:46:15 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2dd6fb4c867so3146432eec.0
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 12:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776455174; x=1777059974; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=j72Eye/A1LUJWfaARKpY4rjs+hz3+kK9w1WcQcEWxkQ=;
 b=eHZd7FBFuy2llX++T7f94pjd+jpcCX2U/XAKFlUyE+uEpPVfEq2bE4irV9X2WZ/evp
 uRUTnkWCmfRdjRqwcGeFF6ZoCPXJ07mwuqY5KC6w9IO+lwy6J/3/+Oyawoa2RlYMmYl1
 kSc0hZqi/WmluYnmMOK+p2kPSCMuKxW/V2TYJA1FwpMUPlxiHW00AxwkAVOvXyc3yTV7
 /bMc7uMsiTG8Xuk+49wZ55Zw3OzrNCFU/QHHneisjTZ/coxhruP6q9LX3ubPprGNwY8E
 3QvlXDL8QrLs2YVy5qaYMa8KgYY2hONUUzieKQXTTe7Gb3VOE4b6MfmzgwaHcLUUXt/8
 JSOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776455174; x=1777059974;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j72Eye/A1LUJWfaARKpY4rjs+hz3+kK9w1WcQcEWxkQ=;
 b=hI58lf+5SYJ3WBLbbzdB0gOg2rKJhFR9CP3A3xIuYNk21lHbtIA6t/RW83ynSz735M
 aKirQi+N/G2rjHO8kU6ssMaDMmVYkF1JyKDxS5eJppgU/iYcK/7z5RWSXiHGwkMQugiD
 KccvYUxsiksXyldA1zYOv2e261rDyUoI/cwX7vmxu7y+ckH2Hf/ys2IgbHovYyfDoKim
 cwyAI8LDHs0RhxsAD4ueSQaW7eeSfh/wVFxdpSMvSFaoQ4QqwDjCUjlcFozMkE+OuOwe
 eVcfkMwtXgqWtgh0Hmh9/ebl63oZUHxr31J9cnXifbkLJEhhA0lYUTpgo55WxqZm8vB+
 f3Dg==
X-Gm-Message-State: AOJu0Yx/872i8PpN/vf6AP+0axrlIyhNJBOf6tEyYSjMpFy/fhaSTCHH
 +nxOXhQ3WoDXaCMiRAlF3VTWlwQmTfCOEHYsRSa9+SS8RgaPFYKDlmcvQk8FP/ZWkqURhVFQ8Oa
 71/4u4WINAjICub065Sx1ok56zpsccG9bJC1LPhcUjVQxzW2AyGEl5FVEpHfhcugE6Q==
X-Gm-Gg: AeBDietaxMUxMYRwkGRvlWpzJrgn5lJNGa4/oxg3KBWCUt2LLNmwpmV857gdLSIYO2Y
 1La+5OzMehxj28jDp48tnpo+eVKMupev9c/IidjRfMTCaOk59rZiJErtlYWRQtWHLeeuLSUJQUG
 m5D5roBete1NEFUeqvXOiJq1kmph9tgmV04jWMyfbIXalBN2FcydblJtu6qTEJzentxREd312B+
 dSm634qvHuFxdtarEbp+7z3iXB58DIOZEMcC5dUFD62NMyCo/FWaxeU+PIJ6wkV33nIrDi2CK+5
 6TrMGI26Nu9gOvX4Dq9wJY/Q62P0qzAHI84ByPsQyKqWNjknaA5e/Khe9e/OMwIs53dXdFMBCMO
 P8sdKS15m6AfRdcTB3lDDTpezza7mPtwZDWL0J1H803l1sxPK6rEBke7ybLHUmJfjGiYvtDDW+o
 C7ihk8ppzr5LbXGJDlYwuWvKHvORE=
X-Received: by 2002:a05:7022:23a5:b0:128:d752:e076 with SMTP id
 a92af1059eb24-12c73f6c3dcmr2368405c88.3.1776455174245; 
 Fri, 17 Apr 2026 12:46:14 -0700 (PDT)
X-Received: by 2002:a05:7022:23a5:b0:128:d752:e076 with SMTP id
 a92af1059eb24-12c73f6c3dcmr2368364c88.3.1776455173543; 
 Fri, 17 Apr 2026 12:46:13 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c749d29f3sm4634325c88.5.2026.04.17.12.46.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 12:46:13 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 matheus.bernardino@oss.qualcomm.com,
 Marco Liebel <marco.liebel@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 0/2] target/hexagon: simply meson.build
Date: Fri, 17 Apr 2026 12:46:04 -0700
Message-ID: <20260417194606.39997-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDE5OSBTYWx0ZWRfX2SlhmXdTS/Sk
 quTjTf35kGNFZ2HUq/CM1YgLL4G8WjB4gziPG0DQc66L+lGDxr8GrYlEKl/7imZstG/g9yB6WE8
 0ROc7+a60p1cGbAjEQWD+Dzmg1me1I4JB6oMic7DAdhqUzUUEL8BlI7GJ55U7TRS0XqtCEeyyVe
 Z4y7UAU8T4FCKyonBYqgIopwc+rfNxm3hrEigR8v1OlvK0WafM3NdqrLKWJnoUo2lKFHWyGj6yk
 Bs+7pVo7d5CZaOmU5jOdbuCuEs0FD+1ABMGLi+Zpnfd5t850SzGvlOlzPkcfU2MVQRPu8GQi8wh
 NxolamdEfw1se14DYE1xqFbU4Sx6kULJ82V/OZbd5cKWlH8DLiwUgT6V8rQ2p6tdetVMB5qtU4L
 BEPcm+1PTLdEhwEJXa23NeyeLSncB+BJtMwC50zdzgep04h/9qxsBjHnjT4f2HvDYPD0Ba+ivAL
 BZVNhE+T0FUOaGSK/yA==
X-Proofpoint-ORIG-GUID: O-AGXF3Z-py8sas2sviDCFS1IbBSlliL
X-Authority-Analysis: v=2.4 cv=FP0rAeos c=1 sm=1 tr=0 ts=69e28e07 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=jb00CFHXqr-iL6it3IAA:9 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: O-AGXF3Z-py8sas2sviDCFS1IbBSlliL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170199
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

This series removes some duplication in target/hexagon/meson.build by using
loops, instead of repeating custom_target definition.

Pierrick Bouvier (2):
  target/hexagon/meson.build: simplify decodetree file generation
  target/hexagon/meson.build: simplify source generation

 target/hexagon/decode.c    |  14 +--
 target/hexagon/meson.build | 193 ++++++-------------------------------
 2 files changed, 39 insertions(+), 168 deletions(-)

-- 
2.47.3


