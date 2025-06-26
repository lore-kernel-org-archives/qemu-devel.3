Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD42C77B7F
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 05:55:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUfZ5-0003us-Fs; Thu, 26 Jun 2025 01:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uUfYp-0003s8-GQ
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 01:54:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uUfYg-00015g-VD
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 01:54:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750917241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MNZUOdZ+jKwE+wLuOTNqCTlalWYEgbu8QtolA3b0XAU=;
 b=bmxNtoYaQVJf6yGTFCe0HaXdrSW9QwDHDlePi/56ueMf8m2fcClV5UkaNb1jzcVGLw+191
 GmzLda/RGL4fHcksayNYFhuhCkK+UmyMaS7SUXxodko0mxAH7iFEIcenUSpfFOYPc5OkZK
 nKRGA1uybVqBex2g1A+Fq5J6dr6WAPo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-25MsUw7uNSyhQdM4lihoHQ-1; Thu,
 26 Jun 2025 01:53:55 -0400
X-MC-Unique: 25MsUw7uNSyhQdM4lihoHQ-1
X-Mimecast-MFC-AGG-ID: 25MsUw7uNSyhQdM4lihoHQ_1750917234
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1E9331808993
 for <qemu-devel@nongnu.org>; Thu, 26 Jun 2025 05:53:54 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.129])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8E39519560A3; Thu, 26 Jun 2025 05:53:52 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 00/19] s390x and misc patches
Date: Thu, 26 Jun 2025 07:53:31 +0200
Message-ID: <20250626055350.218271-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The following changes since commit f9a3def17b2a57679902c33064cf7853263db0ef:

  Merge tag 'pull-tcg-20250623' of https://gitlab.com/rth7680/qemu into staging (2025-06-24 10:38:38 -0400)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2025-06-26

for you to fetch changes up to fd68168e0af14546117705176ace84d2c6c52416:

  target/i386/emulate: replace FSF postal address with licenses URL (2025-06-26 00:42:37 +0200)

----------------------------------------------------------------
* Implement the "Control Program Identification" feature on s390x
* Fix memory leak in loadparm setter on s390x
* Update OpenBSD image to 7.7
* Replace the invalid address of the Free Software Foundation
* Some updates to the MAINTAINERS file

----------------------------------------------------------------
Haseung Bong (1):
      tests/vm: update openbsd image to 7.7

Kevin Wolf (1):
      hw/s390x/ccw-device: Fix memory leak in loadparm setter

Matthew Rosato (1):
      MAINTAINERS: add reviewers for some s390 areas

Sean Wei (11):
      COPYING: replace FSF postal address with licenses URL
      libdecnumber: replace FSF postal address with licenses URL
      include/libdecnumber: replace FSF postal address with licenses URL
      include/hw: replace FSF postal address with licenses URL
      include/qemu: replace FSF postal address with licenses URL
      util/rcu.c: replace FSF postal address with licenses URL
      hw: replace FSF postal address with licenses URL
      scripts: replace FSF postal address with licenses URL
      contrib: replace FSF postal address with licenses URL
      target/xtensa: replace FSF postal address with licenses URL
      target/i386/emulate: replace FSF postal address with licenses URL

Shalini Chellathurai Saroja (3):
      hw/s390x: add SCLP event type CPI
      hw/s390x: add Control-Program Identification to QOM
      hw/s390x: support migration of CPI data

Thomas Huth (1):
      tests/functional/test_pc_cpu_hotplug_props: Set 'pc' machine type explicitly

Yoshinori Sato (1):
      MAINTAINERS: Yoshinori Sato email address has been updated

 MAINTAINERS                                    |  24 ++-
 hw/net/vmxnet3.h                               |   4 +-
 hw/scsi/vmw_pvscsi.h                           |   4 +-
 include/hw/i2c/aspeed_i2c.h                    |   3 +-
 include/hw/pci/pci_bridge.h                    |   4 +-
 include/hw/s390x/event-facility.h              |  17 ++
 include/hw/s390x/s390-virtio-ccw.h             |   1 +
 include/hw/timer/aspeed_timer.h                |   3 +-
 include/libdecnumber/dconfig.h                 |   5 +-
 include/libdecnumber/decContext.h              |   5 +-
 include/libdecnumber/decDPD.h                  |   5 +-
 include/libdecnumber/decNumber.h               |   5 +-
 include/libdecnumber/decNumberLocal.h          |   5 +-
 include/libdecnumber/dpd/decimal128.h          |   5 +-
 include/libdecnumber/dpd/decimal128Local.h     |   5 +-
 include/libdecnumber/dpd/decimal32.h           |   5 +-
 include/libdecnumber/dpd/decimal64.h           |   5 +-
 include/qemu/rcu.h                             |   4 +-
 include/qemu/rcu_queue.h                       |   4 +-
 target/i386/emulate/x86_flags.h                |   4 +-
 contrib/elf2dmp/pdb.c                          |   4 +-
 hw/s390x/ccw-device.c                          |   2 +-
 hw/s390x/event-facility.c                      |   2 +
 hw/s390x/s390-virtio-ccw.c                     |  22 +++
 hw/s390x/sclpcpi.c                             | 212 +++++++++++++++++++++++++
 libdecnumber/decContext.c                      |   5 +-
 libdecnumber/decNumber.c                       |   5 +-
 libdecnumber/dpd/decimal128.c                  |   5 +-
 libdecnumber/dpd/decimal32.c                   |   5 +-
 libdecnumber/dpd/decimal64.c                   |   5 +-
 target/i386/emulate/x86_emu.c                  |   4 +-
 target/i386/emulate/x86_flags.c                |   4 +-
 util/rcu.c                                     |   4 +-
 target/xtensa/core-dc232b/gdb-config.c.inc     |   5 +-
 target/xtensa/core-dc232b/xtensa-modules.c.inc |   5 +-
 target/xtensa/core-fsf/xtensa-modules.c.inc    |   5 +-
 COPYING                                        |   5 +-
 COPYING.LIB                                    |   5 +-
 hw/s390x/meson.build                           |   1 +
 scripts/device-crash-test                      |   3 +-
 tests/functional/test_pc_cpu_hotplug_props.py  |   1 +
 tests/vm/openbsd                               |   4 +-
 42 files changed, 338 insertions(+), 92 deletions(-)
 create mode 100644 hw/s390x/sclpcpi.c


