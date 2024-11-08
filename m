Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEFB8D5E158
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 10:44:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9MT2-0004SY-8q; Fri, 08 Nov 2024 05:43:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t9MT0-0004JF-9u
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 05:43:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t9MSy-0006AY-Rd
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 05:43:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731062628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6c5wzWMg3XjLmnrwtyn9xG6b8XAmz8J+k1Ev/R8hHVE=;
 b=Syyipb1vz21V+RAZNu6pXL8h//NR86/62+rZ2RWtfpJi7rrLylrpXD5v7teYgOMpG+7QtC
 s7i4lRl3xnaFfAV3TwNFmhU20nOYYopiv1sb5Qn3fzkqHKQOm+SSjG7BUoU8oT31CQ73t5
 8y8KwMuKF7VpxkOS9gkK+H/jPbnRqv0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-576-uSyQJIEFN5ewbtTbN9L11w-1; Fri,
 08 Nov 2024 05:43:46 -0500
X-MC-Unique: uSyQJIEFN5ewbtTbN9L11w-1
X-Mimecast-MFC-AGG-ID: uSyQJIEFN5ewbtTbN9L11w
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5DEC71955F45; Fri,  8 Nov 2024 10:43:45 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.118])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4C81A1953882; Fri,  8 Nov 2024 10:43:43 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/10] ui/input-legacy.c: remove unused legacy
 qemu_add_kbd_event_handler() function
Date: Fri,  8 Nov 2024 11:43:10 +0100
Message-ID: <20241108104312.534448-11-thuth@redhat.com>
In-Reply-To: <20241108104312.534448-1-thuth@redhat.com>
References: <20241108104312.534448-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Since the last keyboard device has now been converted over to use
qemu_input_handler_register(), the legacy qemu_add_kbd_event_handler() function
is now unused and can be removed.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20241106120928.242443-3-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/ui/console.h |  2 --
 ui/input-legacy.c    | 37 -------------------------------------
 2 files changed, 39 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 5832d52a8a..46b3128185 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -70,8 +70,6 @@ typedef struct QEMUPutMouseEntry QEMUPutMouseEntry;
 typedef struct QEMUPutKbdEntry QEMUPutKbdEntry;
 typedef struct QEMUPutLEDEntry QEMUPutLEDEntry;
 
-QEMUPutKbdEntry *qemu_add_kbd_event_handler(QEMUPutKBDEvent *func,
-                                            void *opaque);
 QEMUPutMouseEntry *qemu_add_mouse_event_handler(QEMUPutMouseEvent *func,
                                                 void *opaque, int absolute,
                                                 const char *name);
diff --git a/ui/input-legacy.c b/ui/input-legacy.c
index 210ae5eaca..ca4bccb411 100644
--- a/ui/input-legacy.c
+++ b/ui/input-legacy.c
@@ -109,43 +109,6 @@ void qmp_send_key(KeyValueList *keys, bool has_hold_time, int64_t hold_time,
     g_free(up);
 }
 
-static void legacy_kbd_event(DeviceState *dev, QemuConsole *src,
-                             InputEvent *evt)
-{
-    QEMUPutKbdEntry *entry = (QEMUPutKbdEntry *)dev;
-    int scancodes[3], i, count;
-    InputKeyEvent *key = evt->u.key.data;
-
-    if (!entry || !entry->put_kbd) {
-        return;
-    }
-    count = qemu_input_key_value_to_scancode(key->key,
-                                             key->down,
-                                             scancodes);
-    for (i = 0; i < count; i++) {
-        entry->put_kbd(entry->opaque, scancodes[i]);
-    }
-}
-
-static const QemuInputHandler legacy_kbd_handler = {
-    .name  = "legacy-kbd",
-    .mask  = INPUT_EVENT_MASK_KEY,
-    .event = legacy_kbd_event,
-};
-
-QEMUPutKbdEntry *qemu_add_kbd_event_handler(QEMUPutKBDEvent *func, void *opaque)
-{
-    QEMUPutKbdEntry *entry;
-
-    entry = g_new0(QEMUPutKbdEntry, 1);
-    entry->put_kbd = func;
-    entry->opaque = opaque;
-    entry->s = qemu_input_handler_register((DeviceState *)entry,
-                                           &legacy_kbd_handler);
-    qemu_input_handler_activate(entry->s);
-    return entry;
-}
-
 static void legacy_mouse_event(DeviceState *dev, QemuConsole *src,
                                InputEvent *evt)
 {
-- 
2.47.0


