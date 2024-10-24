Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F28FBCE8E78
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 14:05:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3yRW-0007Bf-RB; Thu, 24 Oct 2024 10:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t3yRC-00078q-EU
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 10:03:50 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t3yR8-0003wK-OK
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 10:03:42 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2fb51e00c05so14154581fa.0
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 07:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729778616; x=1730383416; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2iGhVX3FthgCu9tCSB5ib+BmYJD5e1RgHUcKSHCgOOI=;
 b=rUGCQrLWPDkD2kiGqZSdoWxuu2ET2LjSjxyJPDSao/0rESoR17GvIP4KufdEdTeCx8
 w3ZN3i+DgRIILLAHSBBI25LBRRRrQLWjfHfk3U7wRrggD15+xpyLqo6dfapcnR2F2wQJ
 X6iphCWjoTN7eNGQtQUgpoZgd7YdL7UFB+dKOMzjmNsT/wiWIJDtAsVmzJ+khkMm0Jzj
 ANxC3rQhVpK5owDxDyd5lpMCgFYxRwIMf5jOSvm6yCcUz3mrqtg9jqRhq2I0I+Z4mrNb
 FgSvxrpfBwTHSkV9warB9nyVBIF7q40o5RM7fhVwuTY/Xw7yDCHoo+/nu0nL7PqFuo4r
 DCAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729778616; x=1730383416;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2iGhVX3FthgCu9tCSB5ib+BmYJD5e1RgHUcKSHCgOOI=;
 b=pmguOuAmTQedk+MOWQD3hoZnHpREKzG0Yo+VctXWWmhpArieOFvA5JBmTGdF9ZNsBA
 CtPL5ggadf39fv2JtKNgLwtX51QF5nL6JVFjWLCfiASpSA1SKHxmr7YjTEEKdAFIvqqN
 SvEL5wQi7Z0JBpln5iHLtV6XQKIlVcX6zll24eZhWzLbQ21JbtZmbg3az+P323iixAUQ
 DvhF1TrhpYWcHhE3/mDiLGgCxifPKnNEbYcgbTWA7OlnL6eYudjvSWLLTQsAnUP4VDOB
 CREEe6n7fPDNgPpdnxdnebA9hJMQY81xoFbthgOuOtzDmdMaNMhviPFYFc2Zuy1xMc2P
 C3aw==
X-Gm-Message-State: AOJu0YyuJFm+muB3qd6jYt2Bx2g3oC1xogK6SDKZMBASPjrXC+DXzko6
 lmUofYwTnb+40wbe4tW4tago8Ke5ZTJu+Zed9s5HKpF9ZR6ZiZV7VzzGIn5E/k8=
X-Google-Smtp-Source: AGHT+IGhCJhXR6hGf4u3tLOUo/0A2sEJdUiGwOYPNA3umLPkGF/soXznrg3r49In9R5KsO2cYOw3oA==
X-Received: by 2002:a05:6512:220d:b0:535:6baa:8c5d with SMTP id
 2adb3069b0e04-53b1a33cc87mr5521258e87.20.1729778615109; 
 Thu, 24 Oct 2024 07:03:35 -0700 (PDT)
Received: from [127.0.1.1] (adsl-113.37.6.2.tellas.gr. [37.6.2.113])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a912f6878sm621407566b.86.2024.10.24.07.03.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 07:03:34 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 24 Oct 2024 17:03:02 +0300
Subject: [PATCH 04/11] rust: add support for migration in device models
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241024-rust-round-2-v1-4-051e7a25b978@linaro.org>
References: <20241024-rust-round-2-v1-0-051e7a25b978@linaro.org>
In-Reply-To: <20241024-rust-round-2-v1-0-051e7a25b978@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Junjie Mao <junjie.mao@hotmail.com>, 
 Junjie Mao <junjie.mao@intel.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
X-Mailer: b4 0.15-dev-12fc5
X-Developer-Signature: v=1; a=openpgp-sha256; l=37037;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=kB5qjmgamQwXPRu8ReZyXP7rlHpISzFf2JMFS5i2g8I=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm5HbE9pWnc3Q3VJbkM0NUJpRGVnVXhqWTViMTRpCndBd1cxQU04RTNCTVU2cVMv
 SWlKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKWnhwVG9nQUt
 DUkIzS2Nkd2YzNEowQzJRRC85YVU0WGJnYWtIQVdMSnp2NGM0NHdEQW9mSnVzTWYreHY2RUxLZA
 p5N01aU2FTcm1yNk9uNi9VV216VUJEVlEwd2pLWFZrR3BWK1hJTml4UlhYY1o3Y0JOeTMzR1J1Y
 3dZTkJjdGdWCkZkMEdWQVNIWkJadXlyU0FqL0RrbFdoVXhBSE5KOWVGa0RoSWl3WXhXc2dYMENr
 VmtuRDh2YTdRS054U0J0Z2kKdmpNOStjUU1qL28rNjJOWGlaWUN0WHYzbHluS0hEMDc1UXNLOGF
 LUkkySUJkcXVTc0NlQmpPQktKMHRQamtJUgptMFBTd3ZtN3pmVlBlY0llSm85bk5LdG9aUGY0dE
 l6WHN0TyszNnl6WjJkWlNBWEhQRHRQOUlvMENvazcxZkxsClhmWERlTWFGelJhRUxNREdUd2RtR
 EJjR0ZsWnA2MittbENqSVlzVU9ndjhCbGJ3ajdFUXd2ZmdjRE5sbm5OaTkKbE9HY3NkdWdmOFZI
 bHFDVy9Mc21KY2JOeHQ0VmFGcUNWcmVYaDJITkxHWG9XM0cxZGJUWXpNVjZQMjY3K2tpawoxR00
 3R0hOdWtLcWp0VVl4ZjRJVlpTY1BWU3U4b2x1SWZKdTR3MDR5RmRhaFhXbjRvVUlad0EwVDdySV
 BENFdwCk44aVhpMkdtUXZMZjNRK0dnRnpRcXFmZHNIYnkrRFpWb1ZaRnVTYnAyNnRCZ0loQ3NmS
 EdVZTcwNVBYdXVsVjUKczdBYytUTkhjd0UwbFB6SVR2Yy92T1I3dXFBWTFFUjdWM3pjT0RFSmNy
 RUxEeFc5b29GODYvTUVYcFlXNlF5WApnSlB6SU1WSlhNWjVGWWJvbGNjOVF4OGcwdGFpOGlVbzh
 FM3dNZ25nR085ZU9ZZkp4T2ZUT01QdEJidnhBbFZXCkJKTHBGQT09Cj05SFZ0Ci0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This commit adds support for declaring migration state to device models
