Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CAE606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 07:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JMduPw/t;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VsgNcIKo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKVtm-0008W9-NM; Sat, 24 Oct 2026 03:10:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKVtk-0008Vh-Vn
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 03:10:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKVtj-0000Lj-74
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 03:10:36 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69O3Yguc529156
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 07:10:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=brQzJ4Cw05o+BgSIuJrHCJEmTF9bfBa4eX9
 Lxyz4Woc=; b=JMduPw/thK5XpbtZIWExkRwe/5WwgrWji0hCglMQ+0DkCSwrt4g
 4Tqr3BDCp3M7ujpcZmRri9ygged2vX8b8Wj/9CedsI4LOg1YAJm3udPfbu9rJc4P
 l3pbREFgVPeusmubfi7uG4VJyKD4ho8GrbwDkDt6+rHVpWYoHE1pvfMKuB2s5pyK
 Oj3T3Pwi+NJRHhIf0s+JlLxN632spWEKHGkodVnbTJregOhcb6J9I0FJeuKBpqlh
 4MfqXMaTQBWmEeTp69hvx+zB6wy+hc0DCiNHYnSumLVRqvvJiUgjkp/qxaxmTdLa
 2XoHSWZHol0L0U+apb2ZAs0P0aZlErEgh3g==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgmw3gcfj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 07:10:32 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3ab2cb8d5dbso1309923a91.1
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 00:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792825832; x=1793430632; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=brQzJ4Cw05o+BgSIuJrHCJEmTF9bfBa4eX9Lxyz4Woc=;
 b=VsgNcIKoVvKCbT9Zz7Ny+kZKHahBbXjbWo3hfXLWgqNs4HunzA6i9Z8e537HPc48fQ
 jlMsynwsNsBNvZ6puKxQsh8vkSPxfLt7EETM+BExKdBnegXSQvU3VKHt0UYiZMDYU269
 K1XVDyvUFvtaJmMUTX4Z5CJC2stzWqEq3sSmRbo1Tq/qTToYF97ecJOF/hDWcLl/5pu9
 7N4Wn7io5evw7FimjGow0mrqhuyahtwiHdP/H3FKuGzrOV5bsFuMVje/96I61ute1Nn7
 5sNBuGvd1C/TrwrpTVzZ5YL8is6Wz9qfTZfBvoobnUW6mb7nDZxexc5WMXEWsp6YUIYE
 csVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792825832; x=1793430632;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=brQzJ4Cw05o+BgSIuJrHCJEmTF9bfBa4eX9Lxyz4Woc=;
 b=eXHJr6Y3osYRuA3jgvjgx0qAdsnjmzF4Q/mqzLl33lNDhk8Hei7u+BPX0Q8OILYImT
 ykTBGe7TgNcfu0ZzmIvEi2I58tooCp29dVNrARGXUPHa6++3B7VTdyBCGjzX2iM9hOkX
 ONYb6Kx68KlyT/bJnazgLh8th7TGrIis60kC+wfRCnLBtMXc6BCL/c0++aA1I8dY1CIm
 AH+RYCtGmR/Q6LsxvylUrDn3xot+6T4TxP+RRj2mW6I7VLiTWnDvclE7Ds6iGokCjHhU
 iv1TGHsBiVbVKdM2FnuEfBgbHkpgSivcYU2bYUUpP8CE+faSx3R/w7kvrXGogzG4nfQc
 HccA==
X-Gm-Message-State: AFq9FYJHn7s1Uhb0MGf0QK+47uD7i4ZhEu9UqxJXGO3+Mbjdxz+/15je
 yzuTEMPa6wPF1JdvLniKaSbcidt5xmbgJHgFIYPYzTWUGqTrRbXRbseAQ39wtrumkhDxBhpAJkb
 rvb89u734YIwZ6/jPCS1566w5blBu7vcxS6eq8s5F/X8fr8OHok1KLB8o0X/DNG5kyA==
X-Gm-Gg: AYBFou0MEbdihobDsXqs2zO3uo3jzWzvL/u3L6zYTJ7fzQrJ2DG7MSFOez3D7mfaLyO
 INWmmNHH1JsHxbnKZFsR6cqYCoCntF2NoW3JlhVXLrKMwLdVFYOCtpy8tZq3+igsUSvzks/rTIb
 1mqNZJ0RMSy/gFTFbteunG8nYxH4QLWZJ2JZAv4i9c5RYNYpFQYrrVi1hlzeYJLAPGzm3Wgs4J8
 fwMwrxXBMjLq3QziM54NKtMPdY082n9lWvwF8r53oiahZHdJuaBjmphzx2ALzGzVYoSNegDcCdI
 /76WgvjONGjYA6CKjRwalTO95rBP6oGmchmDu4lo59WiSQq1XSz0ZchiBIVr5yjRJQSRGgWNAG5
 qcfnoqwk0YUP7DX84pBaZEZ8ytoaWCZmizCeUmzOfyGTmurD/Wycs0asuH+Z0gY4=
X-Received: by 2002:a17:90b:2552:b0:3ab:e588:c278 with SMTP id
 98e67ed59e1d1-3adea9dab45mr1253441a91.17.1792825832100; 
 Sat, 24 Oct 2026 00:10:32 -0700 (PDT)
