Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56CE9CD8C9D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 18:04:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXjkZ-0003s5-QV; Thu, 11 Jun 2026 14:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXjkX-0003ru-VW
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 14:03:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXjkW-0006wM-AG
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 14:03:29 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BErYqv942536
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 18:03:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=lbRWp0ZdLzDp4A2aV5R1Bo
 T6gHpNuq/2uz5o0kuvqKI=; b=FMVO97PwGJE5mXDAuhbWOteLOMVNt+zWRP4nL6
 vbNbz5ie48DDM8XCm6W+tGx+VovklflwxcnGOoOIPTP1HHAqSJ0DWWMZYiUzsvIA
 HXhwL6iai43+iX+ixucn9ELN+EzdiruuG0y+0hLXXefUtFsqWdxeF4dFKL9usCWz
 h+pc3HCTWTUdoujhsDtYnB69Yl/5o52O2/p/z4JOX5fdLtb4qYpHHy7qWpRO9mub
 Eh4ilU6P+GqXMydREfZw1UgF/btxwokci0bsf4TkTRkMp9XZy2Y7OuX7oX6DBz8/
 B+0sMPph4GIWd3Fm+wqY8fyY4zS9GIT3F9xVV6b4xx+FrIUA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6tmyg0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 18:03:25 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3075fa5a407so558267eec.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 11:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781201005; x=1781805805; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lbRWp0ZdLzDp4A2aV5R1BoT6gHpNuq/2uz5o0kuvqKI=;
 b=LtiKkT9haMJddxb0B8xK21ATj8EGrebq6nEclP3OVJExAhKESLTw/gvGTaW81ykMxB
 gUQowYpzKZA2Nrf89H3vSRR2FAjHy+7VGFZ1ZrF9QNy0lpZyaXRujo6fwCYgOegwHbYe
 9SBKk9GZfHtcxLyuVRdLyFtrB+5RwlGm2nihhXDMUPeBsyRUlW1GOk5Ygv369/98nFmD
 7RmVlbw0GcGR9aCF6XwBtHMewrFz1NXC5Iy4AFCGIk5Vth+Mk0LvRrMu4DvzN2tFhnFk
 J1Pa5jwITer6KwWPvQaO7kJlX9cKTgA5ws6dEk4BhN+Ekn0vkaGBG9pNfeZetEyi2Ltt
 2YJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781201005; x=1781805805;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lbRWp0ZdLzDp4A2aV5R1BoT6gHpNuq/2uz5o0kuvqKI=;
 b=nhQUARca2mWyTCGVFgL/BrXckBY82gdN4NjDvzASnSpb870U62CjxiYyUr7kmEYaaK
 CPsETDXGx3EEpzfYOJJjXD6IGO8VYAxRjQF/9KCA2T2T71x0MgGP2S3LTM4NPG/Z/umO
 yHz688tV+hzVEC+crke5jx3CGDzXyxS3wn6+uo197z+MWS0GjfztpAUjQNCsxlno9B6P
 QaL66ddawCVOShlcRHezKLlkGWRlCNzz/1pdO6UbkJEi0L/ncROvtOq7gVb6sF9HEnDT
 I4Uu/xpoRSMuJFWyEFHu32e5ehjPMtRFTHpoFjnQcKnw7JbKo6FTkCHwNzKZ7ZL/MoxU
 xktA==
X-Gm-Message-State: AOJu0YyZLgQX0sfBUW10PKmafwa4BdZdageMJeM7vVWLOSqRgF1g4eK7
 8L8YmUWeO1H5gIqMqFRi5ERY4pu3Y9Zd0U2lExneAaBowP4hacLE2H1qEeZaf3AqMrO0Alz+S+n
 UsWCugFM5cF+0gril5uOV5Gwi91NbrEnzAkHcTtIIcaiIc/EKZh7C29TC9jURXYekuTgi
