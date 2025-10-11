Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B657CCA476
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Oct 2025 14:20:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7aDb-0004Lh-1B; Sat, 11 Oct 2025 10:05:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7aDW-00046F-6F
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 10:05:02 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7aDK-0005OP-Iq
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 10:05:00 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 3E2F3C017D;
 Sat, 11 Oct 2025 17:04:45 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a4b::1:3c])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id h4NOTl1FrqM0-qiXIptSi; Sat, 11 Oct 2025 17:04:44 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760191484;
 bh=GwUGObk/skOiLvkKNiWNa/3LsaS2Qb5Akmk/NJK1Uw0=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=WO3MYE0B7lA4FfJLc0bgRXan2zj1FRyygj03X6JWbWgZ3Nll0GMu6OAEDipms1sv/
 J651k0r3vwdCoCFqSwtziknV7WQ+wWJS6/oXjeeYMHI9SWvYRsMUBFmqkTBJrr8ay7
 xcv2c+dGzoZ/V10K3aqM7OzJvgR06xJO+xZ5Ul2w=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: armbru@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, eblake@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v2 02/33] qapi/acpi.json: docs: width=70 and two spaces
 between sentences
Date: Sat, 11 Oct 2025 17:04:08 +0300
Message-ID: <20251011140441.297246-3-vsementsov@yandex-team.ru>
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
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
 qapi/acpi.json | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/qapi/acpi.json b/qapi/acpi.json
index 906b3687a5..601271607b 100644
--- a/qapi/acpi.json
+++ b/qapi/acpi.json
@@ -116,10 +116,16 @@
 # .. qmp-example::
 #
 #     -> { "execute": "query-acpi-ospm-status" }
-#     <- { "return": [ { "device": "d1", "slot": "0", "slot-type": "DIMM", "source": 1, "status": 0},
-#                      { "slot": "1", "slot-type": "DIMM", "source": 0, "status": 0},
-#                      { "slot": "2", "slot-type": "DIMM", "source": 0, "status": 0},
-#                      { "slot": "3", "slot-type": "DIMM", "source": 0, "status": 0}
+#     <- { "return": [
+#          { "device": "d1", "slot": "0",
+#            "slot-type": "DIMM", "source": 1,
+#            "status": 0 },
+#          { "slot": "1", "slot-type": "DIMM", "source": 0,
+#            "status": 0 },
+#          { "slot": "2", "slot-type": "DIMM", "source": 0,
+#            "status": 0 },
+#          { "slot": "3", "slot-type": "DIMM", "source": 0,
+#            "status": 0 }
 #        ]}
 ##
 { 'command': 'query-acpi-ospm-status', 'returns': ['ACPIOSTInfo'] }
@@ -137,8 +143,10 @@
 #
 #     <- { "event": "ACPI_DEVICE_OST",
 #          "data": { "info": { "device": "d1", "slot": "0",
-#                              "slot-type": "DIMM", "source": 1, "status": 0 } },
-#          "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
+#                              "slot-type": "DIMM", "source": 1,
+#                              "status": 0 } },
+#          "timestamp": { "seconds": 1265044230,
+#                         "microseconds": 450486 } }
 ##
 { 'event': 'ACPI_DEVICE_OST',
      'data': { 'info': 'ACPIOSTInfo' } }
-- 
2.48.1


