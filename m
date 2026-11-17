Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDCE606A32C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 18:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FiLJuQJW;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=H4BWI/iB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTNq4-00057r-Sk; Tue, 17 Nov 2026 13:23:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xTNpq-00051q-TZ
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:23:14 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xTNpp-0003ci-AG
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:23:14 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHFR6kT1663618
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 18:23:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=ktfwObimbRlzXEVper6p/i
 1lq8/Gk35nh44qD/tBo/M=; b=FiLJuQJWlsEau9ldCKy0Mo9wzrO/QuyEoiJGLS
 PYSq5runzlrswtc5YpFwnF1ajSIcuXM+vCghDDWUmfEJpjaVrZXWMDu78w4cSM6M
 teaaPKI1tO9i4cZeG8V1T1R+N1xHL4qR9Xo0aj5CsVH0BMwHNUILDf4jOdR/zepq
 ZvkkDzvCt1qk5n60RyQ+bhB3DLDpGJlj7KhYHv5xGRRJ2QjLXVpLhNmlZdg+xXyV
 Ju5sWAF0/dR9eMqS3zoF6kIrl3CRuXSt9TN8Tz26dlJZ5baH2Ya2rIRaNaq+LNdh
 Z24r6KPMcerS0EiZ+yTRJW5k+Pw6j10FfDnTIE2U11IX5LWg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0kccafv3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 18:23:11 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3b3b74351a4so982691a91.2
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 10:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794939790; x=1795544590; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ktfwObimbRlzXEVper6p/i1lq8/Gk35nh44qD/tBo/M=;
 b=H4BWI/iB/SzPU7klGIe0JxDH3Rekqsnf4SpVA9TsZweYh0/3qtceUn69NLZ34iNvUU
 86BdeglIDE4fgccbkD1/qSEhWy+EpuXvsJgQqeQ3CTv0kBbcGRsX4e2WZwjdLkmDFaRJ
 RWKhZ1hGJNnQw78U0QAnLTtExqbdn1kDXa/wSJL84ecfOIJ8g83bQohQoF9U1dNJHlzN
 VbHEXRci6uYEsoAgtUCyum1bFBCB1fWc+hba8QdfgEBDlcybENCESbq1HRxCUD9KPezi
 ywUPkU/C1ojp6gqpoxIWUh4kDHnrCEjbnV6+ymPwlnuMfQvvXYIBan+z76TfUkHt19JM
 LFzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794939790; x=1795544590;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ktfwObimbRlzXEVper6p/i1lq8/Gk35nh44qD/tBo/M=;
 b=v/hHz3e4Tak9QC8xJcIxopk/aTBYQ1YMie/Bn41ij3FiQ3EstIkjJW9oggFYZv8ZPb
 0+yVT5PHdFqUl6cAqskWToJnIBrUMclJmUMqcfZzoC4UR54zN4bx5KfJbONZKwY56Ijq
 1gAKeO0urJDgaXX1QEkw+LTi/DJ6CHXKTtGxpHd92jwd0Bty6gKmXUqTfIxodLjSEyAn
 e2WdqXUw+wXLmIoA0z/phjuLR2xgWhhDftzZeScd5qG/x+YeEi43mzll1tLV2BV2m4+v
 SuQ3+LsmM+4RrEvRyR0zR5sKF7YIEXCuWccitnhb7wXN3FSY4MwBFM9jODJnr/dURnpg
 5/ig==
X-Gm-Message-State: APuU4Z+LNJTJGNz/h+zobh4/nMQKRWEzdi8r1oADoskpfkkpeKECCt2k
 N9gCrKZlboB4CVZ2fPJQvp96BjSQqGUzxsHX/VIXHv4uYa+klFbXkVNV7fN5148by7UoK9gGcV9
 9/dhuiBDFQWuYhxkBuOe8dlninM+o2gtIJFwxNmIiySVm5G0x1mbmq+xNKZHm+p1fzw==
X-Gm-Gg: AZFdTZcX1D8ulLjsO1jWLiOYEZ/12s5/LTtXWCnzBUSrMnRBOEVzkK6RWZ7zE7DzquB
 oHL/P8iK9Edq72+aKEH5WqbWNjx64R6DdgbWOo5f1rVjC5TpjicZDVeWH3g4lnZYRuP/p9VpOK6
 Xs1mtwdLCcegg2Pkxjoa4SQqPP7y5Ac8XMnY/sTkOucTcBzH4Si+Z5JlBwd4YEtQEUKYPHL3D9Q
 ktZYvsgQxsQ9MOjzDS7P1Vo0JdWiDk3mN5ryk8W2GI3ACtQuM6cq/FZDsbhVgAPilq5jAm91UJV
 6i/SskruXSo3lsFaLjIqLWEEvyu09UhC7e4cGIrIeNU45x47cBWtjUapcfMxpDb8HUaDD5qJR00
 hcKGoRucWkVAxi36oPX5a5R56GHT1WktmUJ50IT3cFoEmYtd2YMJKM6J7TkOoh/MZ8REJwUFElO
 X2DCDg6Vi0rcpIDh9L7VRAQpu3psL3PAS2vbuT
