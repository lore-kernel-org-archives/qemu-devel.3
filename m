Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 426C1C5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:19:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wySgB-0001SH-6S; Mon, 24 Aug 2026 07:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wySg9-0001Qp-Eg
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 07:17:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wySg4-00057l-ST
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 07:17:23 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67O99VHh3575769
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 11:17:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=YPD83kuQ+6pNQ4ET6igkgI
 wLJF0cbgUoJH3jQr4+9Og=; b=CoSkdgpDDrtIpdqWTyAg0t8qxwTn+7xJ+UTrkS
 U9KN27qWsDX03EBotj0Odw0Dc7UaOscOLZCIC6JQV6jtWlUlm8F/eaOquxYnjVXF
 INwr48iub1lW3CEvjXaBXnQm5EmkjkxF35xEvFpG/9PP4w2p5NZWMTuYR7znT5ut
 iOJcuH5cqqdbtF4c+5QFNmhmIZ73l+IPrdlCtGssyHoILd8KzU6W8bQO5Cky1+fL
 bfiTDo2HxeUQxadLtIrJsy9BBjwPPh4ib5rQC4vO/dDYetkFLZ+NfsA4UheaCGQN
 yYGLTQBWPM8L4cGoCisy93pyI4OuUqUvtd7yCpbvk+ua5kJQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g88jpjcwg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 11:17:19 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-52d827597fbso35006271cf.0
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 04:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787570238; x=1788175038; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YPD83kuQ+6pNQ4ET6igkgIwLJF0cbgUoJH3jQr4+9Og=;
 b=GonGar+UPIZ6JPhWwvsfmKLHS8zdgNzBDilaXCDGQY8unhyShE405Ig1+r9BS9GImH
 GEALKEjr0o5CYC0GSvRJQHnlT163dAS6CzmnLa8ji1M+LTgXEU73Oqak424BrGAgi/6j
 hIuCqtczsON7/KoYXDSreKenODEDi4k+zjrqRTtfR5yTmYcfDtwg5Gl2ajUY1AkqE3iZ
 nTGdSBne0DXx+47GmyKbc+cvefkq2f5D2bM6pC+1HPeRJ9kOL0MPQk27wUiSePtquBmb
 KA+tKpVt17l2L1sWdbFG+J/A7P0Zx+YQr3r2LFrr7ZpfhLWTWJ6pQqP8HCgfhBekcmqx
 wksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787570238; x=1788175038;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YPD83kuQ+6pNQ4ET6igkgIwLJF0cbgUoJH3jQr4+9Og=;
 b=o/sFieP3M2bVGu9zNIyJYBoiN5SEGvSeR1lsVZpbeggGglvlKTiHVrxnoIJpARVX+Y
 B7XAtQ385BmRObAb/HJkDrrjOj6dkWKhWrdjuWOcekrlWN0TfGitJ1D8pp+Gi32+PAFx
 4AIWivsOc0p8MKhJw7yhVbS7lxfDN00kZwrXP76lDBVhJ6/uAegqy2BGZVDfYPUOEHiQ
 Qd+gSpZf8jVPrxNekfA12hgz5xEsaOx1UQJrYQSwKrgCVIB31BkZI+YvqR8C8P/iTEOg
 VwT8s8PnVCTOVZx3m2OBdGMEFpgSru6uDYezy2nRx55ijIjSqH0ueitn7aPrOUE2b9y+
 hFJg==
X-Gm-Message-State: AFuF++kWbqs8FmNSN8Bk+tph044c9sFWPKE7+gFkowEzdOpQXauGTK+9
 gv4JvrC8AWxd8XhpaBwT3SdKUG/n3AGh7u7cYJcNfUJaeKggj82CK252DAEsHs01coloNp/v+BK
 i2K65U8KE8CCslaC9J3DLBeHb2xHvbw0YnRVU/L5u5/b5275WT40vqSg+xivfgF+E6g==
X-Gm-Gg: AR+sD12GDOcBzlPb7miKWdHruPVK84akPfUy2yxVSaYEczrv7TwU+5Mf/F4JpF8dOtM
 PbHksXQT1QGiaRSxcDxVVjwwSG7ziXnYeusmEdh2vjiD0HpI3GGnEdjvfh3dLNXh2Ov4UolaWZj
 1hONT/NY/kSOOtj4QlbwzGeiPPDBZ1V4WBUmaeG/IaytFnfjXP5fXzWhvZeD6N9nCgADm0Oq+cm
 oGdiMdRhPH/RCV4WY1gdLfkjAvAogcdNs8xTUrs8zNxXHj01nqyL7Xb4IH4+ryKWV/uRMs0v1il
 kfT9AbcDv8PPA6MaphnhJ4p85zgiibTXEjVuoblVoZsjI0rCeD2sXUSMR4be1vYFKWp8CrTdTLx
 1ZOgXNOwKVXsr3zPrZ5jxA5W3E4J2z2Ojp4g0YVu1W+VROu7Now==
