Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38800606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 13:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hn1Pd0e4;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IwQNIVbS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLKfd-0001Pq-HL; Mon, 26 Oct 2026 09:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xLKfZ-0001Ow-Af
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 09:23:22 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xLKfV-0005Co-Jg
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 09:23:21 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QAt2ZZ3034264
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 13:23:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=Q/tbb7Belkxi7gnXEDmZSC
 pIGoxL/0hQAcBFIrQmUxI=; b=hn1Pd0e4Ko2lUDjuI2dr0hW60NNVXcNObQo/ZF
 ipvzY4wzrqAqLZrYY3HyhkZUZMlYT7qnSrQzUEOz2es3S0VCsUItpmnW8ll3Ewo3
 mTyiOcYZrsne/8WMDf2uRny1LcC8NUWnCjSh07kxV7Z+13yhLAD0ekoWswNgRLtt
 H4Wv3cf//8+QSaSaLFeiuMCvhgATHRpE5NfMMYzJKceNBIVp0cd+yrQHIl06moZR
 r/xj1HYb21B5pKwA4Edql5nUoTl4ztaGRjymjYRsVCrMVvpwByY4yfvwGNVB78kR
 ts9ZQPmtvv3/aGTMeGcF5G+8W/PGWU+mASxETIZHu+kPM1ug==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj56y0kmb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 13:23:15 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-34edae32c04so433744eec.3
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 06:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793020994; x=1793625794; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Q/tbb7Belkxi7gnXEDmZSCpIGoxL/0hQAcBFIrQmUxI=;
 b=IwQNIVbSUS3MTwAJQrOjP2FtZjXaM855ADxazYADvy/r1YiJ1Il5rT79qHr46eTOWv
 N1rkZ+uhdbVz5ZB8p/iiH9f90NPzi5PtQhuiJ+Q1C0CAYnv3lR5HHX/xR0GlcSbDQCpU
 bXBM2hQiQuEvFHU7lEUBUfOZH2pm9r9RHnTOeNKk8SNwy/+NWU3j9QBnJ0oYJ2iLT3a1
 hXNF0+QUI/ZhTHfrRDR/AXYubEx+aPeUmrKmFel1VJpfWbphS1jyfq/jtZy/lMRE2sQL
 Y/FGubQTBwZaKWKoR0Pemukmd3L+0Q3FUudhWPJ4DzMo4H57smPyzr5nqf94zm3I8XQm
 KJRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793020994; x=1793625794;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Q/tbb7Belkxi7gnXEDmZSCpIGoxL/0hQAcBFIrQmUxI=;
 b=oUeu+JTJfCCIVq/nztd4T1JzH9W3x4kSC5AhxHz1Jo9BbosmEjllpKbXpSJPlj0/Yj
 ZU4pR9PrO0e1fGy5AkoaF7x9KjHH8OxKlX0/UBhozVQXU+t/MI7ED70wjnQrfqOHXXAE
 2YW0iT0QcQV//5ib2AJ4qqc2hpLSiGu5hbQfPPEBAoYs4ekvTB6lRQrPbYZwEJ0QzeYi
 m/qoFclEyKcE10I7rkIgWSaNGRfhaXaxKccG+z6rQ8P7aOEoFQgdFa2M9Orz4lKxsXt+
 vyqZd6tpZV1w9ITdNWBUzqIzIeuEn2gbP7DZiGqHeFW52vpTShOEALDv+ZQPR/w3qceV
 i2XA==
X-Gm-Message-State: AFq9FYKy8jA5ijkDxE7aX54zHCJ/Ftn1Y+DhYCbdawTrs+t6u72PB6Hb
 66H6E+GAOKuNxv9+IGkjnKYUrHhl1/GnfZJ0kKCeRp4GgwJomzauE7updvvjeub5V2uuNyEPKFq
 DRtvWNOx/pJTNUTsLWlQn2bAjFqZ0jcqVzXQZc9IiSP9qbEwN0sY4CqlnFaNjG8RF3g==
X-Gm-Gg: AYBFou0JnIrm63cRcCWZcPAYTsKuUM3Ym5MXEbt4vp2Ci5NhG7y3a/zt3O5VbUef4hh
 kkwjLerkqoMuVzWQv6y9H/i6viXqp3vI3iv4xnycMMXc2/1jH9cmQFukDXI84y/KPGzmvkt1DZO
 UqGYEotPfrdWthLk+3sMIs4yzOWtZRkwxGTMaIzDNW7bHBsUKzq/qe45PFmapcBodiHLSl1AM8c
 D+GYLenCymvh8w4xk027PB1ME5Gu6Z/Kfkfgk+dRN1AV0W6wMb1OP2RQS0wmKAIC8CYA86mdSa1
 k+TYkIhDOv23VCvbsxfbJmCzTlyM9daO4B6flcbzb5BnoArktctCvBBvM8Uxb1jVTiF+qmiPn9J
 4fq8GlMSLDjWIcCddsIT3g69n9pL+1c78ZAZwE1c2rx7BDUzK1mJIbasyuSGiL2GNQyAG79Cxku
 fJHWoJoY6IVaSeFF8+zlbNFpMv8ROvyy8=
