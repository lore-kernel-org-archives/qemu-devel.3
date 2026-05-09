Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E71CD3447
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 17:17:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLlIb-0000hE-Ol; Sat, 09 May 2026 13:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wLlIH-0000Kp-H4
 for qemu-devel@nongnu.org; Sat, 09 May 2026 13:16:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wLlIE-0005LU-6Q
 for qemu-devel@nongnu.org; Sat, 09 May 2026 13:16:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778347005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HBuFafYm6F01wcXXCOvB+PnpdAUYUNMO5FI3mobc9nQ=;
 b=iRssY2/uu/hrX8aBBjUyDHgjlSt3yAkNp64X9CDWgh8dvZvkO2Hl3IjQ2ZPnpnDmtAVKok
 GEfOf52+Fg1KDiWq604L8zp36g3D/o41/Ao2sAOOdJ/3chQcmK2ySUjNTlUogU9mljXezn
 3d19EOAEy6EgEqcIs+UWAqZpS+Fq6rc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-J-OVLP8rOcOUnpRBenVt0Q-1; Sat,
 09 May 2026 13:16:41 -0400
X-MC-Unique: J-OVLP8rOcOUnpRBenVt0Q-1
X-Mimecast-MFC-AGG-ID: J-OVLP8rOcOUnpRBenVt0Q_1778347000
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 587CB18002DC; Sat,  9 May 2026 17:16:40 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 569D31800240; Sat,  9 May 2026 17:16:38 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL v2 27/33] ui/console: add doc comment for
 qemu_console_{un}register_listener()
Date: Sat,  9 May 2026 21:13:48 +0400
Message-ID: <20260509171356.1157879-28-marcandre.lureau@redhat.com>
In-Reply-To: <20260509171356.1157879-1-marcandre.lureau@redhat.com>
References: <20260509171356.1157879-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/ui/console.c b/ui/console.c
index 4f3b4394268..22ca1c35db3 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -572,6 +572,17 @@ dcl_set_graphic_cursor(DisplayChangeListener *dcl, QemuGraphicConsole *con)
     }
 }
 
+/*
+ * qemu_console_register_listener:
+ * @con: the console to attach the listener to
+ * @dcl: the display change listener to register
+ * @ops: the listener operations (callbacks for display updates)
+ *
+ * Register a display change listener on a console. The listener
+ * must not already be registered (i.e. @dcl->ds must be NULL).
+ * This sets up the listener, adds it to the display state, triggers
+ * an initial display update, and setup the cursor.
+ */
 void qemu_console_register_listener(QemuConsole *con,
                                     DisplayChangeListener *dcl,
                                     const DisplayChangeListenerOps *ops)
@@ -605,6 +616,15 @@ void update_displaychangelistener(DisplayChangeListener *dcl,
     }
 }
 
+/*
+ * qemu_console_unregister_listener:
+ * @dcl: the display change listener to unregister
+ *
+ * Unregister a display change listener, removing it from the
+ * display state's listener list. If the listener is not currently
+ * registered (@dcl->ds is NULL), this is a no-op. After unregistering,
+ * the display refresh timer is recalculated.
+ */
 void qemu_console_unregister_listener(DisplayChangeListener *dcl)
 {
     DisplayState *ds = dcl->ds;
-- 
2.54.0


