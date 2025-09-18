Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4275CCA1013
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 20:22:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzL7q-0006ox-0B; Thu, 18 Sep 2025 16:21:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <c921e5496f23221335bea0c9104364409cd0b2b8@kylie.crudebyte.com>)
 id 1uzL7o-0006op-Td
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 16:21:04 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <c921e5496f23221335bea0c9104364409cd0b2b8@kylie.crudebyte.com>)
 id 1uzL7k-0002xt-1e
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 16:21:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:Message-Id:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=ck4hG/kDCub4E//5D/7hjvSxgmRVy4Ylvdj3AsA251g=; b=K5W5w
 igcgOXX2Xu6HfessMdLbqK4QhMkPQ4i9QvAmf3QOqSBjscDVUeZxfR12icVZDbsgnTwmX6KpMS3zE
 uLXl27K1omT8WtMNnJJCgmHaCBu1ICFDRDXa2lICeRQ3dBvT4lb+Vfkq3KeodFL5Sx5rpSJnnwLpC
 z46mxVGAofAW/KXdiysn/MJUFglt96DpSPWnwFhyLtfrqhJSY2aGfrhCnV6tEole4mD7LLGOI138R
 3c/hXqM5GB7KGTRd9EVOYRA/9jjOSTG34lZJs/R0X0F8cu71CEUzMSf7nKzEyI6XgEXBB5LpKvrAW
 jzMyzKSuMLlIDA64yAuELRL0BnBwG0b1oJR5y/k/Gd+Z4YfnswJErICmkmiecwjq1lLmccnHeahUv
 S35KQYVlQO8MSuN/8BDHg05R6oUtxyf/TN/D4alIcqUYjV0M9umXNKfYZ+57yBWRH5XRIupo4smny
 k8ZqqVw2DgAnk5Nw3aL40U4ZqvXqL42phRRcIjbTbqnJ+xzqn322QyzkqyqEdSx9qvzAKh0wGFrbS
 x5Cpjs5J0OdQMj5wun5K4MiUtMdZ+u0rwmuv6wjt8h8x1n9wYbkk1VjJB03sIlgyu5f8b1xWDoCtp
 jbIUtIVH+SUdkba6khJs69/ZgSgO8fvakNCaM0gRr4dS+fCJeZ58+WvUmBkmjg=;
Message-Id: <cover.1758224558.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Thu, 18 Sep 2025 21:42:39 +0200
Subject: [PULL 0/2] 9p queue 2025-09-18
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Mark Johnston <markj@freebsd.org>,
 Peter Foley <pefoley@google.com>,
 Richard Henderson <richard.henderson@linaro.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=c921e5496f23221335bea0c9104364409cd0b2b8@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The following changes since commit e7c1e8043a69c5a8efa39d4f9d111f7c72c076e6:

  Merge tag 'pull-loongarch-20250918' of https://github.com/gaosong715/qemu into staging (2025-09-18 07:08:08 -0700)

are available in the Git repository at:

  https://github.com/cschoenebeck/qemu.git tags/pull-9p-20250918

for you to fetch changes up to c921e5496f23221335bea0c9104364409cd0b2b8:

  9pfs: Stop including gstrfuncs.h (2025-09-18 21:21:29 +0200)

----------------------------------------------------------------
9pfs changes:

* Add FreeBSD host support.

* Fix glib header inclusion.

----------------------------------------------------------------
Mark Johnston (1):
      9pfs: Add FreeBSD support

Peter Foley (1):
      9pfs: Stop including gstrfuncs.h

 fsdev/file-op-9p.h        |   6 ++-
 fsdev/meson.build         |   2 +-
 hw/9pfs/9p-synth.c        |   2 +-
 hw/9pfs/9p-util-freebsd.c | 132 ++++++++++++++++++++++++++++++++++++++++++++++
 hw/9pfs/9p-util-generic.c |   1 -
 hw/9pfs/9p-util.h         |  20 +++++--
 hw/9pfs/9p.c              |  16 +++++-
 hw/9pfs/meson.build       |   2 +
 include/qemu/xattr.h      |   6 ++-
 meson.build               |   8 +--
 10 files changed, 179 insertions(+), 16 deletions(-)
 create mode 100644 hw/9pfs/9p-util-freebsd.c

