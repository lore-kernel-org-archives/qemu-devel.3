Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12232C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 18:07:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfiGu-0001F1-8V; Fri, 03 Jul 2026 14:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfiGs-0001Dq-Nm
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 14:05:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfiGp-00022W-W9
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 14:05:50 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663HiRM7546647
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 18:05:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=0U10LW3MUQtGbLvnzG8vS4
 F7uFgx9ED+V0IXZrqWGBY=; b=bVIGvzoAJEZuQYdaJQXvl3vCieHup0IwIn1sJL
 e3bHlCz49O04YRc3PxBJVuImOPoMITJhT4cgiJFpyzzX2CcN/WIiRJvLovcvm5r6
 tFnl+GD2OC9oNK8FXnnRi50UUjDujQwLR8py7hfUAhtrUO2mokA8l1V/dTbWRk1R
 Mz6Jdqyl8PZxTxc1BXKNVbExqAgjpy77sh4TssMvRUAl0dVWqHcw4O5p0R6eDXp/
 wgXIUW/x52NuaXGKgun35BaVLmbtS2H8wt19rdNPVrg/ArUsVrfo9/PEb0Xn7nyA
 Tc0dbfH9haUwCOLWwhudgNsstLa0w+6dEIfapL3j7ohwgFIg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f67j02jwc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 18:05:44 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c1a9764f0so10760721cf.1
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 11:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783101944; x=1783706744; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0U10LW3MUQtGbLvnzG8vS4F7uFgx9ED+V0IXZrqWGBY=;
 b=YuKt41en14pHhhG1IPFyXWqjP589rrXcL3Tl8vW7l2Do4aq6QplvwaLCs/T8taF8Zu
 TXI1qGjo9dVE9Us4CbJ/MtauPzgXIlVEeVJtCk4nOlNV5tL8tXTSkKiD6IokGPDiC7r/
 hzlCCP/nVS6SZ99xlvIK0KE//uzCuCwg5ZnEdOGLLa7VwG0+2AMM6LTmznHhdwmUH95Y
 ebrViTTzImbeAvHZ4kS5WAdwiHmv20jXxTw7VLgzLQ3VqW0+qWd9mmU6G1JX4ZSKJriA
 wEIBpoG/sPlYkTd53dnRKiCuD9dd339A+dn00Npq97rlZ2FIs7oVMooFmq1QeJcfKgyt
 Xlpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783101944; x=1783706744;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0U10LW3MUQtGbLvnzG8vS4F7uFgx9ED+V0IXZrqWGBY=;
 b=hjhKM5RqxU7MizHmznz7B4HIWYLRlEJnR0FgCu+dw1QTlsGhHvWKORuXBYEQnz8c7N
 m/7d2KRahI7eyUvwVYsf+fKip21zOp2a8pWfnR+OpIl7an9p80Lsz0WmNBMxlTBNSDbQ
 9rpeYf1lVbr41mT7KbrZaNGnb7ZV02cBSJTNShGmkq6Z7ZLMwM/21yS2jkBo6LuDIjO2
 u50snK9mDB1/xCue/MURkBCKsGSf2iFyfb4Q40fFCWTDaJgOxnsMox1wXOGbMAbQCOKu
 BXbwayv0KnHF5RdFg80qYkOL8n/ueZW52iQ8D8rDVp0HOaEFkW+Yt71xiBaiK5hbX5jw
 5e7A==
X-Gm-Message-State: AOJu0YxEjQ75TRnOqccpZV/RluvIS6WwtyY4+GqE8LapMnuE5vlhr2lp
 8c4iB+9K/aEcAos4e6ZsitkRBv/RqOOymntSZ+azfNxXf6dhF5CYiXVfDJR74IfzB/QbeX84Ehk
 EJSLh16RY6xKTmNTa3PIqEJE2GPGsBAMpHHhctBtmuALjnPm4KPQmizewP+G5n+Tggw==
X-Gm-Gg: AfdE7cnxp/vjxeAaYqaGqQSbGptRZ/DhRC8mkFQsJ/QdiHILyUh63Q5HDMB6lYo2SKN
 d2XnyAcjsfnJo2ay0aA4+JBIes894jjLFmGBt3rlIppJt4TFM8lPQDVHarD/D2EZ54bOVeb3RUP
 P9Bdc373ikE2QjeO/oWHRmE1MAe0XsqlO9aILvZjqJX6xgKWiRQGzNKizuZIURMcU0xK2B+DJmW
 ma4mfaFeYe7ZC//awbOWKzRgKuVUr+oLG65873pZdYLUDtKRu0ihtlZDij0582bNOb12OL1L13o
 MPZtDimwySF3+IXxxOI8JLo2avCshGTzTfVXnacn7/382pTlQqC13BGidveG0+orNUEKD9raNAC
 ENjQYDNWLdWW10GQzvU5McgmOVtmQxopqduIR8ERxO74Czg==
X-Received: by 2002:ac8:5784:0:b0:51a:8c9b:649c with SMTP id
 d75a77b69052e-51c4c3c2d62mr8564371cf.64.1783101943671; 
 Fri, 03 Jul 2026 11:05:43 -0700 (PDT)
X-Received: by 2002:ac8:5784:0:b0:51a:8c9b:649c with SMTP id
 d75a77b69052e-51c4c3c2d62mr8563561cf.64.1783101943087; 
 Fri, 03 Jul 2026 11:05:43 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51c41d2d688sm22560081cf.17.2026.07.03.11.05.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 11:05:42 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v4 00/24] target/riscv: move TCG files and fix --disable-tcg
