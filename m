Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F9BC02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 09:52:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbGI7-0004vX-DA; Fri, 24 Jan 2025 04:47:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGFq-00077V-Vm
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:45:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGFo-0003uV-3r
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:45:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737711929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Iz+0oRL8E0Alsm18eGzwPgcS9Df+LzoBBQHD3AQeNAQ=;
 b=ASczHboJXu+CgBtNq0LGYmT7We/reUwHzZLrBFtVl5YD1a8HQC3HgUaMGuSaxmqWgx9UW6
 So80eW3lxJPuIJgjgs9BuAGw874A388cx4c+cF4D+k6uyOj0fsYUbzoZfQ+fP8U9kQRSxQ
 vOI+BdSOu9OwtUqgATHG7GStOQXEWXE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-ZszoNrUbMyK3FqjLb10pYQ-1; Fri, 24 Jan 2025 04:45:27 -0500
X-MC-Unique: ZszoNrUbMyK3FqjLb10pYQ-1
X-Mimecast-MFC-AGG-ID: ZszoNrUbMyK3FqjLb10pYQ
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-436248d1240so8883855e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 01:45:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737711926; x=1738316726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Iz+0oRL8E0Alsm18eGzwPgcS9Df+LzoBBQHD3AQeNAQ=;
 b=K5EiCTLQox/BlZ01qK34+3T9XP99TkG9/PVnKtholS6+4qdlWDIOvgbbzYHfLFwbKm
 z90dT/BKcc3dSomkOzeR7DYJPNCebAttxApFaAl+EnykjPfmOX1I1cylEJBGuLspR+4A
 HYb2DSOxb0+oyiZ0e2SPrQ725CLsaD36oOYazIwuR06d+PY+KT/CejUM8P9y3eRNv+EA
 OBpsOPDknIX4DTs77MntTvbcYagpqUJSoYuzUbJ78lOwHvNHQCxOdRtH08nmSS9EHcn1
 PDDxcf31VzrHu+0jq0GbEQHlvJ5NcxDTy1jMgxfMlLq6rYuw/joGMFTj56VnR9qj49VD
 zv7w==
X-Gm-Message-State: AOJu0Ywqv3cN+I8p4wc3BeSwUdpQBiFp/eC4H/USFbqFuTsZz9cs3EVi
 G4W6JrCvUTzZQGkx1/ighSmTgp85+91caDNGOI1q7c4wsGzC2oGlJQceXDfRK6zmd48xdoLRd9t
 Aa0dUqhFPFDJKbZlDMVIitIT+mbu2l5ANtlypXkPK+EI0I6mvdUdaqS8CTzHGf25dbvQmdLTv2r
 g0oalJg1xkqUAhs+ElCgP1qnztEJzfwYVnL339QuU=
X-Gm-Gg: ASbGncunFNpHuVicyIl6lHLpmIzq9U4hnGfzq3MgDEaJ0yoxdMjHCmmTYCzt2l4WQgi
 8IfSw25QSp8IURko2gsrwyjjsPKoZPOgfzJaErSAQUuLF63M0j2+5XDcdOIU6Ixst15hRMihWwz
 RBGlIjczCJt2dkRL8S+WMx2htAsnF+Ftd3O+c8ydafHfhiR0M7dcrL9nD9PllsNMKGnqTxIdzVU
 mZoUM2bxEZYb9+ShMznXQGl8m//SbsjpriCS15b3Cd0AVu1XV+dZIB515tgb3/UbFY1o2ygkg==
X-Received: by 2002:a05:600c:870a:b0:436:e8b4:3cde with SMTP id
 5b1f17b1804b1-438913ded64mr303096405e9.14.1737711925891; 
 Fri, 24 Jan 2025 01:45:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXSpC+4KZA/BzRCnAv813raC+gdiYw1Sf975YdvHjOWehdfDkA3Vx3ttAodIR60iz3neIHug==
X-Received: by 2002:a05:600c:870a:b0:436:e8b4:3cde with SMTP id
 5b1f17b1804b1-438913ded64mr303096165e9.14.1737711925520; 
 Fri, 24 Jan 2025 01:45:25 -0800 (PST)
Received: from [192.168.10.48] ([151.95.59.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47f120sm21133505e9.2.2025.01.24.01.45.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 01:45:24 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 21/48] rust/qdev: Make REALIZE safe
Date: Fri, 24 Jan 2025 10:44:15 +0100
Message-ID: <20250124094442.13207-22-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250124094442.13207-1-pbonzini@redhat.com>
References: <20250124094442.13207-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.043,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

A safe REALIZE accepts immutable reference.

Since current PL011's realize() only calls a char binding function (
qemu_chr_fe_set_handlers), it is possible to convert mutable reference
(&mut self) to immutable reference (&self), which only needs to convert
the pointers passed to C to mutable pointers.

Thus, make REALIZE accept immutable reference.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250121140457.84631-2-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 10 +++++-----
 rust/qemu-api/src/qdev.rs        |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 65a1234b9ff..a0e0fbdd9dd 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -2,7 +2,7 @@
 // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-use core::ptr::{addr_of_mut, NonNull};
+use core::ptr::{addr_of, addr_of_mut, NonNull};
 use std::{
     ffi::CStr,
     os::raw::{c_int, c_uint, c_void},
@@ -156,7 +156,7 @@ fn properties() -> &'static [Property] {
     fn vmsd() -> Option<&'static VMStateDescription> {
         Some(&device_class::VMSTATE_PL011)
     }
-    const REALIZE: Option<fn(&mut Self)> = Some(Self::realize);
+    const REALIZE: Option<fn(&Self)> = Some(Self::realize);
     const RESET: Option<fn(&mut Self)> = Some(Self::reset);
 }
 
@@ -439,17 +439,17 @@ fn set_read_trigger(&mut self) {
         self.read_trigger = 1;
     }
 
-    pub fn realize(&mut self) {
+    pub fn realize(&self) {
         // SAFETY: self.char_backend has the correct size and alignment for a
         // CharBackend object, and its callbacks are of the correct types.
         unsafe {
             qemu_chr_fe_set_handlers(
-                addr_of_mut!(self.char_backend),
+                addr_of!(self.char_backend) as *mut CharBackend,
                 Some(pl011_can_receive),
                 Some(pl011_receive),
                 Some(pl011_event),
                 None,
-                addr_of_mut!(*self).cast::<c_void>(),
+                addr_of!(*self).cast::<c_void>() as *mut c_void,
                 core::ptr::null_mut(),
                 true,
             );
diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
index 686054e737a..a5121e31a37 100644
--- a/rust/qemu-api/src/qdev.rs
+++ b/rust/qemu-api/src/qdev.rs
@@ -23,7 +23,7 @@ pub trait DeviceImpl {
     ///
     /// If not `None`, the parent class's `realize` method is overridden
     /// with the function pointed to by `REALIZE`.
-    const REALIZE: Option<fn(&mut Self)> = None;
+    const REALIZE: Option<fn(&Self)> = None;
 
     /// If not `None`, the parent class's `reset` method is overridden
     /// with the function pointed to by `RESET`.
-- 
2.48.1


