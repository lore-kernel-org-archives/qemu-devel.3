Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E59B7CCA476
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Oct 2025 14:18:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7aE6-0005BN-SZ; Sat, 11 Oct 2025 10:05:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7aE1-00051b-L9
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 10:05:33 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7aDf-0005bm-ER
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 10:05:33 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 7A4C8C01A1;
 Sat, 11 Oct 2025 17:04:55 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a4b::1:3c])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id h4NOTl1FrqM0-wKSa4CwY; Sat, 11 Oct 2025 17:04:55 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760191495;
 bh=83Si4n9Xifa8e3/o2G6/CFeqpWDDkQPsyg5kZnGHXPo=;
 h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
 b=rMe7fP96aRbUuFcSoMi6SvgRDqKYuZ6dRmm3EOj8kHih6jd7QDAQA9scCoiEl4sLy
 zsxP/YLleMTl6iUbQCJrsy97i1CoCsFLRfEg87kbgOzi/kRWdfe5ey7jK7btqKkk2e
 OYhgQjCGp3RIjSWig/UZmuoKm0dLBxiJIjA6IAz4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: armbru@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, eblake@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v2 20/33] qapi/qom.json: docs: width=70 and two spaces between
 sentences
Date: Sat, 11 Oct 2025 17:04:26 +0300
Message-ID: <20251011140441.297246-21-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251011140441.297246-1-vsementsov@yandex-team.ru>
References: <20251011140441.297246-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
 qapi/qom.json | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index 830cb2ffe7..99cdd0f60c 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -52,7 +52,8 @@
 #
 # @name: the name of the property.
 #
-# @type: the type of the property, as described in `ObjectPropertyInfo`.
+# @type: the type of the property, as described in
+#     `ObjectPropertyInfo`.
 #
 # @value: the value of the property.  Absent when the property cannot
 #     be read.
@@ -92,9 +93,12 @@
 #     -> { "execute": "qom-list",
 #          "arguments": { "path": "/chardevs" } }
 #     <- { "return": [ { "name": "type", "type": "string" },
-#                      { "name": "parallel0", "type": "child<chardev-vc>" },
-#                      { "name": "serial0", "type": "child<chardev-vc>" },
-#                      { "name": "mon0", "type": "child<chardev-stdio>" } ] }
+#                      { "name": "parallel0", "type":
+#     "child<chardev-vc>" },
+#                      { "name": "serial0", "type": "child<chardev-
+#     vc>" },
+#                      { "name": "mon0", "type": "child<chardev-
+#     stdio>" } ] }
 ##
 { 'command': 'qom-list',
   'data': { 'path': 'str' },
@@ -1082,7 +1086,8 @@
 #     Authentication Information Structure' for the SNP_LAUNCH_FINISH
 #     command defined in the SEV-SNP firmware ABI (default: all-zero)
 #
-# @author-key-enabled: true if 'id-auth' blob contains the 'AUTHOR_KEY'
+# @author-key-enabled: true if 'id-auth' blob contains the
+#     'AUTHOR_KEY'
 #     field defined SEV-SNP firmware ABI (default: false)
 #
 # @host-data: 32-byte, base64-encoded, user-defined blob to provide to
@@ -1117,17 +1122,17 @@
 # @attributes: The 'attributes' of a TD guest that is passed to
 #     KVM_TDX_INIT_VM
 #
-# @sept-ve-disable: toggle bit 28 of TD attributes to control disabling
-#     of EPT violation conversion to #VE on guest TD access of PENDING
-#     pages.  Some guest OS (e.g., Linux TD guest) may require this to
-#     be set, otherwise they refuse to boot.
+# @sept-ve-disable: toggle bit 28 of TD attributes to control
+#     disabling of EPT violation conversion to #VE on guest TD access
+#     of PENDING pages.  Some guest OS (e.g., Linux TD guest) may
+#     require this to be set, otherwise they refuse to boot.
 #
 # @mrconfigid: ID for non-owner-defined configuration of the guest TD,
-#     e.g., run-time or OS configuration (base64 encoded SHA384 digest).
-#     Defaults to all zeros.
+#     e.g., run-time or OS configuration (base64 encoded SHA384
+#     digest).  Defaults to all zeros.
 #
-# @mrowner: ID for the guest TD’s owner (base64 encoded SHA384 digest).
-#     Defaults to all zeros.
+# @mrowner: ID for the guest TD’s owner (base64 encoded SHA384
+#     digest).  Defaults to all zeros.
 #
 # @mrownerconfig: ID for owner-defined configuration of the guest TD,
 #     e.g., specific to the workload rather than the run-time or OS
-- 
2.48.1


