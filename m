Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD5E2F3381C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:56:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2QDg-000491-Eh; Tue, 17 Mar 2026 04:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QBk-00010Q-Jr
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:54:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QBh-0005Vg-Ih
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:54:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773737644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EzDZzBWodmNOOZ3jULA7Y2Qa5xw3WpxQ4VBBSaX639Y=;
 b=MHKjut/ipoPvU4DnWJnHOFYMQQnqr0sqJeFDv3O2Pue5/uCtlTlejhwiw3ppZ4KzTi807+
 xbqEXB+1Zb5vaNqNfEp2PTdiAxdN4W96ZMwK3SGaR11myzNROMPy2Qf6fJFM2XB31gVT5h
 sjBIDUo6JE8PYu9MzXTksGV68fNrwT4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-442-8UqOVVaCPLWwkaTHGj_2_w-1; Tue,
 17 Mar 2026 04:54:00 -0400
X-MC-Unique: 8UqOVVaCPLWwkaTHGj_2_w-1
X-Mimecast-MFC-AGG-ID: 8UqOVVaCPLWwkaTHGj_2_w_1773737639
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5997D1944F12
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:53:59 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4DFF6180075B
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:53:57 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 17 Mar 2026 12:50:48 +0400
Subject: [PATCH 34/60] ui: move FONT_WIDTH/HEIGHT to vgafont.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260317-qemu-vnc-v1-34-48eb1dcf7b76@redhat.com>
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
In-Reply-To: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1648;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=1+OWbtQSnb2bEVpjfuso7ec3n8EQR/XImyRKC8nO+lE=;
 b=kA0DAAoB2ujhCXWWnOUByyZiAGm5FduhCw5PTWUwAFUoRXqo7WZZY1wxzbkQrBtfcyzanVP2E
 YkCMwQAAQoAHRYhBIepvZM/h8YG0nb2Ldro4Ql1lpzlBQJpuRXbAAoJENro4Ql1lpzlKqIQALVG
 gMZj8ejma1Y4rvZAgC+FNg3h/eoIg74+zgnPlz0rPxyn4ihlbnrbaRmS1bn1v9YEkHxgrFuwOek
 LOVGnOsZpCVlx5RRKc9vgh8iNyc1l4dhEq+r+DoIqL9OIn95yAMWp2yHFpNv2COF+rQ8efDoHBm
 xT0Y77AIx0mzjPx6cG9LjTui72/ZoXAil7cv3LsOXcp6Q1tCqPFpbqmCgBc6LmI25+DOUBcHvPP
 HIplCQ6QovvTH1aupEycALNozQAH+Oo7KDAwiR8Z23Tk4LZiX5pNKhPxxSFAUBgg7bah04V5Br+
 18+3YRAGbVp4h9PwniIiSNSjmrboUg1jdIhTJ+96yAHYHNAZk2dSnMR41QyuOKXbEzyECALL/L8
 7OhGi8q3I0yWkOTcm2qWaTfGl3M+y0s4gjfFuUppWCaXGv9Q+Q1DZZyOajGXrUA51+ofimIAtlr
 TjiTR0NKXcVV2t+2bJuywiNsMdcxTXeDvQoMdl6Jl6bSCrt9BF8vhIWQNpymJ3mldkP3ZJI16r6
 Hy6ALMZGjbrcK4TQxzGWy4oBvaNPJ/ZB5qPRkAE9SMEUZ4u8PMvHi76jv36n5BFsS87KYsqcCd1
 zRF2jy0CNt5d77pxlGAf2vz8xMzexmJk5Vpz62YguFj9jO2KbFbazB78Iwy5sVLdr08uG5GOCRe
 e5BfU
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Since those values are related to the VGA font, it make sense to move
them here.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console-priv.h | 5 -----
 ui/vgafont.h      | 6 +++++-
 ui/console-vc.c   | 1 +
 ui/console.c      | 1 +
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/ui/console-priv.h b/ui/console-priv.h
index 8bcdb79d914..39798c3e9d7 100644
--- a/ui/console-priv.h
+++ b/ui/console-priv.h
@@ -9,11 +9,6 @@
 #include "qemu/coroutine.h"
 #include "qemu/timer.h"
 
-#include "vgafont.h"
-
-#define FONT_HEIGHT 16
-#define FONT_WIDTH 8
-
 struct QemuConsole {
     Object parent;
 
diff --git a/ui/vgafont.h b/ui/vgafont.h
index 54aeeb7d192..d24b5d47a95 100644
--- a/ui/vgafont.h
+++ b/ui/vgafont.h
@@ -6,6 +6,10 @@
 
 #include <stdint.h>
 
-extern const uint8_t vgafont16[256 * 16];
+/* supports only vga 8x16 */
+#define FONT_WIDTH 8
+#define FONT_HEIGHT 16
+
+extern const uint8_t vgafont16[256 * FONT_HEIGHT];
 
 #endif
diff --git a/ui/console-vc.c b/ui/console-vc.c
index ba440c50744..8e785cde94c 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -11,6 +11,7 @@
 #include "qemu/queue.h"
 #include "ui/console.h"
 #include "ui/cp437.h"
+#include "ui/vgafont.h"
 
 #include "pixman.h"
 #include "trace.h"
diff --git a/ui/console.c b/ui/console.c
index b2b879e8533..c997e8df572 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "ui/console.h"
+#include "ui/vgafont.h"
 #include "hw/core/qdev.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-ui.h"

-- 
2.53.0


