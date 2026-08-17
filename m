Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 145D7C5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 10:55:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvv06-0002v1-J6; Mon, 17 Aug 2026 06:55:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wvv01-0002qP-Ou
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 06:55:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wvuzy-000634-Ms
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 06:55:25 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67H9dvwM1543106
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 10:55:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=ZNPEsPIvIv4NW25fLSac8J
 0wyHQL9LMP3vgyTDpEKqI=; b=EHXXtrYmr1QwA3xIsFNr5LF1Fj0+4UYJfDQaiZ
 7fVMM5Q+WThBUA2jELT6jDzjyiMIvW+pjsJdSnMfchB/VeMzJr0aRttk518ze6tG
 V/5D1ousswlO9tCuzk/KBw89WYMjbAHpaNO0MIzGUswY4gV1G1nQRgqkOPOFDSSV
 BQj8Kj2aRRE9ki4MVYhD7KLq5PzlUHiFBKCWG0OBf+/wHQvccWecCGOZwggWi1i3
 TSIAT+MAu/V4rOpF0JUVlXnnVbRorZaCG7aL8CrAkjBOGrlqZOy1DewHb9bLQmzX
 k6Z9Mp6BiYo3R8DFs161rwfu5glY9BgcgEd1KaJzFuFWOilQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3xw8gh3m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 10:55:21 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-384d033f7f5so602953a91.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 03:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786964120; x=1787568920; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZNPEsPIvIv4NW25fLSac8J0wyHQL9LMP3vgyTDpEKqI=;
 b=egzjiQMLwt0wxGqq9tMzE5b/D8mcr+7fzDpJdeCR4Lc1xb0D5NVi8iu9rxdfi6dN/e
 YLvZ02IexWapPm9KB/leVsl3cRiJH0FugjIrK7l5dQAwyZWWc3SKSeJnwpuNjhsRF3VF
 SZuOhbToZpMR3bO0lpD32NQLSMsyFGibAsx+wlmMki0I5h7itR1AA9zVKg8m+lE4iRhD
 Vyq2cSeIFyZYSWKe22ZUeTCu1bh+qrtbTxjFrZMCzTL4mytU1oMNEgSCMh8dFx+wEtkM
 /HmayUWVQQWj/NrIb7JQFsPLIO8LpA3SiWuu1sYNmrQe+Imo6/kgEgJeWCe2/36G/0La
 WyrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786964120; x=1787568920;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZNPEsPIvIv4NW25fLSac8J0wyHQL9LMP3vgyTDpEKqI=;
 b=ZLH3xZbYu854XHugHW+EXRV+1e2yOoFUNvNvbXCWScHtObGrq4NH5nDOoZ2Az2XFIB
 a3QCouRG09cGxIea+CFZCsIOCjhfMmMcEPWbCyOdI+qsWnqjuHj61qKQknONnUalu+XJ
 T9DXBrU5mTpanTk9vR6G1rBDJauJ5pKsF82McJVOk5AfeIr5jUYI0e+5QoWQ54cia2Qq
 2nSkLY+XIeIjT0MugL2hBGBjJpuaHsNd0ujnLfsOM0NIS1OSMv+h6UJKieq5iyMCjlHJ
 VGJSrM84P6KecmbB+hkqgEOaVuUakujJO+ryK2H8t0UFKLfupqTkuiyWNsbpDrM4MpHM
 cIEg==
X-Gm-Message-State: AOJu0Yw+suLqEPtTxVA5KWqaNMAOhCmA966g7SOXHWT0ysY2yaTAdlfa
 LboyrQMmLHSDfp9kO92Nfb/pfvS6jw3BkALczHSM9alMuc+9zRuUgx+7grJ3sDE+FYhSwpwAtcu
 pCLPVvuIXAeOGtxFXhSuBLcZIog6wH30vUPk4TuFeDMx4yBsHhtUnk1tkq43FqT3WFxPw
