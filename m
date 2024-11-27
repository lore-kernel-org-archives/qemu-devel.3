Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D523D609D0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 10:35:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGFNc-0004l1-Jd; Wed, 27 Nov 2024 05:34:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tGFNW-0004kb-7j
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 05:34:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tGFNT-0000Zd-HU
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 05:34:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732703672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EfhdafdlHmvij+yhUI1HTHmQggoQprGKqI0VVfhW72o=;
 b=S2MRsucv21Rclj6rBrgp+U/0nHUA+9u2JYJQfYt58rgbNZYw1/tlBcWZ6j3adP1P1ABosG
 /+z2w0dUqWRPH68mRJEQAI/2IwJEQso4A6GoDa2fLVGtmz7oN29o6AQBxGy895w8HWtd+o
 xGRZJpC7UDONv1NtnxmaMyk3bIZygi8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-573-iiUGxVLoP4q_0ITNY4ZzXA-1; Wed,
 27 Nov 2024 05:34:28 -0500
X-MC-Unique: iiUGxVLoP4q_0ITNY4ZzXA-1
X-Mimecast-MFC-AGG-ID: iiUGxVLoP4q_0ITNY4ZzXA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D7E3619541AE; Wed, 27 Nov 2024 10:34:27 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.82])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CE56A1956054; Wed, 27 Nov 2024 10:34:26 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 0/7] Misc fixes for QEMU 9.2-rc3
Date: Wed, 27 Nov 2024 11:34:18 +0100
Message-ID: <20241127103425.378289-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.931,
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

The following changes since commit 7872e5fdf38ac0d8d0083aabb98d67da1f530ef4:

  Update version for v9.2.0-rc2 release (2024-11-26 22:26:38 +0000)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2024-11-27

for you to fetch changes up to ef45f46f382a5e2c41c39c71fd3364cff4f41bf5:

  hw/pci: Remove unused pci_irq_pulse() method (2024-11-27 09:34:08 +0100)

----------------------------------------------------------------
* Two small doc updates
* Fix the flaky loongarch64 and sh4 functional tests
* Refuse to compile with old XCode versions that don't work anymore
* Remove an unused function from PCI code

----------------------------------------------------------------
Akihiko Odaki (1):
      docs: Document that hvf on Arm is supported

Cédric Le Goater (1):
      tests/functional: Remove sleep workarounds from sh4 test

Philippe Mathieu-Daudé (1):
      hw/pci: Remove unused pci_irq_pulse() method

Thomas Huth (3):
      docs/devel/testing/functional: Clarify that we have to use the build folder
      meson.build: Refuse XCode versions < v15.0
      .gitlab-ci.d/cirrus: Remove the wrong CPU and RAM settings from the macOS job

Xianglai Li (1):
      tests/functional: Fix the running test case causes loongarch64 to hang

 docs/about/build-platforms.rst            |  2 +-
 docs/devel/testing/functional.rst         |  5 +++--
 meson.build                               |  6 +++---
 include/hw/pci/pci.h                      | 10 ----------
 .gitlab-ci.d/cirrus.yml                   |  2 --
 tests/functional/test_loongarch64_virt.py |  8 ++++----
 tests/functional/test_sh4_tuxrun.py       | 10 +++-------
 7 files changed, 14 insertions(+), 29 deletions(-)


