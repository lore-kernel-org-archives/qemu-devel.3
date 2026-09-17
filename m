Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05424C982D1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 05:24:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x74ak-0007gf-WE; Thu, 17 Sep 2026 01:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1x74ai-0007fy-MT
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 01:23:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1x74af-0003z1-4q
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 01:23:23 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GLY4G63107061
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 05:23:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=D20DLb2p+xFv0bVbi/YLom
 JUIr15uI9VMzap5nCr2Ms=; b=Ir7TRJMs0MY97+ob9S/3zZi8fpBFVW3z/HzMdX
 CeT8Gnuu8gMCmMnvhOEXotgzOed7VQMnhGHakp6Ix0tEDhss7E22vlbZFhJ5Pfk6
 nxYSuWejtkFl9ByCHOZ5ngjILTVyqykoD+QfukwCAXO59ULNU2qmzBQohBgfF2WA
 DXdZDhI+SLkfjq3UVLWkrRZCJNUHoPlEXUXZ2XZFQeWt34PHZfxxIh5qMka5xBLJ
 ZB8rxbyOheK/gYVSV4y4CZcWxdMRqfI5oQBhdkPPOc4ZaDHedRO8qsrIDo8g9s0x
 0rFXxjv66nhap6RJuYQKWI8YROiTQn5h6ku/S5oE5ZBiAvHw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gquw2uk8w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 05:23:17 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-398d3a12589so120005a91.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 22:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789622597; x=1790227397; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=D20DLb2p+xFv0bVbi/YLomJUIr15uI9VMzap5nCr2Ms=;
 b=BjQSh8ECtYvp0RJ42+DI7/gAzl68XGX1fNLXNy8+sZQEkvNrW2ZA94C6Z9l/IebRM4
 eZXS7GCY3MUdRh3xYdorbRM86+OIYTRMUzmr4HEl/4/bUzW11yDK1UajCk/anVsbnFVH
 Qmye18+tzEPGlsRfJMJzDmxaW9BctNHhqKYYQFCdCGNnz0HwAVuDsoMPZHB7IgIXLftF
 jNOGZFzZsAjFKygMyDK2zzVXm86G6WkaFm3wBNL07pSfn6AKhVGeo+zhSG96VZI1TvjS
 gYvGTqWRpcnMGD2/jMaLgHxB9aZ2dxoSNt6vIU/n8OxXtmhip4zLdCaYTlpRq/PFOOBj
 yB4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789622597; x=1790227397;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=D20DLb2p+xFv0bVbi/YLomJUIr15uI9VMzap5nCr2Ms=;
 b=TIqm9YDEAjD5OyESBjm1C0TXCU4OBTisAg6/V5YZIof0omWu+s6eQFRUDWdsZG88Xv
 DEbbJfl6VFOIHfSEelMoBsNAByXUBb4TUDMS+wLkWBE1qZ4wCHTXvIFqkrwfG4IPUM3n
 QxdcuTco8Gyp+S4Xi2bnCG+7HeSQZu6Wtv+IM911qynx0ge3dWGKoqWCOUnYIpjpy8hT
 UWm7YcHCtO5B1zPM0C1wXlLZMTm3PgPhLM7lcNjHQ+KqbWvJ+4FfPUIWt3dR2WvKdRUD
 61JQMKB8v/KHwLtRYXG4yw9uwe+hpmgP+X9GBf7uMTpkGjqSWSE+sr6uEp87SiN+VZKH
 qDbw==
X-Gm-Message-State: AFuF++m+AbSl0vj6SY4z0NZUedvROgp5y9lvCPOSnEr6/Y0tHtSMMjro
 yZcMGGS8gEPPoSmHOcWUZ2xJcU8cccu03MVWFzpVYypAFiL0jd0hjN9GNpsYwgvAwrZBkjhr7Pn
 6QvsXUntrdJng786AcYjisyK/tx9kj2PqTTvKSPnCoumxr4GY6Ac2QaeCU4vNFIChgQ==
X-Gm-Gg: AYBFou0xjHFpfHyuQM3JRCwU/JO1Hk4AgJrQQ7pTOK6yfmRjTUyBqKITKiqolIC6GCv
 VSh50evHGe5lnvs9NzMY+DzosxMRACyBtuVlwCbMnHkKp8b+QRgAFmvwL8V5yXW9347UTK1pUC3
 8isf5CKFrY49niRkGsjpNp3YVH3urUcQGaRr64NGjpZvcJGZtsaK3idWqQzloAgcDXEEbmS1w4q
 FH5exjPcTFpo07DbCpm7EL0LGseuqQ/OUyhq7xWW3YVcWzx+GVSYIAnSxDccvJi07lX69qNrpKa
 nZTV95z4Rmln9gXvK7GtYv2lEPl6o46AHufe+bAJ9omDJ2SZ/ykLvdHQeczEsGBJWL4iXBKhkvO
 F9e4hS3uFF3ubRqzzLHekjgPHH5MIzYV/O3oOG/B77IArTtU0mQu56oV+lXd5NSIcE0zVeLT5JA
 94Ybk/4IjFcZItTOC5deSzb6L0KTdY0X0=
X-Received: by 2002:a17:90a:c10f:b0:398:a2e4:c784 with SMTP id
 98e67ed59e1d1-39e1e266589mr8273995a91.1.1789622596515; 
 Wed, 16 Sep 2026 22:23:16 -0700 (PDT)
X-Received: by 2002:a17:90a:c10f:b0:398:a2e4:c784 with SMTP id
 98e67ed59e1d1-39e1e266589mr8273941a91.1.1789622595852; 
 Wed, 16 Sep 2026 22:23:15 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5af4f0bsm14256187eec.24.2026.09.16.22.23.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 22:23:15 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
