Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA985C83F03
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 13:59:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXKSk-0000tY-SH; Thu, 03 Jul 2025 09:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uXKSj-0000sI-5K
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 09:58:53 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uXKSg-0000j9-If
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 09:58:52 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ae36dc91dc7so953465866b.2
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 06:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751551128; x=1752155928; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jF8aqDbU3LXGxNB2udC3gwDcAxLsQwt6wTonGUyu9pA=;
 b=FoVlHEqjHbU6TgJvk0Rmd8JilWw6UI51DO7SOkuVGIrMW/4eRzJDHdrKDbM+zUawhh
 WjKyesPCWOAdf/zeFhsTgSS0cgPqqaRfTklDICnaOe/0QJfZjAkDviKYvBCjUpZ2QPp5
 IPS7ipo9AXKndyAbaXQd3Pq9hMZvXI/MV4sBji+mXSlWY2JTIZNT/7+qYMO61q6/lnPX
 hFeXFoGT1tV9LzWEmLP6y/7XjhiH+NqSdGUBN0c2TY+mW24Sv66OKKq2pYwivONU+PIK
 j+YRtog73a3k6lpmA8UiNkddChC8AvOvVqfUf3nhe7s5FeYH2em54KG0hK4rJqwBe6An
 y8wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751551128; x=1752155928;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jF8aqDbU3LXGxNB2udC3gwDcAxLsQwt6wTonGUyu9pA=;
 b=Iczz9+rQa3RKQDySNtJxYpOkb3MdNGbtlAZUY1P9veazQ1U5SlMoTuz2lOT2zEZH7I
 YvIIMwu8CXH/JmuLico5S35dnoksIhSUHponJ8ej9GU2aCRUAqd6OybtwJ7jBXl/6It1
 twHF6CHBcgE+4rN30WyEdY8stwhDN5YgRj9MyfsiUwTAaU8Ll/PYUMJzWG4COiHgXonU
 za5zZf5N6pyGMoS41HLQnXgUGz7/xu9+UguDd9IDBhloG6C71D9nrG2aPiXAZZPfy1rw
 RbFupJ5nEmBL/Pih/gjD0SFq2oJeJUoUmVBlEhj4ynbGjMVmNa4FF7H3dew1jQdoO/fD
 cgzA==
X-Gm-Message-State: AOJu0YwWaLVyiRRZ6E24hdfCMPxQkap2kHkXNR6FFjI8UK2VrBx5CUTc
 p+sSnsDAnmPlRT9WD41mHHaTGmRvW87Ny4vq5QBjJUL4U1YvVn3WwU46FH9PNx2jT7vSG9/riFE
 Pp/KsrVE=
X-Gm-Gg: ASbGnctu3POHJDXF7eSJANglPm1DnTpRzawbk5OuID/kmO9LCsrBUC3P7tY8UPM3P8H
 mtciRbATMUgHuXpkYzGXJ9Omv+XJxwppXUjhw8XDJXRFmVP8QD//OB49CIhVwkQXZfStOIRnhaj
 lb55arbdMjBYHjplPv7hLYkh7ahhpQd6yjgltVY3NRN9XeGGRwILqqoeaZ8fvgTMidkfk/BJX7/
 FGm5IhHGf/hykak9vVtjxGEddy4BGo3K11EoFYCOBkbU6D1iVBt8ZsHa5gShjgmOx7KxzQIdH+r
 kkmUjhRLV1JK0hnN2TOh6CwRJgh0VTWv2Ho4HwCAp8rU4oh5Z9pTltz2BrWAL56IiLQ6+xbKJ17
 OaZSZBbYhQ0uOfmNAHVxVm2unG5A2Gxw=
X-Google-Smtp-Source: AGHT+IG3N/M9icLX7qjM1o7pOePX0VOawUQ0FpVJu5KZpLU7NYRtk5P60awXFNpV+ee3EQ6YVob1MQ==
X-Received: by 2002:a17:907:7292:b0:ad2:43b6:dd75 with SMTP id
 a640c23a62f3a-ae3c2b3c08dmr734217066b.10.1751551128203; 
 Thu, 03 Jul 2025 06:58:48 -0700 (PDT)