Date: Fri,  3 Jul 2026 15:05:12 -0300
Message-ID: <20260703180538.3346781-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: l_ky_qGCn-x6UaquVnbNEed3SJyy4BHy
X-Proofpoint-ORIG-GUID: l_ky_qGCn-x6UaquVnbNEed3SJyy4BHy
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE4MSBTYWx0ZWRfX4ltVmFOMnWGc
 bm5Uz5aN+oLkMKDB1CikXIa8CjNxyeSD4kAni33VKaMyqG62UCMd3c+f9dBV2mUDiv1q3885jJD
 Z+JhvNQ3UNVLDu2Kl3bEpH2ZvnC3zfQ=
X-Authority-Analysis: v=2.4 cv=Yuc/gYYX c=1 sm=1 tr=0 ts=6a47f9f8 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Qhm3AQCK7GAS0wBZXmgA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE4MSBTYWx0ZWRfXw5W93zY+CJXV
 v51Wkn78id+GHUG3PTVLdqocej8G60hC9hMALIETnHtHL4C7zJb4rSrxoreqD6ztm30rNne+Nl/
 kqm3imj5zJbE9nat4bfcix5JMvQCuvvfQaPaD1R4KRH61VnqFh+DNCytyB7qBAtYRtfatCCNAZU
 YYuQfpE3vFICzOF8mNw/HfBWyhno0Zj5mBUf8oyF7CrRssgylMSatsTyzU6UJTWFg+sohq12J6L
 Oe3dsf95x4zRXEKQmnJ+3GT4AhrfCvLD/bWsVdCF9iuKuTo5hpl64hNbsqyjsQCGwZRmHgjixyq
 T6/c2Pe7tLlMoV5drL0NPZKx6l3XaPSQ6SGqe7ha4/K7f8/BbdY1den9ByMiCwhvwtOO1XCTozk
 buZBqGWREW5uhD1quUNUORy+wh8quvMFJUFO2YegUlTT8CM+70y7ZcZweSsfxNNQC9ws90veKmj
 2fsKMMnxB6V4VHJbJMQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0
 bulkscore=0 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030181
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Greetings,

In this version a couple of changes were made based on Phil's feedback
on v3.

Most notably, patch 06:

[PATCH v3 06/24] target/riscv: move pmu.h to tcg subdir

was splitted into a patch that does the PMU FDT code move (patch 03) and
the pmu.h path change was squashed into patch 04 ("move TCG only files
to tcg subdir").  I kept the acks/rb-s since it's just an organizational
change and no logic was changed.

No other major changes made.  Patches based on 'master'.  They can also
be fetched from:

https://gitlab.com/danielhb/qemu/-/tree/riscv_disabletcg_v4/

All patches acked/reviewed. 

Changes from v3:
- former patch 6 ("target/riscv: move pmu.h to tcg subdir"):
  - PMU FDT code move put into a new patch:
    "hw/riscv, target/riscv: move pmu fdt function to fdt-common.c"
  - pmu.h file path change squashed into patch 4
- former patch 3 ("target/riscv/machine.c: do not migrate pmp state with kvm")
  - use "ifdef CONFIG_TCG" in pmp_post_load()
- v3 link: https://lore.kernel.org/qemu-devel/20260702135128.1188021-1-daniel.barboza@oss.qualcomm.com/


Daniel Henrique Barboza (22):
  target/riscv: move valid_vm_* satp arrays to cpu.c
  hw/riscv, target/riscv: move pmu fdt function to fdt-common.c
  target/riscv: move TCG only files to tcg subdir
  target/riscv/machine.c: do not migrate pmp state with kvm
  target/riscv: move pmp files to tcg subdir
  target/riscv: tidy up riscv_sysemu_ops
  target/riscv: move debug.h to tcg subdir
  target/riscv: remove csr.h from kvm-cpu.c
  target/riscv: move csr.h to tcg subdir
  target/riscv: move custom_csrs logic to tcg-cpu.c
  target/riscv: move riscv_cpu_set_nmi() to tcg-cpu.c
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
 target/riscv/machine.c                        |  15 +-
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
 target/riscv/{ => tcg}/pmu.h                  |   0
 target/riscv/tcg/tcg-cpu.c                    |  30 +-
 target/riscv/{ => tcg}/th_csr.c               |   2 +-
 target/riscv/{ => tcg}/translate.c            |   0
 target/riscv/{ => tcg}/vcrypto_helper.c       |   0
 target/riscv/{ => tcg}/vector_helper.c        |   0
 target/riscv/{ => tcg}/vector_internals.c     |   0
 target/riscv/{ => tcg}/vector_internals.h     |   0
 target/riscv/{ => tcg}/zce_helper.c           |   0
 target/riscv/time_helper.c                    |  33 +-
 71 files changed, 513 insertions(+), 441 deletions(-)
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
 rename target/riscv/{ => tcg}/pmu.h (100%)
 rename target/riscv/{ => tcg}/th_csr.c (99%)
 rename target/riscv/{ => tcg}/translate.c (100%)
 rename target/riscv/{ => tcg}/vcrypto_helper.c (100%)
 rename target/riscv/{ => tcg}/vector_helper.c (100%)
 rename target/riscv/{ => tcg}/vector_internals.c (100%)
 rename target/riscv/{ => tcg}/vector_internals.h (100%)
 rename target/riscv/{ => tcg}/zce_helper.c (100%)

-- 
2.43.0


