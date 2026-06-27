Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA4B9C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2026 08:55:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdOo9-0002p2-6N; Sat, 27 Jun 2026 04:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.eu>) id 1wdOo3-0002nW-Qk
 for qemu-devel@nongnu.org; Sat, 27 Jun 2026 04:54:31 -0400
Received: from mout01.posteo.de ([185.67.36.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.eu>) id 1wdOnz-0005p3-IW
 for qemu-devel@nongnu.org; Sat, 27 Jun 2026 04:54:29 -0400
Received: from submission (posteo.de [185.67.36.169]) 
 by mout01.posteo.de (Postfix) with ESMTPS id EB35D240027
 for <qemu-devel@nongnu.org>; Sat, 27 Jun 2026 10:54:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.eu; s=2017;
 t=1782550460; bh=CEo4kQ+N6oS8j0poL070SYpsRCzJCAoINSdZpGXz7NE=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
 Content-Transfer-Encoding:From;
 b=ij+NlmvUC9Eg4cgTZ6rN05+/RvP7H6o0gga5cr/uuYhDVVdgg5u6YeGEqUqJ+h+sG
 NPMNCQeU0TPIKy9TJnO42QJKf4co4RaOxh+qJOAUScNdfS5RhT0LqY+ZcQDh0Cn3Fv
 NLzwLOLuKneAf+5Rtoz6uhf0e41ueXOR6x860RyGPo/xCo3S+le/9kDLpT70Sop4R2
 jgEWB02JMse5de3eSN1G1hmVAH8sa49jM2XSUV/p/4ZNPlZUCRB4EFzEV3Iqv6g5zw
 w+2KIsFDp3fW58JfOl18YAQmIvj0sfGshdEOwzglJPKusqoiBDCKUR2465hKckVQ9H
 qyX3oR3nlFNYQ==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4gnRDX0d1Tz6v15;
 Sat, 27 Jun 2026 10:54:19 +0200 (CEST)
From: Thomas Huth <th.huth@posteo.eu>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PULL SUBSYSTEM pseries v2 0/1] pseries: Update SLOF firmware image
 to release 20260627
Date: Sat, 27 Jun 2026 08:54:20 +0000
Message-ID: <20260627085403.150935-1-th.huth@posteo.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.67.36.65; envelope-from=th.huth@posteo.eu;
 helo=mout01.posteo.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

 Hi Harsh!

The following changes since commit 8f1d3b586f1265023f75ea9c227c35d463321aef:

  Merge tag 'pbouvier/pr/ci-20260625' of https://gitlab.com/p-b-o/qemu into staging (2026-06-26 07:58:03 -0400)

are available in the Git repository at:

  https://gitlab.com/huth/qemu.git tags/qemu-slof-20260627

for you to fetch changes up to 6371bc6d30457eb7010b56ad1322c9db14a7de64:

  pseries: Update SLOF firmware image to release 20260627 (2026-06-27 10:45:19 +0200)

Note: this is not for master, this is for pseries

----------------------------------------------------------------
* Fix parsing of ELF program headers

v2: Update roms/SLOF and use a proper release string in the binary
----------------------------------------------------------------
Thomas Huth (1):
      pseries: Update SLOF firmware image to release 20260627

 pc-bios/README   |   2 +-
 pc-bios/slof.bin | Bin 994176 -> 997576 bytes
 roms/SLOF        |   2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)

