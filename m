Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F6ACD98DE
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 02:09:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZJEM-0001Gt-LW; Mon, 15 Jun 2026 22:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZJEK-0001GX-Ut
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 22:08:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZJEJ-0000ra-F1
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 22:08:44 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65G1xgtC2300064
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 02:08:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=2wBVR0SDOAsogayeBDetb+
 JKAg3Gz84XwRCpgpippPc=; b=VgSayQ7YPQk+Zl8/9EeDJEdMlyDlyIR+xyoPT3
 njL2h/FjZud7uBISSKvDinhj3nDYh4nyoZgfM/FWakT5vaMchy4c1swqGq86pwDR
 sTZXQdLFIDfKMlcYzfRhyyApC9Y29o7uPRthEUeNhpMAvNm9FlRUhpEK+hfUcnXJ
 9+EC1YPp4SB4XuUPnH4ro+vN4nQiJxbr4FhfG/9QEoRkshazRHcLCL9T4q+9E6mn
 YGbbW5t2J2VzrHroSKvcqvZTepXmhR5TeYQkZqg6DVQNURxJZGBghBDelFz49Hb0
 7oHQYIiA6R4UPAthIm4XKBxWIRXaytArC9EHFHsy8S2cxq0w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eter245uq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 02:08:42 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9159c4b210aso653247485a.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781575721; x=1782180521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2wBVR0SDOAsogayeBDetb+JKAg3Gz84XwRCpgpippPc=;
 b=JG2343cjRRvzkT7qitAGI6eC+9oBqkLZdkpQFjIeKYhOPk4ykA40To1BMN1Nh9ubJk
 Z3kHcwyk4h3RUf4e34J+7z9AOooi22DomQ6yViL19iFzuqHHL9ynE7cplAAid/RmxS7a
 oEIDNrEKdJGCJGRXqDW3ye0y+fJ13+7dtOF+JKv1P3ZG12ClMpoaeLABCwaprPXudalv
 nuwo8CeBxcorkhJevKWjmMAE80z3HU57kAAuz5LWizjtpK3xvEzzV8wajQDikf0ZYvCx
 onHfoO/CgvK0jB6mdYkjTGgDClD45GsTK70nhfxTddbd9JXWsc8JfnED01gduI9farX8
 Vqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781575721; x=1782180521;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2wBVR0SDOAsogayeBDetb+JKAg3Gz84XwRCpgpippPc=;
 b=FB7Ug0Iw3xwH6OdTPWlJlJ4CdJ5M3Eoas1jjqe3hIZzhyAwzh49Bkc8VoCFZPWxbem
 XcCu4SBDdgI3r/CCRvF3N1IFXyjjx0wlYSJfZtnudpxzs88olYqaZandHeLUVt+Y9634
 qyy2n9QfcyuX3Wn86w1GPDav2779On8nFZwPQQM9cU+epB6L/E8APqsIUfTvBBL3rHDc
 RLz8or0JiAS0KFM5z8iyDnJ8SO0NiMSWcNEj0Yb3XHD00r2v3JRo7glShah7y363CfCp
 qVR5NxQf4FKK9elNaq8W456h5Q/P9DklvfxXctkKfRTRNvib9QHffCGRAjn0evKXxidR
 xzzA==
X-Gm-Message-State: AOJu0YyGv4s4Eqa/0ASqGS8VBit2zWV/ZVF41tDKrUZ+Efqy3f+d9WzZ
 Nyu6AHJ84KY4z5B1u47OhzljrZdwbk0o+4A3gy8jHFO1xJsOl3pCxl5EaIfZ6RYR14/3cSvleKb
 W0hNehRTx9N4a4dM/JxzmZzbv+SbpgsebUkDMmEsnG2ekoN507W2Uzrw6U2IIGZ3DqA==
