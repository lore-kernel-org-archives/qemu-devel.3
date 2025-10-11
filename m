Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA75BCCD184
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Oct 2025 14:00:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7a7J-00067L-V1; Sat, 11 Oct 2025 09:58:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7a7H-00066c-0u
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 09:58:35 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7a76-0004hw-BY
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 09:58:34 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 51F3CC013E;
 Sat, 11 Oct 2025 16:58:04 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a4b::1:3c])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id uvMPBZ1FEOs0-C2SkLvZw; Sat, 11 Oct 2025 16:58:04 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760191084;
 bh=rFXBB96E86A3fQSXCMSSZzegEJGUuPqsnG2ic46PLlc=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=XHSPSoYIppfS4HurSlGNQs4jleTYlhbYRWKTY0d4bVKp7myGfPVJdFpC/p3xBBhHv
 7IeZ3shLA8PksJfxu1njJjBKRIaHp24J78rc6NyEoJc3x997cuIXF7pjuliq14Phco
 kCw8aKJ5/i+YplUPTSaT9Ml4YhPgWx5wEhSj71Cs=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: armbru@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, eblake@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 08/33] qapi/crypto.json: docs: width=70 and two spaces between
 sentences
Date: Sat, 11 Oct 2025 16:56:55 +0300
Message-ID: <20251011135754.294521-15-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251011135754.294521-1-vsementsov@yandex-team.ru>
References: <20251011135754.294521-1-vsementsov@yandex-team.ru>
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 qapi/crypto.json | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/qapi/crypto.json b/qapi/crypto.json
index ab6eda4c2f..72ac718147 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -46,7 +46,8 @@
 #
 # @md5: MD5.  Should not be used in any new code, legacy compat only
 #
-# @sha1: SHA-1.  Should not be used in any new code, legacy compat only
+# @sha1: SHA-1.  Should not be used in any new code, legacy compat
+#     only
 #
 # @sha224: SHA-224.  (since 2.7)
 #
@@ -377,8 +378,8 @@
 #     deactivate all keyslots that match password located in
 #     QCryptoSecret with this ID
 #
-# @iter-time: Optional (for activation only).  Number of milliseconds to
-#     spend in PBKDF passphrase processing for the newly activated
+# @iter-time: Optional (for activation only).  Number of milliseconds
+#     to spend in PBKDF passphrase processing for the newly activated
 #     keyslot.  Currently defaults to 2000.
 #
 # @keyslot: Optional.  ID of the keyslot to activate/deactivate.  For
-- 
2.48.1


