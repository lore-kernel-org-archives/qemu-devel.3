Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7DF0CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 13:17:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rre15-0006so-3v; Tue, 02 Apr 2024 09:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rre0s-00061N-9r
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 09:17:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rre0a-0006RA-Gk
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 09:17:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712063818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=roYxGpFR04h/jwKow/xP9fciI3L1ZyNKVolEJHZVFKA=;
 b=KK9MQpBzcxEKMxapH2ElcAub+QeKD/mUorMz3qXYWZIFgY/PXwZwTKWqKwCYvJ1lWLea+q
 BO+0bNummVp02dMynx1y5cVLgR0E1o76s/NvrkG+Q68aReLJbgXRq7WvsCnsn9d1rKN44s
 yeuOd152GVjqyJ77AZ+0TZm9F0Hy6rE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-c0OmjeMrNOSAII1RQ8UKjQ-1; Tue, 02 Apr 2024 09:16:57 -0400
X-MC-Unique: c0OmjeMrNOSAII1RQ8UKjQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-343400a3afcso2381508f8f.0
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 06:16:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712063815; x=1712668615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=roYxGpFR04h/jwKow/xP9fciI3L1ZyNKVolEJHZVFKA=;
 b=SsXErJGNN3rwbcMaYKaY4XXgOtqeLS0M5mLqxQLNQhuc7U1v4ByM1rA5MogyivuCjG
 GikaLTttc85jFvYrFiJTztpFeRAw7pF9XZqGz6Ex/TiCHIquIPaQrn/gJWpQrhK9ZB13
 WqVgZmWS5mB4gmrsOzFocUFMc7EAPSQ+s3bACozTZw+k+QfcJ5iNtx+4eJaAA84LyXCs
 Ps3xXRFaL1vOhVglnXefHkARAx+b9MntysVBiG5GiF4S3FaaqWalnTgUiOg3tWoxeKXG
 VwMDoX5Ynlj5C2j0C24MdVqIT3w/BIAFrpvdvUT4+He4n7xmeE93Edi4UGibdPC7f9ON
 wT4g==
X-Gm-Message-State: AOJu0YynRIlL0rrgy4NfOGX8a+cKrz73W0s9L0uUxJLIq3kmvAjB65AH
 usApb28IYilERaT/99h4og+MomekkD+BMaAekoOVWiFDQYWxofg1B+hv4Zt1J1gkr17Qo43nAxG
 ZfSSTpbQ02FFa0W8vKJwCFmzLvielMSNxyqV+QRMN7m0aWX/LHxidFE9dbijD1fw4QFyW2e1I3N
 +y1UGrlarQV/tNwA4eaqauioaeCKSrfO7wy4Ml
X-Received: by 2002:a5d:6c63:0:b0:343:3e5b:e8af with SMTP id
 r3-20020a5d6c63000000b003433e5be8afmr8299692wrz.52.1712063814950; 
 Tue, 02 Apr 2024 06:16:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGv9rfS994LOeFSg9rWMBVOh/d4CewI5kVkEQRRqiaNbuyjgTWsRss50ukeMi/VFu+3mLoecw==
X-Received: by 2002:a5d:6c63:0:b0:343:3e5b:e8af with SMTP id
 r3-20020a5d6c63000000b003433e5be8afmr8299679wrz.52.1712063814639; 
 Tue, 02 Apr 2024 06:16:54 -0700 (PDT)
Received: from avogadro.local ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 m19-20020a056000025300b0033e7de97214sm14073414wrz.40.2024.04.02.06.16.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Apr 2024 06:16:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 1/7] vga: merge conditionals on shift control register
Date: Tue,  2 Apr 2024 15:16:43 +0200
Message-ID: <20240402131649.23225-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402131649.23225-1-pbonzini@redhat.com>
References: <20240402131649.23225-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

There are two sets of conditionals using the shift control bits: one to
verify the palette and adjust disp_width, one to compute the "v" and
"bits" variables.  Merge them into one, with the extra benefit that
we now have the "bits" value available early and can use it to
compute region_end.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/display/vga.c | 89 +++++++++++++++++++++++-------------------------
 1 file changed, 42 insertions(+), 47 deletions(-)

