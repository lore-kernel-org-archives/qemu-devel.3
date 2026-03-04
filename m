Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB78EFCE42
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 20:10:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxsXA-0006Fy-5Q; Wed, 04 Mar 2026 15:09:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vxsX4-0006F7-On
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 15:09:24 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vxsX2-0005DO-5w
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 15:09:22 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 624HH7WS3837890
 for <qemu-devel@nongnu.org>; Wed, 4 Mar 2026 20:09:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=vxvGufc2Wz0Jwu5cYaCxIu
 GpzWxLybza92/ZSUEjdQ0=; b=JZPIxLAyfaC72bEtslHGYOcxLDRyedeXnbrKHP
 OBKGIz+Dzolpm2MP6tfdn1Lp2d4vzBuHtbujFIV1XoZiBai4OgI4s4KwBAHjAdz5
 Dee2dSlXgp0pD/v3Qomj/NvjpNXyX7CE5V1y/V13R/KTrH0gIt+rkOPbvYdUNmmJ
 aidO3+w9aol4FH2gVI9Ly/gWC4VBXtyDrJ3f8fBRFVM5ckhjD+tYwVxJQ1ofBmGC
 kZbAWk6fs8VNCyHR9+ibtUl8pw6UHlgIf6oF4QrCz6tPJNQPOSrUz7M3q4uK5Wkp
 lhjIrFon0Z8oJN5tSjJHDIJ6fGBFLLlE7HetmoNx03/p5SCA==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cps0m0hbc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 20:09:17 +0000 (GMT)
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-40f192cf4b6so9297708fac.1
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 12:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1772654957; x=1773259757; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vxvGufc2Wz0Jwu5cYaCxIuGpzWxLybza92/ZSUEjdQ0=;
 b=aONarswUt+G0KdQdN+Vbqgersh/rG3458ZOHU7jgi3q4xoR3BFBb1i/to2su08WvVT
 Yn9dc5Cj0HHLzv/tcDl7DXVzr6y3bsONY1DtjDjbbMz95F43I/yabqmkL2xMXNDwGqrA
 ef9yzrJaj3XOWHDEIHIa7ftni9Z+qWuUuIiyVa6sN/N0EC1a7PWS38L0u1045xJf1o3D
 SoBM0cZgkKuk5zRgptBj+R34qy/AhBoDkHSY59tI28NWt+sDsikcymt079MN2ylUDnd9
 YSKOGEUGLVVMV3VJeWU4CH1vrf2kHX8nzrfeQg/HB6dwpyMCcTsY6PgH9zpS2cGv0+Gr
 oMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772654957; x=1773259757;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vxvGufc2Wz0Jwu5cYaCxIuGpzWxLybza92/ZSUEjdQ0=;
 b=LQau+5DCgOovpOOOMmXMB9WGi/vcwVtL1P/XR+cvMlrKmefEk71TtIzNf2pMnyItpj
 M/ieXPK9A0qBVBPrfVRXEZv9tOzaAQ6AI3UttLk5a1FGETvoD70YPHPBuGAiDAUMTpaZ
 4k5Enm2t3WxbuPxiVqxmRzAjJ0nLuVtwIn6fVpUGYu/ZOYpOMwpr1Ftai2AWS6WDmz2U
 qR3++gLAxjrAQvNKx7nN6K8rxVDVxLMvR0nYT3Pzl7TqRrHF67o/JBcN5uzuIBYmHM4A
 lNQiUMIe4JTuwN4awc7hOjbejl0SD+2wQKKW4iy35badRvQB9ZfRmLOvqi0OrLoPmMDL
 TQOQ==
X-Gm-Message-State: AOJu0YzW7zw2EGX+Wrn+5ARGYoumhQizIkzZIznWvUj8sm0Vp2Dm0QKq
 i4bEYuySK7sejMsAg0s683c/d8Io98mqm3qmC1nV7h6mVEgGupPOsiAFJbur/cqtPsjB9bb3/MX
 YGXW3JIx3XGEzhaChANeD6yKLoPSN9l6iKTYIye01V1D3QC7TVfj6ZM8/DVLmubQ9RQ==
