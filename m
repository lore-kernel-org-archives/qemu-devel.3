Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3BAAD3398E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 14:36:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5QmQ-0002CH-1u; Mon, 28 Oct 2024 10:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5QlB-0000UI-LO
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 10:30:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5Ql9-0003yE-Ts
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 10:30:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730125817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mP3j3evq86lhHlL3nhlSwnDw7BkQlXrJv1c8ym7QLnQ=;
 b=WWZyrzPrGJ5HntjAR/BZNkwYq9sZDMj6cpseWJve2IF3FpZOO4asth9sZZZ32e5jSo+r2y
 Tk9R5cNe9kSg7xCg6awZPy3CZ05nil1m3Zludj3nXiFmCTrUCUEl9NGvliL6eNI113nSvg
 VyUo7HXaw6k3s9OQpU7Vw0f/uiIUFvY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-urF96lmrMXC3hmKn2rS5Jw-1; Mon, 28 Oct 2024 10:30:16 -0400
X-MC-Unique: urF96lmrMXC3hmKn2rS5Jw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4316e350d6aso31978665e9.3
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 07:30:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730125813; x=1730730613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mP3j3evq86lhHlL3nhlSwnDw7BkQlXrJv1c8ym7QLnQ=;
 b=gTECaQUyyJFfSFgztIOz9T17gduliml5BsgA/LNE5wVbRT+ljsBzrKZm74U0sufbzO
 m63prJQ+JMhOA+I6af1kKashBaXJQDA7lQIQ/DBAJT/zWCS1uy6tQgXeSltwMBv5o1Dy
 tVuOOTA544hNxFZArLT2fiMEA7Zqd8jaIlaJFIjx5kib8sJz7ZUngqFW5kY6ifK6duXy
 4v074VVK8Kf105fXImfXJR8Y8Ay1DQgfPC9C92NmZdTOvWPEDM9gFichuHfbMBl1DbUf
 gh+v1ZidHaGnYbBm55SpZincMLg98Oqa14SS0ky6yVqdNfRhDIrWivk0Sfslk3Rv6beg
 qQgQ==
X-Gm-Message-State: AOJu0YxeSNO9fNX+nZXZs0+XEu4RqqvqeWJmBcGiGRMKZ3a4xZV+7vBu
 W5J5wFCSmC7VK1qZb/rYPvw8kfQi8KmQOpAptHyxUaJXBot/VAoXE1KPIKImiXbdNLNDU3ffRNM
 2YdYH28p5VoiVVxCGKJddZvZXBZh+KrlodagJd4ib9mSHVEnmn2rE3DZr2Vl3/6uuMBQH5p4uUS
 JpUt96peAlHjp7npP1o3BvSUQH2kXmkxfsx6FGQDI=
X-Received: by 2002:a05:600c:3c8c:b0:431:251a:9dc9 with SMTP id
 5b1f17b1804b1-4319ad166femr71268685e9.25.1730125813581; 
 Mon, 28 Oct 2024 07:30:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqDmoFtPnkPtJ5PZ8XiIVp22cj09WySPdd1eKnvrzq43uFNJbszq3CD4uV8kTpfUYo+kWDyg==
X-Received: by 2002:a05:600c:3c8c:b0:431:251a:9dc9 with SMTP id
 5b1f17b1804b1-4319ad166femr71268465e9.25.1730125813151; 
 Mon, 28 Oct 2024 07:30:13 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431935f6db9sm113411485e9.29.2024.10.28.07.30.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 07:30:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Junjie Mao <junjie.mao@hotmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 15/24] rust: modernize link_section usage for ELF platforms
Date: Mon, 28 Oct 2024 15:29:22 +0100
Message-ID: <20241028142932.363687-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028142932.363687-1-pbonzini@redhat.com>
References: <20241028142932.363687-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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


