Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42EBEC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 17:03:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ridd4-0000V3-Ue; Fri, 08 Mar 2024 12:03:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1ridcy-0000PE-10
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 12:03:24 -0500
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1ridcw-0000jF-1q
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 12:03:23 -0500
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1ridck-0006GV-VX; Fri, 08 Mar 2024 18:03:10 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: qemu-devel@nongnu.org
Subject: [PULL 0/3] Hyper-V Dynamic Memory and VMBus misc small patches
Date: Fri,  8 Mar 2024 18:02:42 +0100
Message-ID: <cover.1709916836.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

The following changes since commit 8f6330a807f2642dc2a3cdf33347aa28a4c00a87:

  Merge tag 'pull-maintainer-updates-060324-1' of https://gitlab.com/stsquad/qemu into staging (2024-03-06 16:56:20 +0000)

are available in the Git repository at:

  https://github.com/maciejsszmigiero/qemu.git tags/pull-hv-balloon-20240308

for you to fetch changes up to 6093637b4d32875f98cd59696ffc5f26884aa0b4:

  vmbus: Print a warning when enabled without the recommended set of features (2024-03-08 14:18:56 +0100)

----------------------------------------------------------------
Hyper-V Dynamic Memory and VMBus misc small patches

This pull request contains two small patches to hv-balloon:
the first one replacing alloca() usage with g_malloc0() + g_autofree
and the second one adding additional declaration of a protocol message
struct with an optional field explicitly defined to avoid a Coverity
warning.

Also included is a VMBus patch to print a warning when it is enabled
without the recommended set of Hyper-V features (enlightenments) since
some Windows versions crash at boot in this case.

----------------------------------------------------------------
Maciej S. Szmigiero (3):
      hv-balloon: avoid alloca() usage
      hv-balloon: define dm_hot_add_with_region to avoid Coverity warning
      vmbus: Print a warning when enabled without the recommended set of features

 hw/hyperv/hv-balloon.c           | 18 ++++++++----------
 hw/hyperv/hyperv.c               | 12 ++++++++++++
 hw/hyperv/vmbus.c                |  6 ++++++
 include/hw/hyperv/dynmem-proto.h |  9 ++++++++-
 include/hw/hyperv/hyperv.h       |  4 ++++
 target/i386/kvm/hyperv-stub.c    |  4 ++++
 target/i386/kvm/hyperv.c         |  5 +++++
 target/i386/kvm/hyperv.h         |  2 ++
 target/i386/kvm/kvm.c            |  7 +++++++
 9 files changed, 56 insertions(+), 11 deletions(-)

