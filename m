Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35BB3CD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 14:19:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZUbV-0001Ow-QB; Tue, 16 Jun 2026 10:17:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wZUbU-0001OK-5R
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 10:17:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wZUbR-0003xt-UW
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 10:17:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781619440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=55sNU2UIt/bdDVip3VHjJu76KSs780W7d+TrxddONt0=;
 b=ChTjzbj5mcktDWOQ3Ol+4B5RYmpT1Y4xKQrS6WugJ+TZU34/dk27WsGajebJto2eeO/Zk+
 5MMu/fAYm9DGWRiHLkefgsYiSoYtxnmrJhVrZstpqWVOG2dx1p6hkLaJGf03kxxLA6SZVT
 dv+6mcPmVbgoSzBNSs2+TjThgUIUQ18=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-SbU-IAcnPK6SjDCtRkauuQ-1; Tue,
 16 Jun 2026 10:17:19 -0400
X-MC-Unique: SbU-IAcnPK6SjDCtRkauuQ-1
X-Mimecast-MFC-AGG-ID: SbU-IAcnPK6SjDCtRkauuQ_1781619438
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 317AC1954B19
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 14:17:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DAEAA3008DCB
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 14:17:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3FBF921E6A01; Tue, 16 Jun 2026 16:17:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
Subject: [PULL 00/14] QAPI patches for 2026-06-16
Date: Tue, 16 Jun 2026 16:17:01 +0200
Message-ID: <20260616141715.2974467-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The following changes since commit 2f28d34ea0aead9830478cd1d3d0dd9d9191d82e:

  Merge tag 'pull-tcg-20260612' of https://gitlab.com/rth7680/qemu into staging (2026-06-13 14:02:34 -0400)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2026-06-16

for you to fetch changes up to ebb49d4bb6bcc4f97401fabf3310937d44a2226b:

  qapi: add doc comment "Intro" section parsing (2026-06-16 15:36:08 +0200)

----------------------------------------------------------------
QAPI patches for 2026-06-16

----------------------------------------------------------------
Filip Hejsek (1):
      qapi: drop "must exist" from ID descriptions for consistency

John Snow (13):
      python: temporarily restrict max mypy version
      tests/qapi: generate output in source order
      qapi/parser: remove unused QAPIDoc subsection members
      qapi/parser: add has_features property
      qapi/parser: make remaining subsection members "private"
      qapi/parser: fix comment phrasing
      qapi: new doc comment "Intro" section
      qapi/parser: move _insert_near_kind() method
      qapi/parser: add mea culpa comment for ensure_returns
      qapi: adjust doc comment stub member insertion algorithm
      qapi: remove implicit doc comment Plain section
      qapi/qapidoc: add rendering for INTRO sections
      qapi: add doc comment "Intro" section parsing

 docs/devel/qapi-code-gen.rst   |  16 ++--
 docs/sphinx/qapidoc.py         |  61 +++++++++------
 qapi/char.json                 |   6 +-
 python/setup.cfg               |   3 +-
 scripts/qapi/parser.py         | 167 ++++++++++++++++++++++++-----------------
 tests/qapi-schema/doc-good.out |  86 +++++++++++----------
 tests/qapi-schema/test-qapi.py |  14 ++--
 7 files changed, 200 insertions(+), 153 deletions(-)

-- 
2.54.0


