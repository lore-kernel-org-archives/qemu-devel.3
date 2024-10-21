Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86531D3C93E
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 05:46:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2lFI-0003Dz-Gq; Mon, 21 Oct 2024 01:46:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t2lFF-0003AB-Mf
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 01:46:22 -0400
Received: from mail-me3aus01olkn2012.outbound.protection.outlook.com
 ([40.92.63.12] helo=AUS01-ME3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t2lFC-0004Ey-Qy
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 01:46:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LKd6YGa7R6gXKmmnDUxbXZiyCXNtvx4vocWVqlMXf/M/+g4u8u0x+xY2mCGLku8haXRyDzMM1jWXYXgCTP8ku5bJwl6z88yXMqjZkEvpeFqGA60XU0Q0s6f9WyfVsd6QyrePYWue1grolbuTXzbsFrkZ0yKolKC2nf+Q+mQ9DhiiK+SwFUhk6hKQmYQtny1M2eiV+JwEZpsarb52ybY/7wnxCnFKQ/0Vno9oUQ4JFjuUG6zzI2/C1vukIVndxIwN4FA9IymhFgH26s77RSTW41npdcXckr1cay83LlduARhgnCerYXe1Q2m/Y2MU3WQR+1igK7WI35XfbPFUYnstXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9p794tMUUzvgBMZHJulq7HN5KH0JtPEEp2lr26yPh5o=;
 b=QnINk3PAGIEEyRNs3ndm3OAXCrNI6xVOLGZZ/9mhzRAK11SGh3avZ9y25ZZwUkyxA+Ps13eCaJIRrXGYj+JJpelKj19xgPNujEttnT/xL2DkwBwLTJcuJfQWSvl9mNhOIqSaWPB8mDVsOLbglQ8X6AZvYr6ARPTsLQ6F/ZSiqS6AbTyFrRBN40UL76H4a+z3ApGiQBPQw1/MokiZa8mhP6dT+4q73f1ZbMlYtWsgr9WBrdXiK3wiSqXd8wjqQUcL6CDdjrm/KDPM8zLJxVfv9EmVNMRxQV1HH/G5sRE+fDPrnN349eLeSWEmGPfA5UvQk97CkEqP1P+pKa16+S5nrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9p794tMUUzvgBMZHJulq7HN5KH0JtPEEp2lr26yPh5o=;
 b=tDuK9ht+yyt3OjedGX3F9GxLbd6320KLgqlLtUpIeNg27wXH39uaZB81gTjA1TTCQOOEQwhQpmWoY7ADpi1HLnIV/Hyftx2MoOoBG5fVYiUP+tMjegDu8dZB/Bgbx1Y5ylhXxVPTVLwYrv4nwjXEP9bxb8rgD6ONh3bVpx4KLk0/ONFD436fmf7J6xAe+G93fCAA1PQOdVlFUg0gymUHy3RPE8VVb3Lnq1I+Lfvw381hEsR0Ek2Sk1dwXP7ny/V5WC9ICHYN9C24zixqpjdzTAvFSZNmF81SL9+AsvDzAdHHyj4Ik2wEab5CPxkE1+YxhKdbwBbcGBa6gZ3paA3mRw==
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:282::22)
 by MEUP300MB0142.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:21b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 05:41:10 +0000
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd]) by SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd%2]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 05:41:10 +0000
From: Junjie Mao <junjie.mao@hotmail.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
	Junjie Mao <junjie.mao@hotmail.com>
