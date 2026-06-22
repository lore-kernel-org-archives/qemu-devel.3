Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED752CD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 19:32:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbkNF-0000NQ-Jv; Mon, 22 Jun 2026 15:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wbkND-0000N0-VW
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 15:31:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wbkNA-0001jx-NG
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 15:31:59 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MFVjJR1097990
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 19:31:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=9xekP8dDgbpxQcMBHMQ7HJ
 /OLkE+KCmBVorhY7R/7ps=; b=Ovvao97UMRIbWtcayR5ez1cNQci8YUCwiF1Leu
 2WjFoc7E5l3MvEWs0pJHQHuE93Es5sM9YDisKftr0BcZXtZxYNdLjTeTop4RwZEE
 OGeluVfYtNq8NmhWHiU44FyerYS51LYq73EbajXPi/DacEoT5t8/ILpUTvSRkYAf
 KFkn+7xh4LqiVR1uU5sSImjky8IY+b4y0alA+GzZNEoNQ6ZrhhbdMoT0IlW8wABy
 el9XEtp8yMtIn4N9+lTc9d3QpiLOSOZ2SUy8LNRBynnHHLM56M/+hvcyNF8z4cBz
 atM+FiPaa3xEZ221kyEWS7SsdLs/gx6zkf+v3keW8ghvpqeA==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey3cq1xcw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 19:31:54 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-486e64c8edeso6753338b6e.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 12:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782156714; x=1782761514; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9xekP8dDgbpxQcMBHMQ7HJ/OLkE+KCmBVorhY7R/7ps=;
 b=dW+aox9nHSIFOwhDJrtkhu+2PP6oXO4M/dMNhMRM+lwDZ+7M7/GMIE4qka0CGaa+EA
 DZROm1bCPqDTd5PuiDqqibzv3abPgBDnBznm/aHPKxaPReZ7+ZoCRbkAkwb12p7mAbgj
 8c+ogYyapFIPIRW3lFy9+w3I4Q2lr7MWU22IFM3TGNh02bbhSKLJAnyIZ08BINp/94IN
 flBQMDt3XBz+Bk3m1ZOVt7C8JDBff1HpiMJc6zBJORlTl6l/I/p4CZy0IKbiWSHLBYVH
 7E/Ej5JSnslT8LwYNlg6HXxhgS0N5WAGRlu/I6+aY/BQgyELAKHFI6eiE0akPr7FUAcf
 ouog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782156714; x=1782761514;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9xekP8dDgbpxQcMBHMQ7HJ/OLkE+KCmBVorhY7R/7ps=;
 b=tSp34Y+kWkPRc+vduZNrtUXE/8uliOvWQ4mObAXspN2dkxYXEc1Ijbg7As88+EmUBV
 oB+N6PDu8/XJKBGu9ITopRvvmbQjBhhfMDQpNaNIFzu0m/HH29+oScvzsY9EeKcPmM8x
 Ymc2CpOg9KLyGPqm/5C53J/HNMx9JysnZiKDgDJK8qz7XdR++TCre/g+gCt5HO927IPz
 k4tCNVmhkhGFITOEH9kQRyHSTg3rC7nT7fsxYV8XujPObH7gflF2zCB36ogell4g+2oi
 Mg3FVZKMdatHBp3TYTWg8IYnsCOoUVoE9wRTz/NqaDYr3j9fstUPxkvcpY/jZtwjYRSR
 YCiw==
X-Gm-Message-State: AOJu0Yz+kaku0H+LmXcFYzDvj1ae9OKiEa4d+t0wT0UVW+lgMRkM0Vru
 UfjKCLff5g4oFBt+LOBvoNwTQ6jTlmQHGHnOUEP4HcDbdkEm3jagf0WE48UyIeCV0s3zHb4HlFR
 5nOJMgLjDwUt80E+hyd8y1O/FjoRLNLhJREqYT3ohcuLvAdJs8IzWWBSfPgcB+51sbQ==
X-Gm-Gg: AfdE7clbo0QO1zkL1XMAsL853QWrneVlmwWTS1JnkOhXOU41yasw4F0zuUmT/OpRtnw
 5Tp/ulY8GDsMv7Hlc4CIpB6rwPja8U4cIoaZCGW9oTJQkMa9MkXOYZ809WiecVQOtpirEJ9nndQ
 mvoMUHpzIFbprwta10xFPspToebp4DOQlztttwJfjDmmAOkB5qKjPPlVzzj9dDlbwCJMtKkBRai
 eM59eeq4dLv7u1KNFXsXaTURe09TqpsGtjLRRVLULcZptIWNAuLeKYGdBVkJlVSLygKuHkHsJKv
 VBrGovgw+d66dGsnAMVFhS4JbmjfP9gdvvBVOmqOHL7ehZmW6BttrgjdcJ9vI2g+tiYpSkkWTe7
 oShhXwtYDeAQyfRwNT8mtcqQ4SXBqP1rqwjqcTu8kVn/rCw==
