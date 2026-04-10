Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C361F45A0A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:26:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHTX-0007Hz-4N; Fri, 10 Apr 2026 15:25:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHTU-0007D2-3S
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:25:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHTA-0002e2-Qn
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:24:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775849083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U5h14GGyuaRyjjnzUY142eQktIU//IjoFzILlCF5BBg=;
 b=UBxoJ15yfFUj6tgYkrU+WllM0E2GmGENh7yx5AXxb4WYOU+dFWV6G8Svt41SQyjREU3hb6
 sWhedznZ6Gdaut6X7nm8KRigY00AYvDtBWSeKqGPWAnbBaeu+SJRzVLs6UCApnzkxainOz
 4qI5ce1uhjivr0LiLY1LHkhZuFMj198=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-325--zKVLtBAPVK0i1xO298qXA-1; Fri,
 10 Apr 2026 15:24:42 -0400
X-MC-Unique: -zKVLtBAPVK0i1xO298qXA-1
X-Mimecast-MFC-AGG-ID: -zKVLtBAPVK0i1xO298qXA_1775849081
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3188D1956080
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 19:24:41 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AA69D180049F; Fri, 10 Apr 2026 19:24:39 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 10 Apr 2026 23:19:20 +0400
Subject: [PATCH v2 58/67] ui/console: add doc comment for
 qemu_console_{un}register_listener()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-qemu-vnc-v2-58-231416f76dc3@redhat.com>
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
In-Reply-To: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1640;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=o64r7Of9HtLlvuQw/nt9wYCk6CpdYF4iMgj06cV9ySs=;
 b=kA0DAAoB2ujhCXWWnOUByyZiAGnZTRaiByiISa29IGI5AkFuExfn+DVmrRKLN+3yDQNP4zUMU
 YkCMwQAAQoAHRYhBIepvZM/h8YG0nb2Ldro4Ql1lpzlBQJp2U0WAAoJENro4Ql1lpzlvGsQAKJp
 E2LF5AHjtPnnb+lGgpXJq30iaHmFSo2iBAN95sOPiJSERyzhUTh6hxABiLudFZZox8EepOadiXn
 ieH5cnTCsR7KwoOVIVeQySBottGyzokAGzr66MmbFFL5WfeY6Y+zw8vDfIfqYNemogvvGayBUwf
 9ETk/UKwQ0tIGEDwOdK1DF8Z0hBOCJJJuvezyC2dHXlZDMLxbI1TwOAByLCZP3a8SulgDd/xbiC
 yTl+D0qAbCWM77gxHGVRCBTZuft6Qgs4bE6NwRUlVB+H2j1+X25pwBLTJIjtO8zIvdXVVyofWOf
 VxUf4s/DgPZx3QXvBS0aPJMoeihIwch5Eta5FT6AxWweXKLvgmPVlOCwyi9FdaXJgPU2DKOt288
 fBIujfjSYXCBW9x5mQqJ0XRaYvDmrsxwy63kl2hLq6QQB0NvHWSlRtFKibfFUIBnKOlfBzmxmc6
 8chqZBgBzB/kgeay/GYFosC/KLATN7rOkEKseECpGuTat804hPBrIo1RndJDM+vb0lg/RK1Q7Gw
 p1XtOTygGeDwSTpj2r5+Xc3YOK1XUeEMv35WZnBMSQbI73na8OWz34utW3UmdraYY8tRoO00a86
 lv8ctguVKXX2G3zAVuBnkbKSK35SUJSD3ChqdiNfnnZm+sRAo5EPg2wNIHroX8mekbNsKSwB29z
 DL7/1
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/ui/console.c b/ui/console.c
index 3ab987add34..f96e3cf16fa 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -642,6 +642,17 @@ dcl_set_graphic_cursor(DisplayChangeListener *dcl, QemuGraphicConsole *con)
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
@@ -675,6 +686,15 @@ void update_displaychangelistener(DisplayChangeListener *dcl,
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
2.53.0


