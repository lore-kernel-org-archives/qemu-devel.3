Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81F2AC3ABB9
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 09:55:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBsWZ-0002eG-Tu; Mon, 05 May 2025 05:54:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <cdafeda35709ddf8cd982a7eb653c2a5028c8074@kylie.crudebyte.com>)
 id 1uBsWR-0002d3-Q2
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:54:06 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <cdafeda35709ddf8cd982a7eb653c2a5028c8074@kylie.crudebyte.com>)
 id 1uBsWP-0005Aw-Pf
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:54:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:Message-Id:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=drUUw/RVzvIbVSttIX2saBkyr6HVpHTY4POzOc0Ssb0=; b=Yydg4
 2HmMNkWx6387H+EgXvTP6md1Mbxutie8FEup0JdryJBkeEOjmpcCtVb4zdvlTqRM87mN6SPyyuj1W
 bbV9RHXdGE+oLdyvJSHAucPO1XeT9+rpiCqbDlEaCcEhYegVKGoTEbUqcclqQDWn1xOiOZmtYgL26
 PSDnM+WE8lzKz64DrI+U+6jdCHOH4aMu0QZR5EmBSbiOKWIz4WMsHrGAsso0fL6GWwqLQTDCq1/G5
 tCQ1DLUB62egGcB+LEh5zNKrQeLc5nSyZQhBVUMtZmaYQ0P7XnuHofiWUafqrNuvvaWUZizO+U4kN
 Fp8oy5lLawjlMkiSIngWSh1lRtCAwvMel81eSsTo61T+gCqLkeJhqWrIXX9tlHHX1WjtAH3XcfiXP
 Hrnl9Ir8uePWCLGq/UgO0UjdiwUkrlUlTbYuYld6SdQJUgdaosDIm3hJti+3qp7gvxigQLeGPFV9u
 9UEKq4VdQVqmC6TW1RbhEVNd7KAxoRwuyNCutBSu8sby+/JfZu6jTPsSzB00HnGo+/+nkJvC9lLNf
 sRMeuCCWwo0lTjxQIjmi/UjVubwjOQsEKGXy+2cXdr0Yo/F9O1PRP9rKwv0RIu4BKMvr8RD/mFG/F
 kwMNLe7Pl2ZGOnU7S3Y4o+3YDQd2CDUoemL6s/SeNf6j7ReZZPFevQgBA9rODg=;
Message-Id: <cover.1746438650.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 05 May 2025 11:50:51 +0200
Subject: [PULL 0/9] 9p queue 2025-05-05
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=cdafeda35709ddf8cd982a7eb653c2a5028c8074@kylie.crudebyte.com;
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

The following changes since commit 5134cf9b5d3aee4475fe7e1c1c11b093731073cf:

  Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into staging (2025-04-30 13:34:44 -0400)

are available in the Git repository at:

  https://github.com/cschoenebeck/qemu.git tags/pull-9p-20250505

for you to fetch changes up to cdafeda35709ddf8cd982a7eb653c2a5028c8074:

  9pfs: fix 'total_open_fd' decrementation (2025-05-05 11:28:29 +0200)

----------------------------------------------------------------
9pfs changes:

* Fixes for file descriptor reclaiming algorithm (i.e. when running
  towards host's allowed limit of max. open file descriptors).

* Additional fixes on use-after-unlink idiom (i.e. client operations on a
  file descriptor after file has been removed).

----------------------------------------------------------------
Christian Schoenebeck (4):
      9pfs: fix concurrent v9fs_reclaim_fd() calls
      9pfs: fix FD leak and reduce latency of v9fs_reclaim_fd()
      tests/9p: add 'Tsetattr' request to test client
      9pfs: fix 'total_open_fd' decrementation

Greg Kurz (5):
      9pfs: local : Introduce local_fid_fd() helper
      9pfs: Don't use file descriptors in core code
      9pfs: Introduce ftruncate file op
      9pfs: Introduce futimens file op
      tests/9p: Test `Tsetattr` can truncate unlinked file

 fsdev/file-op-9p.h                    |  5 +++
 hw/9pfs/9p-local.c                    | 51 ++++++++++++++++++--------
 hw/9pfs/9p-synth.c                    | 22 ++++++++++++
 hw/9pfs/9p-util.h                     |  1 +
 hw/9pfs/9p.c                          | 68 +++++++++++++++++++++++++++--------
 hw/9pfs/9p.h                          |  1 +
 hw/9pfs/codir.c                       |  7 +++-
 hw/9pfs/cofile.c                      |  7 +++-
 hw/9pfs/cofs.c                        | 37 +++++++++++++++++++
 hw/9pfs/coth.h                        |  4 +++
 tests/qtest/libqos/virtio-9p-client.c | 49 +++++++++++++++++++++++++
 tests/qtest/libqos/virtio-9p-client.h | 34 ++++++++++++++++++
 tests/qtest/virtio-9p-test.c          | 15 ++++++++
 13 files changed, 271 insertions(+), 30 deletions(-)

