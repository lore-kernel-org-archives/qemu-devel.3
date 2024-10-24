Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CA40CE8E7A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 14:05:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3yRY-0007CT-2e; Thu, 24 Oct 2024 10:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t3yRR-0007A2-3v
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 10:04:01 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t3yRP-0003xn-4I
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 10:03:56 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5c9454f3bfaso1106930a12.2
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 07:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729778634; x=1730383434; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=P6v2Co+JCkBUSGoUJI3FUDr2BSiZdpBcLeYpZLITdCA=;
 b=QU7pUCNu5hr7fssiGl3qik1gmMhMfEQb39Vq7TK9G+cUq2o3gktZ3JK3AB6xDiBeQk
 7zKAoJ0+mbVkkQiZHDHPNi0jzJtlZcofXr/QR/aZFTSUzWxWgL8YTIEOtKN5/VnJpa6y
 EaD8V9OOe5dEsLjo5id/xugCjwVgXSkcNjWHclYNzWGkLi5+swLeBAzSPkz2tH9YWdhQ
 go/n2pjZOWYUoXmqynEz+EXv428VWdew1+QLKgFS+xYuL1J66ntxkW/4kiwjS1FXUHD1
 rsGtepe2ZP5afyLL1CMpGj1pDg73MSKZuAVvBY2T4REDTGFcdDRB4j4G7ynFz45tlfGz
 lbsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729778634; x=1730383434;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P6v2Co+JCkBUSGoUJI3FUDr2BSiZdpBcLeYpZLITdCA=;
 b=nYqbevQV4OCR1FjTwkMXeww/F8WaPl9+g7aIrEI+6TQooDp+hbcBQMlL4IADf2nKuo
 YXJZj3klDIruapv+m1IztprGhvOi5ovVdsaes7PwxmWherRVI2d6578oYPquQGcd/PVH
 YVbViryWBRuRNzgNpNaM8FVasM1EecSRdqK1VKh8WuqxbsarSVu8TsDOSoVfuZlGhohV
 8Iw/nTZqs61fMnILu/nbzC6KQYZbavBi6sKpO7h5FWZ4Oji73JIEWtXMo48fzpVn8SwJ
 1mr0+NDhlFr6//makfXtvdT9rWYOmxrPyeiwQ33zE7IeoA/Bta5SS0DNw5Da7zoVbnIL
 Cv+Q==
X-Gm-Message-State: AOJu0YyTLXtRR9vNG9sDgChwRN0FyzrbZJFWp2w6//f+r6sjRxdjcf2q
 /2G7YDBwoVuFJWM5Fi8Ui3ErLnJiSXkEz9lEgpc2gTfjUY8Hmdwq35+1znGye7w=
X-Google-Smtp-Source: AGHT+IFRnERUtukvp4G+Z711fIrDuHFwABPP3sJHPHNJiv+AZCggeRVFxL2S2nuDQr/qf9n6x43Xcg==
X-Received: by 2002:a17:906:f590:b0:a99:f750:bf79 with SMTP id
 a640c23a62f3a-a9abf8aefa7mr629785366b.34.1729778631898; 
 Thu, 24 Oct 2024 07:03:51 -0700 (PDT)
Received: from [127.0.1.1] (adsl-113.37.6.2.tellas.gr. [37.6.2.113])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a912f6878sm621407566b.86.2024.10.24.07.03.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 07:03:51 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 24 Oct 2024 17:03:08 +0300
Subject: [PATCH 10/11] rust/qemu-api: add log module
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241024-rust-round-2-v1-10-051e7a25b978@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7789;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=PnKwn5RfvPLyaFLPXzkFaOcLVrtk0owxj+F4Pzht9MM=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm5HbE9qTndYdUxYWVhLSk5CcllMalZEVFkxTXY2Ck5SU2pIOGhkRzdFMktXZTQ4
 bG1KQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKWnhwVG93QUt
 DUkIzS2Nkd2YzNEowQnJaRUFDUHdvSVAwMnNqc3RtdXQ4NjJCVFdLM21rYXNPdlVyM0tRaWpJWg
 pmWkRCOWh5bFBUa1lGTVpFdGFPaU11K1I2VlhEMnU3b05wV1NQWVpKWmJUUzFqQmRDVk9mYmhvb
 2xha3kyTExKClI2ZHNtbWJ4Rm8rZlkydjMyamNCSkQzd1pvREIzemMvWGRMY0V5ZmNEUGZTaGZU
 ckg2cFlYUHNJZURnOGZJS0oKUEw0ZzNIdlBCKzlkT2JtdUhsTUlmU2tWZ3VGQ3RORXRXYU52UVA
 wbTNpdmdYR2E0OXAybHJRaTB1WkRGK01iMApDQzBhSUtXbU5QMEptbENwNlFVMXp1bGdBdDFFYj
 N5dE1id0RFcUxWbmpicml0QVkvVkl1eTFQSHJreGQxRkFVCmNpOFlmVC9qY2ZWQXpBNFRoYkZMT
 k91b3pydUg0a1RtcDZ0dFYwSVY0ZEZhYXBLZmFiQTY3VTVCWU9Tdmd4aFgKUkpYS3hVQ3QvdDJo
 S2ovTkFFeXloZzlESDVDSENjRGJKRlNCQldyblZoUVZaY2pqcjZURVdKeVpNM2ZDUmlHMwpKbnZ
 HampjUGEwbklFVUNDMk5KWGVjVFVMVlNUamdBYU9WZFpRblJtNjhRM3B6bHp0SHl1UXkyTnh1eD
 J1SFpmCjhNTGFqV2xTcUVFUG9XKzFtUEtSWVg0RmtocTJXR1h5UTVUMlVvRkVHYVorb1FPYmpMa
 Ud4L3owVVQvZC9MeEcKV1crUmN1NmtQYlhsaDA2d3dDVFJLcGpyUjErRFU2WldFZ1ZWNUhUbThk
 RTRkRVVQVmRHVWthU2JKemJ4QTFFegpKTDNvTlR3ckhCMURLTFVMcTE2NXlzVE1talI2NG5HOFh
 HbE5GaUMwRmdWVk5JQStvS25QUGpMZFlNeEpTMmpqCkZKV25NUT09Cj1ab2VQCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52e.google.com
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

