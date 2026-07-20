Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51631C44529
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 17:42:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wls0G-0008Gv-EF; Mon, 20 Jul 2026 13:42:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wlrzU-00080g-L2
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 13:41:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wlrzR-0002tm-8P
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 13:41:20 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KH6Y5F3043934
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 17:41:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=B15u23rCuzZ15+HpJs9F5aq5NscolBUUMD+
 HdJZCURo=; b=Z+YkofxQOrRh0ZX0oQFtvyQEsI9EoylYbmuJNHCylmo8ICjJSIJ
 SbZDa+DNHKxrInfdrGEKawqzmOxmCjy2VJbtsS7w6VZp0TQL1W+6mr0se3kSjaIJ
 lHmY11pNiUTj2W16XzQLwAdlcNz9dThtL8Hucv38e//fJVOZcX2tcgRwxwgl1ArF
 tG+6K35Q99nWxiuPhfrdLojE1AS8hENfGFtTwsbECRucZA4NYSagz7OxA2kNkFex
 D97kGdV3N8wYBt7sFsSxrl0p9jbi6zFELObTLAxSIH4NujmZGR7h7FffW25aLymf
 l8mdZGYPaKOB3QCq5tTRa7ZQXxz6MU/kd7Q==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhgs028q1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 17:41:13 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cab041eced3so12642821a12.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 10:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784569273; x=1785174073; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=B15u23rCuzZ15+HpJs9F5aq5NscolBUUMD+HdJZCURo=;
 b=IbdmOfAbEj+Bqpsl6h7LFDQs8tp/aA9W0igBZ1sst1tmB4iLuf8fjn2tP9gzDOdH9X
 GbByPOH7k/WDZomsxYiMMaB16YOlpVUNguapFgNti8HrWX01wbEb0VA565J/zuWbJj6r
 XgF21R59HBMtAhNzv6xnwZKdSA5m/gjLJeCugEIfNxFuwWaVPKOYRnbwjCududra3ak4
 ccphvVWw9AY5/Lx7gdcQJaLq2UaIrHRqHgvDUi4JFTW0Wk0OwDvHpM7OcHCteZsjlji9
 zX+5kaCPfTAxbwgTuVFghHPKwAjKm7g5J5XxSy6wTJ1kjBJBhQKKO8cv0fJDon57S8VD
 DeSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784569273; x=1785174073;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B15u23rCuzZ15+HpJs9F5aq5NscolBUUMD+HdJZCURo=;
 b=O4CRF3Se/5skbNjWA+Wn89vYxkOWx2vdyvU2xNK9fRofYkhl6f254jnb8rwxGxxVny
 nfol0vMBgHc1iE9KtcQkjY8LzQlUB4cCCWbWSmpdSvnIpGb0ZMephw/5OdoJgpPeLGXy
 Z89inuQTllYVefs5RSrS4gS3mEmyMM6jwgxx+54mvf0H+J4Ocss787jrRnHa1WIgnn5c
 5gP9jkdoBowyM3DtgUzipjUO/ScN075X7mzFYiNIfePMzkiifzJueBecBdJttfuLU4nD
 6QnzgTdn8g+VvmQwnVtySjJwbZqix0rVjXvhVQo0yzwBWCLHQHv5pGwuZe2xr5zdDJGP
 Xy7Q==
X-Gm-Message-State: AOJu0Ywjq/+3aHAFsSE1weyAdA9ymPL/lv5JKebscP97IQ5SdYhdbWMw
 T4jE3uCSDNFyuHwyIcvNvvtUAyFQrc4/wqfd1+NWuCoQ7rcG8Mh212vAptI/R30pSTwMrPAWVJe
 chhcjzG4AklM03DHQl+eQ16fR9P7yqt1rcIpjIshTsMZV+Ql8pA8l/8m3xcujiLRAEA==
