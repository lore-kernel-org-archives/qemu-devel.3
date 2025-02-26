Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64090C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 10:29:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnEez-0004Hn-5H; Wed, 26 Feb 2025 05:29:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tnEex-0004HV-Ol
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 05:28:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tnEet-0003g7-BA
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 05:28:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740565732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pZDg7f9/LXojlDH5bIGvP5r3dZB6LwhELTfiHXMeU5g=;
 b=LPzjs3mmQWSANl3fIaO8rSYNWHR7HJx8Gxvj8ZHdIVfn+qIp46YVcVj1fVIbOQN6nRZ+Dd
 l0S05dFF9J7ct1SifKNR4Fq79kOgAe0r8C56MBRZNSH7Wdek3gNUtNr2G5z9NN45rSpQF1
 ezFtPsSYMhRqCY4ZJJld0RWDJsqL2yM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-507-Q_BZt8mUPaWWTmoPDMnXWA-1; Wed,
 26 Feb 2025 05:28:46 -0500
X-MC-Unique: Q_BZt8mUPaWWTmoPDMnXWA-1
X-Mimecast-MFC-AGG-ID: Q_BZt8mUPaWWTmoPDMnXWA_1740565725
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AC20D1800985
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 10:28:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.9])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 629F1180035F
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 10:28:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8D62121E675E; Wed, 26 Feb 2025 11:28:42 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
Subject: [PULL 0/6] QAPI patches patches for 2025-02-26
Date: Wed, 26 Feb 2025 11:28:36 +0100
Message-ID: <20250226102842.3721046-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The following changes since commit b69801dd6b1eb4d107f7c2f643adf0a4e3ec9124:

  Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging (2025-02-22 05:06:39 +0800)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2025-02-26

for you to fetch changes up to 4bdf4e66233a7c476b934a1c4776ef7d136ff867:

  qapi: pluggable backend code generators (2025-02-26 11:12:46 +0100)

----------------------------------------------------------------
QAPI patches patches for 2025-02-26

----------------------------------------------------------------
Daniel P. Berrangé (1):
      qapi: pluggable backend code generators

John Snow (4):
      qapi: update pylintrc config
      python: add qapi static analysis tests
      docs/qapidoc: support header-less freeform sections
      docs/qapidoc: remove example section support

Roman Penyaev (1):
      qapi/char.json: minor doc rewording for `hub` device

 docs/sphinx/qapidoc.py          | 11 ++----
 qapi/char.json                  |  2 +-
 python/tests/qapi-flake8.sh     |  2 ++
 python/tests/qapi-isort.sh      |  2 ++
 python/tests/qapi-mypy.sh       |  2 ++
 python/tests/qapi-pylint.sh     |  4 +++
 scripts/qapi/backend.py         | 63 ++++++++++++++++++++++++++++++++
 scripts/qapi/main.py            | 80 +++++++++++++++++++++++------------------
 scripts/qapi/pylintrc           |  1 +
 tests/qapi-schema/doc-good.json |  4 +++
 tests/qapi-schema/doc-good.out  |  3 ++
 11 files changed, 130 insertions(+), 44 deletions(-)
 create mode 100755 python/tests/qapi-flake8.sh
 create mode 100755 python/tests/qapi-isort.sh
 create mode 100755 python/tests/qapi-mypy.sh
 create mode 100755 python/tests/qapi-pylint.sh
 create mode 100644 scripts/qapi/backend.py

-- 
2.48.1


