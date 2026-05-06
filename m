Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D77FF8855
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 13:48:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcbY-0005Cl-G7; Wed, 06 May 2026 09:48:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1wKcbV-0005Bx-4L; Wed, 06 May 2026 09:47:57 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1wKcbS-0004FB-UR; Wed, 06 May 2026 09:47:56 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 230C541748;
 Wed,  6 May 2026 13:47:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED214C2BCB8;
 Wed,  6 May 2026 13:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778075272;
 bh=EyQ2TYDv7GuMCX2CwNup38B2RlmpOtyqxR+Cf0aiirU=;
 h=From:To:Cc:Subject:Date:From;
 b=OakMZv9du2MPtPK6VKqqkC0hfTzpqPg8crc2HJ0nZ8BBCB4Sk3RM++0n//dRfCuDO
 BXxDSCPhAQoHz0ukUxHhyvCdRIglikX/t772NshiZsdPI+hiP8GwonAvYmrwpeq5gb
 x+xvjoUrAR9gh5cjr5VJxayp5mqKmv7o+BO9vpvBkvSJw9lupVRaJieuoTWtIKncJ8
 VzLqQ0ihersa1JVOkIv1U18eZG1rCdi/Bc35WafRbYCiGTlr0mAD8fg/WxC3rospQj
 xvBOC5Pk7Lk4mRMXa6MMHV/WgEazzy+BmAL1CXJdW9j0hSNmXFQSTo9+yb3OeGTSAe
 foMOYAVWuoP7A==
Received: from localhost ([::1]) by mail.kernel.org with esmtp (Exim 4.99.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1wKcbN-00000008t0c-3ybo; Wed, 06 May 2026 15:47:50 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Markus Armbruster <armbru@redhat.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, linux-edac@vger.kernel.org,
 qemu-arm@nongnu.org
Subject: [PATCH] MAINTAINERS: update HEST maintainership entries
Date: Wed,  6 May 2026 15:47:37 +0200
Message-ID: <6316f5b788cdc6b63e808606649dc5862271b22e.1778075257.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31;
 envelope-from=mchehab+huawei@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Mark HEST code as maintained and assign them to me.

While here, add a "L" entry to EDAC ML as RAS discussions
usually happen there.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index afa178c5cce1..b6e1362e086d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2217,14 +2217,17 @@ F: tests/functional/x86_64/test_acpi_bits.py
 F: docs/devel/testing/acpi-bits.rst
 
 ACPI/HEST/GHES
+M: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
+L: linux-edac@vger.kernel.org
 L: qemu-arm@nongnu.org
-S: Orphan
+S: Maintained
 F: hw/acpi/ghes.c
 F: include/hw/acpi/ghes.h
 F: docs/specs/acpi_hest_ghes.rst
 
 ACPI/HEST/GHES/ARM processor CPER
-R: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
+M: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
+L: linux-edac@vger.kernel.org
 S: Maintained
 F: hw/arm/ghes_cper.c
 F: hw/acpi/ghes_cper_stub.c
-- 
2.54.0


