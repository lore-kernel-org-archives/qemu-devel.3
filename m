Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19493CCA476
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Oct 2025 14:26:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7aE3-00054I-4D; Sat, 11 Oct 2025 10:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7aDq-0004g0-2j
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 10:05:23 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7aDe-0005bp-Ff
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 10:05:20 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 064DAC017A;
 Sat, 11 Oct 2025 17:04:55 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a4b::1:3c])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id h4NOTl1FrqM0-zi8stucj; Sat, 11 Oct 2025 17:04:54 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760191494;
 bh=/q6rjoxdfB/1Xm73ZxRH85WAZxNcGltDxx8lvKX3FXI=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=FDfTWdZQSui38uxof+BOHNl52nADjorsZ2yKOaSnMbKwjYP9f1dfjQey/iAfssBj9
 /91IHBY5EAyGB0UpiGzRBMy+bA81Rks69MhVte4hiJ7xBIGYb8DYS1DK1KWT/zOuCY
 s+yTzI6UB2qpv3JUqxCWtDgr/01hxMA8uwp1si2U=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: armbru@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, eblake@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v2 19/33] qapi/qdev.json: docs: width=70 and two spaces
 between sentences
Date: Sat, 11 Oct 2025 17:04:25 +0300
Message-ID: <20251011140441.297246-20-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251011140441.297246-1-vsementsov@yandex-team.ru>
References: <20251011140441.297246-1-vsementsov@yandex-team.ru>
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
 qapi/qdev.json | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/qapi/qdev.json b/qapi/qdev.json
index e14a0c9259..9c4b498319 100644
--- a/qapi/qdev.json
+++ b/qapi/qdev.json
@@ -100,8 +100,8 @@
 #    process is signaled with a `DEVICE_DELETED` event.  Guest reset
 #    will automatically complete removal for all devices.  If a
 #    guest-side error in the hot removal process is detected, the
-#    device will not be removed and a `DEVICE_UNPLUG_GUEST_ERROR` event
-#    is sent.  Some errors cannot be detected.
+#    device will not be removed and a `DEVICE_UNPLUG_GUEST_ERROR`
+#    event is sent.  Some errors cannot be detected.
 #
 # Since: 0.14
 #
@@ -114,7 +114,8 @@
 # .. qmp-example::
 #
 #     -> { "execute": "device_del",
-#          "arguments": { "id": "/machine/peripheral-anon/device[0]" } }
+#          "arguments": {
+#            "id": "/machine/peripheral-anon/device[0]" } }
 #     <- { "return": {} }
 ##
 { 'command': 'device_del', 'data': {'id': 'str'} }
@@ -138,7 +139,8 @@
 #     <- { "event": "DEVICE_DELETED",
 #          "data": { "device": "virtio-net-pci-0",
 #                    "path": "/machine/peripheral/virtio-net-pci-0" },
-#          "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
+#          "timestamp": { "seconds": 1265044230,
+#                         "microseconds": 450486 } }
 ##
 { 'event': 'DEVICE_DELETED',
   'data': { '*device': 'str', 'path': 'str' } }
@@ -160,7 +162,8 @@
 #     <- { "event": "DEVICE_UNPLUG_GUEST_ERROR",
 #          "data": { "device": "core1",
 #                    "path": "/machine/peripheral/core1" },
-#          "timestamp": { "seconds": 1615570772, "microseconds": 202844 } }
+#          "timestamp": { "seconds": 1615570772,
+#                         "microseconds": 202844 } }
 ##
 { 'event': 'DEVICE_UNPLUG_GUEST_ERROR',
   'data': { '*device': 'str', 'path': 'str' } }
-- 
2.48.1


