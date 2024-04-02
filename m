Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E90CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 11:35:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrcPU-0007RS-2Y; Tue, 02 Apr 2024 07:34:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rrcPR-0007QY-Tn
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 07:34:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rrcPN-0006TE-KU
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 07:34:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712057665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vsJ3Izd2XL5yiZE8pEzDjeLfRrrkDOazFmqaztclj+U=;
 b=D26CxW07D6oMqYA1xO5sff/pPK5HMahpiTn9CilFbRbjQ99NU/PtzPvYT2hmZtoS/UbI7+
 0p5vBEzv8m6qlZSS1IZZ6QkbEYBObis1Ouf6AMOPPf0g/5SYHytDE6tpEYRCOAb7di+d96
 PichxmtTEtHIByE2TyWJOhEWdCtDXzA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-BmuwecU4PjWVqx6PYUJnyQ-1; Tue, 02 Apr 2024 07:34:23 -0400
X-MC-Unique: BmuwecU4PjWVqx6PYUJnyQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-41489c04f8cso26028625e9.3
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 04:34:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712057661; x=1712662461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vsJ3Izd2XL5yiZE8pEzDjeLfRrrkDOazFmqaztclj+U=;
 b=f26yoznk4takGKV8SEVmrF5VkMTlqEBYEpjdsLTSMSD0U0mSHrhmc5ZxmUsailtGxT
 w5m8PUH9m4dVXBHcw5G7S0C0oY0GQPAZAjK9mHKuUiZ00mLM1oyVbeyZUhyAjbIUl7O+
 5Ox2DHetOor9a5/3eWKyjCF6JjdZWewSwYS/3DTVrdxWmQPkvn03hhlwCh04/GNqDles
 pAvuR5DhbfuX9FTSH4yRqEN5WBpwAfN4Zvs2YM1qf/CMcTRelKJNfhsjyCZLoc+njhIa
 a1eSkQIs8i1MB2qj4dNYrqZ8WiKaTAR7uGeECiRiqixTNQ9i0wrrCKPUf6sJYRgvbiA5
 P9Hw==
X-Gm-Message-State: AOJu0YzenLz1IdEuUScmyOl3JxUizbe5pvWSnrNLuGeS8ho4BfuVNgrT
 9wDO5lO97UMOfGIpnX1GxSireWOVK/CR+K9E8kP31VsIIgEYBgoLwH8Ns+i79fi1bpUobQYjXs4
 qhIhlWTNYvgnpCILSsVHFeWs8qgF4spBWCOH/RgspUniAx+m23Oneb+hCAm0OmYwcDWRVtHe3Dj
 dOPp1CuZL/03uHTGi0Y7CpZ5AClARKTo2p0VFC
X-Received: by 2002:a05:600c:4e94:b0:414:7db2:8be5 with SMTP id
 f20-20020a05600c4e9400b004147db28be5mr10211597wmq.26.1712057661284; 
 Tue, 02 Apr 2024 04:34:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQNQfVeAWg0kXr4+d7MoVE+ld8ZJ8zGCtN4slAypldFB5T65yBmGYHa81i08e23i7SC3WotA==
X-Received: by 2002:a05:600c:4e94:b0:414:7db2:8be5 with SMTP id
 f20-20020a05600c4e9400b004147db28be5mr10211583wmq.26.1712057660972; 
 Tue, 02 Apr 2024 04:34:20 -0700 (PDT)
Received: from avogadro.local ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 v17-20020adfe291000000b0034174566ec4sm13919890wri.16.2024.04.02.04.34.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Apr 2024 04:34:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Helge Konetzka <hk@zapateado.de>
Subject: [PATCH for-9.0 3/4] vga: adjust dirty memory region if pel panning is
 active
Date: Tue,  2 Apr 2024 13:34:05 +0200
Message-ID: <20240402113408.18048-4-pbonzini@redhat.com>
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

When pel panning is active, one more byte is read from each of the VGA
memory planes.  This has to be accounted in the computation of region_end,
otherwise vga_draw_graphic() fails an assertion:

qemu-system-i386: ../system/physmem.c:946: cpu_physical_memory_snapshot_get_dirty: Assertion `start + length <= snap->end' failed.

Reported-by: Helge Konetzka <hk@zapateado.de>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2244
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


