Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CBE5CE8E7C
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 14:06:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3yRW-0007Bb-Au; Thu, 24 Oct 2024 10:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t3yRJ-00079A-G9
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 10:03:53 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t3yRH-0003xI-PG
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 10:03:49 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a9a0ec0a94fso122898066b.1
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 07:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729778626; x=1730383426; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KCn73+YkWwVjQeZCOwMpqD8LHrnSQOeaidvNNKE/Tbg=;
 b=baid7ihQiUxezkPyj1QXwB7iZV9kJjX8e7B1tbK7Ir3ldidu/1+VEWdZHc8WHo2FRp
 lOeMwa8UxA/odZ+EXak0i+MzG3AYq2A4LnIxPNUYscf/h9E0uuEdkWkL8I0do3ffnkkL
 6c0syXUeAVrZVvA1G1Qh3KtHWPd3EQn4/5IhJcqAaSJ+wx5f431gtR23/7bBBDQQyrff
 P/Y2jNK26K3MV0dcL/0bOx8oL7uAWjQUBOhvQy8KRxzB3TWId73cMH6uX+b+61EJlakk
 cgn5dyrB3iWa0pwKsMdYbuzFDkqXGdnll0nBF61FvR3RdPFXB8nZqCvjuWc5oI9Z4wqS
 Wyvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729778626; x=1730383426;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KCn73+YkWwVjQeZCOwMpqD8LHrnSQOeaidvNNKE/Tbg=;
 b=DtxC0al+DU9POHfJjIQMJHaCxP15tjkE5b1HkWuU1VE/J6QyeUVYnlgvo83RVZi3zM
 8jdgaJsMkvpIHq20LdPUwyv8uCoESPo13SLmgTEmKpv32G/TTg/odEIVE29eMIoVOEME
 c4munONUoj6NGV2713lBgTjRR2ZkVg/7oLHyfStfi46YAnOZ71WMVjNi6p0CqEDIneXu
 Y0TwBcPBj4vKGW58tyYsEdmTdno5hvgjigMR7uIqU6uupGht6x2tsBOJdRr8JV8ThFvV
 JvEAcTh0tfm1qMJ1ORfqpTHoKHCt2DIX3tuGuqd424HCExnFQZFwOxgpTh7LlPeQsqiW
 +p4Q==
X-Gm-Message-State: AOJu0YxoaTMn5BwEgVbda93XYdNUQe6aKYH9uejMMQ+T3QpqGFEe5wFa
 8Xah0Dq0d8MHqC/f2aUfd83yxFZZbPc/z/Zw2it1R4OF8PGnO1iphpiwxxJ28Ng=
X-Google-Smtp-Source: AGHT+IEwX1dxqhQrGkfgK6YAEvKzZoJXmTBgXHkYG5P2OIcSO99hXifidTHt70f2mij4Idcd1CeErg==
X-Received: by 2002:a17:906:794b:b0:a99:8178:f7ed with SMTP id
 a640c23a62f3a-a9ad2711849mr199678366b.4.1729778623981; 
 Thu, 24 Oct 2024 07:03:43 -0700 (PDT)
Received: from [127.0.1.1] (adsl-113.37.6.2.tellas.gr. [37.6.2.113])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a912f6878sm621407566b.86.2024.10.24.07.03.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 07:03:43 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 24 Oct 2024 17:03:05 +0300
Subject: [PATCH 07/11] rust/pl011: move pub callback decl to local scope
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241024-rust-round-2-v1-7-051e7a25b978@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5176;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=t89qGxVY7Bbmwy9c+qHVuDpEPvucQqPydBhWY3bNDGg=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm5HbE9qY1RxSXBLa0N5NGh3RFc5NEJjeUliaXFwCmdwc3V0ZUZNbFNxaDdGVExO
 N1dKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKWnhwVG93QUt
 DUkIzS2Nkd2YzNEowTEgzRC80NVhmUFFWSnFrMHB1Zmd4ZUluaUxUK0RrTjhINis3ekNHajhSMQ
 o2QWNxc3VxZ2hQaEhkUWJ4RVhSZUxVT3VqNXQ1WUVFbUlpZjlCRWJSbGludnpxZVJsdHRyN2huQ
 m5hUmM0SStXClh5ejI1d0dMSWlzWXdvdy9WcDAzejVJK1ZlSmNEdG9NTkxQc0xtZTRCTTN5Rkov
 VHo1UmdITGVTMWlPcmxRWmcKWFpZSmFKSHZWM2prbkcvOWhRb2MyY0UwcmVhYnI2aDcwWGJTQ2R
 1M0psMThxK2psenlwcU5RaUVlWDJibUlzaApoYTNUa0dsb1Voa2poOE5ZckVRUEtZTzZQR2svSW
 Z3cVFDdmh2WmtrMkkwSjcxcUY4MVpyOG5mUzVhOGV5Nkx6CnRvNE8yVUdHVzJJL2tqNmxSM2Fmb
 kpVcyt2VWtQWGtlTjlxN21wQTI0MFc3NzhqYlJJSjJscGsxeThwb3o0eGcKbjE0bnlrM3pKUnlq
 bmV1bUhxVEhVTHZYZk5qUDM4U3pxcmpYTS94dXovRTVoaWlIYkk3WmlxYkpUL0F1RndabwptaDY
 3S3Y2elJNaU9uS1ZkTVRhMWhDTnlBRkZyOHNaQW14RWJ6Ynlob1hoSVVWaXBQMXlVK1lNN1FZQW
 YxS2dtCjVuLzc4TDgxanAvYVppcEFqc1JCOWs3YjlvVTQ4U3B6WXBOR2U0TjZxTnQ2U09VQjU1M
 nFkN3JlNUQ1bFRzSmwKQTVhWGRIakdBa1U0ZGFQTytqMU0vbW44Q1U2V3ZvQUN5aG5oUjM2Y2NN
 T05zMWdVNTRIenpyRllwaklGeXgxdQpCQ0RUQ1lIYmo5R1o1cklENUJjL0FIYU5rNlh6aUcvN0w
 rQ3FESkUrdmNKNG5VMzk5bXA5ZGMwclhHZlhkUU9BCmpCLytFUT09Cj1ybTNjCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62e.google.com
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

