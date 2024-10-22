Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E74D9D1CDD5
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 10:55:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3CXR-00010i-Mr; Tue, 22 Oct 2024 06:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t3CXQ-00010Y-2O
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:54:56 -0400
Received: from mail-me3aus01olkn2080a.outbound.protection.outlook.com
 ([2a01:111:f403:2818::80a]
 helo=AUS01-ME3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t3CXN-0001e1-1t
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:54:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aXpnjZStTD0s+RVMDuCgL09YuF5vonLp3lJ9y04PQPB+5Dg/gunukzSdaON3dZIeVfqjCargtf5pKnjQLHZg9dLh1ZuHQGLhlJ2upIGtB/cPpXXL5qWu5T62zCDoGNvRln1iL7mcE3Fev4w4ue5n3abWSmh/E0CTYDdusY6ziOlL/ruKzqctcLWZPzJtQan0RkVOY+CKFUCtHUAmjJgB2hpX+8pv27MQsO3bRsZ4g0U1zTaNIlMSTmBYHqFinGcFQzFwlWFk2Z5F5R2jukQemSsZMX40WIMpaJcJ4Qtxc7cDcywbe1YfckcwgZWBU1WLvYOl23eKD+1l+XkoPn05BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qBztsi0F2AEoaGwG4I0peu+IVtUKc7hW/73qq23EJ/4=;
 b=BULnHiA3K9t906k8J/8d9KdL8f/DGk+/XKaBNWqPWxI7Q2GVzAmi9evhWkE8P66E9JfaxEqGF5UaKkUChCqi6b9w9xbCrCJwKNwgviD6iB0s9aRagXQKiuEYGk5ee3TkwuLJ97498c3w/fqvzM4n57e1ZQ0H+JDoh9pevThIgNJvIaH5JSjnjTpAoZEYn8tgc2k6ij/4jMT/vDl2k8+bpekoQqIhZH1zzDEFJElUvFoCjY4n68rr/t598ndXp3GjGJnuEFQxPfAA/VqSOfQELl17vlshjjutjugl6/mR9Z97Xg40rqjwCkPVCwiUJpcFmyVhFU6BDguBanu3PA/scw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBztsi0F2AEoaGwG4I0peu+IVtUKc7hW/73qq23EJ/4=;
 b=E8qEv1JYBgrWc0w627kQSQwQrZvsvkhO5FQyItBeXLaTLLnxiTMhP+UKubQjeIJr96P5AYpF3xGRtULsYcN339GCIS21ndYD/qle8bIp3duux8xBHBX6GwAiYDZ0OD7U5cYhJQJUKaB7yfg6ooTLM6XbS+tnw8flrIpFg23CNFd+PTPFcdTVH1c2oZWryF2Wwq57uyjxdRD8HgUNvAk53jlRDXaZXe6GmSB6349MPXV25qvJdmK1DosXrfDSa/aZuh9P13qdNHPRn8NLQA2efzYCQ2WGDWWlEBpgOpeH2A3usPBmUlH9pqG9v4q9ZIVzIN3Rou8VMgNXKePGUmH7tw==
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:282::22)
 by ME0P300MB0620.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:231::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Tue, 22 Oct
 2024 10:54:46 +0000
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd]) by SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd%2]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 10:54:45 +0000
From: Junjie Mao <junjie.mao@hotmail.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
	Junjie Mao <junjie.mao@hotmail.com>
Subject: [PATCH v2] rust: introduce alternative implementation of offset_of!
Date: Tue, 22 Oct 2024 18:54:28 +0800
Message-ID: <SY0P300MB10265AA07B530BB674A6D1C6954C2@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KL1PR01CA0125.apcprd01.prod.exchangelabs.com
 (2603:1096:820:4::17) To SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:282::22)
