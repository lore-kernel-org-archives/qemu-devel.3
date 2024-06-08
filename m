Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47876C27C55
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 08:39:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFrXr-0000rk-0r; Sat, 08 Jun 2024 04:35:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrXn-0000py-4a
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:35:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrXl-00006u-Pr
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:35:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717835721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U1hQ9q7ePB1JueKVg84KBcWFusNtYN23aoDQ/vM6aV8=;
 b=EGy/7U8CwY3Wc3RCAhR6uNtZ+jPrBkycrefvVt2YA6Sz0ptH6r/AwNFeUwkJZLGuS6NZm2
 k0iyb1X13vr1SqogQyntPbFjJS40KH7FV7KFJOcgeoLNtCZ289DpwMVfpvsMm1w99lNnEP
 BTpX0LrAZzpMXTbSZ47u5B0BjrYSqU4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-X8ApHWhLOaiePm17XNePcQ-1; Sat, 08 Jun 2024 04:35:19 -0400
X-MC-Unique: X8ApHWhLOaiePm17XNePcQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-57a2fb28a23so2252806a12.3
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 01:35:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717835717; x=1718440517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U1hQ9q7ePB1JueKVg84KBcWFusNtYN23aoDQ/vM6aV8=;
 b=mLFk06uVnD0ri6EUbpMM78s2KTGRmqxpqvkSdJhJwBBKAPYwc6mLE+DTiU+DZFdHfV
 x7pVlJNi1in8DlavAxDzjZyAi3RMRKlCqvVy3o7v1AA+JUnhbvQoLDNgetkq95/NIAw0
 nGwBU5TfzrNs0Y0a4xaWLcyBkl1ctXXYVp5zG7GkWkkrmEZPsjsJxrZyBZqpFhrrZm5u
 Dz5E8gnlmijwmJI95slKaBdcB0n9x4aCu5JHuXkHXDk9CREaWuM76VUUW/OM7l5LY0R/
 C85U5alnrfcnEKAW00yd6RVGN/eB0q/4x5gWlz4LSpVF4icsSD4KXvEtvqAO2J2wiir2
 9Heg==
X-Gm-Message-State: AOJu0YxgN/Geenz86nEG49JNX86E897MtPvLINO807xsq7g3UucA1K7u
 LxvZlk0P/BQpToojGYcf5upyppkbw4G1Ea9Dz8mpXWVavnsHXESTtgEuyEb3TgtSnY76Ni1L/ms
 26mskP3b015ak2SF9OWOX2KSstGvGxwk5Yg3nZue9/bVZTEpoBRgSgo5wWe3hOIkZgO7WRCJ8wd
 r/FEHRakD1U1XDxwqSfBEuS0WVTWoD7ygJGzb5
X-Received: by 2002:a17:906:6a1e:b0:a68:c9b2:6932 with SMTP id
 a640c23a62f3a-a6cdc0e4180mr364951566b.65.1717835717217; 
 Sat, 08 Jun 2024 01:35:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbbhwXW1cA1bSEy3D3QKv4c1U0hcIh9dtVE8KhlS/VL0X8ULg0VckOOquP+y6CQJGIa3wOnw==
X-Received: by 2002:a17:906:6a1e:b0:a68:c9b2:6932 with SMTP id
 a640c23a62f3a-a6cdc0e4180mr364950566b.65.1717835716899; 
 Sat, 08 Jun 2024 01:35:16 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c806ebd59sm353158366b.116.2024.06.08.01.35.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 01:35:15 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 22/42] hostmem: simplify the code for merge and dump properties
Date: Sat,  8 Jun 2024 10:33:55 +0200
Message-ID: <20240608083415.2769160-23-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240608083415.2769160-1-pbonzini@redhat.com>
References: <20240608083415.2769160-1-pbonzini@redhat.com>
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 backends/hostmem.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/backends/hostmem.c b/backends/hostmem.c
index 6da3d7383e3..4e5576a4ada 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -178,19 +178,16 @@ static void host_memory_backend_set_merge(Object *obj, bool value, Error **errp)
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
 
         qemu_madvise(ptr, sz,
                      value ? QEMU_MADV_MERGEABLE : QEMU_MADV_UNMERGEABLE);
-        backend->merge = value;
     }
+
+    backend->merge = value;
 }
 
 static bool host_memory_backend_get_dump(Object *obj, Error **errp)
@@ -212,19 +209,16 @@ static void host_memory_backend_set_dump(Object *obj, bool value, Error **errp)
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
 
         qemu_madvise(ptr, sz,
                      value ? QEMU_MADV_DODUMP : QEMU_MADV_DONTDUMP);
-        backend->dump = value;
     }
+
+    backend->dump = value;
 }
 
 static bool host_memory_backend_get_prealloc(Object *obj, Error **errp)
-- 
2.45.1


