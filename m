Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 244B3C87FCA
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 13:13:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugk7u-0000pa-IN; Tue, 29 Jul 2025 09:12:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ugk7j-00009L-5G
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 09:12:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ugk7b-0001P3-C1
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 09:12:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753794714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+JtyoWfbSYh25mq/jSEHbmsVQmMB4IuV9nUNzgqOoaE=;
 b=fmriGcGjACvU4SBmpLyyuQZtZ7hMhok+Uf2XXRJ1yUyj/4F0KR49rjTTrfAc/kKXJdpLf3
 jnSSsyKxNL/Qm5i0J2ytDDBFrWRIZF5H8ZWy+6QsDT0SWlly3MpreYEw9RBycuVfok5oeM
 pk6wP7z9BR+beKy9DMRjnV0OqMv51yw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-374-VFy69DSQPo6liiPcRthkAA-1; Tue,
 29 Jul 2025 09:11:52 -0400
X-MC-Unique: VFy69DSQPo6liiPcRthkAA-1
X-Mimecast-MFC-AGG-ID: VFy69DSQPo6liiPcRthkAA_1753794711
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 87DA4180010A
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 13:11:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3656D1800B6C
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 13:11:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 601AD21E6A27; Tue, 29 Jul 2025 15:11:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
Subject: [PULL 0/5] QAPI patches for 2025-07-29
Date: Tue, 29 Jul 2025 15:11:43 +0200
Message-ID: <20250729131148.3777401-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 92c05be4dfb59a71033d4c57dac944b29f7dabf0:

  Merge tag 'pull-qga-2025-07-28' of https://repo.or.cz/qemu/armbru into staging (2025-07-28 09:31:19 -0400)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2025-07-29

for you to fetch changes up to a95b3c0ad857055198cdb272bca2af975092d060:

  MAINTAINERS: Cover docs/devel/qapi-domain.rst properly (2025-07-29 14:51:39 +0200)

----------------------------------------------------------------
QAPI patches for 2025-07-29

----------------------------------------------------------------
Markus Armbruster (5):
      qapi: Add more cross-references
      qapi/accelerator: Fix markup of heading
      tests/qapi-schema: Bury dead test case doc-non-first-section
      docs/qapi-domain: Fix typos
      MAINTAINERS: Cover docs/devel/qapi-domain.rst properly

 MAINTAINERS                                  | 1 +
 docs/devel/qapi-domain.rst                   | 4 ++--
 qapi/accelerator.json                        | 4 +++-
 qapi/dump.json                               | 2 +-
 qapi/machine.json                            | 2 +-
 qapi/migration.json                          | 4 ++--
 qapi/misc-i386.json                          | 2 +-
 qapi/run-state.json                          | 2 +-
 qapi/sockets.json                            | 2 +-
 tests/qapi-schema/doc-non-first-section.err  | 1 -
 tests/qapi-schema/doc-non-first-section.json | 6 ------
 tests/qapi-schema/doc-non-first-section.out  | 0
 12 files changed, 13 insertions(+), 17 deletions(-)
 delete mode 100644 tests/qapi-schema/doc-non-first-section.err
 delete mode 100644 tests/qapi-schema/doc-non-first-section.json
 delete mode 100644 tests/qapi-schema/doc-non-first-section.out

-- 
2.49.0


