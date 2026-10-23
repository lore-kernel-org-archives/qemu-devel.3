Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDD1606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Z68inwUz;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RKj2ljgp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHtn-0003ng-Sm; Fri, 23 Oct 2026 12:13:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHtk-0003nB-VF
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:13:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHti-000246-H1
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:13:40 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NG6EiP2215922
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:13:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=TKl2fpB4lJjp9FTQCce1Se
 jvDyoouYKYU8tg7GosBWI=; b=Z68inwUzMccVwPpJ5fRLffroBlq5u9+wkAkGDj
 hgrV70/WsXe4EiuwFmRMjoQKIOpT77bzQ6wGn9XNcbjnHnWFUl6iwj9S/E8E/DI4
 tLZ7qhyjNTlXBEl1BspmjKE6P6K05oBm3uZFhdJr70vbg+X8/pXZ841MVWnG5vga
 iEfcUq6Ywf745fYfLvJN6qTtBPskCUpu7uqXW1umN+6f1qTrq1aTUF6CGsEb88Zf
 iLVZVZL94Dv7AJtJDaruD2cb52UNF6A8zg08G3K+1Mi51BaV0zCb4vE9c29BnSDQ
 tLN4IzwrfCUqlfsfN8rvuPkA0pGYVOncj7JnTUOxtnP3rnGw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgatc8107-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:13:36 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93c5ab5c136so167282585a.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772016; x=1793376816; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TKl2fpB4lJjp9FTQCce1SejvDyoouYKYU8tg7GosBWI=;
 b=RKj2ljgpBl1upVx9y1a8ynuNCNB0LxI+5bI14Lowgbn2Fuk2QBKQe0tJKLpH9xX4dW
 fQ3PL17UvnhKjPsHQ9PpGFmbbiCgZ97ZWbAKpGzcG5WQslpqIt2VWiE/bc2GrftJF/Gh
 4qT7fgW1yHmIu3+1oZcIb3wkcY1qgCk5wINlLFTEUeLaNFl40T8yjqbfyNFGRPOMrLdr
 NzzJLptfVK8hXMURN3t3gNxWTBhN7rsrbh7hXmqdfTHCkzsX8YJo6NQl1nv1pXjjntG8
 /QwMGw1+XmZ8FUmA6vVggQpEGVZMMiH8vmK3cwftLgu5q0qAEe3B63HJLGfsQnc6fMWM
 QC8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772016; x=1793376816;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TKl2fpB4lJjp9FTQCce1SejvDyoouYKYU8tg7GosBWI=;
 b=a4lV23hxjfPchHdzfasHp9k6w8wrp8mOzgSo5uQsOKC5VRJWrkizCjtiQiXFciB2PU
 BjDNh9P3BwnuPTogwTgcIqeFkipXWKOJMNLFadtYaARFnD0c7312Y4/jXNAkCsMEsI4+
 u5Tc0w4TT9vHEnegAwBL6ZN3cvHAzdNqta+9U7w9lOtMjmgIhQpPHt6bYfwoe5ACRpY4
 S866Gl9gFEGfbrjAc5KICVLYTIUL1PCgsYKIv72TeNtOgVJGwWzLp7On5L62JSIMfKGB
 BKFmEMbQwSbjgvPjtzuNEfYwxWFyYR3sXUWt+inqkIi82kJxakMbmjZnGguiRtftacSb
 xMUA==
X-Gm-Message-State: AFq9FYL7Wm3F8DSKIbTb+T/AWYAp3uiXGSamstZS7DAUUvLDnGXJy/W1
 JTRoruFe1uhB2+nKFs9qAC6a2xwNSO14KSJuX5CE/UPkZ30kWicXEBqAz3KRhPipUhLI1MY7BOE
 TLGG1dNaMiV6Dv6xp8asDG5IFZTNDsRndffxIN5Of0Eth2FGjYy6wUPFN03fzlJRojBYG
