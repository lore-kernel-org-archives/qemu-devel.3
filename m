Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C0DCDB481
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 11:43:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcM1G-00042Q-Ks; Wed, 24 Jun 2026 07:43:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcM0s-0003Vd-7m
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:43:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcM0q-00087F-RH
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:43:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782301404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q1Zx3Z7/roefkjF/DLzal9CZPmsTs8ulmeW8smuUOww=;
 b=gNkx2ZvHFp8CHSisJ0oJ8h7C36IYCbXYKTjKTGF+ElpMGr46SvvvpEfxB9FAX+ZtWPgOdo
 MQ9SYgQsU7TJPV0lU5VbovJfxnEgNpBwh0H2AgmW4yIBvAFte0JIZEvyHECRvqmoGaIcQt
 x4x7Gl8eNwNrWpWk8rvuZaDQNIZHKAw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-80-8ZnQUHvTM9mwF6PZGV_tUg-1; Wed,
 24 Jun 2026 07:43:22 -0400
X-MC-Unique: 8ZnQUHvTM9mwF6PZGV_tUg-1
X-Mimecast-MFC-AGG-ID: 8ZnQUHvTM9mwF6PZGV_tUg_1782301402
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 220A018011E6
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 11:43:22 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E0E2C1955F7A; Wed, 24 Jun 2026 11:43:20 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 24 Jun 2026 15:41:42 +0400
Subject: [GIT PULL 20/35] ui/cocoa: implement display cleanup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260624-ui-v1-20-482147b0a7af@redhat.com>
References: <20260624-ui-v1-0-482147b0a7af@redhat.com>
In-Reply-To: <20260624-ui-v1-0-482147b0a7af@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1650;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=k2U8DDg4P2uPTVnpL4gsNGkNYmT7oxgRioNKmkKelP0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqO8Jo5PkdL2qfP03XByEbwMZibt2yRzKOUYe5/
 jTDGe8LpbGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajvCaAAKCRDa6OEJdZac
 5elDD/4yKgni9OkBtcHmrLJpOam9QfHKcXv42dw7hSpVS3qxfkPg07I78Enl8Jxi4E9D12bp9Sr
 MPHL7KSwhQe37YmivP6Pvpj02PW3iaL8S1JJceg/jIYR/r2R0++6diSTyUpmRcxNoUzlFeh1AeA
 2GsAyav1EV124MsTPt++X8Z7iEAzi7R23QNL13uWoQE6dmuFUcL2Cra+Fvwuvj3rPFoS0wHrWA2
 A3Q3Mj59nNZ9xsJc4anHLhX79bsAgnfEusR+vhyoJ2z+GMd4xYt/IO9tb4rihZMguHOQyKpAZlj
 ogLUL3u24B+P9ozRuGxrWcr+rbbgHgLSxFuTZz9KtuH4eNCCmcPaP/qLjelbx7I7IeS9/z3tLq6
 sBVa1vQ5TAeZmu88QqJC764wUFy7rhTJhOeO9OG1z095fGfW6xMgJeowkA6KMkvnp1mb8JqpBrR
 0ImSKiwUqVKPzXSp+xwlJnfHybg6rlGj/IV2bhsYYA97GISqE/sOEnzgN2NINQI8/6WTxCYp+1H
 rmCjv5sIaentcsOV4yI8zllEsCyOH58U01/TyVdATv6yYLmMwZXS1AFGRTX5e3bClu4CwR6nNks
 +8rbSlUyFqhbfnbveYn58bgjmuiujfTJwFV6T6IAyAiAk35hsvl74IdBO9ae+UivSzI3QQYWhK0
 wYo3xhzXXdY0xNg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Move cbowner release from QemuCocoaAppController -dealloc to
cocoa_display_cleanup(), since cbowner is allocated in
cocoa_display_init() and cleanup is the symmetric teardown path.

Tested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260623-b4-ui-v4-20-4656aec3398d@redhat.com>
---
 ui/cocoa.m | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index e157ad01d85..3751be37922 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -1206,8 +1206,6 @@ - (void) dealloc
     COCOA_DEBUG("QemuCocoaAppController: dealloc\n");
 
     [cocoaView release];
-    [cbowner release];
-    cbowner = nil;
 
     [super dealloc];
 }
@@ -2038,9 +2036,26 @@ static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
     qemu_main = cocoa_main;
 }
 
+static void cocoa_display_cleanup(void)
+{
+    if (!kbd) {
+        return;
+    }
+
+    qemu_console_unregister_listener(&dcl);
+    g_clear_pointer(&kbd, qkbd_state_free);
+    qemu_remove_mouse_mode_change_notifier(&mouse_mode_change_notifier);
+    qemu_clipboard_peer_unregister(&cbpeer);
+    g_clear_pointer(&cbinfo, qemu_clipboard_info_unref);
+    qemu_event_destroy(&cbevent);
+    [cbowner release];
+    cbowner = nil;
+}
+
 static QemuDisplay qemu_display_cocoa = {
     .type       = DISPLAY_TYPE_COCOA,
     .init       = cocoa_display_init,
+    .cleanup    = cocoa_display_cleanup,
 };
 
 static void register_cocoa(void)

-- 
2.54.0


