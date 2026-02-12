Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F3D9EB48E6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 08:50:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqSOL-0001ZD-LO; Thu, 12 Feb 2026 03:49:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vqSOJ-0001Yx-Bv
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 03:49:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vqSOG-0001LU-R4
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 03:49:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770886175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=QDIGBw07EU/nFmEsfjnoJVbMw43xcD7aqTsQI2A5pYs=;
 b=gsMmYUgjDOppxdGD5xbe86Cntrw2JXnSv/25sT3nUIDcJHuOnhwyyxr2o7No55qWH+CoX7
 wLJj9+bUWX/CaP0BviUaOS9NgkK4joOOnpK1QETjfAcXHWlxHCcKlEsSeEi7KW/roleWO/
 ZWMcTdXgRI7TUwGi1FdveFaOxWo3o4Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-F5fuFkWHN3KRJXy693XWLw-1; Thu,
 12 Feb 2026 03:49:32 -0500
X-MC-Unique: F5fuFkWHN3KRJXy693XWLw-1
X-Mimecast-MFC-AGG-ID: F5fuFkWHN3KRJXy693XWLw_1770886171
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F4421955D8F; Thu, 12 Feb 2026 08:49:31 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.225.23])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BC9DC30001B9; Thu, 12 Feb 2026 08:49:29 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: [PULL 00/14] Misc patches (s390x, tests, python, docs, ...)
Date: Thu, 12 Feb 2026 09:49:13 +0100
Message-ID: <20260212084927.258642-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

 Hi Peter!

The following changes since commit 0b91040d23dc8820724a60c811223b777f3bc6b7:

  Merge tag 'pull-loongarch-20260210' of https://github.com/gaosong715/qemu into staging (2026-02-10 09:12:38 +0000)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2026-02-12

for you to fetch changes up to 34a56f7a4458be1a8c419994d802ea4f68abbfe6:

  hw/i386/pc.c: add description for fd-bootchk option (2026-02-12 09:40:55 +0100)

----------------------------------------------------------------
* Updates to MAINTAINERS file
* Fix CI (broken pkg_resources in python, revert RCU change to fix alpha test)
* Fix endianness issue in PCI code on s390x
* Implement DIVIDE TO INTEGER instruction for s390x TCG emulation
* Bitesized documentation updates (run-tcg-tests target and fd-bootchk property)

----------------------------------------------------------------
Choon Keong (2):
      tests/Makefile.include: add run-tcg-tests-TARGET to check-help
      hw/i386/pc.c: add description for fd-bootchk option

Eric Farman (1):
      MAINTAINERS: Replace backup for s390 PCI

Ilya Leoshkevich (5):
      target/s390x: Dump Floating-Point-Control Register
      target/s390x: Extract s390_get_bfp_rounding_mode()
      fpu: Restrict parts_round_to_int_normal to target precision
      target/s390x: Implement DIVIDE TO INTEGER
      tests/tcg/s390x: Test DIVIDE TO INTEGER

Jaehoon Kim (1):
      s390x/pci: Fix endianness for zPCI BAR values.

Raphael Norwitz (1):
      MAINTAINERS: Switch to my NVIDIA email

Thomas Huth (2):
      Revert "rcu: Unify force quiescent state"
      python/setup.py: Drop version checking via pkg_resources

Vladimir Sementsov-Ogievskiy (1):
      virtio-ccw: virtio_ccw_set_guest_notifier(): fix failure path

Yodel Eldar (1):
      tests/.../reverse_debugging: Remove unsatisfiable condition

 MAINTAINERS                           |   5 +-
 include/fpu/softfloat.h               |  11 ++
 target/s390x/helper.h                 |   1 +
 target/s390x/tcg/insn-data.h.inc      |   5 +-
 fpu/softfloat.c                       | 142 ++++++++++++++++++
 hw/i386/pc.c                          |   2 +
 hw/s390x/s390-pci-inst.c              |   2 +-
 hw/s390x/virtio-ccw.c                 |   1 +
 target/s390x/cpu-dump.c               |   1 +
 target/s390x/tcg/fpu_helper.c         | 118 +++++++++++----
 target/s390x/tcg/translate.c          |  26 ++++
 tests/tcg/s390x/divide-to-integer.c   | 265 ++++++++++++++++++++++++++++++++++
 util/rcu.c                            |  79 ++++------
 fpu/softfloat-parts.c.inc             |  12 +-
 python/setup.py                       |   5 +-
 tests/Makefile.include                |  33 +++--
 tests/functional/reverse_debugging.py |   3 -
 tests/tcg/s390x/Makefile.target       |   5 +
 18 files changed, 602 insertions(+), 114 deletions(-)
 create mode 100644 tests/tcg/s390x/divide-to-integer.c


