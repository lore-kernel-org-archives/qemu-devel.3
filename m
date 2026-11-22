Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A845606A320
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Nov 2026 16:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LGyQ1kxj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVABi-0001iR-BC; Sun, 22 Nov 2026 11:13:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xVABg-0001g8-Ag
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 11:13:08 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xVABe-0005ZA-Qu
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 11:13:08 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9100F60623;
 Sun, 22 Nov 2026 16:13:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5158A1F000C6;
 Sun, 22 Nov 2026 16:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795363983;
 bh=9JyKKunVX+HxXNwMDUZUs/QHrYJ4z2Gnfb4W2ifPo3A=;
 h=From:To:Cc:Subject:Date;
 b=LGyQ1kxjyQF3ZSS90i5orOYqtl42njLgPuT+1lN59httJV2V2RySVUuxN/8WHlxYz
 9cLsIMvv8BA2bKRX9VVvMCqoV+D5ZUjTRq7XiP9x8BNoLDrEi3LuNi3mxavdGd9FSn
 P+EigjTkdvw3kmHfhhqFPikn4is04dakxTQzOEYWQ/6GkaXCdYGqYWiQ2f2Ljkt21j
 jC9/UWiF2SxZxFu2NvGL0BQx2M82wjSPwuJEBeeF+pmFAUY5DtBswlSfsXoWpB1PO2
 6XMezuCPNv91BFYKp9JoJBE8OQLhbg3EasRIYsqT+r/5pb49hbJhDaqw3fBzf3uaiq
 NVnNorv+EsXRg==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 0/1] Linux user next patches
Date: Sun, 22 Nov 2026 17:12:59 +0100
Message-ID: <20261122161300.6165-1-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Helge Deller <deller@gmx.de>

The following changes since commit 8f66cb79044c370e3813c56ceb7a75a5ca2d0a0e:

  Merge tag 'pull-tcg-20261120' of https://gitlab.com/rth7680/qemu into staging (2026-11-20 14:52:05 -0800)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/linux-user-next-pull-request

for you to fetch changes up to 31b27c0b645e8c596e69027d714ce075f1374792:

  linux-user: do not emulate PI futexes given endianness mismatch (2026-11-22 16:57:52 +0100)

----------------------------------------------------------------
linux user

One PI futex patch from Barnabás Pőcze for linux-user.

----------------------------------------------------------------

Barnabás Pőcze (1):
  linux-user: do not emulate PI futexes given endianness mismatch

 linux-user/syscall.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

-- 
2.54.0


