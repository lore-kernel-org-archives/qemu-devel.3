Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3397C1B0FF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 14:21:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnekN-00072V-Ti; Thu, 27 Feb 2025 09:20:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnekM-00071V-CA
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:20:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnekI-0003i2-T6
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:20:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740666014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PjtxIkwdleYjC4DCWP1LEl8y9JNwMGZvc6X0QJOda88=;
 b=OsfnlrOdWGJwmmAVZ2hACCm4tJ5ZYJi1aZ4yfvaOE2HCXl0Ag3xbiq0wZ218i0GLeXFnih
 H45UVTrBDviiXNurGhsTmYXDhVHBeeW2Li/yihJfbbqlXbdG8AWYlc95BEz5fUuXocP7rY
 6i6Sl8N/PekM1YV4H/7VxVPcMy65Q58=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-OxMmEe7VOVuHqIUO00AoAA-1; Thu, 27 Feb 2025 09:20:12 -0500
X-MC-Unique: OxMmEe7VOVuHqIUO00AoAA-1
X-Mimecast-MFC-AGG-ID: OxMmEe7VOVuHqIUO00AoAA_1740666012
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5de5172cc5bso918251a12.0
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 06:20:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740666011; x=1741270811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PjtxIkwdleYjC4DCWP1LEl8y9JNwMGZvc6X0QJOda88=;
 b=OtD1VMGwu1hW1CR5MdaGM3ULPPunq2Ze9l7c5xBirlQuu5ExpQt6v74JgcYbtbOtKt
 AR3zCoQL1PpbSSlEdPseHzNH4gkgZyqbjHV6m+CCOnFA05TdnvTzAYXJXgmM7SL47hpG
 vzSUB3HwsJmBZcbDclfiHnImd2/4+GnfOreRZKJE0VV/gejzqYQbCsjkuIWmc6vBk7JC
 LPx1YXNUTzmCIoonU1TSS9BUGZZ6AdN96TfH5xR78RnHDrNTg/WvdwGjaFkOuiI2IaYK
 f29C0xyEArlqAv0gX/h5UYYx4IFO6LJWdbQqLozf/moIE+SneQsftRTfJ2DnrEUpoUvY
 wPnQ==
X-Gm-Message-State: AOJu0Yxk+evKC3Z5bwWyqTBhxKUNAhcsccqYpMleKW69BreAkP+slPnH
 QiJ1jfVceg2MMVEwfmcULEazBmvIkomBK72o+kuGfBh4Axa3swFQqiwlKAtkcUzotkmRpuXB3qU
 I+xloTJY/8378VFELqWOvhES+JAbQlWT3MnzB50j5mR80siIDaKelhTOMv0SJOtwNypz3dEX2En
 aqyGHEt7uArpCvg1Ka74sQZVG6+wdUwlFkSNuM5x0=
X-Gm-Gg: ASbGncu9OS3LKZ0Y4H88BqviwGicoObCFJhAqnl7pkEaWuZdBby1Ud/zHY6TTw8wytA
 RuqqsuX6XC0zeUQEflLLBGgHVn1N6IEBJCbWLIKNgibSG+ZGEPyqGwkz8Fo1a96ulPrFmMRkfmu
 /kZcJTY03utV0K2FtJltMQXB8VxYaV49zrhh3CyEYj/ee+Jw4X8fJ+yBxeqw4PPHIyQuQd7HHVh
 2u938DhI9mhSgLh+lQydQlx2VC0EmGwRPedwLuE17bxik4k02uXhfhuwuHK6EbLFfZk39UMsPGL
 6rv7hmXg7VtFhiURBxzk
X-Received: by 2002:a05:6402:550c:b0:5de:4a8b:4c9c with SMTP id
 4fb4d7f45d1cf-5e44bb36bbcmr28548676a12.32.1740666010850; 
 Thu, 27 Feb 2025 06:20:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWomp/c2XCxOHLPzV0g4wWqhMU7pq5Hz6kGeGHOZZ0M6++7mL0JarG9dPdFeUTR5roKKafcA==
X-Received: by 2002:a05:6402:550c:b0:5de:4a8b:4c9c with SMTP id
 4fb4d7f45d1cf-5e44bb36bbcmr28548589a12.32.1740666010217; 
 Thu, 27 Feb 2025 06:20:10 -0800 (PST)
Received: from [192.168.10.48] ([176.206.102.52])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e4c3b6df84sm1143247a12.30.2025.02.27.06.20.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 06:20:08 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 07/34] rust: prefer importing std::ptr over core::ptr
Date: Thu, 27 Feb 2025 15:19:25 +0100
Message-ID: <20250227141952.811410-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227141952.811410-1-pbonzini@redhat.com>
References: <20250227141952.811410-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

The std::ptr is same as core::ptr, but std has already been used in many
cases and there's no need to choose non-std library.

So, use std::ptr directly to make the used ptr library as consistent as
possible.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250218080835.3341082-1-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs       | 2 +-
 rust/hw/char/pl011/src/device_class.rs | 6 ++++--
 rust/qemu-api/src/irq.rs               | 3 +--
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index fe73771021e..59a689fdcd7 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -2,10 +2,10 @@
 // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-use core::ptr::{addr_of, addr_of_mut, NonNull};
 use std::{
     ffi::CStr,
     os::raw::{c_int, c_void},
+    ptr::{addr_of, addr_of_mut, NonNull},
 };
 
 use qemu_api::{
diff --git a/rust/hw/char/pl011/src/device_class.rs b/rust/hw/char/pl011/src/device_class.rs
index dbef93f6cb3..0b2076ddaa0 100644
--- a/rust/hw/char/pl011/src/device_class.rs
+++ b/rust/hw/char/pl011/src/device_class.rs
@@ -2,8 +2,10 @@
 // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-use core::ptr::NonNull;
-use std::os::raw::{c_int, c_void};
+use std::{
+    os::raw::{c_int, c_void},
+    ptr::NonNull,
+};
 
 use qemu_api::{
     bindings::*, c_str, prelude::*, vmstate_clock, vmstate_fields, vmstate_of, vmstate_struct,
diff --git a/rust/qemu-api/src/irq.rs b/rust/qemu-api/src/irq.rs
index d1c9dc96eff..34c19263c23 100644
--- a/rust/qemu-api/src/irq.rs
+++ b/rust/qemu-api/src/irq.rs
@@ -4,8 +4,7 @@
 
 //! Bindings for interrupt sources
 
-use core::ptr;
-use std::{ffi::CStr, marker::PhantomData, os::raw::c_int};
+use std::{ffi::CStr, marker::PhantomData, os::raw::c_int, ptr};
 
 use crate::{
     bindings::{self, qemu_set_irq},
-- 
2.48.1


