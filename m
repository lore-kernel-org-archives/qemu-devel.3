Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A938CC3ABA9
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 03:34:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAh8l-00066f-At; Thu, 01 May 2025 23:32:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAh8X-0005f4-Gj
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:32:31 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAh8V-0001Ln-Se
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:32:29 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7369ce5d323so1540548b3a.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 20:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746156746; x=1746761546; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RcPVYeeQT1GwwWrtzjsEjtZuBAgtjHa2HHwNwJdBE50=;
 b=VUmx/zBtCvqEwGDwLuhhCqftExFPF3YUcQA8MFe/0OoL/2P9fIX6beMG/k6Dc6Puxc
 A8bvcP7jQWoADgHjS4emwipgMNfQhT/bnHeCNeFjDqs+xw6hZvXp0tmn1xAFQwur+ir3
 vmdVatCl9VvF0DKFk31SE1qpv2wrW9lAJYJullptQ0EGNLn+LfS0Lauc6pIequJdEo6k
 t85H+l3BcCf4uTM2OKZ45uUV3K6LeQEO03006BAQhX8rN4hX+A0pj4wVWkSeFa4tEcxC
 YaNaK7cr263aI6ttne8PAyzOtH8Pnom1Xrho/GZ+mc4sHQbkg5azNK5x+15B2GnPJK9V
 SCgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746156746; x=1746761546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RcPVYeeQT1GwwWrtzjsEjtZuBAgtjHa2HHwNwJdBE50=;
 b=Dvv0EIFUGL7Qd+6BDKHlVlf4vLRvviAMmUbUgd84VbJ493e3hXFLTvdFLeTrNsSfB9
 TZHbwA/2iBiR4tc4MbmD+R9vcFTgG/BqgsC2QyUl2geI1AeAHy28sMtKjomWbLzv/JJq
 xXYfv6E2p6zBACXtU7wcCr2aRPcoANS1hZiOPwde3vKPNT21JSTlbfxilqWK69QYkt2W
 HL+fnZ/Wpuk/qV+MZxDYejycwFBhACo2E+Pcy7xOMcbfiQKADtEyHkR2ym5kJwyqhGgA
 Bp0y2DzZvg1pRunMQMyRIY8EH7k9oEVVnIwvpVGBT8fI09SjpWv8qdM+s4NNgfMQ6dVZ
 VNXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfTXdsHJ45+yC4O6lQDlYUhh4ENejadpYcglW6pYCX+PzillR2c2/Z4YqvP8IlysAzvGlbWXUa/Aiu@nongnu.org
X-Gm-Message-State: AOJu0Yx0+3GiQ2iEWVe5P4QBUg7kMWjbn7E6rL+z+8xXQWFUpMpyGPDb
 pmDX68KsOVTIxqHCPqTs28QyhM7co1/WVBwt5YUTRajzljOoRLI5
X-Gm-Gg: ASbGncvRmV+m5WIgBYb8tfelRCTQ0A3rVs6zhYsZzxmlVXmI7oIrbeiUhCrLoJrXOCZ
 DiihuQFv1SACsI3qKu3lBFNMEFVrt6WXyyyYvHsN6XVaBlLwOADOa73chnUahp0sC6VCCKdy7Kz
 EIjwde1gSnQJm1DFR82p/B0sYzWy0FOle48vJiHR5WAZEcaPkuUxO7fSmu+mZ6ke/wms6tznd1u
 Unnhg16Hqas/8x5xGQdQt5UrYTxaxmnqD53SQbaHXEN/PzquE/eYdO/gyLPaBFKnUKeiHduQtys
 EhKCFtrtRY6oFMn4aw9oM6fMLqVuLxg9lrcUyj3Q4Ctg
X-Google-Smtp-Source: AGHT+IGHUzCQEK2l4Q1hKUH4O18BZ5dvIKwp1u0MPThZChab+Vu/BFhbVVJTWGl2oXoUler738BCnw==
X-Received: by 2002:a05:6a00:6c9b:b0:736:3979:369e with SMTP id
 d2e1a72fcca58-74058a1af4cmr1682748b3a.9.1746156746609; 
 Thu, 01 May 2025 20:32:26 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059063f6esm488055b3a.139.2025.05.01.20.32.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 20:32:26 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 17/22] usb/msd: Add some additional assertions
Date: Fri,  2 May 2025 13:30:41 +1000
Message-ID: <20250502033047.102465-18-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502033047.102465-1-npiggin@gmail.com>
References: <20250502033047.102465-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add more assertions to help verify internal logic.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/usb/dev-storage.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index 66fffda3713..81bfdf08992 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -271,13 +271,24 @@ void usb_msd_transfer_data(SCSIRequest *req, uint32_t len)
     MSDState *s = DO_UPCAST(MSDState, dev.qdev, req->bus->qbus.parent);
     USBPacket *p = s->data_packet;
 
-    if ((s->mode == USB_MSDM_DATAOUT) != (req->cmd.mode == SCSI_XFER_TO_DEV)) {
-        usb_msd_fatal_error(s);
-        return;
+    if (s->mode == USB_MSDM_DATAIN) {
+        if (req->cmd.mode == SCSI_XFER_TO_DEV) {
+            usb_msd_fatal_error(s);
+            return;
+        }
+    } else if (s->mode == USB_MSDM_DATAOUT) {
+        if (req->cmd.mode != SCSI_XFER_TO_DEV) {
+            usb_msd_fatal_error(s);
+            return;
+        }
+    } else {
+        g_assert_not_reached();
     }
 
+    assert(s->scsi_len == 0);
     s->scsi_len = len;
     s->scsi_off = 0;
+
     if (p) {
         usb_msd_copy_data(s, p);
         p = s->data_packet;
@@ -295,6 +306,10 @@ void usb_msd_command_complete(SCSIRequest *req, size_t resid)
 
     trace_usb_msd_cmd_complete(req->status, req->tag);
 
+    g_assert(s->req);
+    /* The CBW is what starts the SCSI request */
+    g_assert(s->mode != USB_MSDM_CBW);
+
     s->csw.sig = cpu_to_le32(0x53425355);
     s->csw.tag = cpu_to_le32(req->tag);
     s->csw.residue = cpu_to_le32(s->data_len);
@@ -493,7 +508,7 @@ static void usb_msd_handle_data_out(USBDevice *dev, USBPacket *p)
         trace_usb_msd_cmd_submit(cbw.lun, tag, cbw.flags,
                                  cbw.cmd_len, s->data_len);
         assert(le32_to_cpu(s->csw.residue) == 0);
-        s->scsi_len = 0;
+        assert(s->scsi_len == 0);
         s->req = scsi_req_new(scsi_dev, tag, cbw.lun,
                               cbw.cmd, cbw.cmd_len, NULL);
         if (s->commandlog) {
-- 
2.47.1


