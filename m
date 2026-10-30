Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673DA606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EtHrKkPw;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ps6CMg73
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMrIY-0004TJ-9R; Fri, 30 Oct 2026 14:25:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMrIX-0004TB-6X
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:25:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMrIV-0002Mp-Kq
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:25:52 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UHuCmj4025953
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 18:25:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=AEdDOBTlpa4SeBIfvQwe4R
 iOMQyLZ/vT9bhNVR4rNA0=; b=EtHrKkPweDQlDdljmPJaq8Elq01YLamxJ0nbIV
 2zVCOmQBsZZtEs7aYjYAIHaPjaV6BTucCbHamQF52k08QjsWWaOh6JxV2uWxNmGq
 2R2sMj5PyBti1dM+RkhB8ciywJDdLtRHH/hi4YsHGMjEndLoZfergoNLN3qsdfeB
 66YgFB9pGN+HJVdw1f0q4cLR0YglsTTwW0ZSfXwBIhZXbtL7S+6gXOhiObL7Uj1i
 zdMTDdVKsj8/dFrKS0tnPaUx3dYpOAF3HniH47SBFoLEazdizUs+f+UMpX/BhsGI
 iM5qlAhI3aN7gf0CxQp2Vm6nKAUIMgNLgrdC6tlAlEaWZofA==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qmd7k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 18:25:50 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-7cc694cb4adso221954137.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 11:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793384750; x=1793989550; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=AEdDOBTlpa4SeBIfvQwe4RiOMQyLZ/vT9bhNVR4rNA0=;
 b=Ps6CMg73pftrAxbtivnPCZgg2YMKrLeRyH84bBGmQuGouGHj/A1ba4iauIAEqFwU1u
 ylBX6lA/4ncDAj9OSx40u3XEMxyp+2fNNqP2ghR0kgBEXz4NhTY6DJ7BtN8IMA17Vy2b
 toAT7hvd3hQn5VC3j7lO+mxNtRiPdrJyx9kl8S4B3EFFxdbi71mXbxUIqIFca1MEh6Cu
 W9xp7iduyDs1DBlvfN1PkZr40ZRYze7Z97PcHiaJ0o1OdnYyqLEiTsqOZONS3XAp0wCN
 1rws8XBPN2ZG1rqgWucW0MEY97S21PUxinOEMDnB4TIdIwScIqqQ5f3tPbdvnnxMnLTz
 4Uhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793384750; x=1793989550;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AEdDOBTlpa4SeBIfvQwe4RiOMQyLZ/vT9bhNVR4rNA0=;
 b=vssIlSN97sG64CF5G39puGVEk6QAFed8Nf5Grc53JYfd2mMG4ixByWbDbWKQsk/Ne+
 vfVVZrSKQ8j+ioxKq1vcPSCnms56OwAYZ3fWtiK2InXVtft9eMkhFp2i3xOLPEF4e+mv
 YCQ633amcc7LQRK/UrHuvrWEsqCJBxrVqdXeReO99UmOpFo3T9J0ii8oLowR8HPOnFec
 Z4CHqqmzPUOuuXdX0XLD3cE5w2GdVQ2W4sB+qbV3PoY1ek9if1aOSCc/jlX3Mlaq9ZQK
 ZA+X7M6mEg2QkkMmUl+tmPUpWA8WCbMedE1shlavClEsFRxtWPKF7JbzXh5Tl5muB0dw
 zq4A==
X-Gm-Message-State: AFq9FYIk/5JZzE9t3gJ4F7Dux49bcqwnLwUtigbwz3YnNA1nnOnnm5AO
 BgQ5EEtUQBzso4BNcN5plt2LXcs2qnLD08T2kpKDyj4o5GhHWe+cpS4gYnQZMXQQo88w9h2p5EK
 x+8MbKfvZuulIxn65lg92Lhe8eeUxO/rlE1ziA1kKbVg9DVF8PpdGR6GuZlNeZEqXkkE8
X-Gm-Gg: AYBFou2OJwaGlRaG7qwEz7mdaEQJab4+j+c9bI6o0lL3U1GL87GTyW+Xlgd8vqDbEsd
 I9PVPFvCfAA4LegDeO1ega2yw23B+xfJY1CwZUnbksSpziDRi+d78FBtb2t3VxlcD66spelVnST
 3R3YXPYWrOG0CabGGjXBnYGRsi+KPHbWZKYgBCClYVZOCSO19tKyT/e1sELe7FkArPzcpqmo+ul
 xwgmmLKZuYYPdt48iUcm9cPmt5vN8eSnlkH+XzV4ZkdsLpcv/EGP67G8pn/adgVJ/qFe4Pc/B5t
 hcbi/DkfA8/5TLvcwY58d/hBwjpuo0Lj4JXwEexfgxpApfT7vusmpwOqSA5txgk/Swz7rNPvQYJ
 piU4/2nW5Ak2t41r/sagHqXZxPU+Dn/BN/UaSCADGPAUTLCYDOopKhc44NVtYJiLAnjiVqPmjNK
 e01gZh1X9ZpcF1LzubdCDKY+KCH3GU3g==
X-Received: by 2002:a05:6102:f08:b0:7d0:5688:f511 with SMTP id
 ada2fe7eead31-7d0725b54c6mr1746413137.16.1793384749533; 
 Fri, 30 Oct 2026 11:25:49 -0700 (PDT)
