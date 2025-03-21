Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40BA9C36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 18:39:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvhEM-0002Ge-9t; Fri, 21 Mar 2025 14:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvhEG-0001kB-Oy
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:36:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvhEF-00072K-2g
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742582182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GxdsFjP0x5vh9Jd/1Uxx3cGM8EOg2J+L3U1w2scPDrQ=;
 b=dy/5NynkW1Fa0ic4di4zTGv0GGi8GhLqC4D65l2ns/Y8aJwSPnz4yrskMixv9y9QGgfrSv
 a93PKmywl1aKnASLDhvzJtwQ4vf1NCt71mHp/3ZGSllItc/pAEmGou1ahZWHjBdHjRkUXN
 zoPWNgV/kdIv68EjnDVetN5VHcr2tGg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-7TWddNuRNiO5sNoKOvbR4g-1; Fri, 21 Mar 2025 14:36:20 -0400
X-MC-Unique: 7TWddNuRNiO5sNoKOvbR4g-1
X-Mimecast-MFC-AGG-ID: 7TWddNuRNiO5sNoKOvbR4g_1742582180
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ac2db121f95so188796966b.1
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 11:36:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742582178; x=1743186978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GxdsFjP0x5vh9Jd/1Uxx3cGM8EOg2J+L3U1w2scPDrQ=;
 b=M5RXweMCqA1aY9xZkugS5gK0NPRbO9Xzsj3R856cfi0NITeoHjZDueF/G6gR+vbvMA
 MQShFXpTRrx7MPoBgpLCmFM20rB/I82O5/PKpqjRapC4+nVwcNq85TTX2j/oAkAkhGGn
 16tFrx0WrYNvarBPIhZxlcYv2z2/e0XNMOw2BWTIPqt/7de94bjWZBC77XQ6SIpfEW6J
 jWXSeRYET9369ijlcxJPUI7G4OGazwbUxCFlC+uEHNkwJsWFl9ur5eTFR46/JWeNnKRJ
 VuVwgjEdalFQFQSZFNL4Z8l8/MayWiUfgBWytzGLHNOtCXkctAzN+ijG3fN1lQUf++Ij
 u6kw==
X-Gm-Message-State: AOJu0YzoEwo+6K28hp0KEWFr2nNydQ6yADxVbyK1wHL7UKxs1aVfC5JC
 mWSD2tT/r6pgVBiez/TpJOeII8DDcE1k8yDiCH6n+rWEdE1pNcFqm8O4lhNlIOFLUHlHe70WpoK
 MTfK4Ea7Mo5CDv3amHDpXOqSD/pdKaA8BAEVORbNoroyOvEhAt0xcdi37iUQ2Cl2l0UVhqbYnbb
 w2jiJN9Q5AsdJBmfw13b768THRUdfvb2ZupLJd
X-Gm-Gg: ASbGncsUJpl38MsZ8AEWh4WbCN2F6kZ/XPPczQ2RkzZ5mSirsxX6gnl+jrInKCHE16o
 MGPdNHT1wq71DmUYM88k2uU04HvONXSVVS2G3lw1dzBihsYGBaLWUXt8vFJ02XVNOcAVDgYgvzw
 3MIoIhEis/89ihgZbBWUwW3F81vWKiWN06wiqTXVLVUlz18XHpKSOTIgw14sy1mBjay8s38iOsq
 DcReLfFIKAMLUGMMNjqrXmC4HExyD3L7uf6JGfQqanGqaOm/HVPq2Ei4Hv4ZAXOJfAIqr5+zoX7
 hJE+nHawYelxZTGddHa/
X-Received: by 2002:a17:907:d26:b0:ac3:45b5:f4cc with SMTP id
 a640c23a62f3a-ac3f25032d1mr453261666b.44.1742582177688; 
 Fri, 21 Mar 2025 11:36:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEv3KqT8vGvDDwhAEfw+OPtmfmvMpoI4MpWRKTIuo9dCwkQQ1p02tb1PeIa0NlfluJZZrUvhQ==
X-Received: by 2002:a17:907:d26:b0:ac3:45b5:f4cc with SMTP id
 a640c23a62f3a-ac3f25032d1mr453258666b.44.1742582177106; 
 Fri, 21 Mar 2025 11:36:17 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.194.153])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ebcd0c7737sm1766637a12.49.2025.03.21.11.36.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 11:36:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 06/24] rust: pl011: Check size of state struct at compile time
Date: Fri, 21 Mar 2025 19:35:38 +0100
Message-ID: <20250321183556.155097-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250321183556.155097-1-pbonzini@redhat.com>
References: <20250321183556.155097-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

The PL011 device's C implementation exposes its PL011State struct to
users of the device, and one common usage pattern is to embed that
struct into the user's own state struct.  (The internals of the
struct are technically visible to the C user of the device, but in
practice are treated as implementation details.)

This means that the Rust version of the state struct must not be
larger than the C version's struct; otherwise it will trip a runtime
assertion in object_initialize_type() when the C user attempts to
in-place initialize the type.

Add a compile-time assertion on the Rust side, so that if we
accidentally make the Rust device state larger we know immediately
that we need to expand the padding in the C version of the struct.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Link: https://lore.kernel.org/r/20250321112523.1774131-4-peter.maydell@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/wrapper.h                   | 1 +
 rust/hw/char/pl011/src/device.rs | 9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/rust/wrapper.h b/rust/wrapper.h
index d927ad6799d..d4fec546571 100644
--- a/rust/wrapper.h
+++ b/rust/wrapper.h
@@ -65,3 +65,4 @@ typedef enum memory_order {
 #include "exec/memattrs.h"
 #include "qemu/timer.h"
 #include "exec/address-spaces.h"
+#include "hw/char/pl011.h"
diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index f137b49feaf..bf88e0b00a0 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -2,7 +2,7 @@
 // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-use std::{ffi::CStr, ptr::addr_of_mut};
+use std::{ffi::CStr, mem::size_of, ptr::addr_of_mut};
 
 use qemu_api::{
     chardev::{CharBackend, Chardev, Event},
@@ -12,6 +12,7 @@
     prelude::*,
     qdev::{Clock, ClockEvent, DeviceImpl, DeviceState, Property, ResetType, ResettablePhasesImpl},
     qom::{ObjectImpl, Owned, ParentField},
+    static_assert,
     sysbus::{SysBusDevice, SysBusDeviceImpl},
     vmstate::VMStateDescription,
 };
@@ -124,6 +125,12 @@ pub struct PL011State {
     pub migrate_clock: bool,
 }
 
+// Some C users of this device embed its state struct into their own
+// structs, so the size of the Rust version must not be any larger
+// than the size of the C one. If this assert triggers you need to
+// expand the padding_for_rust[] array in the C PL011State struct.
+static_assert!(size_of::<PL011State>() <= size_of::<qemu_api::bindings::PL011State>());
+
 qom_isa!(PL011State : SysBusDevice, DeviceState, Object);
 
 #[repr(C)]
-- 
2.49.0


