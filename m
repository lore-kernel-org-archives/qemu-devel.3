Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C977DC19776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 08:56:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnw9R-0002E2-GQ; Fri, 28 Feb 2025 03:55:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnw9L-0002Ch-91
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 03:55:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnw9J-0005bm-OT
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 03:55:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740732911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=DEtBrYnRD+qhdroznCKgnXQNtSgBwOAltsGPpjAT9y8=;
 b=b+YLuAd/fMsoGL5iamRcyM588shK0wxglEmRqkjZSlD+4GcH+5FyajV3ufrvwmt3eTqD4l
 xejxFpbHYvvsl1a+x6cher52Bz0nKbNDxu7Qy5pIvij8Zis/dbSwWYvi9UIuqUw1wNtEK3
 PGhKZUnCitGX8a4P6OVP8dfp1F7hzNo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-iCuGXWf8MYSZCbciBv2J0g-1; Fri, 28 Feb 2025 03:55:10 -0500
X-MC-Unique: iCuGXWf8MYSZCbciBv2J0g-1
X-Mimecast-MFC-AGG-ID: iCuGXWf8MYSZCbciBv2J0g_1740732909
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43aafafe6b7so13116645e9.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 00:55:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740732908; x=1741337708;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DEtBrYnRD+qhdroznCKgnXQNtSgBwOAltsGPpjAT9y8=;
 b=V7vPOn2D277pkAJvXXG9kAGyUsY6IVYRDXfV8K24nCYGc4qEARVcy8tYeVeIjY9Tsh
 VAGOWnOxrfl3htexBgnV0gI8Z4+eTO4IxKWnvyHM2U29zrygLchiYcrvDXzSQ3oCmkNa
 SdkSoZo8yESrGR+Tp+4NPXXEICb2ZlEo8Ga8wacbnM5Fw1Y+nkepyP8EvxeK3tcdPge7
 +eTm5WULkpCmSjBgIMGOF5BmEgREkia8LcutIohji8lim+R+nDMvsSbU9VxoyjKnkA4z
 gjBf/2IuMsZpyCLZ1SdGzvGNd5ZTfq+6dky6E0q17NxOKvMI9cdVJhTjepb+C19YfsH+
 PMzQ==
X-Gm-Message-State: AOJu0Yz24DgUgMKGODK/l1MfuBv6ASY4ZiIYMDVCvxFIGzM+J83GkAvx
 H3MiLfvmip+fy5ThbkF/LDADlGS2w3SStDmu6QmoDvvXaBuaLqfIluO7T7IOb8ueKY8WsXFJvfX
 ZddSqoj1eukewk0lT7wzCAV7ZstW1WDxoR9biCTjWeq5az3dbzIzbd6SmPkTuTHStq2KBTvg2hI
 ahni+w34Uo5fGDG8xnMUwScZkhHqSmucvygpTxmYs=
X-Gm-Gg: ASbGnctKwaib0ST4+moHBnP/ckMEMjuWnLsDPaY1Gt/yIANrpdG/FeIr4GMcZtS54K6
 QFxxzXMikZSHN80DNwhLMJCQ469IKapdN3Ef9LmYTLdyPUzxjyTSnT82kRLQcRxUQ60ri5w9Nvg
 38mDR1htsZVN36wmMdbW1Y4NhdDa+FY+E9iWcpSxq6f23AVw71XAdqIvksQkHHanM4H6ij1yFKs
 CHyFg4/Dpc4OJTWJ9+tUbbviSIO55S/Jr7NrUtR/Q/WLGUZsEBhdOrqkBZ/rVc+CgTiVUcRjiA0
 kmp3VzSIP9RxAiaEjjh9
X-Received: by 2002:a05:600c:19c7:b0:439:6b57:c68 with SMTP id
 5b1f17b1804b1-43ba6710a51mr20982545e9.17.1740732908493; 
 Fri, 28 Feb 2025 00:55:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1QxGOsl/WH8Cfj/UOdbIGiyjrlJuhFBmYecfclwvc/h17QG+Y7cG0SAUNqgbWVopwIqDy2g==
X-Received: by 2002:a05:600c:19c7:b0:439:6b57:c68 with SMTP id
 5b1f17b1804b1-43ba6710a51mr20982245e9.17.1740732908022; 
 Fri, 28 Feb 2025 00:55:08 -0800 (PST)
Received: from [192.168.10.48] ([151.95.152.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba52b7ecsm80611535e9.3.2025.02.28.00.55.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 00:55:07 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH] rust: cell: add full example of declaring a SysBusDevice
Date: Fri, 28 Feb 2025 09:55:06 +0100
Message-ID: <20250228085506.846381-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/cell.rs | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/rust/qemu-api/src/cell.rs b/rust/qemu-api/src/cell.rs
index 6db678161ff..13e267ad355 100644
--- a/rust/qemu-api/src/cell.rs
+++ b/rust/qemu-api/src/cell.rs
@@ -73,6 +73,36 @@
 //! QEMU device implementations is usually incorrect and can lead to
 //! thread-safety issues.
 //!
+//! ### Example
+//!
+//! ```
+//! # use qemu_api::prelude::*;
+//! # use qemu_api::{c_str, cell::BqlRefCell, irq::InterruptSource, irq::IRQState};
+//! # use qemu_api::{sysbus::SysBusDevice, qom::Owned, qom::ParentField};
+//! # const N_GPIOS: usize = 8;
+//! # struct PL061Registers { /* ... */ }
+//! # unsafe impl ObjectType for PL061Device {
+//! #     type Class = <SysBusDevice as ObjectType>::Class;
+//! #     const TYPE_NAME: &'static std::ffi::CStr = c_str!("pl061");
+//! # }
+//! struct PL061Device {
+//!     parent_obj: ParentField<SysBusDevice>,
+//!
+//!     // Configuration is read-only after initialization
+//!     pullups: u32,
+//!     pulldowns: u32,
+//!
+//!     // Same for sub-objects of the device
+//!     out: [Owned<IRQState>; N_GPIOS],
+//!
+//!     // Single values shared with C code use BqlCell, in this case via InterruptSource
+//!     interrupt: InterruptSource,
+//!
+//!     // Larger state accessed by device methods uses BqlRefCell or Mutex
+//!     registers: BqlRefCell<PL061Registers>,
+//! }
+//! ```
+//!
 //! ### `BqlCell<T>`
 //!
 //! [`BqlCell<T>`] implements interior mutability by moving values in and out of
-- 
2.48.1


