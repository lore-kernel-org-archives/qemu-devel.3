Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD73AC61DD7
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 11:29:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzulA-0001in-31; Fri, 28 Aug 2026 07:28:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wzul7-0001iS-NV
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 07:28:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wzul5-0007Kf-7g
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 07:28:33 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SA7Qvr2061296
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 11:28:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=HA/vkVP8j5U+2nRKXht8xg
 BZWqrmmM3bI6lVkbS6Ceo=; b=AKkdUb0S7A2A3sBspXiVJm2bAwRmhqFhd1F8H4
 RSOmbCCnHxeyl22COLFD5qBo5Uzzy0EBLzGckf/Zq8fxwoPKrr3+oz9urm00HCuN
 NH2FAFLUJgJN0DGGY5vnE4x9QV84fC/Kms2WgceHRWUFEPNqt29xDf4R9f9YBWdz
 km56pzc1Ky4Hf6njrUE0PrZdIp0N4YyKUO3XI69E2Il5fyRfdssYynhqKeEE8mPD
 YluDaN0XHhgyqFRYFsoJLpVr2By8zF9SxF+wslRKKj7pyG0sLoNi/h275GF94OiB
 +iSrchXlpahQWl6qXvo7Cnw5w4lr4jXTLzagIZ85uM6umH8Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb3mu9fua-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 11:28:27 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38dc0eee75dso290313a91.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 04:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787916507; x=1788521307; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HA/vkVP8j5U+2nRKXht8xgBZWqrmmM3bI6lVkbS6Ceo=;
 b=dt5pHe1riCA24l3L9IN/VJdfEEfoNF5jdreZPO1FzfR60wgoJPzklqlllFP+ixhm6/
 yQ/DQtNIvo5AXb5GcTISuJIxwoWzdgW2BSXUcVRgFLQjZtYsBoo4aM1y9dBF8USvWZ2E
 PyrEpAMKsp206un0Up7HJElyfZFTCnH+Xm/B54CaRE7BWOkz6XmOV+YCtuAg01HtLcMb
 +PNqFZQ3h4+HH/842EVC8MILxfttfCrXgQmFMVNTYHdMPYXf6i/ncNRm7EN0X/zVVuNM
 2ARwkP2DuueQHLKobuUk+7oyzYibvIYnFIluyElDVRbNxRAlNyJukEWUXIPwZoWfWZnN
 e+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787916507; x=1788521307;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HA/vkVP8j5U+2nRKXht8xgBZWqrmmM3bI6lVkbS6Ceo=;
 b=dnBGIOINXPDtdDvMJ2tjWqF0LxRUApA1yE1iVNXKO1mZyzpSqpdY4xx4FJ/cHuND46
 /3QI7+Vo1yl5J64tfRJypcS1lxmpxbdcnzHL2CLbumIbKUWO1pUr+UJiyhLnOODlTYMF
 m/AlLddI0KietbpXBVYvAbKFpP7Y0J0HyihAXX7NlXzPE1CBE7JNp4/Ya8iCtR2wxfHW
 /GxEeBSp1wthBYxqd8168qgChLHG9v6+IHVNQ7szQRNNJbehW88ZEGie8Ebu7VlhzNXT
 VfrEZWsDtNZPdvs8bB5KapfqGNWXgzeY2/G4ZQEm/CXO0NNgH4SrlXwNwSPXUYLKIlBx
 t1uw==
X-Gm-Message-State: AFuF++nbgoO6UwucDOoqo0bnp6cVqI5NXwnNyfAKbUq95DDetCohUPgF
 x4pwyOD1wNk7NMAmSlNDTNSwCRLjdwgYGHZ/4fa88qDJD2OkZRmWyNUgWMg9XoavGXJ0FBSzuRS
 1EJiB4bPY2oiip2G7SniupNkCnUnJ4gFVjIAzaDtTyqoe8bkvfq1DjEkrTKHCoJWDvA==
X-Gm-Gg: AR+sD12TZt3VnXIf4z4x+pSBXI17e17dSkF5md3y4J0cDY3Vxsih+GJ+8dxd0dZKOZy
 0zqGjfCHQdw0Zm8poGuwlHv2O1epqQs40Rt4EQ6IHVKbJodz1d27VLG+7fJe+TKAE+5x39qBOiD
 CeaGVJroZAg4Z7tAMHGsEv4kqlT4wRQMPV5f62MJCKzMu2xEwwRPjp2PTG7s36+Qt+U0D9dpdDT
 iiUaLwoaubXCN2fv0mo/UaXKelwhvpB64bPplOsRXko9EN1DdHVyExTobtaHKl/4wspgu1dW/y3
 lwqiAzF+5VOPJoku41QneEWqKqEvs2nmWf4PAc5EUNxTvsqPGCdTuhtMQmj5bBBRPnWk5mlP8ue
 bMBshaM2MMX6lqpijT8MtSbv1syphvTxM15VD6bPQdlbHYa3j3fJmcCwecO9BAzfcx8IUZKFLeL
 dZOtTezhCf6HuYpktpnYNxyWp+qsDIN6k=
X-Received: by 2002:a17:90b:4c84:b0:381:bcfb:e710 with SMTP id
 98e67ed59e1d1-396d0fe0b90mr5812341a91.3.1787916506704; 
 Fri, 28 Aug 2026 04:28:26 -0700 (PDT)
