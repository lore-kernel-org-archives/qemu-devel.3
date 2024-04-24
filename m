Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 213A4C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 08:17:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzXof-0000Og-LW; Wed, 24 Apr 2024 04:17:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzXoc-0000Lr-KH
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 04:17:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzXoZ-0006Ls-Mp
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 04:17:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713946634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=L0HRyayKXtYJAkL09yI1qRRBiccrv2ccaGdo2Cg2GjA=;
 b=SHX0HYoHdbbsHr1V9CXCbaJrVbDfro9uPCOnVpuFCEJug2kXgkpMMjsfwlkcr0WGCqKL3w
 tQvO7G0xFUGIMm0oim3bq22imd5Rq86xZ23aPSobLA+iJygly39TvCOM+K8wIZkznX3X3u
 EkBYEdeBQsnJQeUGl7QuiOIZzvtnQg4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-_T84hXGONk-q8artRolHGg-1; Wed, 24 Apr 2024 04:17:12 -0400
X-MC-Unique: _T84hXGONk-q8artRolHGg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EFD4880D0F3;
 Wed, 24 Apr 2024 08:17:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CF21F492BC7;
 Wed, 24 Apr 2024 08:17:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C477521E66C8; Wed, 24 Apr 2024 10:17:10 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PULL 00/25] QAPI patches patches for 2024-04-24
Date: Wed, 24 Apr 2024 10:16:45 +0200
Message-ID: <20240424081710.2907748-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
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

The following changes since commit c25df57ae8f9fe1c72eee2dab37d76d904ac382e:

  Update version for 9.0.0 release (2024-04-23 14:19:21 +0100)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2024-04-24

for you to fetch changes up to 060b5a9323e5f49c5edcb77c42e231065bbcc42e:

  qapi: Dumb down QAPISchema.lookup_entity() (2024-04-24 10:03:54 +0200)

----------------------------------------------------------------
QAPI patches patches for 2024-04-24

----------------------------------------------------------------
John Snow (22):
      qapi/parser: fix typo - self.returns.info => self.errors.info
      qapi/parser: shush up pylint
      qapi: sort pylint suppressions
      qapi/schema: add pylint suppressions
      qapi: create QAPISchemaDefinition
      qapi/schema: declare type for QAPISchemaObjectTypeMember.type
      qapi/schema: declare type for QAPISchemaArrayType.element_type
      qapi/schema: make c_type() and json_type() abstract methods
      qapi/schema: adjust type narrowing for mypy's benefit
      qapi/schema: add type narrowing to lookup_type()
      qapi/schema: assert resolve_type has 'info' and 'what' args on error
      qapi/schema: fix QAPISchemaArrayType.check's call to resolve_type
      qapi/schema: assert info is present when necessary
      qapi/schema: add _check_complete flag
      qapi/schema: Don't initialize "members" with `None`
      qapi/schema: fix typing for QAPISchemaVariants.tag_member
      qapi/schema: assert inner type of QAPISchemaVariants in check_clash()
      qapi/parser: demote QAPIExpression to Dict[str, Any]
      qapi/parser.py: assert member.info is present in connect_member
      qapi/schema: add type hints
      qapi/schema: turn on mypy strictness
      qapi/schema: remove unnecessary asserts

Markus Armbruster (3):
      qapi: Assert built-in types exist
      qapi: Tighten check whether implicit object type already exists
      qapi: Dumb down QAPISchema.lookup_entity()

 scripts/qapi/introspect.py |   8 +-
 scripts/qapi/mypy.ini      |   5 -
 scripts/qapi/parser.py     |   7 +-
 scripts/qapi/pylintrc      |  11 +-
 scripts/qapi/schema.py     | 794 +++++++++++++++++++++++++++++----------------
 5 files changed, 537 insertions(+), 288 deletions(-)

-- 
2.44.0


