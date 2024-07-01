Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6271DC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 15:00:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOIV4-00040W-QE; Mon, 01 Jul 2024 10:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOIV3-00040F-6y
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 10:59:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOIV1-0005J7-BK
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 10:59:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719845962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ItGWoIXbmG8BtrqUqVyvFsub+0df4Uw051wHIRwFpYQ=;
 b=Vz5P1xNJFfocxSWg6BFpuV3hLzFDTq4S1NL4yOyeQCUdz6SMhNr9jrT2RNp8oh67pM3Dgs
 uT5JmbhZkxkGmoEEIs18+otWCg7PsJWQS3wiXQNI0y8hhY0VME/s66B2NtieJXvL/CZ9hl
 DquiQ6fXX2Lj+MtgENxbZkjMcGPIFRA=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-C33Z-AxVO5--EY7C0qhI0A-1; Mon, 01 Jul 2024 10:59:21 -0400
X-MC-Unique: C33Z-AxVO5--EY7C0qhI0A-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2ee4a63e95cso31683741fa.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 07:59:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719845958; x=1720450758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ItGWoIXbmG8BtrqUqVyvFsub+0df4Uw051wHIRwFpYQ=;
 b=D6mx4rjIokBajljUj3RUD4dM/3OAJmWgmQilMNjQHT/EAyiEWFjWmWQR+84VGCs6rE
 l/ieSwrmpeq107Y2rvk1ptmKMkEG8FoaAvFc4NfzyBPgOq3s+9eMhwvCLvbGSqa3SRGx
 tZcfoWo8YSbcd5n1SmxNal3AuWXdG/6k4QBf2egPhnR2Kbma5Cka1QkqAWOioJ3XVLr3
 h9Z3ipXTSxfeFQj/w1fHwmaF9i6umg/oQVwz+51EgU1ug+hY2w2uhSQ7JiVT2MkihdNW
 1LTle3SHnlJntF7Ip5G0atPBnpfz8+kRaXSnvmTIXW5eN1646NIjXvAEI2HbhGfXVw6D
 uimw==
X-Gm-Message-State: AOJu0YyfAR+NxErlAOI1Jcw0V47eM5ip1QoRJuM/AzxUx4Rk9tlWDGWp
 UrI/NIlSzfqb1TkqshTjcpGJHnu0bwuHo1QNF26Wex48TEEGlTGsbDkKIFWVyUGqKqdQAofX7ga
 X+hhVm9yCpfBR9d1HtdeCF/piHaig8+n5gLq1hKty5SJ2AqTRQQW30XA6mcp6/zmOpq2M11AH8v
 h6V77Xw3x5xGAo0kEqTz4iNWFoQ/aU8W6yZols
X-Received: by 2002:a05:6512:23a5:b0:52c:c9e9:7dc1 with SMTP id
 2adb3069b0e04-52e82685af7mr4560246e87.32.1719845958302; 
 Mon, 01 Jul 2024 07:59:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrq4CQpqRSQh7VeAd2458ighSxU+mbTpCqs5YqpXlLzux0ViL0UX3tC1CM1gF0qK7GU+tlgA==
X-Received: by 2002:a05:6512:23a5:b0:52c:c9e9:7dc1 with SMTP id
 2adb3069b0e04-52e82685af7mr4560217e87.32.1719845957878; 
 Mon, 01 Jul 2024 07:59:17 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b064f16sm157833445e9.27.2024.07.01.07.59.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 07:59:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 07/14] rust: define wrappers for methods of the QOM Object
 class
Date: Mon,  1 Jul 2024 16:58:39 +0200
Message-ID: <20240701145853.1394967-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240701145853.1394967-1-pbonzini@redhat.com>
References: <20240701145853.1394967-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Provide a trait that can be used to invoke methods of the QOM object
class.  The trait extends Deref and has a blanket implementation for any
type that dereferences to IsA<Object>.  This way, it can be used on any
struct that dereferences to Object or a subclass.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qemu/src/lib.rs        |  2 +
 qemu/src/qom/object.rs | 92 ++++++++++++++++++++++++++++++++++++++++++
 qemu/src/qom/refs.rs   |  8 ++++
 3 files changed, 102 insertions(+)

diff --git a/qemu/src/lib.rs b/qemu/src/lib.rs
index 0d91623..a6e7b17 100644
--- a/qemu/src/lib.rs
+++ b/qemu/src/lib.rs
@@ -5,6 +5,8 @@ pub mod bindings;
 pub use bindings::Object;
 
 pub mod qom;
+pub use qom::object::ObjectClassMethods;
+pub use qom::object::ObjectMethods;
 pub use qom::object::ObjectType;
 pub use qom::refs::ObjectCast;
 pub use qom::refs::Owned;
