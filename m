Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B340FC54FD4
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 20:59:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpBMu-0002dk-4m; Wed, 29 Jul 2026 16:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wpBMs-0002cd-65
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 16:59:10 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wpBMp-0003jT-Vv
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 16:59:09 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 85E096004E;
 Wed, 29 Jul 2026 20:59:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 238C11F000E9;
 Wed, 29 Jul 2026 20:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785358745;
 bh=CfgM8ffPWAoUfGTQDY6DB2doCh3f8Hr4YEQMQ3+Js5o=;
 h=From:To:Cc:Subject:Date;
 b=FEgacMWg091fbxY8yg69UcRJ2AyAl9QpZ0zNGAm+HT4Bk/eOdYzxg4z4cL6OX6m6+
 9FEAm3Z6q0XFRZkIRIsmMifhOPyCwdYvMbxNTQgmShanZgBqDjHdR8o4aBjxi0iFg0
 LmmqMQzi7xGG05XSd4lwX39GaaROk2in111OrobglXFWIhnjcc9JvkKhRjKUKR6ScD
 00U8AjQg1Sf6weTIQS6aL1zXa66pClkADVVyCBWfrhOmvnnpFhmKYuJwuJTTX4gHHq
 NhIIJCU15t2+woya5acvYD5N3dS7PLa/u0yBkZrF0wqgICaRYZadrZ/RMSOv7n62ed
 2YcM49iF4vccw==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@gmail.com>
Cc: Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 0/3] Linux user patches
Date: Wed, 29 Jul 2026 22:58:59 +0200
Message-ID: <20260729205902.3767-1-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

From: Helge Deller <deller@gmx.de>

The following changes since commit de5eb7c4dd3ef5688b14007134eb11ff4973580c:

  Merge tag 'hw-misc-20260728' of https://github.com/philmd/qemu into staging (2026-07-28 10:04:08 -0400)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/linux-user-pull-request

for you to fetch changes up to 8d0ac5933aa3476283c14680f165727268103fcd:

  linux-user/aarch64: Fix SHADOW_STACK_SET_TOKEN (2026-07-29 22:56:12 +0200)

----------------------------------------------------------------
linux-user patches

Three linux-user patches, one aarch64 shadow stack fix
and two fixes for members of the target_msqid_ds struct.

----------------------------------------------------------------

Helge Deller (1):
  linux-user: Fix msqid_ds struct wrt 32-bit big endian architectures

Richard Henderson (1):
  linux-user/aarch64: Fix SHADOW_STACK_SET_TOKEN

no92 (1):
  linux-user: fix incorrect msg_l[sr]pid members of target_msqid_ds

 linux-user/syscall.c | 45 ++++++++++++++++++++------------------------
 1 file changed, 20 insertions(+), 25 deletions(-)

-- 
2.54.0


