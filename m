Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B9DCD343B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 07:04:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKslk-0004Iq-8E; Thu, 07 May 2026 03:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKslJ-0004Gy-17
 for qemu-devel@nongnu.org; Thu, 07 May 2026 03:03:13 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKsl7-0008Kb-UX
 for qemu-devel@nongnu.org; Thu, 07 May 2026 03:03:00 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4891d7164ddso2494995e9.3
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 00:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778137351; x=1778742151; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=S0erX5T8Zy10sYEUG1vOsOy63lvUycNOIDOFutrpzEU=;
 b=ukZS1kPuykJotVsqhJxMidLmObHZpWXT3Ltuahxxqztv3crKaLc8BaZJqsAOS+L6o1
 avf9DJlaXaxfpmzOI6kBFObwgOnhpNKETRxCiy6XxsG5o36sA40mU8jGjSAVvf4Pz4EW
 vBgXZ771wkbRr3wEQB/QlyhGAp21Mu9i3xVYsg7qza4aBSotkQP2PWXvILp2o60DyeqS
 CzInI7cFkpkmClasgRJRjk4xlJ1F4wob3Zpo2n0j1bK/Hvc6NtTmilRiaLETzPyp21kb
 nQzVQm7GvSl5CCPy6HxXFuP3lrMqogck2rOodUOopmVrOGlKWg2Mal353TcjKQO4vxHO
 Ff3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778137351; x=1778742151;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S0erX5T8Zy10sYEUG1vOsOy63lvUycNOIDOFutrpzEU=;
 b=kh1Xc5FFrdFFCPkHC3Zu02HTpupbwW+BNbuxfLCicgFVcvaBfv5HTtkSiMqNuES6sY
 pjv0GZ3lpa/fNrRE8YRPfzRBvp6TsYWy2zfLyD+hUz1d3oj0LBQ13bNKkMww97rVY9C4
 5tv2sMb6JlFsbKax30PYDqU1NHzsY3FBQ77MmXteye0TPoWb0jOcUAbpgnFEr1gY/J/6
 3xMReWdIJCBSXHQylrlFb0oPbhe+VWYVaYfin0ID6Uq10itbFmQaZP3U2xro55LeUfN2
 6Aj56c1QmX+MBJ0w/3ZzVi2gH4hzs/7800K2Oe1go8bsO64RTqftdM3DjRrUSyKG3vQo
 6sig==
X-Gm-Message-State: AOJu0Yyc/uI40BOk7b9Hd5g6V5Rnl/p9BVOSo0k3Ca1CJLoGfyraW4XL
 oTj7Dd6ERMJA/nbXz7Ntirb61zQNWS+mB2eUHpDzozhmXA5piyzllBUXBYe64zzkRPm/1ETU/tg
 5p1+uZXQ=
X-Gm-Gg: AeBDietILldqkmL9G0Oj7GG6u+aApUHyCwuGgBoAWil+La5NxIuqpSeih5aaPoc08BN
 NouGU9H0bVA1ZMuAJebXbBlAvBjP6CLIU5w/BaIiurXOENxAAmB6COrs1JveNLwkW6DmCnHCW5w
 MVOjnlbNRdePLW9yqHN6yqf9n4owwpI4c/w/j9yZzs6VBgxqjWCb8JNQ6/bdU65Kb1G8Vzkt5a0
 Ny3k20BBUogN+tDbwIkadkzE+kqd9zrNWwMKeYH11/Zc7zrLlGhQjLOF6rdXlMunGn21E4WMsfZ
 SvncS8tGFCd+3DKExLgcVyrneI/AFcg9NKEnJE62j6YdRMMMBtqtJT9tAVZAZ6zo6iWe7/6VegB
 33I/xjcUrrqgtlWx9NCtIx1IHlDhwVNhKee5vNqen/JjcqkgpKWVQIl8t9LfpdWHT+j1olc8ute
 SvF4/xva6lhf4bZZMrFvDkoTfZ8D7GLeEGbwyGWFIYfMUBgFwpkBEjhLt8u46tclpWDX989wYUV
 Iha5hM368c=
X-Received: by 2002:a05:600c:6290:b0:485:3f30:6250 with SMTP id
 5b1f17b1804b1-48e51f3fd58mr123787275e9.20.1778137350867; 
 Thu, 07 May 2026 00:02:30 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5389da63sm103101465e9.4.2026.05.07.00.02.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 07 May 2026 00:02:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-rust@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] migration: Remove VMS_MULTIPLY_ELEMENTS and
 VMSTATE_VARRAY_MULTIPLY()
