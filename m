Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23F15D1BDD0
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 17:29:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t80rt-0005A0-78; Mon, 04 Nov 2024 12:27:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80rs-00058u-1N
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:27:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80ro-0000F4-Ui
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:27:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730741271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mP3j3evq86lhHlL3nhlSwnDw7BkQlXrJv1c8ym7QLnQ=;
 b=GC5+Xrlu7UxGHa3wtjioCx9SFZnEcWOh7qkA4OYT3+WcEfRanRFqGZ+tyUP4m2N7ErTsSI
 vDBp/e4WcG1xckqYNDCaKxcp/o0bOgauv3vPHZsZCHj1PO8My7lnMWxdvfLM1MvCzUTbVn
 +vsx3hmQ4lxXY6S6LUN+4xF3VSqhbEw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-dpAiKVBpNYma5k7JJBm-9Q-1; Mon, 04 Nov 2024 12:27:49 -0500
X-MC-Unique: dpAiKVBpNYma5k7JJBm-9Q-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4315a0f25afso30782255e9.3
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 09:27:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730741268; x=1731346068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mP3j3evq86lhHlL3nhlSwnDw7BkQlXrJv1c8ym7QLnQ=;
 b=wuj7FARpTPdtJax1iPusjc4oatSBQe5A8zF4bQj06PNCCAav/XtzD9oYYcSwPNPYyq
 rFWNA0RGoyBj4J/8i15VTFpfWuScMCdNgARSjPk8VVVf6kOrjv7UPHf6m0jb/+dabjhi
 luNLIGqBGUtOa3VrFQyfS9pZmCCR8+DmqSR2sT2OYoeVojdrRtZJkWMEKfjdoJ+3xoZ3
 GXVlAF8pj4eBtUua9OCIyJoqPvXZTLkxwybeyABIkTtBfUyMR9WhSSEiMqNhM9LXScxQ
 faciA3pp4quw+C5ameKmwJG6N5y6Kv/MBm/HVBy4Ce8cxJ+jPpffYod9jNqQvSBQE0Ym
 op+g==
X-Gm-Message-State: AOJu0YwV4hZwItZeXSgkZx9EVYEQgoYRDsZcu2t5fcZDTl0TROH/Af7z
 eScM/SE1MczA8F9HA/cK/VRlLcvS3xzHgns/53FXWb5/IEFIwSVninzduVMhJgmQrczUf96FN91
 e2U34/7csxpY/R6dfxlK+pAExP8YCw9zxI1qkLwYd4+EyZbi28/OSM5oKy7aAbXJYdjYf1r2Lgd
 umXwbfAzyYUKxRQdS+Z7gYReVJLrWWSx6PijttyQo=
X-Received: by 2002:a05:600c:45cd:b0:431:5eeb:2214 with SMTP id
 5b1f17b1804b1-4319ad363eamr270835845e9.33.1730741267783; 
 Mon, 04 Nov 2024 09:27:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDt2bahnHtLFrwePwW6kfkxzDFdriaiVVUuijGKMBoP0pQ6+DQoZl9yA8nDdNn8I5NY8LjKg==
X-Received: by 2002:a05:600c:45cd:b0:431:5eeb:2214 with SMTP id
 5b1f17b1804b1-4319ad363eamr270835565e9.33.1730741267387; 
 Mon, 04 Nov 2024 09:27:47 -0800 (PST)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d5ab2aasm159229815e9.6.2024.11.04.09.27.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 09:27:45 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 11/40] rust: modernize link_section usage for ELF platforms
Date: Mon,  4 Nov 2024 18:26:50 +0100
Message-ID: <20241104172721.180255-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104172721.180255-1-pbonzini@redhat.com>
References: <20241104172721.180255-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

Some newer ABI implementations do not provide .ctors; and while
some linkers rewrite .ctors into .init_array, not all of them do.
Use the newer .init_array ABI, which works more reliably, and
apply it to all non-Apple, non-Windows platforms.

This is similar to how the ctor crate operates; without this change,
"#[derive(Object)]" does not work on Fedora 41.

Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
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
2.47.0


