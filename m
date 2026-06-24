Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 366F4CD4F26
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 00:07:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcB8k-0007IY-9S; Tue, 23 Jun 2026 20:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcB8h-0007I4-A6
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 20:06:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcB8d-00039E-SH
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 20:06:47 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NJwjk63454634
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:06:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=z0wYUjNs0nPXvwo4X6dgB8
 Vx+ekdJ8W2ocH8eQEwVwI=; b=eQI8gf66lknUHFKIz69sk9ho6whOnIcyaMNAmJ
 OSFNk3re3w/3UAXUhEkhQQVLzHYju8rqQ/Vwqwjdj3K4QKufWKLNFsYoQ42XAMzr
 A/RA0Sjk973L+RUCyrARJ9Deq3SOLkaNDYh7GtuzJcJNjPjQV2G4YwmQU7klzVEp
 CfEELRGsrZfwQ3egScT1nAgU84/O6OALALscpyyx5M8hid3o6SbZKFnoEgRrmAN6
 ChQSh6H+BzXO1nREseonxeaRujhQiREvpn3Q06tw/mVMj42oEqU4eVG4v0xXEJA3
 nnmN7nVw+o+APzJUvU8+Dv7Tg/qcvLpjwXqqWdLkGvuP3OHA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyp1gur7a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:06:40 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51a0edd1d7fso7928951cf.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 17:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782259600; x=1782864400; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=z0wYUjNs0nPXvwo4X6dgB8Vx+ekdJ8W2ocH8eQEwVwI=;
 b=DLzXG7Bt5PNxIfuCQXZl4wBi3hiR88H/Vh3dZfwuOAah5C4zBlPkVXuD894tpvdAob
 txmOS3xZAUoLY79g23yNxEWt7JqZdSdTtzqSElFrWni5DuBrnO1TuW+oK8tEHAcs5qH0
 lf8HVqYVmGSvHzwxS8UdqcOErUNL8sNqwVYngEjO3+qzbnCfvw4rq48IkunbmBCAKLoX
 r6gXLVKxUluFNOKjjwlmx1B84QAcj+07uzCOABh4N9AIDTEwSXX7LKMGZX9eH73n7uZh
 YMZ/qLMY88rnX1so4RXsdxmeP67Usr7tBvqshP8DnW21pgWpMm3Fx+8wsSq7GVWaxjXq
 pjLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782259600; x=1782864400;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z0wYUjNs0nPXvwo4X6dgB8Vx+ekdJ8W2ocH8eQEwVwI=;
 b=McCnnNGc9suwWUzYXMfNj87U9vxNev5US+5vysxqctKk6h8NRZS3yhDLFSCTRW6iU1
 NZpm/reXaRTrY0QX42XhgGiATVSG88ljKo22W+6jkLsFTRqqcFaK+Raj8hpfC445Lw0r
 ShlEDLuwXo/ZfZ26ex5FE7oI7FOnns8EYmn5+K9t63ohOd3LrJ1JERsTLIVbKMSmAeSY
 oVO2XGqqexWqFNxIMay1w50qcAc2Xq12jMQ7+CcgSefbzPo+pNK14opQJiJQn9USopX6
 7HoTF3pUtlSjGcnY/+F15WtbZLKTGuUgtcNkUPy+IkmfClD+7f4sP1wenmcQ7bOxFrqc
 nt5Q==
X-Gm-Message-State: AOJu0YxYgPO6V1C1P3rN+47ldx6EigljXIi0y5v81/UGhu8WyNOrWPa3
 M1k+pxmBMVmsq3Nc6uf+mLl0zbSLN3cQEMuTQevbUzhuRwwav8XH9uKx7iezS86YAIitv0TpyB7
 qgxZ7Uk3SoKTiXWGXUz5JLN/lMpDFI5vWEEIjyPLNNTs7ztryT/NISiHwSlnL+Nwd1A==
