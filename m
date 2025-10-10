Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5935CCCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 15:12:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7Ela-0008Qf-1s; Fri, 10 Oct 2025 11:10:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v7ElY-0008Pf-UW
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 11:10:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v7ElG-00043o-PI
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 11:10:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760109020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1p2DJoRVBR8tV1MAyYgxZfuil60xzN5SPRhSiWSYteE=;
 b=EDDBiNVyt0Z5dLmKlnh6yFEqZsrmXgg2BsnmdjqN2j9GdQuh9+WAdoZ2mmYnLzJJUFxxoJ
 x/vq9yBzKrljSUhe0zdein5YrQXOA3heHFYzHYUePxSIO82y5ilEnmPGfK+vfu+QM41Vl9
 O/hcGIVX5sZJxLcGPqhZqGiiuphkdII=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-IJoMKxw4OOiOK_AV9Kux5g-1; Fri, 10 Oct 2025 11:10:15 -0400
X-MC-Unique: IJoMKxw4OOiOK_AV9Kux5g-1
X-Mimecast-MFC-AGG-ID: IJoMKxw4OOiOK_AV9Kux5g_1760109014
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b48635cf06fso365942866b.1
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 08:10:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760109013; x=1760713813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1p2DJoRVBR8tV1MAyYgxZfuil60xzN5SPRhSiWSYteE=;
 b=eTSmr4jWLes59L7ODlb+3nCemJvt1NKWwhjnayqPV/wxipkOf1pzMW2vsPRq3NHfzY
 Cnc3efEfG78b1oVZE6e5DGzvyNavmEmfXAwv9uGQCMBnr2yEOvWJU+oSjVCTlbK2AZC4
 2df/rOymw8FqbuA3QuQfgZTdzbp4qZ2xl5Eo86RXPXKAG5q7a9LjiXcybuWdPJ88ghNt
 LZhM9siIDdZQWM+/sRRY7z778Tkv0ZKnR+UILKvcpbWfZ7Gyh7mwIFLNvf37Xe/JdkU2
 aHbXXqwYUkR04sScPcwzFgy/ifgYlpQqrfcUVRriBZ1Yh7YU1gh0S3FuKlovv2giG8ij
 V5Yg==
X-Gm-Message-State: AOJu0Yzm6bGmX2jZXCO5IIsvMAEyP36aeNlBuAaBK1pIrbIFQG7+hmQN
 rxonJ+WCtzd3OjssFAIsxpdSX3XdellQTl9N2Pv0uhdgW3UpBqtRtju+Y/yR34rDST2YYSFYe6w
 4/jBKFUpdhGnJK3VEdCxQXTFRQi/Ii2X6eSMVN0Ag+CKvdcgqwr6ijDaANRjO8ACqa+Z0eVTjFE
 zJosz58fm/n2A/kPh9ZqaPuBrL0C6EbYGhOaPAbsxk
X-Gm-Gg: ASbGnctBfsCyASH7PC6s/saZ01qkbpBvEc4ljGzbS4UfAanW29EOF/Lm9/vGKVTjos7
 M9u2MpKbnUbPkBm6cCZhI4qEa5Be7X53Pwzp8vG66abKnsBs3lzIGFTixC28LfhT+2pKsjBNktA
 7f5ncV0NOPzV4ft0pJknkPV4Z0i8kY4CcEOeiqFitIUjuS4N3/yV62wlRNNFFqtXjh33bZbQZuN
 237IduS5tNDaanKB+vwkAbuZ+b23g9dvhanL2pKe96z3QCMT2y9exx5aXSqrYz+w5Ww1PVEAVwg
 /dIjek3ogyU15U5ZIOYYbeEymLK8+NMWDf9tAoyC2tUrkPEr7m/J80kkdj5Cc9LD9S6hqh56BQl
 SaG0/sIrs6GfUgcJXMSc0ZVNr08SjQKBQNR6P8MR8UonW
X-Received: by 2002:a17:907:809:b0:b45:b078:c534 with SMTP id
 a640c23a62f3a-b50ac5cf768mr1355354666b.45.1760109013394; 
 Fri, 10 Oct 2025 08:10:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEqY/Lmavybv5EXJzRc4lxTfQq/vdsK6Ltvb6SFc3/2PjVQdDkvjwgnechuXAJwrkP2t8DpA==