X-Gm-Gg: AYBFou1a0j62tSHdUGw8Xtxok80iew+VN6oIrBbta4gimVTxQmodJts36kQgJ5X0SyJ
 YKYmTUsL1WtK9b8TpZk9IsS6jMaax4PZlwN99nGf/OLFJmk9yM2wZuEGctxbJUee09gHvlWJeUV
 uVCMLjSN1/tJ4zd+Aj4Op4t4gATDUDJkHyauA042oDF84PQw1vjt41Rog4PtVyWafi1olAvER2Y
 a2UltrZCyaLvLo79XHQIxxTi5qVX+SHf/RQCXgCxQRIh1Dkawn5HrOMffL9WBm7yz/YBpdACXQE
 g6MiI+RwxV6oI/3ujE146CgqxzQr2tAIo356Z8G6ZL2mtLm4YhNpyWImm/xZ53Eulr9um6sAJw0
 uPBvs9QJ5cy3AutGfrJ7W7I1gXW16aWZEG9p2dD8X
X-Received: by 2002:a05:620a:46ac:b0:93e:c12c:f137 with SMTP id
 af79cd13be357-93f6f86563amr496559685a.82.1792772015714; 
 Fri, 23 Oct 2026 09:13:35 -0700 (PDT)
X-Received: by 2002:a05:620a:46ac:b0:93e:c12c:f137 with SMTP id
 af79cd13be357-93f6f86563amr496552985a.82.1792772014949; 
 Fri, 23 Oct 2026 09:13:34 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d410708sm704437f8f.38.2026.10.23.09.13.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:13:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/83] Misc target/ patches for 2026-10-23
Date: Fri, 23 Oct 2026 18:12:08 +0200
Message-ID: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfXx5smscUEQTFR
 t5fbTZrok2Y2yPJqJnwxi7AxyH5t9s9+hF1YxeUlfw34MIw6UIcNQZMpFLQE6TXITrQ06LYKOBG
 OaET/YmxHiBKenXS/AdlyYIPNtuJzpQzzYj/PkZkGcOUi6l1CCkt/XqypWfVRiuQrLaA0e5Jmrt
 wZOo1b7QS47Cqyq7HLC+gIXBpOGaVD0hmAkNkoVgSJVAHuDnBsg5z7jRaknBrPa6+8ddwR9Wkwg
 aB8tZhQV1Ba+xdet0N+HgYlIbseAazcDloqlmpVc32POE0j920dtVQ4/aO01hfXdP4dZt8yBPWT
 dJ5GDoAMeJFEzDKHeWsCx2Z++OtPIQUdpUCLHr62E2N4T0pRe5ItuoyPGBMBqwlqcJCG/n029Wj
 +lzSnzml4BzDbeCnuuaeSxDwesxvPY4sp/rGE4xKv6m1rRV4rqHeZA/3BbmI7HoMMxjI360NqYD
 fsFEMgPnxcUrr9dIp3A==
X-Proofpoint-GUID: S0jhHVSxOidcezm5GRbAWv_teL8NRasP
X-Authority-Analysis: v=2.4 cv=Scxi5fRu c=1 sm=1 tr=0 ts=6adb87b0 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=p0WdMEafAAAA:8 a=NEAV23lmAAAA:8 a=xMIVGifLfBi6bESdB8EA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: S0jhHVSxOidcezm5GRbAWv_teL8NRasP
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX1Z45GiumRIdx
 yQMlaG8DF77LPVdWMdr2l/CtCaYkyXRcwWmRHG96iZ4A2wjSKmEKGPDbvLJB9b0Rw8qIEdeyFx0
 LbGjkDVas8G4sNggp9yeLWlt7lKex5U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230063
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

The following changes since commit b6c4b7e86dec12d07f5cac65265b986d38ee9002:

  Merge tag 'pbouvier/pr/tcg_tests-20261022' of https://gitlab.com/p-b-o/qemu into staging (2026-10-23 09:09:11 +0200)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/target-misc-20261023

