Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A054EC83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 06:47:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucIOS-000152-Ne; Thu, 17 Jul 2025 02:47:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ucI5t-0008KH-21
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 02:27:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ucI5n-00086r-0g
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 02:27:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752733661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/noCMugMiqjebseDSiV8dQIXAh3/h5Bn5iEmWvEu9kY=;
 b=c6jH4LoPmypiJMt9nJtMwGQTLCli49Dq421Mb0R+Jmrj3F7yeXEFg++Sk7H0wPdtQ6Gztc
 gV3Cexs76yxlmYF3JuDsuav4ywtTFHkJ2ndS36M3BRxoOzfeX28sP+gBWtkuLMsi1E4QfD
 JEJus/xQ0Dd3YqQIFNNi+uoEWyU9QQo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-pAHablfsNzCCcsljmHGJJw-1; Thu, 17 Jul 2025 02:27:40 -0400
X-MC-Unique: pAHablfsNzCCcsljmHGJJw-1
X-Mimecast-MFC-AGG-ID: pAHablfsNzCCcsljmHGJJw_1752733659
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-453817323afso3149835e9.1
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 23:27:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752733658; x=1753338458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/noCMugMiqjebseDSiV8dQIXAh3/h5Bn5iEmWvEu9kY=;
 b=lVldVQ+/g2DoO7F7SDlKqsXFnQQbvecAgG/+GVZ2jOR9eAevlul8FjmYHRvwpGW6Qo
 li6ybGIeOVBDr8Ng07DrtGJ1HLu55rK6bL+Jb0oG3dyaOMJ0T85Z41soF0UaW7Soi604
 Yl/ibEM9lhC5CdlwWik9CVGTPm5NHxnu9JtiWbKfEYGW0mwOmfSc2j5xGzPF2R1aTJvH
 3zn/CoJhPQgsADhvZ8if09scIuVqxkwJ3uT/Q+vfgz6aIZUjIkdTSFhHXkD6MCGQMDkW
 CNakEYCEiYccKs6vJITD/T7uD+x+ftEpkNT8XNEghMkLqbomWnFugf5d9gfNQBpSGlsq
 bJYg==
X-Gm-Message-State: AOJu0Yw4kLuN9Xxhe0lyPZo3QIriNXUvnl83agfw2BmWOjuycRZVBqYK
 q5waIGKID6dTop+aSHE8yvOUCJYzbTc+wwUauIWakJDgMF6YkhhcSR9r3x31M1M+49d/+8YGSee
 I0f2SWrSre/0SvucmOinuaFqbfBPPpvOdgt47arTiPpcjKPT1JVbHqQ4u4Obwlzkgwbo4bTScmg
 BXvAbDe8QnU36KiUvnULnDVYtAIuqOtAmWespIwTmR
X-Gm-Gg: ASbGncs7VHq4FAan+kQ12NTPUMgIVf77emFt4YNR1fL9KAPhX8UWQEVUvgIe09IP8oY
 pM9rO1aJYUhpcmw1JajPSp61dN014tSi+V6INVa5JSGNy5RgE/u19S6o6/uiAt6FgnzotHyvQB7
 3wZuG/0H7L8zEL5Eyey3ktrbhB0i2b6fLA6hy1d/ecgqaVamtXNMAEK1MrDo45o/AhOO+191YAY
 1EjYh6zYKTw1sHG4ReZgxUZx25RXeMsSMxCZz438G7ccIbxXYLejHT0bp36MWx1fXMGDtZ+LXji
 bKKaxeSGCc0NnEQP4jjv+xhvpyr3PfUHrbVBYtTQD10=
X-Received: by 2002:a05:600c:3555:b0:456:22f0:d9ca with SMTP id
 5b1f17b1804b1-4562e28615dmr44305815e9.26.1752733657967; 
 Wed, 16 Jul 2025 23:27:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAzrPcCAwG842sVfUtiTgVZKBOLgrRSXmFxcohfHC+tdwmLrhUfVjT74lGKlPmmFlc6Q9yZA==
X-Received: by 2002:a05:600c:3555:b0:456:22f0:d9ca with SMTP id
 5b1f17b1804b1-4562e28615dmr44305565e9.26.1752733657468; 
 Wed, 16 Jul 2025 23:27:37 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4562e886286sm41382885e9.26.2025.07.16.23.27.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 23:27:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	manos.pitsidianakis@linaro.org
Subject: [PATCH 3/4] rust: qemu-api-macros: support matching more than one
 error
Date: Thu, 17 Jul 2025 08:27:26 +0200
Message-ID: <20250717062727.305466-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250717062727.305466-1-pbonzini@redhat.com>
References: <20250717062727.305466-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api-macros/src/tests.rs | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/rust/qemu-api-macros/src/tests.rs b/rust/qemu-api-macros/src/tests.rs
index 4fbff97bffb..0e5a5728908 100644
--- a/rust/qemu-api-macros/src/tests.rs
+++ b/rust/qemu-api-macros/src/tests.rs
@@ -7,9 +7,9 @@
 use super::*;
 
 macro_rules! derive_compile_fail {
-    ($derive_fn:ident, $input:expr, $error_msg:expr) => {{
+    ($derive_fn:ident, $input:expr, $($error_msg:expr),+ $(,)?) => {{
         let input: proc_macro2::TokenStream = $input;
-        let error_msg: &str = $error_msg;
+        let error_msg = &[$( quote! { ::core::compile_error! { $error_msg } } ),*];
         let derive_fn: fn(input: syn::DeriveInput) -> Result<proc_macro2::TokenStream, syn::Error> =
             $derive_fn;
 
@@ -18,7 +18,7 @@ macro_rules! derive_compile_fail {
         let err = result.unwrap_err().into_compile_error();
         assert_eq!(
             err.to_string(),
-            quote! { ::core::compile_error! { #error_msg } }.to_string()
+            quote! { #(#error_msg)* }.to_string()
         );
     }};
 }
-- 
2.50.1


