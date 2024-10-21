Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C83AD15DBA
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 16:36:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2vOF-0006Aq-68; Mon, 21 Oct 2024 12:36:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2vO4-000622-JQ
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:36:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2vO2-0006JG-Hy
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:36:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729528565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LC3eZXbf/MgMolpo8tNMzb8FwxljpvkDw9TXTcaEtG4=;
 b=a0SeJMUqcC0uc6KyUlYgiH74upYCbDi5JvUEco9lGIrUmoXA1yfq+DxsOtiow+cxwl5F+O
 V0aacUJzdUsTNs7SCLN0seR7YtpLHgWRu0+4YY6O4KDIEevyOVee34u3muj5kAY/eCz0Ww
 FhbVmhQyVOm50w2cUuWge+q4k2IUVSE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-W5rTGtOQMS-wBgFLAVDLwA-1; Mon, 21 Oct 2024 12:36:04 -0400
X-MC-Unique: W5rTGtOQMS-wBgFLAVDLwA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4316300bb15so25077875e9.2
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 09:36:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729528562; x=1730133362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LC3eZXbf/MgMolpo8tNMzb8FwxljpvkDw9TXTcaEtG4=;
 b=bvrXJieR7NxIKBUdfAf0dgzkLI1tVcrCMnzKFiSV1jtOMZXwvNavL6JKivybmCoft/
 FOM2YhLF2jrVYIgva40XwiTrQh3mgopvb+5zhwFBdlXRHYlp5JXVbwtE78e6e57WlFRQ
 IcuK1/7YxiDq3HLPJEaDfR3+DoIdy2adsV3r9zIf6vJj6Riu40OOJ1dOqxG19Blh9h37
 cR8/Q1d3SO6d6GtSnKKfXrJsWtRM9mDwfgWcCJI/6PiP3jOFZvFg/crh5PB3J7gpckNQ
 ACSM38pjAnj503wwCjOaiWbmjXDLdWnS24uCdlEBIm6BM5G0Pi6aXQLgGm6iApoTu1/d
 jS/g==
X-Gm-Message-State: AOJu0YxOYz11BX0Z+/XUOKUA601+KC9pnQ5fwa4z76YR7UYk0YFf9EXn
 33xOmCmhQR9WaZ2UAdqIWOAhszoNO4fpCo0zYxQ5boz60HBsoc0CLEw2qGCF6tLiP0+G8hBDFf0
 8TyzZ95tx2fHCdUpMwLGWTxWPbWvXvNbClMjH5bm29SFsziS0gBBOsdn4vBjqz1f2f426E2S5UC
 eqG4C24/C7Csxpch8g+xCtYsR7s67IwA6zvzr/LGw=
X-Received: by 2002:a05:600c:1d04:b0:431:43c6:e868 with SMTP id
 5b1f17b1804b1-4316168989amr96211185e9.23.1729528562426; 
 Mon, 21 Oct 2024 09:36:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFysiBm3yf0tbZkEr5nT0eHMMCE9Z/zmUvvYl+CWpu6d66CLnxg2DilTYfF7Q1Kp1VDLVTd3w==
X-Received: by 2002:a05:600c:1d04:b0:431:43c6:e868 with SMTP id
 5b1f17b1804b1-4316168989amr96210875e9.23.1729528561868; 
 Mon, 21 Oct 2024 09:36:01 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee0a47b07sm4700072f8f.25.2024.10.21.09.36.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 09:36:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: [PATCH v2 06/13] rust: modernize link_section usage for ELF platforms
Date: Mon, 21 Oct 2024 18:35:31 +0200
Message-ID: <20241021163538.136941-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241021163538.136941-1-pbonzini@redhat.com>
References: <20241021163538.136941-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Some newer ABI implementations do not provide .ctors; and while
some linkers rewrite .ctors into .init_array, not all of them do.
Use the newer .init_array ABI, which works more reliably, and
apply it to all non-Apple, non-Windows platforms.

This is similar to how the ctor crate operates; without this change,
"#[derive(Object)]" does not work on Fedora 41.

Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api-macros/src/lib.rs  |  7 +++++--
 rust/qemu-api/src/definitions.rs | 14 ++++++++++----
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/lib.rs
index 59aba592d9a..70e3f920460 100644
--- a/rust/qemu-api-macros/src/lib.rs
+++ b/rust/qemu-api-macros/src/lib.rs
@@ -16,8 +16,11 @@ pub fn derive_object(input: TokenStream) -> TokenStream {
     let expanded = quote! {
         #[allow(non_upper_case_globals)]
         #[used]
-        #[cfg_attr(target_os = "linux", link_section = ".ctors")]
-        #[cfg_attr(target_os = "macos", link_section = "__DATA,__mod_init_func")]
+        #[cfg_attr(
+            not(any(target_vendor = "apple", target_os = "windows")),
+            link_section = ".init_array"
+        )]
+        #[cfg_attr(target_vendor = "apple", link_section = "__DATA,__mod_init_func")]
         #[cfg_attr(target_os = "windows", link_section = ".CRT$XCU")]
         pub static #module_static: extern "C" fn() = {
             extern "C" fn __register() {
diff --git a/rust/qemu-api/src/definitions.rs b/rust/qemu-api/src/definitions.rs
index 49ac59af123..3323a665d92 100644
--- a/rust/qemu-api/src/definitions.rs
+++ b/rust/qemu-api/src/definitions.rs
@@ -31,8 +31,11 @@ pub trait Class {
 macro_rules! module_init {
     ($func:expr, $type:expr) => {
         #[used]
-        #[cfg_attr(target_os = "linux", link_section = ".ctors")]
-        #[cfg_attr(target_os = "macos", link_section = "__DATA,__mod_init_func")]
+        #[cfg_attr(
+            not(any(target_vendor = "apple", target_os = "windows")),
+            link_section = ".init_array"
+        )]
+        #[cfg_attr(target_vendor = "apple", link_section = "__DATA,__mod_init_func")]
         #[cfg_attr(target_os = "windows", link_section = ".CRT$XCU")]
         pub static LOAD_MODULE: extern "C" fn() = {
             extern "C" fn __load() {
@@ -48,8 +51,11 @@ extern "C" fn __load() {
         // NOTE: To have custom identifiers for the ctor func we need to either supply
         // them directly as a macro argument or create them with a proc macro.
         #[used]
-        #[cfg_attr(target_os = "linux", link_section = ".ctors")]
-        #[cfg_attr(target_os = "macos", link_section = "__DATA,__mod_init_func")]
+        #[cfg_attr(
+            not(any(target_vendor = "apple", target_os = "windows")),
+            link_section = ".init_array"
+        )]
+        #[cfg_attr(target_vendor = "apple", link_section = "__DATA,__mod_init_func")]
         #[cfg_attr(target_os = "windows", link_section = ".CRT$XCU")]
         pub static LOAD_MODULE: extern "C" fn() = {
             extern "C" fn __load() {
-- 
2.46.2