X-Received: by 2002:a05:6808:1592:b0:48a:e928:56ff with SMTP id
 5614622812f47-48ae9285f82mr9007489b6e.39.1782156713875; 
 Mon, 22 Jun 2026 12:31:53 -0700 (PDT)
X-Received: by 2002:a05:6808:1592:b0:48a:e928:56ff with SMTP id
 5614622812f47-48ae9285f82mr9007469b6e.39.1782156713329; 
 Mon, 22 Jun 2026 12:31:53 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-926004ab49csm61489585a.34.2026.06.22.12.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 12:31:52 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 philmd@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH 00/24] target/riscv: move TCG files and fix --disable-tcg
Date: Mon, 22 Jun 2026 16:31:16 -0300
Message-ID: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: DJMnKIbZUN4az5mICZLXidK6raTQBGHP
X-Authority-Analysis: v=2.4 cv=VKXtWdPX c=1 sm=1 tr=0 ts=6a398daa cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=3bqWI8QZYUf-Gufe0jkA:9
 a=QEXdDO2ut3YA:10 a=TPnrazJqx2CeVZ-ItzZ-:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: DJMnKIbZUN4az5mICZLXidK6raTQBGHP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE4OSBTYWx0ZWRfX36fUtkoaJaEh
 FH5kRdh7bDRvBNJ7ga7I4/l0myS4Uym8VsoYQQaOkPbawPEOSAEPxsmktnYstozJjrTUlNLO57I
 mv2dB1GtR9+F99ed6FbotpEQYzlYht65ZfUowSjlTJ9b+UymHk/O52ugGuycAvNRL3zE8j3zk/8
 /KqMfR+MOxOxcUKvp/MoUaPcKwm1wsqFnmYFDrViuWe5sNmSDJWnl1/+Vvo1AAe3DA3dVAx9FX+
 PGLibpsYHeyuqBYlF8z3sHF/2YKfrCx/And4s5Ujjjv/QPFZtn50UqzgNc06BWEApX8wkucbSwo
 zHrTp/OC/Dj7W/Kp4PpXM8oWqrI9JeXPrxFk/3AZ9rB6Mfr4wvLJh/WaUX+yJ7gbFSmUmE5/3CL
 CG1ZXYcvKmGw+WAiJRKgOcPY4NTpA5/SDnhSHatXOBMctA1u3cDohspklTSB8Ti2twKBCyClBC7
 3jKQciJEc4zVvWfuEUg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE4OSBTYWx0ZWRfX3eq2NUFW0ZmP
 ky378f57fKdlPGXzsWQurbBLJ1lR11tA4AXWMkzdeit02eCEW6gzp/fxU278irmAHF5tkPoH7h6
 9RhU8bd5ekyHHnHRiEciO0J5e0YDcS4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_03,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220189
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

This series looks scary but it's mostly trivial and mechanical work.

It is yet another attempt at fixing --disable-tcg.  We have a recent
work sent to the ML [1] and we had Phil's attempt back in 2023 [2].
Phil's work didn't get merged and it's now too hard to rebase and
revive, the most recent attempt got misled into the 'what is common code
between TCG and KVM' dungeon.

After reviewing [1] I went ahead and look what other targets were doing
w.r.t their directory structure and comparing to RISC-V.  In our case we
have a log going on in target/riscv:

$ ls target/riscv
Kconfig                 cpu_cfg.h             fpu_helper.c   machine.c         sbi_ecall_interface.h  vector_internals.c
XVentanaCondOps.decode  cpu_cfg_fields.h.inc  gdbstub.c      meson.build       tcg                    vector_internals.h
arch_dump.c             cpu_helper.c          helper.h       mips_csr.c        th_csr.c               xlrbr.decode
bitmanip_helper.c       cpu_user.h            insn16.decode  monitor.c         time_helper.c          xmips.decode
common-semi-target.c    cpu_vendorid.h        insn32.decode  op_helper.c       time_helper.h          xthead.decode
cpu-param.h             crypto_helper.c       insn_trans     pmp.c             trace-events           zce_helper.c
cpu-qom.h               csr.c                 instmap.h      pmp.h             trace.h
cpu.c                   csr.h                 internals.h    pmu.c             translate.c
cpu.h                   debug.c               kvm            pmu.h             vcrypto_helper.c
cpu_bits.h              debug.h               m128_helper.c  riscv-qmp-cmds.c  vector_helper.c


