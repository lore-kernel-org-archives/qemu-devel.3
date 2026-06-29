Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9404C43602
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:38:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weCBR-0000fe-8S; Mon, 29 Jun 2026 09:37:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <75893c058b21d87d1ec66bbd4e8bf84e1fd616d1@kylie.crudebyte.com>)
 id 1weCBP-0000f4-N6; Mon, 29 Jun 2026 09:37:55 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <75893c058b21d87d1ec66bbd4e8bf84e1fd616d1@kylie.crudebyte.com>)
 id 1weCBO-0003j1-54; Mon, 29 Jun 2026 09:37:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:Message-ID:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=gk0GupwaFHhZm5Es0fllYcuI2CT/UCNdx7u0syNCmNg=; b=WzkHj
 OSl87M8cUydCGsDMmuSi7MxkHmutNeBzUqt4jqR57G1c5T4D8j1l0Dr5I6BiWzNLYSe9Qq8phj8fD
 CVZDzG3P7So0c0m6EyY574VNczL9hSawDbGjdVcQYXtCj09lDs6CzfKTzYRqrN+6SGOnLbQFhz5LK
 ag+xQyau2sJ3J48FJjW0EhRBo8IcQYYUBxEdx8dt7hlBOSK2NK4Zl6X+xamtqkl66JbsxifW7qm5/
 8TSCbEEWYJYilLOQu67kcM1sXBEOVs79/21WACHEmeEBnuN5i3hsb/6Xp1H/ghs0a9N4jkj5LPWZh
 64Z5DulFRBGs9SiWyO9+cKVxWOe3CQACvOZS8ncUZgyOgrduagj8AaKAMQkMg7TAcGoc7D6/j2vv9
 qQFzBPWeMHgB8UnyawlHvsKJOVUhNpIwePrbna43S73MiDRip/be/gmk6POH0RWNT37R55T130H4j
 6YyB1ojZ1KFtDiuHcZa5WzZEQyeU3C5lDGb2bErQmBhequ9sGKgHI1+grYUjN13DDsePsgpd6y0IY
 SYf1Ht2QHwMbZa5NKsUJkZYtqoQtVaN2PC5KksyChQuyTRVsKiqKR+Mgic25DO86W7p5exYF/uglj
 kb69xSJOMRZRwMdQwK3r6z4F5PczEF/T2euyOzXPRjRvzUysrpDx8ZvIrUBR5Y=;
Message-ID: <cover.1782739719.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 29 Jun 2026 15:28:39 +0200
Subject: [PULL 00/23] 9p queue 2026-06-29
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Feifan Qian <bea1e@proton.me>,
 Stefano Stabellini <sstabellini@kernel.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=75893c058b21d87d1ec66bbd4e8bf84e1fd616d1@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 20553466cc47af6a8c95f665b601fce3c852e503:

  Merge tag 'pbouvier/pr/docs-20260626' of https://gitlab.com/p-b-o/qemu into staging (2026-06-27 23:28:35 -0400)

are available in the Git repository at:

  https://github.com/cschoenebeck/qemu.git tags/pull-9p-20260629

for you to fetch changes up to 75893c058b21d87d1ec66bbd4e8bf84e1fd616d1:

  hw/9pfs/local: harden local_fid_fd() on FID types (2026-06-29 15:10:32 +0200)

----------------------------------------------------------------
9pfs changes:

- Fix DoS via Treaddir (CVE-2026-9238).

- Add xattr FID limit (CVE-2026-8348).

- Fix union V9fsFidOpenState type confusion.

----------------------------------------------------------------
Christian Schoenebeck (23):
      hw/9pfs: add msize_limit transport callback
      9pfs/virtio: implement msize_limit callback
      9pfs/xen: implement msize_limit callback
      hw/9pfs: cap negotiated msize to transport limit
      hw/9pfs: add response_buffer_size transport callback
      9pfs/virtio: implement response_buffer_size callback
      9pfs/xen: implement response_buffer_size callback
      hw/9pfs: cap Treaddir allocation (CVE-2026-9238)
      hw/9pfs: add xattr FID limit to prevent memory exhaustion
      hw/9pfs: add max_xattr option
      qemu-options: document 9pfs max_xattr option
      tests/9p: add Tread / Rread test client functions
      tests/9p: add Tclunk / Rclunk test client functions
      tests/9p: add Txattrcreate / Rxattrcreate test client functions
      hw/9pfs: enable xattr (mockup) support for synth fs driver
      hw/9pfs: add xattr count query interface to fs synth driver
      tests/9p: increase P9_MAX_SIZE for test client
      tests/9p: add virtio_9p_add_synth_driver_args() test client function
      tests/9p: add 3 xattr FID limit test cases (synth fs driver)
      tests/9p: add 3 xattr FID limit test cases (local fs driver)
      hw/9pfs: fix invalid union access by v9fs_co_fsync()
      hw/9pfs: fix invalid union access by v9fs_co_fstat()
      hw/9pfs/local: harden local_fid_fd() on FID types

 fsdev/file-op-9p.h                    |  11 ++
 fsdev/qemu-fsdev-opts.c               |   6 +
 fsdev/qemu-fsdev.c                    |   2 +-
 hw/9pfs/9p-local.c                    |  14 +-
 hw/9pfs/9p-synth.c                    |  51 ++++++-
 hw/9pfs/9p.c                          | 113 ++++++++++++++-
 hw/9pfs/9p.h                          |   2 +
 hw/9pfs/virtio-9p-device.c            |  17 +++
 hw/9pfs/xen-9p-backend.c              |  31 ++++
 qemu-options.hx                       |  28 ++--
 system/vl.c                           |   7 +-
 tests/qtest/libqos/virtio-9p-client.c | 124 ++++++++++++++++
 tests/qtest/libqos/virtio-9p-client.h |  88 +++++++++++-
 tests/qtest/libqos/virtio-9p.c        |   6 +
 tests/qtest/libqos/virtio-9p.h        |   6 +
 tests/qtest/virtio-9p-test.c          | 262 +++++++++++++++++++++++++++++++++-
 16 files changed, 746 insertions(+), 22 deletions(-)