Received: from [127.0.1.1] (ppp-2-86-212-125.home.otenet.gr. [2.86.212.125])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae353ca1ca6sm1279678966b.176.2025.07.03.06.58.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jul 2025 06:58:47 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 03 Jul 2025 16:58:13 +0300
Subject: [PATCH 3/3] rust: add *_with_attrs methods to MemoryRegionOps
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-rust-mem-api-v1-3-cd5314bdf580@linaro.org>
References: <20250703-rust-mem-api-v1-0-cd5314bdf580@linaro.org>
In-Reply-To: <20250703-rust-mem-api-v1-0-cd5314bdf580@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3630;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=1P+RBgerOZPwGjZrNaYJyYxeZQDGYekhtRtwSuEW7oM=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm9ab3lUWXlGTk9xWUZNakU2Ky9qYU02YmNTU3VUCldBczhvbGVZeWxiRHFnQ3pQ
 Y0NKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYUdhTWt3QUt
 DUkIzS2Nkd2YzNEowSytlRC80MXFlbG10cE9NcjdNcmZ0alFCT3R6enFaeEt6L2FKdDBSOXNlVA
 pEeURWejRmSXUwUnI0K2JGcE5oc2RMWUxPWC9GVzRZMFpOVXZoTXFLc0J4RTNpRVFGWEJtNXRkR
 ERFVjlPeWE1CmtudWZKdEJRTVI0dDhDcEI2clFsOGw2UStHbmFnRTlNUzY4cUJtblhwbTA4L1ha
 SGhGVjErMCtVM1NpNU9rckkKMUx0ZDhmeVZ0d01LK3BxSlIrdDRoczRtVkpIUmZPaGdFSnl3MWp
 RZ0EwdWFqTVRMYWxBTU9xM2Q2QVo4MGtOMgp1SjI2VWYvSGpqNE8wVktnMllHL25Pb3YxTzFETW
 N5SUF0NkxsQm9waDBSSmxqK0toOHZ4d2xzZnh2cERJcXdLCjdxaHJmcERxQWJEek5rekhDcXFJR
 ThyYUtDM3pKRDZSbTEzY2RGTFdnOFhLaVZsWDl5WCtFc01pRy9Dbjh3bzEKMWhwSnRMZkhVSTA4
 STZ5amRRcjVkSjlmWTZmZCtGL2dKbDdSOG1DbU5xUmJqdFUwdUJnK0wzbnhEcVBYZEgvWgpaMjI
 2ZTRIYWFHdEtDTXUxRVc1a1dENGlxWHU3TUh6YzJsUVBkdlNGTmR4Qjhnc2duRlE3bU8xSkhjNX
 Q5Y0drCi93dzJKaVJ1bDFuYkp4a1UwNGZYV0pxY0N0a25xbG1JeDNxWUFENXdDdGsxd3Jtby80S
 mhibG9DU2F1alhLN3QKM0ExaUdIblg4ekZadEthZVZKWXRURDhwd2FqdTNtYzR1MlZFSHhNQXNo
 UGR2VFFWejdlcnhOZEU0NWhXNTU3NApyV2FOS0JGTTZXTmJqdlFnL2Ixa1pDcXhZYWZvVTF2eFZ
 lbXZRMjdYTUZPcWplWWFHYzQ0VnVwOXFsTUZVYm5ICjhGaHA1UT09Cj1XNit0Ci0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62d.google.com
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

MemoryRegionOps (and its builder type) only support read/write
callbacks.

Add the ability to define {read,write}_with_attrs callbacks for devices
that need them.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 rust/qemu-api/meson.build   |  1 +
 rust/qemu-api/src/memory.rs | 52 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index a090297c458b1a282211b9e241c0e447dd594167..95c097ec8f8dd31a863339d58eaa8bfc4d4dea18 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -26,6 +26,7 @@ foreach enum : c_enums
 endforeach
 c_bitfields = [
   'ClockEvent',
+  'MemTxResult',
   'VMStateFlags',
 ]
 foreach enum : c_bitfields
