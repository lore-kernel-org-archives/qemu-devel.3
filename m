Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC85C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:52:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfHpN-0001WE-21; Thu, 02 Jul 2026 09:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHpL-0001VZ-Ji
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:51:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHpJ-0007uS-AI
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:51:39 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662D0ZVi417183
 for <qemu-devel@nongnu.org>; Thu, 2 Jul 2026 13:51:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=LPH5MnBwkpml7nFlM8kpO5
 YP50zMMUeNqtfcmuaJPMQ=; b=nIATx8i4FKyT9XSu771Pwz+5aATpFELgx/fR2r
 tGS0PrabRPzRb88DHKR549c4jGClxEv5sY09HpDMB2XQLoYdxAQzajSn+JDHDQol
 WshpnaPq+9RxH4aK6quvnUtj5IREFXFBgisqh25Q1WNjsAEYB8M7DR188Yr0NKqo
 YwPGpmcD+L5tS8J2kNaWbykw8nmTRCbXuQluLZ8peDN9BGxXWzH8UlJzuDGLLzCg
 AM1iGzXmYuu0WAHZ7Y2Ws1kayxhOipyymvAbQnIUzeHT7Gz0Zz7box5HwpgFEHfE
 97Msvh0jG2EFXBT/5J/EKqUS7dW5PxJh14tompoz/dKxUrDw==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5n9bh1ag-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 13:51:35 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-96925b219aeso270555241.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 06:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783000294; x=1783605094; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LPH5MnBwkpml7nFlM8kpO5YP50zMMUeNqtfcmuaJPMQ=;
 b=T+hrEZMhzSo5nExJomiHUKr8JEPxR2YuUMyxht3t7B7LxKWumu5XEUixKKtcFeUqGS
 9auR8m9vJqf/NsvlWLI8ZWCT6Q206QY9HcuU9ZI+dgI2UE/qYbK7nXk2bZFyFVJraWro
 Rk1KMFb9Zx/QPVx6ZMWwhA0kh/ye+uxZMb9v9zMpsqx+W7k1+dG4W0b7pgYfV/R7pMWF
 qKy8ZXRGWRNISg8PSXhMD+Nf6PVq/wkYpkpkZfnEa5cFprRPGz8xtae6gxdoXo40wKH9
 /TH0MSTGhFVjkiXW78tOP9gFSrIrf/AHRJPgX/CwBIArAzYWRBYocDPnQRkl+tw0QaMI
 1AbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783000294; x=1783605094;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LPH5MnBwkpml7nFlM8kpO5YP50zMMUeNqtfcmuaJPMQ=;
 b=J6dnEl1B0V7m+4nirDSDnlANQh0sSnS3+TFOmHqjvNN+Aj3OvFlGr1rFrqvXZwZWJq
 iRG9i5ZiXV5qkfeBbDrufkSKMehh0hjepFPOiud7kwO22oDJm8SDp8VZPZRPQ3yD4+/y
 xuVBdX+nBxMZ54q+jh76z5nJ5gc9JsEJkbq2kUwGtpTvaE0C8A7KNo/vVJ+7hWRiESZu
 8DVG7wB9rFHhzf32lhAH1DIhOAeNYuTNXTrrswXN0oh5ZqdigCy3Jj3ta6VeZUupgPPl
 Q3ZYCBYDzvnNeZeWdh2NmFU9OoE3NZ8x1YRlKtgwieCYMGXHDsXmDK7Pj2HO6aam5E8s
 WulA==
X-Gm-Message-State: AOJu0Yxn8jVPYmqhtIRCMTpC6GOeqdLmrkaLoE1cnF7hhPAwCwEResQN
 oWjYppe7x0X/vqHrJaCR0ABoYEB8jeUSdpniqxxF7Bg7ivNSx/uSrgOB+prdx3TwtXPeBSLQxhq
 6hy+iqsOr6gxB6TH26QPRaAoDmfgypjwXxX3YG8XMUuDo0XRgoHpeMT6iw4f2Mghtcg==
