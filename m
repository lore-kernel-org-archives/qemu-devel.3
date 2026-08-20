Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C703EC5DF8E
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 20:15:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx99V-0005LU-C5; Thu, 20 Aug 2026 16:14:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wx99J-0005KK-G7
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 16:14:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wx99H-0001sl-2j
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 16:14:05 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KK84Dp588350
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 20:14:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=ty2W7x0FL79KHD8WFGy5r9
 fs4m59Z35jx+PNPaegBMM=; b=VnyXdVkrXryFfWzYpIfZz3DRPXLzTw+hBT9aTY
 sMc4Xu0NscHdJgtfdrUzzLJ+scnlUfRxPo50XtbL0pWOOZAXe34hdGdwOFuRDp1d
 I3Dg6POiGxwEpRS7Fb9YIuSUbTTOvYkqR6Znmy9M6h5Rd6b2sn7qd+esrornoFo0
 mm8taLG+FjP83bzK6nnRpH6zdbbObDahNK0JQ3n4XQ4sQYXGx/lbhIl3asbTAY56
 f9sI59PLE1C56Z4C+riU8xq87egI0f2V4gneMUZq1uxd1PdwxWbyK8T0ys+xIkA4
 TcLCNfxz/m9WiAJObMFRupjNioqjvUHp6El3sgMmbxiZeX/w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5yg8asck-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 20:14:01 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c19493ac2so2141701cf.1
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 13:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787256840; x=1787861640; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ty2W7x0FL79KHD8WFGy5r9fs4m59Z35jx+PNPaegBMM=;
 b=WSDif2gk3lwn40UO4yVihlNhKc0FCoN3K7/2Jj68IiQDnypNn2en7nRfeGI2XkXEiy
 o6iut7HzJHalAF5Tgnhe28UGV1WsBQB7pAcxWIyq26E7KYFfHMDSwObJuDU2NIHA8jzP
 PdIwd1hpN72bQ4ncCApORkoowXcX35DAYwRmX5U59o763L8AaRIUxuelbCNBJtaZgna6
 jlcQNy9RE/45OH86Idu4gnbNvz+fJONHuOFTAbN3xuQg0Ez7F0y0i8Z0SDzpGB1gSZK/
 DJru61s1bFg/EhAu60h/9B00pXmNegw6f+YViKl/+dLCMVDaau6aHg1gbRvoarIPEBnP
 tP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787256840; x=1787861640;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ty2W7x0FL79KHD8WFGy5r9fs4m59Z35jx+PNPaegBMM=;
 b=sDpgXi9Un+CUXTlJU1et3i5JuBbsA9PQlAXn8Qff0i06VDo8LwusABln0gonqeLLxP
 8hrAW7nbdCIhuT1Vvi0e+g032aPm8WnV4uEjb4Ginjp7Hb9o80Vh04Q7Gz2k+o8lk6CD
 K1EmowDXi7uvibxTK7xT2lcyJGHcuxSPhn01wFZVNJcRCwzup39p6pbFooxlUG7silAW
 U16M2kEe9oItdw6dNrwAbbtx3moKFRTxBmWrjdH4vz0mbGlx5KimYsQvCxpJBtfNq+wh
 qE5HG2Rh24Eo4n6fdZzkj9nFHqp6Z8Uw5SJheqh2yJtzqZOBp5n6tWAk9oCD2ov3Na8M
 xnOA==
X-Gm-Message-State: AOJu0YwMh6IK2S8sWpIhlIE4ROwdvJkpH4RA7yEFDXd974CDPRY3fDPD
 sLjzR4LR1b3NYc93K+3RdHVmk7jh7GVyQ2pU1Ro7P2E6tNsmZEN20aaiKCuNv9hiJa6kVNzEJDa
 NwRjMxtHtXoLbbR4f+IOg0ifX3TuKFN40EZKySMa5CobqHpuEVNLG7MuDIhP8g8b9a56Y
