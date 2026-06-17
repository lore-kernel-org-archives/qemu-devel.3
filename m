Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64BF2CD98F3
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 17:15:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZtr1-0000G2-Ch; Wed, 17 Jun 2026 13:15:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZtqf-0000F8-Uq
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 13:14:47 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZtqd-0006Vy-QU
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 13:14:45 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65HFokNJ3212085
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 17:14:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=gYt3wu0CxoCWR+yIS79GkQ
 C44el0ZwRUbhB2XGcjAGo=; b=C+Lv5IDqHycXCxkQXPLCcrnuqlN+v8KqBFc/3i
 FFuxujmjrCsQtj9WU+5HW5LkigBokGYR2cc/wdcQ38XsGVxjU37Gd3gL0TxpALeW
 sAzDuMyCe+EjVpYtf/k29pFMBsQzW1lN+b2jD4uKlRz6g3zEHt7phhuE0uoJQYKm
 aPvlZfvDFIYocAhy3wr0DS7dXbil7SiMaJ+20vr68R7xlJOa9hm/JBbB41NCH5HB
 WLG77GlApRQUZ/jo/++3dJY+QMr7JvWvlW/zM8PIzcHlRTKs9gqdohKj01dC2TNR
 A80cKbvdWNYoRQ3Nfgg9HH4Dze7YuHMq7SLI+rscFIaj/A7A==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueerck28-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 17:14:41 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-963d7c11611so1879884241.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 10:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781716481; x=1782321281; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gYt3wu0CxoCWR+yIS79GkQC44el0ZwRUbhB2XGcjAGo=;
 b=SyQz230kRH6eHoVQW3AAnAX3V4djAcMqxzcZtQ/gTEpHSUpVRlrRMAKsJ+QSbOi9fH
 rO99U8csqs7IufI9rfVkGEMa+8p4I82t4qGn0XW71BS3vkjE8H2OaMsdN+um87L0q00o
 aWMn2AGyszSnmuX/7qG63N0OEvYp0/UTexBYGBwbkCKKIV4zZFpKoE4J9gVoq7Envgrl
 poK2Uq7Au0Aa1j59+4w5puPH0VYU+k/BNbURvGZwqgds9S2uGAbzSH2IL20cdd+3zTVk
 sN+Q2BthqOoZni+086CkonkYO/ykdmhwI+sz4sbCYqBPMdPJ3jq5T6slFQBaPtCSYgEz
 ve0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781716481; x=1782321281;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gYt3wu0CxoCWR+yIS79GkQC44el0ZwRUbhB2XGcjAGo=;
 b=GD8ASZMjpXjGPxPIse8Ar0LHw/okfS1Su099ytbzqqF2bex8gFJn07NFNOa70FUx7M
 TfD8F1XRx8dVTr1g0sz1QNkwnm3wl7MmU5duxCg7EPqI1hy0J0BspjMipv/aMcI5ODVM
 7NHEYt6P4IQmEv66Ea/laqg20SBtes+kQDJWVvV9qKF9v8hxbiYZDh6WLYmda4awEbWp
 cNr+pu1ZxqohMYsLJcIVJyZMA4pbmug5gxDsM/YjlhwYcIUE7pN/7FdsKQos/oqbRFMg
 O77HLw/x2bdL6LEaqy4hpMT44t7B8ImeGznpF1vCNlI57zcyBpaT4zWHUpgOycT5WRnN
 Lg/w==
X-Gm-Message-State: AOJu0YzXsgUpdoEParjFgDB7QX2KRl93e56mEBCOBJr+4XPw5dftDCMH
 pkMxXmpobNkibODDslvTjdVfANBQExpTraWjyZ1zmxL2fMS++bThy13dZkz9bmkHwXxKWfNrdHR
 Gp0ucFvUhRnKgOC/TU1adUuGTrGcUStw95Zyz1OAUUYPQJVs6Jg3JSNUlJ+Bx/byRrg==
X-Gm-Gg: AfdE7clojWY59jAj0V7e/Vh7w5Vp0jzD2PYRN3YE86d6M5zAJGELa8hCRF8+8twMsPr
 ADClmc/DI8TIOrt9snn3x9ks4YSVYs6TbMP1cbeSQRKlCGJZLz7Z/bKl21SsAKvNTS1EkQ+vwpJ
 ue9+FdaP1BIbFGwIYxEl4H6LHz5wxPuKyb/U7lqkPxIIaODjixO+dpMhEUOaAFJz4eOUeHg7cKm
 bPdL4n++XWCMkqqPEBIYasrZeSdRi1MaFA+UJn4LvuGiqeg9cxbE0PEe0jy0ILSUjkJ8OTg6a0N
 T4qKdFM+QFmkW4J36de0MaU817uVVsVY1HOZNQnkyi9hV+2FTCAC2LCNKQF+w2BRMeKMDHEDL1O
 XHFSZqjefgTRr/YqA1Ml2eJ3UeCgn9a1USPZW/8GMwr92H8D3wlh21FJ5MU1Zvwd9Vzgs
X-Received: by 2002:a05:6102:2b98:b0:726:5c5d:add5 with SMTP id
 ada2fe7eead31-727c4cb9396mr405896137.7.1781716481017; 
 Wed, 17 Jun 2026 10:14:41 -0700 (PDT)
X-Received: by 2002:a05:6102:2b98:b0:726:5c5d:add5 with SMTP id
 ada2fe7eead31-727c4cb9396mr405864137.7.1781716480591; 
 Wed, 17 Jun 2026 10:14:40 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26f726sm53069162f8f.15.2026.06.17.10.14.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Jun 2026 10:14:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 00/11] accel/tcg: Extract cpu-loop API out of
 'exec/cpu-common.h'
