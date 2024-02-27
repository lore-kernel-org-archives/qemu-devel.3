Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C54B7C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 11:41:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1revo7-0008W6-4n; Tue, 27 Feb 2024 06:39:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1revo4-0008Uf-8w
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 06:39:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1revnz-0005US-Oz
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 06:39:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709033966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3pc6iL/NU9ik0JEEUu5tQVI2wnz2A88+8hGJ7eimrOU=;
 b=imPF2GP/aaenRki/qfNRKoWsj+fLj5eGx+SCj86aw9DTYJuiAhLG9lzO3sUjYIvBMqG34x
 ATKJBNce12wrmhPd4KAoU5DrxC3a67oTS5vB0zcYHdoB9gwHMYjycBp8NarxA0tyC/80BI
 Obfi6U7u4GU3ZLfZequdqPbkjvns5sg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-ujZ69QMPOoiGqDI7XWforQ-1; Tue, 27 Feb 2024 06:39:22 -0500
X-MC-Unique: ujZ69QMPOoiGqDI7XWforQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 685B888B763;
 Tue, 27 Feb 2024 11:39:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 44F0620227BF;
 Tue, 27 Feb 2024 11:39:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2814F21E66F4; Tue, 27 Feb 2024 12:39:21 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com, jsnow@redhat.com, eblake@redhat.com,
 kkostiuk@redhat.com
Subject: [PATCH 00/13] Subject: [PATCH 00/15] qapi: Improve command response
 documentation
Date: Tue, 27 Feb 2024 12:39:08 +0100
Message-ID: <20240227113921.236097-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
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

We use doc comment "Returns" sections both for success and error
response.  This series moves the latter to new "Errors" sections.
Enables some cleanup, visible in the diffstat.q

Markus Armbruster (13):
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

 docs/devel/qapi-code-gen.rst               |  6 +-
 qapi/block-core.json                       | 74 ++++++++--------------
 qapi/block-export.json                     | 23 ++++---
 qapi/block.json                            | 10 ++-
 qapi/char.json                             |  6 --
 qapi/dump.json                             |  2 -
 qapi/machine-target.json                   | 37 ++++++-----
 qapi/machine.json                          | 19 ++----
 qapi/migration.json                        | 26 --------
 qapi/misc-target.json                      |  3 -
 qapi/misc.json                             | 25 +++-----
 qapi/net.json                              | 17 +++--
 qapi/qdev.json                             |  3 +-
 qapi/qom.json                              |  6 +-
 qapi/run-state.json                        |  5 +-
 qapi/tpm.json                              |  2 -
 qapi/transaction.json                      |  5 +-
 qapi/ui.json                               | 17 +----
 qapi/yank.json                             |  5 +-
 qga/qapi-schema.json                       | 72 +++++++++------------
 scripts/qapi/parser.py                     | 50 ++++++++++-----
 tests/qapi-schema/doc-good.json            |  2 +
 tests/qapi-schema/doc-good.out             |  2 +
 tests/qapi-schema/doc-good.txt             |  6 ++
 tests/qapi-schema/doc-invalid-return.err   |  2 +-
 tests/qapi-schema/doc-invalid-return2.err  |  1 +
 tests/qapi-schema/doc-invalid-return2.json |  7 ++
 tests/qapi-schema/doc-invalid-return2.out  |  0
 tests/qapi-schema/meson.build              |  1 +
 29 files changed, 189 insertions(+), 245 deletions(-)
 create mode 100644 tests/qapi-schema/doc-invalid-return2.err
 create mode 100644 tests/qapi-schema/doc-invalid-return2.json
 create mode 100644 tests/qapi-schema/doc-invalid-return2.out

-- 
2.43.0


