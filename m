Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D90606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 12:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Fqx1CQ0h;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=EkKdylSZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUO3h-0000rc-8A; Fri, 20 Nov 2026 07:49:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xUO3g-0000rP-2j
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 07:49:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xUO3e-0004lx-8m
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 07:49:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795178977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uSwHL3vuTndJi148C85zSTNoHuO+rSDLC00laMooOgM=;
 b=Fqx1CQ0hZkM+yKmh7skZWdwBm4RuSYsvclYiOJiD+8tlU/CfYhbf8lwfJ03VQABjm03fEP
 xsm3YsMspViGF0clY77wllOc+IBOZorsVpdw3gq+U5JUAjOkde63rPOvQaliRqeRaeq8tc
 5noOOwex1KRVO5C6jCpgtbRPwQ6Nmwg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-br9mhsXZPPSaZ4J_2FtCgQ-1; Fri, 20 Nov 2026 12:49:35 +0000
X-MC-Unique: br9mhsXZPPSaZ4J_2FtCgQ-1
X-Mimecast-MFC-AGG-ID: br9mhsXZPPSaZ4J_2FtCgQ_1795178975
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-94961ed97d6so152878885a.1
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 04:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795178975; x=1795783775; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uSwHL3vuTndJi148C85zSTNoHuO+rSDLC00laMooOgM=;
 b=EkKdylSZyJviwBy+aAW03cK+jwkZBKIIgZ83DSzRcgMY+jG1tnsurrg2k7lszc0VXM
 PwZbV1TNr51VqppfllR2R6mZID7pGcDPYHrzLLhGl0xaxCC/MlLtajTh4VMRWsKlU3B3
 oUEon8P8nzJoxJ4W51j8AhLCZrHmNNcAcGYXhiHdBSR+m3KvaoMnakSVHh0ep06IQlX8
 GV+yzEf5MqR1Sr1gf1G/nExG6wtSwX/7ZPvHsJSBRkdaVNLrbDHKgPCqmKL6+FrGg+do
 MqhbwiXIDkbtmP20TNrywUs5IumyBLFbkwNmeKwn1ZGRxjxI1x+UeiN2ux5KIwc2KyeY
 oRCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795178975; x=1795783775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uSwHL3vuTndJi148C85zSTNoHuO+rSDLC00laMooOgM=;
 b=08ATgqZ2tOrKxPYV94sLMSv1d/7a9Mk5Jye82KVvCgfj9kT3cR8kroUU0s1m18pd6V
 QJL3diAgxQ9nJz2+udwWdwLBwOJ7Dcy+THZNY1RtQ6PiIXc1eDWFOQcsdUbI/ncTXwwU
 yJaV0QkATCfrcWu9QaY77GnepDoHHd/sWKAcRF1CRA8YyaiiNUW130zpjIsVXPbaSq9V
 BJFwI6XcT22NXQpCdXU7/9w01Mw8KfHmmKkW+k+BwogwDn61o0TIW18fq3HbrQqFC+ku
 JSRueFchC+wjzJ607hrhDLOTGGP1FI+fSI50rGZUmQCk3MnyGpVV+/FC7LjI4/aczkiX
 tMxQ==
X-Gm-Message-State: APuU4Z9Ep2VjLsnvcZRhpUh0V0zkfB9dh0MDe1vdmpasXPaMiC64mzYu
 S/qedgqSMGKBMWjCUxBTDk630OLqxycfD0u5iNB/mokTQYdPZPj4e8uzS0NxlCFevuw5+VF5ZcD
 7cdWe52yH7ygWYhIA+G9KJqiasN512ZTAFP21fWrOdZJ4X0+CRKXHnoHpWocYLUZVFPwqXMc4mW
 0SaUHPAldTqyZQ3OlxEuPi2jie0fMU0itjzjdASQ==
X-Gm-Gg: AYBFou0FJM4cL9X2iNSguZrLmqkazPsSmabGTmwZifgESOIq5vRPJjos1XYQdKTQB6d
 mVlmCvKX9M2yPty6F0d/nE27sOC86k74aNXbq6AbTkRFAqjFYuGSTFbVdP6EMebuUL18QfQtfNG
 JP9xNPsPq0706aljklj+0AO0l0OjNvOmNKI84JliU6wXlicW68ufeoep4IRJAIi7QQxcodje/Ga
 GjEmKW22NPkbNpvVWjjUGzTLEd29+E2IjQEtJYOA3ghgOlOtPBFM+3BI/3jC8NqLhlooOy6IVsT
 n9Ut1wpzNFnW51H9b0JDCt01QiG7GSsGent827N9BAqyeFkLlLVAjiT+acMEKkxHnBAIepm0H1r
 oWsZjst+zsb/eJqaEEetP5UHwWpZ5tYt/oZmY7kdFlL30