Date: Wed, 17 Jun 2026 19:14:27 +0200
Message-ID: <20260617171438.75914-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE2NiBTYWx0ZWRfX9Ec3OHbfBrL3
 jrdnoospqbFqQGrqoRExoB9lTM3yVbswbJ9mAgPSlJ20kiXB8SVkiLlsL6kexFLJfUAm8m8C6jK
 BYtjDik4InSB+Dah886zTkVpkJVuJLQ=
X-Proofpoint-GUID: DhwPAaIHO9rwt_0iEmTwoGYbxjuuHPQ4
X-Authority-Analysis: v=2.4 cv=d4fFDxjE c=1 sm=1 tr=0 ts=6a32d601 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=LAEA24q1pFA4S7CnOcUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE2NiBTYWx0ZWRfXwk0qBV2IzhRR
 JHinejfmgUvSPX73m9No0p43eWB5JaL3Jq9dELuBdJAjDggEyOho8aL5zzGQJmdlyFH5HGug02n
 mLyXgg+9AxoanyZm5Yk3cFIypTJJ8sJKXU7NXD+PuuQhWIaHqnJiMrWTZv1hVsOunycDCRH+m9k
 IOrKJA9lnYtC6g8pQnMMG6GFmD+Y1zYa0xIeZM7grWXBAs/p4XqAc/rJpSJhHzDXvRi7UJT6gqM
 uoMCywJ+TJltcjumB5jCpbLqHfIFCGDV0th5sU2GAOeDK4GygTfX08ByNnBwuhhL/+pHvSb9+W2
 4liP66TXD+oHn3xBSMzMGiC04wJX8fc8FznTKMx2wOSF8Zu9TSqvaPckD2gFsParuO50+67K0u8
 F+yf8GhO5l1Mq4ZRz/qef/B6h76ICeQsiN2M1g4XUR8fnsQ7qyXfkvaQVnoynGFk1MjD5v3fKsj
 yowqAPHfJj5zWXWBwGA==
X-Proofpoint-ORIG-GUID: DhwPAaIHO9rwt_0iEmTwoGYbxjuuHPQ4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606170166
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Missing review: 8 & 9

Since v1:
- Do not un-inline cpu_loop_exit_requested()

We still try to clarify our different APIs, in particular TCG
emulation vs hardware accelerators. Extract the TCG vcpu loop
methods out of the generic "exec/cpu-common.h" and move them
under the 'accel/tcg/' namespace.

Philippe Mathieu-Daudé (11):
  target/arm: Restrict TCG specific headers
  hw/s390x/ipl: Remove TCG dependency in handle_diag_308()
  accel/tcg: Remove cpu_loop_exit() stub
  accel/tcg: Move cpu_exec() out of 'exec/cpu-common.h'
  accel/tcg: Move cpu_exec_step_atomic() out of 'exec/cpu-common.h'
  accel/tcg: Move cpu_unwind_state_data() out of 'exec/cpu-common.h'
  accel/tcg: Move cpu_restore_state() out of 'exec/cpu-common.h'
  accel/tcg: Have cpu_loop_exit_requested() take const @cpu argument
  accel/tcg: Move cpu_loop_exit_requested() out of 'exec/cpu-common.h'
  accel/tcg: Move cpu_loop_exit_*() out of 'exec/cpu-common.h'
  accel/tcg: Restrict headers being TCG specific

 bsd-user/freebsd/os-proc.h           |  1 +
 include/accel/tcg/cpu-loop.h         | 73 ++++++++++++++++++++++++++++
 include/accel/tcg/cpu-mmu-index.h    |  4 ++
 include/accel/tcg/cpu-ops.h          |  4 ++
 include/accel/tcg/getpc.h            |  4 ++
 include/accel/tcg/helper-retaddr.h   |  4 ++
 include/accel/tcg/probe.h            |  4 ++
 include/accel/tcg/tb-cpu-state.h     |  4 ++
 include/exec/cpu-common.h            | 56 ---------------------
 include/hw/core/cpu.h                | 20 ++++++++
 include/user/cpu_loop.h              |  2 +-
 target/arm/internals.h               |  4 +-
 target/s390x/s390x-internal.h        |  3 +-
 accel/stubs/tcg-stub.c               | 20 --------
 accel/tcg/cpu-exec-common.c          |  1 +
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
 target/arm/tcg/helper-a64.c          |  2 +
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
 target/s390x/diag.c                  | 32 ++++++------
 target/s390x/mmu_helper.c            |  3 ++
 target/s390x/tcg/cc_helper.c         |  1 +
 target/s390x/tcg/debug.c             |  1 +
 target/s390x/tcg/excp_helper.c       |  1 +
 target/s390x/tcg/mem_helper.c        |  2 +
 target/s390x/tcg/misc_helper.c       |  6 ++-
 target/sh4/helper.c                  |  1 +
 target/sh4/op_helper.c               |  1 +
 target/sparc/helper.c                |  1 +
 target/sparc/mmu_helper.c            |  1 +
 target/tricore/helper.c              |  1 +
 target/tricore/op_helper.c           |  1 +
 target/xtensa/exc_helper.c           |  1 +
 target/xtensa/helper.c               |  1 +
 accel/stubs/meson.build              |  1 -
 83 files changed, 215 insertions(+), 103 deletions(-)
 create mode 100644 include/accel/tcg/cpu-loop.h
 delete mode 100644 accel/stubs/tcg-stub.c

-- 
2.53.0


