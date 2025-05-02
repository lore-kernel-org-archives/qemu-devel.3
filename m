Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 010DBC3ABAA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 10:26:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAnYW-0001DN-Io; Fri, 02 May 2025 06:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uAnYU-0001Cs-KR
 for qemu-devel@nongnu.org; Fri, 02 May 2025 06:23:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uAnYS-0000gl-0Y
 for qemu-devel@nongnu.org; Fri, 02 May 2025 06:23:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746181419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+KZidse3o3NrsJSDXRiipRvy3WbuaGi3BmMJMyV+q9w=;
 b=P2SrT7MAdWaSpuE41ogmW1whuE1aM+J6Vu/QcnmToIlUdXLnzqA7l2yjmuklYIQ0rxy34y
 w8mYWeLd8Ct3J5ETA+p4aEcNg+OBA4InMA6S5vVCo2RvdDUwl6DlEy5d6AEmLhpLVtNi3s
 JtBrb6ZQgDTR8C9fv5Rbpnxc/Eb45pI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-iAv-wbCgNFSTQyDFoT_7BA-1; Fri, 02 May 2025 06:23:38 -0400
X-MC-Unique: iAv-wbCgNFSTQyDFoT_7BA-1
X-Mimecast-MFC-AGG-ID: iAv-wbCgNFSTQyDFoT_7BA_1746181417
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-39130f02631so505988f8f.2
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 03:23:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746181416; x=1746786216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+KZidse3o3NrsJSDXRiipRvy3WbuaGi3BmMJMyV+q9w=;
 b=VWq1QbjOQYNNKqXALz4RTOC5HIwH/0QvoEgEd41fxcfB21B1RsKoOPNg0cGLFp+lqm
 wnjBgjQaUolh0cTeF92WNet665VJIPMOdWR3JtpA/l13h5I/HPw73yGgH1lHMzJZP2wz
 v/Y6BYkNzGvAPITi3JlK9RtrhuyGIghWYHVbNx1YImxBLimP22TdDRkEGqPSKy69xVdZ
 tKRPlhJaN1/RevNTdlZZcC/hdVdS8fNukaQIhJxSjxbgvlyZrJwMXh3w3FBrz6b6SEvn
 xoh61Q5GCpXRTV4sdSCe9Wouw7pcxQ+I9HzXaOUBdCZDGtCOXMPrmsvdOGs2xIqFbjrV
 3dIA==
X-Gm-Message-State: AOJu0YzDzyoXwnRe5shjeEqOHDBQGnrvtXxRaCJ/48YXeV9ypFHnHDqd
 qJOObmSqB548nLA+tANaYwwkxw3tM8oYuA67867xSRrEVvYGBUQkSXqJOAZ3AQ0zxw6UBPBBXru
 yFGqwQcL5fT0U8ATKME5OOyvyn/dOUq2EKNAfUzQ4MWyceA+Ru5sZ6R7JpCDKvWyL78iqtRGA87
 8KrtL6I67Gls35BB7V1sQfXff4qj1l0a0dTqSo
X-Gm-Gg: ASbGncuXXCoEyPgCj4bhx4Ba98iBDwwKAjWX3gLLjZFrY7ILssoBHkh2o/6k5d4g/dw
 /A+9wdLTw420s3OqbyKogaQI7uWvYxtfYbhpgfUaWuCP/rGE4noQZ3T9OMGuNpq+OLa+CAsQ61H
 C8iXvzNGwDjHHZi7ZGoBB/Ak0XwjIfCenDjKrCK88xOmEVo2hlEB+SD7arDOp+VAko7UQn5G1JQ
 jh+BUMcQzWX8wzstXewZw306a76EwnWvTlJxkicsJ+m9rSQsEw08ujk98YtV73liTpOBe9K4uZu
 TENq7LMBYVYpjqc=
X-Received: by 2002:a05:6000:2211:b0:3a0:7a7c:235f with SMTP id
 ffacd0b85a97d-3a099ae939fmr1656679f8f.40.1746181415710; 
 Fri, 02 May 2025 03:23:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFe841JaWdd9NmftMm7CM9LbE/3Sv/SvrR89UJ8RlEG4+lI5yeovCaZ3Vo4sZo3Qc6gS9KeDA==
X-Received: by 2002:a05:6000:2211:b0:3a0:7a7c:235f with SMTP id
 ffacd0b85a97d-3a099ae939fmr1656652f8f.40.1746181415315; 
 Fri, 02 May 2025 03:23:35 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae82e4sm1769890f8f.58.2025.05.02.03.23.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 03:23:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 4/9] rust: qemu_api_macros: use "let ... else"
