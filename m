Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43CFFD29FB1
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 07:42:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8aer-0000ms-3c; Wed, 06 Nov 2024 02:40:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aik@ozlabs.ru>)
 id 1t8Y6n-0007NK-CJ; Tue, 05 Nov 2024 23:57:33 -0500
Received: from ozlabs.ru ([107.172.7.69])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aik@ozlabs.ru>)
 id 1t8Y6j-0001jJ-RU; Tue, 05 Nov 2024 23:57:31 -0500
Received: from ole.2.ozlabs.ru (localhost.localdomain [127.0.0.1])
 by ozlabs.ru (Postfix) with ESMTP id 2FB01804B5;
 Tue,  5 Nov 2024 23:57:22 -0500 (EST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Subject: [PULL SUBSYSTEM qemu-pseries] pseries: Update SLOF firmware image
Date: Wed,  6 Nov 2024 15:57:19 +1100
Message-ID: <20241106045720.599720-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=107.172.7.69; envelope-from=aik@ozlabs.ru;
 helo=ozlabs.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 06 Nov 2024 02:40:47 -0500
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

The following changes since commit bd4be4d9bd20a252e677239a18b6409ecee98f56:

  MAINTAINERS: Remove myself as reviewer (2024-11-04 10:09:36 +1000)

are available in the Git repository at:

  git@github.com:aik/qemu.git tags/qemu-slof-20241106

for you to fetch changes up to 3866b650d567f79e78d6bd35cb9b7143258da052:

  pseries: Update SLOF firmware image (2024-11-06 15:40:53 +1100)

----------------------------------------------------------------
Alexey Kardashevskiy (1):
      pseries: Update SLOF firmware image

 pc-bios/README   |   4 ++--
 pc-bios/slof.bin | Bin 995000 -> 996184 bytes
 roms/SLOF        |   2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)


*** Note: this is not for master, this is for pseries

This adds TPM pass through API.
Also, moves SLOF from github to gitlab: the idea is to make SLOF
a proper QEMU subproject but I am not quite sure what this means.

Do I push changes to https://gitlab.com/qemu-project/SLOF.git [1] ?
Or I push to https://gitlab.com/slof/slof [2] and someone then
configures that sync script to pull [2] and push to [1]?
Or something else entirely? Thanks,


