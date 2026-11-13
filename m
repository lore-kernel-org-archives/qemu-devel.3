Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FA8606A32E
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=daNSUHTY;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jM9cCHKE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRmC6-0002hk-GL; Fri, 13 Nov 2026 02:59:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xRmC2-0002gp-Bq
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 02:59:30 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xRmBz-0000A9-3T
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 02:59:30 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AD57Acr3615976
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 07:59:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=gxYJCNDloUN/4NoPGmoupa
 DpGSzDAVXIww+76fD2+yU=; b=daNSUHTYORj/xJSDP7nxBsleh4xzrv07+mTbfA
 gz6FsqMhv73v0y8AjuZD2x1GMDOEVnDSFun0dLyIZ0aLNgDkhlvbO8MxfTVWz07t
 CX4Bjn3PJKsxe4WGPGkNYabpOweHb16BTD/u0Gdl04DNjx4VQwytfsk9gLwPE9YV
 AcZ/Z0OE9Iuk4bsbXfsyQNb2WwuO1ZM+Hz9tlu+icpgC+SXlVd401NpE32VN3u7m
 NQkGa7E2D5ykfcedzaQ99dq06/Qm87vTXvu/svhtSyYe0GGUYtovdM4XRLOtDGzC
 yr3si6nJ69OsSf5uzZT0uxtp/As+iIhC0p06zxSYyQK5Z4dQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwh0ajsds-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 07:59:23 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-36e61c89e2dso75038eec.3
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 23:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794556763; x=1795161563; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gxYJCNDloUN/4NoPGmoupaDpGSzDAVXIww+76fD2+yU=;
 b=jM9cCHKEWji0Rq++oQCCjg5S1YeNiXqNIB5wB4NIXW5Z+WW2N4kJbHrv4Mhb5yORhJ
 z0MFQIFlKibeHAfnIqz9niX7r+Q/QQqAAyjuCGOgB0o1uxsZr45hwVnClZ4GNn2m2cmX
 xmt5n/z7z+J9Yj/ga76Ug8BwVxfIi0is45axk+m6CEBHfdU2vRdLPg5qEZ6EWtubkfvu
 HVjmb9dfU77ZkrYl0yhbEtlTkHH7sMrfWj6Pmzl/sxbZ+S6UtEO8HA1u1dLycYY7UgBX
 xl8U1MxvBQkktNo5bt/lcJkEOxEvFuq0af9cxq//mZZgZcGGydN06y1YLJlddprIS5s8
 NEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794556763; x=1795161563;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gxYJCNDloUN/4NoPGmoupaDpGSzDAVXIww+76fD2+yU=;
 b=zEjdgAGX659yVOF2rZ90kEw4DZ2it4CD0hFDShMUlO/4AKhZGL2kAphu0ZUYJDJRfU
 R7oWxozGeu4Ro72Q7cVviH5AhzsugYh/SCTTHztXsuKRlX9vjC5TSsjmb9O0Eanyr+Br
 czgIHPXeGQXoyMYettr6cC/J5zwRHaldfjq6O7FDkhJIy3B9lpMy1/3RZymHp6jdegjv
 LbqwUXD+rOtsnZhN2YhIs6J69n8/JC3qyJXBaX+x44AQuyi87uBYmhF/XJmCuG4Pr4kg
 V9d3dhC9VyATBnXyl6Qf1A5clqKs8fukq8LEmdNa54pzq+vlO8rel0TRMSFTygN54ubb
 T8iA==
X-Gm-Message-State: APuU4Z85DuKwKPkk38PYeyhMJmyfmhznV/OH1n17suRuE+V/XVvkPnD7
 FJ+7mQbPMopcGqMjCyf0v3i0Sgg7gOMI5dCYwkggWDxCy0KM6uKcNlOGOWxnmKEY26FZuQYyjWn
 yH0DLu5US3/xC+8k7UR96UvJQFswie4V2ug5eYtmCYFzUYfoBwZyL90OC2NMor24wbQ==