for you to fetch changes up to a0deb11baf6e5818ccd641088d9465e0e0eac9b7:

  MAINTAINERS: cover riscv GDB XML files (2026-10-23 17:52:30 +0200)

----------------------------------------------------------------
Misc target patches queue

- Make TCG halt-to-exec transition explicit and remove cpu_exec_halt()
- Various conversions to translate_for_debug()
- Add common CPUClass::exception_name() handler
- multi-target: prefix helpers with target prefix
- Remove target_long_bits() from GDB register reads
- MAINTAINERS updates
----------------------------------------------------------------

Marc-André Lureau (3):
  MAINTAINERS: cover m68k GDB XML files
  MAINTAINERS: cover x86 GDB XML files
  MAINTAINERS: cover riscv GDB XML files

Matt Turner (2):
  target/alpha: Record masked exceptions in FPCR for /S insns
  target/alpha: Determine tininess from the delivered result

Peter Maydell (10):
  target/alpha: Convert to translate_for_debug
  target/avr: Convert to translate_for_debug
  target/or1k: Convert to translate_for_debug
  target/rx: Convert to translate_for_debug
  target/tricore: Convert to translate_for_debug
  target/hexagon: Convert to translate_for_debug
  target/hppa: Convert to translate_for_debug
  target/loongarch: Convert to translate_for_debug
  target/m68k: Convert to translate_for_debug
  target/mips: Convert to translate_for_debug

Philippe Mathieu-Daudé (50):
  accel/tcg: Refactor poll-while-halted flow in cpu_exec()
  accel/tcg: Introduce poll_during_halt() and leaving_halt()
  target/arm: Split leaving-halt handling from arm_cpu_exec_halt()
  target/arm: Convert cpu_exec_halt() to leaving_halt()
  target/i386: Split APIC polling from x86_cpu_exec_halt()
  target/i386: Split leaving-halt handling from x86_cpu_exec_halt()
  target/i386: Use generic halt transition handlers
  accel/tcg: Remove the redundant cpu_exec_halt() hook
  target/sparc/gdbstub: Replace gdb_get_regl() by gdb_get_reg64()
  target/mips/gdbstub: Reduce to a single gdb_get_regl() call
  target/mips/gdbstub: Replace target_long_bits() by mips_env_is_64bit()
  target/ppc: Factor ppc_env_is_64bit() out
  target/ppc/gdbstub: Replace target_long_bits() by ppc_env_is_64bit()
  target/ppc/gdbstub: Replace gdb_get_regl() by ppc_env_is_64bit()
  target/riscv: Factor riscv_gdb_get_reg_mxl() out
  target/riscv: Replace gdb_get_regl() by riscv_gdb_get_reg_mxl()
  target/hexagon: Expand gdb_get_regl() -> gdb_get_reg32() again
  gdbstub: Remove unused gdb_get_regl()
  include: Remove TARGET_LONG_SIZE definition
  qemu/osdep: Document ARRAY_SIZE() macro rejects pointers
  util/cutils: Add STR_ARRAY_ELEM_OR_NULL() for string table lookups
  cpus: Add helper to log raised exceptions with '-d int'
  cpus: Introduce CPUClass::exception_name() handler
  target/alpha: Register CPUClass::exception_name() handler
  target/alpha: Use a static table in alpha_exception_name()
  target/arm: Register CPUClass::exception_name() handler
  target/avr: Implement and register CPUClass::exception_name()
  target/hexagon: Register CPUClass::exception_name() handler
  target/hppa: Register CPUClass::exception_name() handler
  target/i386: Replace magic value by proper EXCP0E_PAGE definition
  target/i386: Implement and register CPUClass::exception_name()
  target/loongarch: Register CPUClass::exception_name() handler
  target/m68k: Register CPUClass::exception_name() handler
  target/m68k: Use a static table in m68k_exception_name()
  target/microblaze: Implement and register CPUClass::exception_name()
  target/mips: Remove EXCP_LAST, use ARRAY_SIZE(excp_names)
  target/mips: Register CPUClass::exception_name() handler
  target/or1k: Register CPUClass::exception_name() handler
  target/ppc: Name the EBB exceptions
  target/ppc: Use a static table in powerpc_excp_name()
  target/ppc: Register CPUClass::exception_name() handler
  target/riscv: Register CPUClass::exception_name() handler
  target/rx: Unify BRK and INT trap handling
  target/rx: Register CPUClass::exception_name() handler
  target/s390x: Implement and register CPUClass::exception_name()
  target/sh4: Register CPUClass::exception_name() handler
  target/sh4: Use a static table in sh4_exception_name()
  target/sparc: Remove always-defined DEBUG_PCALL
  target/sparc: Register CPUClass::exception_name() handler
  target/xtensa: Implement and register CPUClass::exception_name()

