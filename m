Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3403C10F16
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 09:14:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1jYg-0002BB-QH; Tue, 30 Apr 2024 05:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1s1jYc-00027o-Fw; Tue, 30 Apr 2024 05:13:50 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1s1jYY-0007r3-B9; Tue, 30 Apr 2024 05:13:50 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:2a2a:0:640:d546:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id D838860C8A;
 Tue, 30 Apr 2024 12:13:38 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:8829::1:3c])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id UDNYMV11IqM0-a7wRbi3z; Tue, 30 Apr 2024 12:13:38 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1714468418;
 bh=pOIEHltlGMdkFjSPIDqctLRSpihrM8IdbznrAsXlSns=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=aVMp+AT5E+zN3QKAek2D5iUdKxde7O2i05fRG9bs6SFjj5TAnXxOos8SrNH1s/YIu
 RvBct8tihz6nmF+h80zxHpe3eC7Hz7HmQSvCgri40q0se05cddZvNB2d1+BP/DRHl/
 t6BWS1yBF1jLldY7D5X/7LWG494eULGQROLoCHbc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 jsnow@redhat.com, f.ebner@proxmox.com,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH] iotests/pylintrc: allow up to 10 similar lines
Date: Tue, 30 Apr 2024 12:13:29 +0300
Message-Id: <20240430091329.2365053-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

We want to have similar QMP objects in different tests. Reworking these
objects to make common parts by calling some helper functions doesn't
seem good. It's a lot more comfortable to see the whole QAPI request in
one place.

So, let's increase the limit, to unblock further commit
"iotests: add backup-discard-source"

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---

Hi all! That's a patch to unblock my PR
"[PULL 0/6] Block jobs patches for 2024-04-29"
  <20240429115157.2260885-1-vsementsov@yandex-team.ru>
  https://patchew.org/QEMU/20240429115157.2260885-1-vsementsov@yandex-team.ru/


 tests/qemu-iotests/pylintrc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/pylintrc b/tests/qemu-iotests/pylintrc
index de2e0c2781..05b75ee59b 100644
--- a/tests/qemu-iotests/pylintrc
+++ b/tests/qemu-iotests/pylintrc
@@ -55,4 +55,4 @@ max-line-length=79
 
 [SIMILARITIES]
 
-min-similarity-lines=6
+min-similarity-lines=10
-- 
2.34.1