X-Received: by 2002:a17:90b:1a8d:b0:3b3:c4dd:5437 with SMTP id
 98e67ed59e1d1-3b3d06415fdmr340025a91.5.1794939790118; 
 Tue, 17 Nov 2026 10:23:10 -0800 (PST)
X-Received: by 2002:a17:90b:1a8d:b0:3b3:c4dd:5437 with SMTP id
 98e67ed59e1d1-3b3d06415fdmr339998a91.5.1794939789506; 
 Tue, 17 Nov 2026 10:23:09 -0800 (PST)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3d19a32ccsm68045a91.0.2026.11.17.10.23.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 10:23:09 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 0/3] tcg tests + docker 11.2 fixes
Date: Tue, 17 Nov 2026 11:23:01 -0700
Message-ID: <20261117182304.3261165-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA3MyBTYWx0ZWRfX7oyXo1RfPuOR
 GDzna7SRAvstgfa231CpK+l6glAfQ+w/DHmZv536dbumWEIE20HRM5JLXJcYRRGbbPzJtzg05ss
 qYRRS/XAWimV8d++q0B+C0Hnmg0OmPM=
X-Proofpoint-ORIG-GUID: YV2rLkNpZDSDb9w8uGeYdj4yZCaRdZ2T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA3MyBTYWx0ZWRfX2DKe4H/JdLFm
 z7yAzaDQVYdUnA3GG1EdxDNmWgOMAMVotnFnU4HKTHnW234f91IFL/Oz8Kadfx9C2GgFvao/mpG
 WA7/UMwjUbsxsqt28JDtSuHte0cVhIAbxo+WNvq4vhuUBkNQbEwBKYOdc5hDIQ5fuK+YMBxqBXx
 Q2XQ3w90Ls2+N7o3/pykHOqhkB3tH7BCvVG3GgJi6nZJTISxI4L0Pt3gxGCSrhrSdwVvUQZ0vPf
 TIUR7vJNGN2ghCul+XI6dMf4pjXvrJPxIpgEt276GjRn3Oe2dd7FWXoCrcPHz2r0mV5gFs/JU8w
 U18Qe4kFXp52RmnFuM3BjYpG1ATwPrAW9aygfUGDAv030qpBk+dWG4LFDhcaMsUXW/ANYy398Nr
 e8X+tsYKfAtQxIudwsIGz+aTgfSa30K6oNbvv8zrurRq/pS3wW9c4tKwuim3W9I4zcKkfV9MVEX
 Fypu05HMjHN259lp3Mw==
X-Proofpoint-GUID: YV2rLkNpZDSDb9w8uGeYdj4yZCaRdZ2T
X-Authority-Analysis: v=2.4 cv=ZP1CCn7b c=1 sm=1 tr=0 ts=6afc9b8f cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=NEAV23lmAAAA:8 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=r0V5mPYBHeeWBRqTDOwA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 spamscore=0 bulkscore=0
 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170073
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit 822b70d4ec8532a569c1c88060fc8f41d5b294f2:

  Merge tag 'hw-misc-20261117' of https://github.com/philmd/qemu into staging (2026-11-17 07:25:58 -0800)

are available in the Git repository at:

  https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/tcg_tests_and_docker-20261117

for you to fetch changes up to cf2f97574c18aeeb45fc38aa6864190aecb64bb5:

  tests/docker/dockerfiles/release: use full registry name for image (2026-11-17 18:21:49 +0000)

----------------------------------------------------------------
Changes:
- [PATCH 0/2] tcg-tests: detect redundant exe_name/test_name (Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>)
  Link: https://lore.kernel.org/qemu-devel/20261116232140.2758664-1-pierrick.bouvier@oss.qualcomm.com
- [PATCH v2] tests/docker/dockerfiles/release: use full registry name (Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>)
  Link: https://lore.kernel.org/qemu-devel/20261117170244.3180399-1-pierrick.bouvier@oss.qualcomm.com

----------------------------------------------------------------
Pierrick Bouvier (3):
      tests/tcg/riscv64/system: remove exe_name as it's already the default one
      tests/tcg: detect redundant exe_name/test_name
      tests/docker/dockerfiles/release: use full registry name for image

 tests/docker/dockerfiles/release.docker | 2 +-
 tests/tcg/meson.build                   | 8 ++++++++
 tests/tcg/riscv64/system/meson.build    | 1 -
 3 files changed, 9 insertions(+), 2 deletions(-)

