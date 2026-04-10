Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97202F45A08
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:27:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHQm-0003q4-KD; Fri, 10 Apr 2026 15:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHQl-0003je-8O
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:22:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHQj-0001tK-PN
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:22:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775848933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j3St06greiPm0gRjhv05vve6ioGFoJrPO6xToZlL5pk=;
 b=fwtbLeYkhXs9Vt7TeB2ZVIyHuBF8p7copaIh7PN5eFtwfEaXwDYuKwRBczbEIjXtz08wo1
 10+1lrAhP2Hvtcvs2Eb6RWLBjKY09M+UydzIRtFgfIF38NTUmADl3CLga6zfj+wpsvWHlV
 wJIErqUBJPad0oEXyIorRLPg/FTMkbI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-ypADfWsgOuiGXlPFHrS0tQ-1; Fri,
 10 Apr 2026 15:22:10 -0400
X-MC-Unique: ypADfWsgOuiGXlPFHrS0tQ-1
X-Mimecast-MFC-AGG-ID: ypADfWsgOuiGXlPFHrS0tQ_1775848929
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2219F19560B2; Fri, 10 Apr 2026 19:22:09 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DDDA21801ACA; Fri, 10 Apr 2026 19:22:07 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 10 Apr 2026 23:18:54 +0400
Subject: [PATCH v2 32/67] ui: move FONT_WIDTH/HEIGHT to vgafont.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-qemu-vnc-v2-32-231416f76dc3@redhat.com>
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
In-Reply-To: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1762;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=bzagRfynX+IeSymorU/TnEpMIirjW/YFelY6j4BXYvo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp2U0VHnt50kmy5xeEfHAKZmT6j4riJFT2+BYFQ
 fGa7WGh5xyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCadlNFQAKCRDa6OEJdZac
 5U7CD/0f389iLnU6SZBvcz/VDFZzO9wIkSzyQwcUXFw/WF139c0XFZ3YukWrCj4ss0DZX0Y1o75
 z9MFZrUFjNtAWIP3vtiOsB53jv/j5oVTc1x/87iEnTGImjG569tt68iTZQxYc2ahe7H+5cC3xbn
 oOuv5TG9qFy+gZc9lCZzjcbNByYGXCDt7A3u56LBbU2uNfly5Nf8zuIWbBSuLmFeUbqKKX3bck1
 +URu+2OWep8VD+GkK2Vc42e/9aqOBS6J6IFqy6u+xlHF/t+2BT4eUpLENrDSB4npt8En3IKlms7
 gVHVIAWYWKYK3Axd7vHk8c5rn0PZxtoCXC+p/6zqswn2eHK9WZzom8x3rAz1m5oPDGZaWxF0Pt/
 AP3PPjvNDzuQGb5SD5VRu5YJSdSnnksTJZjExb9pyGGFy39qQdxeFYiGr6d0xdBfdS98LRMBZPi
 EwILWHW6XQXuk8i1vP1NaIJBaOwoN/BNCl1uS4Lt3NBLoNr+Z5lXMLhlzAQ8o8ASbRYQ8XKOO3n
 RRLj04qDTsGO+vZI5/DpiCrUaIwp/+3emOAqcskxm6v8450z+qfhbPoR1tpseZiQFJNEmvhliv7
 6zyfElvhOc+jWbwGgf1/a1qNVrlJ8Gx9V9YRamv1JBGYyceZnetKhd4SLWWoiFqT3m44P3CLYRX
 GCjqopHtFBZP9KQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
index d58917c1850..0d7b943fdc7 100644
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


