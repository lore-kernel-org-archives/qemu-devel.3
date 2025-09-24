Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D52CCAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 12:45:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1OrK-0007qO-5g; Wed, 24 Sep 2025 08:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v1OrE-0007pR-9W
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 08:44:28 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v1Or4-0004Nx-RQ
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 08:44:27 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cf2d:0:640:140f:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 6C197807E4;
 Wed, 24 Sep 2025 15:44:10 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b6c::1:2c])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 8iXHSd0Fn8c0-GvFCslqN; Wed, 24 Sep 2025 15:44:09 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1758717849;
 bh=bGnUipd7PC8iu1gIgR1GwdXtelFxIUyoslMVOb1vDlY=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=H6VcLUAKY7p/KZXAPhLVlJ7yw5a3+/Ki13qiwb7UQ7g5NOlJbsXDCGArdVZ2gXBgJ
 iELoG1axUd3giYi+EJ/vjpJMgWw3qpVJALmv9SGvUaA0jfM0JACEa1mRAS+e/ULtkd
 Lo86CzDRqGFdeSxNMjHC5+cESUAnunX75enGVmPw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: armbru@redhat.com
Cc: qemu-devel@nongnu.org, eblake@redhat.com, jasowang@redhat.com,
 devel@lists.libvirt.org, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 yc-core@yandex-team.ru, vsementsov@yandex-team.ru,
 d-tatianin@yandex-team.ru
Subject: [PATCH 0/2] remove deprecated 'reconnect' options
Date: Wed, 24 Sep 2025 15:44:04 +0300
Message-ID: <20250924124406.320704-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

They were deprecated in 9.2, now we can remove them.
New options to use are reconnect-ms.

Vladimir Sementsov-Ogievskiy (2):
  chardev: remove deprecated 'reconnect' option
  net/stream: remove deprecated 'reconnect' option

 chardev/char-socket.c           | 20 +++-----------------
 chardev/char.c                  |  3 ---
 docs/about/deprecated.rst       | 15 ---------------
 docs/about/removed-features.rst | 22 ++++++++++++++++++++++
 net/stream.c                    | 20 +++++---------------
 qapi/char.json                  | 11 -----------
 qapi/net.json                   | 10 ----------
 7 files changed, 30 insertions(+), 71 deletions(-)

-- 
2.48.1