in Rust. This is done through different but related parts:

- The Device derive macro gains new attributes `vmstate_fields` and
  `vmstate_subsections`. This allows the device declaration to include
  the vmstate fields directly at the struct definition.
- a new qemu_api module, `vmstate` was added. There a bunch of Rust
  macros declared there that are equivalent in spirit to the C macros
  declared in include/migration/vmstate.h.

  For example the Rust of equivalent of the C macro:

    VMSTATE_UINT32(field_name, struct_name)

  is:

    vmstate_uint32!(field_name, StructName)

This breathtaking development now allows us to not have to define
VMStateDescription ourselves but split the notion of migration to two
parts:

- A Migrateable trait that allows a type to define version_ids, name,
  priority, override methods like pre_load, post_load, pre_save etc.
- Define the actual vmstate fields and subsections through the Device
  derive macro right there with the struct definition:

  ------------------------ >8 ------------------------
 #[repr(C)]
 #[derive(Debug, qemu_api_macros::Object, qemu_api_macros::Device)]
+#[device(
+    class_name_override = PL011Class,
+    vmstate_fields = vmstate_fields!{
+        vmstate_unused!(u32::BITS as u64),
+        vmstate_uint32!(flags, PL011State),
+        vmstate_uint32!(line_control, PL011State),
+        vmstate_uint32!(receive_status_error_clear, PL011State),
+        vmstate_uint32!(control, PL011State),
+        vmstate_uint32!(dmacr, PL011State),
+        vmstate_uint32!(int_enabled, PL011State),
+        vmstate_uint32!(int_level, PL011State),
+        vmstate_uint32_array!(read_fifo, PL011State, PL011_FIFO_DEPTH),
+        vmstate_uint32!(ilpr, PL011State),
+        vmstate_uint32!(ibrd, PL011State),
+        vmstate_uint32!(fbrd, PL011State),
+        vmstate_uint32!(ifl, PL011State),
+        vmstate_int32!(read_pos, PL011State),
+        vmstate_int32!(read_count, PL011State),
+        vmstate_int32!(read_trigger, PL011State),
+    },
+    vmstate_subsections = vmstate_subsections!{
+        VMSTATE_PL011_CLOCK
+    }
+)]
 /// PL011 Device Model in QEMU
 pub struct PL011State {
     pub parent_obj: SysBusDevice,
  ------------------------ >8 ------------------------

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 rust/hw/char/pl011/src/device.rs    |  92 +++++++-
 rust/qemu-api-macros/src/device.rs  | 111 +++-------
 rust/qemu-api-macros/src/lib.rs     |   1 +
 rust/qemu-api-macros/src/symbols.rs |   2 +
 rust/qemu-api-macros/src/vmstate.rs | 113 ++++++++++
 rust/qemu-api/meson.build           |   1 +
 rust/qemu-api/src/lib.rs            |   3 +
 rust/qemu-api/src/vmstate.rs        | 403 ++++++++++++++++++++++++++++++++++++
 8 files changed, 637 insertions(+), 89 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index c469877b1ca70dd1a02e3a2449c65ad3e57c93ae..57dc37dadef631fbccfa3049a3d8701b4e62b5b3 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -10,6 +10,8 @@
 use qemu_api::{
     bindings::{self, *},
     objects::*,
+    vmstate_clock, vmstate_fields, vmstate_int32, vmstate_subsections, vmstate_uint32,
+    vmstate_uint32_array, vmstate_unused,
 };
 
 use crate::{
@@ -20,14 +22,74 @@
 
 static PL011_ID_ARM: [c_uchar; 8] = [0x11, 0x10, 0x14, 0x00, 0x0d, 0xf0, 0x05, 0xb1];
 
+/// Integer Baud Rate Divider, `UARTIBRD`
+const IBRD_MASK: u32 = 0x3f;
+
+/// Fractional Baud Rate Divider, `UARTFBRD`
+const FBRD_MASK: u32 = 0xffff;
+
 const DATA_BREAK: u32 = 1 << 10;
 
 /// QEMU sourced constant.
 pub const PL011_FIFO_DEPTH: usize = 16_usize;
 
+#[no_mangle]
+extern "C" fn pl011_clock_needed(opaque: *mut c_void) -> bool {
+    unsafe {
+        debug_assert!(!opaque.is_null());
+        let state = NonNull::new_unchecked(opaque.cast::<PL011State>());
+        state.as_ref().migrate_clock
+    }
+}
+
+qemu_api::vmstate_description! {
+    /// Migration subsection for [`PL011State`] clock.
+    pub static VMSTATE_PL011_CLOCK: VMStateDescription = VMStateDescription {
+        name: c"pl011/clock",
+        unmigratable: false,
+        early_setup: false,
+        version_id: 1,
+        minimum_version_id: 1,
+        priority: MigrationPriority::MIG_PRI_DEFAULT,
+        pre_load: None,
+        post_load: None,
+        pre_save: None,
+        post_save: None,
+        needed: Some(pl011_clock_needed),
+        dev_unplug_pending: None,
+        fields: vmstate_fields!{
+            vmstate_clock!(clock, PL011State),
+        },
+        subsections: ::core::ptr::null(),
+    };
+}
+
 #[repr(C)]
 #[derive(Debug, qemu_api_macros::Object, qemu_api_macros::Device)]
-#[device(class_name_override = PL011Class)]
+#[device(
+    class_name_override = PL011Class,
+    vmstate_fields = vmstate_fields!{
+        vmstate_unused!(u32::BITS as u64),
+        vmstate_uint32!(flags, PL011State),
+        vmstate_uint32!(line_control, PL011State),
+        vmstate_uint32!(receive_status_error_clear, PL011State),
+        vmstate_uint32!(control, PL011State),
+        vmstate_uint32!(dmacr, PL011State),
+        vmstate_uint32!(int_enabled, PL011State),
+        vmstate_uint32!(int_level, PL011State),
+        vmstate_uint32_array!(read_fifo, PL011State, PL011_FIFO_DEPTH),
+        vmstate_uint32!(ilpr, PL011State),
+        vmstate_uint32!(ibrd, PL011State),
+        vmstate_uint32!(fbrd, PL011State),
+        vmstate_uint32!(ifl, PL011State),
+        vmstate_int32!(read_pos, PL011State),
+        vmstate_int32!(read_count, PL011State),
+        vmstate_int32!(read_trigger, PL011State),
+    },
+    vmstate_subsections = vmstate_subsections!{
+        VMSTATE_PL011_CLOCK
+    }
+)]
 /// PL011 Device Model in QEMU
 pub struct PL011State {
     pub parent_obj: SysBusDevice,
@@ -165,7 +227,33 @@ fn reset(&mut self) {
     }
 }
 
