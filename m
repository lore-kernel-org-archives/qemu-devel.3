Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9B3606A32A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PVkS24FD;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WUv7DiQp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRmDa-0005QU-FK; Fri, 13 Nov 2026 03:01:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xRmDU-0005Hx-8Q
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:01:00 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xRmDS-0000Xd-0o
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:00:59 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AD56wCQ3717190
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 08:00:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=I9uMNv0T1oP5jJbUNJmSPgK/5QhVoE5LXvx
 EJQiEATk=; b=PVkS24FDW0TiKUNTC7v7wLbkBF4Hxa3law5EZP3u1/rT6UQyJmi
 5npvy3We41rxpafk6Q0PJFNfGLR15LQeCI0InJoTubll2JVhMruQGHT7Mpn1Ht0k
 Hz2+rjNY7MkKjX6ZzffKPiH7JDIrwcgE80MnBZhsuHNk8DkkrMMITRPTUI+8W0cx
 YQQX61CsBLI6QzkPFis/ZUh/GyRIxjaeayU72KLrMxVz5i1QuW1E42sbvnwqnsXj
 5erasfe36e+pRyear+l8pWJ3ABb2otsuPFpjt4Jx/u20howhssPr7aIK9y3hR3MX
 qX8wrnMn5ZAYVk8rta3HTyg4W3NzWpIEnIA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwqufhd7m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 08:00:55 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30c58d35c0aso115384eec.0
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 00:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794556855; x=1795161655; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=I9uMNv0T1oP5jJbUNJmSPgK/5QhVoE5LXvxEJQiEATk=;
 b=WUv7DiQp4hTKicRLpT110LJ29EXQQMwfkObYPQPehn6kocfOu/RNMLHkZMoIhqrHPx
 xuzn6hEle1QHYDpj+s51Krv06bvrns4bke5qkPfddpdSzeFOEwq1jWjxsExAtiSdVUR6
 mvDsZavdmGdwupJidM0oyM9pLoyfXI5UbFY7QX4eUmMb0Yjg08MrzK/gbXj/DGjSvDH5
 ofG+XRzaf6PRMZ35IiPP5hFNWqvl6FbBgi4tzQt6wUHEi6F6mrGREyPzCRBN5jjpZriZ
 x248a31+OtaixKrbQ9ZhUlQTiLxJ7+ZDJWlWuCs+oL96dNb3xwPiJ49CucyAYTFM5SVz
 9xIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794556855; x=1795161655;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I9uMNv0T1oP5jJbUNJmSPgK/5QhVoE5LXvxEJQiEATk=;
 b=PYi6d88JobtOYl95V32ygRIplG6sOMw2CWiUX6uJfGuaDero9l+dIq94Bwz/ATEYX3
 7I3ND69Thl//TeFG11Gk/tu/Jmvjlwqbfv7r3eAjyPBAGggKiNlBGai6jX79CCy2Z9Aa
 DlEHIruzUhae3W5IXboAzuR8+BJz+g1eMgsqluJvx5R5mLKnu2kPlWYm7/8zGNNrDv1O
 zKEPeQZQMfb7oQpu+l5TkdNqil3Q70kIHHAg5kVTwHzVNcKC+M+wtcQNww4UERSwdZyv
 3PAsIi8/3Jzs9j/CYbURRVmB87BP0MWsHeIANbEGVaR19AbQ3RihgzrSasccyfpXu1C+
 o35Q==
X-Gm-Message-State: APuU4Z+i6Sivc2dbGFgbfrgMuqsTAZSgjWEx5fHqUbVRerwmfS4iKuVq
 3O2LLalj2jfP1tSNIG/vn2DBJlTW5sS8bIyAlAp0yUb/02qOQ9I5MuC8NZ+/CcCY0gKhNWYX1Tv
 jAVKPMt5VjmYweDk8MVxarERbVdDLfj4hiW6z7Ik97D9nIbX+ojwz3J3gGgjNAT2bBw==
