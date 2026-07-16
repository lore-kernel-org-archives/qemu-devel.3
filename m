Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B64C44515
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 18:09:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkQUe-0000t3-3f; Thu, 16 Jul 2026 14:07:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wkQUb-0000sD-Ve
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 14:07:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wkQUX-0001SS-RJ
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 14:07:29 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GGSmsj3171776
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 18:07:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=XLdm1lgqnG4+KrkvqUHPSw9J9mkLukACmoF
 DGsxyJpw=; b=DfAVr6F6Vl8LX+IcCfEVrxLs0QuKIdC9i5hMV3/3Y+6BEn+sckG
 96VUWT8UE5WMmdzAqpuS/VRkf/MN1Ju2h5e1jD3Qevm860OUD6wduQwir4mUwH1w
 oS9I7vHqdZdm3enzxplipBlI42zscZVHjCvHROFoDLFYrrXZggoBS15jUgB09vfJ
 xrfdHEzkJAVuqWEFnS0IeJLj34wcIDv5BEqlJFFCzJ5QRJsPcIc/ArmKSInwvj0g
 9JK6PbUX2VCIzhOdCwxzwXPdMLIolpEPSQqiKtaygqqvuxT8p4Re07pYCh59cYKH
 k94ARDMe4Iw3CWww2yD1PF4n6rVVfv+cyOA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fevkv2bef-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 18:07:22 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c892143db7fso3285238a12.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 11:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784225241; x=1784830041; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XLdm1lgqnG4+KrkvqUHPSw9J9mkLukACmoFDGsxyJpw=;
 b=ewG+UxzdlLvMdncrcu/o/klrg8MJyLgAYIV2vlbiJwDvJM83LlywzLfqgYJImDIgd2
 Z6CHR48jRWYL1qJBOCPTdn9YGF+vtVaffPJM5v75w0HgvG2Wfvg+DErfcvi1lgBWPh3t
 jzSSYvmqezDyum86orq5FRC3n+RietiEzvDiBwUWPgN9fkBvOPIZxmWpnAgnSosz25rb
 6nUhdlra2utb+L1iVEoBUvHO9W4Z571AvYpSPdGQn2zVwD44HXxs1MPyHKJPEHQaVoMg
 WnWTZ8Eo5TF2clY2eMUT2Zft+egYDF30nOC2MdSCcsERbZPkU6EnM4nnf0y6Y6IV0mY6
 xE6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784225241; x=1784830041;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XLdm1lgqnG4+KrkvqUHPSw9J9mkLukACmoFDGsxyJpw=;
 b=pxJCt+sOLqdZmZEDa4wnOwjWpFRx6uIjCtR3lgIuHzni63rjaUWheepsRKwyHPfGbD
 UAOfo85VzR7Rs5YogbGdkjzvcMNGFRR1f7Pby9uM/0uDn6jsqyvnqJDrV1M0KQPuTmF8
 Ewo7nrqRLgs570ovaD1pY2+ha6tAn5SnyoAiF2H3pbojbXmrOGHQTpdtx86K88DyJ7T+
 6RYECdTHH2WouiWpjXFOoc0ZkPKmCrKFOFjzhWz3pHJ9DhKRukND57/Vs+r/84pDptar
 /3vOq8b7yP3W0cSJTphP815nTMYpQBKUO/K1RW8aYTyAcL/bVvQLmPx4HPGqhUldM7mi
 rQpA==
X-Gm-Message-State: AOJu0YyFd3fR/scxhYH49m2t2jv8x78qL3/sxi9t+YsDX5O5T4evKJPU
 93kuy1ZhLlb2BxkgQwCLYZzZCRlGQbJko/jqYteWqNi2k8rAAQrn51QoAGC43W763ULR9b9SmYR
 VNIwBdCwdzaounRyAfWlodoF/qr4AhmGeBlQLSNPE3bwtig0cUyHqVUfrCNFbvZ7sNg==
X-Gm-Gg: AfdE7cnvIlP3ocQcqOMnHhc3gG3637926M5+KeTi2E3ZSlVtP//IUD+BAm4Sa4MXMrb
 TX9W/lgZ6eYpdAM9XG44p6Y4fXv7hvq9T4sw26F10Auw1MfOnzd6NyteB4Ktg8vSAaqvX86RM/5
 IlqZbQx0GAlaus2sLRr69EI2HriDBmMBNPRpn6uc3uCaZnyprCzt//hBulACjwFTuIy03UcOuNV
 KVOaQFX8QIQHYA1DRPj1Rsw8gjjukTO5qIIUfMgdYcqnL2GaN7WvIirlwVUtEV89Qtxq9tC48Hl
 dSWO9DgVzU28GuQyFbuOUzNq/GFEJNjfS7qmHJ1Lt5D8hT01GmyiklOkUOxBCZJQfFLbRIFc8eN
 Cvk1dQVIK6DFCjcAHOzRZGA1Ruq6MhBDplHf51yiAikLLAYFuxeg5nFMVs95HSxI=
