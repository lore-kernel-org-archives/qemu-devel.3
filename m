Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8308C606A321
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 23:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lkTunrCV;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ev72r7/e
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWj0j-0003h3-Ok; Thu, 26 Nov 2026 18:36:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWj0f-0003XV-1U
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 18:36:13 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWj0b-0003lT-TD
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 18:36:12 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQJw6S4061008
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 23:36:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=/6V13vb74Tp5YQSrWoGaPZ
 uprZG42pzRfnC1PotjY5o=; b=lkTunrCV8PKCSHLPG1Eh2gbMkjyBn1VzS89VJe
 PANsRA186uZqiCJ/N9WTMB5jf/7w3+8PK4iRN1lCRMlCYrmcJ5+SJN50BowCIJeU
 GoLVwcxDiNnYDLTnzBcEJ99dyQtf31dUXDXXkShuHiOPPLpL4y0dCBWl5z9ghtg7
 MME60NmFnmxjxQDPyUB/cR64nWlZLr0YcBW55Yha2Pvo5edWwCGNmrE1i0a/ZH/J
 uAzsdAk+yGTE01HxUjR/rYgAFIemezqZ+uQTqIHZ3rp26PdzChB+s805Dm0iOUxr
 LBgRzdsGx+UxW0r2Bb1nCPSj080BNhT0aZWehyyD+tQVcLvg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6u4hrfxj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 23:36:07 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-94967c6d4f4so839697985a.2
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 15:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795736167; x=1796340967; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/6V13vb74Tp5YQSrWoGaPZuprZG42pzRfnC1PotjY5o=;
 b=Ev72r7/eQ8j3axj0vunZk5XwwUwwzeuvMFAmOaLKoDWEwM9Eyaejw+yfL5q/WMvOjB
 i0tPYrW6THVJ99Clwjk4X0GEaYwlw1r9RI1fsYbjMjRZku/fx3oK+vzBvjIx2FZbvThI
 Tuzcb+4qiGh4uJAYxae9Yc0cB2pF+qk5cqVVCrls4NfYG+QOTEF1NFzfQtQdaVnoKFmS
 IZVJetqz9lRdBjqnZFSLdZhQxvXu7U2eim4X4X4VVzdewr8SkziafCXjdOZrBnpSwTZA
 Ef3PJr3R6JFlNkKWM+/7PTtl26FoT7/EXGf8cL7j6Ms2E3aiCncnyKJfCl5J8ToTbQrw
 3yiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795736167; x=1796340967;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/6V13vb74Tp5YQSrWoGaPZuprZG42pzRfnC1PotjY5o=;
 b=sI9tRnT7uIU6qjg3lmBUcJ8P8KqagloMEcjTMUc0fnxJwt7kuKcKQAd0tEvQ32LOgY
 htIhfACS1FdSIQYyjM02nnPOmW1ostOpPH94x95zLdTmUMOOftKkzsJ9U1Yos8+1fbbX
 VpcZzGgf2C58B/RWBoicifoO7CCS/FdutAxHLmryzcw9gP4jJGgxBHPd6boutBn3ImtJ
 4n2/KkEMIkjZ2qoW7WLqSvXszwhXPwZsr+QrrlCRNvhAvVGS81wCCeTvbw8/285Dl2or
 7YV6VpyQVj1SsNK/w3aef4Zq8e1EBMcnxZfvofhwTeRPFl6p8LZEKXxWDcBh1+dYrFl1
 KW7w==
X-Gm-Message-State: APuU4Z/ni/IipQb9xIWIY2cM1C+8e0MOpxyXQdQax1shDmRPe4iAwqvY
 qFNGavcigo/gguLFPUNgCvJY6h2LYzY4StfL9qEQmlbMKkNbK6v2ZqQhaHgNtz0q0uQhuCvlA/H
 zBTYSOdiZKpybtTS20iTUayxvJVCs7ED16e+AWmKWa3zHPAOL1SYK8GSsItjgZ853uA==
