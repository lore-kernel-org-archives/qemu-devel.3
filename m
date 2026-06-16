Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17610CD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:18:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZI6-0007kq-4L; Tue, 16 Jun 2026 15:17:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZZHr-0007Ea-1B
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:17:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZZHo-0004Yw-2N
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:17:26 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GIOJOx1376117
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 19:17:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=+bg4vbEnE+wM7u+u+iO7PF
 8pcTrnrS+fTNvLNU2IRPY=; b=eCSqHyCLIhn/k0YY2GX74BH8H6iCHTd8s/zKPi
 HaqBc/IaLmBJH5eJXjIZ8qozRPxeO1tRtptXAq5KBlGRsuzxB/BcMDwiQZWSjxji
 1zNuE7M0BQrpaKNBX+t8PBmbQDKSZUgfq03EDpl0OBWKCSmd1A1WL+VlPQbjDwnv
 cnkWEO2pqOF2xbt80c1yECkuQZ23VcYaxnz8afFt01L1Auml4lXLVoGOoVDql0Ao
 hV5kxPESUAas+Kz1HLHgzdZsIf5VAfaOLgwicnKw+dCsfZUhVEsCdOl+2emmd6Jx
 wtA1rvjREbsna3Ie0m/tOOEG5KEySfHP3HsMT7NbYnCQVkOw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu2xsb2eq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 19:17:20 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-915d3261c5cso1001808285a.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781637439; x=1782242239; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+bg4vbEnE+wM7u+u+iO7PF8pcTrnrS+fTNvLNU2IRPY=;
 b=aYVod5pSiuUfLVkFoOpAESp56OV4Hfdd3zdi983HoyNKrFySWHalwKNFBBQVYs481q
 BtkeOkUmj6XpWW8B/TE2Nr3pZ5awSjobJLDK7GpRLbZXl1GRfN5S4l6tVAmmpKPTzVD4
 cGwQBETG0leegK+yyKoPACi6nmZ0GBLUdxfRX4z2h+1yh+DKtPOI9bhuxStXRuHLXSyl
 u0kxRJFozy0ZoqGDcsZZtSmTRnMmsnUhjQ3eq6jU+eM2lEPQ0G1+YVPNiu9QZJgYda9u
 HHsFIfsON4A/PqFArLcUs+Q9tuTn/7NapGVHhgpz8m8wfrGWJjCTNrAf0q0ybQYCG3nF
 ae1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781637439; x=1782242239;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+bg4vbEnE+wM7u+u+iO7PF8pcTrnrS+fTNvLNU2IRPY=;
 b=g6LdPPcoh239zhogktKnpXd28gxR+KymxCkKDWl6gZkBLZFksmQXVJJksWB1P2ZhA4
 ZFoZebP90v4XE4e8+YaoyITe3raSQ8FJOL1b/zLvkILeVl3PnhW7jCdXjpMae8GlErDN
 3fmCJ8SgOPPl4nbAQDT+u3qxLaINt4AQdXHnKjLsq8g04CKJKknOP/UDZWo2mlKNXTNf
 4ucyTD75+ZxbJTOMnRbB75M0m8eqdxwgau74UgbWun3D5l0obNClp5JRCKjHbD2L3eaT
 fUY5bgsHgVv7N6oAWRqQl3FZ55F+Zhpzd8Cbr84oLXcoBEtuDx/QR45ZOGD371xJAVEj
 MIIA==
X-Gm-Message-State: AOJu0Ywqh3DzkcipqQ0sVGcNQwB8TJlQ7NqfYEIXFcaAgv44dwD4hScH
 PWkS/RuvaTcpZ90LpnBBo0wAUob1wpyzO+P3Ap9JCqKMijCVP8YJDRETZiA7CbfxEcur2chOFHK
 2qpCQgwWyJzKuMUrbuqhkAIVqVgH2Jt3O5bv1gLsNKwqhIBA8dE6D+maVRWmD8A5cRg==
X-Gm-Gg: Acq92OHFwIrAyGEZjBliszVDhjfpOb3yoabCMS6nHaInjvLiX5tIV6mzTtOkpDFxw+1
 Mi3KaPPpSUJnN2ER6xUefPX72bR8v+5iBIpJJSazlQ+fKkCE+CfN98LBIcDvTEXqEw2taTTOtBX
 pyhD/eAG0EvxAqq6KMavXUXCsPDvhTMzTn50e/zgsvX19kFRLeLqMsn/tDWG3ziDb/RAHiunYpJ
 CqnJDA7kq9xySRgs2xRwEAplwsSxu+GG/aqO6IPk50vKgYJXhHOCy6jNbVDSY3bx6p7OUYJRrZW
 3r9C1/z2VEMPqTanxIcYvkhEC+DdrnqNErHXhLpj4Sbekila3vW+aqYVOdtOlfwO79J6BgihmBx
 FRdF3YHZJARweFoIPLB/dQAWEbcrdqxtnNfm+Nc9Lv1aJp4xkwNYdaPbAnboaLnHZHIIiYVBy0X
 tSeNQ=
