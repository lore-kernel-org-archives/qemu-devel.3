Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 495CFC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 15:01:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOIVS-0004Pk-DN; Mon, 01 Jul 2024 10:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOIVQ-0004M2-El
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 10:59:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOIVB-0005LJ-Nd
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 10:59:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719845973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ATkDSIn1AD4iloFEBRdTrGDcFCBr2wUtEchDeQI6v+Q=;
 b=ErwXH893U6f3EPXmS9wr5FVZu/nCulC2NsNmAfRooQGdf+CHeJANgk8x8UapRA2wZB3Fm+
 h8rJntb/nZajO+aeDBQe6n7Qo5tg8ZK8zSVjbgJxo2hC11SzeEPQ7fOTpGfnM2Cwiui5U3
 p2Z/NFx12AyCMceFJdnkxkH/bb3aJWE=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-SwrYpLGaMSm5psLRhGgHaw-1; Mon, 01 Jul 2024 10:59:31 -0400
X-MC-Unique: SwrYpLGaMSm5psLRhGgHaw-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-52d174e26baso4072166e87.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 07:59:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719845969; x=1720450769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ATkDSIn1AD4iloFEBRdTrGDcFCBr2wUtEchDeQI6v+Q=;
 b=rUgyIgwcb09Fn7SxTBECaatROdXsoS7+bipkU6dMcmoTDtUOiZB4tS+Rs2wMkfn1oU
 MVwwfvrLMtZ2nnPQHtQZ/tum/zy+Mhaxpp2iOEIWFEx7fY+4k4JIkI/1BVfa4pw2ahUi
 0/KGxU5ay/S3k84Vjirxucdfm1HDWQWBnA0acAkFVXJN1lW5dQD+xWAJ6Tj+GBfZNuQ3
 nA9f3HTajc3dasaOJbQXo4UFHCX55C3dAxo+gXSnOhNOq3CSqtJImeYbAO+wC/d1cPIr
 OGBjQtBOz+WwS9gHPS13CYjmcLQglZvR+plYadc6+29ZDoYb6agNsRidY/iXgJmwNYmQ
 tPYw==
X-Gm-Message-State: AOJu0YyA5mLWtZVHMb6M8szIz3QUlgaHQvj6PQZfNEh4aRluaKO4bae0
 b+H0mh6cNtmVXgecKf9+PfVo9ju+7+XZtoWrdXWRDtlnEeHk7ibIi6aamSIYsH1rFlIu/cT7K/8
 oKOQXHiAx+Hi0i5/UL3RppHN54jUdbewvWnosnRDEljqf+HSTWUI/ik+tumkI202Z6glCCSNngc
 rkcNBKEbrrhIqaUldR4oi9ZtpMRz+3niIJGBMv
X-Received: by 2002:a05:6512:2807:b0:52e:764b:b20d with SMTP id
 2adb3069b0e04-52e8266df15mr4109348e87.28.1719845969613; 
 Mon, 01 Jul 2024 07:59:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRUwwyRrlhMLiBz8bYjke97OF81aIw/lI/5KWh8bhZEqd1yOGGLzXZGVgy1sfMMY1nE4sg2A==
X-Received: by 2002:a05:6512:2807:b0:52e:764b:b20d with SMTP id
 2adb3069b0e04-52e8266df15mr4109332e87.28.1719845969238; 
 Mon, 01 Jul 2024 07:59:29 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af3cf9bsm159885515e9.8.2024.07.01.07.59.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 07:59:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 11/14] rust: replace std::ffi::c_char with libc::c_char
Date: Mon,  1 Jul 2024 16:58:43 +0200
Message-ID: <20240701145853.1394967-12-pbonzini@redhat.com>
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

Allow working with Rust versions prior to 1.64.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qemu/src/bindings/mod.rs | 3 ++-
 qemu/src/util/foreign.rs | 7 +++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/qemu/src/bindings/mod.rs b/qemu/src/bindings/mod.rs
index a49447b..0ad3828 100644
--- a/qemu/src/bindings/mod.rs
+++ b/qemu/src/bindings/mod.rs
@@ -1,4 +1,5 @@
-use std::ffi::{c_char, c_void};
+use libc::c_char;
+use std::ffi::c_void;
 
 #[repr(C)]
 pub struct Object {
diff --git a/qemu/src/util/foreign.rs b/qemu/src/util/foreign.rs
index 0b8b708..464400a 100644
--- a/qemu/src/util/foreign.rs
+++ b/qemu/src/util/foreign.rs
@@ -4,8 +4,11 @@
 /// Traits to map between C structs and native Rust types.
 /// Similar to glib-rs but a bit simpler and possibly more
 /// idiomatic.
+
+use libc::c_char;
+
 use std::borrow::Cow;
-use std::ffi::{c_char, c_void, CStr, CString};
+use std::ffi::{c_void, CStr, CString};
 use std::fmt;
 use std::fmt::Debug;
 use std::mem;
@@ -166,7 +169,7 @@ pub trait FromForeign: CloneToForeign + Sized {
     /// # use qemu::FromForeign;
     /// let p = c"Hello, world!".as_ptr();
     /// let s = unsafe {
-    ///     String::cloned_from_foreign(p as *const std::ffi::c_char)
+    ///     String::cloned_from_foreign(p as *const libc::c_char)
     /// };
     /// assert_eq!(s, "Hello, world!");
     /// ```
-- 
2.45.2


