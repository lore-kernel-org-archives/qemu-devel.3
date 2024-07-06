Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC08C41513
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2024 07:25:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPzma-0006ve-Tr; Sat, 06 Jul 2024 03:24:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sPzmZ-0006vM-PA
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 03:24:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sPzmV-0004eW-Q8
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 03:24:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720250665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mbrfMrKhRviUS8L/OBez6OrjkZWDd8rk1lrw+ZkRprI=;
 b=SY/sf9NTTH5lzhd7t6Ea24q3M9sQeJiHzoHz2r86zo1jKkux2zJ84hrezbNyiPNzW5SMuM
 ULokUVJPm0BX56eVUhmHTYDCm92alDUri9YI2iunsUezBnfmzQxiMaHCERqfOZWS7V7x1w
 s3fsEPigx4j5N5pIGef+1N9+98DRKSo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-uaq87RtzPhSLC084OgGmYA-1; Sat,
 06 Jul 2024 03:24:20 -0400
X-MC-Unique: uaq87RtzPhSLC084OgGmYA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EE6E0195609E; Sat,  6 Jul 2024 07:24:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.4])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C5F031955E85; Sat,  6 Jul 2024 07:24:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8724421E668B; Sat,  6 Jul 2024 09:24:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PULL 00/13] QAPI patches patches for 2024-07-06
Date: Sat,  6 Jul 2024 09:24:03 +0200
Message-ID: <20240706072416.1717485-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit f2cb4026fccfe073f84a4b440e41d3ed0c3134f6:

  Merge tag 'pull-maintainer-july24-050724-1' of https://gitlab.com/stsquad/qemu into staging (2024-07-05 09:15:48 -0700)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2024-07-06

for you to fetch changes up to e389929d19a543ea5b34d02553b355f9f1c03162:

  sphinx/qapidoc: Fix to generate doc for explicit, unboxed arguments (2024-07-06 08:58:24 +0200)

----------------------------------------------------------------
QAPI patches patches for 2024-07-06

----------------------------------------------------------------
John Snow (12):
      qapi: linter fixups
      docs/qapidoc: remove unused intersperse function
      docs/qapidoc: delint a tiny portion of the module
      qapi/parser: preserve indentation in QAPIDoc sections
      qapi/parser: fix comment parsing immediately following a doc block
      docs/qapidoc: fix nested parsing under untagged sections
      qapi: fix non-compliant JSON examples
      qapi: nail down convention that Errors sections are lists
      qapi: convert "Note" sections to plain rST
      qapi: update prose in note blocks
      qapi: add markup to note blocks
      qapi/parser: don't parse rST markup as section headers

Markus Armbruster (1):
      sphinx/qapidoc: Fix to generate doc for explicit, unboxed arguments

 docs/devel/qapi-code-gen.rst                   |  14 ++-
 docs/sphinx/qapidoc.py                         | 115 +++++++++++++++----------
 qapi/block-core.json                           |  35 +++-----
 qapi/block.json                                |   2 +-
 qapi/char.json                                 |  12 +--
 qapi/control.json                              |  20 ++---
 qapi/dump.json                                 |   2 +-
 qapi/introspect.json                           |   6 +-
 qapi/machine-target.json                       |  26 +++---
 qapi/machine.json                              |  49 +++++------
 qapi/migration.json                            |  16 ++--
 qapi/misc.json                                 |  91 ++++++++++---------
 qapi/net.json                                  |  12 +--
 qapi/pci.json                                  |   8 +-
 qapi/qdev.json                                 |  30 +++----
 qapi/qom.json                                  |  17 ++--
 qapi/rocker.json                               |  18 ++--
 qapi/run-state.json                            |  18 ++--
 qapi/sockets.json                              |  10 +--
 qapi/stats.json                                |  22 ++---
 qapi/transaction.json                          |  10 +--
 qapi/ui.json                                   |  31 ++++---
 qapi/virtio.json                               |  12 +--
 qga/qapi-schema.json                           |  48 +++++------
 scripts/qapi/introspect.py                     |   8 +-
 scripts/qapi/parser.py                         |  30 +++++--
 scripts/qapi/schema.py                         |   6 +-
 scripts/qapi/visit.py                          |   5 +-
 tests/qapi-schema/doc-empty-section.err        |   2 +-
 tests/qapi-schema/doc-empty-section.json       |   2 +-
 tests/qapi-schema/doc-good.json                |   9 +-
 tests/qapi-schema/doc-good.out                 |  43 +++++----
 tests/qapi-schema/doc-good.txt                 |  13 ++-
 tests/qapi-schema/doc-interleaved-section.json |   2 +-
 34 files changed, 397 insertions(+), 347 deletions(-)

-- 
2.45.0