X-Microsoft-Original-Message-ID: <20241022105428.30628-1-junjie.mao@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB1026:EE_|ME0P300MB0620:EE_
X-MS-Office365-Filtering-Correlation-Id: 376456b8-d0e5-4d1e-ff13-08dcf287f0c5
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|5072599009|19110799003|5062599005|461199028|8060799006|7092599003|15080799006|10035399004|56899033|440099028|3412199025|4302099013|1602099012|1710799026;
X-Microsoft-Antispam-Message-Info: QqUBNif9yrETZzZLTPXpTlA9IGnOWrC+zjLiBtP5SGGbDafwmeTw76DRKL7PQ9vDaE1KrvlhlQbRMK7LNRVqoy3a0pUsjRg/9f4UCN1PHURdjBus81RiTgjK869U6qOb2vU0iKh6ujy0VrpS7NYBealZXFdENInBhZBDSaw51AZd2i4xErGxNzUhRxITmx/8CuYydL57Ib0mWfiDBSOw8Ed6swGZNaEm7CTeTmzYYzUAwgl3Oh19cTu87MS4UkRuqTsY7GaoMJOhNRp6P18Rg51epDScHN5VnT9dSm0HsOft67abeuEHdziLMXqec39dRPUuCc+TC/ysG5OHbeNiC3KB1MXWsYb00ODeIFQU17rTcDoVlyTvqJ/0jpii11kWBD8fdqPtGfuV3UUF5zhz6dShaWHtRprcvAQ0gum/Yv9N5kwEjP0430lvsGLpQzAYpu7vv1urCNcaDXepdu1NhaOsLI/gqrpyoJWXF6t5TxEojyIjwkHZeF4YZ1dMjEQ4qPHdnFjkV1KJpWSONcZL4F3PeU1TYQkTWHDli9t1M83EoiurRB7EI7t5BCyCkxlYJMIgRwJcYWBpFMfdE8BinJfpWkeyUh4PUQrhWJqAYJPiBHfyXRdL7LlVDGm/d9ZllzZPVxV0hfKOfInAL4w5u4XCt/nCPbw4+SDB00XIC05fwefOh6PAXEn2uXI72yE2ZSUoi/OrDBx9X0H0Q8kwjIBN3pC7QzxlikGPs7oDEoU45XkKbbqXOwPC7JaJZIJVNhR9mwRyXJ3eErDPtbJQi+rKVjHS2m050NDkqOqr5km2G+1l3xdLggBf4rEeTK0NXFdU5nSRK0+IFzGHiYcA1BZCs0DcI3UiUb4RDyZW9Ub+2RibAawvLRGi+XaYGWsP4NPhS5cSPL7bYDBRSTyu7U2jfiCnf5Y06sSgiF67jrwNuXXA0FySFzhJlIrHcRLZ
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YhYwINlFgHp/19gl64qGKKNIHIHbh6d2l/loOBW1HT4yKcd9/CbVggw9s4mM?=
 =?us-ascii?Q?Tz8uIBGmO1IPzCBQ4d28/Y/lcaAi94ZCDAyE4AguD/p8BRyHB246Gq6hhW+0?=
 =?us-ascii?Q?F3riWBW/bUXPGjkJzYBg9m8Nar3ErIxaEWtgCVNjjXhIsnZMb8QYo34dSJ14?=
 =?us-ascii?Q?6WOduFdVAWlUDPOGbhpPH4ls4ib+4J2Yq/jWr/rnwGXr8/r7HBQWI1zsdJmk?=
 =?us-ascii?Q?NK7ldBwXRPlLiPrvlwT+Hriz7pG/L0GPjROe6PxWYPucQIFceRBQOaggBikb?=
 =?us-ascii?Q?Qpywy1hqxH2eWJ8yUxwiopUuqbqEUhPDM1DNjpA9FkBIXn3hcxEQiyEo176o?=
 =?us-ascii?Q?qSggbGx+1Byu1kPjE9KKbWKhKM08hetWMWXQE5RxE0yuc+yec4hB0QEEq4YX?=
 =?us-ascii?Q?mdqihSO3FQEXVqOaP7jy7nIG/TwyEz0TRkC0cK4NWSfeFgi7ZoIKS33HTKxx?=
 =?us-ascii?Q?RbeLQuAsl9gGxEN6puKP4RSFW/blmQOXAH471MvX+FxpT/0VuHkxorDN2ety?=
 =?us-ascii?Q?TkLVLG/LkQSiuZTkxE/ivnIuhj0bsaUf0sv7k9zv/MLuLxjT7Lr8grjUzb25?=
 =?us-ascii?Q?o9j84f++gQimi/KYpTGGioV2q48g83he3oYog3y0E1eaqVvK+R6X1cxksey8?=
 =?us-ascii?Q?JesLiDcH2UXkonWsbs8N42r6g8gq7l5I8Pkv3tWVjVPVkBZ12aH7vJYYv3uD?=
 =?us-ascii?Q?LNmlEuSGeGvX31fIfxl2nu75MWEyYphYPafVWAwiYEpL0coYviZak28j50X6?=
 =?us-ascii?Q?tjrG436Jys+CJ4KvknFooc/FbZwj+UynfXS6cJ0VZuizgpXzxcema43tyoCh?=
 =?us-ascii?Q?Hc28hyFo4lEGxjI9McT2Nzi+P5w7v+ZIfuS/unc100uQfGbrKKLvY+zko9mO?=
 =?us-ascii?Q?Ya6BL1sYsdWeWcdFbxfyxjmEb768OCw24grGuzHBeqxz2+1wwXRW8zjLGAMc?=
 =?us-ascii?Q?THOaUv4CUuRN5xjB3fOU8WAcOsoRCLXCA/gguhv0Q2hZIcaSQZlTR/el7KGl?=
 =?us-ascii?Q?Zr9oAZApxzu53Lr+MEtTi+nwp79vd6/XadISLS+ThNJ9HcYClWnprmo84EHN?=
 =?us-ascii?Q?Y6MDGLfDbcFsfEonbWksJQHEJC8FJy3AxQ7N94pqax4yHFDZBk2prDsaD3BJ?=
 =?us-ascii?Q?efusR08a4K6kRib/KdLrwl0cCGgWfxc9RdadJokAdY1N5f0l3tYU8/9Az7Vx?=
 =?us-ascii?Q?O4ob7S0eRBGuWLkpCTl189cE/ZshoV/N8WT33TDSQ7jpCYtc+/oRd1NrqUo?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 376456b8-d0e5-4d1e-ff13-08dcf287f0c5
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 10:54:45.7092 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME0P300MB0620
Received-SPF: pass client-ip=2a01:111:f403:2818::80a;
 envelope-from=junjie.mao@hotmail.com;
 helo=AUS01-ME3-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=ham autolearn_force=no
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