X-Received: by 2002:a05:7022:264b:b0:165:be2f:c56e with SMTP id
 a92af1059eb24-199376df85bmr14122678c88.2.1793020993912; 
 Mon, 26 Oct 2026 06:23:13 -0700 (PDT)
X-Received: by 2002:a05:7022:264b:b0:165:be2f:c56e with SMTP id
 a92af1059eb24-199376df85bmr14122583c88.2.1793020992872; 
 Mon, 26 Oct 2026 06:23:12 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a21bc6cbsm24360931c88.16.2026.10.26.06.23.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 06:23:12 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
Subject: [PATCH v12 00/10] riscv: add initial RPMI virt support
Date: Mon, 26 Oct 2026 18:52:43 +0530
Message-ID: <20261026132254.2652399-1-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA1MyBTYWx0ZWRfX7VSZS2zJbe0T
 UH/a5Wi4N8MOSxTQMOo63riSOBFuHvY0/YqJUliaukxjn4RLthePHFzuxGWoaNTnoe9nFNrErQo
 1sSsI0ShrfYErh7+hdKLlgtOcC8XBwQ=
X-Authority-Analysis: v=2.4 cv=eMeGH3p1 c=1 sm=1 tr=0 ts=6adf5443 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=NEAV23lmAAAA:8 a=PWLY9aKpCGOzqhP01lwA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA1MyBTYWx0ZWRfX9BUOQUQ6VZp8
 mz1a43FMfq9VF7iRsQ3DhOcZ68B22NuZ5cww8Oc6ZBZibutejf0oXMYBT56Lh+sWYm1rwxoeD2e
 pEeLZdGS4U71J653jSWlWauko5JKbDHn6wBzDgpQUwUe0tGFXUglmKf+fAq6Ih+osmlw/DUbvpD
 SrjIG3uJ5R+FFvsIqR+t0Ydy7UeuWQg6l3CkoemR73tbPFrs5yDdJkgyBa4dsIToaw5gqv2tpAa
 thUPzGHiJcNgEDSFHX99rJ25Pebel8o8R2ZWOXLpFHETdGtd5AeNM+AVDucmM/38WFzmhjDH3Js
 NYFF+XBBDHn4P7bzJm8CcIIO5Mu0D9wnZl3+6Y2G/TLcrQDoWXiJ6FFtLW4wbHvCRvuTAd1dXiX
 ZEeqRar/qQ17bKIn+nf5RpxRUrtsPYaplPCHkHr886zM6Uv/FCU/X32na0Do8PMm0X3lyxuK1bl
 Mve6GnAteKX6be5ypog==
X-Proofpoint-GUID: DXNg2xq8ez1oEHa1a-EYGkL_mNgXoK1P
X-Proofpoint-ORIG-GUID: DXNg2xq8ez1oEHa1a-EYGkL_mNgXoK1P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 phishscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260053
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds initial librpmi-backed RPMI support for the RISC-V virt
machine. It covers the optional librpmi build dependency, RPMI transport and
Base support, virt FDT wiring, System Reset, HSM, System Suspend, documentation,
qtests, and a Linux guest smoke test.

librpmi provides the host-side RPMI service-group implementation used by this
QEMU device model:

  https://github.com/riscv-software-src/librpmi

Dependencies:
- librpmi 1.0.0 or newer, available from the upstream repository above or
  from the distribution packages documented in docs/system/riscv/virt.rst.
- A RISC-V toolchain and the firmware/kernel/rootfs artifacts required by
  the functional guest smoke test.

Changes since v11:
- Series-wide:
  - Rebase the complete series onto QEMU master at
    d73149283205645625bfa9fe029cfb68e4c4a9ae.
  - Fold Charles Perry's FDT/schema fix into the original commits.
- [03/10] hw/riscv: add RPMI FDT helpers:
  - Emit RPMI service nodes as /soc siblings of the shared-memory mailbox.
  - Remove shmem_base from the FDT service helper API.
- [04/10] hw/riscv/virt: add opt-in RPMI base support:
  - Update virt FDT wiring for the sibling service-node layout.
- [08/10] docs/system/riscv: document initial virt RPMI support:
  - Document the sibling service-node hierarchy and updated helper behavior.
- [09/10] tests/qtest: cover initial RISC-V RPMI services:
  - Add DTB regression checks for sibling paths, mailbox phandles, service
    IDs, and rejection of the old mailbox-child hierarchy.
- [10/10] tests/functional: add initial RPMI virt guest smoke:
  - Revalidate librpmi and no-librpmi builds, RPMI qtests, and real guest
    smoke tests after the FDT/schema fix.

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
  - Use enum rpmi_servicegroup_id for service-group identifiers from
    the first RPMI config definition, with no-librpmi fallback enum
    values for optional builds.