X-Gm-Gg: AYBFou2RetIQa8RfqdMiQmKD/K5wDSTt/O0YdbeNF05NqrKsdEqWd/5lcadTnlIUHtJ
 u7c+ngG9SuIi9xVYTqqB6vexuECEB+R6j8Vx/ja2mDx4UlwwmTjmvmAigB/+g3BDSz+Qc2E6FH+
 RLXRoobZxCjTalFy13ZSfloXbpSE9LekOnt+4shGRsiAy1F1/kYDzIBnlUsUsEauCVoPooyaJfl
 ap6Tvp/aijcaGuH2d1s4gU79lUdd0goi9OqSbdd//8nXlpB2RxxQIp97SJA152aB1cnVAa9Er/o
 c/q/rxMR+zk1XZIt7mvaELlhlrGealrfgjVoExKLFOzMa1QJWwQ5hdex5HoI7Y5/pzR32yMjCdV
 wLWw2FFwTNGV0YwT5+ft4yDBszlrFUeKlzSkrBz48QvKl3NSNUlHNq1y0g+8B7w0dpXO0KeIOr8
 UzckAGP/pPYARX/8ZHdGG38u3/i1zPZs6byhhGEVDP/kl5mTjQEx6WQl97l8HO1OP7CJsCq3vQg
 ajg0B8=
X-Received: by 2002:a05:701b:2810:b0:1b2:5884:a039 with SMTP id
 a92af1059eb24-1b502f9cda6mr2658424c88.0.1794556855073; 
 Fri, 13 Nov 2026 00:00:55 -0800 (PST)
X-Received: by 2002:a05:701b:2810:b0:1b2:5884:a039 with SMTP id
 a92af1059eb24-1b502f9cda6mr2658371c88.0.1794556854201; 
 Fri, 13 Nov 2026 00:00:54 -0800 (PST)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5031b2519sm4642645c88.13.2026.11.13.00.00.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 00:00:53 -0800 (PST)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Charles Perry <charles.perry@microchip.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Philippe Mathieu-Daude <philmd@oss.qualcomm.com>,
 Sunil V L <sunilvl@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, marcandre.lureau@redhat.com,
 berrange@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v6 0/2] hw/riscv: add RPMI support for server reference
 platform
Date: Fri, 13 Nov 2026 13:30:36 +0530
Message-ID: <20261113080038.720571-1-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: N5r9VzD_W_h7Gait52YvK_0GOJLwlNk_
X-Proofpoint-ORIG-GUID: N5r9VzD_W_h7Gait52YvK_0GOJLwlNk_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAzMSBTYWx0ZWRfX3WJlmEm6Hb8D
 1n3mY2KTp60A+FULbeKkiXxsdzxdjuaOCgPx5JtVmEtM5AwDDGSza1x+QtIcSAdQSYMw6DNheTB
 HT5PcU5haIK2G1YriP3MlrA2PWxy0duqufFTaU2kXcrLXelPMcGVbIBi9jHlKXab4gis44GUUUb
 gkUSIbtfeqZccqGjZ2uEkg06eUcX320Ds2+PqE9Y2OSIIKP4d0v3ucEmax3txodAbySfQWYtcj7
 GvlQfeom3Z3jnrdUfPM45IE7A2MtGc/LDTkXghY5bFxhTQdwbGQeKTP67qCgFJKCX2DomvMK5hS
 twBwCf+FvA15hJhGoxekIHunM9wyKKgVvKmmY8tG/ly9o4/kwkiwTKmX9N1vUNik+DGkMVGRjvD
 T+eXVkOnszmYyPAYqhUg0tNyh79I9A7F14NwCN5PQk2Xjbizxi2aW31RwVpApL6G+mwM2b84ECg
 CPHXKCseVYDRm8++lKQ==
X-Authority-Analysis: v=2.4 cv=XZocX455 c=1 sm=1 tr=0 ts=6af6c3b7 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=5MT0i9eAnCxZ9ojN1gIA:9
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAzMSBTYWx0ZWRfX2G/xH7R18nEf
 aTq3lZ0q2oNBYvzaoEXu5+U/X4bHWQTpkcjzZAquaH54fUXr3FTvsXne5csteAeE4iHeKac2qsM
 3Zlw1Mt7lQZLe1TSoO7GOu5spfC5QQc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130031
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add RPMI transport and service-group support to the RISC-V Server Platform
Reference Board. The series applies on top of the initial RPMI virt support
series and wires the board's reset, HSM, and system-suspend operations to the
same librpmi-backed implementation used by ``virt``.

The RPMI FDT service nodes are emitted as ``/soc/<service>`` siblings of the
shared-memory mailbox. Each node keeps its ``mboxes`` phandle and
service-group ID, and the server-reference qtest checks this hierarchy as a
regression.

