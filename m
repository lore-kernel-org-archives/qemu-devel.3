Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC45C36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 18:40:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvhFY-0004di-QW; Fri, 21 Mar 2025 14:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvhEa-00036f-VO
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:36:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvhEZ-00075N-8L
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:36:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742582202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8PRsXG8olna7mdtCEgxlJldcQSAzgu6Hx/iwD+YkCV8=;
 b=SiIjgYSulJSJxkhvyQGw7Hg7VHHPDdOyvU9c0x3dID64j/HOcpF2a+M7BL8ekRTDnNLUEP
 kzPbcOdbeQ78WQ3MG3ELgIJpF74KRGXV5R6ET5eK9O84HjYx4gS/GDmi3wmquhRVpuoe7+
 2kU/pTt8SbtpboXXAOUcASuOsczcFFE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-WUjD732jOC6NzLaDtCnCmA-1; Fri, 21 Mar 2025 14:36:37 -0400
X-MC-Unique: WUjD732jOC6NzLaDtCnCmA-1
X-Mimecast-MFC-AGG-ID: WUjD732jOC6NzLaDtCnCmA_1742582196
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-391425471d6so1060525f8f.3
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 11:36:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742582195; x=1743186995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8PRsXG8olna7mdtCEgxlJldcQSAzgu6Hx/iwD+YkCV8=;
 b=esDe4u8KhGCTRrcPNoCHU58sKoCXSbJ27MisTXc+6gjf2p8ZUBts17t4bZ1sv1OmFK
 WyPxdJnKcn172XQa1HDSzLoWYuENYOPLQeIILTAI4+mBxSSyC0CD8++a6D2H+Z3orScx
 DuzzUJ4gFZEZ2/jA79XsjMYoZoEfrnATzgArzOl9bRbuNHzb2h4gAESjr1557aZ/gH8L
 jbgGsB8nXWhPy/SSDJy/2PY6oROVMZ3KPCCkb+QHK77w3Yhim6TmCeUK9EqoejlCi642
 J6u5ZngalAr51bGaAijD2Zx89AqQhYrKDFTs+Z/d0JN2is+osSlTwS9OPrSwccAKRX/q
 Qtsw==
X-Gm-Message-State: AOJu0YyqCKrz3BiuDN099+J15l3d6IAozV3pp+TMptB06DtRrCzDnbi1
 7QDMtLNJtjw0bTTN2hBrFZDXiSdDJXO2yJpeNg+09oUmaaCrhK4Xc756pg/nlaMqMsD6IlbvDMI
 ZK+kV4M2eEj4mH/1CPxFcM+ZbWjIGDJp0L7AcZBRGBgBZ09EwAVjgqUWpwdNuSqVyfBFHo+Uco7
 eu9+27X3wF2Bl8xPlL4WR36r7Uqx0c8r2tk0l9
X-Gm-Gg: ASbGnct6iDoFGAJrGhHw5o5h+Rx8EZ/NaT1PM1RZSjXx0BPS7qbCAM92Qu8ITl9R57d
 kLlsxwQ5rwJnaK9f0XGFd7mmehBYPXztFU8vLXtkPKruu6ZYAAcgugfez2OIh3IOcTD1jsCb000
 DjXrD99Zm4fXb9/3AwgIIweWR8454UkWI263WqJrX94TxValmdPZwRQMAlyGm2XwBU8piCMA32q
 C9EGZ6eln5rmjhWHcLl9k1HKQ90871dsdTnVRt/z1SKb8gcWaJzMX0HVphzBV9YCQLEdTLu1zt0
 AaH/YcDa5jGNnu1VOdgR
X-Received: by 2002:a5d:64e4:0:b0:391:43cb:43fa with SMTP id
 ffacd0b85a97d-3997f9595a8mr4379835f8f.51.1742582195400; 
 Fri, 21 Mar 2025 11:36:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEclRNjBFHrvbkrHLXBZdIGSc8zgR1dpg1iz6Bq9z7WpDhBl54xZtX/IeT8lNln+flMaVchA==
X-Received: by 2002:a5d:64e4:0:b0:391:43cb:43fa with SMTP id
 ffacd0b85a97d-3997f9595a8mr4379810f8f.51.1742582194801; 
 Fri, 21 Mar 2025 11:36:34 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.194.153])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9b3ebcsm3010535f8f.47.2025.03.21.11.36.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 11:36:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 13/24] rust/vmstate: Fix type check for varray in vmstate_struct
Date: Fri, 21 Mar 2025 19:35:45 +0100
Message-ID: <20250321183556.155097-14-pbonzini@redhat.com>
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

When pass a varray to vmstate_struct, the `type` parameter should be the
type of the element in the varray, for example:

vmstate_struct!(HPETState, timers, [0 .. num_timers], VMSTATE_HPET_TIMER,
		BqlRefCell<HPETTimer>).with_version_id(0)

But this breaks current type check, because it checks the type of
`field`, which is an array type (for the above example, type of timers
is [BqlRefCell<HPETTimer>; 32], not BqlRefCell<HPETTimer>).

But the current assert_field_type() can no longer be extended to include
new arguments, so a variant of it (a second macro containing the
`num = $num:ident` parameter) had to be added to handle array cases.

In this new macro, it not only checks the type of element, but also
checks whether the `num` (number of elements in varray) is out of range.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250318130219.1799170-6-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/assertions.rs | 15 +++++++++++++++
 rust/qemu-api/src/vmstate.rs    |  2 +-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/rust/qemu-api/src/assertions.rs b/rust/qemu-api/src/assertions.rs
index bba38cfda11..eb12e9499a7 100644
--- a/rust/qemu-api/src/assertions.rs
+++ b/rust/qemu-api/src/assertions.rs
@@ -91,6 +91,21 @@ fn types_must_be_equal<T, U>(_: T)
             }
         };
     };
+
+    ($t:ty, $i:tt, $ti:ty, num = $num:ident) => {
+        const _: () = {
+            #[allow(unused)]
+            fn assert_field_type(v: $t) {
+                fn types_must_be_equal<T, U>(_: T)
+                where
+                    T: $crate::assertions::EqType<Itself = U>,
+                {
+                }
+                let index: usize = v.$num.try_into().unwrap();
+                types_must_be_equal::<_, &$ti>(&v.$i[index]);
+            }
+        };
+    };
 }
 
 /// Assert that an expression matches a pattern.  This can also be
diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index e2a1f7a97aa..9d9cdda993c 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -447,7 +447,7 @@ macro_rules! vmstate_struct {
                 .as_ptr() as *const ::std::os::raw::c_char,
             $(num_offset: $crate::offset_of!($struct_name, $num),)?
             offset: {
-                $crate::assert_field_type!($struct_name, $field_name, $type);
+                $crate::assert_field_type!($struct_name, $field_name, $type $(, num = $num)?);
                 $crate::offset_of!($struct_name, $field_name)
             },
             size: ::core::mem::size_of::<$type>(),
-- 
2.49.0


