Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76ABAC7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 16:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSeo5-0006Zq-Bq; Fri, 20 Jun 2025 12:41:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uSeo2-0006Yu-5W
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 12:41:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uSenz-0000Gq-UU
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 12:41:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750437691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZbRxtT0IMJemouiEORMDGr9tGSaeLkY1c3ABjRf1eR8=;
 b=JP8UPdnXVuIB1I2RDw1Oi73mlJQNBDdRAtf4Uul2s7y/tn4Meo5Cy3Gfb0C5iyijkC6zLl
 RA1d8zsMRRiO3av5ZOO08nwdqKjoPX5tyJVg/9xqLmpNJaVBbM7XjxBgKi9aglraAg2wPC
 WQ23u4jX0wq03edIWFqR9V3oGak6FzQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-v8-5ykeGP86BXIDR9iRdcA-1; Fri, 20 Jun 2025 12:41:16 -0400
X-MC-Unique: v8-5ykeGP86BXIDR9iRdcA-1
X-Mimecast-MFC-AGG-ID: v8-5ykeGP86BXIDR9iRdcA_1750437675
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-adb5f5f43dfso163930866b.3
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 09:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750437674; x=1751042474;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZbRxtT0IMJemouiEORMDGr9tGSaeLkY1c3ABjRf1eR8=;
 b=o/pl0HHobNo+QbE2JIfeYXiHQJRNcGT0WVJR3d83+bA4pg3zUsiKaPfCFRcHyhN5o1
 Njoubpc2uR9Djq1J9dBGUHngRmnTvOAbcL7FdrrDnf8m9QqIHKLKI8Jp9gEqQ3VB9InP
 zeK3SJKTEQlnwBflp20swDjAz8R5EZZH0qZfY7WcxFq7HxYbk6cmeK1oUVdf/1xcNviW
 d1acTlOTh5v9C0awFWVTPiig7SxBeblVhcUgdYwlYSZ/avDRUPml508nMmp8MgLRJHx7
 653kYccu+c3S0lSz5JYdC98Z8RlFJpxQCOzfX/UbWUtjIt+imi30BRChtUvxqC1WHnwX
 LByg==
X-Gm-Message-State: AOJu0YxvDiVDJsB7YwlnN5xDDu9Xdbl1feOOf3jybf+pkD0c6jiilVAG
 xroewK14tR+9XSvJj5YnymlySO2NohLGqrdH2vAITBUU6De4YPf5R29a0QFfQji1MgEttJLXjUK
 m77Ho42qU2wXsnSZnn6yAeMT/lqL2EZSHiOKvuD3sdfuBSkOLRlgcy/aXke+2wriMkVdVwSV9hd
 XobWFIvFXx1A1PTJx5DnnsRpAHB1oL1n4U1hxiAHyD
X-Gm-Gg: ASbGncvySDOnoaYHAePvN3YfJK3n5ywYRItonS82iqFEqRoFTGnxLtIg/MhA4PsYleE
 +x5k+5vTgIWtLgzUQ/Uy4+WIHYieh8iY46yAY7o70xqMRENxAdiYgl2FygNc6uUa96Hy7LALuYo
 hYAU7ilpw80kTEeKs0R/wJq6lxollkSaSqIgfs9Y6EZMkCmkRdVP1/wm7nPROuW9UFmIul6/oVV
 CtENLedXHIPTUc5mF3NfxMzojZrF0shZ3snOGQA1MtwNbdjfFu3exWPize/IqIDWY58ioGdWhFB
 1hZ6ZMYGzYCQ+1QlkMmNAq347w==
X-Received: by 2002:a17:907:9715:b0:ad8:9b5d:2c38 with SMTP id
 a640c23a62f3a-ae057d4d2a3mr350810166b.26.1750437674302; 
 Fri, 20 Jun 2025 09:41:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjeaEMwqFfV9E8dSGQzWMqgp1qiygxRbnsjANyqiuxT+7P/gN4UDB8YsHXsV67tXWKOMAZGQ==
X-Received: by 2002:a17:907:9715:b0:ad8:9b5d:2c38 with SMTP id
 a640c23a62f3a-ae057d4d2a3mr350807566b.26.1750437673789; 
 Fri, 20 Jun 2025 09:41:13 -0700 (PDT)
Received: from [192.168.122.1] ([151.62.200.93])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae054209a2dsm190213166b.174.2025.06.20.09.41.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 09:41:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 07/24] rust: qom: introduce ParentInit
Date: Fri, 20 Jun 2025 18:40:35 +0200
Message-ID: <20250620164053.579416-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620164053.579416-1-pbonzini@redhat.com>
References: <20250620164053.579416-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This is a smart pointer for MaybeUninit; it can be upcasted to the
already-initialized parent classes, or dereferenced to a MaybeUninit
for the class that is being initialized.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/qom.rs | 96 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 95 insertions(+), 1 deletion(-)

