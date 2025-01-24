Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 881B7C0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 09:48:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbGI3-0004RO-Qb; Fri, 24 Jan 2025 04:47:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGGH-0007c8-0z
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:46:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGGD-0003xF-6S
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:45:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737711952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5OmDZaW5YgRWxpigliqJLZJIDncKLDQrlFlqEsLvUnw=;
 b=cwSvw0YMn7VPzkXSd4tJpMdrD1JBBwOOe0G+kPAIw3/tHQTcwFrAMClnSgHXD1YHw5kEoz
 feyLOGJaLxNUruQ1VLYG0+R4oBaHkRAYAFZBTAr+AxnY+oIqtclHaEVEbWYBryKq5HlZLH
 GzoVIsWWP/DeMvu+DVmSA4CWAgLl2E4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-qy4WhyNfOGGhcpfsZW7hyw-1; Fri, 24 Jan 2025 04:45:50 -0500
X-MC-Unique: qy4WhyNfOGGhcpfsZW7hyw-1
X-Mimecast-MFC-AGG-ID: qy4WhyNfOGGhcpfsZW7hyw
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4361efc9dc6so10144355e9.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 01:45:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737711948; x=1738316748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5OmDZaW5YgRWxpigliqJLZJIDncKLDQrlFlqEsLvUnw=;
 b=dlu60qgbjRlabcO7jYZUf3KdIE/hNUY2fs9YwSxxTIdjB3eQ5TWrQIAwxAjiIIcSi2
 VdEuLz3Jo567JzlIDwm3dBdJukX3wkt3enKpQI5nzuigUpcsNL20SFLXFuESul5WzBJq
 JYFsv0ug+nBjBenM1SeFHZD60flo88ThvQnMezny3RSic89kdhC4FZkHi2QuvpPVks1L
 qGunzQ/BMsMW/Eggf8+wGYKiWQfcHcw1sWmN5Q2J4Gdpoqzp30mj8GGz1NQNg7vfWWco
 TmfiR6x6aHQPuRvwrom3tJRlO6J12EhEKF8IyGBQCgE4yqyXvFTBxHJ0bemrpXo8te0U
 cGiw==
X-Gm-Message-State: AOJu0YybccIZk06Ru2qDy52jpCTzEVzJmu+h0GUmvAE4hMOQdKXfbUZ9
 D05H0Mtf/aItLJ0UzItjk2auWt6LL7OvBGD7rY5laCzYm75el1zRvLHAfT8WzfA6HgfaN9SbDXs
 vhzDTyvASPJBSgk/EvRovATRJSJAjg7S8HK+gyquP+w1cQ3p0UeyBODguODoqb8SUU+RuAYvZ5L
 W6Ke54Wc/xX4e6jySoeU8QhoqGVJCChlhFAPblLTs=
X-Gm-Gg: ASbGncvSlYvlOv4uI3AqJ4nprmTS4BFvwnHwIZfyfyiz/vTz5FYsad+Glkibv7c1Gca
 UvDVO168w/GPAO1BkVlF9wfifBwlazrBKacqDZEy1vXDjJOrwTZVsElq6XfE5xsxjSZ/9vBrqNj
 3ggTwvQd5RwrmxRz0x7zzGBCsCOrG0kGP8I9kF9Of8Pi0gQkdXlSdOeZ4U+PdRpPu7wRGkDR+bP
 BHByK0yEfQTMsDiQnMndcxpyjDeXsnY/dWCfxyNIzjf2sVpYjnIcoDB4UwfNe9stpajYkMDKg==
X-Received: by 2002:a05:600c:4f16:b0:434:fdf3:2c26 with SMTP id
 5b1f17b1804b1-4389143a124mr244594815e9.19.1737711947954; 
 Fri, 24 Jan 2025 01:45:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxP3PpEnHAngHO79A5JAb+fLAGpww1lRg5RRriQS1o6t36W4/M5vh8NOvJZvClg5doqAIyqA==
X-Received: by 2002:a05:600c:4f16:b0:434:fdf3:2c26 with SMTP id
 5b1f17b1804b1-4389143a124mr244594505e9.19.1737711947434; 
 Fri, 24 Jan 2025 01:45:47 -0800 (PST)
Received: from [192.168.10.48] ([151.95.59.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd57545dsm20147905e9.40.2025.01.24.01.45.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 01:45:46 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 31/48] rust: qemu_api: add vmstate_struct
Date: Fri, 24 Jan 2025 10:44:25 +0100
Message-ID: <20250124094442.13207-32-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250124094442.13207-1-pbonzini@redhat.com>
References: <20250124094442.13207-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

It is not type safe, but it's the best that can be done without
const_refs_static.  It can also be used with BqlCell and BqlRefCell.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/vmstate.rs | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 9ac699b73b7..d3a9cffdf3f 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -628,6 +628,39 @@ macro_rules! vmstate_array_of_pointer_to_struct {
     }};
 }
 
+// FIXME: including the `vmsd` field in a `const` is not possible without
+// the const_refs_static feature (stabilized in Rust 1.83.0).  Without it,
+// it is not possible to use VMS_STRUCT in a transparent manner using
+// `vmstate_of!`.  While VMSTATE_CLOCK can at least try to be type-safe,
+// VMSTATE_STRUCT includes $type only for documentation purposes; it
+// is checked against $field_name and $struct_name, but not against $vmsd
+// which is what really would matter.
+#[doc(alias = "VMSTATE_STRUCT")]
+#[macro_export]
+macro_rules! vmstate_struct {
+    ($struct_name:ty, $field_name:ident $([0 .. $num:ident $(* $factor:expr)?])?, $vmsd:expr, $type:ty $(,)?) => {
+        $crate::bindings::VMStateField {
+            name: ::core::concat!(::core::stringify!($field_name), "\0")
+                .as_bytes()
+                .as_ptr() as *const ::std::os::raw::c_char,
+            $(.num_offset: $crate::offset_of!($struct_name, $num),)?
+            offset: {
+                $crate::assert_field_type!($struct_name, $field_name, $type);
+                $crate::offset_of!($struct_name, $field_name)
+            },
+            size: ::core::mem::size_of::<$type>(),
+            flags: $crate::bindings::VMStateFlags::VMS_STRUCT,
+            vmsd: unsafe { $vmsd },
+            ..$crate::zeroable::Zeroable::ZERO $(
+                .with_varray_flag($crate::call_func_with_field!(
+                    $crate::vmstate::vmstate_varray_flag,
+                    $struct_name,
+                    $num))
+               $(.with_varray_multiply($factor))?)?
+        }
+    };
+}
+
 #[doc(alias = "VMSTATE_CLOCK_V")]
 #[macro_export]
 macro_rules! vmstate_clock_v {
-- 
2.48.1


