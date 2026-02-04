Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1070EE83EE9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 07:59:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnXms-000123-RW; Wed, 04 Feb 2026 02:58:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vnXmq-00010X-B2; Wed, 04 Feb 2026 02:58:56 -0500
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vnXmo-0006MT-BO; Wed, 04 Feb 2026 02:58:56 -0500
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1593:0:640:6beb:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id DE6E5807DB;
 Wed, 04 Feb 2026 10:58:48 +0300 (MSK)
Received: from heifetz-lin.yandex-team.ru (unknown [2a02:6bf:8080:b69::1:1a])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (smtpcorp/Yandex) with ESMTPSA id lwj54n0AFCg0-xXJjXeWx; 
 Wed, 04 Feb 2026 10:58:48 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; t=1770191928;
 bh=fA35rgmlMigxoNzG3ukMMMKYGiyKC0OxaNuYaxygUTE=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=fO3jo3Nu5Lo6yUP+WmksFd/1eFBaKhTieALKqc+wefgzbrrnfxdsxFUMNhGlmPUwx
 Bio0G4RBJ5ySE+S/KzpgBVhxdv4emNEDsSpESvhOO9FfqR0nnVPaIUYIthQzfnKhV+
 InS5M32P2QoiYTFDpiVV4VsMJeAV6EGQJ18gKUOw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.com
From: Sergei Heifetz <heifetz@yandex-team.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org,
	Sergei Heifetz <heifetz@yandex-team.com>
Subject: [PATCH 0/4] Fix a few minor issues reported by Coverity 
Date: Wed,  4 Feb 2026 12:57:50 +0500
Message-Id: <20260204075754.21078-1-heifetz@yandex-team.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=heifetz@yandex-team.com; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi. This patch series fixes several minor issues reported by our local
Coverity installation.

Sergei Heifetz (4):
  migration/savevm.c: reorder usage and assertion of mis->from_src_file
  dump/dump.c: reorder usage and assertion of block
  system/physmem.c: reorder usage and assertion of block
  hw/usb/core.c: reorder usage and assertion of p->ep

 dump/dump.c        | 2 +-
 hw/usb/core.c      | 2 +-
 migration/savevm.c | 3 ++-
 system/physmem.c   | 4 ++--
 4 files changed, 6 insertions(+), 5 deletions(-)

-- 
2.34.1