Logging in QEMU is done by function-like C macros, which we cannot use
directly from Rust with bindgen.

This commit adds a new qemu_api module, `log`, that provides the
following interfaces:

- a `LogMask` enum type that uses the mask values from the generated
  bindings, and makes sure the rust enum variant names and values will
  match.
- `LogMask` aliases `LogMask::GUEST_ERROR` and `LogMask::UNIMPLEMENTED`
  for convenience.
- a private qemu_loglevel_mask() function, counterpart of
  `qemu_loglevel_mask` in `include/qemu/log-for-trace.h`, which we
  cannot use from bindgen since it's a static inline item.
- public qemu_log(), qemu_log_mask() and qemu_log_mask_and_addr()
  functions that should act like the C equivalent:

  pub fn qemu_log_mask_and_addr(log_mask: LogMask, address: u64, str: &str);
  pub fn qemu_log_mask(log_mask: LogMask, str: &str);
  pub fn qemu_log(str: &str);

  It takes a 'static or allocated string slice as argument, but in the
  feature we will introduce better log macros in Rust that make use of
  Rust's format arguments. This is not really a bad compromise since
  generating a log item is not a hot path so allocating here is fine.

Example usage will be:

```rust
qemu_log_mask(LogMask::GUEST_ERROR, "device XYZ failed spectacularly");

qemu_log_mask(
 LogMask::UNIMPLEMENTED,
 &format!(
   "We haven't implemented this feature in {file}:{line} out of pure laziness.",
   file = file!(),
   line = line!()
 )
);
```

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 rust/wrapper.h            |   1 +
 rust/qemu-api/meson.build |   1 +
 rust/qemu-api/src/lib.rs  |   1 +
 rust/qemu-api/src/log.rs  | 140 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 143 insertions(+)