X-Gm-Gg: AYBFou0uynwsxBJIuy7HEg/cj0ulmf5wU7+sBEc9Ibxsaqeil7/I36yJrcCb6FTZn7b
 OFGaP9SwNpV+RG9qUKTXCm+h3eiIVMqXxNExSa2EDAz8rL47XpWS3Gnoi69DSbwkZ5/Pfbn6w2Y
 NVENVJzo6KUmGDg0WQLS9YsUNiVlzyE62PVxat+lcWQTd0SU7DL1yDm5cRWGm4U4tkVl14QnT3F
 bY11QgG5vkAJ5QZpHZW+BEQhhHe8hxeYRDQ9qq5Lozfg44tn0VW3/9ns+MLDMcvMB72E+/kItKU
 K7fVhj898NFnNymzWD8CVI4/rSMULogPVwiUSv0Rsu08s/9y8f1muqfqRhRM1yRYulIi5zn09z3
 L3yLZc135XP6+M9ogkrBTvDGie1MUm6g3NsYoEl0ING7t38MEnTKpUlwafcAUFkYKeDZeebSZBP
 PaFdGvhta5WZeTedrLiTbDqzWi+LJ9Fr2KRBSS8ov7uJjz33EaZI6dRe3ESTDd5ONpXSf7jKkA7
 l33fFI=
X-Received: by 2002:a05:693c:20cd:10b0:36a:13fd:b5c with SMTP id
 5a478bee46e88-379652f16f8mr2447605eec.2.1794556762170; 
 Thu, 12 Nov 2026 23:59:22 -0800 (PST)
X-Received: by 2002:a05:693c:20cd:10b0:36a:13fd:b5c with SMTP id
 5a478bee46e88-379652f16f8mr2447551eec.2.1794556761318; 
 Thu, 12 Nov 2026 23:59:21 -0800 (PST)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3795378c2fesm5213376eec.1.2026.11.12.23.59.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 23:59:20 -0800 (PST)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Charles Perry <charles.perry@microchip.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Philippe Mathieu-Daude <philmd@oss.qualcomm.com>,
 Sunil V L <sunilvl@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, marcandre.lureau@redhat.com,
 berrange@redhat.com, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 alex.bennee@linaro.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v16 00/10] riscv: add initial RPMI virt support
Date: Fri, 13 Nov 2026 13:28:55 +0530
Message-ID: <20261113075906.715870-1-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAzMSBTYWx0ZWRfX5rAcTLRcY2AS
 rhtEx7ENq/+9285RHgendptXXZEZFgL/0ItehtBaOJsJeE+r+yB120XFL+RTvmAJHUrhnwDjvJl
 YukN2Nomc1oz4zLWYl5krUbmXYazRe4=
X-Proofpoint-GUID: 7hiYXfmBTSmz9nrGVFuJ61wBQB9jlCTW
X-Authority-Analysis: v=2.4 cv=N+e8hG9B c=1 sm=1 tr=0 ts=6af6c35b cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=NEAV23lmAAAA:8 a=mNYjDVxuJv9qxCF7NYoA:9 a=EBqLvCoidswJ0RKY:21
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAzMSBTYWx0ZWRfX6ZrfMcv1C9Yh
 G5q8wFX/6DSmLtztBUv/yb+cIvIsxpe/c/0o5Bh4fs9NDrEtAABZJ1RyikEUfIvsN4Matvp1si0
 N3VPL28ufVPWQtdSltCdjYtpn+mT9vpWrNZVwqJ3oFwga1xcC3mMAUPYdlBQE9I4jLcFhuuZj6L
 14B84HSXN1MYiMMqqWpmXWLpGVS5Ti+HEU/zCevFlMgagUxGd1Tjse8nfkGIZkF8y51NLo5Pn+j
 XXiX2wLZUslsPLFn+ds1wzyHz/2a6+961C5l1nj1e+JWyVjGA0ww6WviLmRu3ICfOi9HkapBBOh
 n5opFGaIKTlVUSUaEhZQqti6nvoOKUAjojdcGHsUuva/J1VeRDECtBSzUAa1f1FPp4svVL1d5Uu
 JLKu6kM6pvlJofHZHEY8GlD0ygjTPG/xZr3Op5cby0FDW8yLctRCZqp9SWECir4/v3oqtVI0ehW
 L0Gp7Y2DWUKVETEF5lg==
