Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 320F0C10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 11:06:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3w7n-00031J-2b; Mon, 06 May 2024 07:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s3w7a-0002lC-9G
 for qemu-devel@nongnu.org; Mon, 06 May 2024 07:03:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s3w7X-0003eN-3g
 for qemu-devel@nongnu.org; Mon, 06 May 2024 07:03:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714993377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+VDoAP4dRSJ6ktQ9AnhVnHywJGpn6ImbQzg65r5yopo=;
 b=IiTWzEBofAQFqiXVDD76hxjZE7LNKMEd4/9fRQCyKOYAytbVrz/xIHjRH1rvS/zmTPhzGp
 xDtqk9c55xBymkfLGaDZW/kRijpNE6W+EqYeTeB/Qqwt9fmYMym9zAYlG+rmTVq3Ss+gJo
 GgD395iEFClZnM2J6ARVwaeQir42M0w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-zDIZxndTMku53V0MxCg1pw-1; Mon, 06 May 2024 07:02:55 -0400
X-MC-Unique: zDIZxndTMku53V0MxCg1pw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5EDC88016FF;
 Mon,  6 May 2024 11:02:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2715CAC6B;
 Mon,  6 May 2024 11:02:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 37A7B21E6806; Mon,  6 May 2024 13:02:54 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PULL 0/7] QAPI patches patches for 2024-05-06
Date: Mon,  6 May 2024 13:02:40 +0200
Message-ID: <20240506110254.3965097-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

The following changes since commit 248f6f62df073a3b4158fd0093863ab885feabb5:

  Merge tag 'pull-axp-20240504' of https://gitlab.com/rth7680/qemu into staging (2024-05-04 08:39:46 -0700)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2024-05-06

for you to fetch changes up to 285a8f209af7b4992aa91e8bea03a303fb6406ab:

  qapi: Simplify QAPISchemaVariants @tag_member (2024-05-06 12:38:27 +0200)

----------------------------------------------------------------
QAPI patches patches for 2024-05-06

----------------------------------------------------------------
Markus Armbruster (7):
      qapi: New QAPISchemaBranches, QAPISchemaAlternatives
      qapi: Rename visitor parameter @variants to @branches
      qapi: Rename visitor parameter @variants to @alternatives
      qapi: Rename QAPISchemaObjectType.variants to .branches
      qapi: Rename QAPISchemaAlternateType.variants to .alternatives
      qapi: Move conditional code from QAPISchemaVariants to its subtypes
      qapi: Simplify QAPISchemaVariants @tag_member

 docs/sphinx/qapidoc.py         |  21 ++--
 scripts/qapi/commands.py       |   2 +-
 scripts/qapi/events.py         |   2 +-
 scripts/qapi/gen.py            |   2 +-
 scripts/qapi/introspect.py     |  15 +--
 scripts/qapi/schema.py         | 223 +++++++++++++++++++++--------------------
 scripts/qapi/types.py          |  12 ++-
 scripts/qapi/visit.py          |  24 +++--
 tests/qapi-schema/test-qapi.py |   9 +-
 9 files changed, 163 insertions(+), 147 deletions(-)

-- 
2.44.0


