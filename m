Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECB07C624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:40:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24rC-0004Qg-QK; Thu, 03 Sep 2026 06:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24rA-0004QP-SO
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:39:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24r8-00067Q-6x
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:39:44 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AH9Gu3203924
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 10:39:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=CKxq1rET0GuCy8dq+5sLZ5
 jwOamRrLdmj2o2p+K8Low=; b=XAf1D4aOMeOr2y3AbpaUDVDd1Nz76Aua1bxFFc
 BNF7kDXFA1V9ymOJriHb3Td/Tb4uKCZYRaMhESiwu8FzEiJedeSJ99IvcNFrqRgi
 kSG+Vzmsxp7RgwuJf6eSYKvun30D6gjTP6Fhcg/uIon/vTEzP0inkx9T5wbj+Gem
 CKGmI9rZz4KDSYcHJtwEPszgT/WDL1S+gXfrPIaZngfxxsQTheQ6xEYHFuGvN0hf
 L3L3m9nwNI15f0PDwiHTxUr7aSYAN8IW1DJ6aOr29YTGz+e/nRErLoIK6DlXJHu6
 rHH3X9ICiSywHYRhtGax8bo24zC6VXZ1d8SJTcb6VEn8nHdg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf5d10h51-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:39:39 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e62e3459fso392401485a.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788431979; x=1789036779; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=CKxq1rET0GuCy8dq+5sLZ5jwOamRrLdmj2o2p+K8Low=;
 b=gorQEy663WvshnPRbXXqbQTvWbq0WIMnRa9S+hZB1LQ22SDkhmlT5mai2uOxuVYLkA
 8h5rdy7xrqYzDCuFUJ3/Q1+CPuTlN2e18DkmGKKndWU70IR79nojIFKa+MTqKxt9jSbg
 AVZzm1f0j7jkWNENj1+nLmf1qqMwrz3D4X7x+2mpXqCfmL4hyOo1rzBlXbXx63XXQWCv
 T0nT8veMZuL5NBx0SPKvebQBWVUvTdKePL40Gnh8J0CfxtPg2OvwVEmW+siKK+YAea04
 VlHojMcahrz6Tc81qPopr+ruL3tflgOcsC+c68bffdH29xj/6f3aFMv6xScFgV4WSXkY
 +OlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788431979; x=1789036779;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CKxq1rET0GuCy8dq+5sLZ5jwOamRrLdmj2o2p+K8Low=;
 b=k5EhBXzOJdv7N55GYc31L/cCWoczxEWfzQNPsxdjEGcSXVuHu+abCAqmQcpI+02D/k
 TatQu/C9GPSok0Vefa5/15N9zphUBZfs7buC6TbKhfpcsbIXJ3bLaHCnGI72BXeKXGKv
 aZ3KJtHHx8FyAthYiWqFvowlI0ObnIOzzqofSoF0A78oyfqXdfEmXu3yHSZpy20trkQa
 S4fGq9Y8Ugj0VI0mOFX20KeEoWd2pvhg7yVqauCIOMj3m87HfG/R09YiU3e+nBzi02no
 ihw7fsxYQbJCGBYYaqYyfZ3tIWKt/oYxQI317gRKKG9HxDPk86I0vXSXqP/C2+/9tRHO
 dWUQ==
X-Gm-Message-State: AFuF++mAx87M6EY6fSI1tPS50jNaxy5ko4E/bEd941kchinNBZxQH4ts
 FvNMovJ3LlCzRFbV2j2LLr0AZHekUwRqTkO42AIKVYRhfjaKz7FXu3oRRZhSGvAonyQGy4ruJm6
 peCKR66Otnmfv/OyIdvfkTMzouzVb9L7rTzk5LR9nyp+lDrETTe79NSHzpkNEzyJ/AQ==
X-Gm-Gg: AYBFou3ig9mVMKz5wehcRoN+YqSeGmmQSPQEmXW4O61LW/3nyyin9aud5hUcD84JZ45
 +PkjvMDvmmohaM6dh5EAaP1aRMv339UWOeoBTaxJMIcVdT9WhbsoNiQPrLex9L4++4Zs/xZwXg0
 sWtc/YPVDfzX/hF2gCmTt2NflcKDh3KDdxILrZKh+4ifAfY+2hAr9LeyyPbdyD3Xtx4h9LM4LSh
 tqiU4fXv9E5YB+MTV1j7evoH53GYfOM4jIv7vSb8Pf079+NJ+HLenGPgQFuFLHCF4YhkTgnC7nl
 rtNdytprgt9uZ33vVUTx4m/r/RF46E+7DD52Rp1Fup2GiSzlEzhozPi65QP5YZy0vVAysfMNtg2
 27xvzRRBDfPbtWrCpq65jkTqJBMqT6F7Vu5kwDU5p
