Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F34D5CCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 15:15:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7Elm-00007e-81; Fri, 10 Oct 2025 11:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v7Eli-000054-Jl
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 11:10:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v7ElP-00047J-5L
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 11:10:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760109031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pCPK7I5rXb+g55P6MWyJcXND3mxADuY6GKf7ZyxSOeg=;
 b=KxaiTc7HdPWUe/YzO4EGeLsjuaECgx4pFzs/E6cGYvv4IO2D2hY6ppSnHGVt+FgP7J0mYs
 5EB48nIFbi+UCuLOJqwI4STTTVLACAVVgVcJNuE8xfCYFCD1xyOZI/pyIkRrcUNIGUjN8m
 XiY35JEn7kIrSNvbLu2aGTmBDBRo6Fg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-MKMyhrP3MziRcFiZKLs8nQ-1; Fri, 10 Oct 2025 11:10:30 -0400
X-MC-Unique: MKMyhrP3MziRcFiZKLs8nQ-1
X-Mimecast-MFC-AGG-ID: MKMyhrP3MziRcFiZKLs8nQ_1760109029
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b2d1072a9c4so194885266b.3
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 08:10:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760109028; x=1760713828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pCPK7I5rXb+g55P6MWyJcXND3mxADuY6GKf7ZyxSOeg=;
 b=LIOKJ7mn08uA3bQGPwe2QT4UlykxUitXItjuk5VqgkM8Wcd0le4WzpM7FzEdRKAm9l
 76b0AHCEdmE23sQZDcDFtSUimNVr2xy9zXnvIvUGtjCtghs2Cy9e2H9BNgfjyqGMCPfr
 vWHglqgHTvUSArYgX1qxlvHmGS7bwURMTbERqNAJJ4737CXSs6fbQNGzCMsPwoKnEyVz
 CcWe7LporNfvEAH7iTpWpSQVm5MRNVkKXMeRzWrrrtO/9R3T2aiWAQBQt3NAwTMETn2Q
 Hrq3s10LdxiPPov0X46cHVf+VlLwcP/fKczji7pUv2b+fnz5v7aiOFmEOhPaAIooysmO
 ia9Q==
X-Gm-Message-State: AOJu0Yw89brrexltQmJqajSQ2RrT2y4Xa1Tih7/LGpQQ3qqR1B3N7xlv
 47hnWVE1vOfQdHSEsL2HJ51Ftg2y4LKs1pfVu5z4VKptcus8VfaCeJzN+EExlUsbc9ny7i0V5r4
 Sif0aePA0cCi2DzjKnoRy5MfZ7eHfFozkBg+sIv0v79TZEPXxdkH0jqXmINUPl/IF7lq2mtLNm5
 kIprpIwlc9nqPaXL5GngoiQsl/u6YewVek4Ra4pvJP
X-Gm-Gg: ASbGnct4hqn44mwDL5sKLFurJTDcp3EO3OhAgiZXxhyC/lCuGP7HT1tM8sb3eKysI/w
 9SKAQ8ry7m9bUKv4ib5VaqR8j3ns018Litplwhq0aM4ifgjhyWoeHZ50aLm9HQTx4PjkJMtdvR0
 w712vnq2M1CJfiATY6pLOgV1G31pfDz9ELXizuWWyurnGWoc9LLHiyAY/OXS+cDkGKIAl6thhGh
 +vmn9Wh2IxQtN49Jz2jvf5MsrDbeX5I5ug88VLGLTfgNuE/0EltTViEfJfQFfA0v2YCX38Wl2Ym
 Efuo9LI6mPg4mf2IssMRhvsAgQQlnlo2tWd/DT5u80ZSXsMU8SvIbW0h/NPfjbx2RittmSWhKo6
 5OsNfvLnkmhlafeN+LfNPHpXXzriZEykOGrHyq24D4eMe
X-Received: by 2002:a17:907:72cf:b0:b40:b6a9:f704 with SMTP id
 a640c23a62f3a-b50a9b61d94mr1243689366b.7.1760109028452; 
 Fri, 10 Oct 2025 08:10:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHf+1tcAvT0bKtrZRDdvEXrXpXVQEPTz2o++Knf/KHNtenmJTOLop/xvRtQ/OliP7ciJSd0A==
X-Received: by 2002:a17:907:72cf:b0:b40:b6a9:f704 with SMTP id
 a640c23a62f3a-b50a9b61d94mr1243685666b.7.1760109027938; 
 Fri, 10 Oct 2025 08:10:27 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.231.162])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b55d8c12b62sm253141466b.48.2025.10.10.08.10.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 08:10:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com,
	marcandre.lureau@redhat.com,
	qemu-rust@nongnu.org
Subject: [PATCH 08/19] rust/qobject: add Deserialize implementation
Date: Fri, 10 Oct 2025 17:09:53 +0200
Message-ID: <20251010151006.791038-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010151006.791038-1-pbonzini@redhat.com>
References: <20251010151006.791038-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This allows QObject to be created from any serializable format, for
example JSON via serde_json.

This is not too useful, since QObjects are produced by
C code or by serializing structs, but it can be used for testing
and it is part of the full implementation of a serde format.

It is relatively simple and similar to the Serializer, just with
the extra indirection of a Visitor.

Co-authored-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/util/meson.build                |   1 +
 rust/util/src/qobject/deserialize.rs | 134 +++++++++++++++++++++++++++
 rust/util/src/qobject/mod.rs         |   1 +
 3 files changed, 136 insertions(+)
 create mode 100644 rust/util/src/qobject/deserialize.rs

