Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26015606D819
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=I7y9CqoU;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AwMSk+Cw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNtL2-0002Bz-P8; Mon, 02 Nov 2026 09:48:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xNtKp-0001hV-2N
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:48:34 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xNtKl-0000wZ-Eb
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:48:30 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A2DpLeQ2991851
 for <qemu-devel@nongnu.org>; Mon, 2 Nov 2026 14:48:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=1vWl1wxMBDsGkcS217gIfd
 LA/e35QYFAIxmHw3WnPUo=; b=I7y9CqoUjXPxyg03emeE0s2jK/6moVJEeez/UZ
 Smejf0Bn1Kf6yxnS237s2xVmZ7H+v/IGMHMt6aQab1gIQnh8k/iiDLGXvGeLZAcN
 2UiqnSRebXy53dSOIRj9JUQr5xfcCJ5M6bw246wasjlBc2/wFHY48VYhQ7J44iuq
 8NW1bTw3e1nhDJX1u26Q4MHziYRZAoR54CEwwnMTzLmvqV3neZPlR1pl7IdLBYl0
 G7dOfTNzydgmLHyZo1Ag4gB//uew0Id2wYphorIlkUk33UC63JMgmzm1FPaa/pLh
 wGSfmU9a4aWUhNfqBgthsPghRlEuahI4o3ov3HJBos+ws9cA==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpsavgua3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 14:48:25 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-9905fc56b60so2502607241.1
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 06:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793630905; x=1794235705; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1vWl1wxMBDsGkcS217gIfdLA/e35QYFAIxmHw3WnPUo=;
 b=AwMSk+Cw9f1QHFJqqxzqoYa+MCefoIDDyxp9zRJLkqZlWX8vArIxSwlDMjcgP9YkMG
 P+O2TMc0qENy+APO4KhNUakW6jifM+e5tv7dAkitSFoVqp5gCXbaVyt6d+lRPimy89xp
 5x9PSzyViZ31BwcYtoMdpFU7AsU6zu9S5X6Jb0tp09OY6UiFF/nnXQBhnv0ilr+MVLHT
 M9yF4y8vhaLBaHaoK8Z4Z8lWvY+8RZgVKklZCp3BoAg0O2SFm6p70q6d0ftaxpJ9jRj4
 MQVBMiE1acndWnCkC5nijKibueLMGjXCJw8H4MN9MLv8AVOOt7GKJw+uAoBycF6ahguz
 bohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793630905; x=1794235705;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1vWl1wxMBDsGkcS217gIfdLA/e35QYFAIxmHw3WnPUo=;
 b=xSoEaGsWwdPHYD9ailwU3qfbrurYRsVxWmPcTl2H9vTYKXZ++p/06TX9PVqVDZVqTe
 DsOVi0+uMawU289QcGara3T1g6AI6wDPCXOlCohGLu2XOjkEdntxFeTcJbPASnWE9hv+
 bAyvaYfTHjpLKn5aUre3gQgUkjd9vui78rkf3Yd8oHSh5DaUzXpfO6JJKT0e8kL5OZzp
 t7hwafR7ZG9RTIi/x5KOyFZ7lyRUKdY/3+7lPUvkqISIfu6X14wLfuodqZIooCTuQtDl
 OxUWD2+NRQLlW2Z9nIlWwaa3K+JDEODhB9wI854bB+2c1waCOn6X0+pEl5PYRnHll7hk
 DJvw==
X-Gm-Message-State: APuU4Z/DtCd59F73DqPpcLqM2CERe0Az8OKZ4EF1TXRie1d/+TP01Ttx
 0lhw8DI+QbypDQLRsBuQ4TdDlUFfO+HYRbwWgb6f02sbOMkOAAx93+CzfcGsh99PX+6rSrPiC29
 Ht8Ma9dDMkKLQgx6UUzuFrIjYW82qsWUUKU2R9pugim1RAIMNpp9w68qc0nbJDOnIsQ==
X-Gm-Gg: AYBFou2LvqJ4CpweDo2o49w+CqFc7n1bjFMEgUewFMaMvevMqh52xS0K5R9Cps93vvo
 O+K9iuEW0voU3iWoGi2sbKXiWK/bVMPCNCg2CB/DBC1y7wWTfAS+QnC/Q9yIe3JXUOfTL3iR6iW
 VPjnl9jc3M0AMc65+fZImRp1y2yYNCxLCsJdT1yiXq0w2XIhOMws8yVJkCTjKCNWHdheQM00Ftj
 6BsVintj9CSRzLTQKS2lQoM1wyRIkIc383Fw2A0EZeF/I/WrqlfBC8ZTw3ceG36kFKIWdLiZxmD
 le6i9iuYcF0ugP/Z9eHt91Lg2MIo5bJsqW8seOU+Q9WnG2z6fLruwSjxS63gyQa1J7GqAQJI3Pf
 44dFGo0+DHYpfxHwSK/J5W7hT6AWG8t6Jhu3CaLV7EaFCVxiLMulfsW6lef7cBdBLwCbXDJBDEZ
 FhHwAdb8lOVlJdXEilXgerVSlVo47n/g==
