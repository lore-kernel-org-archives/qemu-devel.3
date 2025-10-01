Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D00CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 07:53:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3rdk-0006ZT-4G; Wed, 01 Oct 2025 03:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3rdg-0006XK-Rh
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:52:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3rdW-00034m-Mq
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:52:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759305141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=37A/E7m9u63AqLOql9m/xlGjyAGVMHNrlDO+98nVRkU=;
 b=F0LnyVvYmkYWU79Ofu447gyeIM9MivogxQIVhyK5dYvGKOIvOmmHTzUr+h1E32zNP0eljZ
 9SJy9FpZ7seiGrGuJsq4doXPUa8ENvXV129qN5YFf0p6GsLuReXNwEiiYRXx1immGd73/q
 ipC50Ofut6WMRMv1uw0srNzMprxnEvk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-pEtqZIT_PA-xNsjGhnn85A-1; Wed, 01 Oct 2025 03:52:20 -0400
X-MC-Unique: pEtqZIT_PA-xNsjGhnn85A-1
X-Mimecast-MFC-AGG-ID: pEtqZIT_PA-xNsjGhnn85A_1759305139
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-b3f2cfc26edso86388766b.2
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 00:52:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759305138; x=1759909938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=37A/E7m9u63AqLOql9m/xlGjyAGVMHNrlDO+98nVRkU=;
 b=mawHehE7pXQPmD1/1ckEm1uBWMhE9/mICnF770sVEbgYHriymuj04YlaWTDTAhSK0P
 5/2AOZP//0SspKgM+vQ6btZev7NXxAz+ChpzpiS49Kg7GueDu71OfCZ00WEcKVsuBqB1
 96sRwyKQbkZAQhKQuAukQmNGIcw0O3eEnKOI9X+xkgplIJvgTNjpyjvNss5Y4NQtixMR
 jY39IpLndPwD+eGYO66sMjA+I4QHbdLgn+dkOKvJ+if+UdsZrTUJ/Gzdy47CkK7DNeoS
 WZ/K+wXvy3hyMYwKZlazsFRjKRMAxMXX6d4V8yKHQcdggTH1PM3rUNH4tS9S9rYvtZmC
 chsw==
X-Gm-Message-State: AOJu0YzyJKYD6vIVSzQ16JbvFaAczcarWCXpHFNiM5tr5ZYnUOoN11HF
 hHfEBeWLJc+hzmOkrsWKC2K+g3p+Xz6Dv8o42U5NkYRFmyaAnru0XQUzvLEo8BqowAY+9rzi0vo
 REhd8kxdrdLRchNaJmnPMWcgds2G5/VGZgsEfBn4HYUkgZolMloGzwsm8elObGx5H+NbALB2KbT
 g9PiRpwGNhWHCRTb+ynOsWd1eplDaSDcQjDTkbcO4c
X-Gm-Gg: ASbGncuGEmCpqV0j4YmHwAYJM7c9CR//ELAk7Ong4CyOE8OfynSRGE1RHbhWRXHcNrx
 9AvsG5PdtS1K3iMnrsevYI9wvWifbZ4qjiXJtfFdZiG4AOV+V0KIoDqgETPhuop0OjI4MjvIB/x
 CBcEBc/3RLbGyudcilY3BmXA57HkMuWVviRw+cQ1GoE7rLwdN1lkHmxPFqgEd88LP+8IT8VBQRt
 yXnh8HwMSzjH+V4bFTNl+9DwW+fjbD7vm++m/vAfMUEbghnCl/9Bvv7iM49MlfPBxRZaYzl0GiN
 Q/IeQ1t2It9mBCOzgcnsUH7cjLjfWTOzDdGv791BeWTnL3mTpnsAKLlsEzDLQZ/ea7CpZrIiOls
 TSqb6fpuBvC1pyGr5NN7JY5b/KwkRHMILQDqMYYe0Daxi2JuKbAI=
