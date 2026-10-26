Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70392606A329
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 13:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SXSp3gDo;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XVpozVLk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLKhG-0003AG-Ih; Mon, 26 Oct 2026 09:25:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xLKhE-00030I-So
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 09:25:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xLKhC-0005Lj-MR
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 09:25:04 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QAspcW2168616
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 13:25:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=ZvSuFQ99v2Fd/2Hvfa9fu6VLCCTWpL7pug2
 l8nlXpfM=; b=SXSp3gDonxjJSOfaEgmzu75eQcp9esPqleO36+wxbACAh1LtIQ6
 dWF+JZnD6QENSrRUsUqncWBzT0f5/hY1zJkwZ01N/O+jdRqm+b2izfjDU82O3gBR
 rtq52UmBs/eflPhB836uYHMgo5tWJtuPb4Aprhnwk8xZ82bvfb7TsWUD0pRBdSBz
 gfAPg+Wf45mcqbbTTl6Z7iHI3RlW96Wuv/JbRrFgj67C6s19s/uvOumIzlTiVsc5
 qyR2vIcW8WXOJaCnLrwv7hyQoz3oqcrkmiBGI2zY2RID+E/tmN4/7nuPEL1mhb3V
 ug4l9pCu5S6Ie5jA4AC3XiGBRjmer/+EIwQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj3u60y11-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 13:25:00 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2e969b16118so4182555ad.0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 06:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793021100; x=1793625900; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZvSuFQ99v2Fd/2Hvfa9fu6VLCCTWpL7pug2l8nlXpfM=;
 b=XVpozVLkSg9/cpLBjqazeDVKNjJVRriLhlXUZKygbLBPrzPeglvDwAKCra+XiSuQsO
 KeXtuUC04C4y2tRfIuaCWkPdjWrRcIj/mHGlgOyWzT0/FK4R20yCKWNE90HWAQjDfcCm
 lRYAf7a+xVZ7w8iohyXPufhQstXtG6Frg/rHc6gZemBKDRAJpUrVlc17GrDUd9vavHSl
 3TVfCFj59e88BnCZmdi0Y8Bnj4ioWB8dB4r3xw0zFSC6eAn6u9dDxunwSMWczHp7jdGF
 yeIzuR35exQ8pgcy3HYKJaatKbvPDcH0NSvMSV/wJpPkpQZNcKk4Af8ajOIegna9voxT
 gH/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793021100; x=1793625900;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZvSuFQ99v2Fd/2Hvfa9fu6VLCCTWpL7pug2l8nlXpfM=;
 b=lvIvprxJfMmVstu/Y1sc/no7iL59QivegEdZv1hBFjz3D7Yq28E0MJCa6uXTcilncC
 zz4a+ET9M1ekYCDebdTIbraZDfo2eqNwo4GNvS9twYgOHmbDQUjAhSheEYs8nrcTtpL6
 f9Rupx0PL9eaZYGY0UnHTz7d0qSlFd15ca4Z217qW1rr2U9H2T/+pDc5RC7OznrCMBmD
 CdOx+LmxjZ9vU5J+CK293T8q7BnXUxq4wncOOIuRXE4TZbdpp7Y6mZ7EB0vquKIFjDPs
 O9Kc0AhQrbqsCzJHF0Ly6uJ4vmsmWSlzP0ZA61HY5ekJySClqkHVVcQmcffUG7KBTDOb
 v+Ew==
X-Gm-Message-State: AFq9FYLCGzsop8S8MUT2Zuk6qCiWO33DyY5sxXa5D2FS6mqM1/5l7oHR
 n6w+ird17bBWZetz5kczw6Twu/1OtcCYLcrxl47uge8FfDIGZekUVgzPc/Ej6BFYye4K8LdtKKP
 ZIvROjOU6b0mrLl36viBsASHtNcP/JsoTKaY9XUDBhto1n0bwDmD62rQk1l9ZOlG5+w==
