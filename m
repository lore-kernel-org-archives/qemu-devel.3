Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 193D8C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 14:26:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJYlv-0003IE-Jc; Mon, 26 May 2025 10:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uJYlT-0002yF-9Q
 for qemu-devel@nongnu.org; Mon, 26 May 2025 10:25:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uJYlP-0007qv-WF
 for qemu-devel@nongnu.org; Mon, 26 May 2025 10:25:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748269514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3EGlhQGgpmM2dQVRCh7jBtvLfB+JtoZdp0/VjpnQkgc=;
 b=SCNXVLFYB+IDRFy37pgGVlhAUnAjZVWIfG6t+dQzMSXVyrv2nkwa4PkY+2wnhQ4UFi9R29
 Yfi/GNJ1SobLlEmuz6ZO0UJRO59ohrGPdhsJr8P9HvWi3s1srarEp7+beZQa8Zspi1z0ni
 NKP4ZoZR9azuzVkf4wmdygXH0kQ3xhQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-4jcbjMCQNaKceFKoWDdtOQ-1; Mon, 26 May 2025 10:25:13 -0400
X-MC-Unique: 4jcbjMCQNaKceFKoWDdtOQ-1
X-Mimecast-MFC-AGG-ID: 4jcbjMCQNaKceFKoWDdtOQ_1748269512
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-44a3b5996d2so11304565e9.1
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 07:25:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748269511; x=1748874311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3EGlhQGgpmM2dQVRCh7jBtvLfB+JtoZdp0/VjpnQkgc=;
 b=RJQTe12jV7+G7TKH54MYcKTV5qxiP5hFQQjlbKVbilD4luZp46qB/05oVNFLHdV9aY
 7FPtIkiyRc4jIXkg4AsRiAoI1k1SyWoZfyRPY5YClTjxVDGzy0+6ho5GSioUU4+7Zukd
 1YR0qpWRBVIrYVbRwO9mgMTfCk51iZNKdRCVzesTTfUguigXO8vMEnMm0UYMCSGmLO2W
 8vubRMLEVpBVQIk5k/y8wnI7SvE3W8Q1TYFd2G+VJd90KB8zWyAjGK1Li4faqdi7DR3U
 deTAQDNRuvhrl0uB0MiGmGiHps8sR3Ec7fChkp4TK+vc4n/Oa/PuqKuxZLbVGW4zvBtE
 GxXg==
X-Gm-Message-State: AOJu0YzOrxMTpFIYxkqWFlUzPPeWOiDit37Kka3mZvAGR25EGzJ7m3vg
 63xXc0pD6XBhhY798KNz44dQ/fCTx1QmWpPo8IgPsvgUutL/801ErXJX2n/5Q3/Nm5ZAPLD0wW0
 1qRjKI+qobOrbYYr0MLFoMpebHmjjDWzm+BB+2OkciyvgrgTjStn0qIJvIqDnFkznMefuWETAK/
 FvCLr1K1k4+twY/urtUOtzH3b5MeMXOtC5/Z8Un6Bg
X-Gm-Gg: ASbGncuytHVxtoKxaIlWBAXWjytjs1SwCGdt/9VMS1yT+qzEBufafaGkkxok2pp7T8K
 nkk7SOefoZ8PLOJqYj+EHkwTHMiSlHSaUQ7m6+YYVyWbcXCAy7RS/uxa+nIjq48rLXtika9WLvh
 npYesuL8G+P5K9DBK4bwuFDn55nM80U/oSG5cjISPASzM97/qYl/oe/OIOshPUhl7I4sIc/v+Y1
 IRcaHM20LgOw10PtfabwuWuMY3oyaNZzH3H6qoEagoK/jYudCv8SCXuCiLQwpWbWxdRFXtNo0vy
 OqPOoG5JKihq+w==
X-Received: by 2002:a05:600c:5297:b0:44b:1f5b:8c85 with SMTP id
 5b1f17b1804b1-44c919e1690mr78095095e9.13.1748269511008; 
 Mon, 26 May 2025 07:25:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrf2JnDbM5/Xjo8vU4HZrsfTrlL6QdK7hPIzOHeUs3OcU2pEDbqB77ErRZz/tIY3keLU5t6Q==
X-Received: by 2002:a05:600c:5297:b0:44b:1f5b:8c85 with SMTP id
 5b1f17b1804b1-44c919e1690mr78094835e9.13.1748269510570; 
 Mon, 26 May 2025 07:25:10 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.46.79])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f6b29633sm251321115e9.8.2025.05.26.07.25.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 07:25:09 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com,
	qemu-rust@nongnu.org
Subject: [PATCH 06/12] util/error: make func optional
Date: Mon, 26 May 2025 16:24:49 +0200
Message-ID: <20250526142455.1061519-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250526142254.1061009-1-pbonzini@redhat.com>
References: <20250526142254.1061009-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The function name is not available in Rust, so make it optional.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/error.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/util/error.c b/util/error.c
index 6c1033eaba5..b977007faaf 100644
--- a/util/error.c
+++ b/util/error.c
@@ -29,8 +29,12 @@ static void error_handle(Error **errp, Error *err)
             /* No need to free it, the program will abort very soon...  */
             src = g_strndup(err->src, err->src_len);
         }
-        fprintf(stderr, "Unexpected error in %s() at %s:%d:\n",
-                err->func, src, err->line);
+        if (err->func) {
+            fprintf(stderr, "Unexpected error in %s() at %s:%d:\n",
+                    err->func, src, err->line);
+        } else {
+            fprintf(stderr, "Unexpected error at %s:%d:\n", src, err->line);
+        }
         error_report("%s", error_get_pretty(err));
         if (err->hint) {
             error_printf("%s", err->hint->str);
-- 
2.49.0


