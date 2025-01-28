Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECEB6C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 21:42:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tctLL-0004c1-Cw; Tue, 28 Jan 2025 16:41:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tctLI-0004be-8A
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 16:41:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tctLG-0008RQ-Om
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 16:41:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738100513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hSJhqbeXD9zbKyqqhYGAQOG/peWfx4J88UGcHCQtZDA=;
 b=HoImNFTpwCNQ0PsG+UdBgQCGcPtO5p/CENTTf8GKMRKUe5Rf1x+9j7IE0PVMgEa5YSico9
 vd1QGQw/77zcNRm/tBeBjLYLqiDGteo2y/nlqxeBZFjp5jlGFVmnBOXHQuw2VLs8yb0srh
 2VBvkcr+jH8yWXhjoYYNtZadiLhyrLQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-iL7aCDAgNk6aPp2_XtkVZg-1; Tue,
 28 Jan 2025 16:41:49 -0500
X-MC-Unique: iL7aCDAgNk6aPp2_XtkVZg-1
X-Mimecast-MFC-AGG-ID: iL7aCDAgNk6aPp2_XtkVZg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 980C219560BA; Tue, 28 Jan 2025 21:41:47 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.63])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E979319560A3; Tue, 28 Jan 2025 21:41:35 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Troy Lee <troy_lee@aspeedtech.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 0/5] tests/functional: Update Aspeed OpenBMC images
Date: Tue, 28 Jan 2025 22:41:00 +0100
Message-ID: <20250128214100.1196243-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hello,

This series updates the OpenBMC firmware images to the latest version
for existing tests and also adds 2 new tests for Aspeed machines which
were not tested before : witherspoon and bletchley.

Thanks,

C.

Cédric Le Goater (5):
  tests/functional: Introduce a new test routine for OpenBMC images
  tests/functional: Update OpenBMC image of palmetto machine
  tests/functional: Update OpenBMC image of romulus machine
  tests/functional: Introduce a witherspoon machine test
  tests/functional: Introduce a bletchley machine test

 tests/functional/aspeed.py                    | 20 +++++++++-------
 tests/functional/meson.build                  |  4 ++++
 tests/functional/test_arm_aspeed_bletchley.py | 24 +++++++++++++++++++
 tests/functional/test_arm_aspeed_palmetto.py  | 12 +++++-----
 tests/functional/test_arm_aspeed_romulus.py   | 12 +++++-----
 .../functional/test_arm_aspeed_witherspoon.py | 24 +++++++++++++++++++
 6 files changed, 75 insertions(+), 21 deletions(-)
 create mode 100755 tests/functional/test_arm_aspeed_bletchley.py
 create mode 100755 tests/functional/test_arm_aspeed_witherspoon.py

-- 
2.48.1


