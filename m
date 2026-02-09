Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82EC0EF06FF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 06:51:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpL6q-00045z-6W; Mon, 09 Feb 2026 01:51:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vpL6o-00045q-SY
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 01:50:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vpL6n-0005E8-8Z
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 01:50:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770619855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ov7EivfwJ1KQ52RXosTMF7d6mSRGy2MNGCnc123B6bs=;
 b=iXUzVQsE4wbuT2PLE7/6xCfzy81D8oxmr8oAFGW0cddtCResgFo0oE6DtnUCWb3prj4iFq
 OekVel+DDXbF8K3DxpKSVyWX666UJnD7RcNdIz/QkRewjZOTy9SkNeaKFvzNDEk+Okmh4w
 8/iE+Lrghm2yDa9oAmRtKIFW42ZE1oM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-195-DDsOxO6jNMi-ReOtgC5VfQ-1; Mon,
 09 Feb 2026 01:50:52 -0500
X-MC-Unique: DDsOxO6jNMi-ReOtgC5VfQ-1
X-Mimecast-MFC-AGG-ID: DDsOxO6jNMi-ReOtgC5VfQ_1770619851
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D04C919560A5; Mon,  9 Feb 2026 06:50:50 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.73])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 85A8F1956053; Mon,  9 Feb 2026 06:50:46 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 0/2] tests/functional: Aspeed ARM tests enhancements
Date: Mon,  9 Feb 2026 07:50:42 +0100
Message-ID: <20260209065044.239378-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi,

This allows the functional test suite to run tests in parallel more
effectively and adds a new set of tests using the older Linux 5.15
kernel.

Thanks,

C. 

Cédric Le Goater (2):
  tests/functional: Split Aspeed ARM tests into separate files
  tests/functional: Add SDK tests with Linux 5.15

 tests/functional/arm/meson.build              | 18 ++++--
 tests/functional/arm/test_aspeed_ast1060.py   |  0
 ...00.py => test_aspeed_ast2500_buildroot.py} | 14 -----
 .../functional/arm/test_aspeed_ast2500_sdk.py | 29 +++++++++
 .../arm/test_aspeed_ast2500_sdk_515.py        | 29 +++++++++
 .../arm/test_aspeed_ast2600_buildroot.py      | 41 +------------
 .../arm/test_aspeed_ast2600_buildroot_tpm.py  | 60 +++++++++++++++++++
 .../functional/arm/test_aspeed_ast2600_sdk.py | 15 -----
 .../arm/test_aspeed_ast2600_sdk_515.py        | 29 +++++++++
 .../arm/test_aspeed_ast2600_sdk_otp.py        | 34 +++++++++++
 10 files changed, 196 insertions(+), 73 deletions(-)
 mode change 100644 => 100755 tests/functional/arm/test_aspeed_ast1060.py
 rename tests/functional/arm/{test_aspeed_ast2500.py => test_aspeed_ast2500_buildroot.py} (74%)
 create mode 100755 tests/functional/arm/test_aspeed_ast2500_sdk.py
 create mode 100755 tests/functional/arm/test_aspeed_ast2500_sdk_515.py
 create mode 100755 tests/functional/arm/test_aspeed_ast2600_buildroot_tpm.py
 create mode 100755 tests/functional/arm/test_aspeed_ast2600_sdk_515.py
 create mode 100755 tests/functional/arm/test_aspeed_ast2600_sdk_otp.py

-- 
2.53.0