X-Proofpoint-ORIG-GUID: 7hiYXfmBTSmz9nrGVFuJ61wBQB9jlCTW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 bulkscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130031
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
- RPMI-capable OpenSBI firmware for the functional guest test. The
  CI jobs provision a pinned source build; kernel and rootfs use
  pinned assets unless overridden.

Changes since v15:
- Series wide:
  - most of the minor changes done were to fix the sashiko comments.
- [01/10] build: add optional librpmi dependency:
  - Warn and disable RPMI when auto mode finds an incompatible librpmi;
    retain the error for explicit enablement.
- [02/10] hw/misc: add RISC-V RPMI transport and Base support:
  - Clear the doorbell latch on unsupported writes without dispatching.
  - Reject shared memory above librpmi's 32-bit size limit before allocation.
  - Put the no-op environment-lock rationale next to the platform hooks.
- [06/10] riscv: add RPMI HSM service:
  - Remove the unreachable failure branch around reset with error_abort.
- [07/10] riscv: add RPMI system suspend service:
  - Derive resume alignment from the target hart's active ISA, including
    when a writable MISA has disabled compressed instructions.
  - Remove the corresponding unreachable suspend-reset failure branch.
- [08/10] docs/system/riscv: document initial virt RPMI support:
  - Document a pinned OpenSBI build and the thorough guest-test command;
    state the firmware prerequisite and distinguish passes from skips.
- [09/10] tests/qtest: cover initial RISC-V RPMI services:
  - Test unsupported doorbell values and resume alignment after clearing
    active MISA.C through the qtest CSR interface.
  - Remove dumped DTBs before exit-status checks and fatal assertions,
    including abnormal QEMU exits and read failures.
- [10/10] tests/functional: add initial RPMI virt guest smoke:
  - Use pinned kernel/rootfs assets with optional overrides and clean up
    setup failures; escape commas in overlay filenames.
  - Verify a live CPU1-pinned busy worker before the HSM cycle. Use Python's
    affinity API because the pinned rootfs does not provide taskset.
  - Remove the unused class timeout; retain Meson's 420-second limit.
  - Accept transient start denials after a completed stop; retain strict
    stop-only and fatal-stop diagnostic checks.
  - Provision pinned librpmi/OpenSBI in CI, explicitly enable RPMI,
    and require six guest passes without skips.
- Drop Reviewed-by tags from the changed dependency and documentation
  commits; retain tags on unchanged patches.

Changes since v14:
- [07/10] riscv: add RPMI system suspend service:
  - Check the callback hart index and target CPU before dereferencing
    configured hart state.
- [09/10] tests/qtest: cover initial RISC-V RPMI services:
  - Check invalid System Suspend hart-ID rejection without a suspend event.
- [10/10] tests/functional: add initial RPMI virt guest smoke:
  - Set the outer Meson timeout to 420 seconds.
  - Fail on the suspend failure marker without matching echoed shell input.

Changes since v13:
- Series-wide:
  - Rebase onto QEMU master at
    74f7bf4c59e6b6d50dbc6e124d93440be8be4386.
- [04/10] hw/riscv/virt: add opt-in RPMI base support:
  - Size each A2P request/ack queue from one quarter of shared
    memory after an 8 KiB allowance, increasing it from 1 KiB
    to 30 KiB. Retain the existing two-queue transport.
- [07/10] riscv: add RPMI system suspend service:
  - Reject misaligned resume addresses and addresses outside the
    target hart's address width before accepting suspend, and
    require the resume PC to be backed by RAM in the active
    system-memory map.
