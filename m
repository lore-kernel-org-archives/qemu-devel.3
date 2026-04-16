Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F7ADF8E48F
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 23:19:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDVzB-0002Xi-2e; Thu, 16 Apr 2026 19:19:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wDVz9-0002XG-Hq
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 19:18:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wDVz7-0006Un-P7
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 19:18:59 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63GKd6bQ2651713
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 23:18:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=mw/k6N11pLx65iQv4BOl+XuVw0E7ILPileB
 0w87wI24=; b=joOhpN3JzT4redD3dDtNsoSARogp4oy/6JyVUE3liZtCbMUxaUv
 QfZm3F2dEbiAcKxActGRvDyJS3mOspfLXcNXDblJD3lF/B9imekGIMh+5TyVxwK3
 /Y1VRheeGwktT5ysC8Ps3sI3+oj7cLkELvViqTgMtOveuOoVu6MMlyz9K0EbYde5
 pCCEolOfZ+TV/JpcQO7/ftiVPgr5HM3Ntnsk2gcMVGbKc3vSUVIbADnd2vwsDWzF
 gLbj7Ka+GXx2kCZayhD5eFQB9d6VXaI+2br2HDVuJj1kLWXqrAipWIBU4juKMvCO
 ASGZQmT8UkzeRD3qBU1htWIugkoTriW0rXw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djtfukepd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 23:18:55 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b4678c6171so519115ad.1
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 16:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776381535; x=1776986335; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mw/k6N11pLx65iQv4BOl+XuVw0E7ILPileB0w87wI24=;
 b=KYRAShLoAEdqmkzlmt6BrWG2sdpCARIqqKL6LCpHxqku5p4FpziGlm3TaKP5KBxA83
 MOR0fZYMSj6yhelNxaidBHeeMyLMgbMy3LOGdGLmuqpighHCncKBq8XbIJnDojFzi+pA
 E7ufWUoYa2G/lC65AowJtfYgFhFCOuPsdL07P0cXSPJvfTlOhlwOt9Q6b7O1dQgH/H/X
 diihH5TiXs/r6Ja6QjiFYOyZwrFmpJyw1FvJ5aptWIhDp2/HLunFVs3rqBwYGhfJfRbQ
 HpSRnvI8qpkZvPmNweBCMyuy2bVCdQ8Bo4IkD7WzM9Wc4bauDdsJD/75G/4WuN/Z0QZ3
 C3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776381535; x=1776986335;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mw/k6N11pLx65iQv4BOl+XuVw0E7ILPileB0w87wI24=;
 b=ajPGb2s0iXthl83K0B5t10bdTY658ptIGagSeCG/G8CUFbhDW2sECGXnTCylf9enQl
 +/hoa9u17Z23RXLvDOoq7mHLbvMHQRxCT9Nf9PXYIUeh2VN8tgvsRa6tToUwkIm08L2L
 Nj0a+hwUALrPG+Hk7V2EA09GOXtmTzYYgtNOvFMjcfm/JGMZZTR+ezHvaRG7jqUBDHdf
 utSRtcXFSFQC2fqD16wb8B5Q1okvOTKN4zyxh/NA+kWtNojfrty5P3vywDRLd4cAKy3t
 3STY6KuqCQnhHbXHsMLTGU2YrobXxKvO4puz1nqyaiyyYlXkv+24RsMFTVZpmsgjQ0mx
 4stQ==
X-Gm-Message-State: AOJu0YyK+YyGr3IZ3ujXdaYDC2wM80jfbNs5QdEpO5rySpty80AFlJoA
 6lXxd1DlCKTeig5EZwob9uKwL3QdmokilAJRYnTFbMp3FSFaM3L8ECNywVw1++oi0RUOQfJE47r
 XQ5QXO8MRNQrUq8ALbSRKD7WiHTg6nCO5nPcZz3WUPUcGg75340vKr2BQ5DR3Mm0dsA==
