Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75336F46101
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 13:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4f8R-0000E4-V9; Mon, 23 Mar 2026 09:15:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w4f8Q-0000Dl-8z
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:15:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w4f8O-0000Kc-Go
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:15:58 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62N83oL31364149
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 13:15:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=mRTHD33x9sS/GvdPsRjBTq4ipPh5R4vU6n7
 QEzrj5eU=; b=lORzZt4JIrlQpLLAzFNd8ZQacBYwfvyfLDf5xqC0TUkr9wzgXaz
 uHe/sddqvtnlUbH9mG8bn1AHakaYCPvJlsDZ58nIsq7mRsV5niWnRJL6JccUTebn
 S6DnQkvEu3H+mBdJEhqeSqhzyFv/UcqRBJ4BX2XaXSeyyVVj2rJYFaLKcKRvtluU
 RNG+gomjn8iWEMNe7hug3UJj2jOwb/sQTvFkxrCura0UdJagGW7slW6beLymvPCI
 D/r3rg0g1Un2BTUfn3VMAP3ISn80cOeW1adw2NPYj8KtMujVkcEHDupb8DnfAUmZ
 YbXAWgAso52nbZG/1Cueh8zzekUH24SHLaA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d31p792sc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 13:15:53 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-128d0b690feso1233396c88.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 06:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774271752; x=1774876552; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mRTHD33x9sS/GvdPsRjBTq4ipPh5R4vU6n7QEzrj5eU=;
 b=WFSM32QboBjb6LVJiEup8q3wlWqSMJl9nkkCSW8196wsz7YxPbTCTKiqtsa970xvtT
 sPrV9u+I09fJirlbsSjdfFNVc0Ob3Lq6DlYdNds9V52npAgafhvj3qnmPtZrT+RyM8me
 IYMh0ytpHoOLi+w/uAReuadZE9EarYbGJPm0Q3tel8AZD2q+G9GS6XdldFPHalFrp3jr
 ub/4QZoYlYO96P2D/xgjpwjL10T27W7W76SiSPRq4fT8JF81TaR9W26L0+okPS1FvJYe
 YKYnEIQDfN8rdZ2MjV72plYus0zARcF5ZmNSH8Q28W8q+bqYSn2UGWeA1Bkx5WQTzjDM
 M2ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774271752; x=1774876552;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mRTHD33x9sS/GvdPsRjBTq4ipPh5R4vU6n7QEzrj5eU=;
 b=UbVWdnDp4jms5kmbQbE9ZZYA5mu2pOGEJ14yvmcR1yE2LIJ2JD4gy+folEWYQTKBHX
 xNc+GnrWj5f1fZHDpNGt6S/FZIhGFVIM3jccPl9DVvk+2iZ8JrXyihc5CSA4QvZ1UrWj
 DY+22kmbnH63yZe1mO5QlQkhrDmw6TNx0+aSMbWJ9PL02i9QWxieq0LFvmUqPo1K98Z0
 Dp0eYsSDhOKpSovEBEkcd8bIuDAL0Fcz+1QkxcdYGzEWy4MmMjlpkqv5Un+atamicD0D
 hVCsesy2irfc7LC8MtE2y9C/6XEViM+jMUdYlUq1x8EH0Ep8VnLkvMdp0HZBxsp7rrBt
 vqCg==
X-Gm-Message-State: AOJu0YwfQ0LsK8thdOVo8F1oeAeBBV8L+gkz6SjFDQaEBCmYRVVgOfy2
 QRhdlMPGiDeeZug+BE41sxF5IvwaaBkVwcsxTZUR/bvOAcKYJGjnbBRMt9amgxbGkxhGGZFI98g
 5RkerTb8e0QEAANjHJHLsQhg18ElciLNNVjHzzh8X9+EgzLzkChjw8gx6QsAsrL/f8Awv
X-Gm-Gg: ATEYQzx61xz8/BvfN1ukRnb4of/yp0dS++1Dd8pt+SuDijjsrGGIWeLf2P2ImJbYK72
 ilPAkCAGpg8wl3vmNYJLtx6wwNhfJfTvjmRdsSlWKaYlppoXXuSiQ3AvARqMN8urlhhR7lig4Fu
 jIBZZHzvUodTM6zL+0rRLWR9WeZLnFbcbDGH0VTLpk3mMGXmkXkCCcK/d5EHXOyGrJnmtGEimyE
 Y8ZAmo/nqm3HxLlEaUjdR+X3Kncy14d0B89spp57wR5onPgNm70F3Oonvjr+GYSKXzuqHUjbIBs
 LNX7zLt4PaacuDkkNJTkgPILOWh4jbgNjXbgPcv+wGdk8Hn/DGiDcsHv7NYHcbt1l3V1iT7AFx4
 ijfdqSo5Cw8rJEj7RwrjC4uSjge0cFIvTxKJlhorP0K2h1mqo6sZ80b3Ig8hAOIHsHtSS9Tr6nA
 Qt5hkH8ncK
X-Received: by 2002:a05:7022:68a8:b0:119:e56b:c74d with SMTP id
 a92af1059eb24-12a7267f92dmr7204553c88.18.1774271752335; 
 Mon, 23 Mar 2026 06:15:52 -0700 (PDT)
