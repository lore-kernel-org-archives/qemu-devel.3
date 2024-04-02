Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C5D5CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 13:19:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rre1A-0007Ib-S4; Tue, 02 Apr 2024 09:17:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rre0s-00061Z-9U
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 09:17:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rre0h-0006Uu-IF
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 09:17:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712063824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kdytqU6zaqhwaFowWcTOUPdoULLFbHrB8YBUdpdDPOI=;
 b=OROfQ2dX3O9YLjW1tYmthHN2kiDFqZHaMZTc3zO9WhEa/IU2U/drFvxKxhL3ml16XNoNiO
 5HekLr1MlTV6F9h7ktGcBFW5J1DIJhWG3zRkwFiD9NM2qakKQt5RL4B+8L9PFbIRqnnwyY
 Eu/gcxIidJi0bxhIdF6d2kLbV6HvrMA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-ESNTsR6GMjKNJG8AUFyBPQ-1; Tue, 02 Apr 2024 09:17:01 -0400
X-MC-Unique: ESNTsR6GMjKNJG8AUFyBPQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-41493ba3fcbso22887095e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 06:17:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712063818; x=1712668618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kdytqU6zaqhwaFowWcTOUPdoULLFbHrB8YBUdpdDPOI=;
 b=ka3W8eiDFVny9mZWxiVx9IrligJGI++b7vEIL1b4XbbEwVpiJnXPiM5cMgMsknJMhq
 ePOONb8VWU7im/8ixEreBGf3bjCaOgBis+YVkGProxRJXJ6C7TSXxouwLdrUKngxp3/U
 R9+B8d3+/WVOtKdQe6JCKiEzPEBdQHLy+3Kdp52qfrbsz2dNdV2DAWwxdfPhKjzsa+Q6
 dBP7/HEyvpzQzGluoqIneXqqG+638KRhnhU+ZtpE32ixbRiBnjXNQNYrz3CelI1ioq51
 rFvn1FZV2EdB96FejROfMCrHFynGMIBmtGeCFx7tTl0D3kw+U6Brtq1U3RvPRs3YoPBr
 2IjQ==
X-Gm-Message-State: AOJu0YxEPfM1sOsBQN8xUzF5RF+UjY1Q7ub6DMBYzqoQXKCduj+tjy+n
 uoy4H09J7UymY8SMHWw8JA2R0QABHP+5KbqZzqvWaqkq+0TfjaYMKBrI87Dnx6Aa05abGOmd/B1
 BXsM5H59tGp7I733reqhV6FXkc80DwFUhEo9lmQHIJYB6FCYhwp+abJmrlAimv+RZm/g5hC4bfZ
 M8r19Dvld0gDg48hkKquL084X6f0js4eY1wS53
X-Received: by 2002:a05:600c:4f93:b0:414:3713:e9a2 with SMTP id
 n19-20020a05600c4f9300b004143713e9a2mr10130139wmq.3.1712063818469; 
 Tue, 02 Apr 2024 06:16:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEP572aIIdXD+0gq6K3dUh/Gk6SAXQqkws9txkkJjcN7Zuh6nymBQOlI/M3+ikOoXy6EPt1kA==
X-Received: by 2002:a05:600c:4f93:b0:414:3713:e9a2 with SMTP id
 n19-20020a05600c4f9300b004143713e9a2mr10130123wmq.3.1712063818135; 
 Tue, 02 Apr 2024 06:16:58 -0700 (PDT)
Received: from avogadro.local ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 z2-20020a05600c0a0200b00415515263b4sm13855462wmp.7.2024.04.02.06.16.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Apr 2024 06:16:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 2/7] vga: move computation of dirty memory region later
Date: Tue,  2 Apr 2024 15:16:44 +0200
Message-ID: <20240402131649.23225-3-pbonzini@redhat.com>
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

Move the computation of region_start and region_end after the value of
"bits" is known.  This makes it possible to distinguish modes that
support horizontal pel panning from modes that do not.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/display/vga.c | 50 ++++++++++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/hw/display/vga.c b/hw/display/vga.c
index 4795a0012e2..b4ceff70eb8 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -1501,31 +1501,6 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
     disp_width = width;
     depth = s->get_bpp(s);
 
-    region_start = (s->params.start_addr * 4);
-    region_end = region_start + (ram_addr_t)s->params.line_offset * height;
-    region_end += width * depth / 8; /* scanline length */
-    region_end -= s->params.line_offset;
-    if (region_end > s->vbe_size || depth == 0 || depth == 15) {
-        /*
-         * We land here on:
-         *  - wraps around (can happen with cirrus vbe modes)
-         *  - depth == 0 (256 color palette video mode)
-         *  - depth == 15
-         *
-         * Take the safe and slow route:
-         *   - create a dirty bitmap snapshot for all vga memory.
-         *   - force shadowing (so all vga memory access goes
-         *     through vga_read_*() helpers).
-         *
-         * Given this affects only vga features which are pretty much
-         * unused by modern guests there should be no performance
-         * impact.
-         */
-        region_start = 0;
-        region_end = s->vbe_size;
-        force_shadow = true;
-    }
-
     /* bits 5-6: 0 = 16-color mode, 1 = 4-color mode, 2 = 256-color mode.  */
     shift_control = (s->gr[VGA_GFX_MODE] >> 5) & 3;
     double_scan = (s->cr[VGA_CRTC_MAX_SCAN] >> 7);
@@ -1597,6 +1572,31 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
         }
     }
 
+    region_start = (s->params.start_addr * 4);
+    region_end = region_start + (ram_addr_t)s->params.line_offset * height;
+    region_end += width * depth / 8; /* scanline length */
+    region_end -= s->params.line_offset;
+    if (region_end > s->vbe_size || depth == 0 || depth == 15) {
+        /*
+         * We land here on:
+         *  - wraps around (can happen with cirrus vbe modes)
+         *  - depth == 0 (256 color palette video mode)
+         *  - depth == 15
+         *
+         * Take the safe and slow route:
+         *   - create a dirty bitmap snapshot for all vga memory.
+         *   - force shadowing (so all vga memory access goes
+         *     through vga_read_*() helpers).
+         *
+         * Given this affects only vga features which are pretty much
+         * unused by modern guests there should be no performance
+         * impact.
+         */
+        region_start = 0;
+        region_end = s->vbe_size;
+        force_shadow = true;
+    }
+
     /*
      * Check whether we can share the surface with the backend
      * or whether we need a shadow surface. We share native
-- 
2.44.0