X-Gm-Gg: AfdE7cmrRExT6FgOvme4iAI/fWd1t4sBX3PZ+cbEIz4swvfJql1IFpDNBx+Ag6ChnOa
 TbuUgVlI4oI4iva6N7TMvVWyoPOPvVDCLKAx545Q4hvmmdLKfeQIomFU+QNvSWInrHwUMR9rYCy
 yZOaMDpPwuPQsCkpTyY0VZ48XF2sw+6PxCe2YYViWmFCzszwiusL+f5Y7aZqsJVqgcfomflF3wb
 bQS/wHTxxpS+I3JDeNMvMi1Ywp8aEV8osQXBbJqz1h5fkp/J+q78y0F0KHe6xWpsBDZfMp5C7OX
 dFxx7/XuiFwUs/xR/OIRvIUhCmvzwXs1JEupRiwATCFs0NvYL2tOXcboMzRIjpRKG105/853Frr
 AIC7nROHOGKBt34b+5ILOczuJ/aYJYswOOHSv6ARnMF/pyw32Y2E+o8mlvBSlGu8=
X-Received: by 2002:a05:6a21:a393:b0:3c3:9251:fe49 with SMTP id
 adf61e73a8af0-3c3ad972d5bmr16159696637.50.1784569272515; 
 Mon, 20 Jul 2026 10:41:12 -0700 (PDT)
X-Received: by 2002:a05:6a21:a393:b0:3c3:9251:fe49 with SMTP id
 adf61e73a8af0-3c3ad972d5bmr16159664637.50.1784569271944; 
 Mon, 20 Jul 2026 10:41:11 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a1dde81sm66281257eec.21.2026.07.20.10.41.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 10:41:11 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng
Subject: [PATCH v3 00/13] hexagon: add semihosting support
Date: Mon, 20 Jul 2026 10:40:56 -0700
Message-Id: <cover.1784568922.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE5MyBTYWx0ZWRfX5s6xNWntFObC
 QK8FsUN9Gww1hCiAyxK5QM5NNqjMl8qutPNFM8p1lnfeW+lk0pGKmdPmCmXrkXlt7Jmov7yElGJ
 w4k+byfP+2nKDBp306478Wmh3m9KXsU=
X-Proofpoint-ORIG-GUID: t2HMUboyYV4KsN6gpbuiMM2V2Zvwyjqx
X-Authority-Analysis: v=2.4 cv=DMS/JSNb c=1 sm=1 tr=0 ts=6a5e5db9 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=2klBbvr5IC3WPyomHCoA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: t2HMUboyYV4KsN6gpbuiMM2V2Zvwyjqx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE5MyBTYWx0ZWRfX46Tp4GkdA0bb
 zQNE4wtZaENH+XUbCBoFYKNDUcVskNMT2mzDF4pn8UFS5m/pqpY22V8nKJC30lYwWAr4wmOqAAC
 JaUk5mShO/ORwY5C7Alhw9HEO2qAleWQZFT8pNGckpauks8PX6deMHarePgFKnJq9atrFRawAKf
 MuninV+656F80TyOqioaTlHt8RjMpk5uX637XmVMJtuEuOWm2Sh79+umaonNvETrCfmk9RJUIMY
 oAIieFEq9bwC8fAXXxziq1ER/NXdpfYCfCqXvToSsh574iN6KsukE0/+/62WBl4WHhgYqMeQov2
 Ej8bOs6iZuYbzUtFBLTCh2uw/kNbYVrOU86s+hiTIQrrmhorbzVgydoyyv1CW0r2dEmVFuDrt+n
 jjmcCRjuf+7TarVH2QeSKtOq54PsJ/p8+Sc4ai1pwEjJKiP308SB+4YfOE4oZTePMC1PT3xWxCd
 X4u5pO7VsS5DHV3u3aA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_04,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200193
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This series adds semihosting support to hexagon system emulation,
together with functional tests for the added operations.

The Hexagon semihosting spec can be found at:
https://docs.qualcomm.com/doc/80-N2040-101_102648/topic/semihosting-specification.html

