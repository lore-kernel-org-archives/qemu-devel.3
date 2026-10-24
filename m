Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77102606A31B
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 20:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Di/bqOTu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKiKG-0005iQ-P2; Sat, 24 Oct 2026 16:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xKiKE-0005hi-I7
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 16:26:46 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xKiKC-0006df-Vr
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 16:26:46 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8E53543D66;
 Sat, 24 Oct 2026 20:26:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EFAB1F01829;
 Sat, 24 Oct 2026 20:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792873595;
 bh=LJeAfyprJgVRaYEVirq3RAd3md2MVT32ASpJLzGDQto=;
 h=From:To:Cc:Subject:Date;
 b=Di/bqOTuPeLHMOe0KEDKpQUi1N8O3s/ixAMrZAY+2BXuvemz67tiEyHunZuc84Vfg
 Fw8t1ByE+YsYMJB+9wV9EtVCTEe251BasTKOmRcZ6zV4iGWATYtheJzBkDlfSwby43
 pXXjA9oEak8Co77Be4Ec5KrQ5p0CSNZYv+7EDPmLFoPlVLNNzAR6eAA3wtNvxLQhg8
 WpUS2/gh2qHGpJgwJKX6wczlyrPRHGtDK7orvfWIHnjezu1NMRk/OSH5Kc8AUXBylm
 Th9NPEjZnYCceuIo5K8FFd8b4ZeeMhlabgz8YKnToeeORelo77+ofYfwBIYGv0nAfs
 5gGfRAswYXOZg==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v2 0/2] linux user patches
Date: Sat, 24 Oct 2026 22:26:30 +0200
Message-ID: <20261024202632.103711-1-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Helge Deller <deller@gmx.de>

Two patches from Peter Maydell for linux-user:
One fixes the signal context on loongarch64 and the other replaces an old
pthread implementation by an QemuSemaphore implementation which better mimics
the wanted semantics.

Peter Maydell (2):
  linux-user/loongarch64: In extframe_alloc, align before subtracting
    sctx_info size
  linux-user: Use QemuSemaphore to wait for clone child thread

 linux-user/loongarch64/signal.c |  3 ++-
 linux-user/syscall.c            | 17 +++++------------
 2 files changed, 7 insertions(+), 13 deletions(-)

-- 
2.54.0