Date: Fri,  2 May 2025 12:23:17 +0200
Message-ID: <20250502102323.104815-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250502102323.104815-1-pbonzini@redhat.com>
References: <20250502102323.104815-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

"let ... else" is useful when visiting syntax trees, to avoid multiple
levels of indentation.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api-macros/src/lib.rs | 84 ++++++++++++++++-----------------
 1 file changed, 40 insertions(+), 44 deletions(-)

diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/lib.rs
index eda0d46d122..1448f3025a4 100644
--- a/rust/qemu-api-macros/src/lib.rs
+++ b/rust/qemu-api-macros/src/lib.rs
@@ -16,50 +16,47 @@ fn get_fields<'a>(
     input: &'a DeriveInput,
     msg: &str,
 ) -> Result<&'a Punctuated<Field, Comma>, MacroError> {
-    if let Data::Struct(s) = &input.data {
-        if let Fields::Named(fs) = &s.fields {
-            Ok(&fs.named)
-        } else {
-            Err(MacroError::Message(
-                format!("Named fields required for {}", msg),
-                input.ident.span(),
-            ))
-        }
-    } else {
-        Err(MacroError::Message(
+    let Data::Struct(s) = &input.data else {
+        return Err(MacroError::Message(
             format!("Struct required for {}", msg),
             input.ident.span(),
         ))
-    }
+    };
+    let Fields::Named(fs) = &s.fields else {
+        return Err(MacroError::Message(
+            format!("Named fields required for {}", msg),
+            input.ident.span(),
+        ))
+    };
+    Ok(&fs.named)
 }
 
 fn get_unnamed_field<'a>(input: &'a DeriveInput, msg: &str) -> Result<&'a Field, MacroError> {
-    if let Data::Struct(s) = &input.data {
-        let unnamed = match &s.fields {
-            Fields::Unnamed(FieldsUnnamed {
-                unnamed: ref fields,
-                ..
-            }) => fields,
-            _ => {
-                return Err(MacroError::Message(
-                    format!("Tuple struct required for {}", msg),
-                    s.fields.span(),
-                ))
-            }
-        };
-        if unnamed.len() != 1 {
-            return Err(MacroError::Message(
-                format!("A single field is required for {}", msg),
-                s.fields.span(),
-            ));
-        }
-        Ok(&unnamed[0])
-    } else {
-        Err(MacroError::Message(
+    let Data::Struct(s) = &input.data else {
+        return Err(MacroError::Message(
             format!("Struct required for {}", msg),
             input.ident.span(),
         ))
+    };
+    let unnamed = match &s.fields {
+        Fields::Unnamed(FieldsUnnamed {
+            unnamed: ref fields,
+            ..
+        }) => fields,
+        _ => {
+            return Err(MacroError::Message(
+                format!("Tuple struct required for {}", msg),
+                s.fields.span(),
+            ))
+        }
+    };
+    if unnamed.len() != 1 {
+        return Err(MacroError::Message(
+            format!("A single field is required for {}", msg),
+            s.fields.span(),
+        ));
     }
+    Ok(&unnamed[0])
 }
 
 fn is_c_repr(input: &DeriveInput, msg: &str) -> Result<(), MacroError> {
@@ -210,20 +207,19 @@ fn get_repr_uN(input: &DeriveInput, msg: &str) -> Result<Path, MacroError> {
 }
 
 fn get_variants(input: &DeriveInput) -> Result<&Punctuated<Variant, Comma>, MacroError> {
-    if let Data::Enum(e) = &input.data {
-        if let Some(v) = e.variants.iter().find(|v| v.fields != Fields::Unit) {
-            return Err(MacroError::Message(
-                "Cannot derive TryInto for enum with non-unit variants.".to_string(),
-                v.fields.span(),
-            ));
-        }
-        Ok(&e.variants)
-    } else {
-        Err(MacroError::Message(
+    let Data::Enum(e) = &input.data else {
+        return Err(MacroError::Message(
             "Cannot derive TryInto for union or struct.".to_string(),
             input.ident.span(),
         ))
+    };
+    if let Some(v) = e.variants.iter().find(|v| v.fields != Fields::Unit) {
+        return Err(MacroError::Message(
+            "Cannot derive TryInto for enum with non-unit variants.".to_string(),
+            v.fields.span(),
+        ));
     }
+    Ok(&e.variants)
 }
 
 #[rustfmt::skip::macros(quote)]
-- 
2.49.0