Date: Thu,  7 May 2026 09:02:28 +0200
Message-ID: <20260507070228.48877-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Commit c1eb3ac3468 ("target/sparc: Replace
VMSTATE_VARRAY_MULTIPLY -> VMSTATE_UINTTL_ARRAY") removed the
last use of the VMSTATE_VARRAY_MULTIPLY() macro. We can now
remove it as unnecessary, along with the VMS_MULTIPLY_ELEMENTS
flag and the associated tests.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/migration/vmstate.h        | 22 ++----------
 migration/vmstate.c                |  4 ---
 rust/bindings/migration-sys/lib.rs |  8 -----
 rust/migration/src/vmstate.rs      |  3 +-
 rust/tests/tests/vmstate_tests.rs  | 55 ------------------------------
 5 files changed, 4 insertions(+), 88 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 28e3640e60c..0a8a2e85a63 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -105,7 +105,7 @@ enum VMStateFlags {
     VMS_ARRAY_OF_POINTER = 0x040,
 
     /* The field is an array of variable size. The uint16_t at opaque
-     * + VMStateField.num_offset (subject to VMS_MULTIPLY_ELEMENTS)
+     * + VMStateField.num_offset
      * contains the number of entries in the array. See the VMS_ARRAY
      * description regarding array handling in general. May not be
      * combined with VMS_ARRAY or any other VMS_VARRAY*. */
@@ -126,14 +126,14 @@ enum VMStateFlags {
     VMS_MULTIPLY         = 0x200,
 
     /* The field is an array of variable size. The uint8_t at opaque +
-     * VMStateField.num_offset (subject to VMS_MULTIPLY_ELEMENTS)
+     * VMStateField.num_offset
      * contains the number of entries in the array. See the VMS_ARRAY
      * description regarding array handling in general. May not be
      * combined with VMS_ARRAY or any other VMS_VARRAY*. */
     VMS_VARRAY_UINT8     = 0x400,
 
     /* The field is an array of variable size. The uint32_t at opaque
-     * + VMStateField.num_offset (subject to VMS_MULTIPLY_ELEMENTS)
+     * + VMStateField.num_offset
      * contains the number of entries in the array. See the VMS_ARRAY
      * description regarding array handling in general. May not be
      * combined with VMS_ARRAY or any other VMS_VARRAY*. */
@@ -150,12 +150,6 @@ enum VMStateFlags {
      * cause the individual entries to be allocated. */
     VMS_ALLOC            = 0x2000,
 
-    /* Multiply the number of entries given by the integer at opaque +
-     * VMStateField.num_offset (see VMS_VARRAY*) with VMStateField.num
-     * to determine the number of entries in the array. Only valid in
-     * combination with one of VMS_VARRAY*. */
-    VMS_MULTIPLY_ELEMENTS = 0x4000,
-
     /* A structure field that is like VMS_STRUCT, but uses
      * VMStateField.struct_version_id to tell which version of the
      * structure we are referencing to use. */
@@ -446,16 +440,6 @@ extern const VMStateInfo vmstate_info_qlist;
     .offset     = vmstate_offset_2darray(_state, _field, _type, _n1, _n2),  \
 }
 
-#define VMSTATE_VARRAY_MULTIPLY(_field, _state, _field_num, _multiply, _info, _type) { \
-    .name       = (stringify(_field)),                               \
-    .num_offset = vmstate_offset_value(_state, _field_num, uint32_t),\
-    .num        = (_multiply),                                       \
-    .info       = &(_info),                                          \
-    .size       = sizeof(_type),                                     \
-    .flags      = VMS_VARRAY_UINT32|VMS_MULTIPLY_ELEMENTS,           \
-    .offset     = vmstate_offset_varray(_state, _field, _type),      \
-}
-
 #define VMSTATE_SUB_ARRAY(_field, _state, _start, _num, _version, _info, _type) { \
     .name       = (stringify(_field)),                               \
     .version_id = (_version),                                        \
diff --git a/migration/vmstate.c b/migration/vmstate.c
index 2f13b48a37f..6fa7523f04d 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -100,10 +100,6 @@ static int vmstate_n_elems(void *opaque, const VMStateField *field)
         n_elems = *(uint8_t *)(opaque + field->num_offset);
     }
 
-    if (field->flags & VMS_MULTIPLY_ELEMENTS) {
-        n_elems *= field->num;
-    }
-
     trace_vmstate_n_elems(field->name, n_elems);
     return n_elems;
 }
diff --git a/rust/bindings/migration-sys/lib.rs b/rust/bindings/migration-sys/lib.rs
index 7ee30a3f7d5..9581481e421 100644
--- a/rust/bindings/migration-sys/lib.rs
+++ b/rust/bindings/migration-sys/lib.rs
@@ -114,12 +114,4 @@ pub const fn with_varray_flag(mut self, flag: VMStateFlags) -> Self {
         assert!((self.flags.0 & VMStateFlags::VMS_ARRAY.0) != 0);
         self.with_varray_flag_unchecked(flag)
     }