Subject: [PATCH] rust: introduce alternative implementation of offset_of!
Date: Mon, 21 Oct 2024 13:40:57 +0800
Message-ID: <SY0P300MB10265E25557DB71EE426525795432@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0033.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::23) To SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:282::22)
X-Microsoft-Original-Message-ID: <20241021054057.11139-1-junjie.mao@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB1026:EE_|MEUP300MB0142:EE_
X-MS-Office365-Filtering-Correlation-Id: 813536da-2517-4aa7-e32e-08dcf192f7ed
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|15080799006|461199028|7092599003|5072599009|19110799003|5062599005|8060799006|56899033|1602099012|10035399004|440099028|4302099013|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info: A1BaIrSDnfvfKvgjmhgKrGkF+ID1M4OQZ8XjymETUZ/Ba5VXy3UPBrzaKkn295OMap2RnwVvm9YagqP5BQF7M6YQJOTmi4O8pbx2CzWujexzFSZx1Wufsp1/2LPEotcVz+J2PuoLTz1GWiE6ZxB15+Z+h3Z1D/IGdtwsbpG+iGpKM2obIzQ2A5I1AdUQvYbcU6vN3ocUpVNkZ0pxHCe+v/IeTecWHGI1vqGTOZtZQu1qFMHxl/T9Ihg9g3OBmdyaoBcI0VNLb+ZuiHsklZghEbK4UtWdiz3B9P3xcA0w0tDaYeL3tMCFOHrY012iZDmIjzS6W3u//fY1naH43dwD+bE/6DjGhbM2Wts1yByDtKQGRgzN8lfOP8OD3R7OvLP/TU3x4sqfUjz3ffTqnJmSSJ2wK9jIAlTYlm0XfWzao6+sv5cUSaU+E9KUM8bUStLYXsUfbNG4/JvKb8el63jqRk+4pBOvxhTbz7j64UOSgYdDBl5iAR1oZUDQR83tmSjVYBUk5rP49hGM9vWBcGPqri8Z8iDVLKfXH6s4X4GRMZg+JtlTF+ZEn4f/JbB0go+GuwwMW36te+0Dw2adT5VtV9MBbZhz4ag7ZogYIdZAYp5gkEtValMlm01weuKozO36+DbGFZwZ97l/PnuS8Ba8n0xGYsC9ZER7FjU7INajtFxGkvwEUJdmVsiuSImQzrZQf4XnbeJ6fg4PQ9heLvKD3/h6mEUURsrENtB0ltOdFEjLVKil9VrAjso61PEbOcGXrIeHf5v47D0YrafKMUULd6zhTxHvxzLWDI/NwdJIAB4Kp+OTAD9ejf5cBtu45lXRIPgS268T6J5EypyAJYEhPJmR91UN/WxeYT012EagmTWGSlV814haRcLyPujGFMqfsgV46H5dWLBowaNLwSzoaRdSpYF20qYtlpPH/JQVqMjPSELP1fB1h7eoedhVHbQW
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zs7tFeykBpq25LFqevSlI9Wr0SDhHNJceXtK8b9VFgmu6tHbaaKX8IlvOdss?=
 =?us-ascii?Q?sGudYFN9XGCAC+uMOqssIBILX43ovM+srbBj6vtAg03S1mKm8K/xzl5OxxqI?=
 =?us-ascii?Q?vSVZ5iVTkedY5Uwe6vNOy/4CeSEXQwPK7nDzj0eYjMQfizJnvTYIMJPLBlOV?=
 =?us-ascii?Q?Q+xLTYyKH6k0/FwDCW/qcC4PCGmySxiqfR35092I5Io/Mtnm9ZxpvCbDeL1P?=
 =?us-ascii?Q?EtR5sFYO3NCkHYTddVbvmlWcsbfWWI/5zi7vn1A66GsjXuf4DsZRow8Hg7Lw?=
 =?us-ascii?Q?dfp9xT0QKSb43gzYCmfRmNaxsdqSrWvTabPiD9LqcrdjEl+6mkW9SmORugCb?=
 =?us-ascii?Q?EAUycfVVRlD0mz25iiGJcuRtYCAoNcrQkBlcOK0tMx9YUawjxB/u6Qb4+k38?=
 =?us-ascii?Q?9o4o7iL3U3GQuvDOyY0QhNWjSkGV6YLsGhJO18kpCHFqdasZohNll4Z8TriK?=
 =?us-ascii?Q?/oFtggJg6xFTKOBn9dHB+GfEJwEttj2bdTf6/vtlhNy8h2jE8z3KxqaKjvBm?=
 =?us-ascii?Q?NWmn5x9RGc4K9NkDa4g8buO4VgboEXe1ug3xCBBPuWL2my6SavQxFbLdFWGY?=
 =?us-ascii?Q?Ljk4pD6O3mfCE9GakGcAcJsaTUWHwirj9kkNYwZ36WsoYW1S15Ttm0CPzEEY?=
 =?us-ascii?Q?ZF1VA+5tIstjESywIfcTZqBaKspKjOWy50V5JIhFUwoMRDuUkJqMvyhbXX32?=
 =?us-ascii?Q?oZQBv5Iub07Tatwyx0OboK0OIc9OseA56wKRiBu0Q1WycMky9BIuct25K0H2?=
 =?us-ascii?Q?SLwXBM7K12PJsBdWIA907QBCNYPOI767O/Hu0kF8yhjZsbTxrIggpQx4xjAy?=
 =?us-ascii?Q?QlaberCvogxcXCnheFAoUHyAlcNuQq91ULRGUg4ULy78gMpWVT1NYoo/Qjca?=
 =?us-ascii?Q?qUFLDigwq0vMKzjpfFSubMhcZXsHNVuGoC20gcq/ti2kospH5tIhRV/0HN7D?=
 =?us-ascii?Q?afX9uKDE1SymUp4mWcDhnYycFgRSJ+zaPT6y4l9Zakp5PR/gnIf7dFhO948+?=
 =?us-ascii?Q?WrbmRYocG0WHYsciDkG1APrVSN62AwFzDNvu8o7HsuN4Iq/N75Hk09VnVeS0?=
 =?us-ascii?Q?cVOWulQO5WSwDh0hL9IWoXMdkWj/1f+qnBldrvjuimyyrEfYR7rL3MoxrAU+?=
 =?us-ascii?Q?9tJhqBfczhvfjRglf0SjaMTNYLlUPPSBVa9fYmQubrnwQ5S3qmYEEoT//0iT?=
 =?us-ascii?Q?iqbrO6uVfuT1B/8Gj3DoesQMH+II1aUpjCMdeT9VR0sU0EztL+79vxzjJV4?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 813536da-2517-4aa7-e32e-08dcf192f7ed
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 05:41:10.8903 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEUP300MB0142
Received-SPF: pass client-ip=40.92.63.12; envelope-from=junjie.mao@hotmail.com;
 helo=AUS01-ME3-obe.outbound.protection.outlook.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_MSPIKE_H2=-1.699, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