It is non-trivial to realize that most of this stuff is TCG specific.
Meanwhile our 'tcg' subdir is mostly empty:

$ ls target/riscv/tcg
meson.build  tcg-cpu.c  tcg-cpu.h

If we compare it with other targets, let's say loongarch:

$ ls target/loongarch/
Kconfig      cpu-csr.h    cpu-qom.h  cpu_helper.c  disas.c    insns.decode  loongarch-qmp-cmds.c  tcg           translate.h
README       cpu-mmu.h    cpu.c      csr.c         gdbstub.c  internals.h   machine.c             trace-events  vec.h
arch_dump.c  cpu-param.h  cpu.h      csr.h         helper.h   kvm           meson.build           trace.h
$
$ ls target/loongarch/tcg
constant_timer.c  fpu_helper.c  insn_trans      meson.build  tcg_cpu.c        tlb_helper.c  vec_helper.c
csr_helper.c      helper.h      iocsr_helper.c  op_helper.c  tcg_loongarch.h  translate.c

It is straightforward to see which files are TCG exclusive and which
files are common to all accels.

And this is what we did here.  The patches goes mostly as follows:

- move stuff to 'tcg' subdir.  Most stuff is straighforward and is
  manageable with a single patch.  Other things required some logic to
  go to either cpu.c or tcg-cpu;
- move TCG stuff to tcg-cpu.c;
- move common accel stuff to cpu.c.  Usually from cpu_helper.c;
- filter TCG specific code in cpu.c and other files;
- trivial/assorted fixes in misc files that were needed to make
  --disable-tcg work.

Patch 24 is taken from Zephyr Li to enable the CI for --disable-tcg.
Hopefully we won't break it anytime soon.

After this series we have --disable-tcg working and the following dir
structure:

$ ls target/riscv
Kconfig                 cpu.c                 cpu_vendorid.h  internals.h       sbi_ecall_interface.h  xlrbr.decode
XVentanaCondOps.decode  cpu.h                 gdbstub.c       kvm               tcg                    xmips.decode
arch_dump.c             cpu_bits.h            helper.h        machine.c         time_helper.c          xthead.decode
common-semi-target.c    cpu_cfg.h             insn16.decode   meson.build       time_helper.h
cpu-param.h             cpu_cfg_fields.h.inc  insn32.decode   monitor.c         trace-events
cpu-qom.h               cpu_user.h            instmap.h       riscv-qmp-cmds.c  trace.h
$
$ ls target/riscv/tcg
bitmanip_helper.c  csr.h         insn_trans     op_helper.c  pmu.h      translate.c         vector_internals.h
cpu_helper.c       debug.c       m128_helper.c  pmp.c        tcg-cpu.c  vcrypto_helper.c    zce_helper.c
crypto_helper.c    debug.h       meson.build    pmp.h        tcg-cpu.h  vector_helper.c
csr.c              fpu_helper.c  mips_csr.c     pmu.c        th_csr.c   vector_internals.c


[1] https://lore.kernel.org/qemu-devel/20260602091753.3209261-1-fritchleybohrer@gmail.com/
[2] https://lore.kernel.org/qemu-devel/20230711121453.59138-1-philmd@linaro.org/


Daniel Henrique Barboza (22):
  target/riscv: move TCG only files to tcg subdir
  target/riscv/machine.c: do not migrate pmp state with kvm
  target/riscv: move pmp files to tcg subdir
  target/riscv: make some riscv_sysemu_ops TCG only
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
 hw/riscv/riscv_hart.c                         |   4 +-
 hw/riscv/virt.c                               |   1 -
 include/hw/riscv/fdt-common.h                 |   1 +
 target/riscv/cpu.c                            | 316 +++++++++++++++---
 target/riscv/cpu.h                            |  19 +-
 target/riscv/gdbstub.c                        |  10 +-
 target/riscv/kvm/kvm-cpu.c                    |   1 -
 target/riscv/machine.c                        |  15 +-
 target/riscv/meson.build                      |  17 -
 target/riscv/monitor.c                        |   4 +-
 target/riscv/riscv-qmp-cmds.c                 |   2 +-
 target/riscv/{ => tcg}/bitmanip_helper.c      |   0
 target/riscv/{ => tcg}/cpu_helper.c           | 239 +------------
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
 70 files changed, 495 insertions(+), 434 deletions(-)
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


