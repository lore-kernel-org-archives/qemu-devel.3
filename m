Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7205FC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 07:37:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp1KK-0004cD-3M; Tue, 26 Mar 2024 03:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rp1KI-0004bn-Tb
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 03:34:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rp1KH-0005L8-0j
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 03:34:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711438467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=i43ky+hMlKtzrlGiuUgqUQynMaMbo/Xs5KecqvICB3A=;
 b=iKlpntG6M6VP6wOaHBWm7w5YHoe1Q6kOTEpT4PYwVfjKnXbF9rj9Pjn6j1rIngZdGo0zYr
 laLNX5X/ZUYIzuaAGuFb7tN1/WWvaHaAd83cfZX/T2oZ9SiAwONU/rUlx1Gg4ONtgrsDIu
 JxG1vYGqo+mFyIuz85iQfvse1iQk4O8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-i9wG2lp7NRqKh-3dvkubqg-1; Tue, 26 Mar 2024 03:34:25 -0400
X-MC-Unique: i9wG2lp7NRqKh-3dvkubqg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 953A8185A784;
 Tue, 26 Mar 2024 07:34:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 736FC492BD8;
 Tue, 26 Mar 2024 07:34:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 887C521E6757; Tue, 26 Mar 2024 08:34:20 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL 00/20] QAPI patches patches for 2024-03-26
Date: Tue, 26 Mar 2024 08:34:00 +0100
Message-ID: <20240326073420.738016-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
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

This pull request does not touch code, only QAPI schema documentation
comments and error-suppressing QAPI schema pragma
documentation-exceptions.

The following changes since commit 6a4180af9686830d88c387baab6d79563ce42a15:

  Merge tag 'pull-request-2024-03-25' of https://gitlab.com/thuth/qemu into staging (2024-03-25 14:19:42 +0000)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2024-03-26

for you to fetch changes up to 1a533ce986f52c35f324f5f4fff22cdc2619a47c:

  qapi: document parameters of query-cpu-model-* QAPI commands (2024-03-26 06:36:08 +0100)

----------------------------------------------------------------
QAPI patches patches for 2024-03-26

----------------------------------------------------------------
David Hildenbrand (1):
      qapi: document parameters of query-cpu-model-* QAPI commands

Marc-André Lureau (1):
      qapi: document InputMultiTouchType

Markus Armbruster (15):
      qapi: Improve migration TLS documentation
      qapi: Resync MigrationParameter and MigrateSetParameters
      qapi: Fix bogus documentation of query-migrationthreads
      qapi: Drop stray Arguments: line from qmp_capabilities docs
      qapi: Expand a few awkward abbreviations in documentation
      qapi: Tidy up block-latency-histogram-set documentation some more
      qapi: Tidy up indentation of add_client's example
      qapi: Fix argument markup in drive-mirror documentation
      qapi: Fix typo in request-ebpf documentation
      qapi: Fix abbreviation punctuation in doc comments
      qapi: Start sentences with a capital letter, end them with a period
      qapi: Don't repeat member type in its documentation text
      qapi: Refill doc comments to conform to current conventions
      qapi: Correct documentation indentation and whitespace
      qga/qapi-schema: Refill doc comments to conform to current conventions

Paolo Bonzini (2):
      qapi: document leftover members in qapi/run-state.json
      qapi: document leftover members in qapi/stats.json

Vladimir Sementsov-Ogievskiy (1):
      qapi/block-core: improve Qcow2OverlapCheckFlags documentation

 qapi/block-core.json     |  71 ++++++++-----
 qapi/block.json          |  14 +--
 qapi/control.json        |   2 -
 qapi/crypto.json         |  12 +--
 qapi/cxl.json            |   4 +-
 qapi/dump.json           |  18 ++--
 qapi/ebpf.json           |  14 ++-
 qapi/machine-target.json |  68 ++++++++-----
 qapi/machine.json        |  18 ++--
 qapi/migration.json      | 253 ++++++++++++++++++++++++-----------------------
 qapi/misc.json           |   8 +-
 qapi/net.json            |  27 ++---
 qapi/pragma.json         |  13 +--
 qapi/qom.json            |  38 +++----
 qapi/replay.json         |   4 +-
 qapi/run-state.json      |  45 ++++++---
 qapi/sockets.json        |   3 +-
 qapi/stats.json          |  14 ++-
 qapi/ui.json             |  28 ++++--
 qapi/virtio.json         |  20 ++--
 qga/qapi-schema.json     |  29 +++---
 21 files changed, 389 insertions(+), 314 deletions(-)

-- 
2.44.0