X-Received: by 2002:a05:620a:17a7:b0:910:bb22:d426 with SMTP id
 af79cd13be357-91d8aadf209mr171110485a.33.1781637439181; 
 Tue, 16 Jun 2026 12:17:19 -0700 (PDT)
X-Received: by 2002:a05:620a:17a7:b0:910:bb22:d426 with SMTP id
 af79cd13be357-91d8aadf209mr171104385a.33.1781637438682; 
 Tue, 16 Jun 2026 12:17:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa8b423sm99665945e9.11.2026.06.16.12.17.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Jun 2026 12:17:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 00/10] accel/tcg: Extract cpu-loop API out of
 'exec/cpu-common.h'
Date: Tue, 16 Jun 2026 21:17:06 +0200
Message-ID: <20260616191716.12932-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: FAGNscZ8kYUxYnU_osgJ2sHpCj_eL4fn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE5NiBTYWx0ZWRfXyu686VgJcBym
 KFM16uyRA+98NXrsAlk5xQnemGIEh4rWIYf8I0Cm8C8y/JaI0ENiRrM6w/81Mgpg/bEcKJ7Zv1l
 8iOYOacGC8dl4lW67zPhi1zscN1g0jubjU9Z0JHzAnR9BDLeRea1Jk85Zt3vaU1MeCIm9RsS7V4
 2hD7oBDPYO7UyWG2LVn3Qzr2G5Snuk4HaqkO347/lTBhwSlC5DONgG/UlgDYU5g6gWjYX0g++Ic
 bZv1P/3iuhrPjd5NrRFdKpNNDFtpb45HEEw0tL6uT7+CmX971gVs6i034nwWn3/cxf0EQI7kw7C
 IJvgPOeea6RyLwRb7tZOKAMt8nC+5M2xAcGsuIdKT+2ZMWnUPqWAacdDrRZh9TrREdH87rItcSC
 Ks0C2bWtM9zGInU0AogCUYx68p61cJydXiaHfCon670XBMa3JEd5UogTEg8C3JYZYyQFbe7g5Bc
 VGzYzTKVOkBwy5sso0w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE5NiBTYWx0ZWRfX4nRVO0uCXVV2
 cNKsoj0uG8IDRUy6ArRIOofobG1BSsCLcdpUPcOL/t+pZk4xfenGK++/AgfP6BTbRCm7uMR09Yf
 frrHSK2GwGOmOOz7yeFc9CgHQCjl6Sw=
X-Authority-Analysis: v=2.4 cv=MdJcfZ/f c=1 sm=1 tr=0 ts=6a31a140 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=QZqkv1mvd00liVASENMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: FAGNscZ8kYUxYnU_osgJ2sHpCj_eL4fn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160196
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

We still try to clarify our different APIs, in particular TCG
emulation vs hardware accelerators. Extract the TCG vcpu loop
methods out of the generic "exec/cpu-common.h" and move them
under the 'accel/tcg/' namespace.

