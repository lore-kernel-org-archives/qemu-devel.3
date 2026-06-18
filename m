Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46440CD98F9
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 23:48:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waMSr-000056-Dd; Thu, 18 Jun 2026 19:48:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1waMSq-0008WL-51
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 19:48:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1waMSo-0000ii-M8
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 19:48:03 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65ILsqX93061558
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 23:48:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=g9wDLaq/J3c4q6jQl8c0mLb3oceU5zDAXRC
 bcfd8UKo=; b=onvtFRZtGoyeTvLRSsIpia+r1iZq82HvIfIYzjzWO3DlPdsKOeC
 9s0KixvwmzTBnNZpJxCnIQ41jy6cudxE25pTqqR6HxlXONQVmmUYI4l3e+yIeSxY
 WxbhJb+V7DaLDGLfMdSsUQVd9rarc/ZGoxwYXSKLCVQ8tsPkkFaI09wQo7llKL9X
 I2hJ2W/ZrbzD65/jIk1PgGBK5ju3jzG2Zc/3DBbbOz5KhKwvemcjdWzOIM3HB8mq
 bO8qOmaY6QcZiRD4NFdSM2gtAMiHtnN6x2MiS2VdCL9F7Wa0ZJYgjYjNi5L2Dn04
 UxiePZrmc+BsG0+wh8iw2vnXPQI7o/iqFCQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evmtj9j0n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 23:48:01 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-304b8d0ee63so3752063eec.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 16:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781826480; x=1782431280; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=g9wDLaq/J3c4q6jQl8c0mLb3oceU5zDAXRCbcfd8UKo=;
 b=ZTbsagbq3D9+o3dFR5f7tMfKhksdkRvd5XdxfAid+LLEQQP4QwmxuR0RkG8w3ogd7W
 q0L0IIaaeJGW5D6k1d9ZNUBA+mM7WIuaeXCW5SnExDJpszycVcU02LkVQkQgEIwLMumV
 YpUPahSD1GNNNX9UnIvKCj+GgH3pawTvzwNrR9SapSt4pUVq8HS0e+HSCAWTwXvtmeTM
 5sIPL2rXwi60F7aZmTQoIEHHH5FT8dIUCzR3pCI2t7KZcN+IMGvIDFSr14ZbqJbCS1lB
 dfbrIV5dEMcn95rRenvCSIEZ1DZv7hkszsaq+6oo79FN1jrN1miMtyFzFeTw5oy3Gcmw
 yj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781826480; x=1782431280;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g9wDLaq/J3c4q6jQl8c0mLb3oceU5zDAXRCbcfd8UKo=;
 b=atbdItzpR7tCbFtBHXAqAgTqr+4oVblWH4ur27mvOAfHyEJ5r8nUgMlB4vwziquHNl
 LstOMe4/HFUPxU6vYjw6FBv2kcqudj3TW76sn0qMHE93cPTU4brt7NTjo6rGymECQoJs
 2iNmUMz+M6Vd3YuPuPL6IuFLwbLcTdbzOTobl51LONVBxPpZGDfnuUi1MgyAHf3LLeXQ
 Gz0JCzBhdpHq68nTXGXHxPC9OuX1UpvxQHrTn3zRxaIK21MpGL8PCPMhkQWRCtQ2GgEf
 tGxDHSA8BYdhQrSjB1CpXPGIqhyrePmOY8ZBUJFQ2SeFzzldk6zUrN10I348PpWE0GBa
 HxVg==
X-Gm-Message-State: AOJu0Yx3l0SOFbXNnkGK9BVfSYwuy7YkzGYkr6sbgKv6qycD732Sd5IC
 Y7xY2lRqwB8vxHD84s6yYVfEE7DtKMzMPHyznXbqJgNy7MrFNnrf6QkjJ8Xxp6yfRkTiwBvirVI
 rVdDYPY8oyNVdZ9uYvdXfwlC9fBuHIawGPpPcM7EE+4If4/2fJCUgtRPgdL7fnukKoQ==
X-Gm-Gg: AfdE7cnXNzkSMfhmo23gCFb3SvD7ob/tvy+yH0XGDPQiZoGp+HAoSA58SgVIq+1qtVC
 k0B+79+7FmNiAo0mkw7kL1S5XKSXzZyW/8CAosIxJy4If9Tk4r4DJn/lMxb5oF8ri/R+9KBNCKw
 2kZUh/jVdOz+k37F4GfhfG1a8uhJCLwgN+lVuURN0SlVpCHa3xEqtD4Ox1DYt+k/MZuMhbvwPah
 E22EpYhscSGuVbZ2L6B0KEzuEC+vYKo2zOCL6pC9+GAp3NMSfuVxyZhNhsMBgPyrz2Tm7ftWLTy
 cZAWRy9JteJZTLQCYa8q9xJplwJmVpJLGWTF3hDlV9vrvtdcHvPq65TfMW7vnJn0hGQfbPIm7O2
 NkgY4tJ/Y42Enej4q5Bvo/0PjJBnNVPUeCiie7LV6SBH2y1iGCllxkyZOmjkK2o4NiD2wajz1zP
 DXt1rwkg==
