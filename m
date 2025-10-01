Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B646CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 08:06:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3rmY-0005of-Fl; Wed, 01 Oct 2025 04:01:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3rmM-0005jy-8q
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:01:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3rm0-00063Y-SE
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:01:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759305672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=esRzxxhSezsp5v+ipGZzn6zfceiaFhI4xODHPTjgqx4=;
 b=Zp4JUCBjSYWzj9IdIIqRow8kEAHocnfNFh6PqeJPHWM+FeRVh1p3Du9R3+1uzn1umgiuvI
 NjKXS7X+pE05kpUwHamdM1F7XJEQSXcaTeuFnEzmcBHKig/thchV9fGsDwx4TPgv6wnsBd
 GlhKQ3tTGCTW7aWKV8ejHPAtLT++GeY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-J84Inpf1P-ecv-ufCAXY6w-1; Wed, 01 Oct 2025 04:01:11 -0400
X-MC-Unique: J84Inpf1P-ecv-ufCAXY6w-1
X-Mimecast-MFC-AGG-ID: J84Inpf1P-ecv-ufCAXY6w_1759305670
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b3cb0f2b217so437544666b.2
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 01:01:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759305669; x=1759910469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=esRzxxhSezsp5v+ipGZzn6zfceiaFhI4xODHPTjgqx4=;
 b=YpbfgRvKQpXjE1CL9g5BEDLqIwPdqtL07cC8VQs2SB2ZgFg2Zly6zmieVO2A1jqiOB
 uqs2EOITwhjrbQPy7amdguGg1BAAycqkJLfIrR2glgMVtg+6EXnjHF6/m7xSwKTQugtu
 F6qvF04e7xXMSsC3zvMTsA78B9+GXPPbfQZDzpLLdpGehqsie3xcuPTTUc/9k3S8hTRt
 o4nGdToZVHikB/8o7CYryW9KWYM/a5dqtWD9bdJGx4fj2zmKtzuRxtoZkdGwR2goDlYu
 lJgUMD3bbsQhZq06qq1YCcxv55v8hrW3nv99pajUWwlyDDhL7Xui37L+dFkUlkZMEvWt
 bQkg==
X-Gm-Message-State: AOJu0YwHwndCPBdV2N/6wO04ZK2gBmEHpdFQ0N7QgsXBDnJD9wKqLzZ5
 +/VgQKrW7jwGqFveJtqnmsJjkubZhspp+yGOgbygMOVBxCwKdrIbkRaHyqaw8JMyc2JEHpcEsIN
 JGAg3PHu9G3vNW1TV4E1tcA8TdRq5aM0nBU4BJxh2FIQTZ2laWPhQkoUuB3Ch+WhpzoYw0a4K41
 mwCzO15gZi0wqWLHu7OpviTkwmck+ClUQ/vyRWtFsy
X-Gm-Gg: ASbGncvg/MeJVkGTDFns+8iOeBD1K+zAxriW+Wz2HfI79OODI0qoQ9A03v9yBL7ZlIr
 q4awfUTBr6IsMYKAExFJVNYb/8ajgJLQHvMF35E35aHqhWcG7FPh1UHriILPkmAEv6slCn3KTug
 8pPWUqsIx9l1ixXDd2eNUrWCq+NY3aq1+4nZyr/3NFi2ssTci0MOsupL4YKvwoKbg1NSk5G9HdA
 ZvaGfgCxVqwTkTuSRzaYEz2l4xaLFANgxrMoYVDlB9cq4r7CdfEaSg7PWbmW+QMmGItRgh3jKao
 Nikvu14ANHBz/0939wTB8gMm/TamawHihPZ7+LXkX97qO6evA/ZxZp3+/YOHojJdlfLflh8IhVO
 bJHhb82BDrwO7b6gsmFkm9ldFORB5PXWr90LNpkgtMJDo+5ANgds=
X-Received: by 2002:a17:907:9622:b0:b42:e3fb:c950 with SMTP id
 a640c23a62f3a-b46e612bedbmr289813566b.42.1759305668979; 
 Wed, 01 Oct 2025 01:01:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZBTqg/KtMOZrkRKPJoUhfr3DUgvhZxF0lCi42VDSFp1asC2CdHTVmXPMXbCnBe9fVwNEKkA==
X-Received: by 2002:a17:907:9622:b0:b42:e3fb:c950 with SMTP id
 a640c23a62f3a-b46e612bedbmr289796966b.42.1759305666903; 
 Wed, 01 Oct 2025 01:01:06 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b3d2801992csm696877966b.16.2025.10.01.01.01.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 01:01:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	armbru@redhat.com,
	marcandre.lureau@redhat.com
Subject: [PATCH 06/14] rust: add Deserialize implementation for QObject
Date: Wed,  1 Oct 2025 10:00:43 +0200
Message-ID: <20251001080051.1043944-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001075005.1041833-1-pbonzini@redhat.com>
References: <20251001075005.1041833-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
index fb152766003..2b72af99dd5 100644
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
index cd034185748..aec635a5ccc 100644
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


