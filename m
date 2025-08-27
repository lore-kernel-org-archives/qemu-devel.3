Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E3E6CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 18:30:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urKsE-0005mq-4H; Wed, 27 Aug 2025 14:27:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1urKr1-00053G-2a
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 14:26:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1urKqu-0005sX-B9
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 14:26:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756319186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mv9H/MsUUPau2pitXzSJwug9yy3jNWy54GNz6saS/c4=;
 b=V3dN1dX1JVurAGRd5tGjfsg7d5jO9ZcQnw5BeKd8Y89bVi+TyTL/EgSQZHD/Y0WV3v2esE
 58jAYCWJnFP3En7gx58XOagFDbuZwMLBlPDs5Ys9h9dMU7Ez0FHtUpEEQUVjtysSonO5sy
 EI6IqWrm1G2gyGKyt6jQ7WYxgWIMkGI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-4yudRQd6MrKMsS7sYNk4Tw-1; Wed, 27 Aug 2025 14:26:25 -0400
X-MC-Unique: 4yudRQd6MrKMsS7sYNk4Tw-1
X-Mimecast-MFC-AGG-ID: 4yudRQd6MrKMsS7sYNk4Tw_1756319184
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3cd34034c02so78318f8f.1
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 11:26:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756319183; x=1756923983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mv9H/MsUUPau2pitXzSJwug9yy3jNWy54GNz6saS/c4=;
 b=m69eu+FD5Me/AadYdfhu5j5BxbH/cObMjkrqSKu15iJ/Nhuw480RyPktR+9RralrBy
 A2Ykz0vbipOWyCk7xyT+TaxjfCauc8pzogssIeNIaKeiTFhS4a65OxpYYb4ji8V5HTyg
 W5mDiCD/0Pp/57lwOYZgxeEdd3LRkFg+aNifdkhDO7e5PBJLNb79DtXvIN0FbG3Kxu7B
 Yz/sUTtb3EnDz6ZhYlMGKTiOLn6lDlAf2rBSCrup5/OnrClEIfp1lqYMDnIZOKJvYFqH
 SCEKG9aVFacodxgjZnAHDIlHk2HILz9Jn5CeFI55F7RKvaQ0TkVbnfxBHxr7lljyPGxC
 4aow==
X-Gm-Message-State: AOJu0YzpSClUqTlDTNDNgNp9BOg3YmejPrwNTv5eSCIm4wTTuhgz4vkO
 dMyzQ9VQzMxDx56ERZcZ0rSIT6eILZw5TRrjifhlYhuH7AwzCVXbMgg+oWgFLFUB2+xzQVGiJ0u
 3VeYOxzVN58liFw/IG2mfdOr/gZe8Ors1Dk+Po48G1nTgJ3rOjN3bEexJSM5x1FLNQAKIR1Aw6L
 eDMG/mBxky63d7nc/dwMh1ws9+Xg8wnH+hBNTWVGLT
X-Gm-Gg: ASbGnctrcgQ1C85zyY8o/Ni9gphnfrojsjKvrUhzA3RkOGnyopnNsmFVM9pcskU1QhF
 JUNYwPvtAdxtmh04TZIp838nc6c3Zi638v9fphUSXFbKLho0EMO4L9RxxM/oCldhS8k1XAUbQib
 GDgcTN96Y8O1CPoT4DQxT97vVoD9218mYOAK1uY/ALIDSvTLhYp7wmAytEwdUQjZD/gMtOSugqC
 Y5aY9YP357loOFffeuqWULKRvhuF9h3Owka41dYGk2wHW1g32vvVjkJdpU4WaQvh+SXH+ket2Du
 0P/Gv0KSt/9YVt8+1VLbsRgvMk7IYixU9+TFihTTRbtt4h4aCDto4L33stnEoXmFux9DK7UbtTA
 E/usIaNlXObZCaoNLax1Y5/2UNvXtcEMms4G/fql3l9w=
X-Received: by 2002:a5d:5d10:0:b0:3c5:8300:978d with SMTP id
 ffacd0b85a97d-3cbb15ca07fmr5046434f8f.22.1756319183138; 
 Wed, 27 Aug 2025 11:26:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1slRJ544V5y7IaMNJytZ0LZUOSMlDr1Uniu489CpKr/MQicxJQiZbNxdzixmNxV61GVJpEA==
