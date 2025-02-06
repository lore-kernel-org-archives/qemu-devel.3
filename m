Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F52EC02198
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 16:49:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg53k-0008KM-LC; Thu, 06 Feb 2025 11:49:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bfa7bf02782dbd996201c90f850ca11730041af1@kylie.crudebyte.com>)
 id 1tg53Y-0008JV-V3
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 11:48:49 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bfa7bf02782dbd996201c90f850ca11730041af1@kylie.crudebyte.com>)
 id 1tg53W-0006Cy-Lf
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 11:48:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:Message-Id:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=Qr3w56at5qJ1Gp8o8hIWkMpDLh47TyYeRe74iQHg6u4=; b=whOtj
 O48yzLsRSt0HyqDSNsVMX4ocsLicR6E8I6SRQXodPPjF4WKkv/cTxbRMTViKn7drirJBeIphAAGpR
 PRASO5wLjbuUZyhZzHuPLZYLXP1IWHW+FhJuf6Caf6WMmxIe07awxaPoz+X0Yc6Wda1uLHvGIaUwe
 cRxk7BWEBsRA9R72GbQkfsEOCOT25qBWDXIRYyKYFCrD40zlc2KVndp/wBZF38j2AFoSjC2jYF0DR
 QjxKDKxKp2etPE+X3afdK1qcbKoAVNyViOcPlIcqsclGKSbmvtf9Ia3nJ/1fd1juCa5WOXHzJ7fD6
 5HggSVaVzpiYxjcSPZis4BG8nPhH+vkTQFUVjKiYCir8FrKZixYHPJTOTMXAaC6ZKomhzuax2x1CQ
 JZghWKO4xeEa0Z0vfTptDlnBCyDg/mw+etAqrhYNU3MOGBPqD4AJH2wkB/H6lXUTEd4pNu3I+VTJz
 8UdIDvfAaP5+wPkhokW5dk0ZogqsEN+ED2lbiPHZx26rZnoSdBK3d/IJLolbTGJSilnIFVPPGrWKA
 zBWdvujAq4wur2tqI1j/u+lKi0HSvlT9FBZ7J7oE6nAzwNphsFetH/YHd83nFLtzcKAyodW7V1fYT
 QpIQ9TgOHbhfrIKCo7yz7HpXC886vbGd8nY4oLqw4oIwt1HKj22tojhhin6YWE=;
Message-Id: <cover.1738860115.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Thu, 06 Feb 2025 17:41:56 +0100
Subject: [PULL 0/7] 9p queue 2025-02-06
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>,
    Stefan Hajnoczi <stefanha@redhat.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=bfa7bf02782dbd996201c90f850ca11730041af1@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The following changes since commit d922088eb4ba6bc31a99f17b32cf75e59dd306cd:

  Merge tag 'ui-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2025-02-03 13:42:02 -0500)

are available in the Git repository at:

  https://github.com/cschoenebeck/qemu.git tags/pull-9p-20250206

for you to fetch changes up to bfa7bf02782dbd996201c90f850ca11730041af1:

  MAINTAINERS: Mark me as reviewer only for 9pfs (2025-02-06 17:10:46 +0100)

----------------------------------------------------------------

* Greg Kurz steps back as maintainer of 9pfs.

* Make multidevs=remap default option (instead of multidevs=warn)
  and update documentation related to this option.

* Improve tracing (i.e. usefulness of log output content).

* Add test cases for accessing a directory after removal.

----------------------------------------------------------------
Christian Schoenebeck (6):
      9pfs: improve v9fs_walk() tracing
      9pfs: make multidevs=remap default
      9pfs: improve v9fs_open() tracing
      tests/9p: rename test use_after_unlink -> use_file_after_unlink
      tests/9p: add use_dir_after_unlink test
      tests/9p: extend use_dir_after_unlink test with Treaddir

Greg Kurz (1):
      MAINTAINERS: Mark me as reviewer only for 9pfs

 MAINTAINERS                  |  3 +--
 hw/9pfs/9p-local.c           |  3 +++
 hw/9pfs/9p-util-generic.c    | 50 ++++++++++++++++++++++++++++++++++++++++++++
 hw/9pfs/9p-util.h            |  6 ++++++
 hw/9pfs/9p.c                 | 45 +++++++++++++++++++++++++++++++++------
 hw/9pfs/meson.build          |  1 +
 hw/9pfs/trace-events         |  4 ++--
 qemu-options.hx              | 49 ++++++++++++++++++++++++-------------------
 tests/qtest/virtio-9p-test.c | 50 ++++++++++++++++++++++++++++++++++++++++----
 9 files changed, 175 insertions(+), 36 deletions(-)
 create mode 100644 hw/9pfs/9p-util-generic.c