X-Received: by 2002:a05:620a:708e:b0:939:4b31:4669 with SMTP id
 af79cd13be357-93960f81df8mr1069912385a.29.1788431978733; 
 Thu, 03 Sep 2026 03:39:38 -0700 (PDT)
X-Received: by 2002:a05:620a:708e:b0:939:4b31:4669 with SMTP id
 af79cd13be357-93960f81df8mr1069909185a.29.1788431978061; 
 Thu, 03 Sep 2026 03:39:38 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5d1fe2sm69730195e9.3.2026.09.03.03.39.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Sep 2026 03:39:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/51] Misc HW/accel patches for 2026-09-03
Date: Thu,  3 Sep 2026 12:38:44 +0200
Message-ID: <20260903103936.62355-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX49IT2SGUqrQF
 FWxqM4RcvjMreOur184CGl1sijbPUvvCqvjoKLRZzxg7sLC01UAFIUxdq4T4vgNpPWT8e75mQJd
 LIa9CbXKvuNjSFQQASwsxoWOWItaVnAV8TjdGsrpIfXSJ51KpwzinnytRTQkOVTxRzzRRUq8j9x
 glSNKHGJdbXs5eAKIKfOmR6glaT3Zx9IuRRb4EY+W5bEhm7GKk5i6sOQX1JnZdjdvTNsKpAGwkQ
 76yKSATUjdGwdyb1J+hEz96YAs5px2jixApAwh3gmPJrGGgcJbSaMPtQcsokyBY+DDw1LfQhDRZ
 3sSkGneo2rPHYXP1nU3aCPMjaE1kAv+d3ZTRv5P/zxt8seFGfTmYzos02AnFSOKFXm6Aoq9lEQi
 BHR6pO1NHw2utnoXp/J+t5GAnnf0i71Iicmrg34TwbQhwa4qxk/Ghmj6dhGEQsHtp62jXfu0ag6
 Rxs7RxSdS+B6gd2gcNw==
X-Proofpoint-ORIG-GUID: CWQe3jdTQYVYaC8pgt7nYY4-VRReJ675
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX2tONFIFUAEBq
 MAQ60aU6G/WmOFU/vwkbZ3K/Er5IEE8bmMoBAr1iPKVr63tZJaG6Kq7Vgu8CopuaEN81fxVXebs
 uNKHOCvgO9udCLwMheSrC9amNgTNVF4=
X-Proofpoint-GUID: CWQe3jdTQYVYaC8pgt7nYY4-VRReJ675
X-Authority-Analysis: v=2.4 cv=J4GaKgnS c=1 sm=1 tr=0 ts=6a994e6b cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=NEAV23lmAAAA:8 a=RJ9bciaDsgv_ITx_-q8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030092
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

The following changes since commit c513597761d6fc06690b5b7cf10dfb7ab05815d0:

  Merge tag 'pull-hex-20260901' of https://github.com/qualcomm/qemu into staging (2026-09-02 17:59:30 +0100)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20260903

for you to fetch changes up to 94651820173214b3e012cd7e0a69ccff0ab196db:

  MAINTAINERS: Update PhilMD's email address (2026-09-03 12:22:32 +0200)

----------------------------------------------------------------
Misc HW and accel patch queue

- MAINTAINERS updates
- Add const qualifiers to CPU state accessors on various targets
- Improve KVM/ARM error handling
- Restrict TCG HALTED handling to system emulation
- Introduce TypeInfo::is_available callback, remove arm/riscv machines filtering
- Parallel NOR flash: Fix ROMD mode on Intel, add migrations support on AMD
- SD/SDHCI Controller Fixes

Following checkpatch.pl warnings / errors deliberately ignored:

WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
  include/hw/arm/machines-qom.h

WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
  include/hw/riscv/machines-qom.h

WARNING: line over 80 characters
#113: FILE: hw/block/pflash_cfi02.c:1074:
+        pfl->vmstate = qemu_add_vm_change_state_handler(postload_update_cb, pfl);

ERROR: spaces required around that ':' (ctx:OxE)
#63: FILE: include/exec/cpu-common.h:89:
+            CPUArchState *: \
                           ^

ERROR: spaces required around that ':' (ctx:OxE)
#65: FILE: include/exec/cpu-common.h:91:
+            const CPUArchState *: \
                                 ^