X-Gm-Gg: Acq92OHbsE85PLNv8lwBbN95DUo51Rv5JiBosd/KA5AGZjlbnmta7oRbp34aaIOakJy
 xOryE88WGXD/lDvuaWGQCy1TuTldnByf6LTbm6mx6GyjGFdxditISwfPIL+ytEWKq0vOYzMrkIK
 +WAOqeCfbMQ3txBv8uu91aHCq2VttE1zuqyMoTnlPes/MuLie5RmzhD3goxjkQHdcpuFmzRAq/T
 sjH1XUevjyKIAunR2s6yhbMku2pzbASBEJStl2hFGgJ/s0BpVIwPwxx7h2RXh9RJgIiLiOlTKOq
 2baCPfsAg3JDm77JHmBDe8+9VDdDkAiZYBxVqmMNDOEHFo9UG4WaoAnbmXMPcIS7CtENflX2LXO
 sP5DloVsJoWHDAtgFMFq7/sdzDkfJv90yJRtKW/tYIbI0Gz7MJ/XJkLU/UhDM/XeH7U1a0K1zeK
 trNDQ=
X-Received: by 2002:a05:620a:44c4:b0:916:1765:b774 with SMTP id
 af79cd13be357-91c2e9fd4ebmr292472685a.21.1781575721545; 
 Mon, 15 Jun 2026 19:08:41 -0700 (PDT)
X-Received: by 2002:a05:620a:44c4:b0:916:1765:b774 with SMTP id
 af79cd13be357-91c2e9fd4ebmr292470585a.21.1781575721121; 
 Mon, 15 Jun 2026 19:08:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa47da9sm46214665e9.5.2026.06.15.19.08.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 15 Jun 2026 19:08:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 0/6] system: Clarify legacy
 physical_memory_read/write/map/unmap API
Date: Tue, 16 Jun 2026 04:08:33 +0200
Message-ID: <20260616020839.19104-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDAxOCBTYWx0ZWRfX5Z5yDpdVebDA
 CFDvUIaEQNebvhKNox2+a2CgoY2PsGUf2nwchib9+k2d2gO0IsTn+ANms95ftIZp0yUZVj/Ku9+
 P95wTplGDXo105TEAk7YBYlL1qJBIZs=
X-Proofpoint-GUID: SQ_aSpBsa1xIQKqM7SR9yLEuvzEnWer1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDAxOCBTYWx0ZWRfX0B06z1/5hRks
 +qsTOEf5I9dVf2qszYY0bhj676Gbm1wqtAnX6D+h1HFQXMIrPwsSZDDhDzlS12WdYZHv7/raSwl
 CmTvxBzBNroptkY8ClVKlgWpcUqP/M9yy4mjrrmjnp4O2r7hRMikJA/xnWPgUJPGrBAlIehRDz5
 RnWJvyXA8D7Ofu6UBLBcOnBuZOLEBjI6yh4ONw/+Plxss9P6DrKtw57uqECIiSnnydWZZZEitWk
 PQkyp2VCAaEVQTpBuFirJXSxqpeQ3wqYiUpWrwO6+fnbKDSU402MfYYIksNepZ337k9PyWDfNaz
 Yw6qVDVgo0/6DFPWJgdS0yEYoPaO37EpGQ2EmM6JtxwJh0zragGOwV4Eli0Zk4BbwpJvq94BSYo
 J/BckbDHohAkkcPiirr8Qy1vToo27uqxWsKFfiY5pUJumhZmZQutyjP92VDEfsEyOA+Ki8hZ6Db
 NHUB0ElyTrHWlR2E1cA==
X-Authority-Analysis: v=2.4 cv=F4tnsKhN c=1 sm=1 tr=0 ts=6a30b02a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=XEOm3FV0vn0os_yc_hoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: SQ_aSpBsa1xIQKqM7SR9yLEuvzEnWer1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_01,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160018
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

Missing review: #2

It is not obvious the cpu_physical_memory_read/write/map/unmap()
methods do not involve vCPU at all and use the legacy global
address space. Document that, because this is an issue for some
board which doesn't use it at all. Rename the methods stripping
the 'cpu_' prefix.

Clean a pair of dubious uses out of hw/.

Based-on: <20260616020359.18627-1-philmd@oss.qualcomm.com>

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


