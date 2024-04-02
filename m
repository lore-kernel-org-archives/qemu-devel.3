Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC12DC6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 13:20:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rre0z-0006dg-MU; Tue, 02 Apr 2024 09:17:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rre0s-00061e-9n
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 09:17:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rre0o-0006ZM-0i
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 09:17:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712063831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CocnoBVJpn99epD+80lqAYY0uYOL6LyKI4I2LjGgdmg=;
 b=YnOYL1RIXseivo4PsVe8deVsjaI+ZhG9pxWKyrUvEpY0txf3Zw54M+6P2KCXHryYdCMFCA
 iqN6U3CPrr0w3DfTtnMm3mtRZ3eLooyVnbOY8kV9+eN+Aiqu4aC2p/gbGj9J7gINBajrHz
 W3FuWcq+kGkjrn7iGCk3agLdotlOK+M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-vBdr4LvBPvSB3LuLCSeW7g-1; Tue, 02 Apr 2024 09:17:10 -0400
X-MC-Unique: vBdr4LvBPvSB3LuLCSeW7g-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-41481f2d826so24754905e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 06:17:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712063828; x=1712668628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CocnoBVJpn99epD+80lqAYY0uYOL6LyKI4I2LjGgdmg=;
 b=dDb6fPp8Kyl8VMJ1S5/tvEy1xoRzU2NKMHYEMhMTbWtsjlkAmZfMMIDBMCOV+tP5Uz
 3k1CmBJHgAQZeOYYe49ASQSN95Gx70qbA+vnyvUWMDeFoJW8re1xwgeTwEBwypocPx86
 VFz3b0lwwKSzY/EhrON+4sp7FzsOVDv4Mf7u7uqtv4ZQTAjd6sZMS9rZbJNcZ3NTm+a8
 wOP2GDZ4V4H4Gu26OT0OnrudLHBpAQRO4DKcNs+I1TEJY8HJqcavczIrh8VC8kUbtc8U
 B8fyOnijzC3YTni8w/hIHZ9f81CmtMjGHkfQy+l2WmySoxf5GmssOVr1sPKsipTtRtXK
 gBHw==
X-Gm-Message-State: AOJu0YzkyRRLA4l2fM0j4mXSSLZT7KZHDklyLpbDxVjFIPFTe+mwjohf
 HFLW3o+PLqfNJ+3r/5ipsFJyM9VU/YQ59+q7YswXmb0IX5wPaFm74h2uiFz+J4IoS7utBNbvySk
 8tvCYFaLpSot6YK27HFcrl5gYGpGOmKJ/0lz9bLKMCdPslAonUozsQ7T6+aQWdidSq5L9RYD9ek
 IBglyIMN2dkFtViYmlKYp7O8hTmSliif4OUs32
X-Received: by 2002:a05:600c:450a:b0:413:2852:2835 with SMTP id
 t10-20020a05600c450a00b0041328522835mr8691595wmo.17.1712063828109; 
 Tue, 02 Apr 2024 06:17:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2tDd7NHWqiKtqOmtQidZta/7X3h5gH8gRGgR0tMWpUgCkfJRycGvUD5WS7euJ1fjvwqtEGQ==
X-Received: by 2002:a05:600c:450a:b0:413:2852:2835 with SMTP id
 t10-20020a05600c450a00b0041328522835mr8691573wmo.17.1712063827736; 
 Tue, 02 Apr 2024 06:17:07 -0700 (PDT)
Received: from avogadro.local ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 p2-20020a05600c1d8200b004156daeee90sm3712330wms.4.2024.04.02.06.17.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Apr 2024 06:17:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Chuhong Yuan <hslester96@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 5/7] lsi53c895a: avoid out of bounds access to s->msg[]
Date: Tue,  2 Apr 2024 15:16:47 +0200
Message-ID: <20240402131649.23225-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402131649.23225-1-pbonzini@redhat.com>
References: <20240402131649.23225-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

If no bytes are there to process in the message in phase,
the input data latch (s->sidl) is set to s->msg[-1].  Just
do nothing since no DMA is performed.

Reported-by: Chuhong Yuan <hslester96@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/lsi53c895a.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 71f759a59dd..eb9828dd5ef 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -927,13 +927,18 @@ static void lsi_do_msgin(LSIState *s)
     assert(len > 0 && len <= LSI_MAX_MSGIN_LEN);
     if (len > s->dbc)
         len = s->dbc;
-    pci_dma_write(PCI_DEVICE(s), s->dnad, s->msg, len);
-    /* Linux drivers rely on the last byte being in the SIDL.  */
-    s->sidl = s->msg[len - 1];
-    s->msg_len -= len;
-    if (s->msg_len) {
-        memmove(s->msg, s->msg + len, s->msg_len);
-    } else {
+
+    if (len) {
+        pci_dma_write(PCI_DEVICE(s), s->dnad, s->msg, len);
+        /* Linux drivers rely on the last byte being in the SIDL.  */
+        s->sidl = s->msg[len - 1];
+        s->msg_len -= len;
+        if (s->msg_len) {
+            memmove(s->msg, s->msg + len, s->msg_len);
+        }
+    }
+
+    if (!s->msg_len) {
         /* ??? Check if ATN (not yet implemented) is asserted and maybe
            switch to PHASE_MO.  */
         switch (s->msg_action) {
-- 
2.44.0