X-Gm-Gg: ATEYQzzUOApstOXoom1I45QK9WIKTwZkRSIbvn7Zb1DzCdc9Js6zLMuGKg7aPHupit1
 TQ5+u4NqM3FY9tA7ckK474kT6Sbs8HOF28fEm3w3sxZDp3xp3rALgWFPq8EX7jSHMrodQYHkrhg
 mfDmnhmJ9nAin7HQq7NwGnVvYz77PhsTROoqrV8QMwKgVbWdzw2NAwudGboY/SR52gQhoyjL8Iw
 GMYAJAiRQCl/mrQ3LVeJ53JwafvIjqVoGcUGj3Bdj6n4QKmC7zKkZCtFU1S7rvVB/qhi/FwCQoh
 sprtbQhf9LpUfrN4SfbAjJmbayg98iYeGTSMUkDRgcyFhJUdvcRre+0IZ9+9Q35SCil0QNvamFZ
 iQQi2DAfowPBiF34oN90WAD5VVzWjYPMlSsWRK4h/aHP4KEi8W6Kf9GmX+bZx8SPx8jU0Mg==
X-Received: by 2002:a05:6820:995:b0:679:dde1:c535 with SMTP id
 006d021491bc7-67b1774f90amr1864349eaf.35.1772654956806; 
 Wed, 04 Mar 2026 12:09:16 -0800 (PST)
X-Received: by 2002:a05:6820:995:b0:679:dde1:c535 with SMTP id
 006d021491bc7-67b1774f90amr1864310eaf.35.1772654956406; 
 Wed, 04 Mar 2026 12:09:16 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-679f2bec8a1sm14904882eaf.6.2026.03.04.12.09.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 12:09:15 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, berrange@redhat.com, alex.bennee@linaro.org
Subject: [PATCH 0/1] Update hexagon cross container to 22.1.0
Date: Wed,  4 Mar 2026 12:09:00 -0800
Message-Id: <20260304200901.1281731-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=e6wLiKp/ c=1 sm=1 tr=0 ts=69a8916d cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=lnps_zuvmrPqk_99VuYA:9 a=QEXdDO2ut3YA:10
 a=eBU8X_Hb5SQ8N-bgNfv4:22
X-Proofpoint-ORIG-GUID: M-sK42xRaIJWvYu_DfgjKmGA06nGq5PK
X-Proofpoint-GUID: M-sK42xRaIJWvYu_DfgjKmGA06nGq5PK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDE2NCBTYWx0ZWRfX127nmExcvIAX
 zKFK3f4b7CTRAnzbIdmGlTKG/mqqm5oiVXaWL23z111ZNzHMKpzigxXI1ip7Z7ZeufmvExvWmE5
 sx5fDVsAnGr8xsfoDImb9aI9hGD5ykXxbMDQI1a9MHNwndaW5cCGFIcBGSAQrZD1dK0zUOgnieB
 IFIZblzdVpQWSgK1Y2r/fJmKzoBLLDDvy5vdxfwRF31EhyBcGXlUt2xTT0g+s18C6AK5T5d+M7M
 g1S1jVHcyxaPRYvnk1HB+q0FFw54Wd4b8k2XQc6q4nTibSXJJEacP/T5YQ2bQXvbvml6ybNxVDN
 AMP2K05OT+6hBh4P7Mvjo+ykATY+ignjb1lHSpaydrc2oCyVFdjXdEhEF2CRGiZpsoFVVgLuqLV
 P7ZGmU9jZLs5e1XsdaRUSpz+7V8UOB/fLzgMpLL1hMUujknkp5N5oo8iXED/WjadSMTS7o0Duy4
 34npi0LfFV2L5JV7sZQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_07,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 adultscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040164
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Update hexagon cross container to 22.1.0

*** Note *** that this patch should not land without
"tests/tcg/multiarch/linux-test: use portable alternative for dirent64",
a newer musl present in this toolchain exposes this test issue.

Changes in v3:
 * rebased, dropped debian changes (already landed on baseline)

Changes in v3:
 * change debian from 12->13

Changes in v2:
* none -> v2 was unintentionally chosen for the first rev of
this patch.  :(

v3: https://lore.kernel.org/qemu-devel/20260303210553.2044313-1-brian.cain@oss.qualcomm.com/
v2: https://lore.kernel.org/qemu-devel/20260303175444.1540049-1-brian.cain@oss.qualcomm.com/
v1: <none>


Brian Cain (1):
  tests/docker: Update hexagon cross toolchain to 22.1.0

 tests/docker/dockerfiles/debian-hexagon-cross.docker | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

-- 
2.34.1