X-Received: by 2002:a05:6102:6a8b:b0:7cc:8e7:bde3 with SMTP id
 ada2fe7eead31-7d053f23392mr4526370137.2.1793630904535; 
 Mon, 02 Nov 2026 06:48:24 -0800 (PST)
X-Received: by 2002:a05:6102:6a8b:b0:7cc:8e7:bde3 with SMTP id
 ada2fe7eead31-7d053f23392mr4526364137.2.1793630903829; 
 Mon, 02 Nov 2026 06:48:23 -0800 (PST)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71ba24f6sm20956440f8f.51.2026.11.02.06.48.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Nov 2026 06:48:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/78] MIPS patches for 2026-11-02
Date: Mon,  2 Nov 2026 15:47:02 +0100
Message-ID: <20261102144820.46522-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA1OCBTYWx0ZWRfXzlHyX+nWImpt
 ukJW7JiCdqs7QUbgFYj1+rI7PSGAaAg+x8VVPKEh6k6w8ybzPoJUlI48C5bAfxiK5NdVBbRAxhz
 GLq3ioH/xO1EFPLsZSTWwrT4hyObTbPod64ykelmrxangYM8Dyij3WtdHy5340TKNbVxUeRsu7z
 jlb5NhR/UG5C46KmyLsXxYo3rfp9qxF+UuAcBMFBcM3Qgt04M+eVivYWeAwvc0gW1Wpj+dmHOqn
 tG7oIkiIStlR7oUnZsOosvNn1g5FXLtB9iO82sWdNO3W1mDGdbj9EdZ90EQem+G78qJF27AoFwl
 4udhQCaiBGK0PJiDNfwtNeAF5Tc9kHfk0DlMUz6Ucm1/44UG7QaiSDBtf0lL9EwY5N6Wjm7mr2M
 rgzPqu6Z9pfV9NSCwT1rTdFTtiZ0vgm4rgRpVV6CSXuaIAHKpZJvbDuMfz7rOcq9XdnovxzYpiz
 gzS+WynVBwD+C/PCM5g==
X-Proofpoint-GUID: ANgaSkyeTGHGvJ2NGN3LrxU6ltoMOsMb
X-Authority-Analysis: v=2.4 cv=FZmiV5+6 c=1 sm=1 tr=0 ts=6ae8a2b9 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=NEAV23lmAAAA:8 a=fw26_O3xyXGSA7psMHoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA1OCBTYWx0ZWRfX0f8G7khl0JgM
 b06y9WK4o3OyIl9FFWLoojZQuo4nvzxJYHFoP0hH1BQ0I43xovcbXbB10sm38brCTECuNybCXhD
 2BbroF/i/lVpeq5pg6RWDR3oHyb3Gn0=
X-Proofpoint-ORIG-GUID: ANgaSkyeTGHGvJ2NGN3LrxU6ltoMOsMb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020058
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit 56afd82bd4db9688f1c1c9d0e2ea163b8cde3283:

  Merge tag 'qemu-sparc-20261101' of https://github.com/mcayland/qemu into staging (2026-11-01 08:37:48 -0800)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/mips-20261102

for you to fetch changes up to 9e2af46dee82e1856f9bb89e79c3974a3bba28ce:

  tests/tcg/mips64el: Move R5900 tests to system mode and build with meson (2026-11-02 15:06:58 +0100)

Ignoring following checkpatch.pl issues:

  WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?

  WARNING: line over 80 characters
  #43: FILE: scripts/meson-buildoptions.sh:542:
  +    --tcg-tests-cross-cc-mips32r6el=*) quote_sh "-Dtcg_tests_cross_cc_mips32r6el=$2" ;;

  ERROR: line over 90 characters
  #51: FILE: scripts/meson-buildoptions.sh:570:
  +    --tcg-tests-cross-cflags-mips32r6el=*) quote_sh "-Dtcg_tests_cross_cflags_mips32r6el=$2" ;;

  ERROR: use qemu_real_host_page_size() instead of sysconf(_SC_PAGESIZE)
  #145: FILE: tests/tcg/mips/test_msa_load_store.c:113:
  +    long page_size = sysconf(_SC_PAGESIZE);

----------------------------------------------------------------
MIPS patches queue

- Constify and remove TARGET_BIG_ENDIAN uses
- Start converting MIPS16e/micro/nanoMIPS to decodetree
- Translate MSA vector load/store opcodes
- Re-introduce the R5900 CPU (system)
- Improve testing harness (meson & TAP)
- Improve testing of R5900 / Octeon / MIPS32R6
----------------------------------------------------------------

