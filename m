Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A135EC71134
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 13:03:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPL2t-0003JA-CH; Wed, 11 Jun 2025 08:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uPL2f-0003Ia-8b
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 08:58:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uPL2c-0004M7-QG
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 08:58:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749646732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=adkvbb9n2hLEcf3I5zZT/Z6EmRX5R+Fnz+cUexKHWQk=;
 b=SExamj3JCboOzLabnxbwaf2s4W/oDu31sgEzjKUrR7STAKZWlH1XwtpAGOz7k6C9W8QjrI
 a1sltBHtid6C6Lzi32EPu1LITna0y1gD7iwPueZhuyxU+28nNq4WhVkuAeqjxYnR0BmiN1
 3BZc85p2/IwM6cDycx7RFTX/tZf2okM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-146-JRMNBpZIPpyiWQPp_bqleg-1; Wed,
 11 Jun 2025 08:58:50 -0400
X-MC-Unique: JRMNBpZIPpyiWQPp_bqleg-1
X-Mimecast-MFC-AGG-ID: JRMNBpZIPpyiWQPp_bqleg_1749646729
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 986A119560B2
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 12:58:49 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.174])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 409B91956053; Wed, 11 Jun 2025 12:58:47 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 00/10] Misc patches (functional tests, travis.yml, MAINTAINERS,
 ...)
Date: Wed, 11 Jun 2025 14:58:36 +0200
Message-ID: <20250611125846.125918-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

 Hi Stefan!

The following changes since commit bc98ffdc7577e55ab8373c579c28fe24d600c40f:

  Merge tag 'pull-10.1-maintainer-may-2025-070625-1' of https://gitlab.com/stsquad/qemu into staging (2025-06-07 15:08:55 -0400)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2025-06-11

for you to fetch changes up to 1da0025ecd527c833697822511057f1b93579045:

  scripts/meson-buildoptions: Sort coroutine_backend choices lexicographically (2025-06-11 13:08:31 +0200)

----------------------------------------------------------------
* Remove aarch64 job from travis.yml
* Remove deprecated s390-ccw-virtio-4.1 machine
* Add memlock functional test
* Various other small updates and fixes

----------------------------------------------------------------
Akihiko Odaki (1):
      MAINTAINERS: Update Akihiko Odaki's affiliation

Alexandr Moshkov (2):
      tests/functional: add skipLockedMemoryTest decorator
      tests/functional: add memlock tests

Bernhard Beschow (1):
      scripts/meson-buildoptions: Sort coroutine_backend choices lexicographically

Haseung Bong (1):
      tests/vm/README: fix documentation path in tests/vm/README

Thomas Huth (5):
      travis.yml: Remove the aarch64 job
      hw/s390x/s390-virtio-ccw: Remove the deprecated 4.1 machine type
      tests/functional: Use the 'none' machine for the VNC test
      tests/functional: Speed up the avr_mega2560 test
      MAINTAINERS: Update the paths to the testing documentation files

 MAINTAINERS                              | 31 +++++++------
 hw/s390x/s390-virtio-ccw.c               | 14 ------
 target/s390x/gen-features.c              |  4 --
 .mailmap                                 |  3 +-
 .travis.yml                              | 35 --------------
 scripts/meson-buildoptions.sh            |  2 +-
 tests/functional/meson.build             |  1 +
 tests/functional/qemu_test/__init__.py   |  2 +-
 tests/functional/qemu_test/decorators.py | 18 ++++++++
 tests/functional/test_avr_mega2560.py    | 11 ++---
 tests/functional/test_memlock.py         | 79 ++++++++++++++++++++++++++++++++
 tests/functional/test_vnc.py             |  4 ++
 tests/vm/README                          |  2 +-
 13 files changed, 127 insertions(+), 79 deletions(-)
 create mode 100755 tests/functional/test_memlock.py


