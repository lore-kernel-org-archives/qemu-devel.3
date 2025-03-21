Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C16BC36002
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 11:25:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvaVO-0003z5-Uw; Fri, 21 Mar 2025 07:25:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tvaVJ-0003vd-4f
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 07:25:33 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tvaVG-0004P0-AE
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 07:25:32 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43d0618746bso12611005e9.2
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 04:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742556329; x=1743161129; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NzDaV833+sNCdch5vTHYgYjsDrkvTWOgMEcsYmvQ7Aw=;
 b=O6i5iEGGX5ipDvgPxkTufU2YNGxN1dr8Uxy7Lzluxr4+UHIUkOUnaSU7pZ93kd+G9p
 3JvME4u+hKabGBuscYPgCT+nPxStBtLeZibenh0mJWGpR4w9iybI1iPAUGS06QT22v6i
 JPlGjZtYlPYFUBRNmCAspBM+pLpLAK9cb8ies5acxes+z40tzAiV/payNsJ1WpOVPxC2
 XCvx29+S54E3DqXbhY0N6bXTA5pISwnUAQPdeso/BHZhjCBz3PKnW2V2NsDVV8l1hvnB
 YPinfweBxRSzyE5xuz/7Ll978O3zMHcZkXc7+g3G/hrZf0SBHrmYsvVel3ZOM0n3U0r1
 UQow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742556329; x=1743161129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NzDaV833+sNCdch5vTHYgYjsDrkvTWOgMEcsYmvQ7Aw=;
 b=G2d4yA9Syl1FSLgDxkdL+IFiaVjObMJ1PQDT/eo8J97mu9jyWnPmUsYS3i95rcu5YP
 6nteATDZN/u1ix+fYog1WbJa4us3n73SBAeN07kLGezJRi9szDlCe6UBlf/ZNVXLlnrL
 xxg6Qe7ZBmsxMj84DOeG5s2rtwaWiN7rQGSjL0JF1J65CW+2PURhogQevJv+qUrTKX4p
 DCKt3yvcSssIB0fbArzgrU8UXD+7efaqNEOIPk2XZEWWicoeSUrs+IeB/nP8IThmEMoi
 REda+rg9Alm+yr2L59uv8STePkyO1p0+Hn3e+AFyDAtBS/P0pWkn5HiwHegrtUSy1crk
 NDQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSlqz0bRZd1vOze3jDYVM8/g0OtngRPwndAG7I1XCQs2AaYpfZX0rC+TiYer0295I8sO/yW5G8V114@nongnu.org
X-Gm-Message-State: AOJu0YwNyRO9JxT6acghIYVM0ouW5qSin597Xp1YcyTQfMvg8U/UEToO
 4w71gw6anhR4abNcvneW7giBRo14+YTo1OT3yi5yTE8HJZkCge63YKJPMbksryOw0QFiRecpaRJ
 2
X-Gm-Gg: ASbGncsoTgEHOfGjiYH78K5/+fvbwZQif6KYF6SzdhQEDXMzXrjVWnNdpEEBak4oOsn
 jhYu3qjBFi7tVoq2LK09/9TPeWjV1ORdQl3lIbnoCxRMmU5Uehkjyr94D5742AWAfSQSCm72maw
 nR/rEU6pPaetdty/M08unUeRTGfmMEojAzMhdIB30Mfi7LunTED2Hu/qRS+2ASIEhvi6Af/dml5
 H7M1UrC+HVz72bSYnup0yFOrSWFlQktPkSyQCKxhSrj7AhcJbj74edi+I414jhtYh7Hj268O0fs
 RqYOB/vmQMwTcSoLlbJ4zFbtmQ1oIVsIapZI510Bn+Q6+O/8jDQ=
X-Google-Smtp-Source: AGHT+IFKRlSVBFhMXy5QUUclpB5JyQ4KZ1lD9q8qvbxVXt1Rv1vNTiLUe3UyM0zq7IFupJzwhiAE6w==
X-Received: by 2002:a5d:47a5:0:b0:390:fc83:a070 with SMTP id
 ffacd0b85a97d-3997f8a4e9cmr2587541f8f.0.1742556328752; 
 Fri, 21 Mar 2025 04:25:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9e6767sm2132614f8f.66.2025.03.21.04.25.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 04:25:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 3/3] rust: pl011: Check size of state struct at compile time
Date: Fri, 21 Mar 2025 11:25:23 +0000
Message-ID: <20250321112523.1774131-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250321112523.1774131-1-peter.maydell@linaro.org>
References: <20250321112523.1774131-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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
---
v1->v2: fix alpha order in 'use'; use 'size_of' and
'qemu_api::bindings::PL011State rather than 'mem::size_of'
and 'bindings::PL011State'.
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
2.43.0