X-Received: by 2002:a17:907:809:b0:b45:b078:c534 with SMTP id
 a640c23a62f3a-b50ac5cf768mr1355349166b.45.1760109012636; 
 Fri, 10 Oct 2025 08:10:12 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.231.162])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b55d952a273sm266264866b.83.2025.10.10.08.10.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 08:10:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com,
	marcandre.lureau@redhat.com,
	qemu-rust@nongnu.org
Subject: [PATCH 02/19] rust/util: use anyhow's native chaining capabilities
Date: Fri, 10 Oct 2025 17:09:47 +0200
Message-ID: <20251010151006.791038-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010151006.791038-1-pbonzini@redhat.com>
References: <20251010151006.791038-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

This simplifies conversions, making it possible to convert any error
into a QEMU util::Error with ".into()" (and therefore with "?").

The cost is having a separate constructor for when the error is a simple
string, but that is made easier by the ensure! macro.  If necessary,
another macro similar to "anyhow!" can be returned, but for now there
is no need for that.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/util/src/error.rs | 139 ++++++++++++++---------------------------
 1 file changed, 46 insertions(+), 93 deletions(-)

diff --git a/rust/util/src/error.rs b/rust/util/src/error.rs
index 20b8e7d5af5..bdbf2634170 100644
--- a/rust/util/src/error.rs
+++ b/rust/util/src/error.rs
@@ -38,6 +38,7 @@
     borrow::Cow,
     ffi::{c_char, c_int, c_void, CStr},
     fmt::{self, Display},
+    ops::Deref,
     panic, ptr,
 };
 
@@ -49,104 +50,65 @@
 
 #[derive(Debug)]
 pub struct Error {
-    msg: Option<Cow<'static, str>>,
-    /// Appends the print string of the error to the msg if not None
-    cause: Option<anyhow::Error>,
+    cause: anyhow::Error,
     file: &'static str,
     line: u32,
 }
 
