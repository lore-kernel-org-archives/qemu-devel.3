Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1037BCAC5AE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 13:34:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Pcn-0004At-IN; Wed, 24 Sep 2025 09:33:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v1Pcf-00049I-F9
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 09:33:31 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v1PcV-00047T-Gs
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 09:33:29 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id B861CC1029;
 Wed, 24 Sep 2025 16:33:11 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b6c::1:2c])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id AXYn2X0FqeA0-WzNQvIhn; Wed, 24 Sep 2025 16:33:11 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1758720791;
 bh=cdAUYUW6CaGo6OSkpa51udzVT01n/maSNPSGJTWgwAM=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=zK1CsGTgjbJixRfHIy7Bp7g6KsCAcO2s8IL8SrCtSpca2PQqZDtZfGJ02NgaPGn3p
 NOq8OovXEcGBXtGlFJURnNz1hyws34BJnOE2JU8DXseRXw7PgVmLoWPTuKV9dEgsz1
 IvcVuGSWwPqZMUQa63P5bxbaDkploN4dhyCtnO3U=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: armbru@redhat.com
Cc: qemu-devel@nongnu.org, eblake@redhat.com, jasowang@redhat.com,
 devel@lists.libvirt.org, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 yc-core@yandex-team.ru, vsementsov@yandex-team.ru,
 d-tatianin@yandex-team.ru
Subject: [PATCH 0/2] remove deprecated 'reconnect' options
Date: Wed, 24 Sep 2025 16:33:07 +0300
Message-ID: <20250924133309.334631-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

v2: fixup docs and error messages

Vladimir Sementsov-Ogievskiy (2):
  chardev: remove deprecated 'reconnect' option
  net/stream: remove deprecated 'reconnect' option

 chardev/char-socket.c           | 24 +++++-------------------
 chardev/char.c                  |  3 ---
 docs/about/deprecated.rst       | 15 ---------------
 docs/about/removed-features.rst | 22 ++++++++++++++++++++++
 net/stream.c                    | 20 +++++---------------
 qapi/char.json                  | 14 +-------------
 qapi/net.json                   | 13 +------------
 7 files changed, 34 insertions(+), 77 deletions(-)

-- 
2.48.1