X-Received: by 2002:a17:90b:2552:b0:3ab:e588:c278 with SMTP id
 98e67ed59e1d1-3adea9dab45mr1253423a91.17.1792825831604; 
 Sat, 24 Oct 2026 00:10:31 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebb0639bsm1936919a91.12.2026.10.24.00.10.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 00:10:31 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 0/3] tcg tests 20261024
Date: Sat, 24 Oct 2026 07:10:23 +0000
Message-ID: <20261024071026.5092-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: _xtXTGRBc5CAsP36XVqMvULXIf3zXnDR
X-Proofpoint-ORIG-GUID: _xtXTGRBc5CAsP36XVqMvULXIf3zXnDR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDAyOCBTYWx0ZWRfXy8fIvNAMe1iH
 m9eieA8F0bOpuncwczfycUxpf0bwHdrgVIEWuHnOL4ZvymPCbT+8xn/MfdEtOQI/iOdiHeg488j
 24FrHkgzBXRJ34P2WckfL7R4lnQnIdE=
X-Authority-Analysis: v=2.4 cv=HqHjiETS c=1 sm=1 tr=0 ts=6adc59e8 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=NEAV23lmAAAA:8
 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=w6V4ERbfgRYp_P9UAXEA:9
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDAyOCBTYWx0ZWRfX5pFDRS5WLM5s
 HkwPU8QPWIJRG6/PymdOCmuD+Wz1z5u/HPNYndME8DuTs9nh3PZBsY91CX2iclGuR0D+o3UfVZz
 xPyfG9zrZXp0+tT/q8kAR0Ikq6RwFbXBvS7/ZT9YTb0bqzakEZUUF4jyadA6jX/mG1Di8LHzzfV
 +6Ua096Z3HStV434PegRH8xJwUwL9GGGG4N8kgNPv5E7KESIsYSbaIBPsi9XegoFxI09sicPHok
 Z02SZYhgPTlTxMvwhgFzwJJyXOiIeBSIDt5O5Q3wue+z5wKPZZs08ILy1C+vgbA7/BmBK+zkaHh
 rwgtCY6pFgLogm3dDWTIN4p305kzF9c4IaN6yaRbEwhjcgwYs7bXfAeMV19260D+kMyqSW5Kycj
 hwTBNX6dBf7Z2BnjGBxjh2ICJcxb3l5CJvqWoQclHWGs/xcHYtlK7NE8kH0cou6RTsJWBJEHStB
 8iO3R4XJAd4IKrDPNKg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240028
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

The following changes since commit ab5b7ba3794a016663c7200a92045fcca3ed7f1e:

  Merge tag 'pull-loongarch-20261023' of https://github.com/bibo-mao/qemu into staging (2026-10-23 11:45:20 +0200)

are available in the Git repository at:

  https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/tcg_tests-20261024

for you to fetch changes up to 9963acf1930536e8f67a2ee4b2201e6187ded93b:

  tests/tcg: remove global meson variables (2026-10-24 07:09:47 +0000)

----------------------------------------------------------------
Changes:
- [PATCH 0/3] tests/tcg/loongarch64: fix hang with softmmu-gdb-memory (Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>)
  Link: https://lore.kernel.org/qemu-devel/20261022201733.1941651-1-pierrick.bouvier@oss.qualcomm.com

----------------------------------------------------------------
Pierrick Bouvier (3):
      tests/tcg/loongarch64: restrict gdb tests to gdb >= 16.1
      tests/tcg/loongarch64/system: reenable gdb-memory test on aarch64 hosts
      tests/tcg: remove global meson variables

 tests/tcg/aarch64/meson.build            | 46 +++++++++++++-------------------
 tests/tcg/aarch64/system/meson.build     | 16 +++++++----
 tests/tcg/aarch64_be/meson.build         |  1 -
 tests/tcg/alpha/meson.build              |  7 ++---
 tests/tcg/alpha/system/meson.build       |  4 +--
 tests/tcg/arm/meson.build                |  7 ++---
 tests/tcg/arm/system/meson.build         |  4 +--
 tests/tcg/hppa/meson.build               |  1 -
 tests/tcg/i386/meson.build               |  7 ++---
 tests/tcg/i386/system/meson.build        |  4 +--
 tests/tcg/loongarch64/meson.build        | 21 ++++++++++-----
 tests/tcg/loongarch64/system/meson.build | 17 +++++++-----
 tests/tcg/m68k/meson.build               |  1 -
 tests/tcg/mips/meson.build               |  1 -
 tests/tcg/mipsel/meson.build             |  2 --
 tests/tcg/or1k/meson.build               |  1 -
 tests/tcg/ppc64/meson.build              | 11 +++-----
 tests/tcg/ppc64le/meson.build            |  5 +++-
 tests/tcg/riscv32/meson.build            |  3 ---
 tests/tcg/riscv32/system/meson.build     |  4 +--
 tests/tcg/riscv64/meson.build            | 10 +++----
 tests/tcg/riscv64/system/meson.build     |  6 ++---
 tests/tcg/s390x/meson.build              | 21 +++++----------
 tests/tcg/s390x/system/meson.build       |  7 +++--
 tests/tcg/sh4/meson.build                |  1 -
 tests/tcg/x86_64/meson.build             | 10 +++----
 tests/tcg/x86_64/system/meson.build      |  6 ++---
 tests/tcg/xtensa/meson.build             |  6 ++---
 28 files changed, 100 insertions(+), 130 deletions(-)

