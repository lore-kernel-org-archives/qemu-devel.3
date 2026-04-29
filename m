Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D01D4FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 21:06:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIC7J-00005a-Pt; Wed, 29 Apr 2026 17:06:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wIC5y-0006hp-PY
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:05:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wIC5w-0003Xn-1H
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:05:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777496719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dkANc4a7F0AbJagAO11on/jJ58ayyrv4D4QifFMta6U=;
 b=NM6dbV1klIGbCCw+lGm97uVnkhdzjfzXKFwECmWXPVgGn4y8M28vT7vNBJTvOcybr/910x
 LbcO+u23s9oP3CMq7fQKxh6a/lZUGlM4U0lPAa3FMCTA3UV/ZlX8YH2maqtp+CLXO2HKm9
 9qxAcVR1Y1jaEqDYGmQv23Ag0ZN43mU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-483-mU0yOftDNsCxlq7EAmKmGQ-1; Wed,
 29 Apr 2026 17:05:17 -0400
X-MC-Unique: mU0yOftDNsCxlq7EAmKmGQ-1
X-Mimecast-MFC-AGG-ID: mU0yOftDNsCxlq7EAmKmGQ_1777496716
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AA8F71800473
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 21:05:16 +0000 (UTC)
Received: from localhost (unknown [10.44.22.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5EA03180045E; Wed, 29 Apr 2026 21:05:14 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 30 Apr 2026 01:02:54 +0400
Subject: [PATCH v3 21/26] ui/console: add doc comment for
 qemu_console_{un}register_listener()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260430-qemu-vnc-v3-21-be96757428d0@redhat.com>
References: <20260430-qemu-vnc-v3-0-be96757428d0@redhat.com>
In-Reply-To: <20260430-qemu-vnc-v3-0-be96757428d0@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1640;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=fEy64I3B0L4Z5NNPglXU9Wi7CSBCUHOGg1gEsE6KjEM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp8nIMd06ThWKQRQf3Z3ZR3is+9cQdclY7IL2gJ
 wlMLS6hTlqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafJyDAAKCRDa6OEJdZac
 5Xz0D/9Vo8vZiUKKvxxh3WfNZlJkSlGxZphNSP/QFyBUM9kXQNUvv9Mn03Ll0SybWXZeeYYHYp3
 kbheX/b/xoh/6iVHK781T3vMheYJE6UaR5A40P+shUR8Xagi2+Ij4KmtmLEWJvIRA6E7QdZ9HPb
 fduPyH4H/P50uW63E6SOuSCbdsUZoTeL7jYDxQeT1p7aZ2+Qe0jYTgwGpkniCA1eSDRE6zpwjN5
 yZt9ZtMWgZmOQPudwFBfIAKkan1sLRuNRfMoYJ0misMviTRnGBVYQk+GxjZPn02XtNDcD/MXUO8
 D5puVmhdEiO7pzfc63YzT1bUqKMBKBJWypFMkV3j5cOb/3PjzAwmRizOGzq9ZYJMnqdNPU91ZU0
 7CFpKYNsVmTttV4/pnM6jzIASSmKmr2hxIJqnTD/9d9N89TRIdb6t4hj46JPntPwJ82spklSnFS
 TXHcve2951gh1y8TXM7kgLrm+YHWI3QBFp3bgKswcoC8+L7pfrOTgyIOmMX1baYbRHaaza5HH8I
 cdyECnjWXIgFUTjNZ/E0rzQnLWh30A5xiXswa3+y3kgfU1xgSrp85MbJXXzDrIABBfUl6Mk6TjM
 U8UuLSHHUlgXNH96z0P3zJPGOkchzMPcl+6NJnZDxHFhxL9X4r9Lr95PYjL2VJRMDxIZt3wbxgD
 Xzt8NnPB9obh3AA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


