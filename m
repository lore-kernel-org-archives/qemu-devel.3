Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 157B5C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 11:36:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrcPP-0007Pa-C7; Tue, 02 Apr 2024 07:34:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rrcPN-0007OH-65
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 07:34:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rrcPH-0006Lv-80
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 07:34:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712057657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jVfzihO5qwox85ndrhEpPEDkR5EZjIIkF6NFUMuvYM0=;
 b=A3Wc9R+5HqFn3vjovYInnIConglfpVBgon5IRTsK38oYn3BHeomhcOBiYA+JTL2x+KSxvg
 1U8R4fJTRRwvWqASWOPf6aeb3EPRbaUtQoPs5msWaCzt62tG9/NdgRRqMDCvgJ8PIog55S
 5SQTAYUQrmGQeqIN6XRxoYItLwv7ghs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-S2DhWb8wO9-ROwiKCirxeQ-1; Tue, 02 Apr 2024 07:34:16 -0400
X-MC-Unique: S2DhWb8wO9-ROwiKCirxeQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-415591b1500so12337425e9.3
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 04:34:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712057654; x=1712662454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jVfzihO5qwox85ndrhEpPEDkR5EZjIIkF6NFUMuvYM0=;
 b=L1aRbPXC9LpLIG9XCQUGnlgMxic/8dZAxbbFXXfRKVgjTixYbPoVuKhcBViAkg3BHY
 CjydySL7oj+z65/7V1Ai/HWKsDHnp1GqB4HIAVyxAi1GTIznBsBv99ROPnG3fNAZQFXX
 8M4NYpoWFFaQrD4yFezaf6xjvM3csk4kxS9DjBwJ2FIffrEnF4ombyOxttL2T/B/HlB9
 hgwBFKkVAJ98kJXJBOw0vlXSKRW17sjrgWr91VXwBKOOpXoIJvgn1bA8PdhEn9k+O/te
 6M4SY7p2o7FHei3VxLAb4f4zzmajDsZJHIi7Is0yNSsBvJb2NiAD9cRAjhcvzIXRYiBP
 Ki0g==
X-Gm-Message-State: AOJu0Yz4InTll4lckVybGdUW+5cXNRMUyDen2qXOtxOPo5m0WlYkXzBE
 o/DHqGXS5wSj7sfcl7g0q5isgbo/hr/27kiwuRc5Xuz2iz83Tmj14WdoSDJagM/Hdd50yIh7s3p
 QGHhnFyylnYSc7Q+aB8kz+12gJa2K3x3LLlZAG8iAoZRFL+BgAEJTya8A29/+AonOmaryimD0N2
 sP9gfu/8JlBK95x/CIkfedotRXh52oLb3n8wAo
X-Received: by 2002:a7b:c34d:0:b0:416:1c9f:3a3f with SMTP id
 l13-20020a7bc34d000000b004161c9f3a3fmr822885wmj.9.1712057654345; 
 Tue, 02 Apr 2024 04:34:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPo7i3/AN+KKJkuYxtXmCTZweEY6sOXKmxVd6sSDivthDQCYjcueP78YrrZ7yYC3EoaK9B+Q==
X-Received: by 2002:a7b:c34d:0:b0:416:1c9f:3a3f with SMTP id
 l13-20020a7bc34d000000b004161c9f3a3fmr822863wmj.9.1712057653859; 
 Tue, 02 Apr 2024 04:34:13 -0700 (PDT)
Received: from avogadro.local ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 f14-20020a05600c154e00b00414674a1a40sm17593545wmg.45.2024.04.02.04.34.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Apr 2024 04:34:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Helge Konetzka <hk@zapateado.de>
Subject: [PATCH for-9.0 1/4] vga: merge conditionals on shift control register
Date: Tue,  2 Apr 2024 13:34:03 +0200
Message-ID: <20240402113408.18048-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402113408.18048-1-pbonzini@redhat.com>
References: <20240402113408.18048-1-pbonzini@redhat.com>
MIME-Version: 1.0
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


