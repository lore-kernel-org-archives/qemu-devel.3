Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21525606A31D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 16:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XDQraffH;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=L9sTrtgo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLNRG-0008OJ-3w; Mon, 26 Oct 2026 12:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLNRC-0008MU-Re
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 12:20:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLNRA-0000ST-Nx
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 12:20:42 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QEvlOU4098826
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 16:20:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=MQnPqndRovZIjl7Bw00yB0
 HCwoM1YtvyEcPBlTAZOYA=; b=XDQraffHaWyeCy6csR+fpJJdWz74Q16+3q1Zlv
 mDqAmM302y8x6A8Kv6JTTzQumle3znRP48pISs+LHjs/xHjMW0esCuuoyCsgHifM
 ojSkgn55NH+kgt/AWRIZaMNayy3A0xErn/D4ahTpbywTgGtKU2y1bXjEqlXrM7nm
 r4Cs+z3M47lbz//SRpdguLNwxQumadDueJ9nhiYW4+pzDHh2EWSpq3AqOyxdMXLB
 5d8I61MNOf4+C43FAzRLyuYYUopws3pLjHFrpa7HwNnSyVAkCmqSlS5OEsLNvmEU
 kgaBW58tcmgY05mu5QyKBQ/3Wjy2PVNvA02QaDe1uvz0iv4g==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj4s91g5u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 16:20:38 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-91b92acedd9so58217736d6.2
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 09:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793031637; x=1793636437; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MQnPqndRovZIjl7Bw00yB0HCwoM1YtvyEcPBlTAZOYA=;
 b=L9sTrtgo99uhTOJUpu0oELu/19jYFy7u5iJC3Qg2xghkQ/1nS28YKaMdMGERtEaw9s
 XYFVcJupRb5Vi+W1nI6uMyFFQO4c0YByPZviGVNrnJg5VJV1fPxlq6MfeDOT+TM0Q+Ya
 bKKOD5FdTPF35LWw0NPo4x1u573TokhZWlJcxgDhYbhmCekIopLuPqhTmLHsSLoVER3n
 wx4J6HtvHUKBq0mU8kNn28NkgvpC1TxMKGvm4N/bIELeQvoARK4lGz+uIhqz9Qn5zRn4
 5sTRtMRFGxfEJf67SB5CoprSCTik6xUspeY8Xpv8OOkJBj0QhoDrSKQX2p8p/30w+iRx
 UcIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793031637; x=1793636437;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MQnPqndRovZIjl7Bw00yB0HCwoM1YtvyEcPBlTAZOYA=;
 b=Al2mFAmVRXMYb07n1ul8devxpURORgWlQNwJ3a/i9kkxVh1wEFatf/irYerAIEpaWT
 Ri8XdK1kQDvGh/5j3vo5pk2q+BQMGTmsMkWv+Bn7e9kLY6ONzjTdVCqfKbGNMG70pEfs
 5ibMOJw4I562UbMVFdGYW9g/QM5p/If9YJtX8PLwScny1R9M/qO/uuwTk8wFWkLUHXtf
 CQTweBDmdYjkTdv2dOtMuS8m3wOK8/P7xxmUoa9oPzmVc42xeVzygsdLKgKpqN27v0U9
 ZNQZnSNw0ydzKB+fHRUtc3hUmN3H60G9PmqLElbhNxALHq/lc1lhgzD2sRCkJWv9AGVL
 BnKw==
X-Gm-Message-State: AFq9FYJ+pO1rJirOvozSVKUxcUmBxmD2BplY0Thv2A7gDk7oFf6dpgjY
 mbMqX8a+kX05nwa+ADYWT3KNrXOefsOtg1a2w7zG+1yAuLzDOQBZH4z/mQEKMBX6Vgp88PSsWHQ
 yCCkF9jodDGRTj4xea0Wz4T0vMj6j+t0l1pK5dxRIFbOH1C7fnxxYt3gFS3tZVo2kjQ==
