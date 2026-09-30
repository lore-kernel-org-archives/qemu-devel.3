Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF4B9CA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 02:02:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBjdc-0007Qg-O7; Tue, 29 Sep 2026 22:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBjdV-0007PF-LS
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 22:01:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBjdR-00033m-UR
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 22:01:32 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68U1APVN1264036
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 02:01:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=zncZTuTmr2DPGKwNRzLl+d
 akNGtXgZ2A+yf8/OUuvA0=; b=XfDcxSueYmkKfDZMVE2BPBg3ZR3va994baSMx/
 NUhxCiCT7+bXgdF8O7XqXdQGQI1q9o9oe66TSZdC9VjaOXy9hdbk/VIbqAsOyD4V
 KDhDU8SWHoIvbCF9+vW5MRxgg0BA2lEjkYGZ75/ItWgZSMMZMmarpfRZyYGW0zlh
 asmpJhnNqLU2fxOhbLtcDKdENNi7rk0KQIQ0oQeVHUqwgLK4l97DS0upLZzuf2DR
 ULFQsSZ522xnQ8kXe7BldXx0mpjtfhny5z+wwxcjE3wVN1XD0Sdvz/dizH8ev89s
 iN5KwZca0RMnRN9Yyoh9dTtTx4uHTokwCjQyOMa90C7m+zCA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0rheg504-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 02:01:27 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-341eff9e381so5161320eec.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 19:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790733686; x=1791338486; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zncZTuTmr2DPGKwNRzLl+dakNGtXgZ2A+yf8/OUuvA0=;
 b=X4N0lcU0RvdoA39u7x57NTqhW/Y8Si54V+PrZrFrVpyujciqrgzyj5PBEPqt1maRal
 8Fd2SyGkibdY2f7UvLMeO3dmZ1NsWTZjXcCJIKMHCUdP9JQEbX3e7NrFtE+JgRXQRMR0
 B0UOoE/L0VwTRPoBEvkBRNvJI1n3WdjTlDXv4KMOHTM66aN/NpEaVFE0cN1De0PNTq8P
 fPjGuvYZo7QjIWxPZNkuvz9k+z5mJ6BWtyMHc4cwUHiZ6GZN5hmbePjQGIdDwA5CN+8H
 XbvqVuvw4QeINe/6hTMZonN9YGrNfezxDkQBy1TPaWeEpj6VkJmIdlUKotdEtdDXmbrG
 NQHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790733686; x=1791338486;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zncZTuTmr2DPGKwNRzLl+dakNGtXgZ2A+yf8/OUuvA0=;
 b=N0iyhT06DMMpu4RLuWOj2KkcuCKtLSYL54Hwmjzxpagrx8km0oilMDVEg6KJi0kJqN
 86EW/IZtvfLonp6BzlVBXIdJKYHDjO63TDCJ0FPhIHiLwtb1303N+G40vThvK2EXqmhW
 ufyQqS4gvN+gWj6Anme8PXJG5DXDnGGrWorRFDuF30uZR4mmmfMq8QikIsj0i61z+OXK
 BHIGKkWvN3V44dDmVnwA0tXuNin6yTFKJfHpWldJXz5szrscrzv5fY8FoTkgaBcslWWJ
 P5YRtYgVfzGWZIJorVawcW2uHhDzVi0/0CEm5uCn5hNBS3RNK3mCrPJT1vYOGhyB1AY5
 kw+Q==
X-Gm-Message-State: AFuF++l9uBGnoFym2R3VG42LUyUC5hwhYQa54ilL7fhlYZhHBE5yFMW3
 vOHzYYbaX6oSIoDtUzyu5KhL+Ef6wL2aXHRl6nxVyKK5v6fU2iL+aCx+R6mDlMfEocaJa+u3B6g
 Yiw+ufFc3IK/NJ6hep6rW2Qs7qr1HlrkwXh4U4i9a1VsWTYX19V4ELnCv2ExdIIvg7A==
X-Gm-Gg: AYBFou19kXj1svdg3eSZClVha5ru9PxjyqL8S6INhoiud2nq+tvPC9WB9b0+xffskXh
 caFNF1C+IEjf+uqMpXRnp/36ZffPbpTrRd74gA4fQkhoCF5v1mAcz23PxCnamWfGSwrh3PkNPLP
 0p91frI8rG5SZhFk7iBAExTwHuX3QDN7fQsKevsPnHlxi3cPT2nvFs133j+bU0fcl4ZK0gg9K/7
 7s8Yk4UoZoOwF5Opjsp5Z1aAK2yZ+Xnjm78MKGJ8JzfkaNC/N2MVdC4wufNYzvDZJhVTKwDaYYz
 lFAiDfma7y6qlwWXWzC11I2W4ajR0rfa6c1Za5JhSwSCN2CEopKfLHTfCLazOyLIQqRErXnk35u
 7ag95Jj710fBMlVQI3feT7Lp4RKE+Ji3ou+oo2WWoR18A/Sal92K5oM5agWG8
X-Received: by 2002:a05:7022:294:20b0:137:e6a1:c4b3 with SMTP id
 a92af1059eb24-14c98942dadmr1340662c88.0.1790733686102; 
 Tue, 29 Sep 2026 19:01:26 -0700 (PDT)
