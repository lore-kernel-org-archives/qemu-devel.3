Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B788DC0219D
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 09:58:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgL83-0003eJ-Gi; Fri, 07 Feb 2025 04:58:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <52065d405ae96221f15b0fd9c099437c77178d4f@kylie.crudebyte.com>)
 id 1tgL80-0003V9-OB
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 04:58:28 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <52065d405ae96221f15b0fd9c099437c77178d4f@kylie.crudebyte.com>)
 id 1tgL7y-0001II-J4
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 04:58:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:Message-Id:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=gBGlcJmAuTBg14PDDEeWQgZ5n9nhunsbbPA4W8x+gVk=; b=vlieb
 5iRiu//unDCjklWVJ5RkfRKinyoilXc8CR7odwLQLtNT6EeMmbITUYpKDDqmPHQCUHWlyIfZvOI56
 Fo1Om6nS1de+FX48tUAdp+EMxvjUeIkFOzxro/sJMk18veJ4UJRY21GpIwvjtt/FXYWJmGYY3eM9x
 0AU1PlccUTmFbE+dCLLjACG5rqWTqgbeUYKoqUp6A8FmZfgL/cWgqGjtJ9+kNcI18HqgCh9w+asQC
 vWcWTCyaMi/NfP5jU17e778E+FtT7c82DCy/URRw2uJz28fEMX65bfA6QB54mMuz3SIYyF8DsQrLX
 fgDiLi9j5bLBCjXzuh06dI6s8DwTPGK2Y5wDwJLDg5DalX1AwvFwzJFA/2MxGzVLGTAc/OzcrevUK
 GIBc0/mqo4H5R6imaJsD7jVscgWj0fEWL3Or8k0KrGWlZM+ZBEls0D/nWGvWgriv1Kyy12Dicbrg9
 HLQv810+rbKUqiDuUoQ6DRzBET1D9GHJ8MCFFCt+vqaa+YFib4Cowd+ppmtU0lxL9CMe6ZoRwHrd0
 bXNPZu2I4C2FnL4RYiAMwPhUw1MnlIw43ugpxX5tsprvOduLzuDlmz/BUvKwblJxteL8I4uOeoO+4
 XUG/0lMDBI+0kmqWDDNBDP30jOZPhBLG9JMTjA0zMe55o7IwYx5h9Ix/VoAADk=;
Message-Id: <cover.1738921999.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Fri, 07 Feb 2025 10:53:19 +0100
Subject: [PULL v2 0/4] 9p queue 2025-02-06
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>,
    Stefan Hajnoczi <stefanha@redhat.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=52065d405ae96221f15b0fd9c099437c77178d4f@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit d922088eb4ba6bc31a99f17b32cf75e59dd306cd:

  Merge tag 'ui-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2025-02-03 13:42:02 -0500)

are available in the Git repository at:

  https://github.com/cschoenebeck/qemu.git tags/pull-9p-20250207

for you to fetch changes up to 52065d405ae96221f15b0fd9c099437c77178d4f:

  MAINTAINERS: Mark me as reviewer only for 9pfs (2025-02-07 10:28:27 +0100)

----------------------------------------------------------------
9pfs changes:

* Greg Kurz steps back as maintainer of 9pfs.

* Make multidevs=remap default option (instead of multidevs=warn)
  and update documentation related to this option.

* Improve tracing (i.e. usefulness of log output content).

----------------------------------------------------------------
Christian Schoenebeck (3):
      9pfs: improve v9fs_walk() tracing
      9pfs: make multidevs=remap default
      9pfs: improve v9fs_open() tracing

Greg Kurz (1):
      MAINTAINERS: Mark me as reviewer only for 9pfs

 MAINTAINERS               |  3 +--
 hw/9pfs/9p-local.c        |  3 +++
 hw/9pfs/9p-util-generic.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++
 hw/9pfs/9p-util.h         |  6 ++++++
 hw/9pfs/9p.c              | 45 ++++++++++++++++++++++++++++++++++++------
 hw/9pfs/meson.build       |  1 +
 hw/9pfs/trace-events      |  4 ++--
 qemu-options.hx           | 49 +++++++++++++++++++++++++---------------------
 8 files changed, 129 insertions(+), 32 deletions(-)
 create mode 100644 hw/9pfs/9p-util-generic.c

