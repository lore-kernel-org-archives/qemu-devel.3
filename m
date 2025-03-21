Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCB51C36002
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 18:41:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvhFa-0004qV-LK; Fri, 21 Mar 2025 14:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvhEw-0003PS-0I
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:37:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvhEt-00078u-OE
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:37:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742582222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sQLaituN3aYs4wbMz+tZ+slNW5qicDoFAjD2Be2hepc=;
 b=gmvlfDVDRbczD+b7/yK/ezcXGo4xDCc26U/HzsFZ6GoUU91uI85OZTa72wjmYVxmmW3r2o
 SuDZF3gJxhELAZVLNPL6cUL2TJeTYUBd6o2F+X/Yw10kldEPNzhrLvnfXKnW8xXhbET3LM
 fTCeaUbwBaW2ObC7FHNFbwKzPyfeVDU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-qApRgpmoMve-tU2WMKsbgQ-1; Fri, 21 Mar 2025 14:36:58 -0400
X-MC-Unique: qApRgpmoMve-tU2WMKsbgQ-1
X-Mimecast-MFC-AGG-ID: qApRgpmoMve-tU2WMKsbgQ_1742582218
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43ced8c2eb7so17509455e9.1
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 11:36:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742582216; x=1743187016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sQLaituN3aYs4wbMz+tZ+slNW5qicDoFAjD2Be2hepc=;
 b=lc3Xbhz0IcYgs9/QFCHcFGok+gN9HFtLxlm0OJxbnrVa/fOXl26pLhvwvoQnwBi4s1
 UZBbhUha9Ndb3mxxnzXTl3Fbnk+h/ucFdmjbyTDkPTH/MKEG9gUm510uybkewJhx0t/8
 qgg1/kYSXy+Q1GkhBbT2GEx28vyC6Vbm6QoVzvJoUMqGJJ6a8TIXG0rwIjCku08bAvWp
 4QgAXVdDTh6Ppy0ncRNvavoAUjoNL0kKnOyK/2eE2CKSM9Inq2EwsiPMq5dCKSrPKiTD
 658G8x/PXFRPJ2bWhfMwDvwImNmcTVm2CMpfVm4rYU4lmjqmn4oVCo39IJmdtiaGexie
 M9+g==
X-Gm-Message-State: AOJu0YyWPcGm/UQN6UeimlaFP8tv5zA0DFgreomZ9739kPBL6XHPnO67
 pfkRqmabq4A0YPNC+aZJBT8xjUPOWVOu71YMzQbeCeVO8A1yxt1KDYuYP8jHGhEJTmYtqYkh0SW
 Ds7XKHPX9uRUIwKZojt4fW9hWHjpVoSRJEVPP6XXnMB5msnPJNBizwHy4WRsjPk2CgAQhIkQfPA
 n85fbmT29FlO+0kfslsqFTZIrLZEmOjevqS5a2
X-Gm-Gg: ASbGncvQEO0+fO3LRXOOaDRvDgY68eLhWTIKxnjQ2Dq6GRN/+iK8RSqzbK7y7mPHufT
 vmOredbdn54+xXL9yirL0UenC2orTXylzbpcmf6BezSQ8jmjfTt9QidAZU3zU7zMlYmvpJUXQmX
 3udZGIv1LXB2kjc7Ok0CX/efyXnK8c1UwEitdR74kl7MZ47/AY3fNp+Uw/wah8Pe568nMSo3saT
 6aDCBunPeFzW0v2fOErOwYvGP28N3hoQzUXSFKM/OSwArOvFPBxmAl2ZebhdW7NKXh0I175ovUt
 4powA1ej/z5tejd1lkIP
X-Received: by 2002:a05:600c:4512:b0:43d:160:cd9e with SMTP id
 5b1f17b1804b1-43d509f4581mr45625475e9.17.1742582216482; 
 Fri, 21 Mar 2025 11:36:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWDL7cwWynzC/mbB3EChvC1iPMwC6uZnF60FXPdqln5bsplOTYlk6zMpPyLJeQnfsKGTFrHg==
X-Received: by 2002:a05:600c:4512:b0:43d:160:cd9e with SMTP id
 5b1f17b1804b1-43d509f4581mr45625315e9.17.1742582215999; 
 Fri, 21 Mar 2025 11:36:55 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.194.153])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed4d9sm85476765e9.33.2025.03.21.11.36.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 11:36:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 23/24] rust/vmstate: Include complete crate path of
 VMStateFlags in vmstate_clock
Date: Fri, 21 Mar 2025 19:35:55 +0100
Message-ID: <20250321183556.155097-24-pbonzini@redhat.com>
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

From: Zhao Liu <zhao1.liu@intel.com>

The use of "bindings::*" masks incomplete path of VMStateFlags.

Include complete crate path of VMStateFlags in vmstate_clock, and clean
up "bindings::*" in device_class.rs of pl011.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250318130219.1799170-16-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device_class.rs | 8 ++++++--
 rust/qemu-api/src/vmstate.rs           | 5 ++++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/rust/hw/char/pl011/src/device_class.rs b/rust/hw/char/pl011/src/device_class.rs
index 0b2076ddaa0..b4d4a7eb432 100644
--- a/rust/hw/char/pl011/src/device_class.rs
+++ b/rust/hw/char/pl011/src/device_class.rs
@@ -8,8 +8,12 @@
 };
 
 use qemu_api::{
-    bindings::*, c_str, prelude::*, vmstate_clock, vmstate_fields, vmstate_of, vmstate_struct,
-    vmstate_subsections, vmstate_unused, zeroable::Zeroable,
+    bindings::{qdev_prop_bool, qdev_prop_chr},
+    c_str,
+    prelude::*,
+    vmstate::VMStateDescription,
+    vmstate_clock, vmstate_fields, vmstate_of, vmstate_struct, vmstate_subsections, vmstate_unused,
+    zeroable::Zeroable,
 };
 
 use crate::device::{PL011Registers, PL011State};
diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 9740931fb16..1b2b12eadd6 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -487,7 +487,10 @@ macro_rules! vmstate_clock {
                 $crate::offset_of!($struct_name, $field_name)
             },
             size: ::core::mem::size_of::<*const $crate::qdev::Clock>(),
-            flags: VMStateFlags(VMStateFlags::VMS_STRUCT.0 | VMStateFlags::VMS_POINTER.0),
+            flags: $crate::bindings::VMStateFlags(
+                $crate::bindings::VMStateFlags::VMS_STRUCT.0
+                    | $crate::bindings::VMStateFlags::VMS_POINTER.0,
+            ),
             vmsd: unsafe { ::core::ptr::addr_of!($crate::bindings::vmstate_clock) },
             ..$crate::zeroable::Zeroable::ZERO
         }
-- 
2.49.0


