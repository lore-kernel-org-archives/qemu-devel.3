Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F20C3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 19:59:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjer-0007W9-9T; Tue, 02 Jul 2024 15:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sOjeq-0007Ve-26
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 15:59:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sOjem-0008N0-07
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 15:59:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719950351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6Hep9nFblgyR1Zs27iKwK8gqXTSkEmzF+TeJwQNkWF0=;
 b=DAYHVVn5xaNRtkVfDcy8PDrTv3MpF781rXE6+syQ/fNdRzo3EHyVvob6lKHliN1YFII9c0
 0LkHiaUvPh6JkRZeNVFWY1WYJQ9aCLduWJO5a3jGPq+ndGXVn/Eec91eoWd8corbi1hVte
 BzC7lsvTz7QF4mYqs0xjYZoAYhmYZWw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-455-sdPxN1vtNpeen6YxAH6zyA-1; Tue,
 02 Jul 2024 15:59:08 -0400
X-MC-Unique: sdPxN1vtNpeen6YxAH6zyA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 182C519560A6; Tue,  2 Jul 2024 19:59:07 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.32.28])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AA2C53000221; Tue,  2 Jul 2024 19:59:04 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 0/2] docs/python: bump minimum Sphinx version
Date: Tue,  2 Jul 2024 15:59:01 -0400
Message-ID: <20240702195903.204007-1-jsnow@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

With recent deprecations, we can advance our minimum sphinx version=0D
safely. This is heavily motivated by new qapidoc work which is much=0D
easier to maintain cross-version compatibility for - see difficulties in=0D
our dbus documentation which only works on sphinx >=3D 4.=0D
=0D
We can only guarantee >=3D 3.4.3 now, but that's still vastly easier than=0D
maintaining compatibility all the way back to 1.x.=0D
=0D
GitLab: https://gitlab.com/jsnow/qemu/-/pipelines/1357902509=0D
=0D
(failures appear to be unrelated to the series.)=0D
=0D
John Snow (2):=0D
  Python: bump minimum sphinx version to 3.4.3=0D
  docs: remove Sphinx 1.x compatibility code=0D
=0D
 docs/conf.py             |  7 +++----=0D
 docs/sphinx/hxtool.py    | 21 ++++-----------------=0D
 docs/sphinx/kerneldoc.py | 38 ++++++++++++--------------------------=0D
 docs/sphinx/kernellog.py | 28 ----------------------------=0D
 docs/sphinx/qapidoc.py   | 29 +++--------------------------=0D
 pythondeps.toml          |  2 +-=0D
 6 files changed, 23 insertions(+), 102 deletions(-)=0D
 delete mode 100644 docs/sphinx/kernellog.py=0D
=0D
-- =0D
2.45.0=0D
=0D


