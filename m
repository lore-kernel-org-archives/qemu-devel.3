Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A348C021B6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 00:41:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmizs-0004aC-EP; Mon, 24 Feb 2025 19:40:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tmizo-0004XZ-Jy
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 19:40:24 -0500
Received: from fout-b6-smtp.messagingengine.com ([202.12.124.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tmizk-0003Rn-N7
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 19:40:24 -0500
Received: from phl-compute-10.internal (phl-compute-10.phl.internal
 [10.202.2.50])
 by mailfout.stl.internal (Postfix) with ESMTP id B5F141140122;
 Mon, 24 Feb 2025 19:40:17 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-10.internal (MEProxy); Mon, 24 Feb 2025 19:40:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm2; t=1740444017; x=1740530417; bh=Qc
 Y7yloHBJOi4V2A4+6R1KX+428NZiRlMHeP7YBEZqU=; b=pM8ayDa/q5ArUF8NNA
 q4aDabdbYB4oIcXte5qEpAR5joe5NUft6jMVnvnkfkmeaVZuoatK2F2Wlm044OHT
 7upDn/3RYDIA1mvECSWvaWkyhXdQ9rmCjOp3Zd7grPexQVXwUjHugpV+UEoZ84xT
 ZRk4caGPk6TYC/4mDr2FbxqzFVUv2cszP78tgs/Y7SvSndrwpQy0KSgg6rzNCzk/
 CPyTGnLA0/mJj0suMWO2d1HasXG+Wf9wtJNLYAYwl96y1AH8qkorOVT0Iz4XFrxE
 TZVR2bZJ10+78EEbNSdOaeHgORlGAJDdILF1s00rSdOsUDepolZARn8ZTSuQN2Uw
 K3uA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1740444017; x=1740530417; bh=QcY7yloHBJOi4V2A4+6R1KX+428N
 ZiRlMHeP7YBEZqU=; b=zHoMpSLEOOTdZFMhcoO+PRF2uZQUM2FXOytcQH2G2JlL
 eV9Umsw2bmNqhJbIFgfcJP8t/AOKZR2WbE4WJLSx/6kXSPa1KUiOIJXM7t4Xw//L
 LWoz2IocDad28uwgIJoylKurAMdMIb7JP7eFVINdCCaqexXhEKEQ2EA5BNaM9Aie
 xw2+ZjNjjCpyCzjZc8VSQUyEiA2YH6WmtRe67m8KevJ9pmsdnrME0Y8CtqwbAEmU
 gpqF5mGvCIbU7fSLiqIU+bMXDLkIpZCkI5yvEosn9NRrri8qszrm15J5LDWZMRez
 LiIUxrLwdCJ3GC4usg/FaPKxPvejWTmDU0Ihr14IIA==
X-ME-Sender: <xms:cBG9Z_k1zz-TiSgTf45Cs3iqxVmSX6wqpxd5ruX8NPqGkh0Ji8bJxg>
 <xme:cBG9Zy3NOU3ufsaiN3VNiC8ZyuuINW1G8_4a49ONHH5cfME6VHFN4ruSzbFSCTEod
 B-ms08L2lFlsGb95QY>
X-ME-Received: <xmr:cBG9Z1oiz_LCfuTX6M3buc_0LalKuF9DP5guZ3EKntusyrkAH9FFojY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdektddvhecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgvfevofesthejredtredtjeen
 ucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihgh
 horghtrdgtohhmqeenucggtffrrghtthgvrhhnpefgveffjeetgeejfeelgfekteelkefh
 uefggedvueeujeekjeetkeekvdffffefudenucffohhmrghinhepkhgvrhhnvghlrdhorh
 hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhi
 rgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomhdpnhgspghrtghpthhtohepgedpmh
 houggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhirgiguhhnrdihrghnghesfhhlhihg
 ohgrthdrtghomhdprhgtphhtthhopehgrghoshhonhhgsehlohhonhhgshhonhdrtghnpd
 hrtghpthhtohepphhhihhlmhgusehlihhnrghrohdrohhrghdprhgtphhtthhopehqvghm
 uhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
X-ME-Proxy: <xmx:cBG9Z3no6XbhYd99xLjc1VjPOyDEQbiIL9tw4w_Y4pfuyhZSpwQlUg>
 <xmx:cBG9Z911REK372Qmqeed2_lOzF_wf5lIELLApN2bQhhQfMzvEGTvjQ>
 <xmx:cBG9Z2tZrYf3hgJVYb2eKHIiC-fk2DO9PgnxMBC5rZmttAykMf-8fw>
 <xmx:cBG9ZxXGZi5QP_L5BojSNeu_1I1dXrdoB5zE_k-tYSwpi6ikccLVvw>
 <xmx:cRG9Z4QiQdG8gCs_GPcN3pgAI1lHS500Opl-9iGBOXnjTlcAfe1D-oQs>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Feb 2025 19:40:15 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 0/9] target/loongarch: LoongArch32 fixes 1
Date: Tue, 25 Feb 2025 00:40:13 +0000
Message-Id: <20250225-la32-fixes1-v2-0-8ec68ada3dd5@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG0RvWcC/22MwQ6DIBAFf8XsuTSwUoo99T8aDwirklgxYEyN4
 d9LPfc472XmgETRU4JHdUCkzScf5gJ4qcCOZh6IeVcYkKMUiMgmUyPr/YeSYLXS1grpeKMVFGO
 JdD5FeLWFR5/WEPczvonf+r+zCcaZtgq7O90a6bpnP+1DMOvVhje0OecvPyLAs6gAAAA=
X-Change-ID: 20241222-la32-fixes1-368cc14d0986
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=202.12.124.149;
 envelope-from=jiaxun.yang@flygoat.com; helo=fout-b6-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi all,

This series is a collection of small fixes I made to TCG for
LoongArch32.

There are still many thing broken, especially on CSRs. More
series following. However this is sufficient to boot 32bit
kernel.

Thanks for revivewing!

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
Changes in v2:
- Addressing minor review comments
- Don't create 32bit vairant, simply allow 32bit CPU on qemu-loongarch64
- Link to v1: https://lore.kernel.org/r/20241222-la32-fixes1-v1-0-8c62b7e594db@flygoat.com

---
Jiaxun Yang (9):
      target/loongarch: Enable rotr.w/rotri.w for LoongArch32
      target/loongarch: Fix address generation for gen_sc
      target/loongarch: Fix PGD CSR for LoongArch32
      target/loongarch: Perform sign extension for IOCSR reads
      target/loongarch: Use target_ulong for iocsrrd helper results
      target/loongarch: Fix some modifiers for log formatting
      target/loongarch: Use target_ulong for CSR helpers
      target/loongarch: Fix load type for gen_ll
      target/loongarch: Introduce max32 CPU type

 target/loongarch/cpu.c                             | 152 +++++++++++++++++----
 target/loongarch/helper.h                          |  22 +--
 target/loongarch/tcg/csr_helper.c                  |   2 +-
 target/loongarch/tcg/insn_trans/trans_atomic.c.inc |   8 +-
 target/loongarch/tcg/insn_trans/trans_shift.c.inc  |   4 +-
 target/loongarch/tcg/iocsr_helper.c                |  20 +--
 target/loongarch/tcg/op_helper.c                   |   4 +-
 target/loongarch/tcg/tlb_helper.c                  |   2 +-
 target/loongarch/tcg/translate.c                   |   5 +-
 9 files changed, 155 insertions(+), 64 deletions(-)
---
base-commit: 65cb7129f4160c7e07a0da107f888ec73ae96776
change-id: 20241222-la32-fixes1-368cc14d0986

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>


