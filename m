Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5745AC6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 13:18:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rre17-00073P-IW; Tue, 02 Apr 2024 09:17:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rre0s-00061Y-A8
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 09:17:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rre0i-0006Vc-HR
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 09:17:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712063825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sXc6p7CLAD9wC+be/di+J8sDpAR+vHjnFWOEwaQyh7w=;
 b=PpO7df6p+cg33wwPfQpiuELIc+R1pKoMhG4hA/WHqTfOpDGsaSBZJApLFCibPjPU6+nkZ/
 0bXcVOHZRI2PXcolYtOaPXz8eU4tRUNN3l7PnwDcd2f1ZIjDf/S9Zp3lA3X7NiBATmKmLC
 cePlqb+Wa58I5AXoc6fb7ez2FBUKZWQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-H9jqlAbaNkq-OH6lbvQlhQ-1; Tue, 02 Apr 2024 09:17:04 -0400
X-MC-Unique: H9jqlAbaNkq-OH6lbvQlhQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-33ec308655eso1440219f8f.0
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 06:17:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712063822; x=1712668622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sXc6p7CLAD9wC+be/di+J8sDpAR+vHjnFWOEwaQyh7w=;
 b=xSyq7PwGtT6VsLFqCSf60jYedrj3+8+GVnSji3Huqn29jmMLQMOwoGL8T1rDsHRbf7
 nguDYq7jBmk5rgbsADWeE/TDzb5q07NoyCBuY/2EkmulwIaETUYaOTmVc3NU3sZ4EnsS
 9wCiOm0i87reudrOFiJq68N/4cdXTiHGrtrWmkqhDO4a7tcYBQzfLmixhNmA5UIbwEXo
 whZg2CZYtC0wdUj1yE3OuS9C29TE9QTWhOzVTUA2mM+WxewFNH/bS+VrjGRWcPAETHhD
 U8jjyehANT7Lby4RFys4D1PhSLdj39yCF2t7h86fBiHMYAePxaOhIuXL9eEdWSgId3ts
 QVJg==
X-Gm-Message-State: AOJu0Yz9aYmfFmmR5W+m2ycgFnd+tsQh2Z9cwoSgc4yz6AHEaTYY+Pld
 j8Opof+iKC3vadb4lIwKJItiVAhQWrC/7KxyJlm6wLexkX+3kJp+T584LlooVWySFdxrXok1NKl
 qB0Ndicr3z7WK8hKeOEYKuGNnqAnevyGlkoyf61ousMB8ao9ijVCt1AR6oMazEnY33BNGw9JCqM
 Rgoj64oSTQkNP5tnerF+qDfVfgjp0tLBNFFbr1
X-Received: by 2002:adf:ee85:0:b0:343:6a91:5080 with SMTP id
 b5-20020adfee85000000b003436a915080mr1200186wro.29.1712063822147; 
 Tue, 02 Apr 2024 06:17:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdSYup3aOvDZ/oAcWikjhBFeRtMHdRh4jZ3+KlRysp7x4TCHP3BMHL9CGarEXyf5b1NnpeXA==
X-Received: by 2002:adf:ee85:0:b0:343:6a91:5080 with SMTP id
 b5-20020adfee85000000b003436a915080mr1200175wro.29.1712063821779; 
 Tue, 02 Apr 2024 06:17:01 -0700 (PDT)
Received: from avogadro.local ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 dq2-20020a0560000cc200b00341e24a586fsm14081270wrb.93.2024.04.02.06.16.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Apr 2024 06:17:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Helge Konetzka <hk@zapateado.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 3/7] vga: adjust dirty memory region if pel panning is active
Date: Tue,  2 Apr 2024 15:16:45 +0200
Message-ID: <20240402131649.23225-4-pbonzini@redhat.com>
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

When pel panning is active, one more byte is read from each of the VGA
memory planes.  This has to be accounted in the computation of region_end,
otherwise vga_draw_graphic() fails an assertion:

qemu-system-i386: ../system/physmem.c:946: cpu_physical_memory_snapshot_get_dirty: Assertion `start + length <= snap->end' failed.

Reported-by: Helge Konetzka <hk@zapateado.de>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2244
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/display/vga.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/display/vga.c b/hw/display/vga.c
index b4ceff70eb8..40acd19e72a 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -1571,11 +1571,15 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
             break;
         }
     }
+    hpel = bits <= 8 ? s->params.hpel : 0;
 
     region_start = (s->params.start_addr * 4);
     region_end = region_start + (ram_addr_t)s->params.line_offset * height;
     region_end += width * depth / 8; /* scanline length */
     region_end -= s->params.line_offset;
+    if (hpel) {
+        region_end += 4;
+    }
     if (region_end > s->vbe_size || depth == 0 || depth == 15) {
         /*
          * We land here on:
@@ -1660,7 +1664,6 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
            width, height, v, line_offset, s->cr[9], s->cr[VGA_CRTC_MODE],
            s->params.line_compare, sr(s, VGA_SEQ_CLOCK_MODE));
 #endif
-    hpel = bits <= 8 ? s->params.hpel : 0;
     addr1 = (s->params.start_addr * 4);
     bwidth = DIV_ROUND_UP(width * bits, 8);
     if (hpel) {
-- 
2.44.0