v1: https://lore.kernel.org/qemu-devel/cover.1783973054.git.matheus.bernardino@oss.qualcomm.com/
v2: https://lore.kernel.org/qemu-devel/3cd3a419-ee2c-4d7a-9396-60eab8d26908@oss.qualcomm.com/T/#m9e966877cda81c5661838fedadf4e69bd912cbb5

Changes in v3:
- Reworded semihosting section at Hexagon docs
- Rebased, added Reviewed-by's, dropped already merged patch

Changes in v2:
- Added patch 1, a fix for an existing bug that appeared with the new
  test semantics from the last patch.
- Patch 3: s/hexagon_touch_memory/hexagon_peek_memory_range/
- Patch 7:
  * Add semihosting spec link to docs
  * Fixed HEX_SYS_EXCEPTION
- Patch 10:
  * Moved tables to static definition
  * Fixed compilation for Windows
- Dropped patch 11 (OPEN/READ/CLOSE_DIR support): for now we don't have
  dirent semantics for Windows, so leave these ops to a followup series.
- Patch 14:
  * Update test version
  * Don't change directory
  * Don't use os.path, use scratch_file

Brian Cain (4):
  semihosting: add APIs for chardev-aware guest fd routing
  target/hexagon: Add an errno mapping
  python/machine: support routing semihosting output to the test console
  tests/functional: Add hexagon semihosting systests

Matheus Tavares Bernardino (9):
  target/hexagon: fix improper assign of cause code to exception index
  target/hexagon: fix PC advancement for non-COF TB terminators
  target/hexagon: add aux functions for guest mem load/store
  hexagon: cpu_helper: add reg reading/writing helpers
  semihosting: add callback to set error
  target/hexagon: add semihosting support
  semihosting: add ftruncate helper (to be used for hexagon)
  target/hexagon: add main arch-specific semihosting operations
  target/hexagon: add COREDUMP semihosting operation

 docs/system/target-hexagon.rst            |   8 +-
 configs/targets/hexagon-softmmu.mak       |   2 +
 include/semihosting/common-semi.h         |   2 +
 include/semihosting/console.h             |   9 +
 include/semihosting/guestfd.h             |   9 +
 include/semihosting/syscalls.h            |   2 +
 target/hexagon/cpu_helper.h               |  24 +
 target/hexagon/internal.h                 |   1 +
 hw/hexagon/hexagon_dsp.c                  |   2 +
 semihosting/arm-compat-semi.c             |   3 +-
 semihosting/console.c                     |   5 +
 semihosting/guestfd.c                     |   8 +
 semihosting/syscalls.c                    |  29 +
 target/arm/common-semi-target.c           |   4 +
 target/hexagon/common-semi-target.c       |  51 ++
 target/hexagon/cpu.c                      |   5 +-
 target/hexagon/cpu_helper.c               | 173 ++++++
 target/hexagon/hexswi.c                   | 657 +++++++++++++++++++++-
 target/hexagon/op_helper.c                |  18 +-
 target/hexagon/translate.c                |  17 +-
 target/riscv/common-semi-target.c         |   4 +
 hw/hexagon/Kconfig                        |   1 +
 python/qemu/machine/machine.py            |  10 +-
 qemu-options.hx                           |   8 +-
 target/hexagon/meson.build                |   3 +
 tests/functional/hexagon/meson.build      |   5 +
 tests/functional/hexagon/test_systests.py | 110 ++++
 27 files changed, 1135 insertions(+), 35 deletions(-)
 create mode 100644 target/hexagon/common-semi-target.c
 create mode 100755 tests/functional/hexagon/test_systests.py

