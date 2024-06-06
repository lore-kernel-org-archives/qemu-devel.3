Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 811D3C27C52
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 09:37:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF9Yl-0001lu-UI; Thu, 06 Jun 2024 05:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sF9Yj-0001lC-TY
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 05:37:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sF9Yi-0007ZC-E5
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 05:37:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717666643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+GCbTdM0GZ7BVxsKLSoCw+rPoe+MChxl2looUyeu6OM=;
 b=iMuuos96JChsnteUupfnDFVmMF9tNFvsOCr3Go328wRGGZ2K1+vHa2xQ3RKFoADq8u2C63
 CxtLcgyVvRJclJPJ8nGrZo3DRgDd3AsdQzeWqxDHw9f4/gwUlPg7yu1QBQS8a9kouGazMb
 sV/EbMXm+YSYjRgTko1bh0QAa+HzXS0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-MwumC35ZP2iQGGxaK4CceQ-1; Thu, 06 Jun 2024 05:37:19 -0400
X-MC-Unique: MwumC35ZP2iQGGxaK4CceQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a68e0faf0e6so37358166b.2
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 02:37:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717666637; x=1718271437;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+GCbTdM0GZ7BVxsKLSoCw+rPoe+MChxl2looUyeu6OM=;
 b=uABiQz6R6OGeqGLuZ6PnsAPVCB/eyxpZxnreUvzTkaaoV3etzaI78nTrNLSq44IY4W
 RpLPLXmlvG6Dw1wdiBYae4GOd1CU27p8xkA6lIFZf7IcBM4ltrJvOo+mdiofRw1csMuC
 ezp8qTUY9aombknJzlGhLQ6xvHVpXR/UJsY8MLZIaVvGgDHjUN4/1m+tY6cjdNf6OSc/
 GFpOV5QCSgUmn2RguWAJ6pik4qD4Qku9/mHmlj8gjfaurltcddR4J3xVD3875ykzpvo9
 VDoGpIh4zJj2jej1BLP4lsFqxlG0SNjdapdIHvQyQyj83AdpFK8YCtCsfob2bnmo5MJC
 bL1Q==
X-Gm-Message-State: AOJu0YyuS+1wZX4wuStSofPwDR9BNiUfsdSnyAmAGIl1OVFB2/+VRUVL
 wNlNTwWKU/YE6X6cRQaxZPcIayDiDqgNzGAOyXp6Tc0sXWCFf300r2YdiHRmMu+qFaeShvQCstK
 09lu6DO3IFez+lgvDKxuwIAkic4quAk8xhAem2aVb4JLV7lPK13K+G3KXxzl8o8KvZ/dnkKEM6C
 uBDfsejJQX8MTvbyHZANCzzlhZwUceNDXCXmWP
X-Received: by 2002:a17:906:fccf:b0:a64:e418:f93f with SMTP id
 a640c23a62f3a-a69a024ce23mr291021366b.60.1717666636731; 
 Thu, 06 Jun 2024 02:37:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwj1ooVpHb7MZruSuxRO0F2MU0kBdsGAEZK1kz3tEDUYrykgPVZW/UNb/XhO89GwBUG5vHsQ==
X-Received: by 2002:a17:906:fccf:b0:a64:e418:f93f with SMTP id
 a640c23a62f3a-a69a024ce23mr291019666b.60.1717666636187; 
 Thu, 06 Jun 2024 02:37:16 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c806ec893sm71265666b.140.2024.06.06.02.37.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 02:37:15 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: mprivozn@redhat.com
Subject: [PATCH] hostmem: simplify the code
Date: Thu,  6 Jun 2024 11:37:13 +0200
Message-ID: <20240606093713.2469676-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

No semantic change, just simpler control flow.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 backends/hostmem.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/backends/hostmem.c b/backends/hostmem.c
index 37be93c8bb3..33baca6a974 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -178,12 +178,8 @@ static void host_memory_backend_set_merge(Object *obj, bool value, Error **errp)
         return;
     }
 
-    if (!host_memory_backend_mr_inited(backend)) {
-        backend->merge = value;
-        return;
-    }
-
-    if (value != backend->merge) {
+    if (!host_memory_backend_mr_inited(backend) &&
+        value != backend->merge) {
         void *ptr = memory_region_get_ram_ptr(&backend->mr);
         uint64_t sz = memory_region_size(&backend->mr);
 
@@ -194,9 +190,9 @@ static void host_memory_backend_set_merge(Object *obj, bool value, Error **errp)
                              object_get_typename(obj));
             return;
         }
-
-        backend->merge = value;
     }
+
+    backend->merge = value;
 }
 
 static bool host_memory_backend_get_dump(Object *obj, Error **errp)
@@ -218,12 +214,8 @@ static void host_memory_backend_set_dump(Object *obj, bool value, Error **errp)
         return;
     }
 
-    if (!host_memory_backend_mr_inited(backend)) {
-        backend->dump = value;
-        return;
-    }
-
-    if (value != backend->dump) {
+    if (host_memory_backend_mr_inited(backend) &&
+        value != backend->dump) {
         void *ptr = memory_region_get_ram_ptr(&backend->mr);
         uint64_t sz = memory_region_size(&backend->mr);
 
@@ -234,9 +226,9 @@ static void host_memory_backend_set_dump(Object *obj, bool value, Error **errp)
                              object_get_typename(obj));
             return;
         }
-
-        backend->dump = value;
     }
+
+    backend->dump = value;
 }
 
 static bool host_memory_backend_get_prealloc(Object *obj, Error **errp)
-- 
2.45.1