X-Gm-Gg: AYBFou0fmPSZ6AWP5r3FGBFHbsW8MinyQClyjc0B3L/AmuBY1ik4CW4A3SF3sF+BovS
 mZZ1ylQhN2MwMKBY53dyfPtShmlLDBHo+oXROrwtt/oaAiTT1jyx80FomzcjA2N2+Ls7UGzpFnI
 pIeNt/I2+K5WwEQJcsorcI5q0k3xAUKN7JaOFZB4STvErfNd9FTpzQURHxRHBpxO3PvJD0go5xE
 S86oq6gAY63MjxPFbZGd0HkjafihaoBwC3PzKOttZv9WlvmQKlT+WKFplRk+9/FKpxtYLX1/ceA
 6uKx1my/7NpkbfBHz6X2iIQz5ZRWfC/DBd/7wbtY/pd10jQWZ+KbxoLEK2e+v8WNHa4wcueIQCe
 BYcDacR2/dz2CQrEDeDHU7xcWIqE1HaDPk92bt/42bkj0V8R2x1wv4fQ4N6cGkw/G+fdTxKNZGn
 a8GycsMW024jr2LOzlVfmZuIAVU2hC4A==
X-Received: by 2002:a17:902:d4c1:b0:2e9:65bd:62c7 with SMTP id
 d9443c01a7336-2ea9b8db07fmr94435225ad.0.1793021100224; 
 Mon, 26 Oct 2026 06:25:00 -0700 (PDT)
X-Received: by 2002:a17:902:d4c1:b0:2e9:65bd:62c7 with SMTP id
 d9443c01a7336-2ea9b8db07fmr94434765ad.0.1793021099284; 
 Mon, 26 Oct 2026 06:24:59 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369e8db450bsm24312725eec.17.2026.10.26.06.24.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 06:24:58 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
Subject: [PATCH v2 0/2] hw/riscv: add RPMI support for server reference
 platform
Date: Mon, 26 Oct 2026 18:54:47 +0530
Message-ID: <20261026132450.2697115-1-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 0mLuNXVU2Tavo29_4KpSDMM2xvGvF5qq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA1MyBTYWx0ZWRfX2Ydjdminviep
 o16hOzNc/gA6KLNrFS5Kn5dFOLkB6BuhnbBNHWN/NvtolYXwrZncwa/0uD9Y6oxK3liPbq4N6Ne
 cgKQZgBD/ry7iOajsGOB0KC7HwZd/ZoYN8WbbrRrirPzuMC7HILLzzS90VdEHe4syqvBoSjU5D9
 UqjDMttjM8htDKWnJfHXX3FeV3ehUF2YBzmeTxN8qDQU1SJu761j99xuD2Kv5nXmflcNsYei0ke
 awb7pjxCUCJmQjOVej9LtTJMIVFY6tqpi76OD+vFMKBfBLwjQoJHJeBw9HAFxxkCoVtHQp+L9eb
 7eAWYuYZLPAyiWmwjMWn/1dg1rlmdxaZvCXZ3W0H63/vU/9bpeh8dvsRbQrVlvTd/pRxOPplKNw
 h5C4u6lzFW3eer4DlVS0Z5o80u6Pqi3bROSUz4qswK6vgKUIzVwiTgNits1GWovDXzE+svBpup3
 JE3EGChl/GLhxDYi6hg==
X-Proofpoint-ORIG-GUID: 0mLuNXVU2Tavo29_4KpSDMM2xvGvF5qq
X-Authority-Analysis: v=2.4 cv=K823jCWI c=1 sm=1 tr=0 ts=6adf54ac cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8 a=do0brKAVnJz7bNJZ1B0A:9
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA1MyBTYWx0ZWRfX6KZNsesSFIfR
 FPKL8nWH9jRwTv1ZG22x9gF8ifaYvLwAxfZhJjXUiG7At5XjiaAK3TeC0cHgevJ2gWSAtGOcTEY
 u75uXVm1RrF7BLK9LvebO3MXxs6izjM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260053
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

