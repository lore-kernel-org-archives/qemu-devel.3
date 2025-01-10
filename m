Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17647E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 18:49:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWK2l-0000S1-Bp; Fri, 10 Jan 2025 13:47:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK1t-0000Bt-LL
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:46:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK1m-00015K-82
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:46:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736534797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XJMegQJf6w9b9nRXNq7/z8d5kYstt5nQEzXDaVstUso=;
 b=XYEXANFEMDp+y9nPloSjZzE/BBgj4JRSBaXJNUnKiqiGjMibQnNe/3xGY3+1T+wjTFJuJq
 JnD0YiLLhzZ0ioZjRN5ZPR/jvXkMeWjkRT2LXoo613hFXld/lbVVcBJljLsM8oluY+PM25
 6jMsUqcuFPrfQyBdBLDRHh7+BTucJ/Y=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-WMeDq7btO0GgeBT4EUoCqQ-1; Fri, 10 Jan 2025 13:46:36 -0500
X-MC-Unique: WMeDq7btO0GgeBT4EUoCqQ-1
X-Mimecast-MFC-AGG-ID: WMeDq7btO0GgeBT4EUoCqQ
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-aa68952272bso273191866b.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 10:46:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736534794; x=1737139594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XJMegQJf6w9b9nRXNq7/z8d5kYstt5nQEzXDaVstUso=;
 b=i0UlFLQq9pGjVmIjDG/52GigVQ7MieKdC67Oy/q9mTBqZ9FanX7Q+fvIxwGMV2kGLC
 Z9mSuN3x14maPFDGFPmWrrs/+4W2CgijlGtdXsIvoAmybCd6p1uIZv4BTVYXUbobOVLk
 n/RgQzt3P4KPTgACRK8qZ8hQFuZ7WgpbttfKjTVFjIj1myBiVz+cqe18eDFYEw0Uhc4v
 dhPLle8JNu0yOo5ewXb8IFXBU53pRMvD+EImAxy5WW+q2CeDAv/hj7peol56eJUs184F
 hq4qJU2iK5HWbpBHcwrVVcu0BZ0vZINzkNk4B+zBT0A/WHejliUU1Inq4IeNwXmNLd48
 3XQw==
X-Gm-Message-State: AOJu0YwOlTvdRZtUTw16rQ4APhVbt8CGuwySWrVMEeyqY5mFSmkJHCpj
 CK1dUJ6pE9BnL0bBErzGn/5ESomH6Fzub729kZ+BS0Lc8EYelH+WJtEBOsaah2apT9RUY88/Svh
 2GZ1tjP2qXHD2hJCoKmiw4MlVevyTw5SB6Jq+aH/oWLy2/9cJ5KEe8rsbe0yBjcjNTBNPC2InqC
 UBh7laHNz8Oq0v3Wy77Kg/txDeGcT/q2BKC9PUa3U=
X-Gm-Gg: ASbGncscic7IcTLo2tjGC8fcPr9j62nbpQAZ1hiotieb8xwLfCTukBPxQTyJQu0J4rF
 OgodRV2bB6QGmTubOKdyDyn15zfjHPsx53FL96y7SZJWg8RfMaWCoH8vWEZEjvmSwG0FtRgUDYR
 s7t5wuFoFFzpcZvdu5EDxvOcB75klhXyoS6WZmTK4tDOCiJR9Qxo6m43DLsXQC1K+wnIq7CGIky
 Dj+SO84X+qqHIjtafUo9OFzdZJRFqYotlzlcoIauspcLQm0IIptyUyA7u0=
X-Received: by 2002:a17:906:ef0b:b0:aa6:8096:204d with SMTP id
 a640c23a62f3a-ab2ab6a8e78mr1134929866b.3.1736534794403; 
 Fri, 10 Jan 2025 10:46:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkijy8mmWURrs2JHVq/CKL0tbHIq6BzWi2GGaeqKkL4kLCd1ZN/g4bpGYfQYyYHDHC4LGoIw==
X-Received: by 2002:a17:906:ef0b:b0:aa6:8096:204d with SMTP id
 a640c23a62f3a-ab2ab6a8e78mr1134927966b.3.1736534793969; 
 Fri, 10 Jan 2025 10:46:33 -0800 (PST)
Received: from [192.168.10.3] ([151.62.105.73])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c90d9a7dsm194409066b.50.2025.01.10.10.46.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 10:46:32 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 05/38] rust: macros: check that #[derive(Object)] requires
 #[repr(C)]
Date: Fri, 10 Jan 2025 19:45:46 +0100
Message-ID: <20250110184620.408302-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110184620.408302-1-pbonzini@redhat.com>
References: <20250110184620.408302-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Convert derive_object to the same pattern of first making a
Result<proc_macro2::TokenStream, CompileError>, and then doing
.unwrap_or_else(Into::into) to support checking the validity of
the input.  Add is_c_repr to check that all QOM structs include
a #[repr(C)] attribute.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api-macros/src/lib.rs | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/lib.rs
index 74a8bc7503e..160b283d7fd 100644
--- a/rust/qemu-api-macros/src/lib.rs
+++ b/rust/qemu-api-macros/src/lib.rs
@@ -32,18 +32,23 @@ fn is_c_repr(input: &DeriveInput, msg: &str) -> Result<(), CompileError> {
     }
 }
 
-#[proc_macro_derive(Object)]
-pub fn derive_object(input: TokenStream) -> TokenStream {
-    let input = parse_macro_input!(input as DeriveInput);
-    let name = input.ident;
+fn derive_object_or_error(input: DeriveInput) -> Result<proc_macro2::TokenStream, CompileError> {
+    is_c_repr(&input, "#[derive(Object)]")?;
 
-    let expanded = quote! {
+    let name = &input.ident;
+    Ok(quote! {
         ::qemu_api::module_init! {
             MODULE_INIT_QOM => unsafe {
                 ::qemu_api::bindings::type_register_static(&<#name as ::qemu_api::qom::ObjectImpl>::TYPE_INFO);
             }
         }
-    };
+    })
+}
+
+#[proc_macro_derive(Object)]
+pub fn derive_object(input: TokenStream) -> TokenStream {
+    let input = parse_macro_input!(input as DeriveInput);
+    let expanded = derive_object_or_error(input).unwrap_or_else(Into::into);
 
     TokenStream::from(expanded)
 }
-- 
2.47.1