offset_of! was stabilized in Rust 1.77.0. Use an alternative implemenation
that was found on the Rust forums, and whose author agreed to license as
MIT for use in QEMU.

The alternative allows only one level of field access, but apart from this
can be used just by replacing core::mem::offset_of! with
qemu_api::offset_of!.

Using offset_of! prior Rust 1.77.0 requires the structure to have the
derive(qemu_api_macros::Offsets) attribute.

Base on Paolo's fix series [1].

Make sure to remove subprojects/syn-2.0.66 if there is an existing
build. An additional feature cfg is added to
packagefiles/syn-2-rs/meson.build, which requires meson to re-checkout the
subproject.

TODO:

1. For each type of error detected in the proc macro:
    a. Determine the proper span in the error reports.
    b. Add tests.

v1 -> v2:

* Rebase to [1].
* The proc macro now generates a call to the with_offsets! macro rule
  instead of generating everything by itself.
* Use quote_spanned! when reporting errors in the proc macro.
* Add qemu-api-macro as a dependency of qemu-api for cargo expand.

[1] https://lore.kernel.org/qemu-devel/20241021163538.136941-1-pbonzini@redhat.com

Co-authored-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Junjie Mao <junjie.mao@hotmail.com>
---
 rust/hw/char/pl011/src/device.rs              |  2 +-
 rust/qemu-api-macros/Cargo.toml               |  6 +-
 rust/qemu-api-macros/src/lib.rs               | 71 +++++++++++++-
 rust/qemu-api/Cargo.lock                      | 47 ++++++++++
 rust/qemu-api/Cargo.toml                      |  1 +
 rust/qemu-api/meson.build                     | 12 ++-
 rust/qemu-api/src/device_class.rs             |  8 +-
 rust/qemu-api/src/lib.rs                      |  4 +
 rust/qemu-api/src/offset_of.rs                | 94 +++++++++++++++++++
 rust/qemu-api/tests/tests.rs                  | 31 +++++-
 subprojects/packagefiles/syn-2-rs/meson.build |  1 +
 11 files changed, 261 insertions(+), 16 deletions(-)
 create mode 100644 rust/qemu-api/src/offset_of.rs

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 0f6918dd22..fdb15e42d8 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -26,7 +26,7 @@
 pub const PL011_FIFO_DEPTH: usize = 16_usize;
 
 #[repr(C)]