X-Gm-Gg: AfdE7cmWfmgmUlXQKNOuv8X9uXcWN9CryH4chfHfU5tlDesbbriFcc6Ho1yHT4kddrW
 A71aXkdofOOco4d8bnMogmIuG9GwAQdHpf0O3hvkG/uF+rx0ArJ+fEEiyitPEEdlI74pOt0H9ku
 opQclhFdDYtCEFy7KJ+CjoQDL4oUN8hjvi9AEhjaKQHOzEm7XeVIloFKWsjDCaO4atVwiq20rn4
 nhaCaRCsznYwYLD92aPnBrGAEdRWroiF2Hl9JPsGJd7fbD1ey6HCKHt3A5i51xR3lAjCMfoxtAx
 s9KKZfZlz/Jp/IMbnFnVEw0w4IZm8jGbRfqXYxxvS4dpNJxDVCq9g07okOmqBt/leyIOka0u83y
 FVBWPEC+4fQnrFzqUe3qbogDPFGeIsQlGsv7HdDOsarvkDg==
X-Received: by 2002:a05:622a:116:b0:50d:66b6:1564 with SMTP id
 d75a77b69052e-51a61b28c2emr20191911cf.14.1782259599638; 
 Tue, 23 Jun 2026 17:06:39 -0700 (PDT)
X-Received: by 2002:a05:622a:116:b0:50d:66b6:1564 with SMTP id
 d75a77b69052e-51a61b28c2emr20191351cf.14.1782259598994; 
 Tue, 23 Jun 2026 17:06:38 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8df81cdec56sm142422976d6.32.2026.06.23.17.06.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 17:06:37 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 pierrick.bouvier@oss.qualcomm.com, philmd@oss.qualcomm.com,
 fritchleybohrer@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v2 00/24] target/riscv: move TCG files and fix --disable-tcg
Date: Tue, 23 Jun 2026 21:06:07 -0300
Message-ID: <20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=QJhYgALL c=1 sm=1 tr=0 ts=6a3b1f90 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Qhm3AQCK7GAS0wBZXmgA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: YRHX7WpO4WQmgdsBtx6SJ0XmQ8feZFBn
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE5OSBTYWx0ZWRfX41Tb7bz7uzBo
 lrMgB/n41HVN2jTzKwE/C3HUvUNmNCNQFjr3gKMjespEtaq9gO0lpBOxwfrYt78V8QwXAlnCJ+W
 fhvUWQgnLLw6a+UENYnlenO/8IXB2ks=
X-Proofpoint-ORIG-GUID: YRHX7WpO4WQmgdsBtx6SJ0XmQ8feZFBn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE5OSBTYWx0ZWRfX6kC802Pgp6KP
 ORhQPqRnORw6elaxbnpH/7sRi1E0QwOJpZOCTQO9fu5btQuYXwXl8j9MC1SGvotoMtfu46DWjAw
 y08TIMMZ/18d637whJSsD2nvia49zoxJnsps2zTCh2soGKJnXoUKREWcyjaM1PQAAL8W1UijA21
 UQT+umXOY+tEGbPOtqfWIj4okrE8rXdItvo+LzvpQ+icsd+GZ/yXbHJsC+Y/kZuaHY6+pYvG2sI
 mMvcyWJ2qL8vJEXrue5yic1S3yWUcpgIFMzFhiN78Iq0K3+zR4YO/AhMpbRg24LGpKiw0+PNQWf
 xotrsDxmkCmAsifU1ZgBDRwFUjLcpeL3+xijAF/tP3cMBEcxvE6Fzb0PuVzVKbanOhuI9uJFluS
 8BU/s7d5I5OZPNZMpZZEvSmeP2a4Uw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_04,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2606230199
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hello,

In this version we addressed the reviews from Phil and Richard from v1.
No other changes were made.

Patches are based on alistair riscv-to-apply.next tree.

It can also be fetched from this branch:

https://gitlab.com/danielhb/qemu/-/tree/riscv_disabletcg_v2


Changes from v1:
- patch 3:
  - changed pmp_needed return to "tcg_enabled() && cpu->cfg.pmp"
- patch 5:
  - reworded commit msg; implemented translate_for_debug
- patch 10:
  - added ifdefs around custom_csrs in cpu.h
- patch 11:
  - inlined riscv_cpu_set_rnmi()
- patch 16:
  - renamed riscv_set_irq() to riscv_accel_set_irq()
- patch 18:
  - gated csr_register_qtest_callback() with qtest_enabled()
- v1 link: https://lore.kernel.org/qemu-devel/20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com/



