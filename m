Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E044CCD4F39
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 19:47:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNc0X-0006Zl-8I; Thu, 14 May 2026 15:46:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wNc0D-0006XJ-0k
 for qemu-devel@nongnu.org; Thu, 14 May 2026 15:45:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wNc0A-0006zD-Sr
 for qemu-devel@nongnu.org; Thu, 14 May 2026 15:45:48 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64EIpM4C3219657
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 19:45:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=KJb6aZfOKt2y15A52Z+nYLbyFA/8ca/zKTM
 0yD6Jc54=; b=H3iwGjgBqx0WxwMKhOyuij3yjwt1cUb0bmBwAFSX7kpC03Dqnp2
 PL1e/KLwNI+5xp1oAkE2qyxkRuCm//w3munuMQ21ZOp2Y3b3hcP4isaw8maEylm6
 2EwdRrAzGffzFxICfTuDc9TIl2MhUr/uInKZX0iRewg21IFlPNAHjMpvpXP3riz9
 MsLPfCxehT/eTY1+kGZtfQWS3pyp1vqZwD2/fYMzY+dEq7kIebC/Cg3OLhhgXlcK
 tDV+o+LI9r2Y37sY3dqwwcPNLpeLc3JRtkS8+WBj0k3r5WTcRIcA8ezqJiyfASN+
 pv0kx9uOGXItmNZP6XBHqaTLNAuUIWsHKBg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1s0582-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 19:45:43 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50e575a50bcso72228701cf.0
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 12:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778787943; x=1779392743; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KJb6aZfOKt2y15A52Z+nYLbyFA/8ca/zKTM0yD6Jc54=;
 b=DrJ8NgC+V+1BFhqhf44vC0Zm8A6WC2Sj9eyUmZCF3r8SAnuLvA9qygoOaZZKOBOwHz
 DY0be/d4E21GIQg72mJlwikqLVsoPBo49gji2buUPCP2wwu+kqJPg+CwTXAv/YC/cxTX
 XTUlZ5zz84kIwHgljEgOEchK+wi6Q6i4/gPnSG6I/t3LLA40awnpBkd6iNPmE8rXMg48
 mRaVmm6l7ZcZ2ylEzqieN2I05LHA3LzhWefMTGCdBoXH+dypQEt5kVquwp+Kxw4Yf8lJ
 jJYT6EgSGyJQ9RFgS3xE0s9u7Yzr4hxHpIeNS+1h26pErnLzwKEOzAJvEJJkeMSWDGZU
 ZoKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778787943; x=1779392743;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KJb6aZfOKt2y15A52Z+nYLbyFA/8ca/zKTM0yD6Jc54=;
 b=l++DY/Q3vOo72OlqO57mFqXxVqLSdcHrWaJ+i3DbUvHISGMGfJpXWcFhFBhuc0Yu4y
 cUEuW1j3WlSA/v2oxyM6LJx93QLTKE43GGUksetbp6SVt6rKu7KGzvkDw2ASOYBWJpRq
 1NqN7UBf53JtWsZSgx50AknwtuK+8+vDBKMHzw2Xnhb7e3Q/pGTJY0IJgPwPW8qEwnyR
 N0s5qafzdvNF6moP2CY/aAkZ6kP4CGY1+zojDsoYXe8C4brmoPVxhnDjLlS3/zEOzmHf
 tnw/LGO2vobD6cRcLUfXJ5fvS0hxTcXtTXhh5asN283okWO6mOmXW2L/dmdNevmOkozf
 pp3w==
X-Gm-Message-State: AOJu0YzxSbNY5EfRZ6oadyj/ZCwUGRczAKHk4LCl4qrLX62nm0IUEZWs
 mmQxGi1x0LAUKTJGGb8c/rG5f+uefVMPiGpuN2VQmvk5ptXk9zZo2uok2qEtJtFzGxHl7bVq4SH
 /FJYWQbzF2PaPbq+6pubVseWCTwh21HtexndcVBlKcem0WHPwxLESUkJz+FqPskZ7uQ==