X-Gm-Gg: AeBDiesS7HzwSmnPJ3mHJIg2sGNOcNHflT0YSoPlWqa4xfjxfpSzgvQ6A0E057x6N+k
 sjXc2ealOCd7dCjBCXG4WE1A2k7b/epTthN258dLMp3Qx/V/UKRbeImBRwwwImdYbHrftK00XEq
 Fb8woxyrghuPf3NwLUxNDHkxz+zwaKSy77X2cBir3Hnjvmjh76DjL5fuu6+xfD+CWGIAi3ZxB4x
 Z5SWitKYm/gtBlev6evj96YbqupjeTq4qZobH3fgNa69p9V3fuv166uThFqzRwNqmF0cHDzvFwn
 BtXNc5mmhFUNoxaP+FREwC0L+VHgX+sc6fqgv3P1QIPCQguqZorqbxmSKovbjdhxi85l6fUWpTD
 ebEPSH1dH6irk3S5wR8mtDN72W/X/0as+sRr9kAM95SIeQ+qiIgX29Oi8xD6we9qkqqLYFOGzji
 yKwuT74xjmOIKpwqVqdw==
X-Received: by 2002:a17:903:11cd:b0:2b2:5042:dd18 with SMTP id
 d9443c01a7336-2b5f9e7a907mr3722625ad.3.1776381534973; 
 Thu, 16 Apr 2026 16:18:54 -0700 (PDT)
X-Received: by 2002:a17:903:11cd:b0:2b2:5042:dd18 with SMTP id
 d9443c01a7336-2b5f9e7a907mr3722305ad.3.1776381534483; 
 Thu, 16 Apr 2026 16:18:54 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fa59dda1sm800485ad.58.2026.04.16.16.18.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 16:18:54 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 0/2] Update email address
Date: Thu, 16 Apr 2026 16:18:22 -0700
Message-ID: <20260416231824.349872-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 7EbkAA3frYJckz8Dk3hAcezDsPgaPsCz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDIyMSBTYWx0ZWRfXzl4f0pRkBa9e
 cjz3uEUJnnSnbIc4MkZbzEImL1tEIlk7/qZGynmrJEA9OkqqWm5n0ofg7THCf4aiyDluo2Ejgnf
 eowsoMJesl7lYd9S/RdaJizEPv9bIX9Xx7GF82u2l7MNrZqC4ERBfUQdG52QRNEYuE6L83Z+Ket
 hyeRJ5gxYaE2yqI605WwXp/QUoJMWRf+lfMLeBLi2sqR+36h16cv70AA7tjFbX3i4nS3OCj+0Ne
 19PEKbDa7p6xOej1+vsPbYWcng1CWwN0UCAJfN9h5hcf4Jv5btvMlV6baDKqX3D2hqR1WwMfBaF
 yTQum1Y80OmAeDbuaXeikT3C+cLwmbp+QYBpImncgV5KFbEkYP7jqZEaS/vxjW3PLwg0F29IpjD
 fAKN3vIF5vvmHnyOmOP/pF4Huj2DEPNOJbQpbx1cHQPIMYqQl86EMXRlUmlSStab7Eyr1O65yBO
 inbPnkO33Gz7r6f3sEw==
X-Proofpoint-GUID: 7EbkAA3frYJckz8Dk3hAcezDsPgaPsCz
X-Authority-Analysis: v=2.4 cv=KrF9H2WN c=1 sm=1 tr=0 ts=69e16e5f cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=p0WdMEafAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=csrHGirYQKKlO5RPXs4A:9
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160221
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

The following changes since commit da6c4fe60fee30dd77267764d55b38af9cb89d4b:

  Update version for v11.0.0-rc4 release (2026-04-14 20:22:00 +0100)

are available in the Git repository at:

  https://gitlab.com/p-b-o/qemu tags/pr-email_update-20260416

for you to fetch changes up to 9b3a82bdf605d78e4fb38e3b5a0461a45e255a0d:

  MAINTAINERS: add new reviewer for Hexagon target (2026-04-16 16:17:19 -0700)

----------------------------------------------------------------
Changes:
- [PATCH v2 0/2] MAINTAINERS: update address and add Hexagon reviewer (Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>)
  Link: https://lore.kernel.org/qemu-devel/20260416231455.346504-1-pierrick.bouvier@oss.qualcomm.com

----------------------------------------------------------------
Pierrick Bouvier (2):
      MAINTAINERS: update address
      MAINTAINERS: add new reviewer for Hexagon target

 MAINTAINERS | 9 +++++----
 .mailmap    | 1 +
 2 files changed, 6 insertions(+), 4 deletions(-)

