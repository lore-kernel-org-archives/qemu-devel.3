Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30FABFD3770
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 16:19:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvHbB-0005ZN-8w; Wed, 25 Feb 2026 11:18:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vvHb7-0005Yr-8Q
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 11:18:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vvHb5-0005Xv-Po
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 11:18:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772036318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=6BTOniMElvxlKZCOZgyiDqWJqS0vvoYtIPkn+7+7wEk=;
 b=OnSigb/4fF3PDqBUmtHWNkUpLbzTcTEqi+P5bejeI02RgJ5AzEAFQuBZBTgQJl/psvNWmp
 z03yLokypHHgJHVK5o3XEP86JOXzq+9am1jQqYBLpLDt79UfeY1rsTHFmSCAzDB8RlNEQ+
 JDlEgzjOJXDwW+BPbBzI2aQ5sD/Fs2U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-icFaFlEbO_amXNapkSR-rg-1; Wed,
 25 Feb 2026 11:18:34 -0500
X-MC-Unique: icFaFlEbO_amXNapkSR-rg-1
X-Mimecast-MFC-AGG-ID: icFaFlEbO_amXNapkSR-rg_1772036312
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AFF9019560B7; Wed, 25 Feb 2026 16:18:31 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.158])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C29A21800465; Wed, 25 Feb 2026 16:18:25 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: devel@lists.libvirt.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH 0/4] Remove deprecated qemu-system-microblazeel from the build
Date: Wed, 25 Feb 2026 17:18:17 +0100
Message-ID: <20260225161823.1438850-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
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

The qemu-system-microblazeel binary has been marked as deprecated since
two releases, and there were no complaints (as far as I know), so it
should be fine to remove this now. Users can use the qemu-system-microblaze
binary (without the -el suffix) instead that can handle both endiannesses.

Thomas Huth (4):
  tests/functional: Remove the microblazeel test
  tests/qtest: Remove the microblazeel target from the qtests
  gitlab-ci: Remove the microblazeel target from the CI jobs
  Remove the qemu-system-microblazeel target from the build

 MAINTAINERS                                   |  4 +--
 docs/about/deprecated.rst                     | 13 ----------
 docs/about/removed-features.rst               | 14 ++++++++++
 .../devices/microblazeel-softmmu/default.mak  |  6 -----
 configs/targets/microblazeel-softmmu.mak      |  6 -----
 qapi/machine.json                             |  2 +-
 tests/qtest/boot-serial-test.c                |  2 +-
 tests/qtest/machine-none-test.c               |  1 -
 tests/tcg/plugins/syscall.c                   |  1 -
 .gitlab-ci.d/buildtest.yml                    |  6 ++---
 .gitlab-ci.d/cirrus.yml                       |  4 +--
 .gitlab-ci.d/crossbuilds.yml                  |  2 +-
 tests/functional/meson.build                  |  1 -
 .../functional/microblaze/test_s3adsp1800.py  | 23 +++-------------
 tests/functional/microblazeel/meson.build     |  5 ----
 .../microblazeel/test_s3adsp1800.py           | 26 -------------------
 tests/qtest/meson.build                       |  2 --
 17 files changed, 27 insertions(+), 91 deletions(-)
 delete mode 100644 configs/devices/microblazeel-softmmu/default.mak
 delete mode 100644 configs/targets/microblazeel-softmmu.mak
 delete mode 100644 tests/functional/microblazeel/meson.build
 delete mode 100755 tests/functional/microblazeel/test_s3adsp1800.py

-- 
2.53.0