- [03/10] hw/riscv: add RPMI FDT helpers:
  - Move the no-librpmi RPMI FDT helper stub into this patch where
    the helper prototypes are introduced.
- [05/10] riscv: add RPMI system reset service:
  - Use the librpmi RPMI_SRVGRP_SYSTEM_RESET value directly instead of
    a QEMU-local service-group alias.
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
    System Reset, HSM and System Suspend services.

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
  - When RPMI is enabled, advertise reboot and shutdown through the
    RPMI System Reset service instead of the syscon reset nodes.
- [10/10] tests/functional: add initial RPMI virt guest smoke:
  - Extend the functional guest smoke test to check the RPMI reboot
    and shutdown devices reported by firmware and exercise reboot.

Changes since v5:
- [01/10] build: add optional librpmi dependency:
  - Fix the librpmi configure probe to check the system suspend service
    group API used by this initial series instead of the later logging API.
- [04/10] hw/riscv/virt: add opt-in RPMI base support:
  - Keep later SBI MPXY/FDT stubs out of the initial no-librpmi stub
    file; those stubs now live in the later stack layer where their
    prototypes are introduced.

Changes since v4:
- [04/10] hw/riscv/virt: add opt-in RPMI base support:
  - Drop the unused machine-opaque argument from the RPMI machine
    callback API.
  - Move the no-librpmi riscv_rpmi_create() fallback out of the public
    header into hw/misc/riscv_rpmi-stub.c.
  - Add a matching RPMI FDT helper stub for no-librpmi builds, while
    keeping the real rpmi-fdt.c source gated on CONFIG_RISCV_RPMI.
- [05/10] riscv: add RPMI system reset service:
  - Drop the unused machine-opaque argument from the callback API.
- [06/10] riscv: add RPMI HSM service:
  - Drop the unused machine-opaque argument from the callback API.
- [07/10] riscv: add RPMI system suspend service:
  - Drop the unused machine-opaque argument from the callback API.

Changes since v3:
- [01/10] build: add optional librpmi dependency:
  - Use "RPMI support" for librpmi-related Meson option and summary text.
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
    including source builds, Debian/RPM packages, pkg-config setup,
    and the minimum librpmi version.

Changes since v1:
- Series-wide:
  - Fold reviewer fixes into the original commits.
- [02/10] hw/misc: add RISC-V RPMI transport and Base support:
  - Move Base service configuration into the Base support commit.
- [08/10] docs/system/riscv: document initial virt RPMI support:
  - Document the RPMI v1.0 ratified context and specification references.

Testing:
- librpmi-enabled qemu-system-riscv64 build: passed.
- RPMI qtest: 19 subtests passed, including the DT hierarchy regression.
- no-librpmi qemu-system-riscv64 build: passed; virt,rpmi=on is rejected
  with a clear unsupported-build error.
- Real RPMI virt guest testing: 5/5 passed (HSM stop, reset/poweroff,
  reboot, service enumeration, and suspend/wakeup).
- Server-reference Linux boot validation: 2/2 passed (normal and TPM).
- Server-reference RPMI guest reset, suspend/wakeup, reboot, and poweroff:
  passed.

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
 docs/system/riscv/virt.rst                 |  81 +++
 hw/misc/Kconfig                            |   4 +
 hw/misc/meson.build                        |   6 +
 hw/misc/riscv_rpmi-stub.c                  |  16 +
 hw/misc/riscv_rpmi.c                       | 574 +++++++++++++++++
 hw/misc/riscv_rpmi_hsm.c                   | 289 +++++++++
 hw/misc/riscv_rpmi_internal.h              |  43 ++
 hw/misc/riscv_rpmi_sysreset.c              | 206 +++++++
 hw/misc/riscv_rpmi_syssusp.c               | 194 ++++++
 hw/riscv/Kconfig                           |   1 +
 hw/riscv/fdt-common.c                      |   8 +-
 hw/riscv/meson.build                       |   3 +
 hw/riscv/rpmi-fdt-stub.c                   |  36 ++
 hw/riscv/rpmi-fdt.c                        | 101 +++
 hw/riscv/server_platform_ref.c             |   2 +-
 hw/riscv/virt.c                            | 164 ++++-
 include/hw/misc/riscv_rpmi.h               | 114 ++++
 include/hw/riscv/fdt-common.h              |   3 +-
 include/hw/riscv/rpmi-fdt.h                |  40 ++
 include/hw/riscv/virt.h                    |   3 +
 meson.build                                |  14 +
 meson_options.txt                          |   2 +
 scripts/meson-buildoptions.sh              |   3 +
 tests/functional/riscv64/meson.build       |   2 +
 tests/functional/riscv64/test_rpmi_virt.py | 198 ++++++
 tests/qtest/meson.build                    |   3 +
 tests/qtest/riscv-rpmi-test.c              | 686 +++++++++++++++++++++
 29 files changed, 2798 insertions(+), 4 deletions(-)
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


base-commit: d73149283205645625bfa9fe029cfb68e4c4a9ae
-- 
2.43.0


