Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB5BFCD1297
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 13:17:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rre0w-0006Pj-V4; Tue, 02 Apr 2024 09:17:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rre0s-00061a-9z
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 09:17:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rre0k-0006XW-If
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 09:17:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712063828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2PZavkeH6OTmLymO5kneMvG0lPUU9tg04m/0+lSsdoU=;
 b=HZHcIkDzgBt6hXeFJeYyKW2OmBRnFd2wx0JJlLuaPdf6t1MjC4u7igUA6Lw783c05Xbgq7
 frsPi4pjx16z2sAIwipErAgwc1NGzUH+Yupfz/bwA/SCiXGi9mBaWpIGrDJYLfDi4MaL9R
 zJb5j1AWvkRI6jo2ek8qkBDJodum7Dw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-Gn5paO8iP_e0v7TS19unmA-1; Tue, 02 Apr 2024 09:17:07 -0400
X-MC-Unique: Gn5paO8iP_e0v7TS19unmA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3437574111dso169112f8f.2
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 06:17:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712063825; x=1712668625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2PZavkeH6OTmLymO5kneMvG0lPUU9tg04m/0+lSsdoU=;
 b=HNmVmQbnfIibkVPGtlN0xjKduu1ppq7pafnG3uGt01/06u8M9hlw+gXOfdx5zzYHWE
 VpeVNYYuuittKCmnuj0Ccj3JnS7pRziYMd4KCVpXnLqR2aSIJXf/sSSi6Hon93nHU+gB
 sVgp/MZeMXtZwvzkZ1Jn8Aq4wEMqXblbOkza/aixz0yHMBZrL2hz7wKzsP5RDU0L2ygx
 7cQ1qMbdWdj/apq0mCPTVq7TmjmD16h8GUbUs7/Oe0r0ZBrfIMMepiiViYNr8cfUzaH1
 KYGO/rMrzKmwGk8HiA1ftMNyz7HtFJwTSjSNEd+eciZCffaKo69kIvyASFpw1l/d7NVv
 2JKw==
X-Gm-Message-State: AOJu0YyiZ6WaSYWzKW4/+u0CvSmJkAZKqT8TJfKmLde7roZVk9Vr1D8/
 lvLxCKKrQLdv7WBXOIysXYX6d3fwyjvXVudpkSEfEAtaYYmfyEeHyD5FhU651Ec6cHyJlGPvGfR
 /SUI7qIHMagcuvMjEgBvCvtqgQuj+DcwMeVL1vUN1aj90ZVNM4xk9kQBtWR01sQsnQ+fkfOUbIB
 g+6Y/M5ox9N/hW9n8SKhxvmHVxzxopk2A3qSqt
X-Received: by 2002:a05:6000:1818:b0:341:c15c:64d2 with SMTP id
 m24-20020a056000181800b00341c15c64d2mr10010311wrh.32.1712063825645; 
 Tue, 02 Apr 2024 06:17:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwUneul8xSSGJTt4tbfpTnwek8i1FElNjG7EJwZ8q2qG58D7mLDB8XIO0Yv8cR9QLh3yiLpA==
X-Received: by 2002:a05:6000:1818:b0:341:c15c:64d2 with SMTP id
 m24-20020a056000181800b00341c15c64d2mr10010293wrh.32.1712063825214; 
 Tue, 02 Apr 2024 06:17:05 -0700 (PDT)
Received: from avogadro.local ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 bu7-20020a056000078700b00343587cfa7dsm2195919wrb.77.2024.04.02.06.17.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Apr 2024 06:17:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 4/7] vga: do not treat horiz pel panning value of 8 as "enabled"
Date: Tue,  2 Apr 2024 15:16:46 +0200
Message-ID: <20240402131649.23225-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402131649.23225-1-pbonzini@redhat.com>
References: <20240402131649.23225-1-pbonzini@redhat.com>
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


