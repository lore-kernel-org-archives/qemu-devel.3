Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F96ED2AB01
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 09:25:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5iTP-0007Up-F8; Tue, 29 Oct 2024 05:25:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t5iTF-0007UV-Ar
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 05:25:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t5iTD-00041u-Jv
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 05:25:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730193897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=pDqm5tGJHLI99NCJhRksDoPlTzxjaCsSqC+s9KVgds8=;
 b=N1ROIMVNykxVlwkL0W2u9RGRP8yyrjkdByVoTIbhymF0NiEBUT7grC5psUZyl1s4ru1IVM
 nUOMYzp/Ufw/iHKHQ1az0KYtZuDF4Mgt9WoimF6Owap8eYH9fIA+0x8PFjHj2eZ4bdrDhg
 Fuhpa1Ek3izFA+fJS/Y5pNvwLO+gG3s=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-60-oLQzv7XfMcu8y0K0TE0Jkw-1; Tue,
 29 Oct 2024 05:24:50 -0400
X-MC-Unique: oLQzv7XfMcu8y0K0TE0Jkw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 01D171955EA5; Tue, 29 Oct 2024 09:24:47 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.191])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CB61719560AA; Tue, 29 Oct 2024 09:24:42 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Joel Stanley <joel@jms.id.au>
Subject: [PATCH 0/2] Convert the BananaPi and OrangePi Avacodo tests
Date: Tue, 29 Oct 2024 10:24:38 +0100
Message-ID: <20241029092440.25021-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Some of the URLs in the Avocado tests stopped working since the
original assets have been removed from the servers or moved location,
see:

 https://lore.kernel.org/qemu-devel/CACPK8Xc=jsz5iT_WR7s-rcu1cRzryiK+-0o=6vUK_D_qMMrP3A@mail.gmail.com/

Since we are currently in progress of converting the Avocado tests
to the new functional framework, this is a good opportunity to convert
these tests and adjust the URLs (and hashsums) along the way to make
these tests work again.

Thomas Huth (2):
  tests/functional: Convert BananaPi tests to the functional framework
  tests/functional: Convert the OrangePi tests to the functional
    framework

 MAINTAINERS                           |   1 +
 tests/avocado/boot_linux_console.py   | 411 --------------------------
 tests/functional/meson.build          |   4 +
 tests/functional/qemu_test/utils.py   |  21 ++
 tests/functional/test_arm_bpim2u.py   | 206 +++++++++++++
 tests/functional/test_arm_orangepi.py | 270 +++++++++++++++++
 6 files changed, 502 insertions(+), 411 deletions(-)
 create mode 100755 tests/functional/test_arm_bpim2u.py
 create mode 100755 tests/functional/test_arm_orangepi.py

-- 
2.47.0