X-Gm-Gg: AR+sD13EfytabblpHYfe4ecOYC+t/xci4/jYEf2BpJeg+IE+KPmvW86ZyOH7CUoXCMn
 gsmsXhmwQrmyz0ecZBlxpejFNG4wQdiYAzKF6Qd058LZeENXm9jMfMtPxMngGkWU5h7xCO5ycMB
 h9zF1CtIO6zJG1cgkjok3YZiQwvaxQg0/0NcOyL+d9+aHjCHFVbqCrnqP6Ej0s6Psl60VCKDQau
 LY1ma+3RjAV4P1ezxlcemvszSZqgNsgxzGAK5Sh08IQEBNakguNnNjfARf2WdOznu2zXLfoNgsG
 XF6S9SYkeMcRmAKI7m7EUEum9yRwJV3djgxaXw4tw5F8Y8Wwm3jSlcqZRv1BUoWyasrPxLPWph1
 GqTlB2SU3vV0ZG/dL3OrT7n/exCccU1qCwLpNSBT7ag==
X-Received: by 2002:ac8:690c:0:b0:516:d955:ea2 with SMTP id
 d75a77b69052e-52df5524c18mr12777171cf.0.1787256840258; 
 Thu, 20 Aug 2026 13:14:00 -0700 (PDT)
X-Received: by 2002:ac8:690c:0:b0:516:d955:ea2 with SMTP id
 d75a77b69052e-52df5524c18mr12776611cf.0.1787256839821; 
 Thu, 20 Aug 2026 13:13:59 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14c45d1sm12796010f8f.30.2026.08.20.13.13.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 20 Aug 2026 13:13:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 00/15] cpus: Constify @cpu in SysemuCPUOps::has_work()
 handler
Date: Thu, 20 Aug 2026 22:13:40 +0200
Message-ID: <20260820201356.29775-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE1MiBTYWx0ZWRfX9P5YdaoNyHc9
 fjxniUC+Qar6SC8DJ6ukLk+S9lrUvumcyl7NN7FySWJGWdozRvv9Y+CKmSaMNoJuziY3Vdx3D1s
 6MOsR6s4u+mKacJx3FacAINnm5gLSJs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE1MiBTYWx0ZWRfX2RLrLMrKg5eG
 1EHrbprmY9PsHJ715oFlunejtHpm713+f4dKBySdxPdn/7XW2p8aWPlCSJPCIrfixo/vFQe6FuQ
 KMJMFJXXB2GbIRjlsKAID2x5TjGkGirBwCJf/Zl0t7e067UjvpkN/ztW5Jzl32uByMxAXv1dT1L
 nsXpf4B24BECe9oxfplPPWZazkbzjbvgUlwfQvWaipbATAoW9E6GkK3oKf3utPRNAXsHkcI00zp
 9lPLop+cnyZs5mgFf6uS3MLnhdsO9Fi+fSB+BTkZ0i7IacAm/Dsu0tfHQIEIEeuprkiKAoN3XKn
 fpnPDsSQiypN/FVmKlZZR+SO+j2EIVUFQ/YZgfjsmcu1IQdjepJEp9dlV2YDuSrzzM9A31+Hd65
 TN6r0GGesbZT7QAVwZi0jbnbhC3MQA8wbGEh0akvEg2soGQ78aNqKcRXvcSM4y3P+RQA9gVAXCB
 3m++TjdtNrIIb7KMnFw==
X-Authority-Analysis: v=2.4 cv=Y7/IdBeN c=1 sm=1 tr=0 ts=6a876009 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EsJihUnQuNbXHJ2VNycA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: 2hxYTums-SQ6MQGucXfXjKOlc_zDP-jw
X-Proofpoint-ORIG-GUID: 2hxYTums-SQ6MQGucXfXjKOlc_zDP-jw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_02,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 phishscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200152
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Missing review: 2,12,14,15

Since v1:
  - use _Generic (rth)
  - no more RFC

- Patches 2-11 trivially add const qualifier for various
  cpu_is/has() getters
- Patch 12-14 add const-qualified variants of cpu_env(),
  env_cpu(), and env_archcpu() using _Generic() macros;
  consolidate the redundant env_cpu_const() alias and update
  linux-user to use the generic accessor
- Patch 15 finally convert the SysemuCPUOps::has_work
  hook and all target implementations.

No functional change; purely const-correctness improvment
to enforce has_work() callees don't mutate CPUState.