X-Gm-Gg: Acq92OEVKETPOU1J0ooA0K986YyFV8ocewHKzvslqL1hYfWyIvY4QGz254VlVKnthOr
 JNcnW9RLwpL1M7dlh/PsTht+icbxxt2I9vH4VacpBmye7TU1tjSdJJ2M/Rb6njwtP3JaHjmwXXW
 InOBUyTL4wofRBIAGVzmUyw+rohO7jkDbVTOMASJVOs6bNf0/zXRmx9XA6WRok0Fmill0bs9zjM
 ehBChACX8rQ4uM4jDFuDHIp2OhCmY0rPQ5Ptg3YHgtWGRk2fY5BruP/HIVi1Z1aysuX1kG1roR6
 B7WhrZrXG0y216bOA7Iylc9+yj2yaBlYH+U0l0Ym3tiF3qllNL7sJ2JVwnsYsHRT8ZX300fzLjM
 hVUOTSKGOWvCRR1OH6ybXWl+8spruU3l78nHxUhl7AdsRusY5q00htpDGInVbVIEJZvLIXBMCzV
 qNumKTxiHN
X-Received: by 2002:a05:7300:df44:b0:307:3a6c:ecea with SMTP id
 5a478bee46e88-3080461f742mr3155396eec.1.1781201004529; 
 Thu, 11 Jun 2026 11:03:24 -0700 (PDT)
X-Received: by 2002:a05:7300:df44:b0:307:3a6c:ecea with SMTP id
 5a478bee46e88-3080461f742mr3155333eec.1.1781201003968; 
 Thu, 11 Jun 2026 11:03:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606c0fc40csm559036f8f.29.2026.06.11.11.03.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 11 Jun 2026 11:03:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 0/6] system: Clarify legacy
 physical_memory_read/write/map/unmap API
Date: Thu, 11 Jun 2026 20:03:14 +0200
Message-ID: <20260611180320.30320-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE4MSBTYWx0ZWRfX2TmNfmr3Ocqi
 vWJnfo6qaRijl7J5RYyGKryWTxWjH7bwIN9jVBaJUWnqi6dAHug/wYsXsAYCoHdHvJO2x4nIqdM
 XO3qSCFqoFUuTinE5x1/OfA/DOI6TE6ClnvV5VTWy4ehRS48cAJC2xfVHi6B3AleORbu3S4aUfg
 mJc5Q61jnkzBcHFVeb1BRxokZkDGZN7yGf88luOIWkhqLuxq5YdVRrg6up5OHMfqsATGuYnrwBa
 Pb78ve/urlfgszjVtxFN6Nzs8f2G6pT/taynuCWdB1Rox60SmJMB3g3ODtZKJit79UruvWmRMxM
 xxit8Gcak3dRE8nz4JY56oiWozfTP56gZegYuVxuCZkgtGgCwyA2p6yTI1fpGlafEQNeVESIJP2
 3exdESO11thjfIMG+HxCI4ggZcVCRd+8kmJ4nuLE/7ZfTUZu1lm0SBUuGsQvQCCj0UCVlc8V72W
 kay7CUi1AwdcU/MfQfA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE4MSBTYWx0ZWRfX3wQ8Ix2f/xxa
 VM8iCf2NJVhrQ3Zpe/tF4xI7Ma+tLaZ9C0gulUVYbNqFdRaVa+m0T/4BUiouKW7PME3uia51U53
 /EYglb92ZssnHTPbWb+IDeanNLn5TwQ=
X-Authority-Analysis: v=2.4 cv=AaiB2XXG c=1 sm=1 tr=0 ts=6a2af86d cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=XEOm3FV0vn0os_yc_hoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: gTtP_XY4ssUWKx_ubRQGuWXe6UbeE7ma
X-Proofpoint-GUID: gTtP_XY4ssUWKx_ubRQGuWXe6UbeE7ma
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_03,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110181
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

It is not obvious the cpu_physical_memory_read/write/map/unmap()
methods do not involve vCPU at all and use the legacy global
address space. Document that, because this is an issue for some
board which doesn't use it at all. Rename the methods stripping
the 'cpu_' prefix.

Clean a pair of dubious uses out of hw/.

