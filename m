Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C11C02182
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 08:03:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taVgZ-0006nS-4e; Wed, 22 Jan 2025 03:02:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1taVgW-0006my-WF
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 03:02:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1taVgV-0004ua-Ai
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 03:02:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737532918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mYNn2hvYIgKFiZDGSFVaBA9xlO2A5kEFRDFVEkvem9k=;
 b=D6VYtqaMgzIEvZx9dAX2kkAnfUf2rVuNGCLbXXZRD/gPU01bodBvvNRY26SL6lyBdeDlu4
 rwUGRzuTlznGlliMdKg8VZz1i+ni4h8/tOX6Lpu2I7m2SuW8AFyTWDkTYy70BCxiihILR4
 uQlw6YsqZ4K/Bb9Y1jR9L4FcWduj8hQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-57-Sr3cDMOOOUKA-TAIGJqJdA-1; Wed,
 22 Jan 2025 03:01:56 -0500
X-MC-Unique: Sr3cDMOOOUKA-TAIGJqJdA-1
X-Mimecast-MFC-AGG-ID: Sr3cDMOOOUKA-TAIGJqJdA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 43EC81955DD0
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 08:01:55 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.246])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BCABD19560A7; Wed, 22 Jan 2025 08:01:53 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL v2 0/9] s390x and test patches 2025-01-21
Date: Wed, 22 Jan 2025 09:01:49 +0100
Message-ID: <20250122080151.1400422-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

The following changes since commit d6430c17d7113d3c38480dc34e59d00b0504e2f7:

  Merge tag 'pull-riscv-to-apply-20250119-1' of https://github.com/alistair23/qemu into staging (2025-01-19 08:55:46 -0500)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2025-01-21v2

for you to fetch changes up to 9744ceb94bf963ed42685c7d28024a77de2fbe78:

  pc-bios: Update the s390 bios images with the recent changes (2025-01-22 08:28:49 +0100)

----------------------------------------------------------------
* Fix bugs related to the new "boot order" feature in the s390-ccw bios
* Fix crash that occurs when introspecting older s390-virtio-ccw machines
* Fix error in pbkdf code on fast machines (e.g. s390x with crypto adapter)
* Convert kvm_xen_guest avocado test to the functional framework

v2: Replace cancel() with skipTest() in the first patch
----------------------------------------------------------------
Daniel P. Berrangé (1):
      crypto: fix bogus error benchmarking pbkdf on fast machines

Jared Rossi (1):
      pc-bios/s390-ccw: Abort IPL on invalid loadparm

Philippe Mathieu-Daudé (1):
      MAINTAINERS: Remove myself as Avocado Framework reviewer

Thomas Huth (6):
      tests/functional: Convert the kvm_xen_guest avocado test
      hw/s390x: Fix crash that occurs when inspecting older versioned machines types
      pc-bios/s390-ccw/virtio: Add a function to reset a virtio device
      pc-bios/s390-ccw: Fix boot problem with virtio-net devices
      pc-bios/s390-ccw/netmain: Fix error messages with regards to the TFTP server
      pc-bios: Update the s390 bios images with the recent changes

 MAINTAINERS                                        |   3 +-
 pc-bios/s390-ccw/virtio.h                          |   2 +
 crypto/pbkdf.c                                     |  15 +++-
 hw/s390x/s390-virtio-ccw.c                         |  15 ++--
 pc-bios/s390-ccw/bootmap.c                         |  15 ++--
 pc-bios/s390-ccw/netmain.c                         |  52 +++++++-----
 pc-bios/s390-ccw/virtio-net.c                      |   5 ++
 pc-bios/s390-ccw/virtio.c                          |   7 +-
 pc-bios/s390-ccw.img                               | Bin 79608 -> 96000 bytes
 tests/functional/meson.build                       |   2 +
 .../test_x86_64_kvm_xen.py}                        |  89 ++++++++++++---------
 11 files changed, 128 insertions(+), 77 deletions(-)
 rename tests/{avocado/kvm_xen_guest.py => functional/test_x86_64_kvm_xen.py} (61%)
 mode change 100644 => 100755