X-Gm-Gg: Acq92OFt0lIVubPCxSaKWMSC0xVHx+rYc6j3xpmaQQNj+yOWOui797N6Gt1GBCSSQ0p
 0bCWjFtuXzJDDcrtnXpDGqnneJx5wUN7aBjfWzlVjZih2nxmqjfomUjMTvMXCUIeqHUWmOQQQeH
 Yh6Dj+TKpGZfEoFs2M1toj1vcPja1TObgtVeHpKA75bTfg6lAKag1X6GEFyLjE9NkUBVbZ3K5le
 3C+tO9lItYwWnBfw85XlwKX8NZlbtHqorC52o2Lyk6S0CskxwGUg0LTCiDGcqHKRjLfpcVFIWEY
 f98ytL258JY0uHDQmJgwUARNSjius50Nfg2cbfCIsWW1OATOvM8E3qkVTHPEFPkj1lVhEL0f492
 llULszksOuF3uvRaNsE9xsbE0Z+fD4+O17wawLBpwwTsyRBWJjiJ9+KdYWlcW
X-Received: by 2002:ac8:5fd5:0:b0:50d:863d:b50e with SMTP id
 d75a77b69052e-5165a0010f9mr12111281cf.3.1778787943347; 
 Thu, 14 May 2026 12:45:43 -0700 (PDT)
X-Received: by 2002:ac8:5fd5:0:b0:50d:863d:b50e with SMTP id
 d75a77b69052e-5165a0010f9mr12110891cf.3.1778787942898; 
 Thu, 14 May 2026 12:45:42 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5164581aed3sm24430151cf.23.2026.05.14.12.45.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 12:45:42 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH 0/2] target/riscv/csr.c: mstatus write fixes
Date: Thu, 14 May 2026 16:45:35 -0300
Message-ID: <20260514194537.2416243-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE5NyBTYWx0ZWRfX80wCTOQrYrg3
 WpfTwfFEKSVe1ZTqlXp7NCxvYF3KUL56QT0Vapfj8ks9Tq1FfrCpvzktV0IIZZv+/BzC2LrUsSD
 Gjy1EfX8HR28B7dWgi2DVvVUWIeoPfCmEobyB+0XG1MPgOrNLkeoQviGPrFw1AQcF/L1+J81HzF
 XC68k7FN3JfJw7JMgrrhMQsUxLdvYXcG9Ri7K+KE/+nBXX7Yg+2N5r0TNu9gt7QScCuzMYCLBWe
 QDgMLB2CUo9Jv7M2pP4UzI4ES6A7qQLFoDXpfAnGweNhDJ5BSSeiXJhdcfyJAJukSomo6PwuuTj
 C+6lMGGlZqkCyMnrf0wjbFGSW/daicJDFvtarE50YhWO/oygyh0Yq+B0/vCEzk4+Qzbc1ZmBU82
 NJNA9+W2JIIBjkSY5W7HVWKfc57AROa5s5S/1G/QqNJD1o0GInb1bXGMVRdZ1dl4tATiOs8+/Y8
 JgxyECY7hX2QcQfEsgw==
X-Proofpoint-GUID: hnK_RC9rzkJdeOn4ELOrYvKfOYkT3HJ4
X-Proofpoint-ORIG-GUID: hnK_RC9rzkJdeOn4ELOrYvKfOYkT3HJ4
X-Authority-Analysis: v=2.4 cv=HJ7z0Itv c=1 sm=1 tr=0 ts=6a062667 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=p0WdMEafAAAA:8
 a=WQ3ChpK1bNkJyguQgJ8A:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_05,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0
 clxscore=1015 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605140197
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Hi,

This is a short series with mstatus write fixes.  Both related to gitlab
3367:

https://gitlab.com/qemu-project/qemu/-/work_items/3367



Daniel Henrique Barboza (2):
  target/riscv/csr.c: do not allow mstatus MPV/GVA writes
  target/riscv/csr.c: fix mstatus.UXL reserved value

 target/riscv/csr.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

-- 
2.43.0


