Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF5C3C44507
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 09:17:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjZGK-00041d-0p; Tue, 14 Jul 2026 05:17:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wjZGI-00040k-07
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 05:17:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wjZGF-0006iP-Sr
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 05:17:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784020626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CY8BjQ4qT2vZSgj6Hy6tHcVYA6IArdS7UluDICB/6Ww=;
 b=W1MnHMJ06FBZc3rvTGC0NOQVCo+i19xpvH9mhAeE01JnnFjlZtS+YiiJHmjbmiPTvfu23T
 oF73pIgO2/f5dYVp+btJU3Xmsf0wt1SoC8bY2MBsqiUubl8fMLFmt8iLce1nedbKliTYlF
 gUIw4p1hZHYzEJ0dNAYin/SpfhSOnTY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-190-tltLWB2tP_ukjwMYiDVVKg-1; Tue,
 14 Jul 2026 05:17:04 -0400
X-MC-Unique: tltLWB2tP_ukjwMYiDVVKg-1
X-Mimecast-MFC-AGG-ID: tltLWB2tP_ukjwMYiDVVKg_1784020623
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 659221956078
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 09:17:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 23AF1414
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 09:17:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 774F621E6920; Tue, 14 Jul 2026 11:17:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
Subject: [PULL 0/4] Miscellaneous patches for 2026-07-14
Date: Tue, 14 Jul 2026 11:16:56 +0200
Message-ID: <20260714091700.3797064-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=armbru@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

The following changes since commit 499039798cdad7d86b787fec0eaf1da4151c0f05:

  Merge tag 'pull-request-2026-07-12' of https://gitlab.com/huth/qemu into staging (2026-07-12 21:49:04 +0200)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-misc-2026-07-14

for you to fetch changes up to 87f608e3c20677e57fc1c854085218dab8a45946:

  json-parser: fix formatting of comment (2026-07-14 10:59:58 +0200)

----------------------------------------------------------------
Miscellaneous patches for 2026-07-14

----------------------------------------------------------------
Markus Armbruster (3):
      qapi: Fix misspelled section tags in doc comments
      qom: Fix device-list-properties & friends to show legacy-FOO props
      MAINTAINERS: Regularise the status fields (again)

Paolo Bonzini (1):
      json-parser: fix formatting of comment

 MAINTAINERS              | 2 +-
 qapi/machine-common.json | 2 +-
 qapi/qom.json            | 6 +++---
 qobject/json-parser.c    | 7 ++++---
 qom/qom-qmp-cmds.c       | 7 -------
 5 files changed, 9 insertions(+), 15 deletions(-)

-- 
2.54.0


