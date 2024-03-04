Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F58BC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 06:37:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh1t6-0005fb-90; Mon, 04 Mar 2024 01:33:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rh1sY-0005YN-Ce
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 01:32:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rh1sR-000098-4H
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 01:32:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709533962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rFZd5IV1WDNKgdBt9qHdcSx83Jp1mXqoEbBsIONztp8=;
 b=f2Vtapx/WAvpzTbUg6IRx2BiILy/Ig7if4OS+ncWuZiqSWAMFDnuJAKmjzXb0DydxJoYg9
 gW4Xzu9oMHHM0o8Dt4EruowaMeOAnpoebU1e4BxaO8Tg1tEXfMD+Hk4hQgJaeMtfGGKQCQ
 ESn4rPMhrbc+p/cVpyPyFQWVudRe4eU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-3ANZYiJRPzeJLlKQ2xjXpA-1; Mon, 04 Mar 2024 01:32:38 -0500
X-MC-Unique: 3ANZYiJRPzeJLlKQ2xjXpA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D9FF01064F8C;
 Mon,  4 Mar 2024 06:32:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 944E8C04324;
 Mon,  4 Mar 2024 06:32:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6C1F121E6A24; Mon,  4 Mar 2024 07:32:36 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL 00/18] QAPI patches patches for 2024-03-04
Date: Mon,  4 Mar 2024 07:32:18 +0100
Message-ID: <20240304063236.213955-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The following changes since commit e1007b6bab5cf97705bf4f2aaec1f607787355b8:

  Merge tag 'pull-request-2024-03-01' of https://gitlab.com/thuth/qemu into staging (2024-03-01 10:14:32 +0000)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2024-03-04

for you to fetch changes up to 018d5fb1f91c7f316b4b8501a78e7219bb9fb614:

  migration: simplify exec migration functions (2024-03-04 07:12:40 +0100)

----------------------------------------------------------------
QAPI patches patches for 2024-03-04

----------------------------------------------------------------
Markus Armbruster (15):
      qapi: Memorize since & returns sections
      qapi: Slightly clearer error message for invalid "Returns" section
      qapi: New documentation section tag "Errors"
      qapi: Move error documentation to new "Errors" sections
      qapi: Delete useless "Returns" sections
      qapi: Clean up "Returns" sections
      qapi/yank: Tweak @yank's error description for consistency
      qga/qapi-schema: Move error documentation to new "Errors" sections
      qga/qapi-schema: Delete useless "Returns" sections
      qga/qapi-schema: Clean up "Returns" sections
      qga/qapi-schema: Tweak documentation of fsfreeze commands
      qga/qapi-schema: Fix guest-set-memory-blocks documentation
      qapi: Reject "Returns" section when command doesn't return anything
      docs/devel/writing-monitor-commands: Repair a decade of rot
      docs/devel/writing-monitor-commands: Minor improvements

Steve Sistare (3):
      qapi: New QAPI_LIST_LENGTH()
      qapi: New strv_from_str_list()
      migration: simplify exec migration functions

 docs/devel/qapi-code-gen.rst               |   6 +-
 docs/devel/writing-monitor-commands.rst    | 496 ++++++++++++-----------------
 qapi/block-core.json                       |  74 ++---
 qapi/block-export.json                     |  23 +-
 qapi/block.json                            |  10 +-
 qapi/char.json                             |   6 -
 qapi/dump.json                             |   2 -
 qapi/machine-target.json                   |  37 ++-
 qapi/machine.json                          |  19 +-
 qapi/migration.json                        |  26 --
 qapi/misc-target.json                      |   3 -
 qapi/misc.json                             |  25 +-
 qapi/net.json                              |  17 +-
 qapi/qdev.json                             |   3 +-
 qapi/qom.json                              |   6 +-
 qapi/run-state.json                        |   5 +-
 qapi/tpm.json                              |   2 -
 qapi/transaction.json                      |   5 +-
 qapi/ui.json                               |  17 +-
 qapi/yank.json                             |   5 +-
 qga/qapi-schema.json                       |  72 ++---
 include/qapi/type-helpers.h                |   8 +
 include/qapi/util.h                        |  13 +
 migration/exec.c                           |  57 +---
 qapi/qapi-type-helpers.c                   |  14 +
 scripts/qapi/parser.py                     |  50 ++-
 tests/qapi-schema/doc-good.json            |   2 +
 tests/qapi-schema/doc-good.out             |   2 +
 tests/qapi-schema/doc-good.txt             |   6 +
 tests/qapi-schema/doc-invalid-return.err   |   2 +-
 tests/qapi-schema/doc-invalid-return2.err  |   1 +
 tests/qapi-schema/doc-invalid-return2.json |   7 +
 tests/qapi-schema/doc-invalid-return2.out  |   0
 tests/qapi-schema/meson.build              |   1 +
 34 files changed, 430 insertions(+), 592 deletions(-)
 create mode 100644 tests/qapi-schema/doc-invalid-return2.err
 create mode 100644 tests/qapi-schema/doc-invalid-return2.json
 create mode 100644 tests/qapi-schema/doc-invalid-return2.out

-- 
2.44.0