X-Received: by 2002:a5d:5d10:0:b0:3c5:8300:978d with SMTP id
 ffacd0b85a97d-3cbb15ca07fmr5046420f8f.22.1756319182685; 
 Wed, 27 Aug 2025 11:26:22 -0700 (PDT)
Received: from [10.163.96.123] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f2f3383sm38242065e9.26.2025.08.27.11.26.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 11:26:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 13/14] rust: declare self as qemu_api for proc-macros
Date: Wed, 27 Aug 2025 20:25:31 +0200
Message-ID: <20250827182533.854476-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250827182533.854476-1-pbonzini@redhat.com>
References: <20250827182533.854476-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Fix an outstanding TODO.

Declaring `extern crate self as qemu_api` allows use of `qemu_api`
within the qemu_api crate; this allows the Wrapper derive macro and
future proc macros to be used interchangeably in the qemu_api crate and
other crates. This is not required currently and is only for
future-proofing.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Link: https://lore.kernel.org/r/20250728-self-as-qemu_api-v1-1-001c339cccc8@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api-macros/src/lib.rs | 14 ++++++--------
 rust/qemu-api/src/lib.rs        |  4 ++++
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/lib.rs
index a6147418891..959726efe6d 100644
--- a/rust/qemu-api-macros/src/lib.rs
+++ b/rust/qemu-api-macros/src/lib.rs
@@ -123,23 +123,21 @@ fn derive_opaque_or_error(input: DeriveInput) -> Result<proc_macro2::TokenStream
     let field = &get_unnamed_field(&input, "#[derive(Wrapper)]")?;
     let typ = &field.ty;
 
-    // TODO: how to add "::qemu_api"?  For now, this is only used in the
-    // qemu_api crate so it's not a problem.
     Ok(quote! {
-        unsafe impl crate::cell::Wrapper for #name {
-            type Wrapped = <#typ as crate::cell::Wrapper>::Wrapped;
+        unsafe impl ::qemu_api::cell::Wrapper for #name {
+            type Wrapped = <#typ as ::qemu_api::cell::Wrapper>::Wrapped;
         }
         impl #name {
-            pub unsafe fn from_raw<'a>(ptr: *mut <Self as crate::cell::Wrapper>::Wrapped) -> &'a Self {
+            pub unsafe fn from_raw<'a>(ptr: *mut <Self as ::qemu_api::cell::Wrapper>::Wrapped) -> &'a Self {
                 let ptr = ::std::ptr::NonNull::new(ptr).unwrap().cast::<Self>();
                 unsafe { ptr.as_ref() }
             }
 
-            pub const fn as_mut_ptr(&self) -> *mut <Self as crate::cell::Wrapper>::Wrapped {
+            pub const fn as_mut_ptr(&self) -> *mut <Self as ::qemu_api::cell::Wrapper>::Wrapped {
                 self.0.as_mut_ptr()
             }
 
-            pub const fn as_ptr(&self) -> *const <Self as crate::cell::Wrapper>::Wrapped {
+            pub const fn as_ptr(&self) -> *const <Self as ::qemu_api::cell::Wrapper>::Wrapped {
                 self.0.as_ptr()
             }
 
@@ -147,7 +145,7 @@ pub const fn as_void_ptr(&self) -> *mut ::core::ffi::c_void {
                 self.0.as_void_ptr()
             }
 
-            pub const fn raw_get(slot: *mut Self) -> *mut <Self as crate::cell::Wrapper>::Wrapped {
+            pub const fn raw_get(slot: *mut Self) -> *mut <Self as ::qemu_api::cell::Wrapper>::Wrapped {
                 slot.cast()
             }
         }
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index 86dcd8ef17a..bcb51c7986a 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -32,6 +32,10 @@
 pub mod vmstate;
 pub mod zeroable;
 
+// Allow proc-macros to refer to `::qemu_api` inside the `qemu_api` crate (this
+// crate).
+extern crate self as qemu_api;
+
 use std::{
     alloc::{GlobalAlloc, Layout},
     ffi::c_void,
-- 
2.51.0