diff --git a/rust/wrapper.h b/rust/wrapper.h
index 77e40213efb686d23f6b768b78602e4337623280..8f76ef26f111d5e1f308268f445696acc7ddbfef 100644
--- a/rust/wrapper.h
+++ b/rust/wrapper.h
@@ -32,6 +32,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/module.h"
+#include "qemu/log.h"
 #include "qemu-io.h"
 #include "sysemu/sysemu.h"
 #include "hw/sysbus.h"
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 11984abb878bef18be3c819f61da24ce1405ea59..a82ff0d39a2263d15bda312aa0a2d46c77b2501f 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -3,6 +3,7 @@ _qemu_api_rs = static_library(
   structured_sources(
     [
       'src/lib.rs',
+      'src/log.rs',
       'src/objects.rs',
       'src/vmstate.rs',
     ],
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index d276adfb6622eee6e42494e089e1f20b0b5cdf08..c3eb464f66361ee2349e636c49e38d3a6b57ad97 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -29,6 +29,7 @@ unsafe impl Sync for bindings::VMStateDescription {}
 unsafe impl Sync for bindings::VMStateField {}
 unsafe impl Sync for bindings::VMStateInfo {}
 
+pub mod log;
 pub mod objects;
 pub mod vmstate;
 
diff --git a/rust/qemu-api/src/log.rs b/rust/qemu-api/src/log.rs
new file mode 100644
index 0000000000000000000000000000000000000000..50525ac6b7f49786c2975843b7dc70b91c18d5a0
--- /dev/null
+++ b/rust/qemu-api/src/log.rs
@@ -0,0 +1,140 @@
+// Copyright 2024, Linaro Limited
+// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+//! Logging functionality.
+//!
+//! This module provides:
+//!
+//! - a [`LogMask`] enum type that uses the mask values from the generated
+//!   bindings, and makes sures the rust enum variant names and values will
+//!   match.
+//! - [`LogMask`] aliases [`LogMask::GUEST_ERROR`] and [`LogMask::UNIMPLEMENTED`]
+//!   for convenience.
+//! - a private `qemu_loglevel_mask()` function, counterpart of
+//!   `qemu_loglevel_mask` in `include/qemu/log-for-trace.h`, which we
+//!   cannot use from bindgen since it's a `static inline` item.
+//! - public [`qemu_log`], [`qemu_log_mask`] and [`qemu_log_mask_and_addr`] functions that act like
+//!   the C equivalents.
+//!
+//! # Examples
+//!
+//! ```rust
+//! # use qemu_api::log::*;
+//! # fn main() {
+//! qemu_log_mask(LogMask::GUEST_ERROR, "device XYZ failed spectacularly");
+//!
+//! qemu_log_mask(
+//!  LogMask::UNIMPLEMENTED,
+//!  &format!(
+//!    "We haven't implemented this feature in {file}:{line} out of pure laziness.",
+//!    file = file!(),
+//!    line = line!()
+//!  )
+//! );
+//! # }
+//! ```
+
+use crate::bindings;
+
+macro_rules! mask_variants {
+    ($(#[$outer:meta])*
+     pub enum $name:ident {
+         $(
+             $(#[$attrs:meta])*
+             $symbol:ident
+         ),*$(,)*
+     }) => {
+        $(#[$outer])*
+            pub enum $name {
+                $(
+                    $(#[$attrs])*
+                    $symbol = bindings::$symbol
+                ),*
+            }
+    };
+}
+
+mask_variants! {
+    /// A wrapper type for the various log mask `#defines` in the C code base.
+    #[allow(non_camel_case_types)]
+    #[derive(Copy, Clone, Eq, PartialEq, Debug)]
+    #[repr(u32)]
+    pub enum LogMask {
+        CPU_LOG_TB_OUT_ASM,
+        CPU_LOG_TB_IN_ASM,
+        CPU_LOG_TB_OP,
+        CPU_LOG_TB_OP_OPT,
+        CPU_LOG_INT,
+        CPU_LOG_EXEC,
+        CPU_LOG_PCALL,
+        CPU_LOG_TB_CPU,
+        CPU_LOG_RESET,
+        LOG_UNIMP,
+        LOG_GUEST_ERROR,
+        CPU_LOG_MMU,
+        CPU_LOG_TB_NOCHAIN,
+        CPU_LOG_PAGE,
+        LOG_TRACE,
+        CPU_LOG_TB_OP_IND,
+        CPU_LOG_TB_FPU,
+        CPU_LOG_PLUGIN,
+        /// For user-mode strace logging.
+        LOG_STRACE,
+        LOG_PER_THREAD,
+        CPU_LOG_TB_VPU,
+        LOG_TB_OP_PLUGIN,
+    }
+}
+
+impl LogMask {
+    /// Alias.
+    pub const GUEST_ERROR: Self = LogMask::LOG_GUEST_ERROR;
+    /// Alias.
+    pub const UNIMPLEMENTED: Self = LogMask::LOG_UNIMP;
+}
+
+/// Returns `true` if a bit is set in the current loglevel mask.
+///
+/// Counterpart of `qemu_loglevel_mask` in `include/qemu/log-for-trace.h`.
+fn qemu_loglevel_mask(mask: LogMask) -> bool {
+    // SAFETY: This is an internal global variable. We only read from it and reading invalid values
+    // is not a concern here.
+    let current_level = unsafe { bindings::qemu_loglevel };
+    let mask = mask as ::core::ffi::c_int;
+
+    (current_level & mask) != 0
+}
+
+/// Log a message in QEMU's log, given a specific log mask.
+pub fn qemu_log_mask(log_mask: LogMask, str: &str) {
+    if qemu_loglevel_mask(log_mask) {
+        qemu_log(str);
+    }
+}
+
+/// Log a message in QEMU's log only if a bit is set on the current loglevel mask and we are in the
+/// address range we care about.
+pub fn qemu_log_mask_and_addr(log_mask: LogMask, address: u64, str: &str) {
+    if qemu_loglevel_mask(log_mask) && {
+        // SAFETY: This function reads global variables/system state but an error here is not a
+        // concern.
+        unsafe { bindings::qemu_log_in_addr_range(address) }
+    } {
+        qemu_log(str);
+    }
+}
+
+/// Log a message in QEMU's log, without a log mask.
+pub fn qemu_log(str: &str) {
+    let Ok(cstr) = ::std::ffi::CString::new(str) else {
+        panic!(
+            "qemu_log_mask: Converting passed string {:?} to CString failed.",
+            str
+        );
+    };
+    // SAFETY: We're passing two valid CStr pointers. The second argument for the variadic
+    // `qemu_log` function must be a `*const c_char` since the format specifier is `%s`.
+    // Therefore this is a safe call.
+    unsafe { bindings::qemu_log(c"%s\n".as_ptr(), cstr.as_ptr()) };
+}

-- 
2.45.2