diff --git a/rust/qemu-api/src/memory.rs b/rust/qemu-api/src/memory.rs
index b1907aa01300a3fac8e1f3b69c5d50da631a556d..98d1e116147aba2c9034a61159492382b1ee0e5e 100644
--- a/rust/qemu-api/src/memory.rs
+++ b/rust/qemu-api/src/memory.rs
@@ -9,7 +9,7 @@
     marker::PhantomData,
 };
 
-pub use bindings::{hwaddr, MemTxAttrs};
+pub use bindings::{hwaddr, MemTxAttrs, MemTxResult};
 
 use crate::{
     bindings::{self, device_endian, memory_region_init_io},
@@ -59,6 +59,20 @@ unsafe impl<T: Sync> Sync for MemoryRegionOps<T> {}
     F::call((unsafe { &*(opaque.cast::<T>()) }, addr, size))
 }
 
+unsafe extern "C" fn memory_region_ops_read_with_attrs_cb<
+    T,
+    F: for<'a> FnCall<(&'a T, hwaddr, *mut u64, Bits, MemTxAttrs), MemTxResult>,
+>(
+    opaque: *mut c_void,
+    addr: hwaddr,
+    data: *mut u64,
+    size: c_uint,
+    attrs: MemTxAttrs,
+) -> MemTxResult {
+    let size = Bits::try_from(size).expect("invalid size argument");
+    F::call((unsafe { &*(opaque.cast::<T>()) }, addr, data, size, attrs))
+}
+
 unsafe extern "C" fn memory_region_ops_write_cb<
     T,
     F: for<'a> FnCall<(&'a T, hwaddr, u64, Bits)>,
@@ -72,6 +86,20 @@ unsafe impl<T: Sync> Sync for MemoryRegionOps<T> {}
     F::call((unsafe { &*(opaque.cast::<T>()) }, addr, data, size))
 }
 
+unsafe extern "C" fn memory_region_ops_write_with_attrs_cb<
+    T,
+    F: for<'a> FnCall<(&'a T, hwaddr, u64, Bits, MemTxAttrs), MemTxResult>,
+>(
+    opaque: *mut c_void,
+    addr: hwaddr,
+    data: u64,
+    size: c_uint,
+    attrs: MemTxAttrs,
+) -> MemTxResult {
+    let size = Bits::try_from(size).expect("invalid size argument");
+    F::call((unsafe { &*(opaque.cast::<T>()) }, addr, data, size, attrs))
+}
+
 impl<T> MemoryRegionOpsBuilder<T> {
     #[must_use]
     pub const fn read<F: for<'a> FnCall<(&'a T, hwaddr, Bits), u64>>(mut self, _f: &F) -> Self {
@@ -86,6 +114,28 @@ pub const fn write<F: for<'a> FnCall<(&'a T, hwaddr, u64, Bits)>>(mut self, _f:
     }
 
     #[must_use]
+    pub const fn read_with_attrs<
+        F: for<'a> FnCall<(&'a T, hwaddr, *mut u64, Bits, MemTxAttrs), MemTxResult>,
+    >(
+        mut self,
+        _f: &F,
+    ) -> Self {
+        self.0.read_with_attrs = Some(memory_region_ops_read_with_attrs_cb::<T, F>);
+        self
+    }
+
+    #[must_use]
+    pub const fn write_with_attrs<
+        F: for<'a> FnCall<(&'a T, hwaddr, u64, Bits, MemTxAttrs), MemTxResult>,
+    >(
+        mut self,
+        _f: &F,
+    ) -> Self {
+        self.0.write_with_attrs = Some(memory_region_ops_write_with_attrs_cb::<T, F>);
+        self
+    }
+
+    #[must_use]
     pub const fn big_endian(mut self) -> Self {
         self.0.endianness = device_endian::DEVICE_BIG_ENDIAN;
         self

-- 
2.47.2


