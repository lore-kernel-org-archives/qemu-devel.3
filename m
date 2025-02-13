Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE67C021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 16:09:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tibfM-000179-CZ; Thu, 13 Feb 2025 11:02:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tibfC-00012M-5X
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:02:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tibfA-0005cb-Ab
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:02:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739462519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5kzmkIRqhlXbqWGVMFyokXMxq1ViMc/6BtpuRSbbCnU=;
 b=Uexvsv3PblcoFvZKKkcziASuzYltgcFT549Ngjop5g+HnBpVxUxLQIdsaWTV3tvYg3/Mji
 Z80ROy4YamXd5Xw20jyUp1G3Lmybb6mhzqcWI39TiiGvPbg4xhQuCVE5CgcEpd4M+mMoBV
 gp9Es2z3UxFfjIu9u41EwL+7F0P91kI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-hUt8jtLBOQ2zEOngkyubBQ-1; Thu, 13 Feb 2025 11:01:51 -0500
X-MC-Unique: hUt8jtLBOQ2zEOngkyubBQ-1
X-Mimecast-MFC-AGG-ID: hUt8jtLBOQ2zEOngkyubBQ_1739462509
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-439622e9113so5914185e9.3
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 08:01:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739462508; x=1740067308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5kzmkIRqhlXbqWGVMFyokXMxq1ViMc/6BtpuRSbbCnU=;
 b=dt6+ZifajCedv5Ltpl34SnegJTCqGV08PfL61jZX4KiJ+LHsfiTztVqWvc/ybXAsSJ
 xFh+V719K0UgI1on2847JiPDKo/1+NZqPEiFmjL7zhzIs+ThRkWZ4pvK4QALKFn/OmBB
 DMbF0tqLajzsrcWqYGf9NyFd2qNY6LPLfNSzGjKPoJYxCfawQhvZJvqFAhhE87QfWjg2
 4KHv1XKSKC/y/DpSU5R+jAwPafyJnH4a8PempFPS3ImTEkyMMglFs2vLn7G73ucBrijo
 baI1pMHHTh5i4EBcUkAjGMRthBAqRqhCJC2D4xLC0KQHNOHXMDMJUB5brRSKTNSX36Mf
 +2rw==
X-Gm-Message-State: AOJu0Yyw0bw8xw6CIIznktP2vi9pr3UuJvFKjeg4zINqrRgDIMe+Sn2S
 weqctJ8LwnRWGanvbLKCbLng9zz2CavUwj7q+aUaofxDy4kqxugl1Ksilau+1ihSmaiHplylzNR
 6unaXvu9Zi91JU6bm9vKL3lHKG6DsxlIzTnLlDdHpO3vhb9VVlSJFKsuOgctJD0FqY5qZYlFEUO
 KcuvpI2/tt8rnf0QRCnUkuH3zMnSH+P9KSxLhrihA=
X-Gm-Gg: ASbGnct6PHV6hSaEJYZ3M4DMvAlaae4jRhvQiMO2mMVRwOwM06dGDxdxBk53L1l9K7W
 ODx0yt5Kqc2CBOpNkMUsYeXpu4Req4tS6aOfXYwemixsbPIpPNJq0Knhj/S8MqqYwRBP3UXZsjC
 RUqaslQtj9QinHmfgCm5PdXRPLpv34MZOsynDFV07YrzRZref/zGba9j+OfWHVB56SdoT1O1y9x
 p0mfWXksXssPMWidIglESl3W+80pS3l1U3eN3bwM1wJzfndUyAI5EdYomEFAyNhNnL6P0S0dR56
 31WDrVGw/53zig+XRVWCQSHvBzrPbG+Qa6qeBcD8ZI7S9A==
X-Received: by 2002:a05:600c:46ce:b0:439:4706:ae04 with SMTP id
 5b1f17b1804b1-43958183d00mr88069365e9.16.1739462507973; 
 Thu, 13 Feb 2025 08:01:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5P3usQFM4sw99zeLXuofbTil4WiHincDNIFVauGcj8cqp1Jakn1BBYgPpx8TugeF/JE3PXw==
