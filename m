Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B360EC3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 15:34:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCKF0-0003m9-PP; Tue, 06 May 2025 11:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCKEy-0003lG-Qx
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:29:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCKEw-0001xV-9T
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:29:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746545388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4t5TpUC5RTcF8GxmJiKFUlWUgjAwch+v1tmCu4iXGng=;
 b=cPS1MlQeuCxKY3ZVzwbo/0Ie0s50HE5Y/Rxrc3ywTbvG1pIHkikw1blneptjJiehxbrA8E
 g2OBPsRuez0I7wPzyUgGt8yvVdPmBeqCcdu0GYYxSzkedgFN/lfJpXdcPSlHFd2Jts/3TG
 pkIgW4rVEPprRhFhW65rj8to83jJn0w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-KyWR5Q7bPTWjqFb-1Axwkg-1; Tue, 06 May 2025 11:29:47 -0400
X-MC-Unique: KyWR5Q7bPTWjqFb-1Axwkg-1
X-Mimecast-MFC-AGG-ID: KyWR5Q7bPTWjqFb-1Axwkg_1746545386
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-441c122fa56so13168105e9.2
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 08:29:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746545386; x=1747150186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4t5TpUC5RTcF8GxmJiKFUlWUgjAwch+v1tmCu4iXGng=;
 b=awqGn+Hb6YQ0GPHluM+i0m4HrPB6n//r/F5+gRF5MPPuhMdvLRxEwh+MvmnK9FRM/Z
 wwh40hE6YaHyl7/tZ1lZi5DQBQAS5CKMgAcXNFKmCBaTCahp2BlbBiq5e1+u4TozT914
 K/WnG7yJvHSR4ZY4i/SyGg/ZQ89t6EAeSY9t/jX+8MAuqb0eA2/9UinZAAR4czEKJuEf
 5TwUkPHne7m3tujm9nXA8QqVt4OmKHuvJlFrSs//XBXka+xufL7HcRP6waIRlDwbCMI1
 HGhfzOGS5pTvcltOVuJn2C8M/uuDVq4tD5qqRrMTlD5YaDCCVzOTFw1VTZ/iQPfmg/xs
 H2xA==
X-Gm-Message-State: AOJu0Yzu/exiDmV55bhh2t7HZuqW1lFVQ7VGBkVMHhwcD+Ys+9oZgxj6
 S92xRLxu0LDIDFINoJX8//4AmJCu4VFfFXU0pG/7YsSTCSA8HsDRULK6XhjW25w4nBLacwDuM0g
 zdzsc8Qep3+T1JBmrP5jBPUKEvzBxJdpJxg9EoRGsNCaxJiRmJctJsZy/fyn7NdZ72f8vXcwXBZ
 kmuKQlCKnjBlFWn4fy+GvXvfXmlk37K6yGhZHX
X-Gm-Gg: ASbGnctqvWUbmKyF0znzaMvVJLEjB+0ep0iaLqaCFEbyai3XizxM7z+62rvgfsdITo/
 4Tm7WDP9oVSNzHYnPXJKhR4+4gNvNshSLfLJ88LJQC0OoNRg+vOmDr6G5mqNNaLbOpPUGLn8n8r
 ohQs3x2yZ/zx3uEcPaYoTucA/3EecMkaWUlMx4MPYHh6DWYo78tOkdC+KI4ObeC4XbizsHzLpYU
 C587EjRSOOGRViwwgz2d6WMCOonQo8SNIBbwgchdWXVnd4qCX+EFE+Kfc1zonz5UJqjtug0VMuN
 1fLht5jIn0w0KLM=
X-Received: by 2002:a05:600c:681b:b0:43d:fa58:700e with SMTP id
 5b1f17b1804b1-441d101319amr32439045e9.33.1746545386144; 
 Tue, 06 May 2025 08:29:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbrxLJtbsdq71IHPioviS8KSZ2S+jW5jJiIvyQkIgeyuz903/ik5UEdLn4mmo+mqnGNt8jKQ==
X-Received: by 2002:a05:600c:681b:b0:43d:fa58:700e with SMTP id
 5b1f17b1804b1-441d101319amr32438835e9.33.1746545385807; 
 Tue, 06 May 2025 08:29:45 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae3528sm14316030f8f.30.2025.05.06.08.29.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 08:29:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 08/30] rust: enable clippy::ptr_cast_constness
Date: Tue,  6 May 2025 17:29:03 +0200
Message-ID: <20250506152927.222671-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506152927.222671-1-pbonzini@redhat.com>
References: <20250506152927.222671-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/rust.rst            | 2 --
 rust/Cargo.toml                | 2 +-
 rust/hw/timer/hpet/src/hpet.rs | 2 +-
 rust/qemu-api/src/cell.rs      | 2 +-
 rust/qemu-api/src/chardev.rs   | 2 +-
 rust/qemu-api/src/qom.rs       | 4 ++--
 rust/qemu-api/src/timer.rs     | 2 +-
 7 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index 13a002cfe69..a315f668865 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -74,8 +74,6 @@ Supported tools
 QEMU supports rustc version 1.63.0 and newer.  Notably, the following features
 are missing:
 