Build-tested.

Following checkpatch.pl errors ignored:

  13/15 Checking commit efef90983aa7 (cpus: Add const-qualified CPU environment accessors)
  ERROR: spaces required around that ':' (ctx:VxE)
  #46: FILE: include/exec/cpu-common.h:89:
  +            CPUArchState: \
                           ^
  ERROR: spaces required around that ':' (ctx:VxE)
  #62: FILE: include/exec/cpu-common.h:101:
  +            CPUArchState: \
                           ^
  ERROR: spaces required around that ':' (ctx:VxE)
  #90: FILE: include/hw/core/cpu.h:605:
  +        CPUState: \
                   ^
  total: 3 errors, 0 warnings, 64 lines checked

Philippe Mathieu-Daudé (15):
  target/tricore: Document architectural interrupts as not implemented
  system/cpus: Constify various CPUState arguments
  target/avr: Constify CPUAVRState for some cpu_*() getters
  target/hexagon: Constify CPUHexagonState in
    hexagon_thread_is_enabled()
  target/i386: Constify CPU*State for cpu_*_interrupt() getters
  target/loongarch: Constify CPULoongArchState for various cpu_*()
    getters
  target/mips: Constify CPUMIPSState for various cpu_*() getters
  target/s390x: Constify S390CPU for cpu_has_*() getters
  target/riscv: Constify @iprio argument in riscv_cpu_pending_to_irq()
  target/riscv: Constify CPURISCVState for various cpu_*() getters
  target/sparc: Constify CPUSPARCState for various cpu_*() getters
  linux-user: Uncast void pointer argument as Object in
    target_cpu_free()
  cpus: Add const-qualified CPU environment accessors
  linux-user: Replace env_cpu_const() by generic env_cpu() equivalent
  cpus: Constify @cpu in SysemuCPUOps::has_work() handler

 include/exec/cpu-common.h        | 29 ++++++++++-------------------
 include/hw/core/cpu.h            | 21 ++++++++++++++-------
 include/hw/core/sysemu-cpu-ops.h |  4 ++--
 include/system/cpus.h            |  4 ++--
 target/avr/cpu.h                 |  6 +++---
 target/hexagon/cpu.h             |  2 +-
 target/i386/cpu.h                |  4 ++--
 target/loongarch/cpu.h           |  6 +++---
 target/loongarch/internals.h     |  2 +-
 target/mips/cpu.h                |  6 +++---
 target/mips/internal.h           | 10 +++++-----
 target/riscv/cpu.h               | 29 +++++++++++++++--------------
 target/s390x/cpu.h               |  2 +-
 target/s390x/s390x-internal.h    | 12 ++++++------
 target/sparc/cpu.h               | 12 ++++++------
 linux-user/elfload.c             |  2 +-
 linux-user/i386/cpu_loop.c       |  5 +++--
 linux-user/i386/elfload.c        |  2 +-
 linux-user/x86_64/elfload.c      |  2 +-
 system/cpus.c                    |  6 +++---
 target/alpha/cpu.c               |  2 +-
 target/arm/cpu.c                 |  4 ++--
 target/avr/cpu.c                 |  3 ++-
 target/hexagon/cpu.c             |  8 ++++----
 target/hppa/cpu.c                |  2 +-
 target/i386/cpu.c                |  7 +++----
 target/loongarch/cpu.c           |  4 ++--
 target/m68k/cpu.c                |  2 +-
 target/microblaze/cpu.c          |  2 +-
 target/mips/cpu.c                |  4 ++--
 target/or1k/cpu.c                |  2 +-
 target/ppc/cpu_init.c            |  2 +-
 target/riscv/cpu.c               | 17 ++++++++---------
 target/rx/cpu.c                  |  2 +-
 target/s390x/cpu-system.c        |  4 ++--
 target/s390x/interrupt.c         | 22 +++++++++++-----------
 target/sh4/cpu.c                 |  2 +-
 target/sparc/cpu.c               |  2 +-
 target/tricore/cpu.c             |  3 ++-
 target/xtensa/cpu.c              |  4 ++--
 40 files changed, 132 insertions(+), 132 deletions(-)

-- 
2.53.0


