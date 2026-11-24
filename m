Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1CE606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 21:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ul7vZmTM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVxj4-0003Ry-B4; Tue, 24 Nov 2026 16:06:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xVxiy-0003Ir-8v
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 16:06:49 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xVxiw-0003h7-Ll
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 16:06:48 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0C693436D8;
 Tue, 24 Nov 2026 21:06:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 861E41F000E6;
 Tue, 24 Nov 2026 21:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795554402;
 bh=dLoJqA2o0JsPXAq0qYAiVsYA4wcRg8LbBdJtKLa4xQg=;
 h=From:To:Cc:Subject:Date;
 b=Ul7vZmTM5rKDnkQum7xBjMNjndjslg2W5qXOQzdQg3lKK3v3Lqte20yfJFalV4Ayy
 /AB0p3CaxIw/NePe5TG6j+6H7VJ5VXU09KF0me6Qrv5gj2fh3vCjbwkmW5kd+TLxuH
 96deTMeJWXgY6h4+qF9eA49MScEtaS7mtpgH458WjEWaq0ANF+RiJQNJoCsKcsvo+z
 UHpzd1qPsuAIZ2sI+0IzkvXkdvpTzagcLiL/G9qYlx5F6IPBDVdqCEyIqicuRFPdar
 Kx/6ARDpZcLEcaWKyr6xLGEhQZtUAJP/a0Z9TimHMQCzZ8v+6/0G63SXjgdEDBcB4+
 dLw+/Vi4+GYbQ==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Brad Smith <brad@comstyle.com>,
 "Kirill A . Korinsky" <kirill@korins.ky>
Subject: [PATCH v2 0/3] target/hppa patches
Date: Tue, 24 Nov 2026 22:06:36 +0100
Message-ID: <20261124210639.133084-1-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Helge Deller <deller@gmx.de>

Two small patches to adjust the CPU HPA on the 715 and B160L machine
to avoid boot hangs, e.g. on OpenBSD.
Add one test to check if OpenBSD starts.

Helge Deller (2):
  hw/hppa: fix OpenBSD boot on B160L emulation
  hw/hppa: adjust CPU HPA on 715 to avoid broadcast address

Kirill A. Korinsky (1):
  tests/functional/hppa: add OpenBSD CD-ROM boot test for
    qemu-system-hppa

 hw/hppa/machine.c                     |  5 ++--
 tests/functional/hppa/meson.build     |  1 +
 tests/functional/hppa/test_openbsd.py | 37 +++++++++++++++++++++++++++
 3 files changed, 41 insertions(+), 2 deletions(-)
 create mode 100755 tests/functional/hppa/test_openbsd.py

-- 
2.54.0