-impl std::error::Error for Error {
-    fn source(&self) -> Option<&(dyn std::error::Error + 'static)> {
-        self.cause.as_ref().map(AsRef::as_ref)
-    }
+impl Deref for Error {
+    type Target = anyhow::Error;
 
-    #[allow(deprecated)]
-    fn description(&self) -> &str {
-        self.msg
-            .as_deref()
-            .or_else(|| self.cause.as_deref().map(std::error::Error::description))
-            .expect("no message nor cause?")
+    fn deref(&self) -> &Self::Target {
+        &self.cause
     }
 }
 
 impl Display for Error {
     fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
-        let mut prefix = "";
-        if let Some(ref msg) = self.msg {
-            write!(f, "{msg}")?;
-            prefix = ": ";
-        }
-        if let Some(ref cause) = self.cause {
-            write!(f, "{prefix}{cause}")?;
-        } else if prefix.is_empty() {
-            panic!("no message nor cause?");
-        }
-        Ok(())
+        Display::fmt(&format_args!("{:#}", self.cause), f)
     }
 }
 
-impl From<Cow<'static, str>> for Error {
+impl<E> From<E> for Error where anyhow::Error: From<E> {
     #[track_caller]
-    fn from(msg: Cow<'static, str>) -> Self {
-        let location = panic::Location::caller();
-        Error {
-            msg: Some(msg),
-            cause: None,
-            file: location.file(),
-            line: location.line(),
-        }
-    }
-}
-
-impl From<String> for Error {
-    #[track_caller]
-    fn from(msg: String) -> Self {
-        let location = panic::Location::caller();
-        Error {
-            msg: Some(Cow::Owned(msg)),
-            cause: None,
-            file: location.file(),
-            line: location.line(),
-        }
-    }
-}
-
-impl From<&'static str> for Error {
-    #[track_caller]
-    fn from(msg: &'static str) -> Self {
-        let location = panic::Location::caller();
-        Error {
-            msg: Some(Cow::Borrowed(msg)),
-            cause: None,
-            file: location.file(),
-            line: location.line(),
-        }
-    }
-}
-
-impl From<anyhow::Error> for Error {
-    #[track_caller]
-    fn from(error: anyhow::Error) -> Self {
-        let location = panic::Location::caller();
-        Error {
-            msg: None,
-            cause: Some(error),
-            file: location.file(),
-            line: location.line(),
-        }
+    fn from(src: E) -> Self {
+        Self::new(anyhow::Error::from(src))
     }
 }
 
 impl Error {
+    /// Create a new error from an [`anyhow::Error`].
+    ///
+    /// This wraps the error with QEMU's location tracking information.
+    /// Most code should use the `?` operator instead of calling this directly.
+    #[track_caller]
+    pub fn new(cause: anyhow::Error) -> Self {
+        let location = panic::Location::caller();
+        Error {
+            cause,
+            file: location.file(),
+            line: location.line(),
+        }
+    }
+
+    /// Create a new error from a string message.
+    ///
+    /// This is a convenience wrapper around [`Error::new`] for simple string errors.
+    /// Most code should use the [`ensure!`](crate::ensure) macro instead of calling
+    /// this directly.
+    #[track_caller]
+    pub fn msg(src: impl Into<Cow<'static, str>>) -> Self {
+        Self::new(anyhow::Error::msg(src.into()))
+    }
+
     #[track_caller]
     #[doc(hidden)]
     pub fn format(args: fmt::Arguments) -> Self {
         if let Some(msg) = args.as_str() {
-            Self::from(msg)
+            Self::new(anyhow::Error::msg(msg))
         } else {
             let msg = std::fmt::format(args);
-            Self::from(msg)
+            Self::new(anyhow::Error::msg(msg))
         }
     }
 
@@ -155,9 +117,10 @@ pub fn format(args: fmt::Arguments) -> Self {
     #[track_caller]
     pub fn with_error(msg: impl Into<Cow<'static, str>>, cause: impl Into<anyhow::Error>) -> Self {
         let location = panic::Location::caller();
+        let msg: Cow<'static, str> = msg.into();
+        let cause: anyhow::Error = cause.into();
         Error {
-            msg: Some(msg.into()),
-            cause: Some(cause.into()),
+            cause: cause.context(msg),
             file: location.file(),
             line: location.line(),
         }
@@ -326,8 +289,7 @@ unsafe fn cloned_from_foreign(c_error: *const bindings::Error) -> Self {
             };
 
             Error {
-                msg: FromForeign::cloned_from_foreign(error.msg),
-                cause: None,
+                cause: anyhow::Error::msg(String::cloned_from_foreign(error.msg)),
                 file: file.unwrap(),
                 line: error.line as u32,
             }
@@ -370,8 +332,8 @@ macro_rules! ensure {
     };
     ($cond:expr, $err:expr $(,)?) => {
         if !$cond {
-            let s = ::std::borrow::Cow::<'static, str>::from($err);
-            return $crate::Result::Err(s.into());
+            let e = $crate::Error::msg($err);
+            return $crate::Result::Err(e);
         }
     };
 }
@@ -410,19 +372,10 @@ unsafe fn error_get_pretty<'a>(local_err: *mut bindings::Error) -> &'a CStr {
         unsafe { CStr::from_ptr(bindings::error_get_pretty(local_err)) }
     }
 
-    #[test]
-    #[allow(deprecated)]
-    fn test_description() {
-        use std::error::Error;
-
-        assert_eq!(super::Error::from("msg").description(), "msg");
-        assert_eq!(super::Error::from("msg".to_owned()).description(), "msg");
-    }
-
     #[test]
     fn test_display() {
-        assert_eq!(&*format!("{}", Error::from("msg")), "msg");
-        assert_eq!(&*format!("{}", Error::from("msg".to_owned())), "msg");
+        assert_eq!(&*format!("{}", Error::msg("msg")), "msg");
+        assert_eq!(&*format!("{}", Error::msg("msg".to_owned())), "msg");
         assert_eq!(&*format!("{}", Error::from(anyhow!("msg"))), "msg");
 
         assert_eq!(
@@ -439,7 +392,7 @@ fn test_bool_or_propagate() {
             assert!(Error::bool_or_propagate(Ok(()), &mut local_err));
             assert_eq!(local_err, ptr::null_mut());
 
-            let my_err = Error::from("msg");
+            let my_err = Error::msg("msg");
             assert!(!Error::bool_or_propagate(Err(my_err), &mut local_err));
             assert_ne!(local_err, ptr::null_mut());
             assert_eq!(error_get_pretty(local_err), c"msg");
@@ -456,7 +409,7 @@ fn test_ptr_or_propagate() {
             assert_eq!(String::from_foreign(ret), "abc");
             assert_eq!(local_err, ptr::null_mut());
 
-            let my_err = Error::from("msg");
+            let my_err = Error::msg("msg");
             assert_eq!(
                 Error::ptr_or_propagate(Err::<String, _>(my_err), &mut local_err),
                 ptr::null_mut()
-- 
2.51.0