X-Received: by 2002:a05:620a:372b:b0:949:70c5:c0ce with SMTP id
 af79cd13be357-949b35ac8e0mr694767285a.19.1795178974914; 
 Fri, 20 Nov 2026 04:49:34 -0800 (PST)
X-Received: by 2002:a05:620a:372b:b0:949:70c5:c0ce with SMTP id
 af79cd13be357-949b35ac8e0mr694762985a.19.1795178974274; 
 Fri, 20 Nov 2026 04:49:34 -0800 (PST)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-949bb397b4bsm181805685a.21.2026.11.20.04.49.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 04:49:33 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 peterx@redhat.com, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-rust@nongnu.org
Subject: [PATCH for-12.0 5/6] rust: Replace vmstate_validate with post_load
Date: Fri, 20 Nov 2026 07:49:22 -0500
Message-ID: <20261120124923.1656220-6-peterx@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261120124923.1656220-1-peterx@redhat.com>
References: <20261120124923.1656220-1-peterx@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

We dropped all of that in C, drop that in Rust too.  The goal is to remove
the VMSTATE_VALIDATE() together with VMS_MUST_EXIST.

Use post_load instead for the check.

Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-rust@nongnu.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 rust/hw/timer/hpet/src/device.rs  |  9 ++--
 rust/migration/src/prelude.rs     |  1 -
 rust/migration/src/vmstate.rs     | 17 -------
 rust/tests/tests/vmstate_tests.rs | 77 -------------------------------
 4 files changed, 5 insertions(+), 99 deletions(-)

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 89ba7a5c4d..da0540f528 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -934,10 +934,14 @@ fn pre_save(&self) -> Result<(), migration::Infallible> {
         Ok(())
     }
 
