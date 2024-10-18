Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D8BD30011
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 14:46:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1oCT-0008FV-HX; Fri, 18 Oct 2024 10:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t1oCS-0008FI-SH
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:43:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t1oCR-0002bf-7X
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:43:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729262610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9v8sd7Ub7nOvHg864QFQKFIxnhnYovhgbjN7vbVz0Rw=;
 b=ZiIuq1irw6etBjw9kFjw425RauLJZMHcvGjWn+FcNje2hvVTKbwPQEB7+J7xqM9BC2Bn1v
 sEn+sfPlGpCZBRNL1ZyeK9VgT+duWtyK+zsvJHbKAWZNPlmBUltvw9kP0lYhTLxFtQjOXN
 eQmI9un7LlNmwQza25Kv4WH+WaeOWCU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-AaCNfGBePx6LJpZAiuW5JA-1; Fri, 18 Oct 2024 10:43:29 -0400
X-MC-Unique: AaCNfGBePx6LJpZAiuW5JA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4315b7b0c16so13556545e9.1
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 07:43:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729262607; x=1729867407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9v8sd7Ub7nOvHg864QFQKFIxnhnYovhgbjN7vbVz0Rw=;
 b=S1xiONTkmRhJ4XL3iIaPWZp/LOpE7bPBdIXwx+nanQ2HFFLJ85DUyjSgGsPYr5z36C
 ritKmIQ09PH+THV3ngEgcMqJ30GLeXoClF/5xKJFt8eCdHWRFQPwihGjEU/pVZKnbfeC
 8BVccnii2KOAGo2ZzLf7l34TFr5Ghv4VhDYru4N0ZN0YMI7lhir/IGaPoguv2+1eeIaK
 Uz/7NnQNX1AMchCjYC+dbwh/BlgXpfjoc/psCZOH7dmg260bj3zGfR9ucE+XWfL+5WIO
 j5QyIPoz9bnZa0uj+bP+lsb19uWzeVmnWcRh0JM6K2INld65lEBWRQwVd3GmQ6xJ0+Zo
 +obQ==
X-Gm-Message-State: AOJu0YzXMX9cEZAaMB8p4t5xx8MKGVKRK5DipNMtc/OJVELVDhkWpiK3
 lFlGO+i0V2R5MQ3Q14ooRRng70Yo+rzyocta8555433z4sIJEROzrdHBwVflh7R4+CDWn25HhSZ
 NL7R9+wBJrFl81Nohxb5hRshFiQRKjwNHCKvnzB/aVdt2qTo2ukivkBnnVofG+sMNHoXKVv0Mw7
 WxP9Lsuki3CjLIezcPaZFl4C0oAuu4D5j54Vt4eMk=
X-Received: by 2002:adf:fd0a:0:b0:37d:398f:44f9 with SMTP id
 ffacd0b85a97d-37eab70f77amr1699550f8f.32.1729262607341; 
 Fri, 18 Oct 2024 07:43:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmsK1ZtNUDZD6+1/uyzepMga6cblRrFvNPDyjj7DVWRl3MAM1pPE31ixHScSep2apNPCRBew==
X-Received: by 2002:adf:fd0a:0:b0:37d:398f:44f9 with SMTP id
 ffacd0b85a97d-37eab70f77amr1699529f8f.32.1729262606868; 
 Fri, 18 Oct 2024 07:43:26 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43160e0a87csm25800275e9.25.2024.10.18.07.43.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 07:43:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: [PATCH 06/13] rust: remove unused macro module_init!
Date: Fri, 18 Oct 2024 16:42:58 +0200
Message-ID: <20241018144306.954716-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241018144306.954716-1-pbonzini@redhat.com>
References: <20241018144306.954716-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Registering the object is now done by the #[derive(Object)] macro.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/definitions.rs | 43 --------------------------------
 1 file changed, 43 deletions(-)

diff --git a/rust/qemu-api/src/definitions.rs b/rust/qemu-api/src/definitions.rs
index 49ac59af123..73ef9a52c1b 100644
--- a/rust/qemu-api/src/definitions.rs
+++ b/rust/qemu-api/src/definitions.rs
@@ -27,49 +27,6 @@ pub trait Class {
     >;
 }
 
-#[macro_export]
-macro_rules! module_init {
-    ($func:expr, $type:expr) => {
-        #[used]
-        #[cfg_attr(target_os = "linux", link_section = ".ctors")]
-        #[cfg_attr(target_os = "macos", link_section = "__DATA,__mod_init_func")]
-        #[cfg_attr(target_os = "windows", link_section = ".CRT$XCU")]
-        pub static LOAD_MODULE: extern "C" fn() = {
-            extern "C" fn __load() {
-                unsafe {
-                    $crate::bindings::register_module_init(Some($func), $type);
-                }
-            }
-
-            __load
-        };
-    };
-    (qom: $func:ident => $body:block) => {
-        // NOTE: To have custom identifiers for the ctor func we need to either supply
-        // them directly as a macro argument or create them with a proc macro.
-        #[used]
-        #[cfg_attr(target_os = "linux", link_section = ".ctors")]
-        #[cfg_attr(target_os = "macos", link_section = "__DATA,__mod_init_func")]
-        #[cfg_attr(target_os = "windows", link_section = ".CRT$XCU")]
-        pub static LOAD_MODULE: extern "C" fn() = {
-            extern "C" fn __load() {
-                unsafe extern "C" fn $func() {
-                    $body
-                }
-
-                unsafe {
-                    $crate::bindings::register_module_init(
-                        Some($func),
-                        $crate::bindings::module_init_type::MODULE_INIT_QOM,
-                    );
-                }
-            }
-
-            __load
-        };
-    };
-}
-
 #[macro_export]
 macro_rules! type_info {
     ($t:ty) => {
-- 
2.46.2


