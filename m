Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E88E9A04D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 19:32:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsnGl-00028U-7I; Wed, 18 Feb 2026 14:31:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vsnGh-000281-L4
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 14:31:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vsnGf-0007hR-Em
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 14:31:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771443084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NArCG9I5YE66mSkiwKj3wX12DvxACB+8pnJnX+Zskfs=;
 b=MwLNBW8R8Cni43MpiU7X0co8niSipaAVKL+qR4ClbbGBfP4x7agO8bqoXKH2nhdkUQ9e2I
 ckJabdkHMKBIThPy6dSDr413YDqei412V+SOK8444lDKdDdg8Sf7ZlLTJtE49Pt68hRlKh
 TJat0zk05brHey5ayvBzw4JfIRVA/w4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-424-3CkXEdiINX6YTHK66hlQRA-1; Wed,
 18 Feb 2026 14:31:19 -0500
X-MC-Unique: 3CkXEdiINX6YTHK66hlQRA-1
X-Mimecast-MFC-AGG-ID: 3CkXEdiINX6YTHK66hlQRA_1771443078
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B7050180025A; Wed, 18 Feb 2026 19:31:18 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.65.233])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 65C641800361; Wed, 18 Feb 2026 19:31:17 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 0/2] tests: upgrade to debian 13
Date: Wed, 18 Feb 2026 14:31:14 -0500
Message-ID: <20260218193116.659213-1-jsnow@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This mini-series upgrades everything except mipsel tests to Debian 13,=0D
removing our usage of the EOL Debian 11. Our mipsel tests continue to=0D
run Debian 12, which will be EOL in June.=0D
=0D
This is mostly helpful to me for being able to increase the minimum=0D
version of Python modules like setuptools, pip and wheel as I ran into=0D
while writing=0D
https://patchew.org/QEMU/20260216212952.420120-1-jsnow@redhat.com/=0D
=0D
Tested as part of a larger chain of patches at=0D
https://gitlab.com/jsnow/qemu/-/pipelines/2335060565 - though this=0D
series is based directly on origin/master and I have not tested it=0D
separately at this time.=0D
=0D
John Snow (2):=0D
  tests: upgrade most non-lcitool debian tests to debian 13=0D
  tests: upgrade debian-legacy-test-cross to debian 13=0D
=0D
 .../dockerfiles/debian-hexagon-cross.docker      | 11 ++++++-----=0D
 .../dockerfiles/debian-legacy-test-cross.docker  | 16 +++++-----------=0D
 .../dockerfiles/debian-loongarch-cross.docker    | 10 +++++-----=0D
 tests/docker/dockerfiles/debian-toolchain.docker |  8 +++++---=0D
 .../dockerfiles/debian-tricore-cross.docker      |  5 ++---=0D
 .../dockerfiles/debian-xtensa-cross.docker       |  2 +-=0D
 6 files changed, 24 insertions(+), 28 deletions(-)=0D
=0D
-- =0D
2.53.0=0D
=0D


