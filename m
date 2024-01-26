Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B27C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 06:29:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTFh9-0005Ji-Fc; Fri, 26 Jan 2024 01:28:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rTFgz-0005Cf-Ch
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 01:27:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rTFgu-0001kx-Js
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 01:27:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706250468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yFFQcZOejh+Azwa+uHbmJ29+OPbYCOyje9AgaCP8rd8=;
 b=RbnKb7x7t01q39n21lb/MEEBcqDuL4umlkG/u/XSdYXmfrISjc36AY25uk3brCBZ8gC+uv
 7FlU0V0BQWj67kVwy2UFqCCnBAiqgf+uHPwm/Dbsx5kcZ7X+zmrc8GdhEctGR6MaK63CXL
 SI9Id3y8n2uTtamahFdT3cACArWYqCk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-d6vyl39zPwWjd1fbEBD5Ww-1; Fri,
 26 Jan 2024 01:27:46 -0500
X-MC-Unique: d6vyl39zPwWjd1fbEBD5Ww-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EA6833C13A84;
 Fri, 26 Jan 2024 06:27:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C9D7B200A08E;
 Fri, 26 Jan 2024 06:27:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B407521E66E6; Fri, 26 Jan 2024 07:27:44 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL 0/8] QAPI patches patches for 2024-01-26
Date: Fri, 26 Jan 2024 07:27:36 +0100
Message-ID: <20240126062744.265588-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 5bab95dc74d43bbb28c6a96d24c810a664432057:

  Merge tag 'pull-request-2024-01-24' of https://gitlab.com/thuth/qemu into staging (2024-01-25 12:33:42 +0000)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2024-01-26

for you to fetch changes up to 37507c14a6f562036fce98453de3e869b9c0684f:

  qapi: Fix malformed "Since:" section tags (again) (2024-01-26 07:04:54 +0100)

----------------------------------------------------------------
QAPI patches patches for 2024-01-26

----------------------------------------------------------------
Markus Armbruster (8):
      docs/devel/qapi-code-gen: Don't reserve types ending with 'Kind'
      docs/devel/qapi-code-gen: Fix missing ':' in tagged section docs
      docs: Replace dangling references to docs/interop/qmp-intro.txt
      qapi: Fix dangling references to docs/devel/qapi-code-gen.txt
      docs/interop/bitmaps: Clean up a reference to qemu-qmp-ref
      qapi: Fix mangled "Returns" sections in documentation
      qapi: Indent tagged doc comment sections properly
      qapi: Fix malformed "Since:" section tags (again)

 docs/devel/qapi-code-gen.rst            |  9 ++++-----
 docs/devel/writing-monitor-commands.rst |  4 ++--
 docs/interop/bitmaps.rst                |  6 +++---
 qapi/block-core.json                    |  4 ++--
 qapi/char.json                          |  4 ++--
 qapi/introspect.json                    |  2 +-
 qapi/machine.json                       | 24 ++++++++++++------------
 qapi/migration.json                     | 14 +++++++-------
 qapi/misc-target.json                   |  2 +-
 qapi/misc.json                          | 10 +++++-----
 qapi/net.json                           | 15 +++++++++------
 qapi/qdev.json                          |  5 +++--
 qapi/qom.json                           | 10 ++++++----
 qapi/yank.json                          |  4 ++--
 include/qapi/visitor.h                  |  2 +-
 include/qemu/yank.h                     |  2 +-
 qapi/qapi-util.c                        |  2 +-
 util/yank.c                             |  2 +-
 scripts/qapi/parser.py                  |  2 +-
 19 files changed, 64 insertions(+), 59 deletions(-)

-- 
2.43.0


