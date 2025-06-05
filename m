Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8373C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 10:17:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN7eX-0000BG-GH; Thu, 05 Jun 2025 06:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uN7dz-0007Rz-99
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 06:16:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uN7dx-0001LE-Lg
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 06:16:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749118575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZQCdWoOTSdYbeAQWQkf295VeDuJikO78V09umKPWQl8=;
 b=bAhEvfduFRknTgmijvifh4QoL4Fbqn2Sviksu/4d9zZXRTJjV18QHmrPBt6d8zoSjUqykE
 xCfSQcqCjOpZcHsKhJGD3FP4UgEKUQGGJeZxszt+HG8gFPiBZ6g3wH1aPkcGywgozfBJ9+
 7AZdEA0RQpeUF968oFuThpDTJ8lfI8Q=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-J4HsNwPCOwODP_5Rx9EltQ-1; Thu, 05 Jun 2025 06:16:10 -0400
X-MC-Unique: J4HsNwPCOwODP_5Rx9EltQ-1
X-Mimecast-MFC-AGG-ID: J4HsNwPCOwODP_5Rx9EltQ_1749118566
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a50049f8eeso508800f8f.3
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 03:16:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749118564; x=1749723364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZQCdWoOTSdYbeAQWQkf295VeDuJikO78V09umKPWQl8=;
 b=uTJioNbVmcIe+BdL1z3p1DXtnJKHFz6u281dVoLoR5DxF/cn7KQHP+JEojoRNu8FQ+
 yqf3splqFTwmKifIT+PdkGLzilXtsHNW/+fj91NvPoVY/KiPSpOgdwH6jyFu6ttECL0V
 JGQNXIF/LcZUk0YVKjBo34xoJOQzVbMpG6KXyo+fC4CMcnolFMDnGzW3b8Zw9KGLlPJ8
 5O57SNhHv5cMI4e1oG4lZejLXAStaVlVMYLnzMOb5B4B3wNOjH/+7setYh4W8BFSVtXa
 UvLTLHlQ1RXQrQWNvBuumGNSHIOmbtc6bgj7prk6jxSZzupafgyjp+Kg5KB0h+z7bdTQ
 Yuwg==
X-Gm-Message-State: AOJu0Yy6B5zm26Stpxox5QHizPpd6J2DIlvmlIIVugbu8bduAAmlu13o
 uaPoMzAL/5ob0N1i8OqiDpnrvOdfw3effHsTcFhIfoiHH9sK9UdiF/K50iJjnzWcGcnFeaGu71B
 vTlGSwSheTcuyHB4vUlz2v5/pH+dthzN46ox271GQLEWeyHEYlHJ4yai0JrJ8aH4mlQO0mPkGCq
 pc7Hlp9pKVv77R36mzR1sZ66FgOxFFqWVEkua46Rwb
X-Gm-Gg: ASbGncto9BR4TEgHO//mLNyWBOOIAqrxGmoh9Mu37409FhpS7GY4j0sokklK9qItxWM
 F6bO9Jr4Wyd9a3rNYFRSLnbHWSLwXvt+0tefh0RLD09HF6eYWXhqWT7BrttyseC6VnPYyQGA2iG
 Ci63X18yl42zLeKsesvPPgTXd8LuYyg9wCz6MKjm1kXvegwwMGQHNSEuDNMR1rT3xVOk75CYrSR
 6mxiz6utmgwOtBrkS9SDJU4MiH0gJoi8GySVwaFh8XrAIA3WJhjn3np/DjETI9ggi9YeNWHMVCF
 cxal+CgcUT7UBqOdoYr4Ol7B
X-Received: by 2002:a05:6000:18ab:b0:3a4:f41d:6973 with SMTP id
 ffacd0b85a97d-3a51d91b9d8mr5302335f8f.13.1749118563770; 
 Thu, 05 Jun 2025 03:16:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYyS7WrHOeCCeB0Qo+ibeY6lTTD3JU6vd6Kvi6h9sha9RCdOGUQEkIMrCdKb9ndf3nH1THzA==
X-Received: by 2002:a05:6000:18ab:b0:3a4:f41d:6973 with SMTP id
 ffacd0b85a97d-3a51d91b9d8mr5302308f8f.13.1749118563292; 
 Thu, 05 Jun 2025 03:16:03 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-451f98138c0sm19782395e9.9.2025.06.05.03.16.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 03:16:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com,
	zhao1.liu@intel.com,
	qemu-rust@nongnu.org
Subject: [PATCH 07/14] rust: qemu-api: add tests for Error bindings
Date: Thu,  5 Jun 2025 12:15:36 +0200
Message-ID: <20250605101544.368953-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605101544.368953-1-pbonzini@redhat.com>
References: <20250605101544.368953-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