Add RPMI transport and service-group support to the RISC-V Server Platform
Reference Board. The series applies on top of the initial RPMI virt support
series and wires the board's reset, HSM, and system-suspend operations to the
same librpmi-backed implementation used by ``virt``.

The RPMI FDT service nodes are emitted as ``/soc/<service>`` siblings of the
shared-memory mailbox. Each node keeps its ``mboxes`` phandle and service-group
ID, and the server-reference qtest checks this hierarchy as a regression.

Changes since v1:
- Series-wide:
  - Rebase onto current QEMU master, where the Server Platform Reference
    Board prerequisite is already present.
  - Replay the RPMI virt v12 series and update the shared FDT syscon helper
    call accordingly.
  - Fold Charles Perry's FDT/schema fix into the server-reference changes.
- [1/2] hw/riscv: add RPMI support for server reference platform:
  - Emit server-reference RPMI service nodes as /soc siblings of the mailbox.
  - Keep RPMI mandatory when librpmi is available.
  - Retain configure and runtime warnings while allowing no-librpmi boot.
- [2/2] tests/qtest: cover server reference platform RPMI:
  - Reuse the common RPMI protocol tests and register the server-reference
    machine-specific subset.
  - Add regression coverage for service-node paths, mailbox phandles, and
    service-group IDs.

Dependencies:

- The companion RPMI virt prerequisite:
  [PATCH v12 00/10] riscv: add initial RPMI virt support
  (the `part2-rpmi-initial` mailout directory alongside this one).

The server-reference board is already included in the stated QEMU master base.
Daniel Henrique Barboza's original v9 series is retained here for provenance:

  https://lore.kernel.org/qemu-devel/20260903183125.682865-1-daniel.barboza@oss.qualcomm.com/

Apply the server-reference patches after the RPMI virt series.

The exact replayed stack is available at:

  https://github.com/slingappa/qemu/tree/server-ref-platform

The base branch is the RPMI virt replay on the server-reference prerequisite:

  https://github.com/slingappa/qemu/tree/server-ref-platform-base

Testing:

* librpmi-enabled build: passed.
* Server-reference qtest: 24/24 subtests passed, including the FDT sibling
  hierarchy regression.
* No-librpmi build and expected configure/runtime warning behavior: passed.
* Real server-reference Linux boot and RPMI guest reset, suspend/wakeup,
  reboot, and poweroff: passed.

Subrahmanya Lingappa (2):
  hw/riscv: add RPMI support for server reference platform
  tests/qtest: cover server reference platform RPMI

 docs/system/riscv/riscv-server-ref.rst |  41 ++++
 hw/riscv/Kconfig                       |   1 +
 hw/riscv/server_platform_ref.c         | 144 ++++++++++-
 meson.build                            |   4 +
 tests/qtest/riscv-rpmi-test.c          | 319 +++++++++++++++++--------
 5 files changed, 402 insertions(+), 107 deletions(-)


base-commit: d73149283205645625bfa9fe029cfb68e4c4a9ae
prerequisite-patch-id: 9def488de98fc23699367d9927a2748614b568a9
prerequisite-patch-id: 9cbfba6703781182b08d9a639510b02a3f1ad53a
prerequisite-patch-id: d6ea62843f075b7b7f4000096ee31c6b566e1d92
prerequisite-patch-id: ad6707f93581f344c7e268834b159d019f45476c
prerequisite-patch-id: 1be7a5599a2f93d2030e874b5174ed0a7ee5e593
prerequisite-patch-id: c798e606a4fc4e4adae39e168d6267d143436f34
prerequisite-patch-id: e640b0babd95b0a1ee38f29b08775ff83a2ed197
prerequisite-patch-id: 29f7ddf0db5ffe290ebd6158bc4b4ffdb17cc612
prerequisite-patch-id: 2866353e85e88c0013ec1d4d849f4d779e90180e
prerequisite-patch-id: 29b62d3041ae2818a4e2593e478cf6f453061dcd
-- 
2.43.0


