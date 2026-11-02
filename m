Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35BF606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 08:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dRf+tsIE;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VkpQxXeZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNnUq-0003Y6-K2; Mon, 02 Nov 2026 03:34:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xNnSk-0002lm-PP
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 03:32:20 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xNnSg-0004nB-Qg
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 03:32:18 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A25W2Hw3924329
 for <qemu-devel@nongnu.org>; Mon, 2 Nov 2026 08:32:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=ivvhCDRbOVetdcS8+AMHEf
 47qp6RPR8TxQCc5w+GuC8=; b=dRf+tsIEVB1kgFHxkWhgi1cec/FyMQWo3HWZy6
 qiU5qurJiGRHQkDzqmwKQci7lq6OpqqUu/9QruDLCf+G3VqSmwhV0UZptJfh7Yr2
 p8+nq5Sr+/ikbKzQvzaEg62DJfmWUxjVymq4nwd53z0E7p8tMbpEWCaIhCNxcAU6
 FEXeuedOqu85V6EqlWeZwoCCP7/FBbNUkgN8pv/Of3gZR6FLVK2Me2X2GwDnBTr9
 uJOa5iz+WcBDTQF1uTMIbEi+oII1r+A8luvRGL7K7HRwe2eYJhevlzbIZzlalvua
 SsGqEJDEl2yu8xiHCeTxmKy/kazq6QWC8m59yJpFI0qRhViQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpmf1rmpn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 08:32:08 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-36a137058c5so395305eec.1
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 00:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793608328; x=1794213128; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ivvhCDRbOVetdcS8+AMHEf47qp6RPR8TxQCc5w+GuC8=;
 b=VkpQxXeZy4WhvBiV9ND6TcMq8YI1jRziUUruCh6dk6i7ssOS46O3gpRO4JnHdV7ceo
 pHBrkCABWyjy1xJklLu+IkYEQMgDhXHsP/h6DI5GTU5Ix8RUW+rHceDQmwpl9rfjJoLl
 dghredwc5FaGtbbrsLD7f1aZbR7sMvYH2yz5opkWCzjjoakHqEKPIAMJtXzWIEvLE5Mh
 aWe5CxYmkS6up9gXErP82y8+EAHiHSqT05O18stWaLq2sf8fuknP9mQDv3qO4FGgpim8
 069QPEdZVIJndcGsmOXM3To+gqHPcY4xqMcX4sl2N/Nf2kRHL6GiakAFaZABfx7rTA86
 yYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793608328; x=1794213128;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ivvhCDRbOVetdcS8+AMHEf47qp6RPR8TxQCc5w+GuC8=;
 b=KzI0K4VczxZ6sYt3hpaYdn0MpbfNFiqyptGGG351RGpV2j5pJFHkPkDswxnPfSLZE8
 1aVZEPOy71fFZV1x9MdXBS+3FSIO+49HLstt5rZbw5b0Bldb9A8+IRlc57WNqQWXCvxf
 N4mtgb0vPUU+s+WuamDijtM9b5oPrhPsrIEdAHsPZyI8eltHqCwg2pIMrCyaiSiPC/iF
 WgZSANmPb0DLUL/StqNCCVVT+9PBZ9nYH6T65geLFs26AgO3K39+bCHbH0bwipULwDwQ
 dzLF7SNsY3zpPXQWiSNJOTgNKyh8u6czvdUy9Hjylj/+4tcGuP/kPkIrJW/qA2Rv2zGu
 jxCA==
X-Gm-Message-State: AFq9FYJssT1AL2mwNtde5rSj4Kq6Y4/JsqG6M77URfHkctp354gMa2vG
 9rmjgaBqd3IYEGcQ5vW8qHXGHC9xCNcgixXnNutBvI57bARvTByIlXrGJ3AO4/mNRui1X5dED3v
 I0hewgGiGbJU+qFw3Qg8AEO6cFUhmyhz3UceG5GIDkWhjaHjh0vWMKm43JG74nRu9Pw==
X-Gm-Gg: AYBFou34s1r3WBVBu5PRnn4B0MPcxtnvMGyaeKO8XJIFJzui0xBB+ttHOrWxiXgl5jn
 oWP33R8b304aX7yrLc8rTI/tKWxPJG0Ofdfd6ydv0ICR89PMTxeTf3Zddtm8hhJWUxWwxQ1+ZWd
 ARUZcHap2kCC75XYfFrP+ZvIuW4THwiz/QT79SdkMAWsDLs2OMWOr0MTu9hQWVSjVIVZ6UXlSmX
 waF7EnDHsdawVkWs1Q433HFzEZFhLDFaNXozhH8/r1gpJYySTz2tPh4yw5pL2AoHabOKJOFxtKV
 KPvIP3wC0kV2Q+jLxpdVUviiLyfn5RAOsqtlPdWurv0huKQFi2oPJuTfPKbgZn/+S5fxONuk/7R
 Yq6Ysyw8u3DamHrl0r8E9mTa+614hk2tSaB2Oy5mlYGyCbj+IQKswDlpGs2Vhb0ixWLc+PkUiqE
 5YBreUOg7FKh3AfbXM+uxj1IyjQbyu8q/yRE8pk0RMFd7pjC9ztG/oH6/FZnzUaaBDjYtRrS/Qe
 2BLbAQ3