X-Received: by 2002:a05:7022:68a8:b0:119:e56b:c74d with SMTP id
 a92af1059eb24-12a7267f92dmr7204529c88.18.1774271751691; 
 Mon, 23 Mar 2026 06:15:51 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b14cadbsm14702574eec.3.2026.03.23.06.15.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 06:15:51 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com, marco.liebel@oss.qualcomm.com,
 philmd@linaro.org, quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH 00/13] hexagon: add missing HVX float instructions
Date: Mon, 23 Mar 2026 06:15:36 -0700
Message-Id: <cover.1774271525.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=RMC+3oi+ c=1 sm=1 tr=0 ts=69c13d09 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=HTRO867GeXLZ4amH5JYA:9
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-ORIG-GUID: IS6DVvX-gJBVFPUfGaTJs6wL3S5CZ2XC
X-Proofpoint-GUID: IS6DVvX-gJBVFPUfGaTJs6wL3S5CZ2XC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDEwMyBTYWx0ZWRfXwMqo68FifjA3
 /1H9IENn8jI3aqzBD+P/zpf/DXN3hE8RD3Nl59aqvkCEJt2B1LVqtPb7o8zU7DaA8iCtRpKdUE8
 hrgWuBX2RPNV8tMmbU80Rzgp+OAH5z3HZ8KTwVrxmKiTwDCEbB1J6L0wwzTPIil7XOYtXkV+Snj
 cczo/FVjj3BPek8X7ca+wDmtNl/nRTBUICQF1InECkr+0VxDMNBjUjrDP5F5d/yR184S5x9auqs
 PL7ymOGsVpN+Dfd1XntajqsfZ3cr+jz9d0vdxgSXz715UT6nmSuVHrrKk/syxsUJMd79kA2LXmc
 Usgi5y7vEaQrKtZPJ+X5PIT07pCcHmO7KQUViiasR9ARTFQBB24hugQdwTJ9ELb4tA1rMkuniJr
 zXBeE/aewDTL7PRMBWHyQ+joe1rMlURQsQkcE1rzegVXzy7m61qtFUNFApSz5HKhES193ISMKa+
 S1xiYTcEjGVvW/fBvdQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230103
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
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

This patchset adds 59 HVX floating point instructions from Hexagon
revisions v68 and v73 that were missing in qemu. Tests are also added at
the end.

Brian Cain (1):
  tests/docker: Update hexagon cross toolchain to 22.1.0

Matheus Tavares Bernardino (12):
  target/hexagon: fix incorrect/too-permissive HVX encodings
  target/hexagon/cpu: add HVX IEEE FP extension
  target/hexagon: add v68 HVX IEEE float arithmetic insns
  target/hexagon: add v68 HVX IEEE float min/max insns
  target/hexagon: add v68 HVX IEEE float misc insns
  target/hexagon: add v68 HVX IEEE float conversion insns
  target/hexagon: add v68 HVX IEEE float compare insns
  target/hexagon: add v73 HVX IEEE bfloat16 insns
  tests/hexagon: add tests for v68 HVX IEEE float arithmetics
  tests/hexagon: add tests for v68 HVX IEEE float min/max
  tests/hexagon: add tests for v68 HVX IEEE float conversions
  tests/hexagon: add tests for v68 HVX IEEE float comparisons

 target/hexagon/cpu.h                          |   1 +
 target/hexagon/mmvec/kvx_ieee.h               | 119 ++++++
 target/hexagon/mmvec/macros.h                 |  16 +
 target/hexagon/mmvec/mmvec.h                  |   3 +
 target/hexagon/translate.h                    |   1 +
 tests/tcg/hexagon/hex_test.h                  |  16 +
 tests/tcg/hexagon/hvx_misc.h                  |  14 +
 target/hexagon/attribs_def.h.inc              |   9 +
 target/hexagon/cpu.c                          |   1 +
 target/hexagon/decode.c                       |  22 ++
 target/hexagon/mmvec/kvx_ieee.c               | 234 ++++++++++++
 target/hexagon/translate.c                    |   1 +
 tests/tcg/hexagon/fp_hvx.c                    | 150 ++++++++
 tests/tcg/hexagon/fp_hvx_cmp.c                |  58 +++
 tests/tcg/hexagon/fp_hvx_cvt.c                | 194 ++++++++++
 tests/tcg/hexagon/fp_hvx_disabled.c           |  32 ++
 target/hexagon/hex_common.py                  |   2 +
 target/hexagon/imported/mmvec/encode_ext.def  | 127 +++++--
 target/hexagon/imported/mmvec/ext.idef        | 357 +++++++++++++++++-
 target/hexagon/meson.build                    |   1 +
 .../dockerfiles/debian-hexagon-cross.docker   |  10 +-
 tests/tcg/hexagon/Makefile.target             |  14 +
 22 files changed, 1354 insertions(+), 28 deletions(-)
 create mode 100644 target/hexagon/mmvec/kvx_ieee.h
 create mode 100644 target/hexagon/mmvec/kvx_ieee.c
 create mode 100644 tests/tcg/hexagon/fp_hvx.c
 create mode 100644 tests/tcg/hexagon/fp_hvx_cmp.c
 create mode 100644 tests/tcg/hexagon/fp_hvx_cvt.c
 create mode 100644 tests/tcg/hexagon/fp_hvx_disabled.c

-- 
2.37.2