X-Gm-Gg: AR+sD12evhziE9Ilpd/oJ6CHyjK9XJ0CVKcEx0VQX6B3VsD8ZppMEamcC8kHO99T9YU
 Rfx06kdAOWs4y+PuuNlm8G/0cQdjtHprKwzuxZmMd/lJCzke1R67iYbodbdN1SSOETGs6zBXoLh
 tOKvHMmOAGbrcT6ySXKrL+ZHQRejIsWX+l5ZLH+aInBjGXg4hC5NVW087Cjo4J7ImMnhfK2tNVN
 CiIPnWcOFpAZt+Dr0UpB69iuKoTuY4WnWbnSpb6pkQQn0THE5kaP4bq+w/0VPme8Q8a2TMC8M6B
 hAQqz7eXmEzOp3cMeSpOyqXoxNcBtWrZHlSiXCKeaqC9O01g1IhgItOrcGLjbCceUoHBtESE62Q
 MWxA26py5T3GA81DMi3lXpMypDxoxGE2OEEbK40EjJXdW5HgVN7D+UPjJ3k5g+M+f8xf6Ckc/KK
 sHutqZwvHB4ae+pH1wWqpWyRa5fPC+o7c=
X-Received: by 2002:a17:90b:1d44:b0:38f:57f0:1f51 with SMTP id
 98e67ed59e1d1-3933b84ddd6mr16586322a91.0.1786964119978; 
 Mon, 17 Aug 2026 03:55:19 -0700 (PDT)
X-Received: by 2002:a17:90b:1d44:b0:38f:57f0:1f51 with SMTP id
 98e67ed59e1d1-3933b84ddd6mr16586297a91.0.1786964119392; 
 Mon, 17 Aug 2026 03:55:19 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3267c389363sm5431136eec.23.2026.08.17.03.55.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 03:55:19 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
Subject: [PATCH v9 00/10] riscv: add initial RPMI virt support
Date: Mon, 17 Aug 2026 16:24:54 +0530
Message-ID: <20260817105505.2607506-1-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ghr4doPRvDBRKHGXNWUb2OUBZiMW_2nT
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA4MSBTYWx0ZWRfX58kavAdGp7/h
 A5CYdINtDUOPQgP6SH2uf467edGTKLuF782Vv3IHQ9w/tcjZ8zH0/6ishIvrjGXbcl7vb6djYZE
 WmmIorcCrXkL4agGWHOzhdzB7buTFlk=
X-Authority-Analysis: v=2.4 cv=SuCgLvO0 c=1 sm=1 tr=0 ts=6a82e899 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=NEAV23lmAAAA:8 a=go1Wfyv6ChRcmlOJSf0A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: ghr4doPRvDBRKHGXNWUb2OUBZiMW_2nT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA4MSBTYWx0ZWRfX1f0xb7iD9pwA
 3OLjYarqgITXm6EubH5HjEcBPivZh1bFvD5w/BllY2eyaD6HaMFsiOsBjNZdmzkQwmaaveoMMrX
 ikAygB9h/cgM4sQDRK+MbS1evPp/ebomCgypTYM4Huu4/ekDHPN0tE5WqJ4qMjsSRpbzeLhr6Yl
 9tgP4uHvHo/ZAUywUwyZPlLJ3bWSaGqbNIcuM/kLh9HmYrDDAo8YI/rFEyUSqXNrfF5sy82q7Aq
 x6mCZ9j/sozMX+xvr8t3esDV9yLryerkMrgC2mv7DiwP0ySG8sM3JbXwUughAuQf2WMnqhAT1dH
 u11Z9kmBFnjQOZuXmqRIvx0AJALmf79BiUNAjLuWqKF11DROwbPTjcrzwOCHknZTWgyZOFmeHTq
 mNEQSU/Y/2Hn8RmVl2pOpFcUsdMYIrkDr7T9WDR0/2MXesSyXAGXOosmkjyURidOyTcyyiY7SFn
 BdVQ3QFt6uDTZSQOEMQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170081
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

This series adds initial librpmi-backed RPMI support for the RISC-V virt
machine. It covers the optional librpmi build dependency, the RPMI
transport and Base service, virt FDT wiring, opt-in machine support,
System Reset, HSM, System Suspend, documentation, qtests and a Linux
guest smoke test.

librpmi provides the host-side RPMI service-group implementation used by
this QEMU device model. The upstream repository is available at:

  https://github.com/riscv-software-src/librpmi

