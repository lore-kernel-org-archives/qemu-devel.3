Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E91D606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 08:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=e7VEbYkP;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZF8qeHD6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNnU0-00037y-M1; Mon, 02 Nov 2026 03:33:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xNnTY-0002wX-Sm
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 03:33:09 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xNnTX-0004v5-66
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 03:33:08 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A25VsvH3924175
 for <qemu-devel@nongnu.org>; Mon, 2 Nov 2026 08:33:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=OwQojmcpU5eTIzULAINk8oiped9vN+f3GjK
 8xGKTfnY=; b=e7VEbYkPhEL0nigcBqH3r3IRu1Wh3MZ5hLNzrz9+1TR4YBZab78
 SikKbLh582KE/eyVMrWiIFO/Js6G/t9RC1V8nJqUskgbNELPfCeiV6/Bz4VZOqNd
 QQXQqRe4If0nisaF4fzjOy90D9b3mHfLv9rEBeVNe+warPVZVDSW86YRYOM1myaQ
 WAGH2gIarc7Y3Nim0rfdG3RGvIimWnb8mbFmO76QuI6ZkVw8tTmjbzOb//IOYZdu
 tNrNuZfhRe5202moJLrmgcGc5QnF5EXla7/AQTu53rbECqzGZEXWzTuCfev/2sZo
 o7MUL5lhfGaSX4CXx5jepsTZPcPLx3Q48qw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpmf1rmvm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 08:33:05 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2e9a4052726so12984775ad.0
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 00:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793608385; x=1794213185; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OwQojmcpU5eTIzULAINk8oiped9vN+f3GjK8xGKTfnY=;
 b=ZF8qeHD6ALJSjsyWTE0oOScxVL6u5NpIWQvUHl8zIDsMH2/IoYZV2TDrg9cBQdG+dL
 7kdVJnIVMf4mEztpeNXgNpHMBESIT4WMuQxslqTQ84620kNzxFs7GRt9rJiMwAIh27zO
 Cqk6cI4oVog7LLK2MzAwZ2b5Dl7QIwn0GG0mupAtk9r4L3IiUZrV1hcz+LsXaVPOfH5P
 i15S8bet5dp2bpUh/AEkYlTdXSJiYUB4HGtrpP3xYay6Okh0smkCbMn2S2WX0aoTn/Oq
 3ed4erkBEQuT4uTTFLwz3DkoLZpVo6jvebtqMpu7QGbvrT5uKbgWz2t0GFNgv0HmmZOQ
 Rg7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793608385; x=1794213185;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OwQojmcpU5eTIzULAINk8oiped9vN+f3GjK8xGKTfnY=;
 b=JsZxk4WdDyd/wn3yiLaf6X7/GBAH/9WvHbohvV5HQy7rKD+DPA5rBZc18B9p7+88BD
 7tqSbAZB4sXLxB+RQrLx5QxFHmiVSAGUVwdb7bJgGX+LfWNQQD98Z8PBjvkT5kVXOZuo
 58gyfFCH4znR9reL6jfb4dNRUkXcWe9GyqD4N8yu0ZWuxYz/6IcND+pw8eJhXakwf59B
 R116QhW7f0GCC2bYt73Me1gdqqhYjwHuvPzSeP3Lam12s57+Qji0DmPw8rzBiwPtBN/o
 rsgFr8G0IE1/jX6pWr9YYuQrvT4XKAW31ii3vWNJHkIxCFtCjjdL2uhYdmOV1fXqfRub
 FQJw==
X-Gm-Message-State: APuU4Z9e0gvH/mlJy7DZu4k8BZG2CSIUGU1u3h0sC+DBmlsg6aaM9dP1
 +TstltXmk39lb0EPwf0JCMLJ6eBkEpGyEv1AcCZCa7/74kEEBtPWyoT0bwDSONAjsybxlr3xTYp
 56lEud6giJbUm6gF8d9a6oE51A7cFS4c0gKYpLoxOWYibBgx/TcXOryOeibF87pcQtA==
X-Gm-Gg: AYBFou3Fju77AmCeXfVkT82b6e4m0LXbZFKL7mE8Jbn1AGSAUKDvX5yV1iYd78+J0L/
 4LGM+nrF8i78VAP8zzEMToGANmcyRTD2PV9eWp68jg4TWj9lAJ8QLypgaV0HDbNN8+LIrlUuasP
 fZnE/yNsPRk5T/CmY+UbpLa8iDRnHKIl9vRDFKopxmObg+YVxt9DRG+3KLL+oPGjh/VTGfLaBvB
 XCPo3xGdGqdNrpF5l6+QBTc4WV+sMddvUpXgLJUbQ0A4KG6SkvmI8lSSER6eeQAvByx8ylssqjf
 zH6AZkjDjfGidr+e9WTfuUcUZ3yAUDCWfiijwGmaTA5z1HnizP2xI9FW7EQF2R0S5z3YR8KAiga
 8XDxt9mAmn3uuOS05SNGl+iAdIS0+LglRb2la5Nx1w7olrjkHSETeH3ZJeOH/aDr03T5iPOJ+Cl
 UbOd/OIoRkLMdYjeSLA9vu2j/NNWGZAEfgHeBd2BipXkQ1jB5N4bKqL3pQx/L66bpS3z+ZGZwsG
 D/k/2nU
