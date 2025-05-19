Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17803C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 17:02:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH3rs-0007CH-4v; Mon, 19 May 2025 13:01:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uH3rR-00078A-1V
 for qemu-devel@nongnu.org; Mon, 19 May 2025 13:01:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uH3rM-0000BS-HJ
 for qemu-devel@nongnu.org; Mon, 19 May 2025 13:01:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747674062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8Y8s6xJOFgaAAAbJybJ92bajG6M6RwI9LbyP6JKPK4I=;
 b=IGOyRV5VgjzoCsjs3mRKWu5f7AcwFE7YqYtxPSD4POGo+8cKXD6H+N4aDfimhkaQOqdT9S
 Whcd6YGVkgMlkufl9kUtNqAD5ut7i36skA3t2xrNoap3e3H8wLh13En4UymV/MHFlCexlt
 l5ZpZNNOuRZpiQQorvS8Ehd6ZvXmXio=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-52-ck3Lks3LPd-Ce0h2YvXopQ-1; Mon,
 19 May 2025 13:01:00 -0400
X-MC-Unique: ck3Lks3LPd-Ce0h2YvXopQ-1
X-Mimecast-MFC-AGG-ID: ck3Lks3LPd-Ce0h2YvXopQ_1747674059
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9114B19560A3; Mon, 19 May 2025 17:00:59 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.89.235])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A2FD31956095; Mon, 19 May 2025 17:00:57 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Michael Roth <michael.roth@amd.com>,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 0/6] Python patches
Date: Mon, 19 May 2025 13:00:49 -0400
Message-ID: <20250519170055.3693275-1-jsnow@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

The following changes since commit 757a34115e7491744a63dfc3d291fd1de5297ee2=
:=0D
=0D
  Merge tag 'pull-nvme-20250515' of https://gitlab.com/birkelund/qemu into =
staging (2025-05-15 13:42:27 -0400)=0D
=0D
are available in the Git repository at:=0D
=0D
  https://gitlab.com/jsnow/qemu.git tags/python-pull-request=0D
=0D
for you to fetch changes up to 818060c02a53df4b27bc86cbac3a26009996b6a4:=0D
=0D
  qapi: delete un-needed python static analysis configs (2025-05-19 12:44:0=
1 -0400)=0D
=0D
----------------------------------------------------------------=0D
Python PR=0D
=0D
Add scripts/qapi and docs/sphinx/*qapi* to the Python static analysis check=
s=0D
=0D
----------------------------------------------------------------=0D
=0D
John Snow (5):=0D
  qapi: Add some pylint ignores=0D
  docs/qapidoc: linting fixes=0D
  python: update missing dependencies from minreqs=0D
  python: add qapi static analysis tests=0D
  qapi: delete un-needed python static analysis configs=0D
=0D
Markus Armbruster (1):=0D
  python: Drop redundant warn_unused_configs =3D True=0D
=0D
 docs/sphinx/qapi_domain.py  | 25 ++++++++++++++-----------=0D
 docs/sphinx/qapidoc.py      |  5 +++--=0D
 python/setup.cfg            |  2 +-=0D
 python/tests/minreqs.txt    | 25 +++++++++++++++++++++++++=0D
 python/tests/qapi-flake8.sh |  4 ++++=0D
 python/tests/qapi-isort.sh  |  6 ++++++=0D
 python/tests/qapi-mypy.sh   |  2 ++=0D
 python/tests/qapi-pylint.sh |  6 ++++++=0D
 scripts/qapi/.flake8        |  3 ---=0D
 scripts/qapi/.isort.cfg     |  7 -------=0D
 scripts/qapi/backend.py     |  2 ++=0D
 scripts/qapi/mypy.ini       |  4 ----=0D
 scripts/qapi/pylintrc       |  1 +=0D
 13 files changed, 64 insertions(+), 28 deletions(-)=0D
 create mode 100755 python/tests/qapi-flake8.sh=0D
 create mode 100755 python/tests/qapi-isort.sh=0D
 create mode 100755 python/tests/qapi-mypy.sh=0D
 create mode 100755 python/tests/qapi-pylint.sh=0D
 delete mode 100644 scripts/qapi/.flake8=0D
 delete mode 100644 scripts/qapi/.isort.cfg=0D
 delete mode 100644 scripts/qapi/mypy.ini=0D
=0D
-- =0D
2.48.1=0D
=0D


