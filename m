Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE2D1C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 09:34:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaA8l-0000iY-FE; Fri, 11 Jul 2025 05:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uaA8g-0000gi-Je
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:33:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uaA8d-00071R-I3
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:33:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752226427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bkv4NeP5lE64MWXBo0u2pU5pRNpOKFSXT64EPRWAGyI=;
 b=M+afNx8dMJ/9pCGsPFiIjJWlRxp7T4oNvK3eb+v4Wh9z4d0W+PecNTmeDRog4di6g/buB+
 mx4+l61DTIPmR58RemXM00FiygdrHJbk0K5/RH6fwE2w5xAhU15a7B865rmktN7QCjaTVB
 6vtKpIJquPpj/0LfX9mbe2F0mGlDKJI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-402-LlvipcsaO_avdZdWYnaCtg-1; Fri,
 11 Jul 2025 05:33:44 -0400
X-MC-Unique: LlvipcsaO_avdZdWYnaCtg-1
X-Mimecast-MFC-AGG-ID: LlvipcsaO_avdZdWYnaCtg_1752226424
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DF8D418011EF
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 09:33:43 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.54])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7DAA919560A3; Fri, 11 Jul 2025 09:33:42 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 00/15] functional tests and s390x patches
Date: Fri, 11 Jul 2025 11:33:25 +0200
Message-ID: <20250711093340.608485-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

 Hi Stefan!

The following changes since commit df6fe2abf2e990f767ce755d426bc439c7bba336:

  Merge tag 'pull-target-arm-20250704' of https://gitlab.com/pm215/qemu into staging (2025-07-07 09:22:41 -0400)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2025-07-11

for you to fetch changes up to 693b3039d77195953e70f008991c80bf9c5b9691:

  target/s390x: Have s390_cpu_halt() not return anything (2025-07-11 10:33:56 +0200)

----------------------------------------------------------------
* s390x: Allow to select different entries when booting via pxelinux.cfg
* Link s390-ccw.img statically
* Fix broken bamboo functional test
* s390x code cleanups and refactorings

----------------------------------------------------------------
Peter Maydell (1):
      hw/s390x/s390-pci-bus.c: Use g_assert_not_reached() in functions taking an ett

Philippe Mathieu-Daudé (5):
      target/s390x/kvm: Use vaddr in find/insert_hw_breakpoint()
      target/s390x/tcg: Use vaddr in s390_probe_access()
      target/s390x: Remove unused s390_cpu_[un]halt() user stubs
      target/s390x: Expose s390_count_running_cpus() method
      target/s390x: Have s390_cpu_halt() not return anything

Sertonix (1):
      pc-bios/s390-ccw: link statically

Thomas Huth (8):
      pc-bios/s390-ccw: Allow to select a different pxelinux.cfg entry via loadparm
      pc-bios/s390-ccw: Allow up to 31 entries for pxelinux.cfg
      pc-bios/s390-ccw: Make get_boot_index() from menu.c global
      pc-bios/s390-ccw: Add a boot menu for booting via pxelinux.cfg
      tests/functional: Add a test for s390x pxelinux.cfg network booting
      pc-bios: Update the s390 bios images with the pxelinux.cfg loadparm changes
      tests/functional: Add dependency to the keymap_targets
      tests/functional/test_ppc_bamboo: Replace broken link with working assets

 MAINTAINERS                             |   1 +
 pc-bios/s390-ccw/s390-ccw.h             |   1 +
 target/s390x/s390x-internal.h           |  13 +---
 hw/s390x/s390-pci-bus.c                 |  26 +++----
 pc-bios/s390-ccw/menu.c                 |   6 +-
 pc-bios/s390-ccw/netmain.c              |  66 ++++++++++++++----
 target/s390x/cpu-system.c               |   6 +-
 target/s390x/helper.c                   |   4 +-
 target/s390x/kvm/kvm.c                  |   4 +-
 target/s390x/tcg/mem_helper.c           |  10 +--
 pc-bios/s390-ccw.img                    | Bin 96000 -> 87824 bytes
 pc-bios/s390-ccw/Makefile               |   2 +-
 tests/functional/meson.build            |   3 +-
 tests/functional/test_ppc_bamboo.py     |  34 +++++----
 tests/functional/test_s390x_pxelinux.py | 119 ++++++++++++++++++++++++++++++++
 15 files changed, 227 insertions(+), 68 deletions(-)
 create mode 100755 tests/functional/test_s390x_pxelinux.py


