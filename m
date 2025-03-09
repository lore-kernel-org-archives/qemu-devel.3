Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F9CC282D1
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 10:33:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trDx7-0008RZ-Uo; Sun, 09 Mar 2025 06:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1trDwt-00086a-JV
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 06:31:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1trDws-00043Q-0I
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 06:31:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741516317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5YnANE3o7k98qiD5yXSXBYpiijAd3VVlrkAgduC094U=;
 b=dfJTURuOs89YqsVJrFB52UxDLctHezqwIVaQWNDf6x+qIKllj6x2lnXdlBs57UgfTk9bfI
 jjjxXKwKp40ECltyR+2sKw7gqSuymwtsVj6OMrIuKQP/J/1e7maROVQV0D9kSL7HfS/hcT
 +aV1cQbqv3XJCSuhs5KUyduHIYMvXCc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-rn5ZKZZqOAS4u09LVGV24g-1; Sun, 09 Mar 2025 06:31:55 -0400
X-MC-Unique: rn5ZKZZqOAS4u09LVGV24g-1
X-Mimecast-MFC-AGG-ID: rn5ZKZZqOAS4u09LVGV24g_1741516315
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43cf3168b87so1391415e9.2
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 03:31:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741516314; x=1742121114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5YnANE3o7k98qiD5yXSXBYpiijAd3VVlrkAgduC094U=;
 b=AyC9HJ6nofTy3LWp0modTndsl+vLWAdKms9J11NgA8+9/GKUPA0LzuSCRK2Nkms9u/
 n68O9VvsTx5cmYh+c5bIrtUFAGdpKRZvzkVncb50YVoEntZrm+fBoWzGPnWu27hOWQFZ
 ZdvjzYDCyVYYFkymTvS7P9KvcoBFr8Mm8DSF8lE8OjvHH8K/0fYcfzYcUWf6SZ02v13b
 hi1DgROiPYfUvv+2+xB4XiRfKphf1yvKWuoUEIrAEIw0ht4GwtAJ7kmq9upvI4Xp+AaO
 PR6i54jzK08x3OCWTWR2AkmtMZKmeS9+K9MTJmslqJlqdBdD9IWrThv8ed5wy3eeQzI7
 5OEg==
X-Gm-Message-State: AOJu0YyO2iZoRaD+orOKcdlHvC/rIDxjSdMo+gvozMe81E6Mo+cPN898
 1o6pfJ9nzCbLA3GlXcQKcHS9ViGQRlSpmwitWln3AoY7Opo9z4SPsRJ/SSztmSRnJ5hnUPC7aCB
 q4uqLl1K86zXFBH/ps7tLHG1uwHej1JOSztNHtlrx2GziAGhFOeyY3uHAjAAp7FLnOquQ54P9NC
 E1vQoPgNYPy3UpoTTUSfNTUZi17XuGVqardruEbAE=
X-Gm-Gg: ASbGnctoZmFCAfif5qEhdMNnCi5A9XjPCySMf0LbaRcbqz8slmXpIP0a2KljgMzxvfU
 uHCi83hiUd20lH3sG7fQwQG4ZVA4715jNJVnIYEUWV1+2mplsYM7wd9HpXo8llJucDmn5c60bDV
 hVuy1naMVQEq2svT/j6VcaGth0OTnV3XK6nUf8UFiyMe84Fk7vJ9SASlyDfvuMgxKq/vpiOgty1
 GZxJAlTt2eqjkupDP+lbCFjxjgU2hQ1UUvtQMff3ohXvJN/reyMAMxCf75IYQ+b1UWWP1X+1du6
 vtlTyJ5SxlBb1uIBkNjsow==
X-Received: by 2002:a05:600c:6b0a:b0:43c:e9d0:9ee5 with SMTP id
 5b1f17b1804b1-43ce9d0a0bfmr25891325e9.18.1741516314299; 
 Sun, 09 Mar 2025 03:31:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuhYqMLwd298dkGxipeo3Le4223qTSDe1Lu0xFlNfgDEENkxnCjfhfsI5bwlscAzlO2BdTew==
X-Received: by 2002:a05:600c:6b0a:b0:43c:e9d0:9ee5 with SMTP id
 5b1f17b1804b1-43ce9d0a0bfmr25891175e9.18.1741516313858; 
 Sun, 09 Mar 2025 03:31:53 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.122.167])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43cf1b36d14sm17827475e9.37.2025.03.09.03.31.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Mar 2025 03:31:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 15/25] rust: bindings: remove more unnecessary Send/Sync impls
Date: Sun,  9 Mar 2025 11:31:09 +0100
Message-ID: <20250309103120.1116448-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309103120.1116448-1-pbonzini@redhat.com>
References: <20250309103120.1116448-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Send and Sync are now implemented on the opaque wrappers.  Remove them
from the bindings module, unless the structs are pure data containers
and/or have no C functions defined on them.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/bindings.rs | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/rust/qemu-api/src/bindings.rs b/rust/qemu-api/src/bindings.rs
index c3f36108bd5..3c1d297581e 100644
--- a/rust/qemu-api/src/bindings.rs
+++ b/rust/qemu-api/src/bindings.rs
@@ -25,15 +25,11 @@
 
 // SAFETY: these are implemented in C; the bindings need to assert that the
 // BQL is taken, either directly or via `BqlCell` and `BqlRefCell`.
-unsafe impl Send for BusState {}
-unsafe impl Sync for BusState {}
-
+// When bindings for character devices are introduced, this can be
+// moved to the Opaque<> wrapper in src/chardev.rs.
 unsafe impl Send for CharBackend {}
 unsafe impl Sync for CharBackend {}
 
-unsafe impl Send for ObjectClass {}
-unsafe impl Sync for ObjectClass {}
-
 // SAFETY: this is a pure data struct
 unsafe impl Send for CoalescedMemoryRange {}
 unsafe impl Sync for CoalescedMemoryRange {}
-- 
2.48.1