- [09/10] tests/qtest: cover initial RISC-V RPMI services:
  - Check resume-address alignment with and without compressed
    instructions, MMIO and unmapped-address rejection, RAM-backed
    addresses, RV32 width rejection for mapped RAM above 4 GiB,
    and recovery after rejection/reset without suspend side effects.
  - Verify the enlarged DT queue ranges and last-data-slot
    wraparound, accounting for the head/tail metadata slots.

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
- All ten patches build individually with and without librpmi.
- Compatible, incompatible-header and absent-librpmi configuration cases
  pass; auto mode disables incompatible librpmi and explicit enablement fails.
- Without librpmi, the default virt machine realizes and explicit RPMI
  enablement rejects with the expected unsupported-build error.
- RPMI qtests immediately after [09/10]: 22/22 subtests passed, including
  unsupported doorbell writes and active-MISA resume alignment.
- Linux guests immediately after [10/10]: 6/6 passed twice, covering repeated
  and busy-hart HSM stop/start, stopped-hart reboot recovery, service
  enumeration, poweroff, reboot, and suspend/wakeup followed by HSM stop/start.

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

 .gitlab-ci.d/buildtest.yml                 |  58 ++
 Kconfig.host                               |   3 +
 MAINTAINERS                                |   3 +
 docs/system/riscv/virt.rst                 |  99 ++++
 hw/misc/Kconfig                            |   4 +
 hw/misc/meson.build                        |   8 +
 hw/misc/riscv_rpmi-stub.c                  |  16 +
 hw/misc/riscv_rpmi.c                       | 605 +++++++++++++++++++++
 hw/misc/riscv_rpmi_hsm.c                   | 359 +++++++++++++
 hw/misc/riscv_rpmi_internal.h              |  43 ++
 hw/misc/riscv_rpmi_sysreset.c              | 185 +++++++
 hw/misc/riscv_rpmi_syssusp.c               | 210 ++++++++
 hw/riscv/Kconfig                           |   1 +
 hw/riscv/fdt-common.c                      |   8 +-
 hw/riscv/meson.build                       |   3 +
 hw/riscv/rpmi-fdt-stub.c                   |  24 +
 hw/riscv/rpmi-fdt.c                        |  92 ++++
 hw/riscv/server_platform_ref.c             |   2 +-
 hw/riscv/virt.c                            | 144 ++++-
 include/hw/misc/riscv_rpmi.h               | 112 ++++
 include/hw/riscv/fdt-common.h              |   3 +-
 include/hw/riscv/rpmi-fdt.h                |  34 ++
 include/hw/riscv/virt.h                    |   3 +
 meson.build                                |  19 +
 meson_options.txt                          |   2 +
 scripts/ci/build-rpmi-deps.sh              |  49 ++
 scripts/ci/check-rpmi-guests.py            |  36 ++
 scripts/meson-buildoptions.sh              |   3 +
 target/riscv/cpu-qom.h                     |  16 +
 target/riscv/cpu.c                         |  61 +++
 target/riscv/cpu.h                         |   7 +
 target/riscv/tcg/op_helper.c               |   4 +
 target/riscv/tcg/tcg-cpu.c                 |   1 +
 tests/functional/riscv64/meson.build       |   2 +
 tests/functional/riscv64/test_rpmi_virt.py | 310 +++++++++++
 tests/qtest/meson.build                    |   3 +
 tests/qtest/riscv-rpmi-test.c              | 816 +++++++++++++++++++++++++++++
 37 files changed, 3344 insertions(+), 4 deletions(-)
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
 create mode 100644 scripts/ci/build-rpmi-deps.sh
 create mode 100644 scripts/ci/check-rpmi-guests.py
 create mode 100644 tests/functional/riscv64/test_rpmi_virt.py
 create mode 100644 tests/qtest/riscv-rpmi-test.c

base-commit: 74f7bf4c59e6b6d50dbc6e124d93440be8be4386

