Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C2EBCD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 11:35:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrcPQ-0007QD-9X; Tue, 02 Apr 2024 07:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rrcPN-0007OJ-8P
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 07:34:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rrcPH-0006OA-8D
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 07:34:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712057660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A4JYBpR7d9bXiV3mmVNLQk1XfWu8hA7QaepUPCUq7d4=;
 b=Atk7kMrg1h7KpoKlg+F3LVIa4GbV6jJd8L+ZmtdoiQiUTpVjvGe6zXR/EoV1V48XAGSLbE
 8ZTEdEFVvZeoYkRe/nXsp6yKuQDtrFc2igvaYVqjvv+x/Rul7H9gN+BAiGNV9mgvRbu2iV
 RmzY1x2/q2bTqKKWN4iC5vyV/ACQBiU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-e0CO5nNhOm-U6MKx1TjWoQ-1; Tue, 02 Apr 2024 07:34:19 -0400
X-MC-Unique: e0CO5nNhOm-U6MKx1TjWoQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4140bf38378so32837315e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 04:34:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712057657; x=1712662457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A4JYBpR7d9bXiV3mmVNLQk1XfWu8hA7QaepUPCUq7d4=;
 b=Mbig4jk16HsQduDafxQ19Z+CmBgCXrEqw41AaPXv3hl6urfiKf4pa3F1EV7FvuWKXw
 yzgE4xPS5Cwu8ByOOgqTL35HgQKZbXCVS4TvgpkUHsOtAaq5rM3nK0Zr0itUuQDBWsnk
 ww3j3+r+43g7b4gZpJxlzsO/LgNO189DZw9LWrQmcwxMXRZVwBDqWgSJh4V8JX0YZXez
 zjSMN6atqK18ugnG2dEQd2yXPAsuJ68BZHtY3UsE8cnnbuj6JpHd91vwgrifCi3a6l7R
 ZGbAw6g4zGyCLpn8RS5yN6liis529FwJDQgldslpDkgtlEwa43VZJaOm2HLUYL26pcSa
 Pasg==
X-Gm-Message-State: AOJu0YxPS1x/dR6maPI063WnpeGrYXrhsNqqQziauZ7eHoEezZ9T115w
 YG1rrKb7iYAv42eZDoYR68rIUtiomAOmWu0TeokvQvq5RsqUcMendOvY+fsjkZVm0DDwwU30sky
 32G2A0NAkFt+2nNbTVe7JQxuiUh2P1pfhAubA/L6IEpyRIBXMPLvaXLcpzX2FUr34BdZhdA7MB7
 ZDSj7pUVpx4egc/FBSRhl2bMSim+EVUi07ZUU2
X-Received: by 2002:a05:600c:2d06:b0:413:e19:337f with SMTP id
 x6-20020a05600c2d0600b004130e19337fmr1234821wmf.22.1712057657405; 
 Tue, 02 Apr 2024 04:34:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8pz9t/6KkhJ8Ys2iw2frRi/c9UpOITM0EBRj/t1FdRSp8PkljNWEyRkQQVPT+31a8EDSkcQ==
X-Received: by 2002:a05:600c:2d06:b0:413:e19:337f with SMTP id
 x6-20020a05600c2d0600b004130e19337fmr1234808wmf.22.1712057657133; 
 Tue, 02 Apr 2024 04:34:17 -0700 (PDT)
Received: from avogadro.local ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 fs11-20020a05600c3f8b00b004146dd6bfe2sm17560887wmb.47.2024.04.02.04.34.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Apr 2024 04:34:15 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Helge Konetzka <hk@zapateado.de>
Subject: [PATCH for-9.0 2/4] vga: move computation of dirty memory region later
Date: Tue,  2 Apr 2024 13:34:04 +0200
Message-ID: <20240402113408.18048-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402113408.18048-1-pbonzini@redhat.com>
References: <20240402113408.18048-1-pbonzini@redhat.com>
MIME-Version: 1.0
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