Dependencies:
- [PATCH v16 00/10] riscv: add initial RPMI virt support.
- The server-reference board is already present in QEMU master at
  74f7bf4c59e6b6d50dbc6e124d93440be8be4386.

Changes since v5:
- Rebase onto the initial RPMI v16 prerequisite. Board integration and
  server-reference queue sizes are unchanged.
- [2/2] tests/qtest: cover server reference platform RPMI:
  - Preserve the new doorbell and active-ISA tests in the common harness.
  - Keep machine-specific state available to the early regression helper
    and use the common machine setup for unsupported doorbell writes.
  - Inherit DTB removal before exit-status checks and fatal assertions.

Changes since v4:
- Rebase onto the updated initial RPMI v15 prerequisite; server-reference
  code is unchanged. Wrap one long assertion in the qtest.

Changes since v3:
- Rebase onto QEMU master and the initial RPMI v14 prerequisite.
- Keep the board integration and its queue sizes unchanged.
- [2/2] tests/qtest: cover server reference platform RPMI:
  - Use per-machine queue sizes in the shared harness: virt uses
    30 KiB queues while server-reference retains 1 KiB queues.
    Derive acknowledgement offsets and ring moduli accordingly.
  - Inherit resume-address coverage for RAM-backed PCs, MMIO and
    unmapped rejection, and RV32 width checks on mapped high RAM.

Changes since v2:
- Rebase the server-reference integration onto QEMU master and the v13 RPMI
  virt prerequisite.
- [1/2] hw/riscv: add RPMI support for server reference platform:
  - Add an explicit ``rpmi=on|off`` property, defaulting to off so the
    existing board remains migratable and retains its legacy reset/poweroff
    device-tree nodes.
  - Gate RPMI realization, reset/shutdown callbacks, and service nodes on the
    property; reject explicit enablement for KVM and no-librpmi builds.
  - Document the property, migration restriction, build requirements, and
    both device-tree layouts.
- [2/2] tests/qtest: cover server reference platform RPMI:
  - Reuse the common RPMI protocol tests and register the server-reference
    machine-specific subset.
  - Add checks for default/off and explicit-on machine policy,
    service-node sibling placement, mailbox phandles and service IDs,
    legacy syscon nodes, and migration behavior.
  - Name the RPMI-off migration test as a policy-command acceptance check;
    it does not restore a destination VM.

Testing:
- Both patches build individually with and without librpmi.
- Combined RPMI/server-reference qtests after [2/2]: 32/32 subtests passed.
- Without librpmi, default/off realizes and explicit RPMI enablement
  rejects with the unsupported-build error.
- Normal and TPM Linux boots with RPMI off and on: 4/4 reach login
  using the unmodified device tree.

Subrahmanya Lingappa (2):
  hw/riscv: add RPMI support for server reference platform
  tests/qtest: cover server reference platform RPMI

 docs/system/riscv/riscv-server-ref.rst |  43 ++++
 hw/riscv/Kconfig                       |   1 +
 hw/riscv/server_platform_ref.c         | 149 +++++++++++-
 meson.build                            |   4 +
 tests/qtest/riscv-rpmi-test.c          | 430 +++++++++++++++++++++++++--------
 5 files changed, 529 insertions(+), 98 deletions(-)

base-commit: 74f7bf4c59e6b6d50dbc6e124d93440be8be4386
prerequisite-patch-id: 8fffcd6b5c68f533d85fdcd7c427113bdb609577
prerequisite-patch-id: 7117af90e495eb5c358091576b26118d304054dc
prerequisite-patch-id: d745e935ff34157805c5fa043b92f1ffed09c99c
prerequisite-patch-id: 5d8b74a31f56484a810c44c656616f5fc17ffd2b
prerequisite-patch-id: ee4b16cba8eb1048cd3377d7b1aa78a839d84c41
prerequisite-patch-id: 3b3fada964e9e927359bb168f49d3417f7e8b798
prerequisite-patch-id: aed503f0f29d981051f5d286fafd766c8957f784
prerequisite-patch-id: f05e533da8e2eecca237d3fb54cf7a324aee8dae
prerequisite-patch-id: eac8078c13dbcfa70fd4e9cd7df234f7f33c7912
prerequisite-patch-id: 2f98fd26829eb693b33ef3076c375290eaf4541c