offset_of! was stabilized in Rust 1.77.0. Use an alternative implemenation
that was found on the Rust forums, and whose author agreed to license as
MIT for use in QEMU.

The alternative allows only one level of field access, but apart from this
can be used just by replacing core::mem::offset_of! with
qemu_api::offset_of!.

Using offset_of! prior Rust 1.77.0 requires the structure to have the
derive(qemu_api_macros::Offsets) attribute.

Apply as a replacement of 10/16 of Paolo's RFC series [1].

Also remove subprojects/syn-2.0.66 if there is an existing build. An additional
feature cfg is added to packagefiles/syn-2-rs/meson.build, which requires meson
to re-checkout the subproject.

[1] https://lore.kernel.org/qemu-devel/20241015131735.518771-1-pbonzini@redhat.com

Co-authored-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Junjie Mao <junjie.mao@hotmail.com>
---
 rust/hw/char/pl011/src/device.rs              |   2 +-
 rust/qemu-api-macros/src/lib.rs               | 103 +++++++++++++++++-
 rust/qemu-api/meson.build                     |  11 +-
 rust/qemu-api/src/device_class.rs             |   8 +-
 rust/qemu-api/src/lib.rs                      |  16 +++
 rust/qemu-api/src/tests.rs                    |  30 ++++-
 subprojects/packagefiles/syn-2-rs/meson.build |   1 +
 7 files changed, 160 insertions(+), 11 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 55d933ee5e..e9c0932712 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -29,7 +29,7 @@
 pub const PL011_FIFO_DEPTH: usize = 16_usize;
 
 #[repr(C)]
