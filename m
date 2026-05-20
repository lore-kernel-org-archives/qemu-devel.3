Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1668CCD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 09:14:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPd0L-0004f4-EI; Wed, 20 May 2026 05:14:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wPd0E-0004ej-UQ
 for qemu-devel@nongnu.org; Wed, 20 May 2026 05:14:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wPd09-0005dN-GE
 for qemu-devel@nongnu.org; Wed, 20 May 2026 05:14:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779268443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dwedrlkHU+Ey6Qk79pG9+gC5u4fZC/blN+0FsGQe3KE=;
 b=cUUKeGrYwYg2XBcmOBdKkBraPdQmF8SHRkiWANBVKh4FBeXeGEiscRgjZ/8BmhbK9BFJky
 yoJc4s1wAYHQMRRWwC/A1pxWYuBtis517QvEa2dmAXqQ6Gsv5WqovBxO31DLyZqOJkQ4If
 stOPBaKxGWDmtVsRMjVrv/zwUB/Ja2c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-396-8PfuxzleOxalXSlXCq3iUg-1; Wed,
 20 May 2026 05:13:59 -0400
X-MC-Unique: 8PfuxzleOxalXSlXCq3iUg-1
X-Mimecast-MFC-AGG-ID: 8PfuxzleOxalXSlXCq3iUg_1779268438
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 366BC18005B9; Wed, 20 May 2026 09:13:58 +0000 (UTC)
Received: from berrange.com (unknown [10.44.49.211])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B3DFB1800347; Wed, 20 May 2026 09:13:53 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 John Snow <jsnow@redhat.com>, John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
Subject: [PULL 00/29] Misc next patches
Date: Wed, 20 May 2026 10:13:22 +0100
Message-ID: <20260520091351.1160442-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit e89049b3ba5f1f0468bc0d294173345597514a1b:

  Merge tag 'for-upstream' of https://repo.or.cz/qemu/kevin into staging (2026-05-19 15:23:10 -0400)

are available in the Git repository at:

  https://gitlab.com/berrange/qemu tags/misc-next-pull-request

for you to fetch changes up to 5236113844128157c68ea9230cbb56f2ab485f31:

  qom: drop user_creatable_add_type method (2026-05-20 10:12:38 +0100)

----------------------------------------------------------------
Misc patches for iotests, qom, crypt & io

 * Fix client side anoymous TLS credentials
 * Fix return value semantics for qio_channel_flush
 * Add ID validation of internal QOM constructor
 * Fix ability to create internal QOM objects
   without a parent
 * Merge user creatable object constructor into
   main QOM file
 * Print reason for skipping I/O tests
 * Remove redundant meson suits for I/O tests
 * Add optional suites for many block drivers I/O tests
 * Run I/O tests for 10 block drivers in GitLab CI
 * Fix sudo check for LUKS I/O test
 * Mark I/O test 185 as flaky
 * Fix vfio-user iothread ID to be well-formed

----------------------------------------------------------------

Daniel P. Berrangé (27):
  crypto: fix client side anonymous TLS credentials
  gitlab: ensure all meson jobs capture build/meson-logs by default
  iotests: print reason when I/O test is skipped in TAP mode
  iotests: remove redundant meson suite for iotests
  iotests: ensure all qcow2 I/O tests are able to be run via make
  scripts/mtest2make: ensure output has stable sorting
  scripts/mtest2make: support optional tests grouping
  iotests: add a meson suite / make target per block I/O tests format
  docs/devel/testing: expand documentation for 'make check-block'
  iotests: add nbd and luks to the I/O test suites
  iotests: use 'driver' as collective term for either format or protocol
  iotests: validate dmsetup result in test 128
  iotests: fix check for sudo access in LUKS I/O test
  iotests: mark 185 as a flaky test
  gitlab: add jobs for thorough block tests
  gitlab: remove I/O tests from build-tcg-disabled job
  qom: add trace events for object/property lifecycle
  hw/vfio-user: use a valid object ID for iothread
  qom: validate ID format when creating objects
  qom: make errp last param in methods taking va_list
  qom: shorten name of object_set_properties_from_keyval
  qom: have object_set_props_keyval return bool
  qom: move object_set_prop_keyval into object.c
  qom: add object_new_with_props_from_qdict
  qom: fix ability to create objects without a parent
  qom: allow object_new_with_prop* to trigger module loading
  qom: drop user_creatable_add_type method

John Snow (1):
  python: bump qemu.qmp to v0.0.6

Tejus GK (1):
  io: invert the return semantics of qio_channel_flush

 .gitlab-ci.d/buildtest-template.yml           |  30 ++-
 .gitlab-ci.d/buildtest.yml                    |  27 +-
 authz/listfile.c                              |   4 +-
 crypto/tlscredsanon.c                         |   2 +
 docs/devel/testing/main.rst                   |  26 +-
 hw/vfio-user/proxy.c                          |   2 +-
 include/io/channel-socket.h                   |   6 +-
 include/io/channel.h                          |   4 +-
 include/qom/object.h                          | 121 +++++++--
 include/qom/object_interfaces.h               |  18 --
 io/channel-socket.c                           |  16 +-
 python/scripts/vendor.py                      |   4 +-
 ...ny.whl => qemu_qmp-0.0.6-py3-none-any.whl} | Bin 72263 -> 72379 bytes
 pythondeps.toml                               |   2 +-
 qom/object.c                                  | 230 ++++++++++++++++--
 qom/object_interfaces.c                       | 101 +-------
 qom/trace-events                              |  12 +-
 scripts/mtest2make.py                         |  30 ++-
 system/qdev-monitor.c                         |   4 +-
 system/vl.c                                   |   7 +-
 tests/Makefile.include                        |   3 +-
 tests/qemu-iotests/128                        |   6 +
 tests/qemu-iotests/149                        |  13 +-
 tests/qemu-iotests/185                        |   1 +
 tests/qemu-iotests/common.rc                  |  16 ++
 tests/qemu-iotests/meson.build                |  65 ++++-
 tests/qemu-iotests/testrunner.py              |   2 +-
 tests/unit/check-qom-proplist.c               |  97 ++++++--
 tests/unit/test-crypto-tlssession.c           | 120 ++++++++-
 29 files changed, 713 insertions(+), 256 deletions(-)
 rename python/wheels/{qemu_qmp-0.0.5-py3-none-any.whl => qemu_qmp-0.0.6-py3-none-any.whl} (64%)

-- 
2.54.0