-#[derive(Debug, qemu_api_macros::Object)]
+#[derive(Debug, qemu_api_macros::Object, qemu_api_macros::Offsets)]
 /// PL011 Device Model in QEMU
 pub struct PL011State {
     pub parent_obj: SysBusDevice,
diff --git a/rust/qemu-api-macros/Cargo.toml b/rust/qemu-api-macros/Cargo.toml
index 144cc3650f..19ea1e84ea 100644
--- a/rust/qemu-api-macros/Cargo.toml
+++ b/rust/qemu-api-macros/Cargo.toml
@@ -17,9 +17,9 @@ categories = []
 proc-macro = true
 
 [dependencies]
-proc-macro2 = "1"
-quote = "1"
-syn = "2"
+proc-macro2 = "=1.0.84"
+quote = "=1.0.36"
+syn = { version = "=2.0.66", features = ["full", "derive", "parsing", "printing", "clone-impls", "proc-macro", "extra-traits"] }
 
 # Do not include in any global workspace
 [workspace]
diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/lib.rs
index a4bc5d01ee..055c71efba 100644
--- a/rust/qemu-api-macros/src/lib.rs
+++ b/rust/qemu-api-macros/src/lib.rs
@@ -3,8 +3,12 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 use proc_macro::TokenStream;
-use quote::quote;
-use syn::{parse_macro_input, DeriveInput};
+use proc_macro2::Span;
+use quote::{quote, quote_spanned};
+use syn::{
+    parse_macro_input, parse_quote, punctuated::Punctuated, token::Comma, Data, DeriveInput, Field,
+    Fields, Ident, Type, Visibility,
+};
 
 #[proc_macro_derive(Object)]
 pub fn derive_object(input: TokenStream) -> TokenStream {
@@ -21,3 +25,66 @@ pub fn derive_object(input: TokenStream) -> TokenStream {
 
     TokenStream::from(expanded)
 }
+
+fn is_c_repr(input: &DeriveInput) -> Result<(), (String, Span)> {
+    let expected = parse_quote! { #[repr(C)] };
+
+    if input.attrs.iter().any(|attr| attr == &expected) {
+        Ok(())
+    } else {
+        Err((
+            "Can only generate offsets for structs with a C representation.".to_string(),
+            input.ident.span(),
+        ))
+    }
+}
+
+fn get_fields(input: &DeriveInput) -> Result<&Punctuated<Field, Comma>, (String, Span)> {
+    if let Data::Struct(s) = &input.data {
+        if let Fields::Named(fs) = &s.fields {
+            Ok(&fs.named)
+        } else {
+            Err((
+                "Cannot generate offsets for unnamed fields.".to_string(),
+                input.ident.span(),
+            ))
+        }
+    } else {
+        Err((
+            "Cannot generate offsets for union or enum.".to_string(),
+            input.ident.span(),
+        ))
+    }
+}
+
+#[rustfmt::skip::macros(quote)]
+fn derive_offsets_or_error(input: DeriveInput) -> Result<proc_macro2::TokenStream, (String, Span)> {
+    is_c_repr(&input)?;
+
+    let name = &input.ident;
+    let fields = get_fields(&input)?;
+    let field_names: Vec<&Ident> = fields.iter().map(|f| f.ident.as_ref().unwrap()).collect();
+    let field_types: Vec<&Type> = fields.iter().map(|f| &f.ty).collect();
+    let field_vis: Vec<&Visibility> = fields.iter().map(|f| &f.vis).collect();
+
+    Ok(quote! {
+	::qemu_api::with_offsets! {
+	    struct #name {
+		#(#field_vis #field_names: #field_types,)*
+	    }
+	}
+    })
+}
+
+/// A derive macro that generate field offsets for using `offset_of!` in
+/// versions of Rust prior to 1.77
+#[proc_macro_derive(Offsets)]
+pub fn derive_offsets(input: TokenStream) -> TokenStream {
+    let input = parse_macro_input!(input as DeriveInput);
+    let expanded = match derive_offsets_or_error(input) {
+        Ok(ts) => ts,
+        Err((msg, span)) => quote_spanned! {span=> compile_error!(#msg); },
+    };
+
+    proc_macro::TokenStream::from(expanded)
+}
diff --git a/rust/qemu-api/Cargo.lock b/rust/qemu-api/Cargo.lock
index e9c51a243a..3886f58cd0 100644
--- a/rust/qemu-api/Cargo.lock
+++ b/rust/qemu-api/Cargo.lock
@@ -2,6 +2,53 @@
 # It is not intended for manual editing.
 version = 3
 
+[[package]]
+name = "proc-macro2"
+version = "1.0.84"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "ec96c6a92621310b51366f1e28d05ef11489516e93be030060e5fc12024a49d6"
+dependencies = [
+ "unicode-ident",
+]
+
 [[package]]
 name = "qemu_api"
 version = "0.1.0"
+dependencies = [
+ "qemu_api_macros",
+]
+
+[[package]]
+name = "qemu_api_macros"
+version = "0.1.0"
+dependencies = [
+ "proc-macro2",
+ "quote",
+ "syn",
+]
+
+[[package]]
+name = "quote"
+version = "1.0.36"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "0fa76aaf39101c457836aec0ce2316dbdc3ab723cdda1c6bd4e6ad4208acaca7"
+dependencies = [
+ "proc-macro2",
+]
+
+[[package]]
+name = "syn"
+version = "2.0.66"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "c42f3f41a2de00b01c0aaad383c5a45241efc8b2d1eda5661812fda5f3cdcff5"
+dependencies = [
+ "proc-macro2",
+ "quote",
+ "unicode-ident",
+]
+
+[[package]]
+name = "unicode-ident"
+version = "1.0.13"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "e91b56cd4cadaeb79bbf1a5645f6b4f8dc5bde8834ad5894a8db35fda9efa1fe"
diff --git a/rust/qemu-api/Cargo.toml b/rust/qemu-api/Cargo.toml
index 3677def3fe..db594c6408 100644
--- a/rust/qemu-api/Cargo.toml
+++ b/rust/qemu-api/Cargo.toml
@@ -14,6 +14,7 @@ keywords = []
 categories = []
 
 [dependencies]
+qemu_api_macros = { path = "../qemu-api-macros" }
 
 [features]
 default = []
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 1b0fd40637..5736a25181 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -1,3 +1,9 @@
+_qemu_api_cfg = ['--cfg', 'MESON']
+# _qemu_api_cfg += ['--cfg', 'feature="allocator"']
+if rustc.version().version_compare('>=1.77.0')
+  _qemu_api_cfg += ['--cfg', 'has_offset_of']
+endif
+
 _qemu_api_rs = static_library(
   'qemu_api',
   structured_sources(
@@ -6,15 +12,13 @@ _qemu_api_rs = static_library(
       'src/definitions.rs',
       'src/device_class.rs',
       'src/zeroable.rs',
+      'src/offset_of.rs',
     ],
     {'.' : bindings_rs},
   ),
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
-  rust_args: [
-    '--cfg', 'MESON',
-    # '--cfg', 'feature="allocator"',
-  ],
+  rust_args: _qemu_api_cfg,
 )
 
 qemu_api = declare_dependency(
diff --git a/rust/qemu-api/src/device_class.rs b/rust/qemu-api/src/device_class.rs
index ed2d7ce1a5..ed1b14c677 100644
--- a/rust/qemu-api/src/device_class.rs
+++ b/rust/qemu-api/src/device_class.rs
@@ -23,23 +23,23 @@ macro_rules! device_class_init {
 
 #[macro_export]
 macro_rules! define_property {
-    ($name:expr, $state:ty, $field:expr, $prop:expr, $type:expr, default = $defval:expr$(,)*) => {
+    ($name:expr, $state:ty, $field:ident, $prop:expr, $type:expr, default = $defval:expr$(,)*) => {
         $crate::bindings::Property {
             // use associated function syntax for type checking
             name: ::core::ffi::CStr::as_ptr($name),
             info: $prop,
-            offset: ::core::mem::offset_of!($state, $field) as isize,
+            offset: $crate::offset_of!($state, $field) as isize,
             set_default: true,
             defval: $crate::bindings::Property__bindgen_ty_1 { u: $defval.into() },
             ..$crate::zeroable::Zeroable::ZERO
         }
     };
-    ($name:expr, $state:ty, $field:expr, $prop:expr, $type:expr$(,)*) => {
+    ($name:expr, $state:ty, $field:ident, $prop:expr, $type:expr$(,)*) => {
         $crate::bindings::Property {
             // use associated function syntax for type checking
             name: ::core::ffi::CStr::as_ptr($name),
             info: $prop,
-            offset: ::core::mem::offset_of!($state, $field) as isize,
+            offset: $crate::offset_of!($state, $field) as isize,
             set_default: false,
             ..$crate::zeroable::Zeroable::ZERO
         }
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index e94a15bb82..9b2f580756 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -29,6 +29,7 @@ unsafe impl Sync for bindings::VMStateDescription {}
 
 pub mod definitions;
 pub mod device_class;
+pub mod offset_of;
 pub mod zeroable;
 
 use std::alloc::{GlobalAlloc, Layout};
@@ -162,3 +163,6 @@ unsafe fn dealloc(&self, ptr: *mut u8, layout: Layout) {
         }
     }
 }
+
+#[cfg(has_offset_of)]
+pub use std::mem::offset_of;
diff --git a/rust/qemu-api/src/offset_of.rs b/rust/qemu-api/src/offset_of.rs
new file mode 100644
index 0000000000..f914fda648
--- /dev/null
+++ b/rust/qemu-api/src/offset_of.rs
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: MIT
+
+/// This macro provides the same functionality as `core::mem::offset_of`,
+/// except that only one level of field access is supported. The declaration
+/// of the struct must be attributed `derive(qemu_api_macros::Offsets)`.
+///
+/// It is needed because `offset_of!` was only stabilized in Rust 1.77.
+#[cfg(not(has_offset_of))]
+#[macro_export]
+macro_rules! offset_of {
+    ($Container:ty, $field:ident) => {
+        <$Container>::offset_to.$field
+    };
+}
+
+/// A wrapper for struct declarations, that allows using `offset_of!` in
+/// versions of Rust prior to 1.77.
+///
+/// Do not use this macro directly. Add the derive(qemu_api_macros::Offsets)
+/// attribute to the structure instead.
+#[macro_export]
+macro_rules! with_offsets {
+    // source: https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=10a22a9b8393abd7b541d8fc844bc0df
+    // used under MIT license with permission of Yandros aka Daniel Henry-Mantilla
+    (
+        struct $StructName:ident {
+            $(
+                $field_vis:vis
+                $field_name:ident : $field_ty:ty
+            ),*
+            $(,)?
+        }
+    ) => (
+        #[cfg(not(has_offset_of))]
+        #[allow(nonstandard_style)]
+        const _: () = {
+            pub
+            struct StructOffsets {
+                $(
+                    $field_vis
+                    $field_name: usize,
+                )*
+            }
+            struct Helper;
+            impl $StructName {
+                pub
+                const offset_to: StructOffsets = StructOffsets {
+                    $(
+                        $field_name: Helper::$field_name,
+                    )*
+                };
+            }
+            const END_OF_PREV_FIELD: usize = 0;
+            $crate::with_offsets! {
+                @names [ $($field_name)* ]
+                @tys [ $($field_ty ,)*]
+            }
+        };
+    );
+
+    (
+        @names []
+        @tys []
+    ) => ();
+
+    (
+        @names [$field_name:ident $($other_names:tt)*]
+        @tys [$field_ty:ty , $($other_tys:tt)*]
+    ) => (
+        impl Helper {
+            const $field_name: usize = {
+                let align =
+                    std::mem::align_of::<$field_ty>()
+                ;
+                let trail =
+                    END_OF_PREV_FIELD % align
+                ;
+                0   + END_OF_PREV_FIELD
+                    + (align - trail)
+                        * [1, 0][(trail == 0) as usize]
+            };
+        }
+        const _: () = {
+            const END_OF_PREV_FIELD: usize =
+                Helper::$field_name +
+                std::mem::size_of::<$field_ty>()
+            ;
+            $crate::with_offsets! {
+                @names [$($other_names)*]
+                @tys [$($other_tys)*]
+            }
+        };
+    );
+}
diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index aa1e0568c6..22ce1b5628 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -8,7 +8,7 @@
     bindings::*,
     declare_properties, define_property,
     definitions::{Class, ObjectImpl},
-    device_class_init, vm_state_description,
+    device_class_init, offset_of, vm_state_description,
 };
 
 #[test]
@@ -21,7 +21,7 @@ fn test_device_decl_macros() {
     }
 
     #[repr(C)]
-    #[derive(qemu_api_macros::Object)]
+    #[derive(qemu_api_macros::Object, qemu_api_macros::Offsets)]
     pub struct DummyState {
         pub _parent: DeviceState,
         pub migrate_clock: bool,
@@ -76,3 +76,30 @@ impl Class for DummyClass {
         object_unref(object_new(DummyState::TYPE_NAME.as_ptr()) as *mut _);
     }
 }
+
+#[test]
+fn test_offset_of() {
+    #[repr(C)]
+    struct Foo {
+        a: u16,
+        b: u32,
+        c: u64,
+        d: u16,
+    }
+
+    #[repr(C)]
+    #[derive(qemu_api_macros::Offsets)]
+    struct Bar {
+        pub a: u16,
+        pub b: u64,
+        c: Foo,
+        d: u64,
+    }
+
+    const OFFSET_TO_C: usize = offset_of!(Bar, c);
+
+    assert_eq!(offset_of!(Bar, a), 0);
+    assert_eq!(offset_of!(Bar, b), 8);
+    assert_eq!(OFFSET_TO_C, 16);
+    assert_eq!(offset_of!(Bar, d), 40);
+}
diff --git a/subprojects/packagefiles/syn-2-rs/meson.build b/subprojects/packagefiles/syn-2-rs/meson.build
index a53335f309..9f56ce1c24 100644
--- a/subprojects/packagefiles/syn-2-rs/meson.build
+++ b/subprojects/packagefiles/syn-2-rs/meson.build
@@ -24,6 +24,7 @@ _syn_rs = static_library(
     '--cfg', 'feature="printing"',
     '--cfg', 'feature="clone-impls"',
     '--cfg', 'feature="proc-macro"',
+    '--cfg', 'feature="extra-traits"',
   ],
   dependencies: [
     quote_dep,
-- 
2.34.1