X-Received: by 2002:a05:600c:46ce:b0:439:4706:ae04 with SMTP id
 5b1f17b1804b1-43958183d00mr88068625e9.16.1739462507437; 
 Thu, 13 Feb 2025 08:01:47 -0800 (PST)
Received: from [192.168.126.123] (93-38-211-213.ip72.fastwebnet.it.
 [93.38.211.213]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259d5b40sm2266095f8f.68.2025.02.13.08.01.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 08:01:46 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 18/27] rust: add bindings for memattrs
Date: Thu, 13 Feb 2025 17:00:45 +0100
Message-ID: <20250213160054.3937012-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213160054.3937012-1-pbonzini@redhat.com>
References: <20250213160054.3937012-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
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

The MemTxAttrs structure contains bitfield members, and bindgen is
unable to generate an equivalent macro definition for
MEMTXATTRS_UNSPECIFIED.

Therefore, manually define a global constant variable
MEMTXATTRS_UNSPECIFIED to support calls from Rust code.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250125125137.1223277-6-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/wrapper.h                |  1 +
 rust/qemu-api/src/memory.rs   | 16 ++++++++++++++--
 rust/qemu-api/src/zeroable.rs |  1 +
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/rust/wrapper.h b/rust/wrapper.h
index a9bc67af0d5..54839ce0f51 100644
--- a/rust/wrapper.h
+++ b/rust/wrapper.h
@@ -62,3 +62,4 @@ typedef enum memory_order {
 #include "qapi/error.h"
 #include "migration/vmstate.h"
 #include "chardev/char-serial.h"
+#include "exec/memattrs.h"
diff --git a/rust/qemu-api/src/memory.rs b/rust/qemu-api/src/memory.rs
index 963d689c27d..682951ab44e 100644
--- a/rust/qemu-api/src/memory.rs
+++ b/rust/qemu-api/src/memory.rs
@@ -2,7 +2,7 @@
 // Author(s): Paolo Bonzini <pbonzini@redhat.com>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-//! Bindings for `MemoryRegion` and `MemoryRegionOps`
+//! Bindings for `MemoryRegion`, `MemoryRegionOps` and `MemTxAttrs`
 
 use std::{
     ffi::{CStr, CString},
@@ -11,7 +11,7 @@
     ptr::addr_of,
 };
 
-pub use bindings::hwaddr;
+pub use bindings::{hwaddr, MemTxAttrs};
 
 use crate::{
     bindings::{self, device_endian, memory_region_init_io},
@@ -189,3 +189,15 @@ unsafe impl ObjectType for MemoryRegion {
         unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_MEMORY_REGION) };
 }
 qom_isa!(MemoryRegion: Object);
+
+/// A special `MemTxAttrs` constant, used to indicate that no memory
+/// attributes are specified.
+///
+/// Bus masters which don't specify any attributes will get this,
+/// which has all attribute bits clear except the topmost one
+/// (so that we can distinguish "all attributes deliberately clear"
+/// from "didn't specify" if necessary).
+pub const MEMTXATTRS_UNSPECIFIED: MemTxAttrs = MemTxAttrs {
+    unspecified: true,
+    ..Zeroable::ZERO
+};
diff --git a/rust/qemu-api/src/zeroable.rs b/rust/qemu-api/src/zeroable.rs
index 75742b50d4e..9f009606b1a 100644
--- a/rust/qemu-api/src/zeroable.rs
+++ b/rust/qemu-api/src/zeroable.rs
@@ -101,3 +101,4 @@ fn default() -> Self {
 impl_zeroable!(crate::bindings::MemoryRegionOps__bindgen_ty_1);
 impl_zeroable!(crate::bindings::MemoryRegionOps__bindgen_ty_2);
 impl_zeroable!(crate::bindings::MemoryRegionOps);
+impl_zeroable!(crate::bindings::MemTxAttrs);
-- 
2.48.1