-
-    #[must_use]
-    pub const fn with_varray_multiply(mut self, num: u32) -> Self {
-        assert!(num <= 0x7FFF_FFFFu32);
-        self.flags = VMStateFlags(self.flags.0 | VMStateFlags::VMS_MULTIPLY_ELEMENTS.0);
-        self.num = num as i32;
-        self
-    }
 }
diff --git a/rust/migration/src/vmstate.rs b/rust/migration/src/vmstate.rs
index f34a36f6809..63d78b4f275 100644
--- a/rust/migration/src/vmstate.rs
+++ b/rust/migration/src/vmstate.rs
@@ -159,8 +159,7 @@ macro_rules! vmstate_of {
             )$(.with_varray_flag($crate::call_func_with_field!(
                     $crate::vmstate::vmstate_varray_flag,
                     $struct_name,
-                    $($num).+))
-               $(.with_varray_multiply($factor))?)?
+                    $($num).+)))?
         }
     };
 }
diff --git a/rust/tests/tests/vmstate_tests.rs b/rust/tests/tests/vmstate_tests.rs
index 87176a80990..c2c12cfab52 100644
--- a/rust/tests/tests/vmstate_tests.rs
+++ b/rust/tests/tests/vmstate_tests.rs
@@ -118,34 +118,6 @@ fn test_vmstate_varray_uint16_unsafe() {
     assert!(foo_fields[2].field_exists.is_none());
 }
 
-#[test]
-fn test_vmstate_varray_multiply() {
-    let foo_fields: &[VMStateField] =
-        unsafe { slice::from_raw_parts(VMSTATE_FOOA.as_ref().fields, 5) };
-
-    // 4th VMStateField ("arr_mul") in VMSTATE_FOOA (corresponding to
-    // VMSTATE_VARRAY_MULTIPLY)
-    assert_eq!(
-        unsafe { CStr::from_ptr(foo_fields[3].name) }.to_bytes_with_nul(),
-        b"arr_mul\0"
-    );
-    assert_eq!(foo_fields[3].offset, 6);
-    assert_eq!(foo_fields[3].num_offset, 12);
-    assert_eq!(foo_fields[3].info, unsafe { &vmstate_info_int8 });
-    assert_eq!(foo_fields[3].version_id, 0);
-    assert_eq!(foo_fields[3].size, 1);
-    assert_eq!(foo_fields[3].num, 16);
-    assert_eq!(
-        foo_fields[3].flags.0,
-        VMStateFlags::VMS_VARRAY_UINT32.0 | VMStateFlags::VMS_MULTIPLY_ELEMENTS.0
-    );
-    assert!(foo_fields[3].vmsd.is_null());
-    assert!(foo_fields[3].field_exists.is_none());
-
-    // The last VMStateField in VMSTATE_FOOA.
-    assert_eq!(foo_fields[4].flags, VMStateFlags::VMS_END);
-}
-
 // =========================== Test VMSTATE_FOOB ===========================
 // Test the use cases of the vmstate macro, corresponding to the following C
 // macro variants:
@@ -256,33 +228,6 @@ fn test_vmstate_struct_varray_uint8() {
     assert!(foo_fields[2].field_exists.is_none());
 }
 
-#[test]
-fn test_vmstate_struct_varray_uint32_multiply() {
-    let foo_fields: &[VMStateField] =
-        unsafe { slice::from_raw_parts(VMSTATE_FOOB.as_ref().fields, 7) };
-
-    // 4th VMStateField ("arr_a_mul") in VMSTATE_FOOB (corresponding to
-    // (no C version) MULTIPLY variant of VMSTATE_STRUCT_VARRAY_UINT32)
-    assert_eq!(
-        unsafe { CStr::from_ptr(foo_fields[3].name) }.to_bytes_with_nul(),
-        b"arr_a_mul\0"
-    );
-    assert_eq!(foo_fields[3].offset, 64);
-    assert_eq!(foo_fields[3].num_offset, 124);
-    assert!(foo_fields[3].info.is_null()); // VMSTATE_STRUCT_VARRAY_UINT8 doesn't set info field.
-    assert_eq!(foo_fields[3].version_id, 2);
-    assert_eq!(foo_fields[3].size, 20);
-    assert_eq!(foo_fields[3].num, 32);
-    assert_eq!(
-        foo_fields[3].flags.0,
-        VMStateFlags::VMS_STRUCT.0
-            | VMStateFlags::VMS_VARRAY_UINT32.0
-            | VMStateFlags::VMS_MULTIPLY_ELEMENTS.0
-    );
-    assert_eq!(foo_fields[3].vmsd, VMSTATE_FOOA.as_ref());
-    assert!(foo_fields[3].field_exists.is_none());
-}
-
 #[test]
 fn test_vmstate_macro_array() {
     let foo_fields: &[VMStateField] =
-- 
2.53.0


