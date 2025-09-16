Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6198CAC592
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 17:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyZMz-0003ia-VC; Tue, 16 Sep 2025 13:21:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3WJfJaAcKCvktufwjfbhpphmf.dpnrfnv-efwfmopohov.psh@flex--steviea.bounces.google.com>)
 id 1uyZ1J-0001FT-1a
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 12:59:09 -0400
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3WJfJaAcKCvktufwjfbhpphmf.dpnrfnv-efwfmopohov.psh@flex--steviea.bounces.google.com>)
 id 1uyZ1H-0007oQ-8S
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 12:59:08 -0400
Received: by mail-pf1-x44a.google.com with SMTP id
 d2e1a72fcca58-7760b6b7235so4264306b3a.1
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 09:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1758041944; x=1758646744; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=pMsdFXJ2oi93r5StJ5+YQnGAlo8r4QqR8JiZJSKJtV8=;
 b=fZdhnbYNQd7vyYESc8oxlk+OGX8hMiz35sLEp3VI4tQJvtsaK4QMJqYE+2kGB2hi/4
 MDgbuygHxSttzuLrddrcx9DylQpwC/PorekFUAyfv8VsQdE+VqtcVrWdiv9XFFKGMCeZ
 NJasMpmsn3Lg0pgeu4RJ3L7z8PyG3076IixKfwjAZy4tupJizvrHvKA9ad3VQfiIx/Rd
 kcMv5pxrrmKHOPCR0yTTfJnhbMXPrWQMsBCkpCx2Srpc5cohgG8y7LETfSnzV4zEm6dN
 gHhEP1jO5kw0qyFqtWTVV4lxRf0DlZES64RtL7KKUkk3cEXOTKQ/do6EL56zsvnMRyXu
 VghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758041944; x=1758646744;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pMsdFXJ2oi93r5StJ5+YQnGAlo8r4QqR8JiZJSKJtV8=;
 b=KchC9WEn+ia5yv1PAanIIsiL1ilisJAaP8s4Bg4lPvS/p+cBPJufLY7vVIrnFJxxRX
 QCGR8jdTz2u+NBR5WdElJR8TlfbVsBQtOplAjnfi9W3wdPLG364igJjBCZH7WAGIOFD1
 PBlEhhB/ywjmgZgRItS9ytTR+XWqkisIHyfV//aalqKj5So6I2RA8DqOdl55fhD3Bb6s
 b6Bb/6ouSD6k+5GIo1japiJd0Zx0s9OV8RoSeP3xWLHv8GeKJEZiDLOTeK88of5AIBjH
 ouOOEmpT8f+mcZ2NIsroxKmkJfD7Hc6kDNtw9zWtxUjbag0wxBOSiYxNTQjKvsz4+G/1
 xsyw==
X-Gm-Message-State: AOJu0Yxa8taCFt1IAu8Fs3pgCdfFh9MbGfJW01NlJ17CxBHGjso/6v1q
 5cyln86Cv5TmS/kCPaLHEUn7YUGrCo5PffTbmJqA6AARqUSWWlF1O+6Uk6mmjP+fcMUANVqzTRO
 KsYIRMSYohi7wmuUJKo/ORWVLS4ngTKfDdbkubdXTMAKOKf4DcU/lJFmZBJc+izEtVkzWYPUPXf
 iwDD/7J9z6r5xi0RbKEp7uELjFJXhNOSfz3cmuqsnM
X-Google-Smtp-Source: AGHT+IFYilyLyD74rD8pPcO2cWWhfhp44m/XXdtmhAbBVHKchE4eYp5t+vfYmpY+PzJK5Q1qpJzlhpKjQF83
X-Received: from pfmm4.prod.google.com ([2002:a05:6a00:2484:b0:772:5c7d:de38])
 (user=steviea job=prod-delivery.src-stubby-dispatcher) by
 2002:aa7:8888:0:b0:76e:99fc:dde7
 with SMTP id d2e1a72fcca58-77612181914mr20589943b3a.22.1758041944158; Tue, 16
 Sep 2025 09:59:04 -0700 (PDT)
Date: Tue, 16 Sep 2025 16:58:59 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250916165859.1718787-1-steviea@google.com>
Subject: [PATCH] hw/i2c: pca954x: enable vmstate
From: Stevie Alvarez <steviea@google.com>
To: qemu-devel@nongnu.org
Cc: venture@google.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::44a;
 envelope-from=3WJfJaAcKCvktufwjfbhpphmf.dpnrfnv-efwfmopohov.psh@flex--steviea.bounces.google.com;
 helo=mail-pf1-x44a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 16 Sep 2025 13:21:27 -0400
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

From: Patrick Venture <venture@google.com>

Add missing vmstate support.

Signed-off-by: Patrick Venture <venture@google.com>
---
 hw/i2c/i2c_mux_pca954x.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/i2c/i2c_mux_pca954x.c b/hw/i2c/i2c_mux_pca954x.c
index a8ef640cd2..78828acafb 100644
--- a/hw/i2c/i2c_mux_pca954x.c
+++ b/hw/i2c/i2c_mux_pca954x.c
@@ -22,6 +22,7 @@
 #include "hw/qdev-core.h"
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qemu/queue.h"
@@ -211,6 +212,18 @@ static void pca954x_init(Object *obj)
     }
 }
 
+static const VMStateDescription pca954x_vmstate = {
+    .name = TYPE_PCA954X,
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = (VMStateField[]) {
+        VMSTATE_SMBUS_DEVICE(parent, Pca954xState),
+        VMSTATE_UINT8(control, Pca954xState),
+        VMSTATE_BOOL_ARRAY(enabled, Pca954xState, PCA9548_CHANNEL_COUNT),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const Property pca954x_props[] = {
     DEFINE_PROP_STRING("name", Pca954xState, name),
 };
@@ -228,6 +241,7 @@ static void pca954x_class_init(ObjectClass *klass, const void *data)
 
     dc->desc = "Pca954x i2c-mux";
     dc->realize = pca954x_realize;
+    dc->vmsd = &pca954x_vmstate;
 
     k->write_data = pca954x_write_data;
     k->receive_byte = pca954x_read_byte;
-- 
2.51.0.384.g4c02a37b29-goog


