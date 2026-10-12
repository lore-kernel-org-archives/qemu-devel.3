Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 490EACA9EC5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 14:59:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGHUU-0001YB-1u; Mon, 12 Oct 2026 10:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xGHUB-0001Ui-Mt
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 10:58:48 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xGHU0-0005fD-6X
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 10:58:33 -0400
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-48afcd7ba9bso1115910f8f.3
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 07:58:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791817111; x=1792421911;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cBS24KyVkFdx9K1mrb9mnaPLSyXbJlcPXKfV6TpuYbc=;
 b=rrV7bYLJ89IOUjtkRC5saFigl9+O4TuT+dcX8W0rhnhxxydtx5CYH8q8Mpqm/0XxYe
 okt5wCSfW+007U6ZZiHV4CcbReAIYC4yKIXU/YBLWLvCSr4tLCHAggs9nCthjaZWduag
 GUGh0Y7NbAkj8NWD5MKRmhvC/nK4L9U8Am9KsTOi2LIkh+tldZ0hVXu8NzTOnlpw7pmQ
 KVkN3GdEZoDCEHdj4T504ek33iYI0Icx2mwMbo89SGEZK3iNyL+Rgp0650/Lv9jmqKuf
 Bh1x/2EVwIYupICIM48EHMfVkeOUVNTOsgTO6f41pIUtJpHUzVXh7LC0+FTdH75EiLbJ
 ZQNw==
X-Gm-Message-State: AFq9FYICFPZBKzwzwZ4pFTegU/rx/1WKlWEb6C90yP5ylOY7qwgDJScB
 3GTo6WP3k7MUapbhfbTjSPPZBY74KreWT04AYXAWOpejZinZEmHgEXz/hCbOr6Bc
X-Gm-Gg: AYBFou0RkR+lImygEMIVO9ufQwuvH2EGxWwg5Y+dDXy9XjYXdlK6e4nspijhj0CL7LE
 3bQe0h7urK0MiKOwuQNi3N4TUEIPivI2gAdF1MRfOfGoIbvcxR6s+c/lDtnzZv60Rbk+QptKC5t
 aLcZMm/ECqcxGMG9sHbGSTRaGwBbu6y2ws3s5kXrcufRVJNuu4aqzyD5YWRbP2E6rFEBtVD1KXH
 ZCdf8pJeQiLqmdwh61oClLsMsW6YEGyaciC+AXFeE7uNPDDX64zURZ5DfGA+pNM3mWg1mPCsttl
 jz+Nf0ygfCYAVe0CyJp75Q5nLvPwKALtkTs8gqXUerbuVNQY0iHHOifOjdRS8QoLFBDnkNP64rk
 nXD+/7mxbxz5DqBcbfE08RKAoG+LTjsThtIxA1YENEeGAVIUzbkot1XxBddqMruKJUJBC9BDT3R
 k3dcGXHHrhaaiGDyJ5ZR7JqjQqEHdzaukJppBUFoy43vZAQK/oLAEX5WBKxweBFy3wARtM1uz8s
 y6xtnH5h3Y2YsZfYa8M/Q1pnVI7rpdPg4uYsAhNUQXs7w==
X-Received: by 2002:a5d:5e01:0:b0:487:35d:cb0f with SMTP id
 ffacd0b85a97d-48dbaadde6dmr19172721f8f.14.1791817110618; 
 Mon, 12 Oct 2026 07:58:30 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9acfa28sm20117000f8f.51.2026.10.12.07.58.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 07:58:30 -0700 (PDT)
Date: Mon, 12 Oct 2026 16:31:59 +0200
Subject: [PATCH v2 06/50] hw/i2c: pca954x: migrate mux state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-bmc-minerva-v2-6-4c3dff084ec9@free.fr>
References: <20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr>
In-Reply-To: <20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org, 
 Patrick Leis <venture@google.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791815519; l=1912;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=6X3qtF5y9bDFv2QNu2TGa306El/FnP4ElGjKxh8N7cM=;
 b=a/5no+gY9vkPrY0vzsK8im6C2uagcbkgarXXe3eLjxbo6dEPrkuWZVv3+pquCSlmGHutp1fVZ
 M4UyIV9d2W9BZCOIO8chhhFYJQro60j5KZq24p4nRLpQIdLv5ilwr2h
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.221.52; envelope-from=eblot.ml@gmail.com;
 helo=mail-wr1-f52.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Emmanuel Blot <emmanuel.blot@free.fr>
From:  Emmanuel Blot via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The pca954x model had no VMStateDescription, so neither the channel
selection nor the PCA9545 interrupt status survived a migration.

This changes the migration stream of the pre-existing PCA9546 and
PCA9548, which an older QEMU rejects.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 hw/i2c/i2c_mux_pca954x.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/hw/i2c/i2c_mux_pca954x.c b/hw/i2c/i2c_mux_pca954x.c
index 4bb078a03c..597e57d99a 100644
--- a/hw/i2c/i2c_mux_pca954x.c
+++ b/hw/i2c/i2c_mux_pca954x.c
@@ -28,6 +28,7 @@
 #include "hw/core/irq.h"
 #include "hw/core/qdev.h"
 #include "hw/core/qdev-properties.h"
+#include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/queue.h"
 #include "qom/object.h"
@@ -270,6 +271,28 @@ static void pca954x_init(Object *obj)
     }
 }
 
+static int pca954x_post_load(void *opaque, int version_id)
+{
+    Pca954xState *s = PCA954X(opaque);
+
+    pca954x_enable_channel(s, s->control);
+    qemu_set_irq(s->int_out, s->int_status == 0);
+    return 0;
+}
+
+static const VMStateDescription vmstate_pca954x = {
+    .name = "pca954x",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .post_load = pca954x_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_SMBUS_DEVICE(parent, Pca954xState),
+        VMSTATE_UINT8(control, Pca954xState),
+        VMSTATE_UINT8(int_status, Pca954xState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static const Property pca954x_props[] = {
     DEFINE_PROP_STRING("name", Pca954xState, name),
 };
@@ -287,6 +310,7 @@ static void pca954x_class_init(ObjectClass *klass, const void *data)
 
     dc->desc = "Pca954x i2c-mux";
     dc->realize = pca954x_realize;
+    dc->vmsd = &vmstate_pca954x;
 
     k->write_data = pca954x_write_data;
     k->receive_byte = pca954x_read_byte;

-- 
2.50.1