X-Received: by 2002:a05:6102:f08:b0:7d0:5688:f511 with SMTP id
 ada2fe7eead31-7d0725b54c6mr1746394137.16.1793384748969; 
 Fri, 30 Oct 2026 11:25:48 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d4f9sm4646922f8f.2.2026.10.30.11.25.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 11:25:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 00/12] tests/tcg: Add MIPS32 Release 6 tests
Date: Fri, 30 Oct 2026 19:25:33 +0100
Message-ID: <20261030182546.2508-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: gdLcaBU-4J2e85ExwodNe88yP6yIjn2G
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3MyBTYWx0ZWRfXyANgnASTWzXf
 oanRmtJIL1HhpnyprkKRb0Ls9stY1KDGIU0gF+Dy+oLtWBnyiLYlR+jkq5YOyDKcI0hSEjGMvUm
 RuC1wdGBE3eREh5oGR9inbKMeULXvAM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3MyBTYWx0ZWRfX2/wZBPjXtEXI
 A2QsUohTw+ghpEbUkPOyWC9Qq4hcYScBDiBswX0pjzmHlfFEUJCc1QNE+edPIm4bkdPDRmUKDAb
 toos6G1q9pMDvLdlaeIf5NxygtragWllyNOnR8SbEEPZmykDrFNo/8J/yVNEYc6F5cyE74Ulr/a
 h5IHIqNkT93LAfpdsOIO9KGE3LHh8wxhC+g/r9x1RLkv1zdXKKeNSC4Cy00qNUKaHmaUGYzy93W
 0d9CdLqPbjmYB351d+ES0ODrd6OiUK9+Ny8zXv/DrDV3zSLnbZJ/QOcXCSMcZDSK68wxiVqMMk1
 qTP7TDdd7ewELXmMtUmdN7kIMgkXIuBSGJP2FsYxGYqFq2Z0awLoUrGOETVJOVApBRifDAGRRvL
 STKwQaZ//bLLvVwUg/UuIPwhKgoLm/BAM6QUy97omZgLTgmM7fIa8xvnCJv1GNfg/esq1ciEK8s
 PaQws/ikpn4dWAmN+0w==
X-Proofpoint-ORIG-GUID: gdLcaBU-4J2e85ExwodNe88yP6yIjn2G
X-Authority-Analysis: v=2.4 cv=TpVzFzXh c=1 sm=1 tr=0 ts=6ae4e12e cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=g_wvgEvSoXs7u6HgXSkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 suspectscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300073
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

v2:
- Use Debian toolchain instead of Bootlin (pbo)
- Convert to TAP

v1:
- Include Bootlin mips32r6el toolchain in debian-all-test container
- Wire it to meson
- Cover all the 32-bit opcodes tested in MIPS64 Rel6 (using TAP)

Based-on: <20261030175357.99684-1-philmd@oss.qualcomm.com>

Philippe Mathieu-Daudé (12):
  tests/docker: Add the mips32r6el toolchain on Debian cross container
  meson: Add the tcg_tests_cross_cc/cflags options for mips32r6el
  tests/tcg/mipsel: Add MIPS32R6 logic tests
  tests/tcg/mipsel: Add MIPS32R6 shift tests
  tests/tcg/mipsel: Add MIPS32R6 bit operation tests
  tests/tcg/mipsel: Add MIPS32R6 multiply tests
  tests/tcg/mipsel: Add MIPS32R6 PC-relative tests
  tests/tcg/mipsel: Test MIPS32R6 SELEQZ and SELNEZ
  tests/tcg/mipsel: Test MIPS32R6 DIV, MOD, DIVU and MODU
  tests/tcg/mipsel: Test MIPS32R6 LSA
  tests/tcg/mipsel: Test MIPS32R6 BALC
  tests/tcg/mipsel: Test MIPS32R6 JIALC and JIC

 tests/tcg/mips/include/wrappers_mips32r6.h    |  91 +++++++++++++
 tests/tcg/mipsel/test_mips32r6_bitops.c       |  79 +++++++++++
 tests/tcg/mipsel/test_mips32r6_branch.c       | 124 ++++++++++++++++++
 tests/tcg/mipsel/test_mips32r6_logic.c        |  65 +++++++++
 tests/tcg/mipsel/test_mips32r6_multiply.c     | 104 +++++++++++++++
 tests/tcg/mipsel/test_mips32r6_pcrel.c        |  88 +++++++++++++
 tests/tcg/mipsel/test_mips32r6_shift.c        |  81 ++++++++++++
 .../dockerfiles/debian-all-test-cross.docker  |   3 +
 meson_options.txt                             |   4 +
 scripts/meson-buildoptions.sh                 |   2 +
 tests/tcg/mipsel/meson.build                  |  34 +++++
 11 files changed, 675 insertions(+)
 create mode 100644 tests/tcg/mips/include/wrappers_mips32r6.h
 create mode 100644 tests/tcg/mipsel/test_mips32r6_bitops.c
 create mode 100644 tests/tcg/mipsel/test_mips32r6_branch.c
 create mode 100644 tests/tcg/mipsel/test_mips32r6_logic.c
 create mode 100644 tests/tcg/mipsel/test_mips32r6_multiply.c
 create mode 100644 tests/tcg/mipsel/test_mips32r6_pcrel.c
 create mode 100644 tests/tcg/mipsel/test_mips32r6_shift.c

-- 
2.55.0