Philippe Mathieu-Daudé (78):
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
  target/mips: Constify CPUMIPSTLBContext::map_address() handlers
  target/mips: Constify get_physical_address()
  target/mips: Constify read-only CPUMIPSState arguments
  target/mips: Do not use TARGET_BIG_ENDIAN in cpu.c
  target/mips: Use CPU endianness in MSA LD.D / ST.D helpers
  target/mips: Expand TRANS_DF_iv() macro for MSA Load/Store
  target/mips: Convert MSA LD/ST.B (Byte Vector)
  target/mips: Convert MSA LD/ST.H (Halfword Vector)
  target/mips: Convert MSA LD/ST.W (Word Vector)
  target/mips: Convert MSA LD/ST.D (Doubleword Vector)
  accel/tcg: Remove non-explicit endian cpu_ld/st*_data*() helpers
  tests/tcg: Add minimal TAP helper header
  tests/tcg: Allow tests to report results with TAP
  tests/tcg/mips64: Report Octeon test results with TAP
  tests/tcg/mips64: Test the Octeon POP instruction
  tests/tcg/mips: Remove unused test_utils_32.h
  tests/tcg/mips: Group DSP acc tests
  tests/tcg/mips: Group DSP arith tests
  tests/tcg/mips: Group DSP cmp tests
  tests/tcg/mips: Group DSP ctrl tests
  tests/tcg/mips: Group DSP dot tests
  tests/tcg/mips: Group DSP mul tests
  tests/tcg/mips: Group DSP pack tests
  tests/tcg/mips: Group DSP shift tests
  tests/tcg/mips: Group Release 6 bitops tests
  tests/tcg/mips: Group Release 6 crc tests
  tests/tcg/mips: Group Release 6 logic tests
  tests/tcg/mips: Group Release 6 multiply tests
  tests/tcg/mips: Group Release 6 shift tests
  tests/tcg/mips: Group MSA bit-count tests
  tests/tcg/mips: Group MSA bit-move tests
  tests/tcg/mips: Group MSA bit-set tests
  tests/tcg/mips: Group MSA fixed-multiply tests
  tests/tcg/mips: Group MSA float-max-min tests
  tests/tcg/mips: Group MSA int-add tests
  tests/tcg/mips: Group MSA int-average tests
  tests/tcg/mips: Group MSA int-compare tests
  tests/tcg/mips: Group MSA int-div-mod tests
  tests/tcg/mips: Group MSA int-dot-product tests
  tests/tcg/mips: Group MSA int-max-min tests
  tests/tcg/mips: Group MSA int-multiply tests
  tests/tcg/mips: Group MSA int-subtract tests
  tests/tcg/mips: Group MSA interleave tests
  tests/tcg/mips: Group MSA logic tests
  tests/tcg/mips: Group MSA pack tests
  tests/tcg/mips: Group MSA shift tests
  tests/tcg/mips: Add MSA load/store tests
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
  target/mips: Re-introduce the R5900 CPU in system mode
  target/mips/tx79: Fix PCGT* (Parallel Compare for Greater Than)
  tests/guest-debug: Allow placing the binary within system QEMU args
  tests/tcg/mips64el: Add bare-metal harness for R5900 system tests
  tests/tcg/mips64el: Move R5900 tests to system mode and build with
    meson

 MAINTAINERS                                   |   1 +
 docs/devel/loads-stores.rst                   |  18 +-
 include/accel/tcg/cpu-ldst.h                  |  48 ---
 target/mips/cpu.h                             |   4 +-
 target/mips/internal.h                        |  10 +-
 target/mips/tcg/tcg-internal.h                |   2 +-
 target/mips/tcg/translate.h                   |  11 +
 tests/tcg/include/tap.h                       |  92 ++++++
 tests/tcg/mips/include/test_utils_128.h       |  32 +-
 tests/tcg/mips/include/test_utils_32.h        |  78 -----
 tests/tcg/mips/include/test_utils_64.h        |  24 +-
 tests/tcg/mips/include/wrappers_mips32r6.h    |  91 ++++++
 tests/tcg/mips64el/system/include/assert.h    |  18 ++
 tests/tcg/mips64el/system/include/inttypes.h  |  10 +
 tests/tcg/mips64el/system/include/stdio.h     |  20 ++
 tests/tcg/mips64el/system/include/string.h    |  19 ++
 tests/tcg/mipsel/test_dsp_runner.h            |  26 ++
 target/mips/tcg/msa_helper.h.inc              |   9 -
 target/mips/tcg/micromips16.decode            |  18 ++
 target/mips/tcg/micromips32.decode            |  11 +
 target/mips/tcg/micromips32_r6.decode         |  19 ++
 target/mips/tcg/mips16e_16.decode             |  17 +
 target/mips/tcg/mips16e_32.decode             |  18 ++
 target/mips/tcg/msa.decode                    |   3 +-
 target/mips/tcg/nanomips16.decode             |  17 +
 target/mips/tcg/nanomips32.decode             |  14 +
 target/mips/tcg/nanomips48.decode             |  16 +
 target/mips/tcg/rel6.decode                   |   5 +-
 target/mips/cpu.c                             |  13 +-
 target/mips/system/cp0.c                      |   2 +-
 target/mips/system/physaddr.c                 |   9 +-
 target/mips/tcg/comput_translate.c            |  21 ++
 target/mips/tcg/dsp_helper.c                  |   2 +-
 target/mips/tcg/exception.c                   |   2 +-
 target/mips/tcg/micromips_translate.c         |  37 +++
 target/mips/tcg/mips16e_translate.c           |  21 ++
 target/mips/tcg/msa_helper.c                  | 176 -----------
 target/mips/tcg/msa_translate.c               | 110 ++++++-
 target/mips/tcg/nanomips_translate.c          |  46 +++
 target/mips/tcg/rel6_translate.c              |   9 +-
 target/mips/tcg/system/cp0_helper.c           |   2 +-
 target/mips/tcg/system/tlb_helper.c           |   9 +-
 target/mips/tcg/translate.c                   |  24 +-
 target/mips/tcg/tx79_translate.c              |  10 +-
 tests/tcg/mips/test_msa_bit_count.c           |  99 ++++++
 tests/tcg/mips/test_msa_bit_move.c            |  93 ++++++
 tests/tcg/mips/test_msa_bit_set.c             |  99 ++++++
 tests/tcg/mips/test_msa_fixed_multiply.c      |  99 ++++++
 tests/tcg/mips/test_msa_float_max_min.c       |  75 +++++
 tests/tcg/mips/test_msa_int_add.c             | 183 +++++++++++
 tests/tcg/mips/test_msa_int_average.c         | 123 +++++++
 tests/tcg/mips/test_msa_int_compare.c         | 147 +++++++++
 tests/tcg/mips/test_msa_int_div_mod.c         | 123 +++++++
 tests/tcg/mips/test_msa_int_dot_product.c     | 135 ++++++++
 tests/tcg/mips/test_msa_int_max_min.c         | 171 ++++++++++
 tests/tcg/mips/test_msa_int_multiply.c        |  99 ++++++
 tests/tcg/mips/test_msa_int_subtract.c        | 231 ++++++++++++++
 tests/tcg/mips/test_msa_interleave.c          | 123 +++++++
 tests/tcg/mips/test_msa_load_store.c          | 171 ++++++++++
 tests/tcg/mips/test_msa_logic.c               |  57 ++++
 tests/tcg/mips/test_msa_pack.c                |  99 ++++++
 tests/tcg/mips/test_msa_shift.c               | 147 +++++++++
 tests/tcg/mips64/octeon-insns.c               |  87 +++--
 tests/tcg/mips64/test_mips64r6_bitops.c       |  60 ++++
 tests/tcg/mips64/test_mips64r6_crc.c          |  72 +++++
 tests/tcg/mips64/test_mips64r6_logic.c        |  48 +++
 tests/tcg/mips64/test_mips64r6_multiply.c     |  72 +++++
 tests/tcg/mips64/test_mips64r6_shift.c        |  60 ++++
 tests/tcg/mips64el/system/harness.c           |  69 ++++
 .../system}/test_r5900_div1.c                 |   0
 .../system}/test_r5900_divu1.c                |   0
 .../system}/test_r5900_madd.c                 |   0
 .../system}/test_r5900_maddu.c                |   0
 .../system}/test_r5900_mflohi1.c              |   0
 .../system}/test_r5900_mtlohi1.c              |   0
 .../system}/test_r5900_mult.c                 |   0
 .../system}/test_r5900_multu.c                |   0
 tests/tcg/mipsel/test_dsp_acc.c               | 109 +++++++
 tests/tcg/mipsel/test_dsp_arith.c             | 179 +++++++++++
 tests/tcg/mipsel/test_dsp_cmp.c               |  84 +++++
 tests/tcg/mipsel/test_dsp_ctrl.c              |  44 +++
 tests/tcg/mipsel/test_dsp_dot.c               | 154 +++++++++
 tests/tcg/mipsel/test_dsp_mul.c               |  64 ++++
 tests/tcg/mipsel/test_dsp_pack.c              | 149 +++++++++
 tests/tcg/mipsel/test_dsp_r1_absq_s_ph.c      |   1 -
 tests/tcg/mipsel/test_dsp_r1_absq_s_w.c       |   1 -
 tests/tcg/mipsel/test_dsp_r1_addq_ph.c        |   1 -
 tests/tcg/mipsel/test_dsp_r1_addq_s_ph.c      |   1 -
 tests/tcg/mipsel/test_dsp_r1_addq_s_w.c       |   1 -
 tests/tcg/mipsel/test_dsp_r1_addsc.c          |   1 -
 tests/tcg/mipsel/test_dsp_r1_addu_qb.c        |   1 -
 tests/tcg/mipsel/test_dsp_r1_addu_s_qb.c      |   1 -
 tests/tcg/mipsel/test_dsp_r1_addwc.c          |   1 -
 tests/tcg/mipsel/test_dsp_r1_bitrev.c         |   1 -
 tests/tcg/mipsel/test_dsp_r1_bposge32.c       |   1 -
 tests/tcg/mipsel/test_dsp_r1_cmp_eq_ph.c      |   1 -
 tests/tcg/mipsel/test_dsp_r1_cmp_le_ph.c      |   1 -
 tests/tcg/mipsel/test_dsp_r1_cmp_lt_ph.c      |   1 -
 tests/tcg/mipsel/test_dsp_r1_cmpgu_eq_qb.c    |   1 -
 tests/tcg/mipsel/test_dsp_r1_cmpgu_le_qb.c    |   1 -
 tests/tcg/mipsel/test_dsp_r1_cmpgu_lt_qb.c    |   1 -
 tests/tcg/mipsel/test_dsp_r1_cmpu_eq_qb.c     |   1 -
 tests/tcg/mipsel/test_dsp_r1_cmpu_le_qb.c     |   1 -
 tests/tcg/mipsel/test_dsp_r1_cmpu_lt_qb.c     |   1 -
 tests/tcg/mipsel/test_dsp_r1_dpaq_s_w_ph.c    |   1 -
 tests/tcg/mipsel/test_dsp_r1_dpaq_sa_l_w.c    |   1 -
 tests/tcg/mipsel/test_dsp_r1_dpau_h_qbl.c     |   1 -
 tests/tcg/mipsel/test_dsp_r1_dpau_h_qbr.c     |   1 -
 tests/tcg/mipsel/test_dsp_r1_dpsq_s_w_ph.c    |   1 -
 tests/tcg/mipsel/test_dsp_r1_dpsq_sa_l_w.c    |   1 -
 tests/tcg/mipsel/test_dsp_r1_dpsu_h_qbl.c     |   1 -
 tests/tcg/mipsel/test_dsp_r1_dpsu_h_qbr.c     |   1 -
 tests/tcg/mipsel/test_dsp_r1_extp.c           |   1 -
 tests/tcg/mipsel/test_dsp_r1_extpdp.c         |   1 -
 tests/tcg/mipsel/test_dsp_r1_extpdpv.c        |   1 -
 tests/tcg/mipsel/test_dsp_r1_extpv.c          |   1 -
 tests/tcg/mipsel/test_dsp_r1_extr_r_w.c       |   1 -
 tests/tcg/mipsel/test_dsp_r1_extr_rs_w.c      |   1 -
 tests/tcg/mipsel/test_dsp_r1_extr_s_h.c       |   1 -
 tests/tcg/mipsel/test_dsp_r1_extr_w.c         |   1 -
 tests/tcg/mipsel/test_dsp_r1_extrv_r_w.c      |   1 -
 tests/tcg/mipsel/test_dsp_r1_extrv_rs_w.c     |   1 -
 tests/tcg/mipsel/test_dsp_r1_extrv_s_h.c      |   1 -
 tests/tcg/mipsel/test_dsp_r1_extrv_w.c        |   1 -
 tests/tcg/mipsel/test_dsp_r1_insv.c           |   1 -
 tests/tcg/mipsel/test_dsp_r1_lbux.c           |   1 -
 tests/tcg/mipsel/test_dsp_r1_lhx.c            |   1 -
 tests/tcg/mipsel/test_dsp_r1_lwx.c            |   1 -
 tests/tcg/mipsel/test_dsp_r1_madd.c           |   1 -
 tests/tcg/mipsel/test_dsp_r1_maddu.c          |   1 -
 tests/tcg/mipsel/test_dsp_r1_main.c           |   6 -
 tests/tcg/mipsel/test_dsp_r1_maq_s_w_phl.c    |   1 -
 tests/tcg/mipsel/test_dsp_r1_maq_s_w_phr.c    |   1 -
 tests/tcg/mipsel/test_dsp_r1_maq_sa_w_phl.c   |   1 -
 tests/tcg/mipsel/test_dsp_r1_maq_sa_w_phr.c   |   1 -
 tests/tcg/mipsel/test_dsp_r1_mfhi.c           |   1 -
 tests/tcg/mipsel/test_dsp_r1_mflo.c           |   1 -
 tests/tcg/mipsel/test_dsp_r1_modsub.c         |   1 -
 tests/tcg/mipsel/test_dsp_r1_msub.c           |   1 -
 tests/tcg/mipsel/test_dsp_r1_msubu.c          |   1 -
 tests/tcg/mipsel/test_dsp_r1_mthi.c           |   1 -
 tests/tcg/mipsel/test_dsp_r1_mthlip.c         |   1 -
 tests/tcg/mipsel/test_dsp_r1_mtlo.c           |   1 -
 tests/tcg/mipsel/test_dsp_r1_muleq_s_w_phl.c  |   1 -
 tests/tcg/mipsel/test_dsp_r1_muleq_s_w_phr.c  |   1 -
 tests/tcg/mipsel/test_dsp_r1_muleu_s_ph_qbl.c |   1 -
 tests/tcg/mipsel/test_dsp_r1_muleu_s_ph_qbr.c |   1 -
 tests/tcg/mipsel/test_dsp_r1_mulq_rs_ph.c     |   1 -
 tests/tcg/mipsel/test_dsp_r1_mult.c           |   1 -
 tests/tcg/mipsel/test_dsp_r1_multu.c          |   1 -
 tests/tcg/mipsel/test_dsp_r1_packrl_ph.c      |   1 -
 tests/tcg/mipsel/test_dsp_r1_pick_ph.c        |   1 -
 tests/tcg/mipsel/test_dsp_r1_pick_qb.c        |   1 -
 tests/tcg/mipsel/test_dsp_r1_preceq_w_phl.c   |   1 -
 tests/tcg/mipsel/test_dsp_r1_preceq_w_phr.c   |   1 -
 tests/tcg/mipsel/test_dsp_r1_precequ_ph_qbl.c |   1 -
 .../tcg/mipsel/test_dsp_r1_precequ_ph_qbla.c  |   1 -
 tests/tcg/mipsel/test_dsp_r1_precequ_ph_qbr.c |   1 -
 .../tcg/mipsel/test_dsp_r1_precequ_ph_qbra.c  |   1 -
 tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbl.c  |   1 -
 tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbla.c |   1 -
 tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbr.c  |   1 -
 tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbra.c |   1 -
 tests/tcg/mipsel/test_dsp_r1_precrq_ph_w.c    |   1 -
 tests/tcg/mipsel/test_dsp_r1_precrq_qb_ph.c   |   1 -
 tests/tcg/mipsel/test_dsp_r1_precrq_rs_ph_w.c |   1 -
 .../tcg/mipsel/test_dsp_r1_precrqu_s_qb_ph.c  |   1 -
 tests/tcg/mipsel/test_dsp_r1_raddu_w_qb.c     |   1 -
 tests/tcg/mipsel/test_dsp_r1_rddsp.c          |   1 -
 tests/tcg/mipsel/test_dsp_r1_repl_ph.c        |   1 -
 tests/tcg/mipsel/test_dsp_r1_repl_qb.c        |   1 -
 tests/tcg/mipsel/test_dsp_r1_replv_ph.c       |   1 -
 tests/tcg/mipsel/test_dsp_r1_replv_qb.c       |   1 -
 tests/tcg/mipsel/test_dsp_r1_shilo.c          |   1 -
 tests/tcg/mipsel/test_dsp_r1_shilov.c         |   1 -
 tests/tcg/mipsel/test_dsp_r1_shll_ph.c        |   1 -
 tests/tcg/mipsel/test_dsp_r1_shll_qb.c        |   1 -
 tests/tcg/mipsel/test_dsp_r1_shll_s_ph.c      |   1 -
 tests/tcg/mipsel/test_dsp_r1_shll_s_w.c       |   1 -
 tests/tcg/mipsel/test_dsp_r1_shllv_ph.c       |   1 -
 tests/tcg/mipsel/test_dsp_r1_shllv_qb.c       |   1 -
 tests/tcg/mipsel/test_dsp_r1_shllv_s_ph.c     |   1 -
 tests/tcg/mipsel/test_dsp_r1_shllv_s_w.c      |   1 -
 tests/tcg/mipsel/test_dsp_r1_shra_ph.c        |   1 -
 tests/tcg/mipsel/test_dsp_r1_shra_r_ph.c      |   1 -
 tests/tcg/mipsel/test_dsp_r1_shra_r_w.c       |   1 -
 tests/tcg/mipsel/test_dsp_r1_shrav_ph.c       |   1 -
 tests/tcg/mipsel/test_dsp_r1_shrav_r_ph.c     |   1 -
 tests/tcg/mipsel/test_dsp_r1_shrav_r_w.c      |   1 -
 tests/tcg/mipsel/test_dsp_r1_shrl_qb.c        |   1 -
 tests/tcg/mipsel/test_dsp_r1_shrlv_qb.c       |   1 -
 tests/tcg/mipsel/test_dsp_r1_subq_ph.c        |   1 -
 tests/tcg/mipsel/test_dsp_r1_subq_s_ph.c      |   1 -
 tests/tcg/mipsel/test_dsp_r1_subq_s_w.c       |   1 -
 tests/tcg/mipsel/test_dsp_r1_subu_qb.c        |   1 -
 tests/tcg/mipsel/test_dsp_r1_subu_s_qb.c      |   1 -
 tests/tcg/mipsel/test_dsp_r1_wrdsp.c          |   1 -
 tests/tcg/mipsel/test_dsp_r2_absq_s_qb.c      |   1 -
 tests/tcg/mipsel/test_dsp_r2_addqh_ph.c       |   1 -
 tests/tcg/mipsel/test_dsp_r2_addqh_r_ph.c     |   1 -
 tests/tcg/mipsel/test_dsp_r2_addqh_r_w.c      |   1 -
 tests/tcg/mipsel/test_dsp_r2_addqh_w.c        |   1 -
 tests/tcg/mipsel/test_dsp_r2_addu_ph.c        |   1 -
 tests/tcg/mipsel/test_dsp_r2_addu_s_ph.c      |   1 -
 tests/tcg/mipsel/test_dsp_r2_adduh_qb.c       |   1 -
 tests/tcg/mipsel/test_dsp_r2_adduh_r_qb.c     |   1 -
 tests/tcg/mipsel/test_dsp_r2_append.c         |   1 -
 tests/tcg/mipsel/test_dsp_r2_balign.c         |   1 -
 tests/tcg/mipsel/test_dsp_r2_cmpgdu_eq_qb.c   |   1 -
 tests/tcg/mipsel/test_dsp_r2_cmpgdu_le_qb.c   |   1 -
 tests/tcg/mipsel/test_dsp_r2_cmpgdu_lt_qb.c   |   1 -
 tests/tcg/mipsel/test_dsp_r2_dpa_w_ph.c       |   1 -
 tests/tcg/mipsel/test_dsp_r2_dpaqx_s_w_ph.c   |   1 -
 tests/tcg/mipsel/test_dsp_r2_dpaqx_sa_w_ph.c  |   1 -
 tests/tcg/mipsel/test_dsp_r2_dpax_w_ph.c      |   1 -
 tests/tcg/mipsel/test_dsp_r2_dps_w_ph.c       |   1 -
 tests/tcg/mipsel/test_dsp_r2_dpsqx_s_w_ph.c   |   1 -
 tests/tcg/mipsel/test_dsp_r2_dpsqx_sa_w_ph.c  |   1 -
 tests/tcg/mipsel/test_dsp_r2_dpsx_w_ph.c      |   1 -
 tests/tcg/mipsel/test_dsp_r2_mul_ph.c         |   1 -
 tests/tcg/mipsel/test_dsp_r2_mul_s_ph.c       |   1 -
 tests/tcg/mipsel/test_dsp_r2_mulq_rs_w.c      |   1 -
 tests/tcg/mipsel/test_dsp_r2_mulq_s_ph.c      |   1 -
 tests/tcg/mipsel/test_dsp_r2_mulq_s_w.c       |   1 -
 tests/tcg/mipsel/test_dsp_r2_mulsa_w_ph.c     |   1 -
 tests/tcg/mipsel/test_dsp_r2_mulsaq_s_w_ph.c  |   1 -
 tests/tcg/mipsel/test_dsp_r2_precr_qb_ph.c    |   1 -
 tests/tcg/mipsel/test_dsp_r2_precr_sra_ph_w.c |   1 -
 .../tcg/mipsel/test_dsp_r2_precr_sra_r_ph_w.c |   1 -
 tests/tcg/mipsel/test_dsp_r2_prepend.c        |   1 -
 tests/tcg/mipsel/test_dsp_r2_shra_qb.c        |   1 -
 tests/tcg/mipsel/test_dsp_r2_shra_r_qb.c      |   1 -
 tests/tcg/mipsel/test_dsp_r2_shrav_qb.c       |   1 -
 tests/tcg/mipsel/test_dsp_r2_shrav_r_qb.c     |   1 -
 tests/tcg/mipsel/test_dsp_r2_shrl_ph.c        |   1 -
 tests/tcg/mipsel/test_dsp_r2_shrlv_ph.c       |   1 -
 tests/tcg/mipsel/test_dsp_r2_subqh_ph.c       |   1 -
 tests/tcg/mipsel/test_dsp_r2_subqh_r_ph.c     |   1 -
 tests/tcg/mipsel/test_dsp_r2_subqh_r_w.c      |   1 -
 tests/tcg/mipsel/test_dsp_r2_subqh_w.c        |   1 -
 tests/tcg/mipsel/test_dsp_r2_subu_ph.c        |   1 -
 tests/tcg/mipsel/test_dsp_r2_subu_s_ph.c      |   1 -
 tests/tcg/mipsel/test_dsp_r2_subuh_qb.c       |   1 -
 tests/tcg/mipsel/test_dsp_r2_subuh_r_qb.c     |   1 -
 tests/tcg/mipsel/test_dsp_shift.c             | 124 ++++++++
 tests/tcg/mipsel/test_mips32r6_bitops.c       |  82 +++++
 tests/tcg/mipsel/test_mips32r6_branch.c       | 127 ++++++++
 tests/tcg/mipsel/test_mips32r6_logic.c        |  68 ++++
 tests/tcg/mipsel/test_mips32r6_multiply.c     | 111 +++++++
 tests/tcg/mipsel/test_mips32r6_pcrel.c        |  91 ++++++
 tests/tcg/mipsel/test_mips32r6_shift.c        |  84 +++++
 target/mips/cpu-defs.c.inc                    |  45 +++
 target/mips/tcg/micromips_translate.c.inc     | 152 ++++-----
 target/mips/tcg/mips16e_translate.c.inc       |  56 ++--
 target/mips/tcg/nanomips_translate.c.inc      |  56 ++--
 .../dockerfiles/debian-all-test-cross.docker  |   2 +
 meson_options.txt                             |   4 +
 scripts/decodetree.py                         |   4 +
 scripts/meson-buildoptions.sh                 |   2 +
 target/mips/tcg/meson.build                   |  12 +
 tests/guest-debug/run-test.py                 |  20 +-
 tests/tcg/meson.build                         |   9 +-
 tests/tcg/mips/meson.build                    | 299 ++----------------
 tests/tcg/mips/user/isa/r5900/Makefile        |  32 --
 tests/tcg/mips/user/isa/r5900/README          |   6 -
 tests/tcg/mips64/meson.build                  |  43 +--
 tests/tcg/mips64el/meson.build                |   2 +
 tests/tcg/mips64el/system/boot.S              |  26 ++
 tests/tcg/mips64el/system/kernel.ld           |  46 +++
 tests/tcg/mips64el/system/meson.build         |  53 ++++
 tests/tcg/mips64el/system/test-r5900.py       |  30 ++
 tests/tcg/mipsel/meson.build                  | 206 +++---------
 272 files changed, 5377 insertions(+), 1249 deletions(-)
 create mode 100644 tests/tcg/include/tap.h
 delete mode 100644 tests/tcg/mips/include/test_utils_32.h
 create mode 100644 tests/tcg/mips/include/wrappers_mips32r6.h
 create mode 100644 tests/tcg/mips64el/system/include/assert.h
 create mode 100644 tests/tcg/mips64el/system/include/inttypes.h
 create mode 100644 tests/tcg/mips64el/system/include/stdio.h
 create mode 100644 tests/tcg/mips64el/system/include/string.h
 create mode 100644 tests/tcg/mipsel/test_dsp_runner.h
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
 create mode 100644 tests/tcg/mips/test_msa_bit_count.c
 create mode 100644 tests/tcg/mips/test_msa_bit_move.c
 create mode 100644 tests/tcg/mips/test_msa_bit_set.c
 create mode 100644 tests/tcg/mips/test_msa_fixed_multiply.c
 create mode 100644 tests/tcg/mips/test_msa_float_max_min.c
 create mode 100644 tests/tcg/mips/test_msa_int_add.c
 create mode 100644 tests/tcg/mips/test_msa_int_average.c
 create mode 100644 tests/tcg/mips/test_msa_int_compare.c
 create mode 100644 tests/tcg/mips/test_msa_int_div_mod.c
 create mode 100644 tests/tcg/mips/test_msa_int_dot_product.c
 create mode 100644 tests/tcg/mips/test_msa_int_max_min.c
 create mode 100644 tests/tcg/mips/test_msa_int_multiply.c
 create mode 100644 tests/tcg/mips/test_msa_int_subtract.c
 create mode 100644 tests/tcg/mips/test_msa_interleave.c
 create mode 100644 tests/tcg/mips/test_msa_load_store.c
 create mode 100644 tests/tcg/mips/test_msa_logic.c
 create mode 100644 tests/tcg/mips/test_msa_pack.c
 create mode 100644 tests/tcg/mips/test_msa_shift.c
 create mode 100644 tests/tcg/mips64/test_mips64r6_bitops.c
 create mode 100644 tests/tcg/mips64/test_mips64r6_crc.c
 create mode 100644 tests/tcg/mips64/test_mips64r6_logic.c
 create mode 100644 tests/tcg/mips64/test_mips64r6_multiply.c
 create mode 100644 tests/tcg/mips64/test_mips64r6_shift.c
 create mode 100644 tests/tcg/mips64el/system/harness.c
 rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/test_r5900_div1.c (100%)
 rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/test_r5900_divu1.c (100%)
 rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/test_r5900_madd.c (100%)
 rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/test_r5900_maddu.c (100%)
 rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/test_r5900_mflohi1.c (100%)
 rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/test_r5900_mtlohi1.c (100%)
 rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/test_r5900_mult.c (100%)
 rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/test_r5900_multu.c (100%)
 create mode 100644 tests/tcg/mipsel/test_dsp_acc.c
 create mode 100644 tests/tcg/mipsel/test_dsp_arith.c
 create mode 100644 tests/tcg/mipsel/test_dsp_cmp.c
 create mode 100644 tests/tcg/mipsel/test_dsp_ctrl.c
 create mode 100644 tests/tcg/mipsel/test_dsp_dot.c
 create mode 100644 tests/tcg/mipsel/test_dsp_mul.c
 create mode 100644 tests/tcg/mipsel/test_dsp_pack.c
 delete mode 100644 tests/tcg/mipsel/test_dsp_r1_main.c
 create mode 100644 tests/tcg/mipsel/test_dsp_shift.c
 create mode 100644 tests/tcg/mipsel/test_mips32r6_bitops.c
 create mode 100644 tests/tcg/mipsel/test_mips32r6_branch.c
 create mode 100644 tests/tcg/mipsel/test_mips32r6_logic.c
 create mode 100644 tests/tcg/mipsel/test_mips32r6_multiply.c
 create mode 100644 tests/tcg/mipsel/test_mips32r6_pcrel.c
 create mode 100644 tests/tcg/mipsel/test_mips32r6_shift.c
 delete mode 100644 tests/tcg/mips/user/isa/r5900/Makefile
 delete mode 100644 tests/tcg/mips/user/isa/r5900/README
 create mode 100644 tests/tcg/mips64el/system/boot.S
 create mode 100644 tests/tcg/mips64el/system/kernel.ld
 create mode 100644 tests/tcg/mips64el/system/meson.build
 create mode 100644 tests/tcg/mips64el/system/test-r5900.py

-- 
2.55.0


