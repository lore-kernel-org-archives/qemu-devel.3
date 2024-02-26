Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7779FC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 10:53:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reYZD-0002kn-Kc; Mon, 26 Feb 2024 05:50:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1reYYg-0002bg-Th
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 05:50:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1reYYa-0003jF-Fj
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 05:50:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708944599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wjrEUFhDf6rCyDM7vVCEGZDQ6Q/pZSu4wvm6SodbO1U=;
 b=E6TsdRnNW4Qz/IcMm1BUtB6aTC1c1pSsNk5byZPFj5s7SHwstvJa0c6+UBIS0juiAlugFx
 NsiBP2TLz/tnqd9y1psObCy1sZsZf4oSu/ux1ZSK5dyYIG7Gh2i4v8ZW8Ul9ye6z97D5PC
 bcghYmD9+gLQO2m8UoB77fRH5mmdDr0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-BV-nghUuO4utVp1fHn4h3w-1; Mon, 26 Feb 2024 05:49:56 -0500
X-MC-Unique: BV-nghUuO4utVp1fHn4h3w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C55B188208A;
 Mon, 26 Feb 2024 10:49:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7FC624024857;
 Mon, 26 Feb 2024 10:49:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 850EB21E66F4; Mon, 26 Feb 2024 11:49:54 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL 00/17] QAPI patches patches for 2024-02-26
Date: Mon, 26 Feb 2024 11:49:37 +0100
Message-ID: <20240226104954.3781985-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

The following changes since commit dd88d696ccecc0f3018568f8e281d3d526041e6f:

  Merge tag 'pull-request-2024-02-23' of https://gitlab.com/thuth/qemu into staging (2024-02-24 16:12:51 +0000)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2024-02-26

for you to fetch changes up to adb0193b90bd1fecd7d6dda70fc1c2d2e45ceae0:

  qapi: Divorce QAPIDoc from QAPIParseError (2024-02-26 10:43:56 +0100)

----------------------------------------------------------------
QAPI patches patches for 2024-02-26

----------------------------------------------------------------
Het Gala (1):
      qapi: Misc cleanups to migrate QAPIs

Markus Armbruster (16):
      tests/qapi-schema: Fix test 'QAPI rST doc'
      tests/qapi-schema: Cover duplicate 'Features:' line
      tests/qapi-schema: Cover 'Features:' not followed by descriptions
      sphinx/qapidoc: Drop code to generate doc for simple union branch
      qapi: Improve error position for bogus argument descriptions
      qapi: Improve error position for bogus invalid "Returns" section
      qapi: Improve error message for empty doc sections
      qapi: Rename QAPIDoc.Section.name to .tag
      qapi: Reject section heading in the middle of a doc comment
      qapi: Require descriptions and tagged sections to be indented
      qapi: Recognize section tags and 'Features:' only after blank line
      qapi: Call QAPIDoc.check() always
      qapi: Merge adjacent untagged sections
      qapi: Rewrite doc comment parser
      qapi: Reject multiple and empty feature descriptions
      qapi: Divorce QAPIDoc from QAPIParseError

 docs/devel/qapi-code-gen.rst                    |  30 +-
 docs/sphinx/qapidoc.py                          |  28 +-
 qapi/acpi.json                                  |  20 +-
 qapi/block-core.json                            | 868 ++++++++++++------------
 qapi/block.json                                 | 274 ++++----
 qapi/char.json                                  | 172 ++---
 qapi/control.json                               |  54 +-
 qapi/dump.json                                  |  26 +-
 qapi/machine-target.json                        |   6 +-
 qapi/machine.json                               | 302 ++++-----
 qapi/migration.json                             | 695 +++++++++----------
 qapi/misc-target.json                           | 110 +--
 qapi/misc.json                                  | 172 ++---
 qapi/net.json                                   | 118 ++--
 qapi/pci.json                                   | 252 +++----
 qapi/qdev.json                                  |  38 +-
 qapi/qom.json                                   |  54 +-
 qapi/rdma.json                                  |  14 +-
 qapi/replay.json                                |  16 +-
 qapi/rocker.json                                |  66 +-
 qapi/run-state.json                             |  86 ++-
 qapi/tpm.json                                   |  36 +-
 qapi/trace.json                                 |  12 +-
 qapi/transaction.json                           |  36 +-
 qapi/ui.json                                    | 324 ++++-----
 qapi/virtio.json                                | 778 ++++++++++-----------
 qapi/yank.json                                  |  24 +-
 scripts/qapi/parser.py                          | 517 +++++++-------
 scripts/qapi/schema.py                          |   7 +-
 tests/qapi-schema/doc-bad-alternate-member.err  |   2 +-
 tests/qapi-schema/doc-bad-boxed-command-arg.err |   2 +-
 tests/qapi-schema/doc-bad-command-arg.err       |   2 +-
 tests/qapi-schema/doc-bad-enum-member.err       |   2 +-
 tests/qapi-schema/doc-bad-event-arg.err         |   2 +-
 tests/qapi-schema/doc-bad-feature.err           |   2 +-
 tests/qapi-schema/doc-bad-union-member.err      |   2 +-
 tests/qapi-schema/doc-duplicate-features.err    |   1 +
 tests/qapi-schema/doc-duplicate-features.json   |  11 +
 tests/qapi-schema/doc-duplicate-features.out    |   0
 tests/qapi-schema/doc-duplicated-arg.err        |   2 +-
 tests/qapi-schema/doc-duplicated-return.err     |   2 +-
 tests/qapi-schema/doc-duplicated-return.json    |   1 +
 tests/qapi-schema/doc-duplicated-since.err      |   2 +-
 tests/qapi-schema/doc-duplicated-since.json     |   1 +
 tests/qapi-schema/doc-empty-arg.err             |   2 +-
 tests/qapi-schema/doc-empty-features.err        |   1 +
 tests/qapi-schema/doc-empty-features.json       |  10 +
 tests/qapi-schema/doc-empty-features.out        |   0
 tests/qapi-schema/doc-empty-section.err         |   2 +-
 tests/qapi-schema/doc-good.json                 |  25 +-
 tests/qapi-schema/doc-good.txt                  |  21 +-
 tests/qapi-schema/doc-invalid-return.err        |   2 +-
 tests/qapi-schema/doc-invalid-return.json       |   1 +
 tests/qapi-schema/doc-non-first-section.err     |   1 +
 tests/qapi-schema/doc-non-first-section.json    |   6 +
 tests/qapi-schema/doc-non-first-section.out     |   0
 tests/qapi-schema/meson.build                   |  12 +-
 tests/qapi-schema/test-qapi.py                  |   2 +-
 58 files changed, 2624 insertions(+), 2630 deletions(-)
 create mode 100644 tests/qapi-schema/doc-duplicate-features.err
 create mode 100644 tests/qapi-schema/doc-duplicate-features.json
 create mode 100644 tests/qapi-schema/doc-duplicate-features.out
 create mode 100644 tests/qapi-schema/doc-empty-features.err
 create mode 100644 tests/qapi-schema/doc-empty-features.json
 create mode 100644 tests/qapi-schema/doc-empty-features.out
 create mode 100644 tests/qapi-schema/doc-non-first-section.err
 create mode 100644 tests/qapi-schema/doc-non-first-section.json
 create mode 100644 tests/qapi-schema/doc-non-first-section.out

-- 
2.43.0