Range-diff against v2:
 1:  aaac9492e5a !  1:  4f4ec84cb85 target/hexagon: fix improper assign of cause code to exception index
    @@ Commit message
         gen_exception(), which treats its argument as an event index and stores
         it directly in cs->exception_index.
     
    +    Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
         Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
     
      ## target/hexagon/cpu.c ##
 2:  2f5247200ec <  -:  ----------- target/hexagon: fix get_phys_addr_debug with in-page offset
 3:  2cac81d1782 =  2:  ab16d424acd target/hexagon: fix PC advancement for non-COF TB terminators
 4:  b0f794c467a !  3:  db1ec7611b7 target/hexagon: add aux functions for guest mem load/store
    @@ Commit message
     
         Will be used for semihosting.
     
    -    Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
         Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
         Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
    +    Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
     
      ## target/hexagon/cpu_helper.h ##
     @@
 5:  5b16ff40a6e =  4:  b02e7a60814 hexagon: cpu_helper: add reg reading/writing helpers
 6:  90074658cf5 =  5:  c540d8251f2 semihosting: add APIs for chardev-aware guest fd routing
 7:  a08d1e274e7 =  6:  a130a83d7a1 semihosting: add callback to set error
 8:  5c5c06f35f7 !  7:  0c46c3d9cf8 target/hexagon: add semihosting support
    @@ Commit message
         CONFIG_ARM_COMPATIBLE_SEMIHOSTING and routing trap0 to the
         semihosting handler.
     
    -    Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
         Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
         Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
    +    Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
     
      ## docs/system/target-hexagon.rst ##
     @@ docs/system/target-hexagon.rst: Semihosting
    @@ docs/system/target-hexagon.rst: Semihosting
     +guest software can access the host console and filesystem. Read the
     +`Hexagon Semihosting Specification
     +<https://docs.qualcomm.com/doc/80-N2040-101_102648/topic/semihosting-specification.html>`__
    -+for details. Semihosting is enabled on qemu-system-hexagon machines by default,
    -+and it can be configured through ``-semihosting-config``.
    ++for details. Semihosting is enabled by default on hexagon-sim-compatible
    ++machines. This can be further configured through ``-semihosting-config``.
      
      Hexagon Features
      ================
 9:  7399327e99b =  8:  6bff530121c semihosting: add ftruncate helper (to be used for hexagon)
10:  b66476c599c !  9:  96776c988e4 target/hexagon: add main arch-specific semihosting operations
    @@ Commit message
         perform file I/O when running on qemu-system-hexagon.
     
         Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
    +    Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
         Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
     
      ## include/semihosting/common-semi.h ##
11:  7fd1831acb4 ! 10:  9ac447d6831 target/hexagon: add COREDUMP semihosting operation
    @@ Commit message
         Implement the handler to decode the SSR cause field and
         print the full register file, matching hexagon-sim behavior.
     
    -    Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
         Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
         Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
    +    Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
     
      ## target/hexagon/internal.h ##
     @@ target/hexagon/internal.h: int hexagon_hvx_gdb_write_register(CPUState *env, uint8_t *mem_buf, int n);
12:  24731ad7a27 = 11:  bf030fc808d target/hexagon: Add an errno mapping
13:  c16ea7a7e6c = 12:  6d1f197c4ac python/machine: support routing semihosting output to the test console
14:  87a6d2559c3 ! 13:  4299b53256d tests/functional: Add hexagon semihosting systests
    @@ Commit message
         Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
         Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
     
    - ## tests/functional/hexagon/meson.build (new) ##
    + ## tests/functional/hexagon/meson.build ##
     @@
    -+# SPDX-License-Identifier: GPL-2.0-or-later
    + 
    + tests_hexagon_system_thorough = [
    +   'arch_tests',
    ++  'systests',
    + ]
     +
     +test_hexagon_timeouts = {
     +  'systests': 180,
     +}
    -+
    -+tests_hexagon_system_thorough = [
    -+  'systests',
    -+]
     
      ## tests/functional/hexagon/test_systests.py (new) ##
     @@
    @@ tests/functional/hexagon/test_systests.py (new)
     +
     +if __name__ == "__main__":
     +    QemuSystemTest.main()
    -
    - ## tests/functional/meson.build ##
    -@@ tests/functional/meson.build: subdir('aarch64')
    - subdir('alpha')
    - subdir('arm')
    - subdir('avr')
    -+subdir('hexagon')
    - subdir('hppa')
    - subdir('i386')
    - subdir('loongarch64')
-- 
2.37.2


