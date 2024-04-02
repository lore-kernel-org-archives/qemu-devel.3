Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 294D9C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 11:34:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrcPS-0007Qg-Cl; Tue, 02 Apr 2024 07:34:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rrcPQ-0007QF-Bo
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 07:34:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rrcPN-0006UR-6c
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 07:34:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712057667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2PZavkeH6OTmLymO5kneMvG0lPUU9tg04m/0+lSsdoU=;
 b=d9w8QeQ5qNqqeoFAZF4GtgOEYWuG3wMViqt0QUCjSDhG7i7vujZiiZxCPzYGIcdv+J6iyh
 LMNr0a6Q+BB8x+e2tJSgNSPomrrei0DWpz6zXoE5tzmvL0kqs7uFVdRkHqMH4gH/WHqwv3
 FeXG2ib5pu6rhHy/y0WPZMB/R5n6Dns=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-d7nl4wmDOa-iGfIGDPuWow-1; Tue, 02 Apr 2024 07:34:25 -0400
X-MC-Unique: d7nl4wmDOa-iGfIGDPuWow-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4140bf38378so32837945e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 04:34:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712057664; x=1712662464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2PZavkeH6OTmLymO5kneMvG0lPUU9tg04m/0+lSsdoU=;
 b=fqJC8brgIaHttJdeNVhbHbdU5WpMjzA+oZ3ec0ut69CjqzSe68d/f7GcpH2K7GlDDg
 zIhiALzrOdrOcEB/DXqe1Eb+grPMks+rTlWs3jayNxqvDTEGIeZC9NzJvh+qt4oV7LNQ
 xGfgFei0yp4Sw2I1hZoOOn3VMeOz9mvW+8UUXvgPl9bGrT8vVa4Gdg4FCQiAqLpbVf7I
 Fa7xXZK7CPXo7M0UBNLq++OHRNj7vjfhVAhU4MJsF4XbvHCeojwTICqsQC08L75/2xlf
 1moJzhOfKu1MKXF8ufHquWzosSj7L5Mmmt8VV4SoJLk+8JaqbnLVls55XVJAs7WAqmQU
 aiVw==
X-Gm-Message-State: AOJu0Yx+XgDIkLzy0Syu3U0xU0yb9a5C8pwFE1XxkX9Tn16iw/XEBCd1
 aVZfojuYGCXUN6atqbtRy8tvL50d+05Yu/sZ4kH9Bl/vv7GtBx6SoCAs4IZRdtj3muvZ1KUOLxt
 6/IUBaqpMyOszam8O37JEb9bFWltnD9/x0/Ejl9YRBH5IVb78RHZPVuE6h30NfGkx6FDvaE7lmt
 8F5Gc0fnfm0bQr3cMbmWCMg2UVmn+EXQ74+YvJ
X-Received: by 2002:a05:600c:68c3:b0:414:84f9:2a2d with SMTP id
 jd3-20020a05600c68c300b0041484f92a2dmr1412177wmb.27.1712057663987; 
 Tue, 02 Apr 2024 04:34:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGe3yXg5avfW25nfnniDlk7L1kz8YGkoA8tCsdNPhV/FMnT8m34DbiozdksRJVFP+oTn63tnQ==
X-Received: by 2002:a05:600c:68c3:b0:414:84f9:2a2d with SMTP id
 jd3-20020a05600c68c300b0041484f92a2dmr1412166wmb.27.1712057663721; 
 Tue, 02 Apr 2024 04:34:23 -0700 (PDT)
Received: from avogadro.local ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 hg8-20020a05600c538800b0041565d750e1sm6132030wmb.2.2024.04.02.04.34.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Apr 2024 04:34:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Helge Konetzka <hk@zapateado.de>
Subject: [PATCH for-9.0 4/4] vga: do not treat horiz pel panning value of 8 as
 "enabled"
Date: Tue,  2 Apr 2024 13:34:06 +0200
Message-ID: <20240402113408.18048-5-pbonzini@redhat.com>
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

Horizontal pel panning bit 3 is only used in text mode.  In graphics
mode, it can be treated as if it was zero, thus not extending the
dirty memory region.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/display/vga.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/display/vga.c b/hw/display/vga.c
index 40acd19e72a..77f59e8c113 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -1571,7 +1571,9 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
             break;
         }
     }
-    hpel = bits <= 8 ? s->params.hpel : 0;
+
+    /* Horizontal pel panning bit 3 is only used in text mode.  */
+    hpel = bits <= 8 ? s->params.hpel & 7 : 0;
 
     region_start = (s->params.start_addr * 4);
     region_end = region_start + (ram_addr_t)s->params.line_offset * height;
-- 
2.44.0