X-Received: by 2002:a05:7301:3f09:b0:304:ab8:f89a with SMTP id
 5a478bee46e88-30c06ffd2d0mr1221342eec.1.1781826480181; 
 Thu, 18 Jun 2026 16:48:00 -0700 (PDT)
X-Received: by 2002:a05:7301:3f09:b0:304:ab8:f89a with SMTP id
 5a478bee46e88-30c06ffd2d0mr1221318eec.1.1781826479674; 
 Thu, 18 Jun 2026 16:47:59 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c06c307fdsm829917eec.18.2026.06.18.16.47.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 16:47:59 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 0/1] Plugins update for 2026-06-18
Date: Thu, 18 Jun 2026 16:47:48 -0700
Message-ID: <20260618234749.1659878-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDIxNiBTYWx0ZWRfX+Es9Ng8L8R2U
 Q/nRv7uD1qoV72tlAERX1p97MeVx9J3p/GXworkkynZ0XNLmef2lNz5B26I2AllGrVR/DB+ZQGb
 LmD5upzH1eOp4lDE+1HqQghaU9oO3bg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDIxNiBTYWx0ZWRfX80jLY31FSLIG
 38mPgZ1eYtDsrS99ChAqiaZH0WCdopfGpGLOBGUk1JmsNWgvgDv7CUmvWzXJMO4K6h7eflbRYPN
 mI8/yeZklqE8ECkltrEuGg+OB6kF7eBZKTkETvbZtbFTBh9k7T4i0hh1cZ0dKdIypYW0cmKfwI/
 L0fzv53JlT3S3EnPq7uaUqjURfItyyXvHpMlg8vCG3jB43/Cl8oqTxz0oTDOdPK5dDJ5v+6WXOE
 NMCIl2zBbrGs0r75OdATVfPvwZpoxypaMLs/P9n0Z0T8/J/BVWL6aMpSzHx6dP+iHouA+8m0OEQ
 4r1ORXmGlyqQwNUW4hbk9OmhN0nIoM0prYuwqwk4RGwzeB1gfBkXx6voLYzCFWjb7WxTrCjYS2u
 vzaodi9gUAii14A8x0BwiDl7C/sJa+IMXlmNfWN+KzDNpES8oy5ZJ5LnZ7NBiSZqjpjMfUlVrsi
 0RJe7V/AXdl7Mkz9dGA==
X-Proofpoint-GUID: oee_a_vutejDvH2jLpsM02_vUDBiGSZW
X-Proofpoint-ORIG-GUID: oee_a_vutejDvH2jLpsM02_vUDBiGSZW
X-Authority-Analysis: v=2.4 cv=OM8XGyaB c=1 sm=1 tr=0 ts=6a3483b1 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=NEAV23lmAAAA:8
 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=w1JcTC8Nwk0S2mYjzzEA:9
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_04,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 adultscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 bulkscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180216
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

The following changes since commit 3b50303f9563a42538a1fd5c0ea7f952e23016e1:

  Merge tag 'accel-20260618' of https://github.com/philmd/qemu into staging (2026-06-18 16:28:12 -0400)

are available in the Git repository at:

  https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/plugins-20260618

for you to fetch changes up to 731525c27607bbe392abe3b8be2bce3ab65ae4f5:

  plugins: use int64_t for the syscall filter return value (2026-06-18 16:47:12 -0700)

----------------------------------------------------------------
Changes:
- [PATCH v2 0/1] plugins: fix syscall filter return value type (Ziyang Zhang <functioner@sjtu.edu.cn>)
  Link: https://lore.kernel.org/qemu-devel/20260618082426.790315-1-functioner@sjtu.edu.cn

----------------------------------------------------------------
Ziyang Zhang (1):
      plugins: use int64_t for the syscall filter return value

 include/plugins/qemu-plugin.h | 2 +-
 include/qemu/plugin.h         | 4 ++--
 linux-user/syscall.c          | 2 +-
 plugins/core.c                | 2 +-
 tests/tcg/plugins/setpc.c     | 2 +-
 tests/tcg/plugins/syscall.c   | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