Daniel Henrique Barboza (22):
  target/riscv: move TCG only files to tcg subdir
  target/riscv/machine.c: do not migrate pmp state with kvm
  target/riscv: move pmp files to tcg subdir
  target/riscv: tidy up riscv_sysemu_ops
  target/riscv: move pmu.h to tcg subdir
  target/riscv: move debug.h to tcg subdir
  target/riscv: remove csr.h from kvm-cpu.c
  target/riscv: move csr.h to tcg subdir
  target/riscv: move custom_csrs logic to tcg-cpu.c
  target/riscv: move riscv_cpu_set_nmi() to tcg-cpu.c
  target/riscv: move valid_vm_* satp arrays to cpu.c
  target/riscv: move some irq helpers to cpu.c
  target/riscv: move riscv_cpu_claim_interrupts to cpu.c
  target/riscv/cpu.c: handle TCG bits of riscv_cpu_dump_state
  target/riscv: gate riscv_cpu_update_mip with tcg_enabled()
  target/riscv/cpu.c: filter TCG only bits in riscv_cpu_reset_hold()
  hw/riscv/riscv_hart.c isolate tcg only bits
  target/riscv/gdbstub.c: isolate TCG only checks
  target/riscv: move riscv_cpu_set_rdtime_fn to riscv_aclint
  target/riscv/tcg: remove unused riscv_cpu_get_geilen()
  target/riscv: move riscv_cpu_set_geilen() to riscv-imsic
  target/riscv: move riscv_cpu_set_aia_ireg_rmw_cb() to riscv_imsic

