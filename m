Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C7C6EF06E2
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Feb 2026 10:41:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vp2Db-0003tL-E5; Sun, 08 Feb 2026 05:40:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vp2DZ-0003ry-5J; Sun, 08 Feb 2026 05:40:41 -0500
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vp2DV-0006yf-To; Sun, 08 Feb 2026 05:40:40 -0500
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 98DBC80605;
 Sun, 08 Feb 2026 13:40:33 +0300 (MSK)
Received: from heifetz-lin.yandex-team.ru (unknown [2a02:6bf:8080:d25::1:35])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (smtpcorp/Yandex) with ESMTPSA id WeNYFo1Apa60-Lf0iCb3J; 
 Sun, 08 Feb 2026 13:40:33 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; t=1770547233;
 bh=gDWh/+XCKtt831Uf17PqcbUmy24afzXLJ4ZHWo1hmP4=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=r1UTFurMHnOy0DjO3NAWmPGp+eyJsCzdJotj0NG8ZFMgsoiL6e/X8XICwPGMrK+Fr
 HHIkqi4PWEyp6wnD4ggQ1oZbOfT9H1voJ4XCYoMjP5WuEWeZH7GBy9TRomKpmc5ey7
 ei2bNngUJvSHG6pJ699cSv7ZgRKPlYdCxloTlIKI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.com
From: Sergei Heifetz <heifetz@yandex-team.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
Subject: [PATCH v3 0/4] Fix a few minor issues reported by Coverity
Date: Sun,  8 Feb 2026 15:39:54 +0500
Message-Id: <20260208103958.121455-1-heifetz@yandex-team.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=heifetz@yandex-team.com; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Hi. This patch series fixes several minor issues reported by our local
Coverity installation.

Changes in v3:
- Nothing. I sent the second version of the series without the corresponding 'v2'
  suffix by mistake. I apologise.

Changes in v2:
- Remove assert(block) in system/physmem.c instead of placing it
  before the dereference.

Sergei Heifetz (4):
  migration/savevm.c: reorder usage and assertion of mis->from_src_file
  dump/dump.c: reorder usage and assertion of block
  system/physmem.c: remove useless assertion of block
  hw/usb/core.c: reorder usage and assertion of p->ep

 dump/dump.c        | 2 +-
 hw/usb/core.c      | 2 +-
 migration/savevm.c | 3 ++-
 system/physmem.c   | 2 --
 4 files changed, 4 insertions(+), 5 deletions(-)

-- 
2.34.1


