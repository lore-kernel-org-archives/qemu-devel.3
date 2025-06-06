Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D05AEC61CE8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 12:42:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNWIA-0002Z3-52; Fri, 06 Jun 2025 08:35:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNWI6-0002Y2-5M
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 08:35:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNWI2-0005sY-PA
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 08:35:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749213316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZQCdWoOTSdYbeAQWQkf295VeDuJikO78V09umKPWQl8=;
 b=Y8WxYCRIjH4Izn588cAxoztMj4rJSUw0qzfebaE4NVqCbeufVBLy3oo/0MB91YuSs8r8l5
 t2aLgT5QEaziaxv6+WbQCWmYMrCMq0rceIttukLhfOqi11+eqlTZLvUYeIGOpG45ModEbD
 D343IWSMMD/9J2xAlVFb+Rvb05FY5Ss=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-qUzQKa3yPni5yTkqC1fsxQ-1; Fri, 06 Jun 2025 08:35:15 -0400
X-MC-Unique: qUzQKa3yPni5yTkqC1fsxQ-1
X-Mimecast-MFC-AGG-ID: qUzQKa3yPni5yTkqC1fsxQ_1749213314
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-450d021b9b1so9156695e9.0
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 05:35:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749213313; x=1749818113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZQCdWoOTSdYbeAQWQkf295VeDuJikO78V09umKPWQl8=;
 b=EImjC84CZnkCjXaoRR+upyrAW5s7DdVt8nJIS25+Fw9AVWSKR1W3mdgPzWlOavg31V
 wAgNP4rE/zhi2NgjMgC/Pfnv7SgBB+Wo6XZiN5rEQVR/l9xp5x/bePqDqnxpQVSxpXGM
 TT7WNO4r6VGvznnjyAvsFT97O09thPXm1FYE2gPOcGMEebKbzeeTUHwxkhQlvSNpImXV
 hdbA12+CMTg2sW0UX3ktBqiEd4ZUdF2VqdhO2HMcOeWVzreamGgGcQy23k92NwjSv+gy
 KLie4SI+qMwlJ9Li7/Gk6kMohS+Ss8Mm3mmf8jDOJ1t5OZoL/nSQe4xKg0iMxQV3oW98
 egcw==
X-Gm-Message-State: AOJu0Yw+dh1dMKFtQeNN+B5rjjtLIi3CK2BZXCgrdI1Dp7VFEFY9KFw8
 MPUI+J8wGZV4XR9Bv0YFrsJbsKk7fXjx8j34Eb5h1dpgvuuCgCd2Y6FykBefW7zJPIEBGazr9dg
 ZdMSRVSaW+dVXBpmduT5LRP5e3bY/6lpo37R2nVhTxNogSZ69Aj9ZTGpBOQOqIYneiF8pbYDSLo
 c1JutCYwZdmmgxHxweJE4qjlhvNT0o3Fon1xd1Ml9o
X-Gm-Gg: ASbGncvYJIUwb5z+23Tc4oQ6E4AnBmQ+HrodGIFrjPRAPMHw0ecBcMdHgxizFQ23ti0
 T3Olk4gu1y+oKC4HnWMGhlhW4j5Jt0ZHZfLbb9qhAj7FdE6IOHpD5KDt0v3+WvvD+faw4/udniE
 uomgeUIt2cMupsbKmVH4fSM21KtFKs6Sq2LK3uDnAWTr8YquVxmHycPVuLhR8901xry0lRGEVh9
 etGWbfbbMS1OE4TLodiM+KcneDlgNVNEOUHk3M5SxEJvoIPUe24I1Wv3NnqVtiFrmqcdWA2bpCT
 6R1/AfJuwxmZtlCiMMFMVQOs
X-Received: by 2002:a05:6000:2c10:b0:3a5:2653:7308 with SMTP id
 ffacd0b85a97d-3a531cf5becmr2545345f8f.57.1749213313506; 
 Fri, 06 Jun 2025 05:35:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxihx7EzRk8y+6awWnFEvj+M+Idu/wz1gReqCZSiNjQ5waOcN6bRdiWE6T3g2YjKahaYKwIg==
X-Received: by 2002:a05:6000:2c10:b0:3a5:2653:7308 with SMTP id
 ffacd0b85a97d-3a531cf5becmr2545316f8f.57.1749213312975; 
 Fri, 06 Jun 2025 05:35:12 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53229da18sm1810783f8f.19.2025.06.06.05.35.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 05:35:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/31] rust: qemu-api: add tests for Error bindings
