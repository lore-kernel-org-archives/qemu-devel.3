Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64937C4829B
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 09:15:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZSOt-0006Pq-Uz; Mon, 12 Feb 2024 04:14:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rZSOi-0006Ji-8x
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 04:14:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rZSOf-0003cD-Ip
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 04:14:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707729280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=aVt/HPs2uFpTTOJCn2O1oQgl76gBtn4fbGUenMfZPms=;
 b=elApjmysF7RE9zAtOV/ppz//QUhfGxgVxyS4rYnQ0Wyrb7n+vp+m0vWdOw5dcvPyGhq1vf
 LtCiB1eUKXR5Ikjcg1stgW8H0wjg0fBTNpVb1I31D6JAx/O1ipTkOcWQ6KTdma7G89GN+k
 JKbFHQgwurWJGVxxerogTAa1+xXcxhA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-349-zdxcq2BTORyqu7c1OxrS5w-1; Mon,
 12 Feb 2024 04:14:38 -0500
X-MC-Unique: zdxcq2BTORyqu7c1OxrS5w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BBAFE3C0FC81;
 Mon, 12 Feb 2024 09:14:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 98BABC4C9FB;
 Mon, 12 Feb 2024 09:14:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 77FDD21E66D5; Mon, 12 Feb 2024 10:14:36 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL 00/18] QAPI patches patches for 2024-02-12
Date: Mon, 12 Feb 2024 10:14:18 +0100
Message-ID: <20240212091436.688598-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.677,
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

The following changes since commit 5d1fc614413b10dd94858b07a1b2e26b1aa0296c:

  Merge tag 'migration-staging-pull-request' of https://gitlab.com/peterx/qemu into staging (2024-02-09 11:22:20 +0000)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2024-02-12

for you to fetch changes up to 0afbba6c3255dbe954ef609987b610cdaaf48f24:

  MAINTAINERS: Cover qapi/stats.json (2024-02-12 10:12:18 +0100)

----------------------------------------------------------------
QAPI patches patches for 2024-02-12

----------------------------------------------------------------
Markus Armbruster (17):
      docs/devel/qapi-code-gen: Normalize version refs x.y.0 to just x.y
      docs/devel/qapi-code-gen: Tweak doc comment whitespace
      qapi/block-core: Fix BlockLatencyHistogramInfo doc markup
      qapi: Indent tagged doc comment sections properly
      sphinx/qapidoc: Drop code to generate doc for simple union tag
      qapi: Require member documentation (with loophole)
      qga/qapi-schema: Clean up documentation of guest-set-memory-blocks
      qga/qapi-schema: Clean up documentation of guest-set-vcpus
      qga/qapi-schema: Plug trivial documentation holes
      qapi/yank: Clean up documentaion of yank
      qapi/dump: Clean up documentation of DumpGuestMemoryCapability
      qapi: Plug trivial documentation holes around former simple unions
      qapi: Improve documentation of file descriptor socket addresses
      qapi: Move @String out of common.json to discourage reuse
      qapi: Add missing union tag documentation
      MAINTAINERS: Cover qapi/cxl.json
      MAINTAINERS: Cover qapi/stats.json

Peter Xu (1):
      qapi/migration: Add missing tls-authz documentation

 MAINTAINERS                                     |  2 +
 docs/devel/qapi-code-gen.rst                    | 14 ++++--
 docs/sphinx/qapidoc.py                          |  6 ---
 qapi/block-core.json                            | 26 ++++++++--
 qapi/block-export.json                          |  2 +
 qapi/char.json                                  | 28 +++++++++++
 qapi/common.json                                | 11 -----
 qapi/crypto.json                                |  2 +
 qapi/dump.json                                  |  2 +-
 qapi/machine.json                               | 14 ++++++
 qapi/migration.json                             | 52 ++++++++++---------
 qapi/misc.json                                  | 12 +++--
 qapi/net.json                                   | 12 ++++-
 qapi/pragma.json                                | 66 +++++++++++++++++++++++++
 qapi/qdev.json                                  | 12 ++---
 qapi/sockets.json                               | 48 +++++++++++++-----
 qapi/stats.json                                 |  2 +
 qapi/tpm.json                                   |  4 ++
 qapi/transaction.json                           |  2 +
 qapi/ui.json                                    | 14 ++++++
 qapi/yank.json                                  |  4 +-
 qga/qapi-schema.json                            | 58 ++++++++++++++--------
 include/hw/virtio/vhost-vsock-common.h          |  1 +
 include/net/filter.h                            |  2 +-
 chardev/char-socket.c                           |  2 +-
 util/qemu-sockets.c                             |  3 +-
 scripts/qapi/parser.py                          |  7 ++-
 scripts/qapi/source.py                          |  2 +
 tests/qapi-schema/doc-bad-alternate-member.json |  2 +
 tests/qapi-schema/doc-good.json                 | 14 +++---
 tests/qapi-schema/doc-good.out                  |  2 +-
 31 files changed, 322 insertions(+), 106 deletions(-)

-- 
2.43.0


