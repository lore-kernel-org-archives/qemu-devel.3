Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB1EC0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 22:49:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcuNt-0002bO-TX; Tue, 28 Jan 2025 17:48:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tcuNl-0002ZV-Hn
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 17:48:36 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tcuNj-000242-Tu
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 17:48:33 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id E81F85C587C;
 Tue, 28 Jan 2025 22:47:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBDA0C4CED3;
 Tue, 28 Jan 2025 22:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1738104506;
 bh=Wd9sPtMbjBGG+0n6k0ZX9sUhqpPZO1e8+ykDsOkyevk=;
 h=From:To:Cc:Subject:Date:From;
 b=l/3eKWAGaSkcPT2o4ZUZVq+OG9Z92X6ysEoFxTPPe7j02VHQ5k/ktJIvRYAn4spBP
 jsKkqwA/lP4/Fe6qij/FSm1D+LhcWB/OrUJrSeQ0l1iMDxgngO3bafDWzwfPx4ElXY
 2jM70Gwpjzdx8hQYI9VX04ZrAB3dSx9KlJCKM2wrP7XIbd9TDzilCZ3YX6JG8sLK30
 h86R37Kr267YZxSVHm873DO0OCy72x/vt5BhAo9/PVGIepY9JD7zCh3318trf4tTGA
 44bjHtdUPJ/6c1GSeQaoPQOVij1nzZUy+nbooYux4rvY2MhBLcr0L6P7hkhoJ+zbaW
 p1K/oMuiPgAZA==
From: deller@kernel.org
To: richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2] target/hppa: Implement CPU diagnose registers for 64-bit
 HP-UX
Date: Tue, 28 Jan 2025 23:45:40 +0100
Message-ID: <20250128224817.24715-1-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217; envelope-from=deller@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -83
X-Spam_score: -8.4
X-Spam_bar: --------
X-Spam_report: (-8.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This series of 4 patches incorporates the changes as suggested by
Richard regarding PATCH #3 from my previous series.
Please review.

Helge