X-Gm-Gg: AZFdTZe9YAiRD6l+F0dTPiN55/rgsYNiqlUuev4gugA7HAQF/3M1AYTUltYkGJF5fJ0
 edz/rDUg56srMw37SmSQsA5yFo1r/55sqSIFnHByb0HAi6nDIMMaKQTnivYzvQHhEJ9SfdjQfAz
 wEw0paDp5vv4hzI9de1OAbmzbuBLSglA/envhQMLsOs1yeREb0wWExpLDSZQpfyBd8soU5Jyvcb
 uZ2nDB8808RoJdBgNHGzBQz4lJJW7dFgo7lb7SM3B6Cz3O7g1+5pRSF0sn/nWt+xta8pRb2xA1S
 hrzKXVh1Tec0dkB1ANpoNQy4GjDA8T9diuJVHGl6xfZRJmt3I+852uVnGWrPm0hl2OK437OC3Ew
 O45D4OWz7HBoA74gbJ46mt3vTQV2+uAVmthEqSyLeI4EG6x7dB/hA5Z6MOuNMvGXf3NY2Cmmwma
 HFx7RfJceg5EOuMg==
X-Received: by 2002:a05:620a:132c:b0:93f:2cf4:e6dd with SMTP id
 af79cd13be357-949bab31a16mr3973426985a.51.1795736166599; 
 Thu, 26 Nov 2026 15:36:06 -0800 (PST)
X-Received: by 2002:a05:620a:132c:b0:93f:2cf4:e6dd with SMTP id
 af79cd13be357-949bab31a16mr3973421885a.51.1795736166116; 
 Thu, 26 Nov 2026 15:36:06 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884ab091sm897359255e9.11.2026.11.26.15.36.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 26 Nov 2026 15:36:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 00/24] accel/tcg: Widen TranslationBlock::flags to 64 bits
Date: Fri, 27 Nov 2026 00:35:38 +0100
Message-ID: <20261126233604.67722-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA5MyBTYWx0ZWRfX0b44dswOTH5e
 VEYn0YVOF1c+NmsKHENOEaIci7+jSSySc+qgJw9AmwX3s5c2mTni94cXQkNvzUzcFAmBJ8ypYNV
 hzBLG8p98Kut6wFiKnNdmfFRf1xT9AU=
X-Proofpoint-GUID: 3mhDP3JPPBCsIHXxiDbFJ71aBjaW2mAL
X-Proofpoint-ORIG-GUID: 3mhDP3JPPBCsIHXxiDbFJ71aBjaW2mAL
X-Authority-Analysis: v=2.4 cv=M9fYuCws c=1 sm=1 tr=0 ts=6b08c267 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=2XMqVGIP9XV-oN6J0JAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA5MyBTYWx0ZWRfXxWpIMBsSXd+1
 48/83JEGMQpEg+bXfN8yek6UADoUMozbbwhDTIWm6S0xPBDpQjPV8IoFHLfRGZvEJNi0C/fmNlP
 fvHIHJs18a+w4lS5yFkiSzVBYNfkXG5XGI4VlLobtjoov67j0MVulQLd5NszIFtHMv25F88BRNE
 nu+DmjOPdvxVjwksmCsWwaYmnb7vrahHxn7bYc2l2u9SOYu6CWfHoeu52n9m4r7X7kmtXJbWSsG
 EIScbM7cspfva5QVr4ADJOeWpfxTDGUP6MlNnR8fhzvo8ipGbQsuLVpJOb4giNCtpr3f2mEyfrr
 kBhrDyxyRMWXHUSb2IYpEEKQCWRmkVPrjbIT9tIw7vVqd1wiNvwCJ2ay6Y4k0huSiq0mg4wsNSM
 o0vGX2lmV7TFofJuKiEVj/P/uwxzIMx/4MGtSnQw5S1onX57AL4i/Qa/aylDhAvfoJQc5m5IHKM
 vonUvFQymtdNC22S0XA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_05,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260093
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Wanting to support another MIPS ISA I realized all the target
flags are occupied. When that happen we use @cs_base as extra
jocker, but then I remembered we aren't restricted to 32-bits
anymore and can convert TranslationBlock::flags to uint64.
Hence this series. Doing so I noticed RISCV MISA handling
could be a bit simplified using full cs_base jocker card.
Notes taken while auditing uses also committed.