ERROR: spaces required around that ':' (ctx:OxE)
#79: FILE: include/exec/cpu-common.h:101:
+            CPUArchState *: \
                           ^

ERROR: spaces required around that ':' (ctx:OxE)
#81: FILE: include/exec/cpu-common.h:103:
+            const CPUArchState *: \
                                 ^

ERROR: spaces required around that ':' (ctx:OxE)
#107: FILE: include/hw/core/cpu.h:605:
+    CPUState *: \
               ^

ERROR: spaces required around that ':' (ctx:OxE)
#109: FILE: include/hw/core/cpu.h:607:
+    const CPUState *: \
                     ^
----------------------------------------------------------------

Alberto Garcia (1):
  hw/sd/sdcard: Register device ops in drives without media

Bin Meng (7):
  hw/sd: sdhci: Migrate the Host Control 2 register
  hw/sd: sdhci: Accept version 4 enable without UHS-I
  hw/sd: sdhci: Factor sdhci_advance_sdma_address() helper out
  hw/sd: sdhci: Factor sdhci_sdma_address() helper out
  hw/sd: sdhci: Use version 4 system address for SDMA
  hw/sd: sdhci: Support version 4 ADMA 64-bit addressing
  hw/sd: sdhci: Resume version 4 SDMA at buffer boundaries

Daniel P. Berrangé (1):
  system: improve -mon deprecation warning

Denis V. Lunev (1):
  hw/sd: give the RPMB vmstate subsection a name of its own

Jean-Philippe Brucker (1):
  target/arm: Return immediately on error in kvm_arch_init()

Junjie Cao (1):
  hw/cxl: fix timer leak in cxl_destroy_cci()

Kuan-Jui Chiu (1):
  hw/sd/axiado_sdhci: Add header guard

Om Barkare (1):
  hw/block/pflash_cfi02: Add migration support

Paolo Bonzini (1):
  rustfmt: disable wrap_comments

Peter Maydell (1):
  hw/block/pflash_cfi01: Always set romd mode when clearing wcycle and
    cmd

Philippe Mathieu-Daudé (21):
  MAINTAINERS: Cover pflash QTest in pflash section
  accel/tcg: Rename for exception codes named @ret as @excp
  accel/tcg: Restrict EXCP_HALTED handling to system emulation
  accel/tcg: Check %halted field in cpu_handle_halt() caller
  target/i386: Remove const qualifier in ptw_setl*()
  linux-user: Uncast void pointer argument as Object in
    target_cpu_free()
  cpus: Add const-qualified CPU environment accessors
  linux-user: Replace env_cpu_const() by generic env_cpu() equivalent
  system/cpus: Constify various CPUState arguments
  target/avr: Constify CPUAVRState for some cpu_*() getters
  target/hexagon: Constify CPUHexagonState in
    hexagon_thread_is_enabled()
  target/i386: Constify CPU*State for cpu_*_interrupt() getters
  target/loongarch: Constify LoongArchTLB
  target/mips: Constify CPUMIPSState for various cpu_*() getters
  target/s390x: Constify S390CPU for cpu_has_*() getters
  target/riscv: Constify @iprio argument in riscv_cpu_pending_to_irq()
  target/sparc: Constify CPUSPARCState for various cpu_*() getters
  target/tricore: Document architectural interrupts as not implemented
  target/xtensa: Constify CPUXtensaState in
    xtensa_replicate_windowstart()
  MAINTAINERS: Stop reviewing meson-related patches
  MAINTAINERS: Update PhilMD's email address

Pierrick Bouvier (12):
  qom/object: add is_available callback to TypeInfo
  hw/arm: filter minimal set of machines
  system: query machines using TYPE_MACHINE
  target-info: remove machine_typename
  hw/arm: remove TYPE_TARGET_{AARCH64,ARM}_MACHINE
  hw/arm: remove {arm, arm_aarch64, aarch64}_machine_interfaces
  hw/arm: remove DEFINE_MACHINE_{AARCH64,ARM}
  hw/arm: remove machines-qom.h
  hw/riscv: remove TYPE_TARGET_{RISCV32,RISCV64}_MACHINE
  hw/riscv: remove {riscv32, riscv32_64, riscv64}_machine_interfaces
  hw/riscv: remove DEFINE_MACHINE_{RISCV32,RISCV64}
  hw/riscv: remove machines-qom.h