The documentation patch adds librpmi build instructions, "RPMI qtest
coverage", and "RPMI firmware and guest smoke" sections to
docs/system/riscv/virt.rst.

Changes since v8:
- Series-wide:
  - Rebase on current QEMU master, commit 539bc315538a.
- [02/10] hw/misc: add RISC-V RPMI transport and Base support:
  - Update the RPMI transport shared-memory helpers for the current
    physical_memory_read()/physical_memory_write() APIs.
- [08/10] docs/system/riscv: document initial virt RPMI support:
  - Add qtest coverage documentation alongside the existing firmware and
    guest smoke test notes.

Changes since v7:
- [02/10] hw/misc: add RISC-V RPMI transport and Base support:
  - Drop the redundant internal RiscvRpmiServiceKind field from
    RiscvRpmiServiceConfig and use service_group as the single dispatch
    and FDT service identifier.
- [05/10] riscv: add RPMI system reset service:
  - Move the RiscvRpmiServiceOps table and service_group lookup
    infrastructure into this patch, so the HSM and System Suspend
    patches only add their own service entries.
- [06/10] riscv: add RPMI HSM service:
  - Build on the System Reset patch's service_group lookup
    infrastructure instead of introducing it here.

Changes since v6:
- [04/10] hw/riscv/virt: add opt-in RPMI base support:
  - When RPMI is enabled, advertise reboot and shutdown through the RPMI
    system reset service instead of the syscon reset nodes.
- [10/10] tests/functional: add initial RPMI virt guest smoke:
  - Extend the functional guest smoke test to check the RPMI reboot and
    shutdown devices reported by firmware and exercise the reboot path.

Changes since v5:
- [01/10] build: add optional librpmi dependency:
  - Fix the librpmi configure probe to check the system suspend service
    group API used by this initial series instead of the later logging
    service API.
- [04/10] hw/riscv/virt: add opt-in RPMI base support:
  - Keep later SBI MPXY/FDT stubs out of the initial no-librpmi stub
    file; those stubs now live in the later stack layer where their
    prototypes are introduced.

Changes since v4:
- [04/10] hw/riscv/virt: add opt-in RPMI base support:
  - Drop the unused machine-opaque argument from the RPMI machine
    callback API.
  - Move the no-librpmi riscv_rpmi_create() fallback out of the public
    header into a dedicated hw/misc/riscv_rpmi-stub.c file.
  - Add a matching RPMI FDT helper stub file for no-librpmi builds,
    while keeping the real rpmi-fdt.c source gated on CONFIG_RISCV_RPMI.
- [05/10] riscv: add RPMI system reset service:
  - Drop the unused machine-opaque argument from the RPMI machine
    callback API.
- [06/10] riscv: add RPMI HSM service:
  - Drop the unused machine-opaque argument from the RPMI machine
    callback API.
- [07/10] riscv: add RPMI system suspend service:
  - Drop the unused machine-opaque argument from the RPMI machine
    callback API.

Changes since v3:
- [01/10] build: add optional librpmi dependency:
  - Use "RPMI support" for librpmi-related Meson option and summary
    text.
  - Add Reviewed-by tags from Daniel Henrique Barboza and Philippe
    Mathieu-Daude.
- [02/10] hw/misc: add RISC-V RPMI transport and Base support:
  - Use the Resettable API instead of device_class_set_legacy_reset().
- [03/10] hw/riscv: add RPMI FDT helpers:
  - Gate the RPMI FDT helper source on CONFIG_RISCV_RPMI.
  - Add Reviewed-by from Daniel Henrique Barboza.
- [04/10] hw/riscv/virt: add opt-in RPMI base support:
  - Mark no-librpmi stub parameters with G_GNUC_UNUSED.
- [05/10] riscv: add RPMI system reset service:
  - Add Reviewed-by from Daniel Henrique Barboza.
- [06/10] riscv: add RPMI HSM service:
  - Add Reviewed-by from Daniel Henrique Barboza.
- [07/10] riscv: add RPMI system suspend service:
  - Add Reviewed-by from Daniel Henrique Barboza.