Philippe Mathieu-Daudé (24):
  target/arm: Widen CPUARMTBFlags::flags to 64 bits
  accel/tcg: Update stale TranslationBlock::jmp_lock comment
  accel/tcg: Widen TranslationBlock::flags to 64 bits
  target/arm: Update TB flags split comment for 64-bit tb->flags
  target/alpha: Use 64-bit TB flags
  target/avr: Use 64-bit TB flags
  target/hexagon: Use 64-bit TB flags
  target/hppa: Use 64-bit TB flags
  target/i386: Use 64-bit TB flags
  target/loongarch: Use 64-bit TB flags
  target/m68k: Use 64-bit TB flags
  target/microblaze: Use 64-bit TB flags
  target/mips: Use 64-bit TB flags
  target/or1k: Use 64-bit TB flags
  target/ppc: Use 64-bit TB flags
  target/riscv: Use 64-bit TB flags
  target/riscv: Partially revert use of tb->cs_base
  target/rx: Use 64-bit TB flags
  target/s390x: Use 64-bit TB flags
  target/sh4: Use 64-bit TB flags
  target/sparc: Use 64-bit TB flags
  target/tricore: Use 64-bit TB flags
  target/xtensa: Use 64-bit TB flags
  accel/tcg: Update TranslationBlock::cs_base description

 accel/tcg/tb-hash.h              |  5 +--
 include/accel/tcg/tb-cpu-state.h |  2 +-
 include/exec/translation-block.h | 23 +++++++++----
 target/arm/cpu.h                 | 17 +++++-----
 target/riscv/cpu.h               |  8 ++---
 target/sparc/cpu.h               |  4 +--
 accel/tcg/cpu-exec.c             |  2 +-
 target/alpha/cpu.c               |  2 +-
 target/alpha/translate.c         |  2 +-
 target/arm/tcg/hflags.c          |  4 +--
 target/avr/cpu.c                 |  2 +-
 target/avr/translate.c           |  2 +-
 target/hexagon/cpu.c             | 16 ++++-----
 target/hexagon/translate.c       | 14 ++++----
 target/hppa/cpu.c                |  2 +-
 target/hppa/translate.c          |  2 +-
 target/i386/tcg/tcg-cpu.c        |  3 +-
 target/i386/tcg/translate.c      |  4 +--
 target/loongarch/tcg/tcg_cpu.c   |  2 +-
 target/m68k/cpu.c                |  2 +-
 target/microblaze/translate.c    |  6 ++--
 target/mips/cpu.c                |  2 +-
 target/mips/tcg/translate.c      |  2 +-
 target/or1k/translate.c          |  2 +-
 target/ppc/translate.c           |  2 +-
 target/riscv/tcg/tcg-cpu.c       | 58 +++++++++++++++-----------------
 target/riscv/tcg/translate.c     | 49 +++++++++++++--------------
 target/rx/cpu.c                  |  6 ++--
 target/rx/translate.c            | 16 ++++-----
 target/s390x/cpu.c               |  2 +-
 target/sh4/cpu.c                 |  2 +-
 target/sh4/translate.c           |  4 +--
 target/sparc/cpu.c               |  4 +--
 target/tricore/cpu.c             |  2 +-
 target/tricore/translate.c       |  4 +--
 target/xtensa/cpu.c              |  2 +-
 target/xtensa/translate.c        |  2 +-
 37 files changed, 146 insertions(+), 137 deletions(-)

-- 
2.55.0


