Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E41C5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:08:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8eX-00007Q-JG; Wed, 12 Aug 2026 09:05:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8e7-0008Kr-Hv; Wed, 12 Aug 2026 09:05:29 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8e6-0004ei-26; Wed, 12 Aug 2026 09:05:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539783; bh=K0RNsper823VnfRSK1pc37z55ocpHYZxFbBCKIQQOj0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=PCZ6DvaKdWB1sjIgER7IcCyi2C6r1mkQ4lp454YHHWmdNTxzRvyy5nuzcOcTRZzle
 /grbK0QVVCzljOWaKXkJ7cmo8WlHvp11pVeeVYBopEjXEpeZDYZ1XRddsFCU0FB6Mw
 KHdfmjzRjwahmAPumCM7YE1vpqAVad80FSdFXV11YLNZQO/UPQn9I7DgFKJT+0TODG
 cvqD9Rg6oh2mftt7z0XWiBimHrvN4oXcIhip90wuCXDTx5gY8Zvvw4rmeeFO4npbXk
 VUC9Vig7yC7Gm82wI+BpP1oY7mvUMN1xlCvFkf0wczUFS6oJrXpbWL9SFoh+tvrUM9
 C0uHwz2b04VCg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8C9E01CA49A;
 Wed, 12 Aug 2026 16:03:03 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id C1A08409B7D;
 Wed, 12 Aug 2026 16:03:14 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 12C4B2F8CA; Wed, 12 Aug 2026 16:02:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 027/102] ui/vnc: remove redundant rows computation
Date: Wed, 12 Aug 2026 16:01:02 +0300
Message-ID: <20260812130233.621965-27-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

"rows" was already computed in an earlier commit 3543c2b855 ("ui/vnc:
fix OOB write in vnc_refresh_lossy_rect").
(Mjt: in 10.0.x this is commit 5ab666fda9d)

Fixes: e650e4fe0f ("ui/vnc: fix out-of-bounds write in lossy refresh dirty marking")
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
(cherry picked from commit efa7244b2a0bd5e40ec334dbec4a09af0134d91f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/ui/vnc.c b/ui/vnc.c
index 8be69754e0e..ac03d42b32b 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3005,7 +3005,6 @@ static int vnc_refresh_lossy_rect(VncDisplay *vd, int x, int y,
 
     y = QEMU_ALIGN_DOWN(y, VNC_STAT_RECT);
     x = QEMU_ALIGN_DOWN(x, VNC_STAT_RECT);
-    rows = MIN(VNC_STAT_RECT, height - y);
 
     rows = MIN(VNC_STAT_RECT, height - y);
     if (rows <= 0) {
-- 
2.47.3