- [08/10] docs/system/riscv: document initial virt RPMI support:
  - Add Reviewed-by from Daniel Henrique Barboza.
- [09/10] tests/qtest: cover initial RISC-V RPMI services:
  - Add Reviewed-by from Daniel Henrique Barboza.
- [10/10] tests/functional: add initial RPMI virt guest smoke:
  - Drop the stale Ventana copyright line.

Changes since v2:
- [08/10] docs/system/riscv: document initial virt RPMI support:
  - Document how to obtain and install librpmi for QEMU builds,
    including source build steps, Debian/RPM package targets, pkg-config
    setup, and the minimum librpmi version.

Changes since v1:
- Series-wide:
  - Fold reviewer fixes into the original commits.
- [02/10] hw/misc: add RISC-V RPMI transport and Base support:
  - Move Base service configuration into the Base support commit.
- [08/10] docs/system/riscv: document initial virt RPMI support:
  - Add RPMI v1.0 Ratified context and specification references.

Subrahmanya Lingappa (10):
  build: add optional librpmi dependency
  hw/misc: add RISC-V RPMI transport and Base support
  hw/riscv: add RPMI FDT helpers
  hw/riscv/virt: add opt-in RPMI base support
  riscv: add RPMI system reset service
  riscv: add RPMI HSM service
  riscv: add RPMI system suspend service
  docs/system/riscv: document initial virt RPMI support
  tests/qtest: cover initial RISC-V RPMI services
  tests/functional: add initial RPMI virt guest smoke

 Kconfig.host                               |   3 +
 MAINTAINERS                                |   3 +
 docs/system/riscv/virt.rst                 |  80 ++
 hw/misc/Kconfig                            |   4 +
 hw/misc/meson.build                        |   6 +
 hw/misc/riscv_rpmi-stub.c                  |  16 +
 hw/misc/riscv_rpmi.c                       | 544 ++++++++++++++++
 hw/misc/riscv_rpmi_hsm.c                   | 287 +++++++++
 hw/misc/riscv_rpmi_internal.h              |  41 ++
 hw/misc/riscv_rpmi_sysreset.c              | 206 +++++++
 hw/misc/riscv_rpmi_syssusp.c               | 191 ++++++
 hw/riscv/Kconfig                           |   1 +
 hw/riscv/meson.build                       |   3 +
 hw/riscv/rpmi-fdt-stub.c                   |  37 ++
 hw/riscv/rpmi-fdt.c                        | 103 ++++
 hw/riscv/virt.c                            | 176 +++++-
 include/hw/misc/riscv_rpmi.h               | 106 ++++
 include/hw/riscv/rpmi-fdt.h                |  41 ++
 include/hw/riscv/virt.h                    |   3 +
 meson.build                                |  14 +
 meson_options.txt                          |   2 +
 scripts/meson-buildoptions.sh              |   3 +
 tests/functional/riscv64/meson.build       |   2 +
 tests/functional/riscv64/test_rpmi_virt.py | 184 ++++++
 tests/qtest/meson.build                    |   2 +
 tests/qtest/riscv-rpmi-test.c              | 684 +++++++++++++++++++++
 26 files changed, 2740 insertions(+), 2 deletions(-)
 create mode 100644 hw/misc/riscv_rpmi-stub.c
 create mode 100644 hw/misc/riscv_rpmi.c
 create mode 100644 hw/misc/riscv_rpmi_hsm.c
 create mode 100644 hw/misc/riscv_rpmi_internal.h
 create mode 100644 hw/misc/riscv_rpmi_sysreset.c
 create mode 100644 hw/misc/riscv_rpmi_syssusp.c
 create mode 100644 hw/riscv/rpmi-fdt-stub.c
 create mode 100644 hw/riscv/rpmi-fdt.c
 create mode 100644 include/hw/misc/riscv_rpmi.h
 create mode 100644 include/hw/riscv/rpmi-fdt.h
 create mode 100644 tests/functional/riscv64/test_rpmi_virt.py
 create mode 100644 tests/qtest/riscv-rpmi-test.c


base-commit: 539bc315538afe036a4b99088659aa82e3b489f2
-- 
2.43.0

