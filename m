Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E407C44533
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 15:56:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmCpO-000518-C3; Tue, 21 Jul 2026 11:56:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wmCpH-0004xb-9b
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 11:56:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wmCpD-0004xX-Eh
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 11:56:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784649365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=aQko+osKnPe+UN4OtN8mCCXra7lJmxwWQmhE7sp8jkE=;
 b=KZvCRwL4EwhZFRhwBDQpPRzjt+Ce8dDOzQKmFcT3B2o+v9EUW3pfI87PjpweX3wt8f/sFM
 ls5/T5SFLzWyWSK9SENeDsH7LhWxRkql32eDYMfP+4XvWjJcKfapXbeZqQMD44cDC4oFCo
 adPog6HMZooI6t4BGumcja6n73sEKJA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-425-HwZnfj2uMGGFt_4QYdXs9g-1; Tue,
 21 Jul 2026 11:56:01 -0400
X-MC-Unique: HwZnfj2uMGGFt_4QYdXs9g-1
X-Mimecast-MFC-AGG-ID: HwZnfj2uMGGFt_4QYdXs9g_1784649360
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 095FD180ABEB; Tue, 21 Jul 2026 15:56:00 +0000 (UTC)
Received: from berrange.com (unknown [10.44.32.83])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 353871800617; Tue, 21 Jul 2026 15:55:55 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 0/5] Misc patches
Date: Tue, 21 Jul 2026 16:55:49 +0100
Message-ID: <20260721155554.128840-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=berrange@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

The following changes since commit bd6079a7a1d14de0918a7715ef6db85dc32de3bb:

  Merge tag 'next-pull-request' of https://gitlab.com/peterx/qemu into staging (2026-07-20 11:12:38 -0400)

are available in the Git repository at:

  https://gitlab.com/berrange/qemu tags/misc-next-pull-request

for you to fetch changes up to 84a6c5f94b3d3c445c55189d38aca22234054c10:

  get_maintainer: add ability to report Git Lab handle (2026-07-21 16:53:12 +0100)

----------------------------------------------------------------
* Update FreeBSD image to 14.4
* Fix inotify test for FreeBSD 15
* Fix crypt/nettle build option argument handling
* Add tracking & reporting of GitLab account handles for maintainers

----------------------------------------------------------------

Daniel P. Berrangé (3):
  tests/vm: update to FreeBSD 14.4 image
  gitlab: introduce files mapping GitLab accounts to real names
  get_maintainer: add ability to report Git Lab handle

Jessica Clarke (1):
  test-util-filemonitor: Adapt to FreeBSD 15's native inotify semantics

Luc Michel (1):
  meson.build: re-add explicit gcrypt/nettle request check

 .gitlab-map-auto                   | 93 ++++++++++++++++++++++++++++++
 .gitlab-map-manual                 | 18 ++++++
 crypto/cipher.c                    |  2 +-
 crypto/meson.build                 |  2 +-
 meson.build                        | 11 +++-
 scripts/get_maintainer.pl          | 53 +++++++++++++++--
 scripts/gitlab-map-check           | 51 ++++++++++++++++
 scripts/gitlab-map-update          | 45 +++++++++++++++
 tests/unit/test-crypto-block.c     |  3 +-
 tests/unit/test-util-filemonitor.c | 29 +++++++++-
 tests/vm/freebsd                   |  4 +-
 11 files changed, 300 insertions(+), 11 deletions(-)
 create mode 100644 .gitlab-map-auto
 create mode 100644 .gitlab-map-manual
 create mode 100755 scripts/gitlab-map-check
 create mode 100755 scripts/gitlab-map-update

-- 
2.55.0