diff --git a/hw/display/vga.c b/hw/display/vga.c
index bc5b83421bf..4795a0012e2 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -1546,12 +1546,54 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
     }
 
     if (shift_control == 0) {
+        full_update |= update_palette16(s);
         if (sr(s, VGA_SEQ_CLOCK_MODE) & 8) {
             disp_width <<= 1;
+            v = VGA_DRAW_LINE4D2;
+        } else {
+            v = VGA_DRAW_LINE4;
         }
+        bits = 4;
+
     } else if (shift_control == 1) {
+        full_update |= update_palette16(s);
         if (sr(s, VGA_SEQ_CLOCK_MODE) & 8) {
             disp_width <<= 1;
+            v = VGA_DRAW_LINE2D2;
+        } else {
+            v = VGA_DRAW_LINE2;
+        }
+        bits = 4;
+
+    } else {
+        switch (depth) {
+        default:
+        case 0:
+            full_update |= update_palette256(s);
+            v = VGA_DRAW_LINE8D2;
+            bits = 4;
+            break;
+        case 8:
+            full_update |= update_palette256(s);
+            v = VGA_DRAW_LINE8;
+            bits = 8;
+            break;
+        case 15:
+            v = s->big_endian_fb ? VGA_DRAW_LINE15_BE : VGA_DRAW_LINE15_LE;
+            bits = 16;
+            break;
+        case 16:
+            v = s->big_endian_fb ? VGA_DRAW_LINE16_BE : VGA_DRAW_LINE16_LE;
+            bits = 16;
+            break;
+        case 24:
+            v = s->big_endian_fb ? VGA_DRAW_LINE24_BE : VGA_DRAW_LINE24_LE;
+            bits = 24;
+            break;
+        case 32:
+            v = s->big_endian_fb ? VGA_DRAW_LINE32_BE : VGA_DRAW_LINE32_LE;
+            bits = 32;
+            break;
         }
     }
 
@@ -1607,53 +1649,6 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
         }
     }
 
-    if (shift_control == 0) {
-        full_update |= update_palette16(s);
-        if (sr(s, VGA_SEQ_CLOCK_MODE) & 8) {
-            v = VGA_DRAW_LINE4D2;
-        } else {
-            v = VGA_DRAW_LINE4;
-        }
-        bits = 4;
-    } else if (shift_control == 1) {
-        full_update |= update_palette16(s);
-        if (sr(s, VGA_SEQ_CLOCK_MODE) & 8) {
-            v = VGA_DRAW_LINE2D2;
-        } else {
-            v = VGA_DRAW_LINE2;
-        }
-        bits = 4;
-    } else {
-        switch(s->get_bpp(s)) {
-        default:
-        case 0:
-            full_update |= update_palette256(s);
-            v = VGA_DRAW_LINE8D2;
-            bits = 4;
-            break;
-        case 8:
-            full_update |= update_palette256(s);
-            v = VGA_DRAW_LINE8;
-            bits = 8;
-            break;
-        case 15:
-            v = s->big_endian_fb ? VGA_DRAW_LINE15_BE : VGA_DRAW_LINE15_LE;
-            bits = 16;
-            break;
-        case 16:
-            v = s->big_endian_fb ? VGA_DRAW_LINE16_BE : VGA_DRAW_LINE16_LE;
-            bits = 16;
-            break;
-        case 24:
-            v = s->big_endian_fb ? VGA_DRAW_LINE24_BE : VGA_DRAW_LINE24_LE;
-            bits = 24;
-            break;
-        case 32:
-            v = s->big_endian_fb ? VGA_DRAW_LINE32_BE : VGA_DRAW_LINE32_LE;
-            bits = 32;
-            break;
-        }
-    }
     vga_draw_line = vga_draw_line_table[v];
 
     if (!is_buffer_shared(surface) && s->cursor_invalidate) {
-- 
2.44.0