Philippe Mathieu-Daudé (6):
  system: Document cpu_physical_memory_*() declarations
  accel/kvm: Replace legacy cpu_physical_memory_write() call
  gdbstub/system: Replace legacy cpu_physical_memory_read/write() calls
  target/s390x: Factor common s390_ipl_read/write() helpers
  target/s390x: Replace legacy cpu_physical_memory_read/write() calls
  system: Move cpu_physical_memory_*() declarations to
    'system/physmem.h'

 docs/devel/loads-stores.rst            | 18 +++++-----
 scripts/coccinelle/exec_rw_const.cocci | 16 ++++-----
 hw/xtensa/bootparam.h                  |  6 ++--
 include/exec/cpu-common.h              |  8 -----
 include/system/physmem.h               | 50 ++++++++++++++++++++++++++
 accel/kvm/kvm-all.c                    | 12 +++----
 dump/dump.c                            |  3 +-
 dump/win_dump-x86.c                    |  5 +--
 gdbstub/system.c                       | 11 +++---
 hw/acpi/ghes.c                         | 24 ++++++-------
 hw/acpi/nvdimm.c                       | 13 +++----
 hw/acpi/vmgenid.c                      |  3 +-
 hw/audio/marvell_88w8618.c             |  3 +-
 hw/char/riscv_htif.c                   |  5 +--
 hw/display/exynos4210_fimd.c           |  7 ++--
 hw/display/omap_lcdc.c                 |  5 +--
 hw/display/ramfb.c                     |  7 ++--
 hw/dma/i8257.c                         |  9 ++---
 hw/dma/omap_dma.c                      |  6 ++--
 hw/dma/rc4030.c                        |  3 +-
 hw/dma/sifive_pdma.c                   |  9 ++---
 hw/hyperv/hyperv.c                     | 25 ++++++-------
 hw/hyperv/syndbg.c                     | 13 +++----
 hw/hyperv/vmbus.c                      |  9 ++---
 hw/i386/kvm/clock.c                    |  3 +-
 hw/i386/vapic.c                        | 21 +++++------
 hw/intc/apic.c                         |  3 +-
 hw/intc/xive2.c                        |  3 +-
 hw/m68k/next-cube.c                    |  3 +-
 hw/microblaze/boot.c                   |  3 +-
 hw/misc/pc-testdev.c                   |  5 +--
 hw/net/fsl_etsec/rings.c               | 13 +++----
 hw/net/mcf_fec.c                       | 11 +++---
 hw/net/opencores_eth.c                 |  9 ++---
 hw/nvram/spapr_nvram.c                 |  9 ++---
 hw/ppc/amigaone.c                      |  5 +--
 hw/ppc/e500.c                          |  3 +-
 hw/ppc/pegasos.c                       | 11 +++---
 hw/ppc/pnv.c                           |  5 +--
 hw/ppc/ppc440_uc.c                     |  9 ++---
 hw/ppc/spapr.c                         |  3 +-
 hw/ppc/spapr_drc.c                     |  3 +-
 hw/ppc/spapr_events.c                  |  9 ++---
 hw/ppc/spapr_hcall.c                   | 17 ++++-----
 hw/ppc/spapr_rtas.c                    |  5 +--
 hw/ppc/spapr_tpm_proxy.c               |  5 +--
 hw/ppc/virtex_ml507.c                  |  3 +-
 hw/s390x/css.c                         |  5 +--
 hw/s390x/ipl.c                         |  9 ++---
 hw/s390x/s390-pci-bus.c                |  5 +--
 hw/s390x/virtio-ccw.c                  |  5 +--
 hw/scsi/vmw_pvscsi.c                   | 12 +++----
 hw/xen/xen_pt_graphics.c               |  4 +--
 hw/xtensa/xtfpga.c                     |  5 +--
 system/cpus.c                          |  3 +-
 system/physmem.c                       | 12 +++----
 target/s390x/diag.c                    | 43 ++++++++++++----------
 57 files changed, 310 insertions(+), 224 deletions(-)

-- 
2.53.0