diff --git a/qemu/src/qom/object.rs b/qemu/src/qom/object.rs
index bd6b957..4e84e29 100644
--- a/qemu/src/qom/object.rs
+++ b/qemu/src/qom/object.rs
@@ -2,12 +2,26 @@
 //!
 //! @author Paolo Bonzini
 
+use std::borrow::Cow;
 use std::ffi::CStr;
+use std::fmt;
+use std::ops::Deref;
 
+use crate::bindings::object_get_typename;
+use crate::bindings::object_property_add_child;
+use crate::bindings::object_new;
+use crate::bindings::object_unparent;
 use crate::bindings::Object;
 
 use crate::qom_isa;
 
+use crate::qom::refs::IsA;
+use crate::qom::refs::ObjectCast;
+use crate::qom::refs::Owned;
+
+use crate::util::foreign::CloneToForeign;
+use crate::util::foreign::FromForeign;
+
 /// Trait exposed by all structs corresponding to QOM objects.
 /// Defines "class methods" for the class.  Usually these can be
 /// implemented on the class itself; here, using a trait allows
@@ -31,4 +45,82 @@ unsafe impl ObjectType for Object {
     const TYPE: &'static CStr = c"object";
 }
 
+// ------------------------------
+// Object class
+
 qom_isa!(Object);
+
+/// Trait for class methods exposed by the Object class.  The methods can be
+/// called on all objects that have the trait `IsA<Object>`.
+///
+/// The trait should only be used through the blanket implementation,
+/// which guarantees safety via `IsA`
+
+pub trait ObjectClassMethods: IsA<Object> {
+    /// Return a new reference counted instance of this class
+    fn new() -> Owned<Self> {
+        // SAFETY: the object created by object_new is allocated on
+        // the heap and has a reference count of 1
+        unsafe {
+            let obj = &*object_new(Self::TYPE.as_ptr());
+            Owned::from_raw(obj.unsafe_cast::<Self>())
+        }
+    }
+}
+
+/// Trait for methods exposed by the Object class.  The methods can be
+/// called on all objects that have the trait `IsA<Object>`.
+///
+/// The trait should only be used through the blanket implementation,
+/// which guarantees safety via `IsA`
+pub trait ObjectMethods: Deref
+where
+    Self::Target: IsA<Object>,
+{
+    /// Return the name of the type of `self`
+    fn typename(&self) -> Cow<'_, str> {
+        let obj = self.upcast::<Object>();
+        // SAFETY: safety of this is the requirement for implementing IsA
+        // The result of the C API has static lifetime
+        unsafe {
+            Cow::cloned_from_foreign(object_get_typename(obj.as_mut_ptr()))
+        }
+    }
+
+    /// Add an object as a child of the receiver.
+    fn property_add_child<T: ObjectType>(&self, name: &str, child: Owned<T>)
+    {
+        let obj = self.upcast::<Object>();
+        let name = name.clone_to_foreign();
+        unsafe {
+            // SAFETY: casting to object is always safe even if `child`'s
+            // target type is an interface type
+            let child = child.unsafe_cast::<Object>();
+            object_property_add_child(obj.as_mut_ptr(),
+                                      name.as_ptr(),
+                                      child.as_mut_ptr());
+
+            // object_property_add_child() added a reference of its own;
+            // dropping the one in `child` is the common case.
+        }
+    }
+
+    /// Remove the object from the QOM tree
+    fn unparent(&self) {
+        let obj = self.upcast::<Object>();
+        // SAFETY: safety of this is the requirement for implementing IsA
+        unsafe {
+            object_unparent(obj.as_mut_ptr());
+        }
+    }
+
+    /// Convenience function for implementing the Debug trait
+    fn debug_fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
+        f.debug_tuple(&self.typename())
+            .field(&(self as *const Self))
+            .finish()
+    }
+}
+
+impl<R> ObjectClassMethods for R where R: IsA<Object> {}
+impl<R: Deref> ObjectMethods for R where R::Target: IsA<Object> {}
diff --git a/qemu/src/qom/refs.rs b/qemu/src/qom/refs.rs
index a319bde..431ef0a 100644
--- a/qemu/src/qom/refs.rs
+++ b/qemu/src/qom/refs.rs
@@ -6,9 +6,11 @@ use crate::bindings::object_dynamic_cast;
 use crate::bindings::Object;
 use crate::bindings::{object_ref, object_unref};
 
+use crate::qom::object::ObjectMethods;
 use crate::qom::object::ObjectType;
 
 use std::borrow::Borrow;
+use std::fmt::{self, Debug};
 use std::mem::ManuallyDrop;
 use std::ops::Deref;
 use std::ptr::NonNull;
@@ -272,3 +274,9 @@ impl<T: ObjectType> Drop for Owned<T> {
         }
     }
 }
+
+impl<T: IsA<Object>> Debug for Owned<T> {
+    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
+        self.deref().debug_fmt(f)
+    }
+}
-- 
2.45.2