Date: Fri,  6 Jun 2025 14:34:21 +0200
Message-ID: <20250606123447.538131-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606123447.538131-1-pbonzini@redhat.com>
References: <20250606123447.538131-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/error.rs | 104 +++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/rust/qemu-api/src/error.rs b/rust/qemu-api/src/error.rs
index 80157f6ea1b..e114fc4178b 100644
--- a/rust/qemu-api/src/error.rs
+++ b/rust/qemu-api/src/error.rs
@@ -310,3 +310,107 @@ unsafe fn cloned_from_foreign(c_error: *const bindings::Error) -> Self {
         }
     }
 }
+
+#[cfg(test)]
+mod tests {
+    use std::ffi::CStr;
+
+    use anyhow::anyhow;
+    use foreign::OwnedPointer;
+
+    use super::*;
+    use crate::{assert_match, bindings};
+
+    #[track_caller]
+    fn error_for_test(msg: &CStr) -> OwnedPointer<Error> {
+        // SAFETY: all arguments are controlled by this function
+        let location = panic::Location::caller();
+        unsafe {
+            let err: *mut c_void = libc::malloc(std::mem::size_of::<bindings::Error>());
+            let err: &mut bindings::Error = &mut *err.cast();
+            *err = bindings::Error {
+                msg: msg.clone_to_foreign_ptr(),
+                err_class: bindings::ERROR_CLASS_GENERIC_ERROR,
+                src_len: location.file().len() as c_int,
+                src: location.file().as_ptr().cast::<c_char>(),
+                line: location.line() as c_int,
+                func: ptr::null_mut(),
+                hint: ptr::null_mut(),
+            };
+            OwnedPointer::new(err)
+        }
+    }
+
+    unsafe fn error_get_pretty<'a>(local_err: *mut bindings::Error) -> &'a CStr {
+        unsafe { CStr::from_ptr(bindings::error_get_pretty(local_err)) }
+    }
+
+    #[test]
+    #[allow(deprecated)]
+    fn test_description() {
+        use std::error::Error;
+
+        assert_eq!(super::Error::from("msg").description(), "msg");
+        assert_eq!(super::Error::from("msg".to_owned()).description(), "msg");
+    }
+
+    #[test]
+    fn test_display() {
+        assert_eq!(&*format!("{}", Error::from("msg")), "msg");
+        assert_eq!(&*format!("{}", Error::from("msg".to_owned())), "msg");
+        assert_eq!(&*format!("{}", Error::from(anyhow!("msg"))), "msg");
+
+        assert_eq!(
+            &*format!("{}", Error::with_error("msg", anyhow!("cause"))),
+            "msg: cause"
+        );
+    }
+
+    #[test]
+    fn test_bool_or_propagate() {
+        unsafe {
+            let mut local_err: *mut bindings::Error = ptr::null_mut();
+
+            assert!(Error::bool_or_propagate(Ok(()), &mut local_err));
+            assert_eq!(local_err, ptr::null_mut());
+
+            let my_err = Error::from("msg");
+            assert!(!Error::bool_or_propagate(Err(my_err), &mut local_err));
+            assert_ne!(local_err, ptr::null_mut());
+            assert_eq!(error_get_pretty(local_err), c"msg");
+            bindings::error_free(local_err);
+        }
+    }
+
+    #[test]
+    fn test_ptr_or_propagate() {
+        unsafe {
+            let mut local_err: *mut bindings::Error = ptr::null_mut();
+
+            let ret = Error::ptr_or_propagate(Ok("abc".to_owned()), &mut local_err);
+            assert_eq!(String::from_foreign(ret), "abc");
+            assert_eq!(local_err, ptr::null_mut());
+
+            let my_err = Error::from("msg");
+            assert_eq!(
+                Error::ptr_or_propagate(Err::<String, _>(my_err), &mut local_err),
+                ptr::null_mut()
+            );
+            assert_ne!(local_err, ptr::null_mut());
+            assert_eq!(error_get_pretty(local_err), c"msg");
+            bindings::error_free(local_err);
+        }
+    }
+
+    #[test]
+    fn test_err_or_unit() {
+        unsafe {
+            let result = Error::err_or_unit(ptr::null_mut());
+            assert_match!(result, Ok(()));
+
+            let err = error_for_test(c"msg");
+            let err = Error::err_or_unit(err.into_inner()).unwrap_err();
+            assert_eq!(&*format!("{err}"), "msg");
+        }
+    }
+}
-- 
2.49.0