X-Received: by 2002:a05:7022:f903:b0:16b:4f52:a08 with SMTP id
 a92af1059eb24-1ac4fd01f92mr23325828c88.0.1793608327725; 
 Mon, 02 Nov 2026 00:32:07 -0800 (PST)
X-Received: by 2002:a05:7022:f903:b0:16b:4f52:a08 with SMTP id
 a92af1059eb24-1ac4fd01f92mr23325760c88.0.1793608326846; 
 Mon, 02 Nov 2026 00:32:06 -0800 (PST)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b106edc7f8sm15083213c88.9.2026.11.02.00.32.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 00:32:06 -0800 (PST)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
Subject: [PATCH v13 00/10] riscv: add initial RPMI virt support
Date: Mon,  2 Nov 2026 14:01:48 +0530
Message-ID: <20261102083159.3383468-1-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: AVsS8gprKgVs8yrSKwSp5SfATT4vWYYf
X-Authority-Analysis: v=2.4 cv=bNaDs/+Z c=1 sm=1 tr=0 ts=6ae84a88 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=NEAV23lmAAAA:8 a=HAtRXJe3qvw1RctvmaQA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAzMyBTYWx0ZWRfX3r/TbgQyUWc9
 +gkiLTnwQtSucrBQeRYSSBsc/7uV3CT2Ntp2mflyv3F4Ni5I8OCIYJsYRjH+NbbDEfX5aIpEOep
 8l6A+yWjkv1m/J8WLgtDMVU+cqFN8qdBq6KUnR4P1i0SxTiDRuNseysrwvQdFI7Y63TKY4u0gne
 cB+3VdEYatWASr66drv70Z0FeHm+yxltq8kv1Jk8tDHTXWqw8Zf4+kiNH3YWuFltZpeSJvcuahv
 gwzwUJd0OXuxU90lXuMZZadDvrnFk1hVr/IFuE6n38KpOMz9dRf03awvlLiqS7z2RwiTrqCIm4y
 pwETp6Y6a8QxtjlU2VX9H37bXpuGloBSrp4NVORD2dPYiex/Eg62vGuF8p4ciYkRJHdgvq8ItpJ
 9s6ZEHBYQNTU6jaQYEavUKtAbvBxaMgfbAwUTm+a6jRgxi63lBfUc31yliq1ltEPStNAmqMAjPa
 n1SwZ0CV+Tgfr7y7Hlw==
X-Proofpoint-GUID: AVsS8gprKgVs8yrSKwSp5SfATT4vWYYf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAzMyBTYWx0ZWRfX0/iZbO/DO7Nt
 ClL/uLyWPXf6rtAboj49MUIh+qX+axcxj99q3aGKzN18pEoZ0b6kzfDtvHVqy02em381qaCz1QD
 xEYfNoh1Q1vizmkzwz01v46t3mXf7rI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020033
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds initial librpmi-backed RPMI support for the RISC-V virt
machine. It covers the optional librpmi build dependency, RPMI transport
and Base support, virt FDT wiring, System Reset, HSM, System Suspend,
documentation, qtests, and a Linux guest smoke test.

librpmi provides the host-side RPMI service-group implementation used by
this QEMU device model:

  https://github.com/riscv-software-src/librpmi

Dependencies:
- librpmi 1.0.0 or newer, available from the upstream repository above or
  from the distribution packages documented in docs/system/riscv/virt.rst.
- A RISC-V toolchain and the firmware/kernel/rootfs artifacts required by
  the functional guest smoke test.

Changes since v12:
- Series-wide:
  - Fix HSM stop completion after guest tests exposed divergence between
    cached RPMI hart state and actual WFI state, including HART_STOP failures
    after suspend/wakeup.
  - Fold post-v12 review fixes and build corrections into their owning
    commits; retain the v12 FDT hierarchy/schema fix and earlier fixes.
  - Drop earlier Reviewed-by tags from the materially rewritten HSM,
    System Suspend, and qtest patches.
- [02/10] hw/misc: add RISC-V RPMI transport and Base support:
  - Keep librpmi calls under existing BQL ownership because its environment
    lock hooks are no-ops.
  - Remove unrelated global event polling from doorbell handling; service
    state transitions now drive their own event processing.
  - Reject request queues too small to hold queue metadata and a data slot.
  - Name the minimum queue size RPMI_DATA_SLOT_SIZE instead of repeating
    the head, tail, and data-slot size expression in queue validation.
- [03/10] hw/riscv: add RPMI FDT helpers:
  - Remove duplicate helper arguments by passing the service configuration
    directly, and allow Base-only callers to omit the mailbox phandle.
- [04/10] hw/riscv/virt: add opt-in RPMI base support:
  - Keep this intermediate commit independently buildable before the reset
    service lands; retain legacy reset nodes until [05/10].
  - Keep queue sizing local, drop the unused MSI phandle argument, and
    document the librpmi and TCG requirements.
