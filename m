Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9217C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 08:00:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sasd6-0000VL-4O; Mon, 05 Aug 2024 03:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sasd4-0000Q4-8a
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 03:59:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sasd2-0005RJ-7N
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 03:59:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722844779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jUAhjzTEuAUsuEOYL4wwlFdg2ijyAuFR3R4fvEiyVZg=;
 b=R9eooA0ySWpU0Z2hWoa6fFe5SpSe9RrUEio4hUxaMQ0sm55QPOdHBwPt+kr94KddTjK3JO
 /AXQP8hhjhqac+UZwOyoczSWnJp2sM0JdHlrIE42gRAylFyg6fi52D2nOdcbRP6O7GFxlc
 mIk6Fq2D7Mgy/cquZl3TH2Y/xc0f1sw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-yrQUXjtPPN6AdMcfOioeiQ-1; Mon,
 05 Aug 2024 03:59:34 -0400
X-MC-Unique: yrQUXjtPPN6AdMcfOioeiQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A3D0119560AA; Mon,  5 Aug 2024 07:59:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CF968195605F; Mon,  5 Aug 2024 07:59:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A6D1F21E5A6D; Mon,  5 Aug 2024 09:59:25 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PULL 0/2] QAPI patches patches for 2024-08-05
Date: Mon,  5 Aug 2024 09:59:23 +0200
Message-ID: <20240805075925.2062973-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit f9851d2ffef59b3a7f39513469263ab3b019480f:

  Merge tag 'migration-20240802-pull-request' of https://gitlab.com/farosas/qemu into staging (2024-08-03 07:26:26 +1000)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2024-08-05

for you to fetch changes up to ef71d8209f5786c4e68b5ac7dbc0da7a43f0ed4e:

  qmp: Fix higher half vaddrs for [p]memsave (2024-08-05 09:34:34 +0200)

----------------------------------------------------------------
QAPI patches patches for 2024-08-05

----------------------------------------------------------------
Josh Junon (1):
      qmp: Fix higher half vaddrs for [p]memsave

Markus Armbruster (1):
      qapi: Refill doc comments to conform to conventions

 qapi/block-core.json     | 71 ++++++++++++++++++++++++------------------------
 qapi/block-export.json   |  8 +++---
 qapi/block.json          | 12 ++++----
 qapi/char.json           |  8 +++---
 qapi/control.json        | 14 +++++-----
 qapi/crypto.json         |  8 +++---
 qapi/cxl.json            | 42 ++++++++++++++--------------
 qapi/dump.json           |  2 +-
 qapi/ebpf.json           |  2 +-
 qapi/introspect.json     |  4 +--
 qapi/job.json            |  8 +++---
 qapi/machine-target.json | 54 ++++++++++++++++++------------------
 qapi/machine.json        | 33 +++++++++++++---------
 qapi/migration.json      | 68 +++++++++++++++++++++++-----------------------
 qapi/misc.json           | 31 +++++++++++----------
 qapi/net.json            | 27 +++++++++++-------
 qapi/pci.json            |  1 -
 qapi/qdev.json           | 20 +++++++-------
 qapi/qom.json            | 38 +++++++++++++-------------
 qapi/rocker.json         |  4 +--
 qapi/run-state.json      | 12 ++++----
 qapi/sockets.json        |  5 ++--
 qapi/stats.json          |  6 ++--
 qapi/transaction.json    |  4 +--
 qapi/ui.json             | 27 +++++++++---------
 qapi/vfio.json           |  8 +++---
 qapi/virtio.json         |  6 ++--
 system/cpus.c            | 12 ++++----
 28 files changed, 277 insertions(+), 258 deletions(-)

-- 
2.45.0


