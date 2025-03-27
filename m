Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2238C3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 08:06:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txiG5-0000O7-Bk; Thu, 27 Mar 2025 04:06:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1txiG4-0000Nu-4y
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 04:06:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1txiG2-00061w-Bw
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 04:06:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743062791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jyrX5+gf0v3ERSESOyhfYHCoU2YcBYbGxw5i9X5uDQQ=;
 b=TVlHq1+REEWj+9jbnaZWvMlJo9ryWqUt2E1QqGx9EXMCmpt3IXKhXDzpB+cEd1HbprbOIk
 j8FUBKEHUC1xlJvwtjVh7bM3gNbQ6S94GT1muuK6g4fTRJveEndHHc/WeSRahlFggue6eF
 r8DtljKQpcWKUJpRAdj1QPirBwLPbrc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-215-SthLBaDrM4SDgl7dD2wL8A-1; Thu,
 27 Mar 2025 04:06:27 -0400
X-MC-Unique: SthLBaDrM4SDgl7dD2wL8A-1
X-Mimecast-MFC-AGG-ID: SthLBaDrM4SDgl7dD2wL8A_1743062786
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B1045180035C
 for <qemu-devel@nongnu.org>; Thu, 27 Mar 2025 08:06:25 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.126])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0EEAF19560AB; Thu, 27 Mar 2025 08:06:23 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 0/6] Functional test fixes for 10.0-rc2
Date: Thu, 27 Mar 2025 09:06:16 +0100
Message-ID: <20250327080622.954388-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit b876e721f1c939f3e83ac85bd3c1c2821e12b3fa:

  Update version for v10.0.0-rc1 release (2025-03-25 13:58:14 -0400)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2025-03-27

for you to fetch changes up to 5a8d024f8d3f55846cb8385b025d795fee4afd35:

  tests/functional/test_vnc: Skip test if VNC support is not available (2025-03-27 08:59:35 +0100)

----------------------------------------------------------------
* Make some functional tests more robust
* Fix a typo in the s390x code

----------------------------------------------------------------
Peter Maydell (1):
      tests/functional/meson.build: Bump arm_aspeed_bletchley timeout

Philippe Mathieu-Daudé (1):
      target/s390x: Fix a typo in s390_cpu_class_init()

Thomas Huth (4):
      tests/functional/test_ppc64_replay: Mark the e500 test as flaky
      tests/functional: Add missing require_netdev('user') statements
      tests/functional/test_aarch64_virt_gpu: Skip if "dbus" display isn't available
      tests/functional/test_vnc: Skip test if VNC support is not available

 MAINTAINERS                                  |  2 +-
 target/s390x/cpu.c                           |  2 +-
 tests/functional/meson.build                 |  2 +-
 tests/functional/test_aarch64_rme_sbsaref.py |  1 +
 tests/functional/test_aarch64_rme_virt.py    |  4 +++-
 tests/functional/test_aarch64_virt_gpu.py    |  2 ++
 tests/functional/test_arm_bpim2u.py          |  2 ++
 tests/functional/test_arm_cubieboard.py      |  2 ++
 tests/functional/test_arm_orangepi.py        |  4 ++++
 tests/functional/test_ppc64_hv.py            |  3 +++
 tests/functional/test_ppc64_replay.py        |  3 ++-
 tests/functional/test_vnc.py                 | 26 ++++++++++++++++++++++----
 tests/functional/test_x86_64_kvm_xen.py      |  1 +
 13 files changed, 45 insertions(+), 9 deletions(-)