diff --git a/rust/util/meson.build b/rust/util/meson.build
index 39f427b3456..9f8fbd49f00 100644
--- a/rust/util/meson.build
+++ b/rust/util/meson.build
@@ -39,6 +39,7 @@ _util_rs = static_library(
     {'.': _util_bindings_inc_rs,
     'qobject': [
       'src/qobject/mod.rs',
+      'src/qobject/deserialize.rs',
       'src/qobject/error.rs',
       'src/qobject/serializer.rs',
       'src/qobject/serialize.rs',
diff --git a/rust/util/src/qobject/deserialize.rs b/rust/util/src/qobject/deserialize.rs
new file mode 100644
index 00000000000..280a577b6be
--- /dev/null
+++ b/rust/util/src/qobject/deserialize.rs
@@ -0,0 +1,134 @@
+//! `QObject` deserialization
+//!
+//! This module implements the [`Deserialize`] trait for `QObject`,
+//! allowing it to be created from any serializable format, for
+//! example JSON.
+
+use core::fmt;
+use std::ffi::CString;
+
+use serde::de::{self, Deserialize, MapAccess, SeqAccess, Visitor};
+
+use super::{to_qobject, QObject};
+
+impl<'de> Deserialize<'de> for QObject {
+    #[inline]
+    fn deserialize<D>(deserializer: D) -> Result<QObject, D::Error>
+    where
+        D: serde::Deserializer<'de>,
+    {
+        struct ValueVisitor;
+
+        impl<'de> Visitor<'de> for ValueVisitor {
+            type Value = QObject;
+
+            fn expecting(&self, formatter: &mut fmt::Formatter) -> fmt::Result {
+                formatter.write_str("any valid JSON value")
+            }
+
+            #[inline]
+            fn visit_bool<E>(self, value: bool) -> Result<QObject, E> {
+                Ok(value.into())
+            }
+
+            #[inline]
+            fn visit_i64<E>(self, value: i64) -> Result<QObject, E> {
+                Ok(value.into())
+            }
+
+            fn visit_i128<E>(self, value: i128) -> Result<QObject, E>
+            where
+                E: serde::de::Error,
+            {
+                to_qobject(value).map_err(|_| de::Error::custom("number out of range"))
+            }
+
+            #[inline]
+            fn visit_u64<E>(self, value: u64) -> Result<QObject, E> {
+                Ok(value.into())
+            }
+
+            fn visit_u128<E>(self, value: u128) -> Result<QObject, E>
+            where
+                E: serde::de::Error,
+            {
+                to_qobject(value).map_err(|_| de::Error::custom("number out of range"))
+            }
+
+            #[inline]
+            fn visit_f64<E>(self, value: f64) -> Result<QObject, E> {
+                Ok(value.into())
+            }
+
+            #[inline]
+            fn visit_str<E>(self, value: &str) -> Result<QObject, E>
+            where
+                E: serde::de::Error,
+            {
+                CString::new(value)
+                    .map_err(|_| de::Error::custom("NUL character in string"))
+                    .map(QObject::from)
+            }
+
+            #[inline]
+            fn visit_string<E>(self, value: String) -> Result<QObject, E>
+            where
+                E: serde::de::Error,
+            {
+                CString::new(value)
+                    .map_err(|_| de::Error::custom("NUL character in string"))
+                    .map(QObject::from)
+            }
+
+            #[inline]
+            fn visit_none<E>(self) -> Result<QObject, E> {
+                Ok(().into())
+            }
+
+            #[inline]
+            fn visit_some<D>(self, deserializer: D) -> Result<QObject, D::Error>
+            where
+                D: serde::Deserializer<'de>,
+            {
+                Deserialize::deserialize(deserializer)
+            }
+
+            #[inline]
+            fn visit_unit<E>(self) -> Result<QObject, E> {
+                Ok(().into())
+            }
+
+            #[inline]
+            fn visit_seq<V>(self, mut visitor: V) -> Result<QObject, V::Error>
+            where
+                V: SeqAccess<'de>,
+            {
+                // TODO: insert elements one at a time
+                let mut vec = Vec::<QObject>::new();
+
+                while let Some(elem) = visitor.next_element()? {
+                    vec.push(elem);
+                }
+                Ok(QObject::from_iter(vec))
+            }
+
+            fn visit_map<V>(self, mut visitor: V) -> Result<QObject, V::Error>
+            where
+                V: MapAccess<'de>,
+            {
+                // TODO: insert elements one at a time
+                let mut vec = Vec::<(CString, QObject)>::new();
+
+                if let Some(first_key) = visitor.next_key()? {
+                    vec.push((first_key, visitor.next_value()?));
+                    while let Some((key, value)) = visitor.next_entry()? {
+                        vec.push((key, value));
+                    }
+                }
+                Ok(QObject::from_iter(vec))
+            }
+        }
+
+        deserializer.deserialize_any(ValueVisitor)
+    }
+}
diff --git a/rust/util/src/qobject/mod.rs b/rust/util/src/qobject/mod.rs
index f8bd195ca2b..80c496b8a63 100644
--- a/rust/util/src/qobject/mod.rs
+++ b/rust/util/src/qobject/mod.rs
@@ -6,6 +6,7 @@
 
 #![deny(clippy::unwrap_used)]
 
+mod deserialize;
 mod error;
 mod serialize;
 mod serializer;
-- 
2.51.0


