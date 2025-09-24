Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 159A2CAC5AE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 06:41:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1JB0-0002VC-70; Wed, 24 Sep 2025 02:40:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v1JAx-0002Ua-L1
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 02:40:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v1JAh-0006hj-IL
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 02:40:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758696007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=QvctvtOOKhapFr6/WqYxgGhqMLMuWcjQvA2OEyQGX8E=;
 b=iGBDyfRpXtixi1SmcpeB6JgHH13JLabx2/UkadNhL7v9Fug3Q02i0sUpVu26324GesI7D0
 +95xbpYomA55SDg99t1OkjPWCQ3L/fwV0mT0p9kyR+CmXFSgDP7h2x0ZBA3udUr9IW0p3G
 DP1XrfniYaySECszonCW4bXgeoC4bUw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-394-NikKt0e3PmKtWrMN1l7JxA-1; Wed,
 24 Sep 2025 02:40:00 -0400
X-MC-Unique: NikKt0e3PmKtWrMN1l7JxA-1
X-Mimecast-MFC-AGG-ID: NikKt0e3PmKtWrMN1l7JxA_1758695999
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3992A1956086; Wed, 24 Sep 2025 06:39:59 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-176.str.redhat.com
 [10.33.192.176])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4BA411955F19; Wed, 24 Sep 2025 06:39:57 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 00/12] Functional test patches
Date: Wed, 24 Sep 2025 08:39:44 +0200
Message-ID: <20250924063956.519792-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

 Hi Richard!

The following changes since commit ab8008b231e758e03c87c1c483c03afdd9c02e19:

  Merge tag 'pull-9p-20250918' of https://github.com/cschoenebeck/qemu into staging (2025-09-19 12:21:35 -0700)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2025-09-24

for you to fetch changes up to 097bbfc5e0ba889ce17106ef941a56111c3de270:

  tests/functional: treat unknown exceptions as transient faults (2025-09-24 08:26:11 +0200)

----------------------------------------------------------------
* New functional tests to check via the vmstate-static-checker.py script
* New functional tests for CD-ROM boot on hppa
* Skip functional tests on more exotic network errors, too
* Fix another issue with htags in the gitlab CI
* Some additional minor fixes to various functional tests

----------------------------------------------------------------
Daniel P. Berrangé (3):
      tests/functional: use self.log for all logging
      tests/functional: retry when seeing ConnectionError exception
      tests/functional: treat unknown exceptions as transient faults

Peter Maydell (1):
      .gitlab-ci.d/buildtest.yml: Unset CI_COMMIT_DESCRIPTION for htags

Thomas Huth (8):
      tests/functional/m68k: Use proper polling in the next-cube test
      tests/functional/s390x/test_pxelinux: Fix warnings from pylint
      tests: Move the old vmstate-static-checker files to tests/data/
      tests/functional: Test whether the vmstate-static-checker script works fine
      tests/data/vmstate-static-checker: Add dump files from QEMU 7.2.17
      tests/functional: Use vmstate-static-checker.py to test data from v7.2
      tests/functional/hppa: Add a CD-ROM boot test for qemu-system-hppa
      tests: Fix "make check-functional" for targets without thorough tests

 MAINTAINERS                                        |    6 +-
 .gitlab-ci.d/buildtest.yml                         |    2 +-
 tests/Makefile.include                             |    3 +
 .../vmstate-static-checker/aarch64/virt-7.2.json   | 2571 +++++++++++++++
 .../vmstate-static-checker}/dump1.json             |    0
 .../vmstate-static-checker}/dump2.json             |    0
 .../data/vmstate-static-checker/m68k/virt-7.2.json | 2936 +++++++++++++++++
 .../vmstate-static-checker/ppc64/pseries-7.2.json  | 1068 +++++++
 .../s390x/s390-ccw-virtio-7.2.json                 |  475 +++
 .../vmstate-static-checker/x86_64/pc-q35-7.2.json  | 3297 ++++++++++++++++++++
 tests/functional/aarch64/meson.build               |    1 +
 tests/functional/aarch64/test_virt.py              |    4 +-
 tests/functional/arm/test_integratorcp.py          |    3 +-
 tests/functional/generic/test_vmstate.py           |   67 +
 tests/functional/hppa/meson.build                  |    4 +
 tests/functional/hppa/test_cdboot.py               |   38 +
 tests/functional/m68k/meson.build                  |    4 +
 tests/functional/m68k/test_nextcube.py             |   17 +-
 tests/functional/mips64el/test_malta.py            |    3 +-
 tests/functional/ppc64/meson.build                 |    1 +
 tests/functional/qemu_test/asset.py                |   10 +-
 tests/functional/replay_kernel.py                  |   16 +-
 tests/functional/s390x/meson.build                 |    4 +
 tests/functional/s390x/test_pxelinux.py            |   25 +-
 tests/functional/x86_64/meson.build                |    4 +-
 tests/functional/x86_64/test_acpi_bits.py          |   31 +-
 tests/functional/x86_64/test_bad_vmstate.py        |   58 +
 27 files changed, 10599 insertions(+), 49 deletions(-)
 create mode 100644 tests/data/vmstate-static-checker/aarch64/virt-7.2.json
 rename tests/{vmstate-static-checker-data => data/vmstate-static-checker}/dump1.json (100%)
 rename tests/{vmstate-static-checker-data => data/vmstate-static-checker}/dump2.json (100%)
 create mode 100644 tests/data/vmstate-static-checker/m68k/virt-7.2.json
 create mode 100644 tests/data/vmstate-static-checker/ppc64/pseries-7.2.json
 create mode 100644 tests/data/vmstate-static-checker/s390x/s390-ccw-virtio-7.2.json
 create mode 100644 tests/data/vmstate-static-checker/x86_64/pc-q35-7.2.json
 create mode 100755 tests/functional/generic/test_vmstate.py
 create mode 100755 tests/functional/hppa/test_cdboot.py
 create mode 100755 tests/functional/x86_64/test_bad_vmstate.py