X-Received: by 2002:a17:907:2da5:b0:b45:a6e6:97ac with SMTP id
 a640c23a62f3a-b46ea415682mr271063266b.64.1759305138436; 
 Wed, 01 Oct 2025 00:52:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNDgnkWdeHaODzXwg+jEfB7UYR+gQyo406AWeujsWWxZE4nSLrtqVfs7Nmw+8klnONiThQew==
X-Received: by 2002:a17:907:2da5:b0:b45:a6e6:97ac with SMTP id
 a640c23a62f3a-b46ea415682mr271060966b.64.1759305138024; 
 Wed, 01 Oct 2025 00:52:18 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b3b9d55a5bcsm818595466b.70.2025.10.01.00.52.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 00:52:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 03/11] rust: migration: do not store raw pointers into
 VMStateSubsectionsWrapper
Date: Wed,  1 Oct 2025 09:52:02 +0200
Message-ID: <20251001075210.1042479-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001075005.1041833-1-pbonzini@redhat.com>
References: <20251001075005.1041833-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Raw pointers were used to insert a NULL one at the end of the array.
However, Option<&...> has the same layout and does not remove Sync
from the type of the array.

As an extra benefit, this enables validation of the terminator of the
subsection array, because is_null() in const context would not be stable
until Rust 1.84.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/migration/src/vmstate.rs | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/rust/migration/src/vmstate.rs b/rust/migration/src/vmstate.rs
index 319d353c311..6a89769984f 100644
--- a/rust/migration/src/vmstate.rs
+++ b/rust/migration/src/vmstate.rs
@@ -469,33 +469,21 @@ unsafe impl $crate::vmstate::VMState for $type {
     };
 }
 
-/// A transparent wrapper type for the `subsections` field of
-/// [`VMStateDescription`].
-///
-/// This is necessary to be able to declare subsection descriptions as statics,
-/// because the only way to implement `Sync` for a foreign type (and `*const`
-/// pointers are foreign types in Rust) is to create a wrapper struct and
-/// `unsafe impl Sync` for it.
-///
-/// This struct is used in the
-/// [`vm_state_subsections`](crate::vmstate_subsections) macro implementation.
-#[repr(transparent)]
-pub struct VMStateSubsectionsWrapper(pub &'static [*const crate::bindings::VMStateDescription]);
-
-unsafe impl Sync for VMStateSubsectionsWrapper {}
+/// The type returned by [`vmstate_subsections!`].
+pub type VMStateSubsections = &'static [Option<&'static crate::bindings::VMStateDescription>];
 
 /// Helper macro to declare a list of subsections ([`VMStateDescription`])
 /// into a static and return a pointer to the array of pointers it created.
 #[macro_export]
 macro_rules! vmstate_subsections {
     ($($subsection:expr),*$(,)*) => {{
-        static _SUBSECTIONS: $crate::vmstate::VMStateSubsectionsWrapper = $crate::vmstate::VMStateSubsectionsWrapper(&[
+        static _SUBSECTIONS: $crate::vmstate::VMStateSubsections = &[
             $({
                 static _SUBSECTION: $crate::bindings::VMStateDescription = $subsection.get();
-                ::core::ptr::addr_of!(_SUBSECTION)
+                Some(&_SUBSECTION)
             }),*,
-            ::core::ptr::null()
-        ]);
+            None,
+        ];
         &_SUBSECTIONS
     }}
 }
@@ -685,8 +673,9 @@ pub const fn fields(mut self, fields: &'static [VMStateField]) -> Self {
     }
 
     #[must_use]
-    pub const fn subsections(mut self, subs: &'static VMStateSubsectionsWrapper) -> Self {
-        self.0.subsections = subs.0.as_ptr();
+    pub const fn subsections(mut self, subs: &'static VMStateSubsections) -> Self {
+        let subs: *const Option<&bindings::VMStateDescription> = subs.as_ptr();
+        self.0.subsections = subs.cast::<*const bindings::VMStateDescription>();
         self
     }
 
-- 
2.51.0


