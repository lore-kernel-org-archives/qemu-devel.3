Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA94AC36000
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 13:20:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tutK5-0008PZ-QF; Wed, 19 Mar 2025 09:19:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tutK2-0008PO-D0
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 09:19:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tutK0-0007aW-JH
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 09:19:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742390339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZM0rgxSQS+ogyTV5QnciGipQzIM0uYNUrOFSayUURpk=;
 b=VkBfA7nhRmpFb/7FNPIsQDUMgCCTFzN/yI+JsF0Ad2sHv5TnaoP5DkHGjmUr0AIviCWW3S
 rLrAYb359BUKBj0yYDSIM6E2LmGqP6bmaUqu367NSO2fNCzGbBhrwakBq2NaaqU8cTtYnX
 q0kxIjzy9Zwr2nK3IZ7k7WIaoF9GULM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-iOlz0SkEPo6Rd-wFxBy72Q-1; Wed,
 19 Mar 2025 09:18:58 -0400
X-MC-Unique: iOlz0SkEPo6Rd-wFxBy72Q-1
X-Mimecast-MFC-AGG-ID: iOlz0SkEPo6Rd-wFxBy72Q_1742390337
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 537861801A07
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 13:18:57 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.212])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3BC3D3001D0E; Wed, 19 Mar 2025 13:18:53 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 0/8] Functional and s390x patches for v10.0-rc1
Date: Wed, 19 Mar 2025 14:18:43 +0100
Message-ID: <20250319131851.148817-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

 Hi Stefan!

The following changes since commit 1dae461a913f9da88df05de6e2020d3134356f2e:

  Update version for v10.0.0-rc0 release (2025-03-18 10:18:14 -0400)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2025-03-19

for you to fetch changes up to f700abbbeb6ab68a3446d1fb168a934d6f284eb5:

  tests/functional/test_migration: Use "ncat" instead of "nc" in the exec test (2025-03-19 13:28:34 +0100)

----------------------------------------------------------------
* Fix linking problem when CONFIG_VIRTIO_PCI is not set for s390x
* Update functional tests parts of the documenation
* Some minor fixes for functional tests

----------------------------------------------------------------
Daniel P. Berrangé (1):
      tests/functional: remove all class level fields

Niek Linnenbank (1):
      tests/functional/test_arm_orangepi: rename test class to 'OrangePiMachine'

Thomas Huth (6):
      hw/virtio: Also include md stubs in case CONFIG_VIRTIO_PCI is not set
      docs/system: Use the meson binary from the pyvenv
      docs/system/arm: Use "functional tests" instead of "integration tests"
      docs/devel/testing/functional: Add a section about logging
      tests/functional/test_x86_64_kvm_xen: Remove avocado tags
      tests/functional/test_migration: Use "ncat" instead of "nc" in the exec test

 docs/devel/testing/functional.rst       | 22 ++++++++++++++++++++--
 docs/system/arm/bananapi_m2u.rst        |  8 ++++----
 docs/system/arm/orangepi.rst            |  8 ++++----
 docs/system/devices/igb.rst             |  5 +++--
 hw/virtio/meson.build                   |  3 ++-
 tests/functional/qemu_test/testcase.py  |  6 ------
 tests/functional/test_acpi_bits.py      |  1 -
 tests/functional/test_arm_orangepi.py   |  2 +-
 tests/functional/test_migration.py      |  7 +++----
 tests/functional/test_x86_64_kvm_xen.py | 28 ----------------------------
 10 files changed, 37 insertions(+), 53 deletions(-)


