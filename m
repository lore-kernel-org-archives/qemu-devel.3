Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04371E9B371
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 12:36:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx2Tj-0004lj-6U; Mon, 02 Mar 2026 07:34:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vx2Th-0004ka-Ob
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 07:34:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vx2Tf-0005y1-W1
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 07:34:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772454861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+BYur7TlNl7TKeRB4p2oZAX0598jmd59YeTQW3LHamk=;
 b=du5agz5egZnyvpI0nlGROI4tj6yaCRkOucVZAQlN/ptAxc/CZw99M6kdzfNUpvCtd8g+L1
 tKWjdEc4eLuJEB6YcAYSNV83IRkuazZU7HKkYuRimFegIMyEmszEZw5tn6+s8nIBcJoQTZ
 2aZCZT42ZTNIhncJuUBUd5fx2oGNnoM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-394-S3aWQGGiPz64Wd4vtc_dFQ-1; Mon,
 02 Mar 2026 07:34:17 -0500
X-MC-Unique: S3aWQGGiPz64Wd4vtc_dFQ-1
X-Mimecast-MFC-AGG-ID: S3aWQGGiPz64Wd4vtc_dFQ_1772454857
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BF0F318002FB; Mon,  2 Mar 2026 12:34:16 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.162])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6E99C1956053; Mon,  2 Mar 2026 12:34:15 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: [PULL 00/10] microblazeel removal, improved docker detection, etc.
Date: Mon,  2 Mar 2026 13:34:03 +0100
Message-ID: <20260302123413.274700-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit ffcf1a7981793973ffbd8100a7c3c6042d02ae23:

  Merge tag 'pull-11.0-testing-updates-270226-2' of https://gitlab.com/stsquad/qemu into staging (2026-02-28 14:30:23 +0000)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2026-03-02

for you to fetch changes up to 424b4b82d53ac26ca3e991b1f85de225cda707ba:

  gitlab: ensure docker output is always displayed in CI (2026-03-02 09:48:10 +0100)

----------------------------------------------------------------
* Remove qemu-system-microblazeel (qemu-system-microblaze can be used instead)
* Improve detection of the docker/podman binary
* Prevent a null pointer dereference during zpci hot unplug

----------------------------------------------------------------
Aby Sam Ross (1):
      s390x/pci: prevent null pointer dereference during zpci hot unplug

Daniel P. Berrangé (4):
      tests/docker: improve handling of docker probes
      tests/docker: add support for podman remote access
      tests/docker: allow display of docker output
      gitlab: ensure docker output is always displayed in CI

Peter Maydell (1):
      tests/functional: Make sure test case .py files are executable

Thomas Huth (4):
      tests/functional: Remove the microblazeel test
      tests/qtest: Remove the microblazeel target from the qtests
      gitlab-ci: Remove the microblazeel target from the CI jobs
      Remove the qemu-system-microblazeel target from the build

 MAINTAINERS                                      |  4 ++--
 docs/about/deprecated.rst                        | 13 ------------
 docs/about/removed-features.rst                  | 14 +++++++++++++
 configure                                        | 19 +++++++----------
 configs/devices/microblazeel-softmmu/default.mak |  6 ------
 configs/targets/microblazeel-softmmu.mak         |  6 ------
 qapi/machine.json                                |  2 +-
 system/arch_init.h                               |  3 +--
 hw/s390x/s390-pci-bus.c                          |  2 +-
 tests/qtest/boot-serial-test.c                   |  2 +-
 tests/qtest/machine-none-test.c                  |  1 -
 .gitlab-ci.d/base.yml                            |  3 +++
 .gitlab-ci.d/buildtest.yml                       |  6 +++---
 .gitlab-ci.d/cirrus.yml                          |  4 ++--
 .gitlab-ci.d/crossbuilds.yml                     |  2 +-
 tests/docker/Makefile.include                    | 25 +++++++++++++++--------
 tests/docker/docker.py                           | 17 +++++++---------
 tests/functional/meson.build                     |  1 -
 tests/functional/microblaze/test_s3adsp1800.py   | 23 +++------------------
 tests/functional/microblazeel/meson.build        |  5 -----
 tests/functional/microblazeel/test_s3adsp1800.py | 26 ------------------------
 tests/qtest/meson.build                          |  2 --
 22 files changed, 62 insertions(+), 124 deletions(-)
 delete mode 100644 configs/devices/microblazeel-softmmu/default.mak
 delete mode 100644 configs/targets/microblazeel-softmmu.mak
 delete mode 100644 tests/functional/microblazeel/meson.build
 delete mode 100755 tests/functional/microblazeel/test_s3adsp1800.py


