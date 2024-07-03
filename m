Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D0E6C30653
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 17:53:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP49x-0003FW-4i; Wed, 03 Jul 2024 13:52:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sP49v-0003F0-AZ
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 13:52:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sP49s-0001FO-9u
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 13:52:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720029163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=e0vdgbI6cFFYammuYGEmn/VaVPPNRa/koqoZUcBHlTo=;
 b=NPPSAed9L2WtKzELJksKheWb4MIRXcMY9isChVZjfLvQT7H+SUcVMfAWV/KWHNzV0Q71PH
 N/HGXIy1puqepj62yhgPmTv5HDN5oFdePbyqTKaIVmlSFA3pOMJ++39359zEcFD7CdRZS0
 Ag70rL6myZr3Z+EQH45pfYVfnKDFOBU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-Iy6r05A6NM-E7FiQOxigBA-1; Wed,
 03 Jul 2024 13:52:39 -0400
X-MC-Unique: Iy6r05A6NM-E7FiQOxigBA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E7B9D19560B4; Wed,  3 Jul 2024 17:52:37 +0000 (UTC)
Received: from scv.localdomain (unknown [10.22.34.31])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 780B71955BC0; Wed,  3 Jul 2024 17:52:36 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v2 0/2] docs/python: bump minimum Sphinx version
Date: Wed,  3 Jul 2024 13:52:33 -0400
Message-ID: <20240703175235.239004-1-jsnow@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
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
https://gitlab.com/jsnow/qemu/-/pipelines/1359549621=0D
=0D
(failures appear to be unrelated to the series.)=0D
=0D
V2: refactor all code deletions into patch 2=0D
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