X-Received: by 2002:a05:622a:1ccc:b0:51c:44c:6ad with SMTP id
 d75a77b69052e-52df5a07b4cmr260561281cf.21.1787570238094; 
 Mon, 24 Aug 2026 04:17:18 -0700 (PDT)
X-Received: by 2002:a05:622a:1ccc:b0:51c:44c:6ad with SMTP id
 d75a77b69052e-52df5a07b4cmr260560651cf.21.1787570237517; 
 Mon, 24 Aug 2026 04:17:17 -0700 (PDT)
Received: from localhost.localdomain (44.170.88.92.rev.sfr.net. [92.88.170.44])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249606b161sm1336403066b.11.2026.08.24.04.17.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Aug 2026 04:17:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 00/20] cpus: Constify @cpu in SysemuCPUOps::has_work()
 handler
Date: Mon, 24 Aug 2026 13:16:49 +0200
Message-ID: <20260824111711.26297-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA5NCBTYWx0ZWRfXyLGW33ZxfdWm
 BJu68fTMh5v/TpCr0eOo6IXMeUZwJ2YIJGmHQ19pJcfdsqRognH1IDep4FZ90AemHXkSpqcK2y3
 O+6nt3k7C7Gi0kmxjMetRd3scVWa15pjKy4G7DQjZO+6oxEvx9WGOIDXkk4gYpdgCyWQuAcJYYn
 /YxScv7SddHx6aBtf3bP6F0k55IuqPANGX9hRp5WgzJUFQBSo4xKZv6Vk/yf04aNFqxldoB1dgJ
 MLITotg6/HdUw7/42kAmQ/ajr+uQ9lE/KPwMdlcVlRF/vWaYTRndbKL79DIvj57wCgbtPcDfrEB
 ztmworXV+lpMzWs/M1ZyIPwTFNoVwP4HmH+vHGUU5LcXr5FVUgyfJ30wDXExLESyFtmg8vBHBkK
 ZTjB7q7crGspmvEt1LyCSUR4HYig6e5NQN0uocc5ZidEfalJQKJqvJ9rFwc6BXcCBWo8IvgUKBi
 4ygeW/PCDBjCO9UkM2Q==
X-Proofpoint-GUID: -4Ga4nnGw2Q1Huvz1zp2mZurNvbpgYvH
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA5NCBTYWx0ZWRfX5q5KgXKG8fIZ
 l0BKr9RrSIOqUBz2HPQ+NW3dOKYRfxTkMojZ4Dk16Z+6fWEUET3Wk7ZDBv88F+d76tjDzPEJtws
 93qGSlOebawgDYpRkICPe2p37ne3DEA=
X-Authority-Analysis: v=2.4 cv=Xey5Co55 c=1 sm=1 tr=0 ts=6a8c283f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=s1NLoHz9uzatdv2VNqxUSg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=WgZ0fXF2DweS4szHog4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: -4Ga4nnGw2Q1Huvz1zp2mZurNvbpgYvH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240094
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Missing review: 1, 6, 11, 18, 20 (all new)

(I plan to merge myself once reviewed)

Since v3:
  - Fixed _Generic (rth)
Since v2:
  - Reorder _Generic changes first to maintain bisectability
Since v1:
  - use _Generic (rth)
  - no more RFC

No functional change; purely const-correctness improvment
to enforce has_work() callees don't mutate CPUState.

Build-tested.

Following checkpatch.pl errors ignored:

  2/15 Checking commit efef90983aa7 (cpus: Add const-qualified CPU environment accessors)
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