X-Received: by 2002:a17:90b:2ed0:b0:37f:9cdf:f03a with SMTP id
 98e67ed59e1d1-38e46799943mr597261a91.29.1784225240657; 
 Thu, 16 Jul 2026 11:07:20 -0700 (PDT)
X-Received: by 2002:a17:90b:2ed0:b0:37f:9cdf:f03a with SMTP id
 98e67ed59e1d1-38e46799943mr597216a91.29.1784225239867; 
 Thu, 16 Jul 2026 11:07:19 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3140e5326c0sm17131184eec.11.2026.07.16.11.07.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 11:07:17 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng
Subject: [PATCH v2 00/14] hexagon: add semihosting support
Date: Thu, 16 Jul 2026 11:06:44 -0700
Message-Id: <cover.1784225209.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE4NSBTYWx0ZWRfX15Ztb9zwJ9dP
 suKU80YaTEyn1UvBPtl76jTB46v79r/Dx10OEBEIMnXUmUsW1pzgf29lvLBFnyAQvl6WPZXjbTq
 gIHHHqdTrgSCy2sU5sRAqmgVRwJ0qJk/hSmIYmaNBOv3wfqdv6Z4ES/bEX6/l5O0QwskvQiKvr8
 mq5ph4eoaPoCo006le5XUvzkhY/b4BDp5mgQIOuio/VoF4rKseFA53AuAWEhneK49/iGyiZl00j
 SszxgAL8Ti+TGWYNGS8JhODQM3VcM62Us9yyR2BbkbMM0XXUPsH5k84OyiiLTFnNAEtfvlXbanV
 v9WGUImQ2WFizb2smWN30cciwPsfuQAJbu+PAIGXvrb0vqHdibhhrQ8bpE0SWdJXA7z1g4Acan5
 3LBHZ8u4GvMnUBjXzb4lMywSzEKxBYFMZH+PWXcqfOxp4VHx4q5FwVSd/xvYyrgcyOsE/g2hyzA
 ylcOp0TbtSVh5hJ/10g==
X-Authority-Analysis: v=2.4 cv=WrEb99fv c=1 sm=1 tr=0 ts=6a591dda cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=5vFef2XoAAAA:20 a=COk6AnOGAAAA:8 a=6NPpPscU-uX0YG7HArcA:9
 a=3WC7DwWrALyhR5TkjVHa:22 a=TjNXssC_j7lpFel5tvFf:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: gB4ijWy6b3l8NIqjogaeEuJWV9ZL3JCb
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE4NSBTYWx0ZWRfX8DV3zOeOwj5o
 VX5QRYPoITL//eO6gLtIA4mPP3WpL310Ilb+ThO9iFPKNsMTBdoAXSQNZSu/ZLZyVBLXv+RhAd2
 ZqfmKrsPNeycZzCHj2x1KcPcPAYd2+g=
X-Proofpoint-ORIG-GUID: gB4ijWy6b3l8NIqjogaeEuJWV9ZL3JCb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_06,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160185
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
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

This series adds semihosting support to hexagon system emulation,
together with functional tests for the added operations.

The Hexagon semihosting spec can be found at:
https://docs.qualcomm.com/doc/80-N2040-101_102648/topic/semihosting-specification.html

v1: https://lore.kernel.org/qemu-devel/cover.1783973054.git.matheus.bernardino@oss.qualcomm.com/

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

Matheus Tavares Bernardino (10):
  target/hexagon: fix improper assign of cause code to exception index
  target/hexagon: fix get_phys_addr_debug with in-page offset
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
 target/hexagon/cpu.c                      |   7 +-
 target/hexagon/cpu_helper.c               | 173 ++++++
 target/hexagon/hexswi.c                   | 657 +++++++++++++++++++++-
 target/hexagon/op_helper.c                |  18 +-
 target/hexagon/translate.c                |  17 +-
 target/riscv/common-semi-target.c         |   4 +
 hw/hexagon/Kconfig                        |   1 +
 python/qemu/machine/machine.py            |  10 +-
 qemu-options.hx                           |   8 +-
 target/hexagon/meson.build                |   3 +
 tests/functional/hexagon/meson.build      |   9 +
 tests/functional/hexagon/test_systests.py | 110 ++++
 tests/functional/meson.build              |   1 +
 28 files changed, 1142 insertions(+), 35 deletions(-)
 create mode 100644 target/hexagon/common-semi-target.c
 create mode 100644 tests/functional/hexagon/meson.build
 create mode 100755 tests/functional/hexagon/test_systests.py