X-Received: by 2002:a17:90b:4c84:b0:381:bcfb:e710 with SMTP id
 98e67ed59e1d1-396d0fe0b90mr5812271a91.3.1787916505978; 
 Fri, 28 Aug 2026 04:28:25 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e0de4d92sm4997320c88.13.2026.08.28.04.28.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 04:28:25 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
Subject: [PATCH v10 00/10] riscv: add initial RPMI virt support
Date: Fri, 28 Aug 2026 16:57:52 +0530
Message-ID: <20260828112803.86636-1-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ZbMt8MVA c=1 sm=1 tr=0 ts=6a9170db cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=NEAV23lmAAAA:8 a=MqH2nUcDTpyvXNrK82AA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: t9L8cps_wTHXDNQzuzAjSQdBscXAOKzy
X-Proofpoint-GUID: t9L8cps_wTHXDNQzuzAjSQdBscXAOKzy
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA5OCBTYWx0ZWRfX5CyRQM3zCNEr
 jL8NpzeXiCKr5MnGrhYezPjI81mrihcueKoJsh2KK+PaIqDI/2nT1JiGGZQHWxAYdVbjCk2xD54
 Mj3aJIYlODT6VDhmPxBF0hGxvVCTrdw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA5OCBTYWx0ZWRfX7vbh2yjQefOs
 OKPKkaFHWu+rw1FnuejT/GCaBEWgjrbIwVpsA9YqcfaBQSG+PS+kGZVY4HfbaDqvu1W3SOausWg
 PIesnSmxUOEezc7OCpEnLZAdZguF6rWd8OfGy1W+7valk6eSXcqK5aR7ZqIFk3l5GvQSTelAKYz
 GPAGqo+P13NLJ/tXczKHx7uG0Hx/VMJgubDxRlByBQzfa1rhqMpLQXNB9K64mWm3Q/f93spiRmN
 NIm4DFLk0mUK0N8PC5bkKQUNztqCsxvYlVoOJbtuxHNzLTzwx3OYy6cZQOFAvrnjoKASC6khami
 h7frR54plJX4Ha7OVkFm+zAdL18Z+HE2dIwE/vjP/2SHzzJCuxkSH19lZd8Wr2JzrgmI/QI04W2
 b5BRN/aJfHqMVQw3U2/Up7JGdfrF7I1pKsW/eMRJEXrUW2nbsEFIDw+gQF3w28H4bH2J98Bqqs1
 7sLf2ErlC6GCLIRePnQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608280098
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

Changes since v9:
- [02/10] hw/misc: add RISC-V RPMI transport and Base support:
  - Store RPMI doorbell writes in little-endian order using QEMU's
    stl_le_p() helper before physical_memory_write().
  - Validate the complete shared-memory fill range before writing.
  - Return RPMI_ERR_BAD_RANGE for invalid shared-memory accesses to
    match current librpmi.
- [06/10] riscv: add RPMI HSM service:
  - Honor the HART_START start_addr parameter by setting the target
    hart PC before starting it.
  - Keep HART_SUSPEND as a state-transition operation without forcing
    QEMU CPU PC to the resume address. Directly rewriting PC here made
    the Linux guest hang before login in the HSM stop smoke test.
- [07/10] riscv: add RPMI system suspend service:
  - Preserve the system-suspend resume address for RPMI request state,
    but resume the boot hart without directly rewriting QEMU CPU PC.
- [09/10] tests/qtest: cover initial RISC-V RPMI services:
  - Keep qtest coverage for HART_START PC programming.
  - Validate HART_SUSPEND state transition without requiring a QEMU CPU
    PC rewrite.
- Series-wide:
  - Rebase on current QEMU master, commit 0a1ebd448b38.

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
 docs/system/riscv/virt.rst                 |  80 +++
 hw/misc/Kconfig                            |   4 +
 hw/misc/meson.build                        |   6 +
 hw/misc/riscv_rpmi-stub.c                  |  16 +
 hw/misc/riscv_rpmi.c                       | 558 ++++++++++++++++++
 hw/misc/riscv_rpmi_hsm.c                   | 289 ++++++++++
 hw/misc/riscv_rpmi_internal.h              |  43 ++
 hw/misc/riscv_rpmi_sysreset.c              | 206 +++++++
 hw/misc/riscv_rpmi_syssusp.c               | 194 +++++++
 hw/riscv/Kconfig                           |   1 +
 hw/riscv/meson.build                       |   3 +
 hw/riscv/rpmi-fdt-stub.c                   |  38 ++
 hw/riscv/rpmi-fdt.c                        | 103 ++++
 hw/riscv/virt.c                            | 176 +++++-
 include/hw/misc/riscv_rpmi.h               | 114 ++++
 include/hw/riscv/rpmi-fdt.h                |  41 ++
 include/hw/riscv/virt.h                    |   3 +
 meson.build                                |  14 +
 meson_options.txt                          |   2 +
 scripts/meson-buildoptions.sh              |   3 +
 tests/functional/riscv64/meson.build       |   2 +
 tests/functional/riscv64/test_rpmi_virt.py | 184 ++++++
 tests/qtest/meson.build                    |   2 +
 tests/qtest/riscv-rpmi-test.c              | 625 +++++++++++++++++++++
 26 files changed, 2711 insertions(+), 2 deletions(-)
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


base-commit: 0a1ebd448b38afaa118597cbb633dbec24ef74d3
-- 
2.43.0