-impl qemu_api::objects::Migrateable for PL011State {}
+impl qemu_api::objects::Migrateable for PL011State {
+    const NAME: Option<&'static CStr> = Some(c"pl011");
+    const UNMIGRATABLE: bool = false;
+    const VERSION_ID: c_int = 2;
+    const MINIMUM_VERSION_ID: c_int = 2;
+
+    unsafe fn post_load(&mut self, _version_id: c_int) -> c_int {
+        /* Sanity-check input state */
+        if self.read_pos >= self.read_fifo.len() || self.read_count > self.read_fifo.len() {
+            return -1;
+        }
+
+        if !self.fifo_enabled() && self.read_count > 0 && self.read_pos > 0 {
+            // Older versions of PL011 didn't ensure that the single
+            // character in the FIFO in FIFO-disabled mode is in
+            // element 0 of the array; convert to follow the current
+            // code's assumptions.
+            self.read_fifo[0] = self.read_fifo[self.read_pos];
+            self.read_pos = 0;
+        }
+
+        self.ibrd &= IBRD_MASK;
+        self.fbrd &= FBRD_MASK;
+
+        0
+    }
+}
 
 #[used]
 pub static CLK_NAME: &CStr = c"clk";
diff --git a/rust/qemu-api-macros/src/device.rs b/rust/qemu-api-macros/src/device.rs
index 3b965576a065601cd5c97d5ab6a2501f96d16a61..a666c64087715b9dc0d9ebe33f2b22d965381c64 100644
--- a/rust/qemu-api-macros/src/device.rs
+++ b/rust/qemu-api-macros/src/device.rs
@@ -10,11 +10,13 @@
 };
 use syn::{parse_macro_input, DeriveInput};
 
-use crate::{symbols::*, utilities::*};
+use crate::{symbols::*, utilities::*, vmstate};
 
 #[derive(Debug, Default)]
 struct DeriveContainer {
     category: Option<syn::Path>,
+    vmstate_fields: Option<syn::Expr>,
+    vmstate_subsections: Option<syn::Expr>,
     class_name: Option<syn::Ident>,
     class_name_override: Option<syn::Ident>,
 }