X-Gm-Gg: AYBFou1fWpqaGSYsGa8j5Cf6irpuW2CBOM2LGqI2RlwCPJ62R7ccmKGhHh/Hlo/uFTN
 iRsTMvg4xoM4VjrtNBaWB5tjizhvJn4dBYevYmQAYzrhOw/ThYtnrr6BXwIcGPAgo4jlS8aAbzQ
 jzDJyvrgUhSP7p4GlyotWNlF4kgnAP6kJ05W+xoB6WP5y4ak4QAobyh5qplea0I/KzmfTKTb5qv
 SM7HpzShFE+c9e2s9p+it8+NJ51Kq7X7U/aDgF+jk/F3p7ZeafgIUrM8RyKKmgCrdLxquuKn1tq
 6tHCqOVf4cTH+XAaEu8GAaXtHMBEjji4wVNgH4CAKjyx9iqTwG6odD+uU/XdEY50chPnlkL82T6
 Hb0KuqYHbI9GX2SrjzVw5ZgJJq8eln+jyag+zrV1n
X-Received: by 2002:a05:620a:6499:b0:93c:b420:c2b8 with SMTP id
 af79cd13be357-940ef914b6bmr1018981285a.61.1793031637434; 
 Mon, 26 Oct 2026 09:20:37 -0700 (PDT)
X-Received: by 2002:a05:620a:6499:b0:93c:b420:c2b8 with SMTP id
 af79cd13be357-940ef914b6bmr1018977285a.61.1793031636954; 
 Mon, 26 Oct 2026 09:20:36 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb99esm16669808f8f.23.2026.10.26.09.20.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Oct 2026 09:20:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 00/14] target/mips: Start converting MIPS16e/micro/nanoMIPS
 to decodetree
Date: Mon, 26 Oct 2026 17:20:19 +0100
Message-ID: <20261026162034.32711-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA2NSBTYWx0ZWRfXy9ktdMon7haA
 WPezIg0BoXhkHYlpzWRVDgKTdlRnArtxaHX6J+BV8xUJ1a/Q0pmC03BJ/013OkDLA1Uv6drfMmc
 ZTZhLWlT3YfItOu+Gj4kvrPgzlf0Mlk3q7lydlqtR1ZmRuOLUb9caS5ekwBSass1XSW9uRwIyDt
 7BOpUIfcmZx8xKUW5HNcmc1hOarQ8+z7f3GOrZOwvFhh8Nzg4qEOcyJLX6ySCFbJz4M2s/ey+FC
 qm/b5+xDTewise1NINLTmsfs9n9KeGIK9jftDb0mdLG4YXVq3PJ604fgZq5K3k+paDIpSfX9qIz
 P4Mu6XHUMWiHE9okw+XzAMAji7zPla8h7sTu4LOuTwh6EaBAaicX7zjlwoYZTkL/puH9r5Ltn0E
 uq7RGAebcCaq/Sg05JjT7r2h3d5CV+xRm0wvW63v8P95kb0ahgN33yUgGm0jAghj3UbhmMeGlVZ
 ZF7ws9BWNCWETrxZfKw==
X-Proofpoint-ORIG-GUID: CwtrGeWi08rGAS6VP0GrQxeEjH57I_64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA2NSBTYWx0ZWRfX0YIfnHV4vb9V
 Q/T1iLCCJ6Z0BlYQDFtZZ/e6AnxBnm6kR2BN7FKlokWubvqO6rqeT68xI/3p3ozS/QdreOrcUn1
 cN1hR9xmgpHGrphPT1u1/g31BaET1Hg=
X-Proofpoint-GUID: CwtrGeWi08rGAS6VP0GrQxeEjH57I_64
X-Authority-Analysis: v=2.4 cv=HKhWhYtv c=1 sm=1 tr=0 ts=6adf7dd6 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=oiSss8nPy0L6DFi72B4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260065
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

Missing review: patches 3, 4, 10, 13, 14

Since v3:
- Rebased; v3 patches 1-3 and 5 were merged
- Use translator_ld*_end() with mo_endian()
- Select decoders from the instruction size (Richard)
- New patch 4, computing the microMIPS size up front (Richard)
- Treat MIPS16e JAL/JALX as 32-bit
- Add micromips32_r6.decode; LSA no longer accepted on pre-R6
  microMIPS CPUs