extern "C" callbacks in instance_init() do not need to be public. Move
them to local function scope instead.

No functional change.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 rust/hw/char/pl011/src/device.rs | 104 +++++++++++++++++++--------------------
 1 file changed, 50 insertions(+), 54 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 3aa055dee4b10866a624505a9d05ef1ab8182dce..75399fa6352916fa9cc24164af0ea2e20fe29399 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -219,6 +219,56 @@ unsafe fn instance_init(&mut self) {
 
 impl DeviceImpl for PL011State {
     fn realize(&mut self) {
+        /// # Safety
+        ///
+        /// We expect the FFI user of this function to pass a valid pointer, that has
+        /// the same size as [`PL011State`]. We also expect the device is
+        /// readable/writeable from one thread at any time.
+        unsafe extern "C" fn pl011_can_receive(opaque: *mut c_void) -> c_int {
+            unsafe {
+                debug_assert!(!opaque.is_null());
+                let state = NonNull::new_unchecked(opaque.cast::<PL011State>());
+                state.as_ref().can_receive().into()
+            }
+        }
+        /// # Safety
+        ///
+        /// We expect the FFI user of this function to pass a valid pointer, that has
+        /// the same size as [`PL011State`]. We also expect the device is
+        /// readable/writeable from one thread at any time.
+        ///
+        /// The buffer and size arguments must also be valid.
+        unsafe extern "C" fn pl011_receive(
+            opaque: *mut core::ffi::c_void,
+            buf: *const u8,
+            size: core::ffi::c_int,
+        ) {
+            unsafe {
+                debug_assert!(!opaque.is_null());
+                let mut state = NonNull::new_unchecked(opaque.cast::<PL011State>());
+                if state.as_ref().loopback_enabled() {
+                    return;
+                }
+                if size > 0 {
+                    debug_assert!(!buf.is_null());
+                    state.as_mut().put_fifo(c_uint::from(buf.read_volatile()))
+                }
+            }
+        }
+
+        /// # Safety
+        ///
+        /// We expect the FFI user of this function to pass a valid pointer, that has
+        /// the same size as [`PL011State`]. We also expect the device is
+        /// readable/writeable from one thread at any time.
+        unsafe extern "C" fn pl011_event(opaque: *mut core::ffi::c_void, event: QEMUChrEvent) {
+            unsafe {
+                debug_assert!(!opaque.is_null());
+                let mut state = NonNull::new_unchecked(opaque.cast::<PL011State>());
+                state.as_mut().event(event)
+            }
+        }
+
         // SAFETY: self.char_backend has the correct size and alignment for a
         // CharBackend object, and its callbacks are of the correct types.
         unsafe {
@@ -611,60 +661,6 @@ pub fn update(&self) {
 
 /// # Safety
 ///
-/// We expect the FFI user of this function to pass a valid pointer, that has
-/// the same size as [`PL011State`]. We also expect the device is
-/// readable/writeable from one thread at any time.
-#[no_mangle]
-pub unsafe extern "C" fn pl011_can_receive(opaque: *mut c_void) -> c_int {
-    unsafe {
-        debug_assert!(!opaque.is_null());
-        let state = NonNull::new_unchecked(opaque.cast::<PL011State>());
-        state.as_ref().can_receive().into()
-    }
-}
-
-/// # Safety
-///
-/// We expect the FFI user of this function to pass a valid pointer, that has
-/// the same size as [`PL011State`]. We also expect the device is
-/// readable/writeable from one thread at any time.
-///
-/// The buffer and size arguments must also be valid.
-#[no_mangle]
-pub unsafe extern "C" fn pl011_receive(
-    opaque: *mut core::ffi::c_void,
-    buf: *const u8,
-    size: core::ffi::c_int,
-) {
-    unsafe {
-        debug_assert!(!opaque.is_null());
-        let mut state = NonNull::new_unchecked(opaque.cast::<PL011State>());
-        if state.as_ref().loopback_enabled() {
-            return;
-        }
-        if size > 0 {
-            debug_assert!(!buf.is_null());
-            state.as_mut().put_fifo(c_uint::from(buf.read_volatile()))
-        }
-    }
-}
-
-/// # Safety
-///
-/// We expect the FFI user of this function to pass a valid pointer, that has
-/// the same size as [`PL011State`]. We also expect the device is
-/// readable/writeable from one thread at any time.
-#[no_mangle]
-pub unsafe extern "C" fn pl011_event(opaque: *mut core::ffi::c_void, event: QEMUChrEvent) {
-    unsafe {
-        debug_assert!(!opaque.is_null());
-        let mut state = NonNull::new_unchecked(opaque.cast::<PL011State>());
-        state.as_mut().event(event)
-    }
-}
-
-/// # Safety
-///
 /// We expect the FFI user of this function to pass a valid pointer for `chr`.
 #[no_mangle]
 pub unsafe extern "C" fn pl011_create(

-- 
2.45.2


