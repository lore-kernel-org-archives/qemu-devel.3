Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14CE2CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 11:35:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrcPZ-0007SA-Q7; Tue, 02 Apr 2024 07:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rrcPT-0007R4-AE
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 07:34:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rrcPP-0006a1-In
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 07:34:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712057670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ibQM6JbOztIOF6BAzKgIao5EgyqQZHeEw2BMtuP36D0=;
 b=gTgrOQ321nwBTobmB9VZJTS//y/LPihJlVNNClgIxYVQvCAL9TUuVVTpwF5okungEBr1Xx
 AJ5BNIau8qLLjRbKo6UKDPF27VnrU2WXqceqpsq1DNutseszPanodt0j3EBFUXiq62Lqz6
 9l7diW30w8+grhiDmC7VaKqXwo/Vi1Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-jgFMjfbhM0WQT5oOfo_zKA-1; Tue, 02 Apr 2024 07:34:29 -0400
X-MC-Unique: jgFMjfbhM0WQT5oOfo_zKA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-341678a510bso3244564f8f.1
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 04:34:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712057667; x=1712662467;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ibQM6JbOztIOF6BAzKgIao5EgyqQZHeEw2BMtuP36D0=;
 b=uVT4wgDML7aDS0ugkEfxoj1lGTtm+lE+ggK28O2z9O2fVg5r6mdkfqI/GUpW6tYm0J
 lbDz6RUgOQWDfTMxuZL3DrnVngH+Y/zjZh1+zEWLWfdyahGZB16/eGAJZZsuUERcx0Ln
 OXDK1C9oCa5cYQt9velFb/wwroYVWgJB69S15Na23dFfzRuIdfu9sDggM0UxrJyzLfDd
 4LMfgfMV1D5E/3l2eBHTBrTiQIsJlP7mHeFR+T/PB4Ri98TJY1he6BCNluDGM+QDCcRo
 XkQtnOla5nItGB60FMj0Q9/NxeSQkcTXqlb4aYq+zkhNCk7mrkCKFXZp7pM2MA9j7G97
 TzzA==
X-Gm-Message-State: AOJu0YwC/nMaQABobIApbXcGKKqVFtm1fg2QLDvJepEN8NoQzh2qp/P4
 kEaFGTIBVLf3RXeSeQjiFgZ10QKyAqmJQHQvog8z7zD2eP6jSpJDsC+oCB/qqiXGNCPtMBCOKPd
 QfAkt0Wu0gc/IzflwAPJ4sBmpVlQNxIvYjqzBw21p/eH9mzaO4v7uYEJj8JgjLSGYD7HjtDXP0h
 /iGHtc2F3V44kNQGatUM7kKQk/g9okuzcZmSLb
X-Received: by 2002:a05:6000:1a4f:b0:343:7a64:7c25 with SMTP id
 t15-20020a0560001a4f00b003437a647c25mr261667wry.51.1712057667278; 
 Tue, 02 Apr 2024 04:34:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6QpcH3mA9M+OmBGmACdHWGz21Q41aroEapwtjKXlT+nbepfct7gNfYRM4EzXbttNguGRIDg==
X-Received: by 2002:a05:6000:1a4f:b0:343:7a64:7c25 with SMTP id
 t15-20020a0560001a4f00b003437a647c25mr261649wry.51.1712057666658; 
 Tue, 02 Apr 2024 04:34:26 -0700 (PDT)
Received: from avogadro.local ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 ch9-20020a5d5d09000000b0034330c9eccasm13568608wrb.79.2024.04.02.04.34.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Apr 2024 04:34:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Helge Konetzka <hk@zapateado.de>
Subject: [PATCH for-9.1 5/4] vga: optimize computation of dirty memory region
Date: Tue,  2 Apr 2024 13:34:07 +0200
Message-ID: <20240402113408.18048-6-pbonzini@redhat.com>
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

The depth == 0 and depth == 15 have to be special cased because
width * depth / 8 does not provide the correct scanline length.
However, thanks to the recent reorganization of vga_draw_graphic()
the correct value of VRAM bits per pixel is available in "bits".

Use it (via the same "bwidth" computation that is used later in
the function, and that already takes into account pel panning),
so that the slow path is restricted to the wraparound case.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/display/vga.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/hw/display/vga.c b/hw/display/vga.c
index 77f59e8c113..77d709a3d69 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -1574,22 +1574,16 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
 
     /* Horizontal pel panning bit 3 is only used in text mode.  */
     hpel = bits <= 8 ? s->params.hpel & 7 : 0;
+    bwidth = DIV_ROUND_UP(width * bits, 8); /* scanline length */
+    if (hpel) {
+        bwidth += 4;
+    }
 
     region_start = (s->params.start_addr * 4);
-    region_end = region_start + (ram_addr_t)s->params.line_offset * height;
-    region_end += width * depth / 8; /* scanline length */
-    region_end -= s->params.line_offset;
-    if (hpel) {
-        region_end += 4;
-    }
-    if (region_end > s->vbe_size || depth == 0 || depth == 15) {
+    region_end = region_start + (ram_addr_t)s->params.line_offset * (height - 1) + bwidth;
+    if (region_end > s->vbe_size) {
         /*
-         * We land here on:
-         *  - wraps around (can happen with cirrus vbe modes)
-         *  - depth == 0 (256 color palette video mode)
-         *  - depth == 15
-         *
-         * Take the safe and slow route:
+         * On wrap around take the safe and slow route:
          *   - create a dirty bitmap snapshot for all vga memory.
          *   - force shadowing (so all vga memory access goes
          *     through vga_read_*() helpers).
@@ -1667,10 +1661,6 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
            s->params.line_compare, sr(s, VGA_SEQ_CLOCK_MODE));
 #endif
     addr1 = (s->params.start_addr * 4);
-    bwidth = DIV_ROUND_UP(width * bits, 8);
-    if (hpel) {
-        bwidth += 4;
-    }
     y_start = -1;
     d = surface_data(surface);
     linesize = surface_stride(surface);
-- 
2.44.0


