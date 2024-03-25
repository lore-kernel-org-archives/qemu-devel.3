Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98048C54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 09:58:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roh4y-0007AS-2B; Mon, 25 Mar 2024 05:57:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1roh4w-0007AF-5B
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 05:57:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1roh4u-00019P-FJ
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 05:57:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711360634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=q0/nD6GX1CT9CTMN/YU40xF2dQa5ekacZ4wpLaKuw/k=;
 b=Sid6Knwjv35xceeslcIv3t2TRW1Hfw0x0gpG11rVGBym6wf1uci/DQqE8txhZ8WNscJ9+7
 +xecqsmOBySmcnkYKsDJAfzW49Rkzb+wCMtw/XGf9CQDW60DY4zI23iSDKaIrd088WaXT9
 PA0WCeQxMxEomEYUrYMg020K1DntrpA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-KWr_1l2-PM-LXV-TeQNYbg-1; Mon,
 25 Mar 2024 05:57:11 -0400
X-MC-Unique: KWr_1l2-PM-LXV-TeQNYbg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 807D11C07F2F
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 09:57:11 +0000 (UTC)
Received: from localhost (unknown [10.39.208.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 64E8140C6CB3;
 Mon, 25 Mar 2024 09:57:10 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: [PATCH] qapi: document InputMultiTouchType
Date: Mon, 25 Mar 2024 13:56:48 +0400
Message-ID: <20240325095648.2835381-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qapi/ui.json | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/qapi/ui.json b/qapi/ui.json
index 5744c24e3c..53d9143054 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -1080,6 +1080,16 @@
 #
 # Type of a multi-touch event.
 #
+# @begin: A new touch event sequence has just started.
+#
+# @update: A touch event sequence has been updated.
+#
+# @end: A touch event sequence has finished.
+#
+# @cancel: A touch event sequence has been canceled.
+#
+# @data: Absolute position data.
+#
 # Since: 8.1
 ##
 { 'enum'  : 'InputMultiTouchType',
@@ -1137,6 +1147,8 @@
 #
 # MultiTouch input event.
 #
+# @type: The type of multi-touch event.
+#
 # @slot: Which slot has generated the event.
 #
 # @tracking-id: ID to correlate this event with previously generated
-- 
2.44.0


