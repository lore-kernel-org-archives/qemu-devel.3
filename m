Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB4C0CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 10:17:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBUtK-0004A8-Iv; Tue, 29 Sep 2026 06:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1xBUtI-00049u-HO
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:16:52 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1xBUtG-0001e0-5p
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:16:52 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:6522:0:640:3362:0])
 by forwardcorp1d.mail.yandex.net (postfix) with ESMTPS id DF2848086E;
 Tue, 29 Sep 2026 13:16:42 +0300 (MSK)
Received: from dtalexundeer-nx.yandex.net (unknown [2a02:6bf:8080:852::1:36])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp) with
 ESMTPSA id NGf07W1YRSw0-zs5RWZLd; Tue, 29 Sep 2026 13:16:42 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1790677002;
 bh=g2qqngGT8Oz5dfle7W/A7+DWnvAxgYxBDcVtC7Vwc7Y=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=SuXM2j6OK3UaOgL3tdVjYmQ8SS7C5E5XU/pR9A7sceXyXyrI7k/Ee3jwl41omzJzr
 ZwIqwPOzYuG6nwBZKh4kdKFBnm+dyjqa3+J7BhnQItAfVb0R+E9LgowM/6Z1YSIDQ5
 XeD3k/WNxYyzhCAN0GC+MOL2qlg8AUymdeG65jaU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 "yc-core @ yandex-team . ru" <yc-core@yandex-team.ru>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Subject: [PATCH] vhost-user: add missing stub for
 vhost_user_has_protocol_feature()
Date: Tue, 29 Sep 2026 15:16:23 +0500
Message-Id: <20260929101623.1352299-1-dtalexundeer@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=dtalexundeer@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

Currently, building with --disable-vhost-user fails to link when other
vhost backends are enabled: vhost.c calls vhost_user_has_protocol_feature(),
but its implementation is not built.

Add a stub returning false to fix the link error.

Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
---
 hw/virtio/vhost-user-stub.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/virtio/vhost-user-stub.c b/hw/virtio/vhost-user-stub.c
index 45559788dd..9d2e521788 100644
--- a/hw/virtio/vhost-user-stub.c
+++ b/hw/virtio/vhost-user-stub.c
@@ -4,3 +4,8 @@
 void vhost_user_qmp_status(struct vhost_dev *dev, VirtioStatus *status)
 {
 }
+
+bool vhost_user_has_protocol_feature(struct vhost_dev *dev, uint64_t feature)
+{
+    return false;
+}
-- 
2.34.1


