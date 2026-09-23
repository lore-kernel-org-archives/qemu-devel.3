Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80891C982FA
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 07:53:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Hmy-00080d-Q4; Wed, 23 Sep 2026 03:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <fe9e30899ffceef25cf345ec83f76546afca19dd@kylie.crudebyte.com>)
 id 1x9Hmx-00080Q-Px; Wed, 23 Sep 2026 03:53:12 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <fe9e30899ffceef25cf345ec83f76546afca19dd@kylie.crudebyte.com>)
 id 1x9Hmw-0001N0-7r; Wed, 23 Sep 2026 03:53:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:Message-ID:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=zhG9278i1KZTSrz+hP6W4C5Cx4D1bcA1fcpxC1uvVFA=; b=XhnVe
 d+xGVM3I336d46I6rpTyFzG0iij+ETszwK2NO0iC/O2tIAJWNjHDSwP/gpb8PLJ2kqZX9l36a6JB5
 WE78Mp+vFf6jcXrnsMyOvW7gqd+0LCn17asQeJBIT/X5GURaTwWKepYaa9FWfwLaPBmSwMOYO3s59
 SApemvIY+SJpAUi1SOJaXIYYMLAaiVtPLzVxLKkY9tnSoh+QsVurpkiH63EZ6U+afg5xWhl41tVta
 0UbgdhfPTQdiDQ03T5kqrWwZioUAvKsb1UReHriIYeObqb3wYxt186ez7DF8kfUTIencabs/1gaxJ
 BWxW0SUPVX5XVbDhRbyDSSzXgrmP/9+/fCKsQXQPBjIqKXThd5SU3HwY1xUup6CCMiTyOl54UGteb
 yNghfhOdR+i4szYjo5mDRXPaJEOr4azPGvuTSG9xUm5hIEoGnon+iK8Ut6yE0YkXyst2En4x/gQwD
 28KPiYzaJbaWAKjp6pcdbt5ok83envCtB1pQPdTCbTavGOuxY6EcZs4LvQ/RGWlnFVUNQP4STbl41
 AV02cghSVdlafIA3D4SBFhYrI1uhXYv/9SCKGRkYVvbEyyCRz+M5eXfffmTEj3ypjGKY8zKiP8tBr
 wLJ9rlscC6LqBNb9sH4/WdgdhSUYdNKflrDMR714JN3kvRPdZTvSU5dvAcEhms=;
Message-ID: <cover.1790149757.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Wed, 23 Sep 2026 09:49:18 +0200
Subject: [PULL 0/1] 9p queue 2026-09-23
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=fe9e30899ffceef25cf345ec83f76546afca19dd@kylie.crudebyte.com;
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

The following changes since commit 7074591d7954876951f84c15b994a43251d5a3c1:

  Merge tag 'qom-qdev-20260922' of https://gitlab.com/mcayland-ntx/qemu into staging (2026-09-22 07:56:00 -0700)

are available in the Git repository at:

  https://github.com/cschoenebeck/qemu.git tags/pull-9p-20260923

for you to fetch changes up to fe9e30899ffceef25cf345ec83f76546afca19dd:

  hw/9pfs: mutate FID path from main thread only (CVE-2026-93834) (2026-09-23 09:32:15 +0200)

----------------------------------------------------------------
9pfs changes:

- Fix CVE-2026-93834.

----------------------------------------------------------------
Christian Schoenebeck (1):
      hw/9pfs: mutate FID path from main thread only (CVE-2026-93834)

 hw/9pfs/cofile.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