X-Received: by 2002:a17:90b:4fc5:b0:3a8:9db2:a59 with SMTP id
 98e67ed59e1d1-3ae891891f1mr13051185a91.0.1793608384922; 
 Mon, 02 Nov 2026 00:33:04 -0800 (PST)
X-Received: by 2002:a17:90b:4fc5:b0:3a8:9db2:a59 with SMTP id
 98e67ed59e1d1-3ae891891f1mr13051144a91.0.1793608384379; 
 Mon, 02 Nov 2026 00:33:04 -0800 (PST)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42a96172sm32074372eec.27.2026.11.02.00.33.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 00:33:04 -0800 (PST)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
Subject: [PATCH v3 0/2] hw/riscv: add RPMI support for server reference
 platform
Date: Mon,  2 Nov 2026 14:02:55 +0530
Message-ID: <20261102083257.3405653-1-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: enpnvCuRo_hS4odi6fb3y5fsN-2byX9I
X-Authority-Analysis: v=2.4 cv=bNaDs/+Z c=1 sm=1 tr=0 ts=6ae84ac1 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=BuW6VaZA-UvrB-SslPkA:9
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAzMyBTYWx0ZWRfXxFD4Y+DwuOcv
 Uq7TwtGEtKyi8UlqjC8hvc1+5Z8LhOVCmQr3Lo1Y/MmdMZuE8/0mb91loJupq1mCmMBTuIksYTj
 jUnN5ZKyXQirCBAPHLat6BbGj6S4aSRC7z/GrRltcZmBeIbJLo9LQxxWt+Kto8d8oHHizL9FvFZ
 666Z+11dDTQNItaOghzmjWd02wpaIugRQC77MzQQGSXBvB0h/L+1aIJvLpTNWK037zkfOMF3jXz
 K7v9VrVUDtMViIob1JPYs5fTvczaxbilrmfBfBiSfjiQltxOpK+J8ynwv/2bR/fOJxyV2tTDuUC
 Z4zfivrdsbeCOz7QNTQvx3Zbfk227Isqo4wPmRfCHFUrdjUrCM1rtdI0JBlh+yJHXcYHtDJckXI
 cvPz4wWKdUGnP1Xd30fTv5trZag6dnFwK/NJmjXkGNBYruwCrFkGmSs+NHY5MeXzxRTq3ITIDGl
 nFNjQri+4mOFIwZBf0w==
X-Proofpoint-GUID: enpnvCuRo_hS4odi6fb3y5fsN-2byX9I
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAzMyBTYWx0ZWRfX/N2rhdmNJCnh
 1Ma72Zds90y/hInN/lamUcrLViPP8F3OXNNFY+o4OAV+HPC5GWBoKiUTg37VLQ6vk+0JMYTQD7H
 1QIDs1UaZKQUO1vluocl/SUWnFZvTME=
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
- [PATCH v13 00/10] riscv: add initial RPMI virt support.
- The server-reference board is already present in QEMU master at
  d73149283205645625bfa9fe029cfb68e4c4a9ae.

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
- Librpmi-enabled and no-librpmi server-reference builds: passed.
- Complete RPMI/server-reference qtest stack: 29/29 subtests passed.
- no-librpmi explicit RPMI enablement rejects with the expected unsupported
  build error; the default server-reference machine realizes successfully.
- Normal and TPM server-reference Linux boots: 2/2 passed.
- Normal and TPM guests reach login with RPMI both off and on (4/4),
  tested against this series on November 2.

Subrahmanya Lingappa (2):
  hw/riscv: add RPMI support for server reference platform
  tests/qtest: cover server reference platform RPMI

 docs/system/riscv/riscv-server-ref.rst |  43 +++
 hw/riscv/Kconfig                       |   1 +
 hw/riscv/server_platform_ref.c         | 149 ++++++++-
 meson.build                            |   4 +
 tests/qtest/riscv-rpmi-test.c          | 418 +++++++++++++++++++------
 5 files changed, 519 insertions(+), 96 deletions(-)


base-commit: 6321a4ee8b32afc3c106f707176073a25e768357
-- 
2.43.0


