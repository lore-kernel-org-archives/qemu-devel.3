Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED7BC0218C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 10:57:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taBw1-0006eN-DO; Tue, 21 Jan 2025 05:56:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1taBvk-0006dU-PI
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 05:56:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1taBvi-00055D-4g
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 05:56:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737456980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MegwuoD/vrK9ur2qBvaJ0BihJMoxdj3s0hTjbgpR8Zw=;
 b=V5THG+v8iuI57LhVIOkw2f4K5CwWjqgfiRQhny9h+m9rREoq43QjXZvO/jdLyKjL+GPUHO
 t0aTjyb0na65h18rH8XxNkhRxTyrFfxiNCPi8WQ6CdytB+9uK/zinP9YjQQE1DXYPOe7fN
 OdiFin7YNNDrM3uJFUgNcEzAnxc0KW4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-14-edwSkK7HOU6hDMJJOs2Kgw-1; Tue,
 21 Jan 2025 05:56:18 -0500
X-MC-Unique: edwSkK7HOU6hDMJJOs2Kgw-1
X-Mimecast-MFC-AGG-ID: edwSkK7HOU6hDMJJOs2Kgw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 07E9B1956059
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 10:56:17 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.56])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8C2A819560B0; Tue, 21 Jan 2025 10:56:15 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 0/9] s390x and test patches 2025-01-21
Date: Tue, 21 Jan 2025 11:56:02 +0100
Message-ID: <20250121105613.1286672-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.036,
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

The following changes since commit 20fac491cfeebb042f59cc61ae76fed1b397d25c:

  Merge tag 'qtest-20250117-pull-request' of https://gitlab.com/farosas/qemu into staging (2025-01-18 18:37:16 -0500)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2025-01-21

for you to fetch changes up to 929efa1955ffc8bdbd79a413e8057cb35c1d9c01:

  pc-bios: Update the s390 bios images with the recent changes (2025-01-21 08:53:50 +0100)

----------------------------------------------------------------
* Fix bugs related to the new "boot order" feature in the s390-ccw bios
* Fix crash that occurs when introspecting older s390-virtio-ccw machines
* Fix error in pbkdf code on fast machines (e.g. s390x with crypto adapter)
* Convert kvm_xen_guest avocado test to the functional framework

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
 pc-bios/s390-ccw/netmain.c                         |  52 +++++++------
 pc-bios/s390-ccw/virtio-net.c                      |   5 ++
 pc-bios/s390-ccw/virtio.c                          |   7 +-
 pc-bios/s390-ccw.img                               | Bin 79608 -> 96000 bytes
 tests/functional/meson.build                       |   2 +
 .../test_x86_64_kvm_xen.py}                        |  83 ++++++++++++---------
 11 files changed, 125 insertions(+), 74 deletions(-)
 rename tests/{avocado/kvm_xen_guest.py => functional/test_x86_64_kvm_xen.py} (64%)
 mode change 100644 => 100755