Philippe Mathieu-Daudé (10):
  target/arm: Restrict TCG specific headers
  hw/s390x/ipl: Remove TCG dependency in handle_diag_308()
  accel/tcg: Remove cpu_loop_exit() stub
  accel/tcg: Move cpu_exec() out of 'exec/cpu-common.h'
  accel/tcg: Move cpu_exec_step_atomic() out of 'exec/cpu-common.h'
  accel/tcg: Move cpu_unwind_state_data() out of 'exec/cpu-common.h'
  accel/tcg: Move cpu_restore_state() out of 'exec/cpu-common.h'
  accel/tcg: Have cpu_loop_exit_requested() take const cpu and un-inline
  accel/tcg: Move cpu_loop_exit_*() out of 'exec/cpu-common.h'
  accel/tcg: Restrict headers being TCG specific

 bsd-user/freebsd/os-proc.h           |  1 +
 include/accel/tcg/cpu-loop.h         | 85 ++++++++++++++++++++++++++++
 include/accel/tcg/cpu-mmu-index.h    |  4 ++
 include/accel/tcg/cpu-ops.h          |  4 ++
 include/accel/tcg/getpc.h            |  4 ++
 include/accel/tcg/helper-retaddr.h   |  4 ++
 include/accel/tcg/probe.h            |  4 ++
 include/accel/tcg/tb-cpu-state.h     |  4 ++
 include/exec/cpu-common.h            | 56 ------------------
 include/user/cpu_loop.h              |  2 +-
 target/arm/internals.h               |  4 +-
 target/s390x/s390x-internal.h        |  3 +-
 accel/stubs/tcg-stub.c               | 20 -------
 accel/tcg/cpu-exec-common.c          |  7 +++
 accel/tcg/cpu-exec.c                 |  1 +
 accel/tcg/cputlb.c                   |  1 +
 accel/tcg/tb-maint.c                 |  1 +
 accel/tcg/tcg-accel-ops-mttcg.c      |  1 +
 accel/tcg/tcg-accel-ops-rr.c         |  1 +
 accel/tcg/tcg-accel-ops.c            |  1 +
 accel/tcg/tcg-runtime.c              |  1 +
 accel/tcg/translate-all.c            |  1 +
 accel/tcg/user-exec.c                |  1 +
 accel/tcg/watchpoint.c               |  1 +
 bsd-user/main.c                      |  1 +
 hw/misc/mips_itu.c                   |  1 +
 hw/s390x/ipl.c                       |  5 --
 plugins/api.c                        |  1 +
 semihosting/console.c                |  1 +
 target/alpha/helper.c                |  1 +
 target/alpha/mem_helper.c            |  1 +
 target/arm/cpu-irq.c                 |  3 +-
 target/arm/tcg/helper-a64.c          |  1 +
 target/arm/tcg/op_helper.c           |  1 +
 target/arm/tcg/tlb_helper.c          |  1 +
 target/avr/helper.c                  |  1 +
 target/hexagon/op_helper.c           |  1 +
 target/hppa/cpu.c                    |  1 +
 target/hppa/mem_helper.c             |  1 +
 target/hppa/op_helper.c              |  1 +
 target/i386/helper.c                 |  1 +
 target/i386/tcg/excp_helper.c        |  1 +
 target/i386/tcg/misc_helper.c        |  1 +
 target/i386/tcg/system/bpt_helper.c  |  1 +
 target/i386/tcg/system/misc_helper.c |  1 +
 target/i386/tcg/system/svm_helper.c  |  1 +
 target/i386/tcg/user/excp_helper.c   |  1 +
 target/i386/tcg/user/seg_helper.c    |  1 +
 target/loongarch/tcg/tcg_cpu.c       |  1 +
 target/loongarch/tcg/tlb_helper.c    |  1 +
 target/m68k/helper.c                 |  1 +
 target/m68k/op_helper.c              |  1 +
 target/microblaze/helper.c           |  1 +
 target/microblaze/op_helper.c        |  1 +
 target/mips/tcg/exception.c          |  1 +
 target/mips/tcg/system/tlb_helper.c  |  1 +
 target/or1k/exception_helper.c       |  1 +
 target/or1k/fpu_helper.c             |  1 +
 target/or1k/mmu.c                    |  1 +
 target/or1k/sys_helper.c             |  1 +
 target/ppc/tcg-excp_helper.c         |  1 +
 target/ppc/user_only_helper.c        |  1 +
 target/riscv/cpu_helper.c            |  1 +
 target/riscv/csr.c                   |  1 +
 target/riscv/op_helper.c             |  1 +
 target/rx/op_helper.c                |  1 +
 target/s390x/diag.c                  | 30 ++++++----
 target/s390x/mmu_helper.c            |  3 +
 target/s390x/tcg/cc_helper.c         |  1 +
 target/s390x/tcg/debug.c             |  1 +
 target/s390x/tcg/excp_helper.c       |  1 +
 target/s390x/tcg/mem_helper.c        |  1 +
 target/s390x/tcg/misc_helper.c       |  6 +-
 target/sh4/helper.c                  |  1 +
 target/sh4/op_helper.c               |  1 +
 target/sparc/helper.c                |  1 +
 target/sparc/mmu_helper.c            |  1 +
 target/tricore/helper.c              |  1 +
 target/tricore/op_helper.c           |  1 +
 target/xtensa/exc_helper.c           |  1 +
 target/xtensa/helper.c               |  1 +
 accel/stubs/meson.build              |  1 -
 82 files changed, 214 insertions(+), 98 deletions(-)
 create mode 100644 include/accel/tcg/cpu-loop.h
 delete mode 100644 accel/stubs/tcg-stub.c

-- 
2.53.0