Zephyr Li (2):
  target/riscv: Remove unused tcg/tcg.h include
  gitlab-ci.d/crossbuilds: add riscv64 KVM-only build job

 .gitlab-ci.d/crossbuilds.yml                  |   8 +
 hw/intc/riscv_aclint.c                        |   8 +
 hw/intc/riscv_imsic.c                         |  24 ++
 hw/riscv/fdt-common.c                         |  52 +++
 hw/riscv/riscv_hart.c                         |   8 +-
 hw/riscv/virt.c                               |   1 -
 include/hw/riscv/fdt-common.h                 |   1 +
 target/riscv/cpu.c                            | 318 +++++++++++++++---
 target/riscv/cpu.h                            |  24 +-
 target/riscv/gdbstub.c                        |  10 +-
 target/riscv/kvm/kvm-cpu.c                    |   1 -
 target/riscv/machine.c                        |  17 +-
 target/riscv/meson.build                      |  17 -
 target/riscv/monitor.c                        |   4 +-
 target/riscv/riscv-qmp-cmds.c                 |   2 +-
 target/riscv/{ => tcg}/bitmanip_helper.c      |   0
 target/riscv/{ => tcg}/cpu_helper.c           | 253 +-------------
 target/riscv/{ => tcg}/crypto_helper.c        |   0
 target/riscv/{ => tcg}/csr.c                  |  45 +--
 target/riscv/{ => tcg}/csr.h                  |   6 +-
 target/riscv/{ => tcg}/debug.c                |   2 +-
 target/riscv/{ => tcg}/debug.h                |   0
 target/riscv/{ => tcg}/fpu_helper.c           |   0
 .../insn_trans/trans_privileged.c.inc         |   0
 .../{ => tcg}/insn_trans/trans_rva.c.inc      |   0
 .../{ => tcg}/insn_trans/trans_rvb.c.inc      |   0
 .../{ => tcg}/insn_trans/trans_rvbf16.c.inc   |   0
 .../{ => tcg}/insn_trans/trans_rvd.c.inc      |   0
 .../{ => tcg}/insn_trans/trans_rvf.c.inc      |   0
 .../{ => tcg}/insn_trans/trans_rvh.c.inc      |   0
 .../{ => tcg}/insn_trans/trans_rvi.c.inc      |   0
 .../{ => tcg}/insn_trans/trans_rvk.c.inc      |   0
 .../{ => tcg}/insn_trans/trans_rvm.c.inc      |   0
 .../{ => tcg}/insn_trans/trans_rvv.c.inc      |   0
 .../{ => tcg}/insn_trans/trans_rvvk.c.inc     |   0
 .../{ => tcg}/insn_trans/trans_rvzabha.c.inc  |   0
 .../{ => tcg}/insn_trans/trans_rvzacas.c.inc  |   0
 .../{ => tcg}/insn_trans/trans_rvzalasr.c.inc |   0
 .../{ => tcg}/insn_trans/trans_rvzawrs.c.inc  |   0
 .../{ => tcg}/insn_trans/trans_rvzce.c.inc    |   0
 .../{ => tcg}/insn_trans/trans_rvzcmop.c.inc  |   0
 .../{ => tcg}/insn_trans/trans_rvzfa.c.inc    |   0
 .../{ => tcg}/insn_trans/trans_rvzfh.c.inc    |   0
 .../{ => tcg}/insn_trans/trans_rvzicbo.c.inc  |   0
 .../insn_trans/trans_rvzicfiss.c.inc          |   0
 .../{ => tcg}/insn_trans/trans_rvzicond.c.inc |   0
 .../{ => tcg}/insn_trans/trans_rvzimop.c.inc  |   0
 .../{ => tcg}/insn_trans/trans_svinval.c.inc  |   0
 .../{ => tcg}/insn_trans/trans_xlrbr.c.inc    |   0
 .../{ => tcg}/insn_trans/trans_xmips.c.inc    |   0
 .../{ => tcg}/insn_trans/trans_xthead.c.inc   |   0
 .../insn_trans/trans_xventanacondops.c.inc    |   0
 .../{ => tcg}/insn_trans/trans_zilsd.c.inc    |   0
 target/riscv/{ => tcg}/m128_helper.c          |   0
 target/riscv/tcg/meson.build                  |  31 +-
 target/riscv/{ => tcg}/mips_csr.c             |   2 +-
 target/riscv/{ => tcg}/op_helper.c            |   2 +-
 target/riscv/{ => tcg}/pmp.c                  |   2 +-
 target/riscv/{ => tcg}/pmp.h                  |   0
 target/riscv/{ => tcg}/pmu.c                  |  52 ---
 target/riscv/{ => tcg}/pmu.h                  |   1 -
 target/riscv/tcg/tcg-cpu.c                    |  30 +-
 target/riscv/{ => tcg}/th_csr.c               |   2 +-
 target/riscv/{ => tcg}/translate.c            |   0
 target/riscv/{ => tcg}/vcrypto_helper.c       |   0
 target/riscv/{ => tcg}/vector_helper.c        |   0
 target/riscv/{ => tcg}/vector_internals.c     |   0
 target/riscv/{ => tcg}/vector_internals.h     |   0
 target/riscv/{ => tcg}/zce_helper.c           |   0
 target/riscv/time_helper.c                    |  33 +-
 70 files changed, 515 insertions(+), 441 deletions(-)
 rename target/riscv/{ => tcg}/bitmanip_helper.c (100%)
 rename target/riscv/{ => tcg}/cpu_helper.c (91%)
 rename target/riscv/{ => tcg}/crypto_helper.c (100%)
 rename target/riscv/{ => tcg}/csr.c (99%)
 rename target/riscv/{ => tcg}/csr.h (96%)
 rename target/riscv/{ => tcg}/debug.c (99%)
 rename target/riscv/{ => tcg}/debug.h (100%)
 rename target/riscv/{ => tcg}/fpu_helper.c (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_privileged.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rva.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvb.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvbf16.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvd.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvf.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvh.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvi.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvk.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvm.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvv.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvvk.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvzabha.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvzacas.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvzalasr.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvzawrs.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvzce.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvzcmop.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvzfa.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvzfh.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvzicbo.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvzicfiss.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvzicond.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvzimop.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_svinval.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_xlrbr.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_xmips.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_xthead.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_xventanacondops.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_zilsd.c.inc (100%)
 rename target/riscv/{ => tcg}/m128_helper.c (100%)
 rename target/riscv/{ => tcg}/mips_csr.c (99%)
 rename target/riscv/{ => tcg}/op_helper.c (99%)
 rename target/riscv/{ => tcg}/pmp.c (99%)
 rename target/riscv/{ => tcg}/pmp.h (100%)
 rename target/riscv/{ => tcg}/pmu.c (86%)
 rename target/riscv/{ => tcg}/pmu.h (95%)
 rename target/riscv/{ => tcg}/th_csr.c (99%)
 rename target/riscv/{ => tcg}/translate.c (100%)
 rename target/riscv/{ => tcg}/vcrypto_helper.c (100%)
 rename target/riscv/{ => tcg}/vector_helper.c (100%)
 rename target/riscv/{ => tcg}/vector_internals.c (100%)
 rename target/riscv/{ => tcg}/vector_internals.h (100%)
 rename target/riscv/{ => tcg}/zce_helper.c (100%)

-- 
2.43.0