@@ -27,6 +29,8 @@ fn parse(input: ParseStream) -> Result<Self> {
         assert_eq!(DEVICE, bracketed.parse::<syn::Ident>()?);
         let mut retval = Self {
             category: None,
+            vmstate_fields: None,
+            vmstate_subsections: None,
             class_name: None,
             class_name_override: None,
         };
@@ -54,6 +58,20 @@ fn parse(input: ParseStream) -> Result<Self> {
                 let lit: syn::LitStr = content.parse()?;
                 let path: syn::Path = lit.parse()?;
                 retval.category = Some(path);
+            } else if value == VMSTATE_FIELDS {
+                let _: syn::Token![=] = content.parse()?;
+                if retval.vmstate_fields.is_some() {
+                    panic!("{} can only be used at most once", VMSTATE_FIELDS);
+                }
+                let expr: syn::Expr = content.parse()?;
+                retval.vmstate_fields = Some(expr);
+            } else if value == VMSTATE_SUBSECTIONS {
+                let _: syn::Token![=] = content.parse()?;
+                if retval.vmstate_subsections.is_some() {
+                    panic!("{} can only be used at most once", VMSTATE_SUBSECTIONS);
+                }
+                let expr: syn::Expr = content.parse()?;
+                retval.vmstate_subsections = Some(expr);
             } else {
                 panic!("unrecognized token `{}`", value);
             }
@@ -272,7 +290,11 @@ pub struct #class_name {
     let class_base_init_fn = format_ident!("__{}_class_base_init_generated", class_name);
 
     let (vmsd, vmsd_impl) = {
-        let (i, vmsd) = make_vmstate(name);
+        let (i, vmsd) = vmstate::make_vmstate(
+            name,
+            derive_container.vmstate_fields,
+            derive_container.vmstate_subsections,
+        );
         (quote! { &#i }, vmsd)
     };
     let category = if let Some(category) = derive_container.category {
@@ -346,88 +368,3 @@ unsafe impl ::qemu_api::objects::ClassImplUnsafe for #class_name {
         #vmsd_impl
     }
 }
-
-fn make_vmstate(name: &syn::Ident) -> (syn::Ident, proc_macro2::TokenStream) {
-    let vmstate_description_ident = format_ident!("__VMSTATE_{}", name);
-
-    let pre_load = format_ident!("__{}_pre_load_generated", name);
-    let post_load = format_ident!("__{}_post_load_generated", name);
-    let pre_save = format_ident!("__{}_pre_save_generated", name);
-    let post_save = format_ident!("__{}_post_save_generated", name);
-    let needed = format_ident!("__{}_needed_generated", name);
-    let dev_unplug_pending = format_ident!("__{}_dev_unplug_pending_generated", name);
-
-    let migrateable_fish = quote! {<#name as ::qemu_api::objects::Migrateable>};
-    let vmstate_description = quote! {
-        #[used]
-        #[allow(non_upper_case_globals)]
-        pub static #vmstate_description_ident: ::qemu_api::bindings::VMStateDescription = ::qemu_api::bindings::VMStateDescription {
-            name: if let Some(name) = #migrateable_fish::NAME {
-                name.as_ptr()
-            } else {
-                <#name as ::qemu_api::objects::ObjectImplUnsafe>::TYPE_INFO.name
-            },
-            unmigratable: #migrateable_fish::UNMIGRATABLE,
-            early_setup: #migrateable_fish::EARLY_SETUP,
-            version_id: #migrateable_fish::VERSION_ID,
-            minimum_version_id: #migrateable_fish::MINIMUM_VERSION_ID,
-            priority: #migrateable_fish::PRIORITY,
-            pre_load: Some(#pre_load),
-            post_load: Some(#post_load),
-            pre_save: Some(#pre_save),
-            post_save: Some(#post_save),
-            needed: Some(#needed),
-            dev_unplug_pending: Some(#dev_unplug_pending),
-            fields: ::core::ptr::null(),
-            subsections: ::core::ptr::null(),
-        };
-
-        #[no_mangle]
-        pub unsafe extern "C" fn #pre_load(opaque: *mut ::core::ffi::c_void) -> ::core::ffi::c_int {
-            let mut instance = NonNull::new(opaque.cast::<#name>()).expect(concat!("Expected opaque to be a non-null pointer of type ", stringify!(#name), "::Object"));
-            unsafe {
-                ::qemu_api::objects::Migrateable::pre_load(instance.as_mut())
-            }
-        }
-        #[no_mangle]
-        pub unsafe extern "C" fn #post_load(opaque: *mut ::core::ffi::c_void, version_id: core::ffi::c_int) -> ::core::ffi::c_int {
-            let mut instance = NonNull::new(opaque.cast::<#name>()).expect(concat!("Expected opaque to be a non-null pointer of type ", stringify!(#name), "::Object"));
-            unsafe {
-                ::qemu_api::objects::Migrateable::post_load(instance.as_mut(), version_id)
-            }
-        }
-        #[no_mangle]
-        pub unsafe extern "C" fn #pre_save(opaque: *mut ::core::ffi::c_void) -> ::core::ffi::c_int {
-            let mut instance = NonNull::new(opaque.cast::<#name>()).expect(concat!("Expected opaque to be a non-null pointer of type ", stringify!(#name), "::Object"));
-            unsafe {
-                ::qemu_api::objects::Migrateable::pre_save(instance.as_mut())
-            }
-        }
-        #[no_mangle]
-        pub unsafe extern "C" fn #post_save(opaque: *mut ::core::ffi::c_void) -> ::core::ffi::c_int {
-            let mut instance = NonNull::new(opaque.cast::<#name>()).expect(concat!("Expected opaque to be a non-null pointer of type ", stringify!(#name), "::Object"));
-            unsafe {
-                ::qemu_api::objects::Migrateable::post_save(instance.as_mut())
-            }
-        }
-        #[no_mangle]
-        pub unsafe extern "C" fn #needed(opaque: *mut ::core::ffi::c_void) -> bool {
-            let mut instance = NonNull::new(opaque.cast::<#name>()).expect(concat!("Expected opaque to be a non-null pointer of type ", stringify!(#name), "::Object"));
-            unsafe {
-                ::qemu_api::objects::Migrateable::needed(instance.as_mut())
-            }
-        }
-        #[no_mangle]
-        pub unsafe extern "C" fn #dev_unplug_pending(opaque: *mut ::core::ffi::c_void) -> bool {
-            let mut instance = NonNull::new(opaque.cast::<#name>()).expect(concat!("Expected opaque to be a non-null pointer of type ", stringify!(#name), "::Object"));
-            unsafe {
-                ::qemu_api::objects::Migrateable::dev_unplug_pending(instance.as_mut())
-            }
-        }
-    };
-
-    let expanded = quote! {
-        #vmstate_description
-    };
-    (vmstate_description_ident, expanded)
-}
diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/lib.rs
index 7753a853fae72fc87e6dc642cf076c6d0c736345..7b5c0c044da879241b05bba75edcb17b498e5d5a 100644
--- a/rust/qemu-api-macros/src/lib.rs
+++ b/rust/qemu-api-macros/src/lib.rs
@@ -10,6 +10,7 @@
 mod object;
 mod symbols;
 mod utilities;
+mod vmstate;
 
 #[proc_macro_derive(Object)]
 pub fn derive_object(input: TokenStream) -> TokenStream {
diff --git a/rust/qemu-api-macros/src/symbols.rs b/rust/qemu-api-macros/src/symbols.rs
index f73768d228ed2b4d478c18336db56cb11e70f012..79c242cf069d5de1dd0cd61b2a5c7814564af47e 100644
--- a/rust/qemu-api-macros/src/symbols.rs
+++ b/rust/qemu-api-macros/src/symbols.rs
@@ -15,6 +15,8 @@
 pub const CLASS_NAME_OVERRIDE: Symbol = Symbol("class_name_override");
 pub const QDEV_PROP: Symbol = Symbol("qdev_prop");
 pub const MIGRATEABLE: Symbol = Symbol("migrateable");
+pub const VMSTATE_FIELDS: Symbol = Symbol("vmstate_fields");
+pub const VMSTATE_SUBSECTIONS: Symbol = Symbol("vmstate_subsections");
 pub const PROPERTIES: Symbol = Symbol("properties");
 pub const PROPERTY: Symbol = Symbol("property");
 
diff --git a/rust/qemu-api-macros/src/vmstate.rs b/rust/qemu-api-macros/src/vmstate.rs
new file mode 100644
index 0000000000000000000000000000000000000000..2d72bf13b5acc861fac0814d749762ddb76824d5
--- /dev/null
+++ b/rust/qemu-api-macros/src/vmstate.rs
@@ -0,0 +1,113 @@
+// Copyright 2024, Linaro Limited
+// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+use quote::{format_ident, quote};
+
+pub fn make_vmstate(
+    name: &syn::Ident,
+    vmstate_fields: Option<syn::Expr>,
+    vmstate_subsections: Option<syn::Expr>,
+) -> (syn::Ident, proc_macro2::TokenStream) {
+    let vmstate_description_ident = format_ident!("__VMSTATE_{}", name);
+
+    let pre_load = format_ident!("__{}_pre_load_generated", name);
+    let post_load = format_ident!("__{}_post_load_generated", name);
+    let pre_save = format_ident!("__{}_pre_save_generated", name);
+    let post_save = format_ident!("__{}_post_save_generated", name);
+    let needed = format_ident!("__{}_needed_generated", name);
+    let dev_unplug_pending = format_ident!("__{}_dev_unplug_pending_generated", name);
+
+    let migrateable_fish = quote! {<#name as ::qemu_api::objects::Migrateable>};
+    let vmstate_fields = if let Some(fields) = vmstate_fields {
+        quote! {
+            #fields
+        }
+    } else {
+        quote! {
+            ::core::ptr::null()
+        }
+    };
+    let vmstate_subsections = if let Some(subsections) = vmstate_subsections {
+        quote! {
+            #subsections
+        }
+    } else {
+        quote! {
+            ::core::ptr::null()
+        }
+    };
+
+    let vmstate_description = quote! {
+        #[used]
+        #[allow(non_upper_case_globals)]
+        pub static #vmstate_description_ident: ::qemu_api::bindings::VMStateDescription = ::qemu_api::bindings::VMStateDescription {
+            name: if let Some(name) = #migrateable_fish::NAME {
+                name.as_ptr()
+            } else {
+                <#name as ::qemu_api::objects::ObjectImplUnsafe>::TYPE_INFO.name
+            },
+            unmigratable: #migrateable_fish::UNMIGRATABLE,
+            early_setup: #migrateable_fish::EARLY_SETUP,
+            version_id: #migrateable_fish::VERSION_ID,
+            minimum_version_id: #migrateable_fish::MINIMUM_VERSION_ID,
+            priority: #migrateable_fish::PRIORITY,
+            pre_load: Some(#pre_load),
+            post_load: Some(#post_load),
+            pre_save: Some(#pre_save),
+            post_save: Some(#post_save),
+            needed: Some(#needed),
+            dev_unplug_pending: Some(#dev_unplug_pending),
+            fields: #vmstate_fields,
+            subsections: #vmstate_subsections,
+        };
+
+        #[no_mangle]
+        pub unsafe extern "C" fn #pre_load(opaque: *mut ::core::ffi::c_void) -> ::core::ffi::c_int {
+            let mut instance = NonNull::new(opaque.cast::<#name>()).expect(concat!("Expected opaque to be a non-null pointer of type ", stringify!(#name), "::Object"));
+            unsafe {
+                ::qemu_api::objects::Migrateable::pre_load(instance.as_mut())
+            }
+        }
+        #[no_mangle]
+        pub unsafe extern "C" fn #post_load(opaque: *mut ::core::ffi::c_void, version_id: core::ffi::c_int) -> ::core::ffi::c_int {
+            let mut instance = NonNull::new(opaque.cast::<#name>()).expect(concat!("Expected opaque to be a non-null pointer of type ", stringify!(#name), "::Object"));
+            unsafe {
+                ::qemu_api::objects::Migrateable::post_load(instance.as_mut(), version_id)
+            }
+        }
+        #[no_mangle]
+        pub unsafe extern "C" fn #pre_save(opaque: *mut ::core::ffi::c_void) -> ::core::ffi::c_int {
+            let mut instance = NonNull::new(opaque.cast::<#name>()).expect(concat!("Expected opaque to be a non-null pointer of type ", stringify!(#name), "::Object"));
+            unsafe {
+                ::qemu_api::objects::Migrateable::pre_save(instance.as_mut())
+            }
+        }
+        #[no_mangle]
+        pub unsafe extern "C" fn #post_save(opaque: *mut ::core::ffi::c_void) -> ::core::ffi::c_int {
+            let mut instance = NonNull::new(opaque.cast::<#name>()).expect(concat!("Expected opaque to be a non-null pointer of type ", stringify!(#name), "::Object"));
+            unsafe {
+                ::qemu_api::objects::Migrateable::post_save(instance.as_mut())
+            }
+        }
+        #[no_mangle]
+        pub unsafe extern "C" fn #needed(opaque: *mut ::core::ffi::c_void) -> bool {
+            let mut instance = NonNull::new(opaque.cast::<#name>()).expect(concat!("Expected opaque to be a non-null pointer of type ", stringify!(#name), "::Object"));
+            unsafe {
+                ::qemu_api::objects::Migrateable::needed(instance.as_mut())
+            }
+        }
+        #[no_mangle]
+        pub unsafe extern "C" fn #dev_unplug_pending(opaque: *mut ::core::ffi::c_void) -> bool {
+            let mut instance = NonNull::new(opaque.cast::<#name>()).expect(concat!("Expected opaque to be a non-null pointer of type ", stringify!(#name), "::Object"));
+            unsafe {
+                ::qemu_api::objects::Migrateable::dev_unplug_pending(instance.as_mut())
+            }
+        }
+    };
+
+    let expanded = quote! {
+        #vmstate_description
+    };
+    (vmstate_description_ident, expanded)
+}
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 0bd70b59afcc005251135802897954789b068e6e..11984abb878bef18be3c819f61da24ce1405ea59 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -4,6 +4,7 @@ _qemu_api_rs = static_library(
     [
       'src/lib.rs',
       'src/objects.rs',
+      'src/vmstate.rs',
     ],
     {'.' : bindings_rs},
   ),
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index b94adc15288cdc62de7679988f549ebd80f895d7..d276adfb6622eee6e42494e089e1f20b0b5cdf08 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -26,8 +26,11 @@ unsafe impl Send for bindings::Property {}
 unsafe impl Sync for bindings::Property {}
 unsafe impl Sync for bindings::TypeInfo {}
 unsafe impl Sync for bindings::VMStateDescription {}
+unsafe impl Sync for bindings::VMStateField {}
+unsafe impl Sync for bindings::VMStateInfo {}
 
 pub mod objects;
+pub mod vmstate;
 
 use std::alloc::{GlobalAlloc, Layout};
 
diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
new file mode 100644
index 0000000000000000000000000000000000000000..4478febc9ac2768cca3e638ebae27b042edb1bf2
--- /dev/null
+++ b/rust/qemu-api/src/vmstate.rs
@@ -0,0 +1,403 @@
+// Copyright 2024, Linaro Limited
+// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+//! Helper macros to declare migration state for device models.
+//!
+//! Some macros are direct equivalents to the C macros declared in `include/migration/vmstate.h`
+//! while [`vmstate_description`], [`vmstate_subsections`] and [`vmstate_fields`] are meant to be
+//! used when declaring a device model state struct with the [`Device`](qemu_api_macros::Device)
+//! `Derive` macro.
+
+#[doc(alias = "VMSTATE_UNUSED_BUFFER")]
+#[macro_export]
+macro_rules! vmstate_unused_buffer {
+    ($field_exists_fn:expr, $version_id:expr, $size:expr) => {{
+        $crate::bindings::VMStateField {
+            name: c"unused".as_ptr(),
+            err_hint: ::core::ptr::null(),
+            offset: 0,
+            size: $size,
+            start: 0,
+            num: 0,
+            num_offset: 0,
+            size_offset: 0,
+            info: unsafe { ::core::ptr::addr_of!($crate::bindings::vmstate_info_unused_buffer) },
+            flags: VMStateFlags::VMS_BUFFER,
+            vmsd: ::core::ptr::null(),
+            version_id: $version_id,
+            struct_version_id: 0,
+            field_exists: $field_exists_fn,
+        }
+    }};
+}
+
+#[doc(alias = "VMSTATE_UNUSED_V")]
+#[macro_export]
+macro_rules! vmstate_unused_v {
+    ($version_id:expr, $size:expr) => {{
+        $crate::vmstate_unused_buffer!(None, $version_id, $size)
+    }};
+}
+
+#[doc(alias = "VMSTATE_UNUSED")]
+#[macro_export]
+macro_rules! vmstate_unused {
+    ($size:expr) => {{
+        $crate::vmstate_unused_v!(0, $size)
+    }};
+}
+
+#[doc(alias = "VMSTATE_SINGLE_TEST")]
+#[macro_export]
+macro_rules! vmstate_single_test {
+    ($field_name:ident, $struct_name:ty, $field_exists_fn:expr, $version_id:expr, $info:block, $size:expr) => {{
+        $crate::bindings::VMStateField {
+            name: ::core::concat!(::core::stringify!($field_name), 0)
+                .as_bytes()
+                .as_ptr() as *const ::core::ffi::c_char,
+            err_hint: ::core::ptr::null(),
+            offset: ::core::mem::offset_of!($struct_name, $field_name) as _,
+            size: $size,
+            start: 0,
+            num: 0,
+            num_offset: 0,
+            size_offset: 0,
+            info: $info,
+            flags: VMStateFlags::VMS_SINGLE,
+            vmsd: ::core::ptr::null(),
+            version_id: $version_id,
+            struct_version_id: 0,
+            field_exists: $field_exists_fn,
+        }
+    }};
+}
+
+#[doc(alias = "VMSTATE_SINGLE")]
+#[macro_export]
+macro_rules! vmstate_single {
+    ($field_name:ident, $struct_name:ty, $version_id:expr, $info:block, $size:expr) => {{
+        $crate::vmstate_single_test!($field_name, $struct_name, None, $version_id, $info, $size)
+    }};
+}
+
+#[doc(alias = "VMSTATE_UINT32_V")]
+#[macro_export]
+macro_rules! vmstate_uint32_v {
+    ($field_name:ident, $struct_name:ty, $version_id:expr) => {{
+        $crate::vmstate_single!(
+            $field_name,
+            $struct_name,
+            $version_id,
+            { unsafe { ::core::ptr::addr_of!($crate::bindings::vmstate_info_uint32) } },
+            u32::BITS as u64
+        )
+    }};
+}
+
+#[doc(alias = "VMSTATE_UINT32")]
+#[macro_export]
+macro_rules! vmstate_uint32 {
+    ($field_name:ident, $struct_name:ty) => {{
+        $crate::vmstate_uint32_v!($field_name, $struct_name, 0)
+    }};
+}
+
+#[doc(alias = "VMSTATE_INT32_V")]
+#[macro_export]
+macro_rules! vmstate_int32_v {
+    ($field_name:ident, $struct_name:ty, $version_id:expr) => {{
+        $crate::vmstate_single!(
+            $field_name,
+            $struct_name,
+            $version_id,
+            { unsafe { ::core::ptr::addr_of!($crate::bindings::vmstate_info_int32) } },
+            i32::BITS as u64
+        )
+    }};
+}
+
+#[doc(alias = "VMSTATE_INT32")]
+#[macro_export]
+macro_rules! vmstate_int32 {
+    ($field_name:ident, $struct_name:ty) => {{
+        $crate::vmstate_int32_v!($field_name, $struct_name, 0)
+    }};
+}
+
+#[doc(alias = "VMSTATE_ARRAY")]
+#[macro_export]
+macro_rules! vmstate_array {
+    ($field_name:ident, $struct_name:ty, $length:expr, $version_id:expr, $info:block, $size:expr) => {{
+        $crate::bindings::VMStateField {
+            name: ::core::concat!(::core::stringify!($field_name), 0)
+                .as_bytes()
+                .as_ptr() as *const ::core::ffi::c_char,
+            err_hint: ::core::ptr::null(),
+            offset: ::core::mem::offset_of!($struct_name, $field_name) as _,
+            size: $size,
+            start: 0,
+            num: $length as _,
+            num_offset: 0,
+            size_offset: 0,
+            info: $info,
+            flags: VMStateFlags::VMS_ARRAY,
+            vmsd: ::core::ptr::null(),
+            version_id: $version_id,
+            struct_version_id: 0,
+            field_exists: None,
+        }
+    }};
+}
+
+#[doc(alias = "VMSTATE_UINT32_ARRAY_V")]
+#[macro_export]
+macro_rules! vmstate_uint32_array_v {
+    ($field_name:ident, $struct_name:ty, $length:expr, $version_id:expr) => {{
+        $crate::vmstate_array!(
+            $field_name,
+            $struct_name,
+            $length,
+            $version_id,
+            { unsafe { ::core::ptr::addr_of!($crate::bindings::vmstate_info_uint32) } },
+            u32::BITS as u64
+        )
+    }};
+}
+
+#[doc(alias = "VMSTATE_UINT32_ARRAY")]
+#[macro_export]
+macro_rules! vmstate_uint32_array {
+    ($field_name:ident, $struct_name:ty, $length:expr) => {{
+        $crate::vmstate_uint32_array_v!($field_name, $struct_name, $length, 0)
+    }};
+}
+
+#[doc(alias = "VMSTATE_STRUCT_POINTER_V")]
+#[macro_export]
+macro_rules! vmstate_struct_pointer_v {
+    ($field_name:ident, $struct_name:ty, $version_id:expr, $vmsd:expr, $type:ty) => {{
+        $crate::bindings::VMStateField {
+            name: ::core::concat!(::core::stringify!($field_name), 0)
+                .as_bytes()
+                .as_ptr() as *const ::core::ffi::c_char,
+            err_hint: ::core::ptr::null(),
+            offset: ::core::mem::offset_of!($struct_name, $field_name) as _,
+            size: ::core::mem::size_of::<*const $type>() as _,
+            start: 0,
+            num: 0,
+            num_offset: 0,
+            size_offset: 0,
+            info: ::core::ptr::null(),
+            flags: VMStateFlags(VMStateFlags::VMS_STRUCT.0 | VMStateFlags::VMS_POINTER.0),
+            vmsd: $vmsd,
+            version_id: $version_id,
+            struct_version_id: 0,
+            field_exists: None,
+        }
+    }};
+}
+
+#[doc(alias = "VMSTATE_ARRAY_OF_POINTER")]
+#[macro_export]
+macro_rules! vmstate_array_of_pointer {
+    ($field_name:ident, $struct_name:ty, $num:expr, $version_id:expr, $info:expr, $type:ty) => {{
+        $crate::bindings::VMStateField {
+            name: ::core::concat!(::core::stringify!($field_name), 0)
+                .as_bytes()
+                .as_ptr() as *const ::core::ffi::c_char,
+            version_id: $version_id,
+            num: $num,
+            info: $info,
+            size: ::core::mem::size_of::<*const $type>() as _,
+            flags: VMStateFlags(VMStateFlags::VMS_ARRAY.0 | VMStateFlags::VMS_ARRAY_OF_POINTER.0),
+            offset: ::core::mem::offset_of!($struct_name, $field_name) as _,
+            err_hint: ::core::ptr::null(),
+            start: 0,
+            num_offset: 0,
+            size_offset: 0,
+            vmsd: ::core::ptr::null(),
+            struct_version_id: 0,
+            field_exists: None,
+        }
+    }};
+}
+
+#[doc(alias = "VMSTATE_ARRAY_OF_POINTER_TO_STRUCT")]
+#[macro_export]
+macro_rules! vmstate_array_of_pointer_to_struct {
+    ($field_name:ident, $struct_name:ty, $num:expr, $version_id:expr, $vmsd:expr, $type:ty) => {{
+        $crate::bindings::VMStateField {
+            name: ::core::concat!(::core::stringify!($field_name), 0)
+                .as_bytes()
+                .as_ptr() as *const ::core::ffi::c_char,
+            version_id: $version_id,
+            num: $num,
+            vmsd: $vmsd,
+            size: ::core::mem::size_of::<*const $type>() as _,
+            flags: VMStateFlags(
+                VMStateFlags::VMS_ARRAY.0
+                    | VMStateFlags::VMS_STRUCT.0
+                    | VMStateFlags::VMS_ARRAY_OF_POINTER.0,
+            ),
+            offset: ::core::mem::offset_of!($struct_name, $field_name) as _,
+            err_hint: ::core::ptr::null(),
+            start: 0,
+            num_offset: 0,
+            size_offset: 0,
+            vmsd: ::core::ptr::null(),
+            struct_version_id: 0,
+            field_exists: None,
+        }
+    }};
+}
+
+#[doc(alias = "VMSTATE_CLOCK_V")]
+#[macro_export]
+macro_rules! vmstate_clock_v {
+    ($field_name:ident, $struct_name:ty, $version_id:expr) => {{
+        $crate::vmstate_struct_pointer_v!(
+            $field_name,
+            $struct_name,
+            $version_id,
+            { unsafe { ::core::ptr::addr_of!($crate::bindings::vmstate_clock) } },
+            $crate::bindings::Clock
+        )
+    }};
+}
+
+#[doc(alias = "VMSTATE_CLOCK")]
+#[macro_export]
+macro_rules! vmstate_clock {
+    ($field_name:ident, $struct_name:ty) => {{
+        $crate::vmstate_clock_v!($field_name, $struct_name, 0)
+    }};
+}
+
+#[doc(alias = "VMSTATE_ARRAY_CLOCK_V")]
+#[macro_export]
+macro_rules! vmstate_array_clock_v {
+    ($field_name:ident, $struct_name:ty, $num:expr, $version_id:expr) => {{
+        $crate::vmstate_array_of_pointer_to_struct!(
+            $field_name,
+            $struct_name,
+            $num,
+            $version_id,
+            { unsafe { ::core::ptr::addr_of!($crate::bindings::vmstate_clock) } },
+            $crate::bindings::Clock
+        )
+    }};
+}
+
+#[doc(alias = "VMSTATE_ARRAY_CLOCK")]
+#[macro_export]
+macro_rules! vmstate_array_clock {
+    ($field_name:ident, $struct_name:ty, $num:expr) => {{
+        $crate::vmstate_array_clock_v!($field_name, $struct_name, $name, 0)
+    }};
+}
+
+/// Helper macro to declare a list of
+/// ([`VMStateField`](`crate::bindings::VMStateField`)) into a static and return a
+/// pointer to the array of values it created.
+#[macro_export]
+macro_rules! vmstate_fields {
+    ($($field:expr),*$(,)*) => {{
+        #[used]
+        static _FIELDS: &[$crate::bindings::VMStateField] = &[
+            $($field),*,
+            $crate::bindings::VMStateField {
+                name: ::core::ptr::null(),
+                err_hint: ::core::ptr::null(),
+                offset: 0,
+                size: 0,
+                start: 0,
+                num: 0,
+                num_offset: 0,
+                size_offset: 0,
+                info: ::core::ptr::null(),
+                flags: VMStateFlags::VMS_END,
+                vmsd: ::core::ptr::null(),
+                version_id: 0,
+                struct_version_id: 0,
+                field_exists: None,
+            }
+        ];
+        _FIELDS.as_ptr()
+    }}
+}
+
+/// A transparent wrapper type for the `subsections` field of
+/// [`VMStateDescription`](crate::bindings::VMStateDescription).
+///
+/// This is necessary to be able to declare subsection descriptions as statics, because the only
+/// way to implement `Sync` for a foreign type (and `*const` pointers are foreign types in Rust) is
+/// to create a wrapper struct and `unsafe impl Sync` for it.
+///
+/// This struct is used in the [`vmstate_subsections`] macro implementation.
+#[repr(transparent)]
+pub struct VMStateSubsectionsWrapper(pub &'static [*const crate::bindings::VMStateDescription]);
+
+unsafe impl Sync for VMStateSubsectionsWrapper {}
+
+/// Helper macro to declare a list of subsections
+/// ([`VMStateDescription`](`crate::bindings::VMStateDescription`)) into a static and return a
+/// pointer to the array of pointers it created.
+#[macro_export]
+macro_rules! vmstate_subsections {
+    ($($subsection:expr),*$(,)*) => {{
+        #[used]
+        static _SUBSECTIONS: $crate::vmstate::VMStateSubsectionsWrapper = $crate::vmstate::VMStateSubsectionsWrapper(&[
+            $({
+                #[used]
+                static _SUBSECTION: $crate::bindings::VMStateDescription = $subsection;
+                ::core::ptr::addr_of!(_SUBSECTION)
+            }),*,
+            ::core::ptr::null()
+        ]);
+        _SUBSECTIONS.0.as_ptr()
+    }}
+}
+
+/// Thin macro to declare a valid [`VMStateDescription`](`crate::bindings::VMStateDescription`)
+/// static.
+#[macro_export]
+macro_rules! vmstate_description {
+    ($(#[$outer:meta])*
+     pub static $name:ident: VMStateDescription = VMStateDescription {
+         name: $vname:expr,
+         unmigratable: $um_val:expr,
+         early_setup: $early_setup:expr,
+         version_id: $version_id:expr,
+         minimum_version_id: $minimum_version_id:expr,
+         priority: $priority:expr,
+         pre_load: $pre_load_fn:expr,
+         post_load: $post_load_fn:expr,
+         pre_save: $pre_save_fn:expr,
+         post_save: $post_save_fn:expr,
+         needed: $needed_fn:expr,
+         dev_unplug_pending: $dev_unplug_pending_fn:expr,
+         fields: $fields:expr,
+         subsections: $subsections:expr$(,)*
+     };
+    ) => {
+        #[used]
+        $(#[$outer])*
+            pub static $name: $crate::bindings::VMStateDescription = $crate::bindings::VMStateDescription {
+                name: ::core::ffi::CStr::as_ptr($vname),
+                unmigratable: $um_val,
+                early_setup: $early_setup,
+                version_id: $version_id,
+                minimum_version_id: $minimum_version_id,
+                priority: $priority,
+                pre_load: None,
+                post_load: None,
+                pre_save: None,
+                post_save: None,
+                needed: None,
+                dev_unplug_pending: None,
+                fields: $fields,
+                subsections: $subsections,
+            };
+    }
+}

-- 
2.45.2