Tao Ding (2):
  hw/sd: sdhci: Fix SDMA boundary bug
  qtest: add xilinx-zynq SDHCI sdma test

 MAINTAINERS                               |  59 +++---
 hw/sd/sdhci-internal.h                    |   1 +
 include/exec/cpu-common.h                 |  29 ++-
 include/hw/arm/machines-qom.h             |  46 -----
 include/hw/core/cpu.h                     |  21 ++-
 include/hw/riscv/machines-qom.h           |  46 -----
 include/hw/sd/axiado_sdhci.h              |   5 +
 include/hw/sd/sdhci.h                     |   2 +
 include/qemu/target-info-impl.h           |   2 -
 include/qemu/target-info.h                |   8 -
 include/qom/object.h                      |   3 +
 include/system/cpus.h                     |   4 +-
 target/avr/cpu.h                          |   6 +-
 target/hexagon/cpu.h                      |   2 +-
 target/hexagon/cpu_helper.h               |   4 +-
 target/i386/cpu.h                         |   4 +-
 target/mips/cpu.h                         |   8 +-
 target/mips/internal.h                    |  10 +-
 target/riscv/cpu.h                        |   2 +-
 target/s390x/cpu.h                        |   2 +-
 target/s390x/s390x-internal.h             |  12 +-
 target/sparc/cpu.h                        |  12 +-
 target/xtensa/cpu.h                       |   2 +-
 accel/tcg/cpu-exec.c                      |  51 +++---
 accel/tcg/tcg-accel-ops-mttcg.c           |   7 +-
 accel/tcg/tcg-accel-ops-rr.c              |   8 +-
 accel/tcg/tcg-accel-ops.c                 |   7 +-
 configs/targets/aarch64-softmmu.c         |   2 -
 configs/targets/arm-softmmu.c             |   2 -
 configs/targets/riscv32-softmmu.c         |   2 -
 configs/targets/riscv64-softmmu.c         |   2 -
 hw/arm/aspeed.c                           |   1 -
 hw/arm/aspeed_ast1040_evb.c               |   2 -
 hw/arm/aspeed_ast10x0_evb.c               |   3 -
 hw/arm/aspeed_ast2400_palmetto.c          |   2 -
 hw/arm/aspeed_ast2400_quanta-q71l.c       |   2 -
 hw/arm/aspeed_ast2400_supermicrox11.c     |   2 -
 hw/arm/aspeed_ast2500_evb.c               |   2 -
 hw/arm/aspeed_ast2500_g220a.c             |   2 -
 hw/arm/aspeed_ast2500_romulus.c           |   2 -
 hw/arm/aspeed_ast2500_supermicro-x11spi.c |   2 -
 hw/arm/aspeed_ast2500_tiogapass.c         |   2 -
 hw/arm/aspeed_ast2500_witherspoon.c       |   2 -
 hw/arm/aspeed_ast2500_yosemitev2.c        |   2 -
 hw/arm/aspeed_ast2600_anacapa.c           |   2 -
 hw/arm/aspeed_ast2600_bletchley.c         |   2 -
 hw/arm/aspeed_ast2600_catalina.c          |   2 -
 hw/arm/aspeed_ast2600_evb.c               |   2 -
 hw/arm/aspeed_ast2600_fby35.c             |   2 -
 hw/arm/aspeed_ast2600_fuji.c              |   2 -
 hw/arm/aspeed_ast2600_gb200nvl.c          |   2 -
 hw/arm/aspeed_ast2600_rainier.c           |   2 -
 hw/arm/aspeed_ast27x0-fc.c                |   3 +-
 hw/arm/aspeed_ast27x0_evb.c               |   5 +-
 hw/arm/ax3000-boards.c                    |   2 -
 hw/arm/b-l475e-iot01a.c                   |   2 -
 hw/arm/bananapi_m2u.c                     |   3 +-
 hw/arm/collie.c                           |   2 -
 hw/arm/cubieboard.c                       |   3 +-
 hw/arm/digic_boards.c                     |   3 +-
 hw/arm/exynos4_boards.c                   |   3 -
 hw/arm/imx25_pdk.c                        |   3 +-
 hw/arm/imx8mm-evk.c                       |   3 +-
 hw/arm/imx8mp-evk.c                       |   2 -
 hw/arm/integratorcp.c                     |   3 +-
 hw/arm/kzm.c                              |   3 +-
 hw/arm/max78000fthr.c                     |   3 +-
 hw/arm/mcimx6ul-evk.c                     |   3 +-
 hw/arm/mcimx7d-sabre.c                    |   3 +-
 hw/arm/microbit.c                         |   2 -
 hw/arm/mps2-tz.c                          |   6 -
 hw/arm/mps2.c                             |   5 -
 hw/arm/mps3r.c                            |   2 -
 hw/arm/msf2-som.c                         |   3 +-
 hw/arm/musca.c                            |   3 -
 hw/arm/netduino2.c                        |   3 +-
 hw/arm/netduinoplus2.c                    |   3 +-
 hw/arm/npcm7xx_boards.c                   |   6 -
 hw/arm/npcm8xx_boards.c                   |   2 -
 hw/arm/olimex-stm32-h405.c                |   3 +-
 hw/arm/omap_sx1.c                         |   3 -
 hw/arm/orangepi.c                         |   3 +-
 hw/arm/raspi.c                            |   8 +-
 hw/arm/raspi4b.c                          |   3 +-
 hw/arm/realview.c                         |   5 -
 hw/arm/sabrelite.c                        |   2 -
 hw/arm/sbsa-ref.c                         |   2 -
 hw/arm/stellaris.c                        |   3 -
 hw/arm/stm32vldiscovery.c                 |   3 +-
 hw/arm/versatilepb.c                      |   3 -
 hw/arm/vexpress.c                         |   3 -
 hw/arm/virt.c                             |   2 -
 hw/arm/xen-pvh.c                          |   2 -
 hw/arm/xilinx_zynq.c                      |   2 -
 hw/arm/xlnx-versal-virt.c                 |   3 -
 hw/arm/xlnx-zcu102.c                      |   2 -
 hw/block/pflash_cfi01.c                   |  31 ++--
 hw/block/pflash_cfi02.c                   |  52 +++++-
 hw/core/machine-qmp-cmds.c                |   2 +-
 hw/core/null-machine.c                    |   9 +-
 hw/cxl/cxl-mailbox-utils.c                |   2 +
 hw/nitro/machine.c                        |   6 -
 hw/remote/machine.c                       |   3 -
 hw/riscv/boston-aia.c                     |   3 +-
 hw/riscv/k230.c                           |   2 -
 hw/riscv/microblaze-v-generic.c           |   3 +-
 hw/riscv/microchip_pfsoc.c                |   2 -
 hw/riscv/opentitan.c                      |   2 -
 hw/riscv/shakti_c.c                       |   2 -
 hw/riscv/sifive_e.c                       |   2 -
 hw/riscv/sifive_u.c                       |   2 -
 hw/riscv/spike.c                          |   2 -
 hw/riscv/tt_atlantis.c                    |   2 -
 hw/riscv/virt.c                           |   3 -
 hw/riscv/xiangshan_kmh.c                  |   2 -
 hw/sd/sd.c                                |  49 +++--
 hw/sd/sdhci.c                             | 208 +++++++++++++++++++---
 linux-user/elfload.c                      |   2 +-
 linux-user/i386/cpu_loop.c                |   5 +-
 linux-user/i386/elfload.c                 |   2 +-
 linux-user/x86_64/elfload.c               |   2 +-
 monitor/qemu-config-qmp.c                 |   2 +-
 qom/object.c                              |   4 +
 system/cpus.c                             |   6 +-
 system/vl.c                               |  14 +-
 target-info-qom.c                         |  23 ---
 target-info-stub.c                        |   1 -
 target-info.c                             |   5 -
 target/arm/kvm.c                          |   9 +-
 target/arm/machine.c                      |  18 --
 target/hexagon/cpu.c                      |   4 +-
 target/hexagon/cpu_helper.c               |   6 +-
 target/i386/cpu.c                         |   5 +-
 target/i386/tcg/system/excp_helper.c      |   4 +-
 target/loongarch/tcg/tlb_helper.c         |  16 +-
 target/riscv/cpu.c                        |   2 +-
 target/riscv/machine.c                    |  17 --
 target/s390x/interrupt.c                  |  22 +--
 target/tricore/cpu.c                      |   1 +
 tests/qtest/xilinx-zynq-sdhci-test.c      | 185 +++++++++++++++++++
 .mailmap                                  |   9 +-
 rust/qom/src/qom.rs                       |   1 +
 rust/rustfmt.toml                         |   2 +-
 tests/qtest/meson.build                   |   1 +
 144 files changed, 694 insertions(+), 612 deletions(-)
 delete mode 100644 include/hw/arm/machines-qom.h
 delete mode 100644 include/hw/riscv/machines-qom.h
 create mode 100644 tests/qtest/xilinx-zynq-sdhci-test.c

-- 
2.53.0


