Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 780EED78326
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:57:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6v2-0000qW-47; Mon, 02 Dec 2024 08:56:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tI6uz-0000pR-S8
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:56:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tI6uv-0001JW-Ov
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:56:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733147805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gxSgLFn1ndKCj/rkfxXTQt0pZ1a6VfrR8jSChedadXY=;
 b=JDR/b2oL5byi0idryPDYYtfpdZIHn5AeHLKMtw/dZg2mOCiy7XybKTqhhpvyw+zonnx47Q
 tKyeYhNLKUOsS4NqQG8/8odpeJT93XTSh5re1dWcxbRoC73HCX0tKZhlgOlq6DX0i2+cs2
 gzv6Z9w8b+uGuGjsVP017Nj/h4SaJuo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-475-XbReJXnjM7Ktv7N80xlncQ-1; Mon,
 02 Dec 2024 08:56:43 -0500
X-MC-Unique: XbReJXnjM7Ktv7N80xlncQ-1
X-Mimecast-MFC-AGG-ID: XbReJXnjM7Ktv7N80xlncQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E5B2B1944DDA; Mon,  2 Dec 2024 13:56:42 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-206.str.redhat.com
 [10.33.192.206])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E7DDB1956089; Mon,  2 Dec 2024 13:56:41 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 0/3] Functional test fixes for v9.2.0-rc3
Date: Mon,  2 Dec 2024 14:56:37 +0100
Message-ID: <20241202135640.80528-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

 Hi Peter!

The following changes since commit 72b88908d12ee9347d13539c7dd9a252625158d1:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-11-29 10:09:05 +0000)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2024-12-02

for you to fetch changes up to 92ee59bf56ba42954166e56ab112afe10f3c7556:

  tests/functional: increase timeouts for arm sx1 test (2024-12-02 14:53:40 +0100)

----------------------------------------------------------------
* Fix timeouts in arm-sx1 test
* Check for the "pc" machine in the virtio_version and acpi-bits tests

----------------------------------------------------------------
Daniel P. Berrangé (1):
      tests/functional: increase timeouts for arm sx1 test

Thomas Huth (2):
      tests/functional/test_acpi_bits: Turn the test into a QemuSystemTest
      tests/functional/test_virtio_version: Check for the availability of the machine

 tests/functional/test_acpi_bits.py      | 9 +++++----
 tests/functional/test_arm_sx1.py        | 6 +++---
 tests/functional/test_virtio_version.py | 2 ++
 3 files changed, 10 insertions(+), 7 deletions(-)