X-Gm-Gg: AfdE7ckUxEu7BS33i+Zf0/A+o9fAyS8azkb8qXqw7ugNJDCoKNjN44Z268ucJ04DT18
 0gripsF1NSb4JzUJdjDoW+1wX0bHw4gnKwJa2omBHPJfE/0Fav+D2sVAJ3AQzxcawTtjinm0ZtJ
 xl4usqQUe7LDmqsXodYVHKJzTY8+i9+fczpx2tj8WWaN8LATBEAGBG3qx3AfyuOopbWyBD3Bm4W
 LtY2+w70JFFh8GMxPL8JCdI3GZAWfTJat8aq8QQ8lgnQXajjiI6JzpKH1DjFeVo5s/StULVnwYg
 AVlKcrbZC2Tub744dw9wMhRfLMKpiSBLCTPdoBnlLUu5ARlb8XLZGxQl27zRUt5CRF1BH/JVBWW
 GmKXE9VhQ+WU1yDgEc6kXdhx+KDcH6mkGJ4If3IROmNyOYA==
X-Received: by 2002:a05:6102:3748:b0:73a:e9b:26ec with SMTP id
 ada2fe7eead31-73dbf89465bmr2222829137.16.1783000294107; 
 Thu, 02 Jul 2026 06:51:34 -0700 (PDT)
X-Received: by 2002:a05:6102:3748:b0:73a:e9b:26ec with SMTP id
 ada2fe7eead31-73dbf89465bmr2222818137.16.1783000293498; 
 Thu, 02 Jul 2026 06:51:33 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-73e1c4e64a3sm1276462137.9.2026.07.02.06.51.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 06:51:32 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v3 00/24] target/riscv: move TCG files and fix --disable-tcg
Date: Thu,  2 Jul 2026 10:51:02 -0300
Message-ID: <20260702135128.1188021-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: KaeSoOGUUa1UtrFMQbzJZN7duEy3GtYU
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE0NCBTYWx0ZWRfXwiMKFuXZdIWT
 ALKLGP/jTmm3TrJY5BdQ6u5ht6sqYtjXBm9GxSlACqT4E1WRcDtCKFK4/JgRrV7c3x0UTC7epkZ
 xAG13H15VqaNPLL2LozxKDG+gnPxFJs=
X-Proofpoint-GUID: KaeSoOGUUa1UtrFMQbzJZN7duEy3GtYU
X-Authority-Analysis: v=2.4 cv=bOom5v+Z c=1 sm=1 tr=0 ts=6a466ce7 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Qhm3AQCK7GAS0wBZXmgA:9
 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE0NCBTYWx0ZWRfX+BrNqERc64Ib
 /U+bBqqjTc83TSX0FU+zvs3OIjzcKdnbnsOsVyaTiHgmKJJgmrFHNnItcqXYQg9M6chEGyIX/wp
 m5DJIbRvLY4bb2+lD/MQb/WuQN35R4PAgihWLank2iOwzY2g4Asw5mturwD5MWnclcWUwt27Gpu
 1l5Gsxq9bOfuN/LFn1qErCpFxVRJJItLoPtdyvAwebgUQZ09ZJLsO7ALpXGW9+dP5TqOGxG2oKi
 nfZhQ0sh2eEGraBegCwNv9oD44Sf+UISUthJLfWjvdKYhBjJmnIQ8hMB8MHp/RKSc0DXjOOwoCV
 BuldAoyjPqAdI90QABF5/YyUV/i9RzyooxcEqs1CxYObsDufh6xynHfpc7jbsr0qczFabI71JuF
 fDs17oQy9Eobg6XMo/yeoaEOyPhSpEKp4iDDMnoh03OSEJG/nDrFn0e5s/HxpSipRrqP/yAG/CP
 rpyoEXj4IaPVnhwUugA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015 suspectscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020144
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

This new version was rebased with 'master' after the last RISC-V PR got
merged.  A trivial conflict with the recent Atlantis board was fixed
(header file path changed).  Aside from that R-bs that were given in
v1 and I forgot to add in v2 were added, along with r-bs given in v2.

No other changes made.  Patches based on master.  They can also be found
here:

https://gitlab.com/danielhb/qemu/-/tree/riscv_disabletcg_v3

Usually I don't point this out but given that this patch is fixing
--disable-tcg and adding a new KVM-only runner - CI status is green:
https://gitlab.com/danielhb/qemu/-/pipelines/2646978060


All patches acked/reviewed.

Changes from v2:
- rebased with 'master'
- added r-bs given in v1 and v2
- v2 link: https://lore.kernel.org/qemu-devel/20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com/ 

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
 hw/riscv/tt_atlantis.c                        |   1 -
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
 71 files changed, 515 insertions(+), 442 deletions(-)
 rename target/riscv/{ => tcg}/bitmanip_helper.c (100%)
 rename target/riscv/{ => tcg}/cpu_helper.c (92%)
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