- [05/10] riscv: add RPMI system reset service:
  - Include the runstate API here so the callback-introducing commit builds
    independently.
  - Preserve little-endian responses without alignment-unsafe buffer casts.
- [06/10] riscv: add RPMI HSM service:
  - Complete accepted stop and suspend requests only when the target hart
    actually enters WFI; no later RPMI request is needed to publish the new
    state.
  - Observe WFI persistently and replay the observer on the target CPU so
    stop requests arriving after WFI are not missed.
  - Run HART_START on the target CPU, keep stopped harts off until that
    request, publish RPMI state under the BQL, and drain target-CPU work
    during teardown.
  - Reconstruct HSM state on machine reset to avoid stale service state.
- [07/10] riscv: add RPMI system suspend service:
  - Align suspend completion and wakeup with the corrected HSM transitions;
    process only its accepted event and avoid stale wakeup work on teardown.
  - Recreate the suspend group around HSM reset reconstruction.
- [08/10] docs/system/riscv: document initial virt RPMI support:
  - Remove the obsolete RFC caveat now that the binding names are settled.
- [09/10] tests/qtest: cover initial RISC-V RPMI services:
  - Match the non-executing qtest accelerator: expect pending states, reject
    HART_START while stop is pending, and check reset recovery.
  - Remove an invalid target-PC assertion and use the negotiated response
    slot for variable-length replies.
- [10/10] tests/functional: add initial RPMI virt guest smoke:
  - Bound the wait for online after CPU death: Linux's offline mask can
    precede firmware STOPPED. Keep transient errors visible and require
    eventual successful start; STOP_PENDING start rejection remains tested.
  - Verify completed stop/start transitions, repeated stops, busy-hart stop,
    reboot recovery, and HSM operation after suspend/wakeup.
  - Tighten console checks to prevent echoed commands or stale prompts from
    producing false passes, and fail on fatal firmware HSM diagnostics.

Changes since v11:
- Series-wide:
  - Rebase the complete series onto QEMU master at
    d73149283205645625bfa9fe029cfb68e4c4a9ae.
  - Fold the FDT/schema review fix into the original commits.
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
- qemu-system-riscv64 builds with and without librpmi: passed.
- HSM and System Suspend commit-boundary builds with librpmi: passed.
- RPMI virt qtest at [09/10]: 19/19 subtests passed, including DT layout
  and migration-policy checks.
- Without librpmi, virt,rpmi=on rejects with the expected unsupported-build
  error; virt,rpmi=off realizes successfully.
- Final RPMI virt guest suite: 6/6 passed twice on November 2, including
  the bounded CPU-online wait in [10/10]. Coverage includes service
  enumeration, repeated and busy-hart HSM stop/start, stopped-hart reboot
  recovery, reset/poweroff, and suspend/wakeup followed by HSM stop/start.

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
 docs/system/riscv/virt.rst                 |  79 +++
 hw/misc/Kconfig                            |   4 +
 hw/misc/meson.build                        |   6 +
 hw/misc/riscv_rpmi-stub.c                  |  16 +
 hw/misc/riscv_rpmi.c                       | 599 ++++++++++++++++++
 hw/misc/riscv_rpmi_hsm.c                   | 359 +++++++++++
 hw/misc/riscv_rpmi_internal.h              |  43 ++
 hw/misc/riscv_rpmi_sysreset.c              | 185 ++++++
 hw/misc/riscv_rpmi_syssusp.c               | 175 ++++++
 hw/riscv/Kconfig                           |   1 +
 hw/riscv/fdt-common.c                      |   8 +-
 hw/riscv/meson.build                       |   3 +
 hw/riscv/rpmi-fdt-stub.c                   |  24 +
 hw/riscv/rpmi-fdt.c                        |  92 +++
 hw/riscv/server_platform_ref.c             |   2 +-
 hw/riscv/virt.c                            | 143 ++++-
 include/hw/misc/riscv_rpmi.h               | 112 ++++
 include/hw/riscv/fdt-common.h              |   3 +-
 include/hw/riscv/rpmi-fdt.h                |  34 +
 include/hw/riscv/virt.h                    |   3 +
 meson.build                                |  14 +
 meson_options.txt                          |   2 +
 scripts/meson-buildoptions.sh              |   3 +
 target/riscv/cpu-qom.h                     |  16 +
 target/riscv/cpu.c                         |  61 ++
 target/riscv/cpu.h                         |   7 +
 target/riscv/tcg/op_helper.c               |   4 +
 target/riscv/tcg/tcg-cpu.c                 |   1 +
 tests/functional/riscv64/meson.build       |   2 +
 tests/functional/riscv64/test_rpmi_virt.py | 268 ++++++++
 tests/qtest/meson.build                    |   3 +
 tests/qtest/riscv-rpmi-test.c              | 685 +++++++++++++++++++++
 34 files changed, 2959 insertions(+), 4 deletions(-)
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


