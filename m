Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7EB6C36009
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 10:36:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqVYn-00011r-JF; Tue, 17 Sep 2024 06:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sqVYj-0000nu-Nw
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 06:35:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sqVYh-0007EF-To
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 06:35:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726569347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=I/kQvYXXNA9PfnVpMRMcO+46aqwkomR8VO9CAsh4dC8=;
 b=L7YKhxUNZ7czQRzVchEOnrVp4dOHYMnsbHGfroT2Vqi4XdvuMUJpqHDMsYrWVfGM372B7K
 TmykO+jh99Ne2GTxUrOMx6oNY5SBlHiigamkja0+tB+I+qzcoQiUUim/2cSsKRuAOTpouN
 ozOQ0JaaEnXBx4N7Fmfq301EbVmarBA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-302-P_94joMKMqWWIVN0Dbpj6w-1; Tue,
 17 Sep 2024 06:35:44 -0400
X-MC-Unique: P_94joMKMqWWIVN0Dbpj6w-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC0481953945; Tue, 17 Sep 2024 10:35:43 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.158])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 49AEA19560A3; Tue, 17 Sep 2024 10:35:41 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 00/17] s390x and test patches
Date: Tue, 17 Sep 2024 12:35:23 +0200
Message-ID: <20240917103540.149144-1-thuth@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

 Hi!

The following changes since commit ea9cdbcf3a0b8d5497cddf87990f1b39d8f3bb0a:

  Merge tag 'hw-misc-20240913' of https://github.com/philmd/qemu into staging (2024-09-15 18:27:40 +0100)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2024-09-17

for you to fetch changes up to 66659fe76d3577b2cc3aa36d3935e3a2e9558e82:

  .gitlab-ci.d/crossbuilds.yml: Force 'make check' to -j2 for cross-i686-tci (2024-09-17 10:53:13 +0200)

----------------------------------------------------------------
* Make all qtest targets work with "--without-default-devices"
* Replace assert(0) and assert(false) in qtests and s390x code
* Enable the device aliases for or1k
* Some other small test improvements

----------------------------------------------------------------
Daniel P. Berrangé (1):
      gitlab: fix logic for changing docker tag on stable branches

Matheus Tavares Bernardino (1):
      docs/fuzz: fix outdated mention to enable-sanitizers

Peter Maydell (1):
      .gitlab-ci.d/crossbuilds.yml: Force 'make check' to -j2 for cross-i686-tci

Philippe Mathieu-Daudé (1):
      system: Sort QEMU_ARCH_VIRTIO_PCI definition

Pierrick Bouvier (5):
      tests/qtest: replace assert(0) with g_assert_not_reached()
      tests/unit: replace assert(0) with g_assert_not_reached()
      include/hw/s390x: replace assert(false) with g_assert_not_reached()
      tests/qtest: replace assert(false) with g_assert_not_reached()
      tests/qtest: remove break after g_assert_not_reached()

Thomas Huth (8):
      tests/qtest/cdrom-test: Improve the machine detection in the cdrom test
      tests/qtest/boot-order-test: Make the machine name mandatory in this test
      tests/qtest/hd-geo-test: Check for availability of "pc" machine before using it
      tests/qtest/meson.build: Add more CONFIG switches checks for the x86 tests
      tests/qtest: Disable numa-test if the default machine is not available
      .gitlab-ci.d/buildtest: Build most targets in the build-without-defaults job
      system: Enable the device aliases for or1k, too
      tests/functional: Move the mips64el fuloong2e test into the thorough category

 docs/devel/testing/fuzzing.rst  |  5 +--
 include/hw/s390x/cpu-topology.h |  2 +-
 system/qdev-monitor.c           | 18 ++++++----
 tests/qtest/boot-order-test.c   |  4 +--
 tests/qtest/cdrom-test.c        | 77 ++++++++++++++++++++++-------------------
 tests/qtest/hd-geo-test.c       | 71 +++++++++++++++++++------------------
 tests/qtest/ipmi-bt-test.c      |  2 +-
 tests/qtest/ipmi-kcs-test.c     |  4 +--
 tests/qtest/migration-helpers.c |  1 -
 tests/qtest/numa-test.c         | 10 +++---
 tests/qtest/rtl8139-test.c      |  2 +-
 tests/unit/test-xs-node.c       |  4 +--
 .gitlab-ci.d/base.yml           |  2 +-
 .gitlab-ci.d/buildtest.yml      |  9 +----
 .gitlab-ci.d/crossbuilds.yml    |  4 +--
 tests/functional/meson.build    |  5 +--
 tests/qtest/meson.build         | 31 +++++++++--------
 17 files changed, 131 insertions(+), 120 deletions(-)