Subject: [PATCH v11 00/10] riscv: add initial RPMI virt support
Date: Thu, 17 Sep 2026 10:52:39 +0530
Message-ID: <20260917052250.1041262-1-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDA2OCBTYWx0ZWRfX8Q2cie6VDrkH
 vNixJJ2k1WZsck/IhgdcNXv/v/vEn6sWwRCbPbjtDxV8i2QydtiqIggolddOOkoU8EjpsbwzRNj
 GxeZv52wFYn3g/6oq4MyjFMEwwVQLm8=
X-Proofpoint-GUID: Q11yYf9RB2BJMHeGQUIq4P7MjHom07LS
X-Authority-Analysis: v=2.4 cv=N4m8hG9B c=1 sm=1 tr=0 ts=6aab7945 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=NEAV23lmAAAA:8 a=081Sr7Ilyrv4IrdElTgA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: Q11yYf9RB2BJMHeGQUIq4P7MjHom07LS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDA2OCBTYWx0ZWRfX/qQPMHJMvGdC
 XzX0GCUcikbYhv2eWFJWW+GKGw90ZgTzF77pQBFv88wleBpp4Mse2bxFCsuNgYYBoN/0qQm5E6u
 6ntMFx1ShrqazrCIPg4RGrCIVa0rR2KmzvJNTVsuKmRLtwWkMtYBJobK+7Q7WM/wIuz+H5YvKYN
 CFZizUap8Lwz0Mq8OBeBuldoHCrOsFTFobtELXUVh+XUXz+wdLCCWCYjNSlJ5qAsd010Jpd4ueV
 FIJ1w3IGZcAQ2EKtDkv2HZk+DKiAscpa3/KOzszu3J+ObI4IFjAucTS7AFlMsqI+LvgkMaHH3vf
 HYIqi1U6lxIHMPiyBPUCW9rYz4wOfOOjqUzgK+nFn6EPzGLz3LTkIqHkJmDpqd58ZIxIgGFhX4+
 LU25PYVZIZGETiF3mrvfp4N6v+Zwoqf8R5j3nQKZEdWTdPkk/gyaD4YcLVRvmt2d/S5tC50CVG0
 2TauqsLoGcz9ZD8fkUg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170068
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

Changes since v10:
- Series-wide:
  - Fold the post-v10 mailing-list review fixes into the original commits.
- [01/10] build: add optional librpmi dependency:
  - Add Reviewed-by tags from Alistair Francis and Sunil V L.
- [02/10] hw/misc: add RISC-V RPMI transport and Base support:
  - Replace legacy physical-memory helpers with QEMU address-space APIs.
  - Propagate failed shared-memory transactions as RPMI_ERR_IO.
  - Use address_space_set() for bulk shared-memory fills.
  - Log failures from the void librpmi_env_writel() hook.
  - Document the external librpmi_env.h environment-hook contract.

Changes since v9:
- Series-wide:
  - Rebase on current QEMU master, commit 0a1ebd448b38.
- [02/10] hw/misc: add RISC-V RPMI transport and Base support:
  - Move the no-librpmi riscv_rpmi_create() stub into this patch where
    the public RPMI device API is introduced.
  - Use enum rpmi_servicegroup_id for service-group identifiers from the
    first RPMI config definition, with no-librpmi fallback enum values
    for optional builds.
- [03/10] hw/riscv: add RPMI FDT helpers:
  - Move the no-librpmi RPMI FDT helper stub into this patch where the
    helper prototypes are introduced.
- [05/10] riscv: add RPMI system reset service:
  - Use the librpmi RPMI_SRVGRP_SYSTEM_RESET value directly instead of a
    QEMU-local service-group alias.
  - Introduce the service-ops dispatch table in this patch, with the
    initial System Reset entry.
- [06/10] riscv: add RPMI HSM service:
  - Use the librpmi RPMI_SRVGRP_HSM value directly instead of a
    QEMU-local service-group alias.
  - Add only the HSM service entry on top of the System Reset service
    ops infrastructure.
- [07/10] riscv: add RPMI system suspend service:
  - Use the librpmi RPMI_SRVGRP_SYSTEM_SUSPEND value directly instead
    of a QEMU-local service-group alias.
- [09/10] tests/qtest: cover initial RISC-V RPMI services:
  - Drop future/unimplemented service-group definitions and probes from
    the qtest coverage. The test now covers only the initial Base,
    System Reset, HSM and System Suspend services added by this series.

Changes since v8:
- Series-wide:
  - Rebase on current QEMU master, commit 539bc315538a.
- [02/10] hw/misc: add RISC-V RPMI transport and Base support:
  - Update the RPMI transport shared-memory helpers for the current
    physical_memory_read()/physical_memory_write() APIs.
- [08/10] docs/system/riscv: document initial virt RPMI support:
  - Add qtest coverage documentation alongside the existing firmware
    and guest smoke test notes.

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
- [08/10] docs/system/riscv: document RPMI v1.0 Ratified context and
    specification references.

Testing:
- librpmi-enabled build of qemu-system-riscv64 and riscv-rpmi-test.
- RPMI qtest: 18 subtests passed.
- Real Linux/OpenSBI guest: HSM start/stop, service enumeration,
  suspend/wakeup, reset/reboot, and reset/poweroff all passed.
- No-librpmi build: virt,rpmi=on is rejected with a clear error;
  virt,rpmi=off boots the guest to login and powers down cleanly.

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
 hw/misc/riscv_rpmi.c                       | 574 +++++++++++++++++++
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
 26 files changed, 2727 insertions(+), 2 deletions(-)
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