X-Received: by 2002:a05:7022:294:20b0:137:e6a1:c4b3 with SMTP id
 a92af1059eb24-14c98942dadmr1340621c88.0.1790733685271; 
 Tue, 29 Sep 2026 19:01:25 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34c388cc02esm3174803eec.21.2026.09.29.19.01.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 19:01:24 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 00/21] multi-target: add straightforward architectures
Date: Wed, 30 Sep 2026 02:00:47 +0000
Message-ID: <20260930020108.217892-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Xp_eWfnteSwJVVTe_1gNMihqVL3qn8ia
X-Proofpoint-ORIG-GUID: Xp_eWfnteSwJVVTe_1gNMihqVL3qn8ia
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAwNyBTYWx0ZWRfX+RvYufoLtyA2
 LoO4RpDF4G0qJAtOjRJfBA3ONP5i0DDGtuBKi61f0ilKMh+k+67TYXCFidZVtBoFl/Dgm0yvWPq
 ZjRb5bqEPZ8NaphtW5nw/XrpwA5nMzxU/zE0CSuol/GVKf2L0CjB+FPFXbFo6wK40RUKVF2ekbj
 bEiQG2CrRGZOPScpa7UfWboOBMUD4mYruyOJFm87ewtoyWzQI4GzHhVT1nZwYS2IPvKqgrxvMCs
 DqoD2qIQJn2XqSpu0nkN1GtLSK5JR5pxisU2qZZ3dSkrIh43iV6F29MF7mr6f/19wryoWnpi9Cv
 JFqi/UXaKGhZVFlmAVQcWw7rParO1YwGI/zyUQK5cdcKe+RWR5Bn4ZUry3osGxkEoKTNL8R8kUk
 brgtPoidLm5p7XC4nFFaAlAaD6vRFQH1lHU7e2qY1DmZSFxNvIbgl5C2TYrMEGUHmHrrcdVXgTe
 YSoaIVK61poy/o4xsuw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAwNyBTYWx0ZWRfX6k9PkqYtYgoM
 6GCnoAtIPRfmtEhHUQy3ak96tuCNf1lAuJb0VGqxcQzzlZ7D8aYp3HVU9PkD+a9/Icxy4c0Vhr/
 Mr+wWRxiPF5PYJTFNCi7FFCb4OaOu0c=
X-Authority-Analysis: v=2.4 cv=Tu1zFzXh c=1 sm=1 tr=0 ts=6abc6d77 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=zXyrj37FFUh65mByYT4A:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300007
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

This series adds all architectures that only require stubs, basic helpers
renaming, or filtering to be included in multi-target binary.

List:
- alpha
- microblaze
- m68k
- hppa
- rx
- tricore
- or1k

Pierrick Bouvier (21):
  hw/arm/virt: make virt machines available for base arm targets only
  meson.build: subdir system before finalizing stubs library
  system/meson: use stub_ss for dtb stubs
  target/microblaze: prefix helper conflicting with other arch
  target-info: add target_m68k
  hw/m68k/virt: make machine available for m68k target only
  meson.build: add m68k to multi-target
  hw/pci-bridge: use stub_ss for pci_expander_bridge_stubs.c
  target/alpha: prefix divs helper
  meson.build: add alpha-softmmu to multi-target
  meson.build: add avr-softmmu to multi-target
  target/hppa: prefix helpers conflicting with other arch
  meson.build: add hppa-softmmu to multi-target
  target/rx: prefix helpers conflicting with other arch
  meson.build: add rx-softmmu to multi-target
  target/tricore: prefix helpers conflicting with other arch
  meson.build: add tricore-softmmu to multi-target
  target-info: add target_or1k
  hw/or1k/virt: make virt machine available for or1k target only
  target/or1k: prefix symbols conflicting with other arch
  meson.build: add or1k-softmmu to multi-target

 hw/arm/virt.c                  |  2 ++
 hw/m68k/virt.c                 | 10 ++++++----
 hw/or1k/virt.c                 |  1 +
 hw/pci-bridge/meson.build      |  4 ++--
 include/qemu/target-info.h     | 14 ++++++++++++++
 meson.build                    | 10 ++++++++--
 system/meson.build             |  4 ++--
 target-info.c                  | 10 ++++++++++
 target/alpha/fpu_helper.c      |  2 +-
 target/alpha/helper.h          |  2 +-
 target/alpha/translate.c       |  4 ++--
 target/hppa/helper.h           |  6 +++---
 target/hppa/op_helper.c        |  4 ++--
 target/hppa/sys_helper.c       |  8 ++++----
 target/hppa/translate.c        |  6 +++---
 target/microblaze/helper.h     | 10 +++++-----
 target/microblaze/op_helper.c  | 10 +++++-----
 target/microblaze/translate.c  | 10 +++++-----
 target/or1k/exception.c        |  2 +-
 target/or1k/exception.h        |  2 +-
 target/or1k/exception_helper.c |  2 +-
 target/or1k/helper.h           |  2 +-
 target/or1k/interrupt_helper.c |  2 +-
 target/or1k/sys_helper.c       |  6 +++---
 target/or1k/translate.c        |  2 +-
 target/rx/helper.h             | 12 ++++++------
 target/rx/op_helper.c          | 12 ++++++------
 target/rx/translate.c          | 14 +++++++-------
 target/tricore/fpu_helper.c    | 12 ++++++------
 target/tricore/helper.h        | 14 +++++++-------
 target/tricore/translate.c     | 14 +++++++-------
 31 files changed, 124 insertions(+), 89 deletions(-)

-- 
2.43.0