-#[derive(Debug, qemu_api_macros::Object)]
+#[derive(Debug, qemu_api_macros::Object, qemu_api_macros::Offsets)]
 /// PL011 Device Model in QEMU
 pub struct PL011State {
     pub parent_obj: SysBusDevice,
diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/lib.rs
index 59aba592d9..edf987dc37 100644
--- a/rust/qemu-api-macros/src/lib.rs
+++ b/rust/qemu-api-macros/src/lib.rs
@@ -4,7 +4,10 @@
 
 use proc_macro::TokenStream;
 use quote::{format_ident, quote};
-use syn::{parse_macro_input, DeriveInput};
+use syn::{
+    parse_macro_input, parse_quote, punctuated::Punctuated, token::Comma, Data, DeriveInput, Field,
+    Fields, Ident, Visibility,
+};
 
 #[proc_macro_derive(Object)]
 pub fn derive_object(input: TokenStream) -> TokenStream {
@@ -41,3 +44,101 @@ extern "C" fn __load() {
 
     TokenStream::from(expanded)
 }
+
+fn is_c_repr(input: &DeriveInput) -> Result<(), proc_macro2::TokenStream> {
+    let expected = parse_quote! { #[repr(C)] };
+
+    for attr in &input.attrs {
+        if attr == &expected {
+            return Ok(());
+        }
+    }
+
+    Err(quote! { "Can only generate offsets for structs with a C representation." })
+}
+
+fn get_fields(input: &DeriveInput) -> Result<&Punctuated<Field, Comma>, proc_macro2::TokenStream> {
+    if let Data::Struct(s) = &input.data {
+        if let Fields::Named(fs) = &s.fields {
+            Ok(&fs.named)
+        } else {
+            Err(quote! { "Cannot generate offsets for unnamed fields." })
+        }
+    } else {
+        Err(quote! { "Cannot generate offsets for union or enum." })
+    }
+}
+
+#[rustfmt::skip::macros(quote)]
+fn derive_offsets_or_error(
+    input: DeriveInput,
+) -> Result<proc_macro2::TokenStream, proc_macro2::TokenStream> {
+    // The way to generate field offset constants comes from:
+    //
+    //     https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=10a22a9b8393abd7b541d8fc844bc0df
+    //
+    // used under MIT license with permission of Yandros aka Daniel Henry-Mantilla
+
+    is_c_repr(&input)?;
+
+    let name = &input.ident;
+    let fields = get_fields(&input)?;
+    let field_names: Vec<&Ident> = fields.iter().map(|f| f.ident.as_ref().unwrap()).collect();
+    let field_vis: Vec<&Visibility> = fields.iter().map(|f| &f.vis).collect();
+
+    let mut field_offsets = quote! {};
+    let mut end_of_prev_field = quote! { 0 };
+    for field in fields {
+        let name = field.ident.as_ref().unwrap();
+        let ty = &field.ty;
+
+        field_offsets.extend(
+            quote! {
+                const #name: usize = {
+                    let end_of_prev_field: usize = #end_of_prev_field;
+                    let align = std::mem::align_of::<#ty>();
+                    let trail = end_of_prev_field % align;
+                    end_of_prev_field + (align - trail) * [1, 0][(trail == 0) as usize]
+                };
+            }
+            .into_iter(),
+        );
+
+        end_of_prev_field = quote! {
+            Helper::#name + std::mem::size_of::<#ty>()
+        }
+    }
+
+    Ok(quote! {
+        #[cfg(not(has_offset_of))]
+        #[allow(nonstandard_style)]
+        const _: () = {
+            pub struct StructOffsets {
+                #(#field_vis #field_names: usize,)*
+            }
+            struct Helper;
+            impl #name {
+                pub const offset_to: StructOffsets = StructOffsets {
+                    #(#field_names: Helper::#field_names,)*
+                };
+            }
+            impl Helper {
+                #field_offsets
+            }
+        };
+    })
+}
+
+/// A derive macro that generate field offsets for using `offset_of!` in
+/// versions of Rust prior to 1.77
+#[proc_macro_derive(Offsets)]
+pub fn derive_offsets(input: TokenStream) -> TokenStream {
+    let input = parse_macro_input!(input as DeriveInput);
+
+    let expanded = match derive_offsets_or_error(input) {
+        Ok(ts) => ts,
+        Err(msg) => quote! { compile_error!(#msg); },
+    };
+
+    proc_macro::TokenStream::from(expanded)
+}
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index b55931c649..9a16b2872f 100644
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
@@ -12,10 +18,7 @@ _qemu_api_rs = static_library(
   ),
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
-  rust_args: [
-    '--cfg', 'MESON',
-    # '--cfg', 'feature="allocator"',
-  ],
+  rust_args: _qemu_api_cfg,
   dependencies: [
     qemu_api_macros,
   ],
diff --git a/rust/qemu-api/src/device_class.rs b/rust/qemu-api/src/device_class.rs
index 871063d4a9..d4fa544df3 100644
--- a/rust/qemu-api/src/device_class.rs
+++ b/rust/qemu-api/src/device_class.rs
@@ -26,7 +26,7 @@ macro_rules! device_class_init {
 
 #[macro_export]
 macro_rules! define_property {
-    ($name:expr, $state:ty, $field:expr, $prop:expr, $type:expr, default = $defval:expr$(,)*) => {
+    ($name:expr, $state:ty, $field:ident, $prop:expr, $type:expr, default = $defval:expr$(,)*) => {
         $crate::bindings::Property {
             name: {
                 #[used]
@@ -34,7 +34,7 @@ macro_rules! define_property {
                 _TEMP.as_ptr()
             },
             info: $prop,
-            offset: ::core::mem::offset_of!($state, $field)
+            offset: $crate::offset_of!($state, $field)
                 .try_into()
                 .expect("Could not fit offset value to type"),
             bitnr: 0,
@@ -47,7 +47,7 @@ macro_rules! define_property {
             link_type: ::core::ptr::null(),
         }
     };
-    ($name:expr, $state:ty, $field:expr, $prop:expr, $type:expr$(,)*) => {
+    ($name:expr, $state:ty, $field:ident, $prop:expr, $type:expr$(,)*) => {
         $crate::bindings::Property {
             name: {
                 #[used]
@@ -55,7 +55,7 @@ macro_rules! define_property {
                 _TEMP.as_ptr()
             },
             info: $prop,
-            offset: ::core::mem::offset_of!($state, $field)
+            offset: $crate::offset_of!($state, $field)
                 .try_into()
                 .expect("Could not fit offset value to type"),
             bitnr: 0,
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index 9b2483fbfa..fd37d68eb5 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -167,3 +167,19 @@ unsafe fn dealloc(&self, ptr: *mut u8, layout: Layout) {
         }
     }
 }
+
+/// This macro provides the same functionality as `core::mem::offset_of`,
+/// except that only one level of field access is supported. The declaration
+/// of the struct must be attributed `derive(qemu_api_macros::Offsets)`.
+///
+/// It is needed because `offset_of!` was only stabilized in Rust 1.77.
+#[cfg(not(has_offset_of))]
+#[macro_export]
+macro_rules! offset_of {
+    ($container:ty, $field:ident) => {
+        <$container>::offset_to.$field
+    };
+}
+
+#[cfg(has_offset_of)]
+pub use std::mem::offset_of;
diff --git a/rust/qemu-api/src/tests.rs b/rust/qemu-api/src/tests.rs
index d34b8d2418..479dd9b450 100644
--- a/rust/qemu-api/src/tests.rs
+++ b/rust/qemu-api/src/tests.rs
@@ -3,7 +3,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 use crate::{
-    bindings::*, c_str, declare_properties, define_property, device_class_init, vm_state_description,
+    bindings::*, c_str, declare_properties, define_property, device_class_init, offset_of, vm_state_description,
 };
 
 #[test]
@@ -16,6 +16,7 @@ fn test_device_decl_macros() {
     }
 
     #[repr(C)]
+    #[derive(qemu_api_macros::Offsets)]
     pub struct DummyState {
         pub char_backend: CharBackend,
         pub migrate_clock: bool,
@@ -47,3 +48,30 @@ pub struct DummyState {
         vmsd => VMSTATE,
     }
 }
+
+#[test]
+fn test_offset_of() {
+    #[repr(C)]
+    struct Foo {
+	a: u16,
+	b: u32,
+	c: u64,
+	d: u16,
+    }
+
+    #[repr(C)]
+    #[derive(qemu_api_macros::Offsets)]
+    struct Bar {
+	pub a: u16,
+	pub b: u64,
+	c: Foo,
+	d: u64,
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