- Fix MIPS16e EXT-RI LI immediate field order
- Fix nanoMIPS LI[16] register map and unsigned immediate
- Fix nanoMIPS LI[48] immediate halfword order; split the NMS
  check into trans_LI_nnms(), reusing check_nms()
- New patch 10, sharing the MIPS16e/microMIPS GPR xlat map

Prepare the build system and the per-ISA dispatchers so MIPS16e,
microMIPS and nanoMIPS opcodes can be decoded with the decodetree
script, then convert the first opcodes: LSA and LI.

v3: https://lore.kernel.org/qemu-devel/20241126140003.74871-1-philmd@linaro.org/

Philippe Mathieu-Daudé (14):
  target/mips: Call translator_ld() in translate_insn() callees
  target/mips: Decode LSA shift amount using decodetree function
  target/mips: Introduce decode tree bindings for MIPS16e ASE
  target/mips: Determine microMIPS insn size before delay slot check
  target/mips: Introduce decodetree bindings for microMIPS ISA
  scripts/decodetree: Add support for 48-bit instructions
  target/mips: Introduce decode tree bindings for nanoMIPS ISA
  target/mips: Convert microMIPS LSA opcode to decodetree
  target/mips: Convert nanoMIPS LSA opcode to decodetree
  target/mips: Share MIPS16e/microMIPS 3-bit GPR xlat mapping
  target/mips: Add gen_li() helper
  target/mips: Convert microMIPS LI opcode to decodetree
  target/mips: Convert MIPS16e LI opcodes to decodetree
  target/mips: Convert nanoMIPS LI opcodes to decodetree

 target/mips/tcg/translate.h               |  11 ++
 target/mips/tcg/micromips16.decode        |  18 +++
 target/mips/tcg/micromips32.decode        |  11 ++
 target/mips/tcg/micromips32_r6.decode     |  19 +++
 target/mips/tcg/mips16e_16.decode         |  17 +++
 target/mips/tcg/mips16e_32.decode         |  18 +++
 target/mips/tcg/msa.decode                |   3 +-
 target/mips/tcg/nanomips16.decode         |  17 +++
 target/mips/tcg/nanomips32.decode         |  14 ++
 target/mips/tcg/nanomips48.decode         |  16 +++
 target/mips/tcg/rel6.decode               |   5 +-
 target/mips/tcg/comput_translate.c        |  21 +++
 target/mips/tcg/micromips_translate.c     |  37 ++++++
 target/mips/tcg/mips16e_translate.c       |  21 +++
 target/mips/tcg/msa_translate.c           |   4 +-
 target/mips/tcg/nanomips_translate.c      |  46 +++++++
 target/mips/tcg/rel6_translate.c          |   9 +-
 target/mips/tcg/translate.c               |  24 ++--
 target/mips/tcg/micromips_translate.c.inc | 152 +++++++++++-----------
 target/mips/tcg/mips16e_translate.c.inc   |  56 ++++----
 target/mips/tcg/nanomips_translate.c.inc  |  56 ++++----
 scripts/decodetree.py                     |   4 +
 target/mips/tcg/meson.build               |  12 ++
 23 files changed, 447 insertions(+), 144 deletions(-)
 create mode 100644 target/mips/tcg/micromips16.decode
 create mode 100644 target/mips/tcg/micromips32.decode
 create mode 100644 target/mips/tcg/micromips32_r6.decode
 create mode 100644 target/mips/tcg/mips16e_16.decode
 create mode 100644 target/mips/tcg/mips16e_32.decode
 create mode 100644 target/mips/tcg/nanomips16.decode
 create mode 100644 target/mips/tcg/nanomips32.decode
 create mode 100644 target/mips/tcg/nanomips48.decode
 create mode 100644 target/mips/tcg/comput_translate.c
 create mode 100644 target/mips/tcg/micromips_translate.c
 create mode 100644 target/mips/tcg/mips16e_translate.c
 create mode 100644 target/mips/tcg/nanomips_translate.c

-- 
2.55.0