-    fn post_load(&self, _version_id: u8) -> Result<(), migration::Infallible> {
+    fn post_load(&self, version_id: u8) -> Result<(), migration::InvalidError> {
         let mut regs = self.regs.borrow_mut();
         let cnt = regs.counter;
 
+        if !self.validate_num_timers(version_id) {
+            return Err(migration::InvalidError);
+        }
+
         for tn_regs in regs.tn_regs.iter_mut().take(self.num_timers) {
             tn_regs.update_cmp64(cnt);
             tn_regs.last = CLOCK_VIRTUAL.get_ns() - NANOSECONDS_PER_SECOND;
@@ -1082,8 +1086,6 @@ fn restore_migrated_state(
 
 impl_vmstate_struct!(HPETTimerMigration, VMSTATE_HPET_TIMER);
 
-const VALIDATE_TIMERS_NAME: &CStr = c"num_timers must match";
-
 // HPETRegistersMigration is generated by ToMigrationState macro.
 impl_vmstate_struct!(
     HPETRegistersMigration,
@@ -1109,7 +1111,6 @@ fn restore_migrated_state(
         .fields(vmstate_fields! {
             vmstate_of!(HPETState, regs),
             vmstate_of!(HPETState, num_timers_save),
-            vmstate_validate!(HPETState, VALIDATE_TIMERS_NAME, HPETState::validate_num_timers),
             vmstate_of!(HPETState, timers[0 .. num_timers_save], HPETState::validate_num_timers).with_version_id(0),
         })
         .subsections(vmstate_subsections!(
diff --git a/rust/migration/src/prelude.rs b/rust/migration/src/prelude.rs
index 797e7ec59d..e2cbbda43e 100644
--- a/rust/migration/src/prelude.rs
+++ b/rust/migration/src/prelude.rs
@@ -16,4 +16,3 @@
 pub use crate::vmstate_of;
 pub use crate::vmstate_subsections;
 pub use crate::vmstate_unused;
-pub use crate::vmstate_validate;
diff --git a/rust/migration/src/vmstate.rs b/rust/migration/src/vmstate.rs
index 5ed061f2ab..0c8b92f9d6 100644
--- a/rust/migration/src/vmstate.rs
+++ b/rust/migration/src/vmstate.rs
@@ -372,23 +372,6 @@ macro_rules! vmstate_fields {
     }}
 }
 
-#[doc(alias = "VMSTATE_VALIDATE")]
-#[macro_export]
-macro_rules! vmstate_validate {
-    ($struct_name:ty, $test_name:expr, $test_fn:expr $(,)?) => {
-        $crate::bindings::VMStateField {
-            name: ::std::ffi::CStr::as_ptr($test_name),
-            field_exists: $crate::vmstate_exist_fn!($struct_name, $test_fn),
-            flags: $crate::bindings::VMStateFlags(
-                $crate::bindings::VMStateFlags::VMS_MUST_EXIST.0
-                    | $crate::bindings::VMStateFlags::VMS_NO_STATE.0,
-            ),
-            num: 0, // 0 elements: no data, only run test_fn callback
-            ..::common::zeroable::Zeroable::ZERO
-        }
-    };
-}
-
 /// Helper macro to allow using a struct in [`vmstate_of!`]
 ///
 /// # Safety
diff --git a/rust/tests/tests/vmstate_tests.rs b/rust/tests/tests/vmstate_tests.rs
index 6578d54b37..f4db02abac 100644
--- a/rust/tests/tests/vmstate_tests.rs
+++ b/rust/tests/tests/vmstate_tests.rs
@@ -406,80 +406,3 @@ fn test_vmstate_macro_array_of_pointer_wrapped() {
     // The last VMStateField in VMSTATE_FOOC.
     assert_eq!(foo_fields[4].flags, VMStateFlags::VMS_END);
 }
-
-// =========================== Test VMSTATE_FOOD ===========================
-// Test the use cases of the vmstate macro, corresponding to the following C
-// macro variants:
-//   * VMSTATE_FOOD:
-//     - VMSTATE_VALIDATE
-
-// Add more member fields when vmstate_of support "test" parameter.
-struct FooD;
-
-impl FooD {
-    fn validate_food_0(&self, _version_id: u8) -> bool {
-        true
-    }
-
-    fn validate_food_1(_state: &FooD, _version_id: u8) -> bool {
-        false
-    }
-}
-
-fn validate_food_2(_state: &FooD, _version_id: u8) -> bool {
-    true
-}
-
-static VMSTATE_FOOD: VMStateDescription<FooD> = VMStateDescriptionBuilder::<FooD>::new()
-    .name(c"foo_d")
-    .version_id(3)
-    .minimum_version_id(1)
-    .fields(vmstate_fields! {
-        vmstate_validate!(FooD, c"foo_d_0", FooD::validate_food_0),
-        vmstate_validate!(FooD, c"foo_d_1", FooD::validate_food_1),
-        vmstate_validate!(FooD, c"foo_d_2", validate_food_2),
-    })
-    .build();
-
-#[test]
-fn test_vmstate_validate() {
-    let foo_fields: &[VMStateField] =
-        unsafe { slice::from_raw_parts(VMSTATE_FOOD.as_ref().fields, 4) };
-    let mut foo_d = FooD;
-    let foo_d_p = std::ptr::addr_of_mut!(foo_d).cast::<c_void>();
-
-    // 1st VMStateField in VMSTATE_FOOD
-    assert_eq!(
-        unsafe { CStr::from_ptr(foo_fields[0].name) }.to_bytes_with_nul(),
-        b"foo_d_0\0"
-    );
-    assert_eq!(foo_fields[0].offset, 0);
-    assert_eq!(foo_fields[0].num_indirect.size, 0);
-    assert!(foo_fields[0].info.is_null());
-    assert_eq!(foo_fields[0].version_id, 0);
-    assert_eq!(foo_fields[0].size, 0);
-    assert_eq!(foo_fields[0].num, 0);
-    assert_eq!(
-        foo_fields[0].flags.0,
-        VMStateFlags::VMS_NO_STATE.0 | VMStateFlags::VMS_MUST_EXIST.0
-    );
-    assert!(foo_fields[0].vmsd.is_null());
-    assert!(unsafe { foo_fields[0].field_exists.unwrap()(foo_d_p, 0) });
-
-    // 2nd VMStateField in VMSTATE_FOOD
-    assert_eq!(
-        unsafe { CStr::from_ptr(foo_fields[1].name) }.to_bytes_with_nul(),
-        b"foo_d_1\0"
-    );
-    assert!(!unsafe { foo_fields[1].field_exists.unwrap()(foo_d_p, 1) });
-
-    // 3rd VMStateField in VMSTATE_FOOD
-    assert_eq!(
-        unsafe { CStr::from_ptr(foo_fields[2].name) }.to_bytes_with_nul(),
-        b"foo_d_2\0"
-    );
-    assert!(unsafe { foo_fields[2].field_exists.unwrap()(foo_d_p, 2) });
-
-    // The last VMStateField in VMSTATE_FOOD.
-    assert_eq!(foo_fields[3].flags, VMStateFlags::VMS_END);
-}
-- 
2.56.0


