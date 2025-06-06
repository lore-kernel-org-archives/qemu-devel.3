Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93D05C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 12:44:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNWI2-0002Wi-7S; Fri, 06 Jun 2025 08:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNWHx-0002To-0O
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 08:35:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNWHv-0005pc-2U
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 08:35:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749213309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ww1lY6S2uTksI0wQpy/g8QzaKoXGCoLz7u1pFjqzdyU=;
 b=CaZsGVU02dQNdDzYtuLKLpgfvB3IjWsSZWxyIOMiYTG5iwd4uNhPWk7+r/dEhejaiZ9xZp
 Eb4h98duSvAx6u9ZuLemb8lNEp5sGOdSJn+U6tzsfTOiHw/R6io8NF/IzJ6QgQyRYTt52U
 mZj8tk2XhYEmcpP/IYiOM2LeJcZtKww=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-nAy1XDzfPXOogJb2CjG39A-1; Fri, 06 Jun 2025 08:35:08 -0400
X-MC-Unique: nAy1XDzfPXOogJb2CjG39A-1
X-Mimecast-MFC-AGG-ID: nAy1XDzfPXOogJb2CjG39A_1749213307
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4eb6fcd88so1311029f8f.1
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 05:35:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749213306; x=1749818106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ww1lY6S2uTksI0wQpy/g8QzaKoXGCoLz7u1pFjqzdyU=;
 b=sanCeC9CdQYYrIckPho44OBCEP7JN3d76XlXvp1SrVb7OTZVwGBhWS6p0uPfQWv0xc
 LhzqyqdcLDA0ULVon9wvCXLuN8v9G/WuIyWz8l+1MzEzwT+8AsuaSH9BM3PoA6xd9+eq
 0A4c430UZ+WTBIkLPjfAXZp0HHYsrN6yrg9YxrJKn9ZMPO93VQE/3TNti4dKNIgTqXm7
 Fhn+0EVZNzPy0sWLMaGi9ZIWatM6K8xozdOA7S+loogdPTOYEutvsAO4o7+i9v2v0KC9
 KZijb4VeXKwmHxrN5PxGVz9IPZmPuarBIZBgZUlpqsbXQm2tfeGPbbqUls5BbxoQESN9
 H3RA==
X-Gm-Message-State: AOJu0Yw2b5vmS5pWGZXMGJgz1MEEOeQ0bYpIlfgqgiabpjA80iyysAGq
 TA47gVQ/342OfxlPuGjqMVa01rm29p0oJOThoTtx/6BHX5rHReEmUI3U4fiD83k6+lvkgKLI6dC
 xPfb5MOxtf4BNTvfpZiWpwgHv58/p6qnjGXnrDwZR7XgvofUTtTWsYxJF/w9Ozlgqi8mwV1wtLv
 Ls4tgYks3+puGPvXBrEVhg+rSMM1YRUL3LZOmHJ3+n
X-Gm-Gg: ASbGncuz6kxEXZSF5mVxoR3/Z0PDGQOzm9zGe6TasgKwP+9HnG8fDSwKyocA3jA8XZ3
 LfkPgdtiyZ3WCPMZoP4QPtk/aNiQgvG0lEp828rdoOgTRbV+l2oi+bHMuNbhPWyDfyGFnVrkEbi
 s6xc8fEald9JRJHvWkB61084ZWXJOG80Eivd2i2d62VdbxDruQVBjcRMRtocOwbRRT5GZUsMUDO
 ursPdoEjM+0D7oIBKPpYWot+OFPsRSnxB/rVj5a34xovPO6Ngyb46p3yX0SkaeMihu+pGHgY5rm
 kwaxwgy19zezXA==
X-Received: by 2002:a5d:64e2:0:b0:3a3:685b:118 with SMTP id
 ffacd0b85a97d-3a531cb35bdmr2760988f8f.24.1749213306494; 
 Fri, 06 Jun 2025 05:35:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsIRYqg26O6wvRMeFHlAFmdgrPCWDVkr1YL8snkAYwEiv6oJlnpWQ/ANLFtbU9fMQ8W8hfMg==
X-Received: by 2002:a5d:64e2:0:b0:3a3:685b:118 with SMTP id
 ffacd0b85a97d-3a531cb35bdmr2760968f8f.24.1749213306055; 
 Fri, 06 Jun 2025 05:35:06 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4526e158637sm20211105e9.11.2025.06.06.05.35.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 05:35:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 05/31] util/error: make func optional
Date: Fri,  6 Jun 2025 14:34:19 +0200
Message-ID: <20250606123447.538131-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606123447.538131-1-pbonzini@redhat.com>
References: <20250606123447.538131-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
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

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qapi/error-internal.h | 2 ++
 util/error.c                  | 9 +++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/qapi/error-internal.h b/include/qapi/error-internal.h
index 1ec3ceb40f0..ff18a2086d2 100644
--- a/include/qapi/error-internal.h
+++ b/include/qapi/error-internal.h
@@ -18,6 +18,8 @@ struct Error
 {
     char *msg;
     ErrorClass err_class;
+
+    /* Used for error_abort only, may be NULL. */
     const char *func;
 
     /*
diff --git a/util/error.c b/util/error.c
index 3449ecc0b92..daea2142f30 100644
--- a/util/error.c
+++ b/util/error.c
@@ -24,8 +24,13 @@ Error *error_warn;
 static void error_handle(Error **errp, Error *err)
 {
     if (errp == &error_abort) {
-        fprintf(stderr, "Unexpected error in %s() at %.*s:%d:\n",
-                err->func, err->src_len, err->src, err->line);
+        if (err->func) {
+            fprintf(stderr, "Unexpected error in %s() at %.*s:%d:\n",
+                    err->func, err->src_len, err->src, err->line);
+        } else {
+            fprintf(stderr, "Unexpected error at %.*s:%d:\n",
+		    err->src_len, err->src, err->line);
+        }
         error_report("%s", error_get_pretty(err));
         if (err->hint) {
             error_printf("%s", err->hint->str);
-- 
2.49.0


