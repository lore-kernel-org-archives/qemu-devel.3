Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2779E6F072
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 17:38:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6vaG-00011b-W3; Fri, 01 Nov 2024 13:37:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1t6vaD-0000zJ-7k
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 13:37:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1t6vaA-0000tA-Fn
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 13:37:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730482627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6cEQXUG082XzKLilEz14APYugcqUROKrmhZsSn33FSk=;
 b=XV4ogsu2L5aqDA+d/tIxOxGzu83j71gbK0dtEPSsATGQUf99MleR3yEvB50y5Z82KK9I57
 zpriokAqYYtJGJXHkvfvBpIzXeypKR1RAx8RBIB92Mmv9TyYIUMX5nXRx2PA+TSj0nCSqf
 QiI8LI2QxwyXkRzcBHUs+KpZS3XB+SI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-9-h7eWQu0LOke7hEa16RE_NA-1; Fri,
 01 Nov 2024 13:37:06 -0400
X-MC-Unique: h7eWQu0LOke7hEa16RE_NA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9C2FC195608A; Fri,  1 Nov 2024 17:37:04 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.82.62])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8D3A119560A2; Fri,  1 Nov 2024 17:37:02 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 0/4] python: update linting for new mypy/pylint releases
Date: Fri,  1 Nov 2024 13:36:56 -0400
Message-ID: <20241101173700.965776-1-jsnow@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Various python tests in the "check-python-tox" test case on GitLab have=0D
begun failing due to newer package versions. This patch set corrects=0D
those issues and also improves the reliability of local developer tests=0D
which may be using these tooling versions outside of GitLab pinned=0D
version tests.=0D
=0D
There are remaining issues with the "check-dev" test I have yet to=0D
rectify, but appear unrelated to linter versions specifically and will=0D
be handled separately.=0D
=0D
As a result of this patch, the optionally-run and may-fail=0D
"check-python-tox" test case on GitLab will become green again, and=0D
local invocations of "make check-tox" in the python subdirectory will=0D
also pass again. "check-python-minreqs" on GitLab and "make=0D
check-minreqs" in the local developer environment were/are=0D
unaffected. local iotest invocations for test case #297 ought to now=0D
begin passing on developer workstations with bleeding-edge python=0D
packages.=0D
=0D
John Snow (4):=0D
  iotests: reflow ReproducibleTestRunner arguments=0D
  iotests: correct resultclass type in ReproducibleTestRunner=0D
  python: disable too-many-positional-arguments warning=0D
  python: silence pylint raising-non-exception error=0D
=0D
 python/scripts/mkvenv.py      |  3 +++=0D
 python/setup.cfg              |  1 +=0D
 tests/qemu-iotests/iotests.py | 11 +++++++----=0D
 tests/qemu-iotests/pylintrc   |  1 +=0D
 4 files changed, 12 insertions(+), 4 deletions(-)=0D
=0D
-- =0D
2.47.0=0D
=0D