Pierrick Bouvier (16):
  target/alpha: define and call helpers using HELPER macro
  target/arm: define and call helpers using HELPER macro
  target/avr: define and call helpers using HELPER macro
  target/hppa: define and call helpers using HELPER macro
  target/i386: define and call helpers using HELPER macro
  target/loongarch: define and call helpers using HELPER macro
  target/m68k: define and call helpers using HELPER macro
  target/microblaze: define and call helpers using HELPER macro
  target/mips: define and call helpers using HELPER macro
  target/or1k: define and call helpers using HELPER macro
  target/ppc: define and call helpers using HELPER macro
  target/riscv: define and call helpers using HELPER macro
  target/s390x: define and call helpers using HELPER macro
  target/sh4: define and call helpers using HELPER macro
  target/sparc: define and call helpers using HELPER macro
  target/tricore: define and call helpers using HELPER macro

Yonggang Luo (2):
  target/rx: Define exception vector constants
  target/sh4: Define exception vector constants

 MAINTAINERS                             |   4 +
 include/accel/tcg/cpu-ops.h             |  36 +-
 include/exec/target_long.h              |   8 +-
 include/gdbstub/helpers.h               |  18 -
 include/hw/core/cpu.h                   |   2 +
 include/qemu/cutils.h                   |  17 +
 include/qemu/osdep.h                    |   9 +
 include/user/tswap-target.h             |   2 +-
 target/alpha/cpu.h                      |   4 +-
 target/arm/cpu.h                        |   4 +-
 target/arm/internals.h                  |   3 -
 target/arm/tcg/vec_internal.h           |   5 +-
 target/avr/cpu.h                        |   5 +-
 target/hexagon/cpu_bits.h               |   2 +
 target/hppa/cpu.h                       |   5 +-
 target/i386/cpu.h                       |   2 +
 target/i386/ops_sse.h                   | 401 +++++++-------
 target/i386/tcg/helper-tcg.h            |   3 +-
 target/loongarch/cpu-mmu.h              |   3 +-
 target/loongarch/internals.h            |   3 +-
 target/m68k/cpu.h                       |   5 +-
 target/microblaze/cpu.h                 |   2 +
 target/mips/cpu.h                       |   4 +-
 target/mips/internal.h                  |   8 +-
 target/mips/tcg/tcg-internal.h          |   2 -
 target/or1k/cpu.h                       |   5 +-
 target/ppc/cpu.h                        |   2 +
 target/ppc/internal.h                   |  18 +-
 target/riscv/cpu.h                      |   1 +
 target/riscv/internals.h                |   5 -
 target/rx/cpu.h                         |  17 +-
 target/rx/helper.h                      |   3 +-
 target/s390x/cpu.h                      |   2 +
 target/s390x/s390x-internal.h           |   1 -
 target/sh4/cpu.h                        |  22 +
 target/sparc/cpu.h                      |   1 +
 target/tricore/cpu.h                    |   3 +-
 target/xtensa/cpu.h                     |   2 +
 accel/tcg/cpu-exec-common.c             |  36 ++
 accel/tcg/cpu-exec.c                    |  20 +-
 target/alpha/clk_helper.c               |   2 +-
 target/alpha/cpu.c                      |   4 +-
 target/alpha/fpu_helper.c               | 130 +++--
 target/alpha/helper.c                   |  78 ++-
 target/alpha/int_helper.c               |  38 +-
 target/alpha/sys_helper.c               |  12 +-
 target/alpha/vax_helper.c               |  42 +-
 target/arm/cpu.c                        |  21 +-
 target/arm/helper.c                     |  77 ++-
 target/arm/tcg/cpu-v7m.c                |   1 -
 target/arm/tcg/helper-a64.c             |   6 +-
 target/arm/tcg/mve_helper.c             |  28 +-
 target/arm/tcg/psci.c                   |   2 +-
 target/arm/tcg/sme_helper.c             |   4 +-
 target/arm/tcg/sve_helper.c             | 141 ++---
 target/arm/tcg/tlb_helper.c             |   2 +-
 target/arm/tcg/vec_helper.c             |  72 +--
 target/arm/tcg/vec_helper64.c           |  64 +--
 target/avr/cpu.c                        |  20 +-
 target/avr/helper.c                     |  23 +-
 target/hexagon/cpu.c                    |  51 +-
 target/hexagon/gdbstub.c                |   4 +-
 target/hexagon/hexswi.c                 |  30 +-
 target/hppa/cpu.c                       |  45 +-
 target/hppa/fpu_helper.c                |   2 +-
 target/hppa/int_helper.c                |  48 +-
 target/hppa/mem_helper.c                |  21 +-
 target/hppa/op_helper.c                 |   2 +-
 target/hppa/sys_helper.c                |   6 +-
 target/i386/cpu.c                       |  30 ++
 target/i386/tcg/bpt_helper.c            |   6 +-
 target/i386/tcg/cc_helper.c             |  14 +-
 target/i386/tcg/excp_helper.c           |  15 +-
 target/i386/tcg/fpu_helper.c            | 182 +++----
 target/i386/tcg/int_helper.c            |  34 +-
 target/i386/tcg/mem_helper.c            |   4 +-
 target/i386/tcg/misc_helper.c           |  16 +-
 target/i386/tcg/mpx_helper.c            |  12 +-
 target/i386/tcg/seg_helper.c            |  43 +-
 target/i386/tcg/system/bpt_helper.c     |   6 +-
 target/i386/tcg/system/misc_helper.c    |  32 +-
 target/i386/tcg/system/seg_helper.c     |  21 +-
 target/i386/tcg/system/smm_helper.c     |  12 +-
 target/i386/tcg/system/svm_helper.c     |  16 +-
 target/i386/tcg/tcg-cpu.c               |   3 +-
 target/i386/tcg/user/seg_helper.c       |   4 +-
 target/loongarch/cpu.c                  |  42 +-
 target/loongarch/cpu_helper.c           |  12 +-
 target/loongarch/tcg/csr_helper.c       |  22 +-
 target/loongarch/tcg/fpu_helper.c       | 126 ++---
 target/loongarch/tcg/iocsr_helper.c     |  16 +-
 target/loongarch/tcg/op_helper.c        |  18 +-
 target/loongarch/tcg/tcg_cpu.c          |  42 --
 target/loongarch/tcg/tlb_helper.c       |  26 +-
 target/loongarch/tcg/vec_helper.c       |   4 +-
 target/m68k/cpu.c                       |   4 +-
 target/m68k/helper.c                    |  16 +-
 target/m68k/op_helper.c                 | 161 +++---
 target/microblaze/cpu.c                 |  16 +-
 target/microblaze/op_helper.c           |  46 +-
 target/mips/cpu.c                       |   4 +-
 target/mips/gdbstub.c                   |  85 +--
 target/mips/system/physaddr.c           |  13 +-
 target/mips/tcg/dsp_helper.c            | 187 +++----
 target/mips/tcg/exception.c             |  18 +-
 target/mips/tcg/fpu_helper.c            | 291 +++++-----
 target/mips/tcg/ldst_helper.c           |  18 +-
 target/mips/tcg/lmmi_helper.c           |  98 ++--
 target/mips/tcg/msa_helper.c            | 690 ++++++++++++------------
 target/mips/tcg/octeon_crypto.c         | 100 ++--
 target/mips/tcg/op_helper.c             |  34 +-
 target/mips/tcg/system/cp0_helper.c     | 276 +++++-----
 target/mips/tcg/system/lcsr_helper.c    |   8 +-
 target/mips/tcg/system/special_helper.c |  12 +-
 target/mips/tcg/system/tlb_helper.c     |  14 +-
 target/mips/tcg/vr54xx_helper.c         |  30 +-
 target/or1k/cpu.c                       |   4 +-
 target/or1k/exception.c                 |  22 +
 target/or1k/fpu_helper.c                |  16 +-
 target/or1k/interrupt.c                 |  19 +-
 target/or1k/mmu.c                       |  21 +-
 target/ppc/cpu_init.c                   |   4 +-
 target/ppc/dfp_helper.c                 |  52 +-
 target/ppc/excp_helper.c                | 140 ++---
 target/ppc/fpu_helper.c                 | 396 +++++++-------
 target/ppc/gdbstub.c                    |  38 +-
 target/ppc/int_helper.c                 | 292 +++++-----
 target/ppc/mem_helper.c                 |  28 +-
 target/ppc/misc_helper.c                |  56 +-
 target/ppc/mmu-hash64.c                 |  18 +-
 target/ppc/mmu_helper.c                 |  70 +--
 target/ppc/power8-pmu.c                 |  14 +-
 target/ppc/tcg-excp_helper.c            |  56 +-
 target/ppc/timebase_helper.c            |  54 +-
 target/riscv/cpu.c                      |  22 +-
 target/riscv/gdbstub.c                  |  35 +-
 target/riscv/tcg/debug.c                |   2 +-
 target/riscv/tcg/fpu_helper.c           | 196 +++----
 target/riscv/tcg/op_helper.c            |  76 +--
 target/riscv/tcg/tcg-cpu.c              |   1 -
 target/rx/cpu.c                         |   4 +-
 target/rx/helper.c                      |  72 ++-
 target/rx/op_helper.c                   |  17 +-
 target/rx/translate.c                   |  23 +-
 target/s390x/cpu-system.c               |   2 +-
 target/s390x/cpu.c                      |   2 +-
 target/s390x/interrupt.c                |  16 +
 target/s390x/tcg/excp_helper.c          |   6 +-
 target/s390x/tcg/mem_helper.c           |   2 +-
 target/s390x/tcg/misc_helper.c          |   3 +-
 target/sh4/cpu.c                        |   2 +-
 target/sh4/helper.c                     | 109 ++--
 target/sh4/op_helper.c                  |  92 ++--
 target/sparc/cpu.c                      |   2 +-
 target/sparc/fop_helper.c               | 106 ++--
 target/sparc/gdbstub.c                  |  13 +-
 target/sparc/helper.c                   |  22 +-
 target/sparc/int32_helper.c             |  22 +-
 target/sparc/int64_helper.c             |  48 +-
 target/sparc/ldst_helper.c              |  14 +-
 target/sparc/vis_helper.c               |  94 ++--
 target/sparc/win_helper.c               |  38 +-
 target/tricore/cpu.c                    |   3 +-
 target/tricore/fpu_helper.c             |  32 +-
 target/tricore/helper.c                 |  13 +-
 target/tricore/op_helper.c              | 220 ++++----
 target/xtensa/cpu.c                     |  25 +-
 target/xtensa/exc_helper.c              |   3 +-
 util/cutils.c                           |   6 +
 target/ppc/translate/vsx-impl.c.inc     |   2 +-
 170 files changed, 3773 insertions(+), 3422 deletions(-)

-- 
2.55.0