-* ``cast_mut()``/``cast_const()`` (1.65.0).  Use ``as`` instead.
-
 * Generic Associated Types (1.65.0)
 
 * ``CStr::from_bytes_with_nul()`` as a ``const`` function (1.72.0).
diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index eda7980b31a..a328634d949 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -71,6 +71,7 @@ no_effect_underscore_binding = "deny"
 option_option = "deny"
 or_fun_call = "deny"
 ptr_as_ptr = "deny"
+ptr_cast_constness = "deny"
 pub_underscore_fields = "deny"
 redundant_clone = "deny"
 redundant_closure_for_method_calls = "deny"
@@ -92,7 +93,6 @@ used_underscore_binding = "deny"
 
 # nice to have, but cannot be enabled yet
 #wildcard_imports = "deny"   # still have many bindings::* imports
-#ptr_cast_constness = "deny" # needs 1.65.0 for cast_mut()/cast_const()
 
 # these may have false positives
 #option_if_let_else = "deny"
diff --git a/rust/hw/timer/hpet/src/hpet.rs b/rust/hw/timer/hpet/src/hpet.rs
index d4364f2f2f7..b7a1be05deb 100644
--- a/rust/hw/timer/hpet/src/hpet.rs
+++ b/rust/hw/timer/hpet/src/hpet.rs
@@ -219,7 +219,7 @@ fn init(&mut self, index: u8, state: &HPETState) {
             // SAFETY: the HPETTimer will only be used after the timer
             // is initialized below.
             qemu_timer: unsafe { Timer::new() },
-            state: NonNull::new(state as *const _ as *mut _).unwrap(),
+            state: NonNull::new((state as *const HPETState).cast_mut()).unwrap(),
             config: 0,
             cmp: 0,
             fsb: 0,
diff --git a/rust/qemu-api/src/cell.rs b/rust/qemu-api/src/cell.rs
index ab0785a2692..1cb9fdcd53f 100644
--- a/rust/qemu-api/src/cell.rs
+++ b/rust/qemu-api/src/cell.rs
@@ -1016,7 +1016,7 @@ pub const fn as_mut_ptr(&self) -> *mut T {
 
     /// Returns a raw pointer to the opaque data.
     pub const fn as_ptr(&self) -> *const T {
-        self.as_mut_ptr() as *const _
+        self.as_mut_ptr().cast_const()
     }
 
     /// Returns a raw pointer to the opaque data that can be passed to a
diff --git a/rust/qemu-api/src/chardev.rs b/rust/qemu-api/src/chardev.rs
index 146a4852da3..6e0590d758e 100644
--- a/rust/qemu-api/src/chardev.rs
+++ b/rust/qemu-api/src/chardev.rs
@@ -160,7 +160,7 @@ pub fn enable_handlers<
                 receive_cb,
                 event_cb,
                 None,
-                (owner as *const T as *mut T).cast::<c_void>(),
+                (owner as *const T).cast_mut().cast::<c_void>(),
                 core::ptr::null_mut(),
                 true,
             );
diff --git a/rust/qemu-api/src/qom.rs b/rust/qemu-api/src/qom.rs
index 52e3a1ec981..41e5a5e29a8 100644
--- a/rust/qemu-api/src/qom.rs
+++ b/rust/qemu-api/src/qom.rs
@@ -388,7 +388,7 @@ fn as_mut_ptr<U: ObjectType>(&self) -> *mut U
     {
         #[allow(clippy::as_ptr_cast_mut)]
         {
-            self.as_ptr::<U>() as *mut _
+            self.as_ptr::<U>().cast_mut()
         }
     }
 }
@@ -638,7 +638,7 @@ pub unsafe fn from_raw(ptr: *const T) -> Self {
         // SAFETY NOTE: while NonNull requires a mutable pointer, only
         // Deref is implemented so the pointer passed to from_raw
         // remains const
-        Owned(NonNull::new(ptr as *mut T).unwrap())
+        Owned(NonNull::new(ptr.cast_mut()).unwrap())
     }
 
     /// Obtain a raw C pointer from a reference.  `src` is consumed
diff --git a/rust/qemu-api/src/timer.rs b/rust/qemu-api/src/timer.rs
index d697fd742bc..868bd88575f 100644
--- a/rust/qemu-api/src/timer.rs
+++ b/rust/qemu-api/src/timer.rs
@@ -81,7 +81,7 @@ pub fn init_full<'timer, 'opaque: 'timer, T, F>(
                 scale as c_int,
                 attributes as c_int,
                 Some(timer_cb),
-                (opaque as *const T).cast::<c_void>() as *mut c_void,
+                (opaque as *const T).cast::<c_void>().cast_mut(),
             )
         }
     }
-- 
2.49.0