Philippe Mathieu-Daudé (20):
  target/i386: Remove const qualifier in ptw_setl*()
  linux-user: Uncast void pointer argument as Object in
    target_cpu_free()
  cpus: Add const-qualified CPU environment accessors
  linux-user: Replace env_cpu_const() by generic env_cpu() equivalent
  system/cpus: Constify various CPUState arguments
  target/arm: Constify CPUARMState for various cpu_*() getters
  target/avr: Constify CPUAVRState for some cpu_*() getters
  target/hexagon: Constify CPUHexagonState in
    hexagon_thread_is_enabled()
  target/i386: Constify CPU*State for cpu_*_interrupt() getters
  target/loongarch: Constify CPULoongArchState for various cpu_*()
    getters
  target/loongarch: Constify CPULoongArchState for various tlb_*()
    getters
  target/mips: Constify CPUMIPSState for various cpu_*() getters
  target/s390x: Constify S390CPU for cpu_has_*() getters
  target/riscv: Constify @iprio argument in riscv_cpu_pending_to_irq()
  target/riscv: Constify CPURISCVState for various cpu_*() getters
  target/sparc: Constify CPUSPARCState for various cpu_*() getters
  target/tricore: Document architectural interrupts as not implemented
  target/xtensa: Constify CPUXtensaState in
    xtensa_replicate_windowstart()
  cpus: Constify @cpu in SysemuCPUOps::has_work() handler
  accel/tcg: Constify @cpu in cpu_mmu_index() and TCGCPUOps handlers

 include/accel/tcg/cpu-mmu-index.h    |  2 +-
 include/accel/tcg/cpu-ops.h          |  2 +-
 include/exec/cpu-common.h            | 29 ++++--------
 include/hw/core/cpu.h                | 21 ++++++---
 include/hw/core/sysemu-cpu-ops.h     |  4 +-
 include/system/cpus.h                |  4 +-
 target/alpha/cpu.h                   |  2 +-
 target/arm/cpu.h                     | 55 +++++++++++-----------
 target/arm/internals.h               | 69 ++++++++++++++--------------
 target/avr/cpu.h                     |  6 +--
 target/hexagon/cpu.h                 |  2 +-
 target/hexagon/cpu_helper.h          |  4 +-
 target/i386/cpu.h                    |  4 +-
 target/i386/tcg/tcg-cpu.h            |  2 +-
 target/loongarch/cpu-mmu.h           | 20 ++++----
 target/loongarch/cpu.h               |  6 +--
 target/loongarch/internals.h         |  2 +-
 target/loongarch/tcg/tcg_loongarch.h |  2 +-
 target/mips/cpu.h                    |  8 ++--
 target/mips/internal.h               | 10 ++--
 target/ppc/cpu.h                     |  2 +-
 target/riscv/cpu.h                   | 53 +++++++++++----------
 target/riscv/internals.h             |  2 +-
 target/s390x/cpu.h                   |  4 +-
 target/s390x/s390x-internal.h        | 12 ++---
 target/sparc/cpu.h                   | 12 ++---
 target/xtensa/cpu.h                  |  2 +-
 linux-user/elfload.c                 |  2 +-
 linux-user/i386/cpu_loop.c           |  5 +-
 linux-user/i386/elfload.c            |  2 +-
 linux-user/x86_64/elfload.c          |  2 +-
 system/cpus.c                        |  6 +--
 target/alpha/cpu.c                   |  4 +-
 target/arm/cpu.c                     |  6 +--
 target/arm/helper.c                  | 41 +++++++++--------
 target/arm/tcg/debug.c               | 18 ++++----
 target/arm/tcg/hflags.c              | 35 +++++++-------
 target/arm/tcg/m_helper.c            |  8 ++--
 target/arm/tcg/op_helper.c           |  2 +-
 target/avr/cpu.c                     |  5 +-
 target/hexagon/cpu.c                 | 14 +++---
 target/hexagon/cpu_helper.c          |  6 +--
 target/hppa/cpu.c                    |  6 +--
 target/i386/cpu.c                    |  7 ++-
 target/i386/tcg/system/excp_helper.c |  4 +-
 target/i386/tcg/tcg-cpu.c            |  6 +--
 target/loongarch/cpu.c               |  4 +-
 target/loongarch/cpu_helper.c        | 20 ++++----
 target/loongarch/tcg/tcg_cpu.c       |  4 +-
 target/loongarch/tcg/tlb_helper.c    | 26 +++++------
 target/m68k/cpu.c                    |  4 +-
 target/microblaze/cpu.c              |  8 ++--
 target/mips/cpu.c                    |  6 +--
 target/or1k/cpu.c                    |  6 +--
 target/ppc/cpu_init.c                |  4 +-
 target/riscv/cpu.c                   | 17 ++++---
 target/riscv/tcg/cpu_helper.c        | 18 ++++----
 target/riscv/tcg/csr.c               |  3 +-
 target/riscv/tcg/tcg-cpu.c           |  2 +-
 target/rx/cpu.c                      |  4 +-
 target/s390x/cpu-system.c            |  4 +-
 target/s390x/cpu.c                   |  2 +-
 target/s390x/interrupt.c             | 22 ++++-----
 target/sh4/cpu.c                     |  6 +--
 target/sparc/cpu.c                   |  6 +--
 target/tricore/cpu.c                 |  5 +-
 target/xtensa/cpu.c                  |  6 +--
 67 files changed, 352 insertions(+), 345 deletions(-)

-- 
2.53.0