Range-diff against v1:
 -:  ----------- >  1:  aaac9492e5a target/hexagon: fix improper assign of cause code to exception index
 1:  dd52bfe14af !  2:  2f5247200ec target/hexagon: fix get_phys_addr_debug with in-page offset
    @@ Commit message
     
         This would break semihosting argument reads when it is added for Hexagon.
     
    +    Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
         Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
     
      ## target/hexagon/cpu.c ##
 2:  c0cc9ab4c7d !  3:  2cac81d1782 target/hexagon: fix PC advancement for non-COF TB terminators
    @@ Commit message
         hex_gpr[HEX_REG_PC]).  Drop the special case so these packets advance to
         the following packet like any other non-COF TB terminator.
     
    +    Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
         Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
     
      ## target/hexagon/translate.c ##
 3:  9cdc7c7f27a !  4:  b0f794c467a target/hexagon: add aux functions for guest mem load/store
    @@
      ## Metadata ##
    -Author: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
    +Author: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
     
      ## Commit message ##
         target/hexagon: add aux functions for guest mem load/store
     
         Will be used for semihosting.
     
    -    Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
    +    Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
         Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
    +    Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
     
      ## target/hexagon/cpu_helper.h ##
     @@
    @@ target/hexagon/cpu_helper.h
     +                         void *retptr, uintptr_t retaddr);
     +void hexagon_write_memory(CPUHexagonState *env, target_ulong vaddr,
     +                          int size, uint64_t data, uintptr_t retaddr);
    -+void hexagon_touch_memory(CPUHexagonState *env, uint32_t start_addr,
    -+                          uint32_t length, uintptr_t retaddr);
    ++void hexagon_peek_memory_range(CPUHexagonState *env, uint32_t start_addr,
    ++                               uint32_t length, uintptr_t retaddr);
      uint32_t hexagon_get_pmu_counter(CPUHexagonState *cur_env, int index);
      void hexagon_modify_ssr(CPUHexagonState *env, uint32_t new, uint32_t old);
      int get_cpu_mode(CPUHexagonState *env);
    @@ target/hexagon/cpu_helper.c
     +    return addr & page_align;
     +}
     +
    -+void hexagon_touch_memory(CPUHexagonState *env, uint32_t start_addr,
    -+                          uint32_t length, uintptr_t retaddr)
    ++void hexagon_peek_memory_range(CPUHexagonState *env, uint32_t start_addr,
    ++                               uint32_t length, uintptr_t retaddr)
     +{
     +    unsigned int warm;
     +    uint32_t first = page_start(start_addr);
 4:  636d47e381c !  5:  5b16ff40a6e hexagon: cpu_helper: add reg reading/writing helpers
    @@ Commit message
         And adjust op_helper to use those. They will also be used on upcoming
         semihosting commits.
     
    +    Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
         Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
     
      ## target/hexagon/cpu_helper.h ##
 6:  726a2186349 !  6:  90074658cf5 semihosting: add APIs for chardev-aware guest fd routing
    @@ Commit message
         rather than directly to host stdio.
     
         Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
    +    Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
     
      ## include/semihosting/console.h ##
     @@ include/semihosting/console.h: void qemu_semihosting_console_block_until_ready(CPUState *cs);
 5:  df1607f5ee3 !  7:  a08d1e274e7 semihosting: add callback to set error
    @@ Commit message
         semihosting: add callback to set error
     
         This is currently unused by existing semihosting targets, but it will be
    -    used by hexagon.
    +    used by hexagon in the following commit.
     
    -    Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
         Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
    +    Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
    +    Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
     
      ## include/semihosting/common-semi.h ##
     @@
 7:  e01b8e57d6b !  8:  5c5c06f35f7 target/hexagon: add semihosting support
    @@
      ## Metadata ##
    -Author: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
    +Author: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
     
      ## Commit message ##
         target/hexagon: add semihosting support
    @@ Commit message
         CONFIG_ARM_COMPATIBLE_SEMIHOSTING and routing trap0 to the
         semihosting handler.
     
    -    Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
    +    Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
         Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
    +    Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
    +
    + ## docs/system/target-hexagon.rst ##
    +@@ docs/system/target-hexagon.rst: Semihosting
    + -----------
    + Hexagon supports a semihosting interface similar to other architectures'.
    + The ``trap0`` instruction can activate these semihosting calls so that the
    +-guest software can access the host console and filesystem.  Semihosting
    +-is not yet implemented in QEMU hexagon.
    +-
    ++guest software can access the host console and filesystem. Read the
    ++`Hexagon Semihosting Specification
    ++<https://docs.qualcomm.com/doc/80-N2040-101_102648/topic/semihosting-specification.html>`__
    ++for details. Semihosting is enabled on qemu-system-hexagon machines by default,
    ++and it can be configured through ``-semihosting-config``.
    + 
    + Hexagon Features
    + ================
     
      ## configs/targets/hexagon-softmmu.mak ##
     @@ configs/targets/hexagon-softmmu.mak: TARGET_LONG_BITS=32
    @@ target/hexagon/hexswi.c
     +
     +    hexagon_read_memory(env, swi_info + 4, 4, &addr, retaddr);
     +    hexagon_read_memory(env, swi_info + 8, 4, &count, retaddr);
    -+    hexagon_touch_memory(env, addr, count, retaddr);
    ++    hexagon_peek_memory_range(env, addr, count, retaddr);
     +}
     +
     +static void sim_handle_trap0(CPUHexagonState *env)
     +{
     +    target_ulong what_swi, swi_info;
    -+    G_GNUC_UNUSED uintptr_t retaddr = 0;
     +    CPUState *cs = env_cpu(env);
     +
     +    g_assert(bql_locked());
    @@ target/hexagon/hexswi.c
     +    switch (what_swi) {
     +
     +    case HEX_SYS_EXCEPTION:
    ++    {
    ++        uint32_t ret = arch_get_thread_reg(env, HEX_REG_R02);
     +        arch_set_system_reg(env, HEX_SREG_MODECTL, 0);
    -+        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
    -+        break;
    ++        gdb_exit(ret);
    ++        exit(ret);
    ++    }
    ++    break;
     +
     +    /* TODO: implement other hexagon-specific semihosting calls */
     +
 8:  8f1099dc944 !  9:  7399327e99b semihosting: add ftruncate helper (to be used for hexagon)
    @@ Commit message
         operation.  Add semihost_sys_ftruncate() so that Hexagon
         can delegate to it rather than calling ftruncate directly.
     
    -    Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
         Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
    +    Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
    +    Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
     
      ## include/semihosting/syscalls.h ##
     @@ include/semihosting/syscalls.h: void semihost_sys_gettimeofday(CPUState *cs, gdb_syscall_complete_cb complete,
 9:  45fc870a747 ! 10:  b66476c599c target/hexagon: add main arch-specific semihosting operations
    @@ Commit message
         that baremetal programs using the standard Hexagon simulator ABI can
         perform file I/O when running on qemu-system-hexagon.
     
    -    Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
         Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
    +    Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
     
      ## include/semihosting/common-semi.h ##
     @@
    @@ semihosting/arm-compat-semi.c: static inline uint32_t get_swi_errno(CPUState *cs
      #ifdef CONFIG_USER_ONLY
     
      ## target/hexagon/hexswi.c ##
    +@@ target/hexagon/hexswi.c: static inline bool is_hexagon_specific_swi_flag(enum hex_swi_flag what_swi)
    + }
    + #undef DEF_SWI_FLAG
    + 
    ++static const unsigned int angel_to_host_filemode_table[] = {
    ++    O_RDONLY,
    ++    O_RDONLY | O_BINARY,
    ++    O_RDWR,
    ++    O_RDWR | O_BINARY,
    ++    O_WRONLY | O_CREAT | O_TRUNC,
    ++    O_WRONLY | O_CREAT | O_TRUNC | O_BINARY,
    ++    O_RDWR | O_CREAT | O_TRUNC,
    ++    O_RDWR | O_CREAT | O_TRUNC | O_BINARY,
    ++    O_WRONLY | O_APPEND | O_CREAT,
    ++    O_WRONLY | O_APPEND | O_CREAT | O_BINARY,
    ++    O_RDWR | O_APPEND | O_CREAT,
    ++    O_RDWR | O_APPEND | O_CREAT | O_BINARY,
    ++    O_RDWR | O_CREAT,
    ++    O_RDWR | O_CREAT | O_EXCL
    ++};
    ++
    ++/*
    ++ * This must match the caller's definition, it would be in the
    ++ * caller's angel.h or equivalent header.
    ++ */
    ++struct __SYS_STAT {
    ++    uint64_t dev;
    ++    uint64_t ino;
    ++    uint32_t mode;
    ++    uint32_t nlink;
    ++    uint64_t rdev;
    ++    uint32_t size;
    ++    uint32_t __pad1;
    ++    uint32_t atime;
    ++    uint32_t mtime;
    ++    uint32_t ctime;
    ++    uint32_t __pad2;
    ++} sys_stat;
    ++
    + static void init_semihosting_guestfds(void)
    + {
    +     static gsize initialized;
     @@ target/hexagon/hexswi.c: static void do_preload(CPUHexagonState *env, target_ulong swi_info, bool load)
    -     hexagon_touch_memory(env, addr, count, retaddr);
    +     hexagon_peek_memory_range(env, addr, count, retaddr);
      }
      
     +static void common_semi_ftell_cb(CPUState *cs, uint64_t ret, int err)
    @@ target/hexagon/hexswi.c: static void do_preload(CPUHexagonState *env, target_ulo
      static void sim_handle_trap0(CPUHexagonState *env)
      {
          target_ulong what_swi, swi_info;
    +     CPUState *cs = env_cpu(env);
    ++    uintptr_t retaddr = 0;
    + 
    +     g_assert(bql_locked());
    +     init_semihosting_guestfds();
     @@ target/hexagon/hexswi.c: static void sim_handle_trap0(CPUHexagonState *env)
    -         qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
    -         break;
    +     }
    +     break;
      
     -    /* TODO: implement other hexagon-specific semihosting calls */
    -+#ifndef _WIN32
     +    case HEX_SYS_OPEN:
     +    {
     +        char filename[BUFSIZ];
    -+        target_ulong physicalFilenameAddr;
    ++        target_ulong physical_filename_addr;
     +        unsigned int filemode;
     +        int length;
     +        int real_openmode;
     +        int ret, err = 0;
     +        int i = 0;
    -+        static const unsigned int mode_table[] = {
    -+            O_RDONLY,
    -+            O_RDONLY | O_BINARY,
    -+            O_RDWR,
    -+            O_RDWR | O_BINARY,
    -+            O_WRONLY | O_CREAT | O_TRUNC,
    -+            O_WRONLY | O_CREAT | O_TRUNC | O_BINARY,
    -+            O_RDWR | O_CREAT | O_TRUNC,
    -+            O_RDWR | O_CREAT | O_TRUNC | O_BINARY,
    -+            O_WRONLY | O_APPEND | O_CREAT,
    -+            O_WRONLY | O_APPEND | O_CREAT | O_BINARY,
    -+            O_RDWR | O_APPEND | O_CREAT,
    -+            O_RDWR | O_APPEND | O_CREAT | O_BINARY,
    -+            O_RDWR | O_CREAT,
    -+            O_RDWR | O_CREAT | O_EXCL
    -+        };
     +
    -+
    -+        hexagon_read_memory(env, swi_info, 4, &physicalFilenameAddr, retaddr);
    ++        hexagon_read_memory(env, swi_info, 4, &physical_filename_addr, retaddr);
     +        hexagon_read_memory(env, swi_info + 4, 4, &filemode, retaddr);
     +        hexagon_read_memory(env, swi_info + 8, 4, &length, retaddr);
     +
    @@ target/hexagon/hexswi.c: static void sim_handle_trap0(CPUHexagonState *env)
     +        }
     +
     +        do {
    -+            hexagon_read_memory(env, physicalFilenameAddr + i, 1, &filename[i],
    ++            hexagon_read_memory(env, physical_filename_addr + i, 1, &filename[i],
     +                                retaddr);
     +            i++;
     +        } while (filename[i - 1]);
     +
     +        /* convert ARM ANGEL filemode into host filemode */
    -+        if (filemode < 14) {
    -+            real_openmode = mode_table[filemode];
    ++        if (filemode < ARRAY_SIZE(angel_to_host_filemode_table)) {
    ++            real_openmode = angel_to_host_filemode_table[filemode];
     +        } else {
     +            qemu_log_mask(LOG_GUEST_ERROR,
     +                          "%s: invalid OPEN mode: %u\n",
    @@ target/hexagon/hexswi.c: static void sim_handle_trap0(CPUHexagonState *env)
     +
     +    /*
     +     * Hexagon's SYS_ISTTY is a bit different than arm's: we do not return -1
    -+     * on error, neither errno. So we override with out own implementation.
    ++     * on error, neither errno. So we override with our own implementation.
     +     */
     +    case HEX_SYS_ISTTY:
     +    {
    @@ target/hexagon/hexswi.c: static void sim_handle_trap0(CPUHexagonState *env)
     +    case HEX_SYS_STAT:
     +    case HEX_SYS_FSTAT:
     +    {
    -+        /*
    -+         * This must match the caller's definition, it would be in the
    -+         * caller's angel.h or equivalent header.
    -+         */
    -+        struct __SYS_STAT {
    -+            uint64_t dev;
    -+            uint64_t ino;
    -+            uint32_t mode;
    -+            uint32_t nlink;
    -+            uint64_t rdev;
    -+            uint32_t size;
    -+            uint32_t __pad1;
    -+            uint32_t atime;
    -+            uint32_t mtime;
    -+            uint32_t ctime;
    -+            uint32_t __pad2;
    -+        } sys_stat;
     +        struct stat st_buf;
     +        uint8_t *st_bufptr = (uint8_t *)&sys_stat;
     +        int rc, err = 0;
     +        char filename[BUFSIZ];
    -+        target_ulong physicalFilenameAddr;
    ++        target_ulong physical_filename_addr;
     +        target_ulong statBufferAddr;
    -+        hexagon_read_memory(env, swi_info, 4, &physicalFilenameAddr, retaddr);
    ++        hexagon_read_memory(env, swi_info, 4, &physical_filename_addr, retaddr);
     +
     +        if (what_swi == HEX_SYS_STAT) {
     +            int i = 0;
     +            do {
    -+                hexagon_read_memory(env, physicalFilenameAddr + i, 1,
    ++                hexagon_read_memory(env, physical_filename_addr + i, 1,
     +                                    &filename[i], retaddr);
     +                i++;
     +            } while ((i < BUFSIZ) && filename[i - 1]);
     +            rc = stat(filename, &st_buf);
     +            err = errno;
     +        } else {
    -+            int fd = physicalFilenameAddr;
    ++            int fd = physical_filename_addr;
     +            GuestFD *gf = get_guestfd(fd);
     +            if (!gf || gf->type != GuestFDHost) {
     +                qemu_log_mask(LOG_UNIMP,
    @@ target/hexagon/hexswi.c: static void sim_handle_trap0(CPUHexagonState *env)
     +            sys_stat.nlink = (uint32_t) st_buf.st_nlink;
     +            sys_stat.rdev  = st_buf.st_rdev;
     +            sys_stat.size  = (uint32_t) st_buf.st_size;
    ++#if defined(__linux__)
     +            sys_stat.atime = (uint32_t) st_buf.st_atim.tv_sec;
     +            sys_stat.mtime = (uint32_t) st_buf.st_mtim.tv_sec;
     +            sys_stat.ctime = (uint32_t) st_buf.st_ctim.tv_sec;
    ++#elif defined(_WIN32)
    ++            sys_stat.atime = st_buf.st_atime;
    ++            sys_stat.mtime = st_buf.st_mtime;
    ++            sys_stat.ctime = st_buf.st_ctime;
    ++#endif
     +        }
     +        hexagon_read_memory(env, swi_info + 4, 4, &statBufferAddr, retaddr);
     +
    @@ target/hexagon/hexswi.c: static void sim_handle_trap0(CPUHexagonState *env)
     +                      " is unimplemented in QEMU\n",
     +                      (uint32_t)what_swi);
     +        break;
    -+
    -+#endif /* ! _WIN32 */
      
          default:
              qemu_log_mask(LOG_GUEST_ERROR,
10:  a2e686ac0ba ! 11:  7fd1831acb4 target/hexagon: add COREDUMP semihosting operation
    @@
      ## Metadata ##
    -Author: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
    +Author: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
     
      ## Commit message ##
         target/hexagon: add COREDUMP semihosting operation
    @@ Commit message
         Implement the handler to decode the SSR cause field and
         print the full register file, matching hexagon-sim behavior.
     
    -    Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
    +    Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
         Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
    +    Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
     
      ## target/hexagon/internal.h ##
     @@ target/hexagon/internal.h: int hexagon_hvx_gdb_write_register(CPUState *env, uint8_t *mem_buf, int n);
11:  db95d3b7af7 <  -:  ----------- target/hexagon: add OPEN/READ/CLOSE_DIR semihosting operations
12:  60a8f2decf0 ! 12:  24731ad7a27 target/hexagon: Add an errno mapping
    @@ Commit message
         guest so that baremetal programs see the expected error codes.
     
         Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
    +    Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
         Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
     
      ## target/hexagon/hexswi.c ##
     @@ target/hexagon/hexswi.c: static void do_preload(CPUHexagonState *env, target_ulong swi_info, bool load)
    -     hexagon_touch_memory(env, addr, count, retaddr);
    +     hexagon_peek_memory_range(env, addr, count, retaddr);
      }
      
     +/* Hexagon semihosting errno values */
    @@ target/hexagon/hexswi.c: static void sim_handle_trap0(CPUHexagonState *env)
          }
          break;
      
    -@@ target/hexagon/hexswi.c: static void sim_handle_trap0(CPUHexagonState *env)
    -         } else {
    -             err = errno;
    -         }
    --        common_semi_cb(cs, rc, rc != 0 ? 0 : err);
    -+        semi_cb(cs, rc, rc != 0 ? 0 : err);
    -         break;
    -     }
    - 
    -@@ target/hexagon/hexswi.c: static void sim_handle_trap0(CPUHexagonState *env)
    -             }
    -             rc = guest_dir_entry;
    -         }
    --        common_semi_cb(cs, rc, err);
    -+        semi_cb(cs, rc, err);
    -         break;
    -     }
    - 
    -@@ target/hexagon/hexswi.c: static void sim_handle_trap0(CPUHexagonState *env)
    -         } else {
    -             err = EBADF;
    -         }
    --        common_semi_cb(cs, ret, ret == 0 ? 0 : err);
    -+        semi_cb(cs, ret, ret == 0 ? 0 : err);
    -         break;
    -     }
    - 
     @@ target/hexagon/hexswi.c: static void sim_handle_trap0(CPUHexagonState *env)
          case HEX_SYS_PROF_STATSRESET:
          case HEX_SYS_DUMP_PMU_STATS:
13:  c366abf8749 ! 13:  c16ea7a7e6c python/machine: support routing semihosting output to the test console
    @@ Commit message
         console.
     
         Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
    +    Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
         Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
     
      ## python/qemu/machine/machine.py ##
14:  da280da8fec ! 14:  87a6d2559c3 tests/functional: Add hexagon semihosting systests
    @@ Commit message
         tests/functional: Add hexagon semihosting systests
     
         Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
    +    Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
         Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
     
      ## tests/functional/hexagon/meson.build (new) ##
    @@ tests/functional/hexagon/test_systests.py (new)
     +#!/usr/bin/env python3
     +#
     +# Copyright(c) Qualcomm Innovation Center, Inc. All Rights Reserved.
    -+#
     +# SPDX-License-Identifier: GPL-2.0-or-later
     +
     +import os
    @@ tests/functional/hexagon/test_systests.py (new)
     +from qemu_test import QemuSystemTest, Asset, wait_for_console_pattern
     +
     +
    -+_TARBALL_BIN_PATH = os.path.join(
    ++_TARBALL_BIN_PATH = (
     +    "systests_standalone_package",
     +    "StandaloneSysTests_6.4.0.2_v68",
     +    "bin",
     +)
     +
    -+
     +class SysTestsStandaloneTests(QemuSystemTest):
     +    SYSTEST_TIMEOUT_SEC = 30
     +
     +    ASSET_TARBALL = Asset(
    -+        "https://github.com/qualcomm/qemu-hexagon-testing/releases/download/v0.2.9/systests_standalone.tar.gz",
    -+        "db961ea3fcc389b478b3d5c2f3bac60bec87e7f3d7efef5e58a9ae8ee78d0e40",
    ++        "https://github.com/qualcomm/qemu-hexagon-testing/releases/download/v0.2.11/systests_standalone.tar.gz",
    ++        "b5777aa65245de7710a7a08d717953c1362be7c8b60d9014c9fee8b17610ad1c",
     +    )
     +
     +    def setUp(self):
     +        super().setUp()
     +        self.archive_extract(self.ASSET_TARBALL)
    -+        self.bin_dir = os.path.join(self.workdir, _TARBALL_BIN_PATH)
    -+        self._orig_cwd = os.getcwd()
    -+        os.chdir(self.workdir)
    -+        self.addCleanup(os.chdir, self._orig_cwd)
    -+
    -+    def tearDown(self):
    -+        if hasattr(self, "_orig_cwd"):
    -+            os.chdir(self._orig_cwd)
    -+        super().tearDown()
     +
     +    def binary(self, name):
    -+        """Return the full path to binary *name* inside bin_dir."""
    -+        return os.path.join(self.bin_dir, name)
    ++        """Return the full path to binary *name* inside bin dir."""
    ++        path = self.scratch_file(*_TARBALL_BIN_PATH, name)
    ++        self.assertTrue(os.path.exists(path))
    ++        return path
     +
     +    def run_exit_zero(self, binary_name, *extra_args, machine="V66G_1024"):
     +        """Launch *binary_name* and assert it exits with code 0.
     +
    -+        :param binary_name: name of the binary inside bin_dir.
    ++        :param binary_name: name of the binary inside bin dir.
     +        :param extra_args: optional pairs of (flag, value) strings passed
     +            to set_vm_arg(), e.g. ('-append', 'myarg').
     +        :param machine: QEMU machine type (default "V66G_1024").
    @@ tests/functional/hexagon/test_systests.py (new)
     +                            machine="V66G_1024"):
     +        """Launch *binary_name* and wait for *pattern* on the semihosting console.
     +
    -+        :param binary_name: name of the binary inside bin_dir.
    ++        :param binary_name: name of the binary inside bin dir.
     +        :param pattern: string pattern to wait for via wait_for_console_pattern.
     +        :param extra_args: optional pairs of (flag, value) strings passed
     +            to set_vm_arg(), e.g. ('-append', 'myarg').
    @@ tests/functional/hexagon/test_systests.py (new)
     +
     +    def test_fopen(self):
     +        """fopen reads a file passed via --append and verifies its contents."""
    -+        with open(os.path.join(self.workdir, "dummy.so"), "w") as f:
    ++        import tempfile
    ++        # The fopen binary has a short cmdline buffer; use a short path.
    ++        dummy = os.path.join(tempfile.gettempdir(), "qemu_fopen_test.so")
    ++        with open(dummy, "w") as f:
     +            f.write("valid\n")
    -+        self.run_exit_zero("fopen", "-append", "dummy.so")
    ++        self.run_exit_zero("fopen", "-append", dummy)
     +
     +    def test_ftrunc(self):
     +        """ftrunc truncates _testfile_ftrunc from 6 bytes to 1 byte."""
    -+        ftrunc_path = os.path.join(self.workdir, "_testfile_ftrunc")
    ++        ftrunc_path = self.scratch_file("_testfile_ftrunc")
     +        with open(ftrunc_path, "w") as f:
     +            f.write("valid\n")
     +        # Sleep 1 s so mtime change is observable
     +        time.sleep(1)
    -+        self.run_exit_zero("ftrunc")
    -+        self.assertEqual(
    -+            os.path.getsize(ftrunc_path),
    -+            1,
    -+            "_testfile_ftrunc should be 1 byte after ftrunc",
    -+        )
    -+
    -+    def test_dirent(self):
    -+        """dirent lists a directory passed via --append; output must be
    -+        '. .. fileA fileB'."""
    -+        dirent_dir = os.path.join(self.workdir, "_dirent_testdir")
    -+        os.makedirs(dirent_dir, exist_ok=True)
    -+        open(os.path.join(dirent_dir, "fileA"), "w").close()
    -+        open(os.path.join(dirent_dir, "fileB"), "w").close()
    -+        self.run_console_pattern(
    -+            "dirent", ". .. fileA fileB", "-append", "_dirent_testdir"
    -+        )
    ++        self.run_exit_zero("ftrunc", "-append", ftrunc_path)
    ++        self.assertEqual(os.path.getsize(ftrunc_path), 1,
    ++                         "_testfile_ftrunc should be 1 byte after ftrunc")
     +
     +    def test_access(self):
     +        """access checks R_OK|W_OK on _testfile_access."""
    -+        with open(os.path.join(self.workdir, "_testfile_access"), "w") as f:
    ++        testfile = self.scratch_file("_testfile_access")
    ++        with open(testfile, "w") as f:
     +            f.write("valid\n")
    -+        self.run_exit_zero("access")
    ++        self.run_exit_zero("access", "-append", testfile)
     +
     +    def test_semihost(self):
    -+        semihost_dir = os.path.join(self.workdir, "_semihost_dir")
    -+        os.makedirs(semihost_dir, exist_ok=True)
    -+        open(os.path.join(semihost_dir, "fileA"), "w").close()
    -+        open(os.path.join(semihost_dir, "fileB"), "w").close()
     +        self.run_console_pattern("semihost", "PASS", "-append", "arg1", "arg2")
     +
     +if __name__ == "__main__":
-- 
2.37.2