diff --git a/rust/qemu-api/src/qom.rs b/rust/qemu-api/src/qom.rs
index 14f98fee60a..ef966e570ca 100644
--- a/rust/qemu-api/src/qom.rs
+++ b/rust/qemu-api/src/qom.rs
@@ -95,7 +95,7 @@
 use std::{
     ffi::{c_void, CStr},
     fmt,
-    mem::ManuallyDrop,
+    mem::{ManuallyDrop, MaybeUninit},
     ops::{Deref, DerefMut},
     ptr::NonNull,
 };
@@ -206,6 +206,100 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> Result<(), fmt::Error> {
     }
 }
 
+/// This struct knows that the superclasses of the object have already been
+/// initialized.
+pub struct ParentInit<'a, T>(&'a mut MaybeUninit<T>);
+
+impl<'a, T> ParentInit<'a, T> {
+    #[inline]
+    pub fn with(obj: &'a mut MaybeUninit<T>, f: impl FnOnce(ParentInit<'a, T>)) {
+        let parent_init = ParentInit(obj);
+        f(parent_init)
+    }
+}
+
+impl<T: ObjectType> ParentInit<'_, T> {
+    /// Return the receiver as a mutable raw pointer to Object.
+    ///
+    /// # Safety
+    ///
+    /// Fields beyond `Object` could be uninitialized and it's your
+    /// responsibility to avoid that they're used when the pointer is
+    /// dereferenced, either directly or through a cast.
+    pub fn as_object_mut_ptr(&self) -> *mut bindings::Object {
+        self.as_object_ptr().cast_mut()
+    }
+
+    /// Return the receiver as a mutable raw pointer to Object.
+    ///
+    /// # Safety
+    ///
+    /// Fields beyond `Object` could be uninitialized and it's your
+    /// responsibility to avoid that they're used when the pointer is
+    /// dereferenced, either directly or through a cast.
+    pub fn as_object_ptr(&self) -> *const bindings::Object {
+        self.0.as_ptr().cast()
+    }
+}
+
+impl<'a, T: ObjectImpl> ParentInit<'a, T> {
+    /// Convert from a derived type to one of its parent types, which
+    /// have already been initialized.
+    ///
+    /// # Safety
+    ///
+    /// Structurally this is always a safe operation; the [`IsA`] trait
+    /// provides static verification trait that `Self` dereferences to `U` or
+    /// a child of `U`, and only parent types of `T` are allowed.
+    ///
+    /// However, while the fields of the resulting reference are initialized,
+    /// calls might use uninitialized fields of the subclass.  It is your
+    /// responsibility to avoid this.
+    pub unsafe fn upcast<U: ObjectType>(&self) -> &'a U
+    where
+        T::ParentType: IsA<U>,
+    {
+        // SAFETY: soundness is declared via IsA<U>, which is an unsafe trait;
+        // the parent has been initialized before `instance_init `is called
+        unsafe { &*(self.0.as_ptr().cast::<U>()) }
+    }
+
+    /// Convert from a derived type to one of its parent types, which
+    /// have already been initialized.
+    ///
+    /// # Safety
+    ///
+    /// Structurally this is always a safe operation; the [`IsA`] trait
+    /// provides static verification trait that `Self` dereferences to `U` or
+    /// a child of `U`, and only parent types of `T` are allowed.
+    ///
+    /// However, while the fields of the resulting reference are initialized,
+    /// calls might use uninitialized fields of the subclass.  It is your
+    /// responsibility to avoid this.
+    pub unsafe fn upcast_mut<U: ObjectType>(&mut self) -> &'a mut U
+    where
+        T::ParentType: IsA<U>,
+    {
+        // SAFETY: soundness is declared via IsA<U>, which is an unsafe trait;
+        // the parent has been initialized before `instance_init `is called
+        unsafe { &mut *(self.0.as_mut_ptr().cast::<U>()) }
+    }
+}
+
+impl<T> Deref for ParentInit<'_, T> {
+    type Target = MaybeUninit<T>;
+
+    fn deref(&self) -> &Self::Target {
+        self.0
+    }
+}
+
+impl<T> DerefMut for ParentInit<'_, T> {
+    fn deref_mut(&mut self) -> &mut Self::Target {
+        self.0
+    }
+}
+
 unsafe extern "C" fn rust_instance_init<T: ObjectImpl>(obj: *mut bindings::Object) {
     let mut state = NonNull::new(obj).unwrap().cast::<T>();
     // SAFETY: obj is an instance of T, since rust_instance_init<T>
-- 
2.49.0


