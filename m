Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA3EC3ABB0
	for <qemu-devel@archiver.kernel.org>; Sat,  3 May 2025 07:59:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uB7mJ-00084R-QO; Sat, 03 May 2025 03:59:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uB7mH-000845-RH
 for qemu-devel@nongnu.org; Sat, 03 May 2025 03:59:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uB7mG-0006dC-0L
 for qemu-devel@nongnu.org; Sat, 03 May 2025 03:59:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746259153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LqeniZgXmPTdrTI+xq1XQTwnSc7B7nOzlTpRU2OjaDw=;
 b=LT/Y4jToNXaZMYzP5ammOewo/TP4ekawOUSUu0IeEgj+hfXPZpRwygWTT/dgxQvT66pzYl
 FWFJkKsdFcu1hXHZhty4KvyQ8ynVA3qADMutDkGu4uZfLD8mY4p2xpt2sGsmMTzg+HRAgQ
 WelPXaMd/qGDRpIFvsv62+ZTGKIx0/I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-pm-jBnJ9OA-g-W0Eoi_rew-1; Sat, 03 May 2025 03:59:11 -0400
X-MC-Unique: pm-jBnJ9OA-g-W0Eoi_rew-1
X-Mimecast-MFC-AGG-ID: pm-jBnJ9OA-g-W0Eoi_rew_1746259150
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43d01024089so17696365e9.1
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 00:59:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746259150; x=1746863950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LqeniZgXmPTdrTI+xq1XQTwnSc7B7nOzlTpRU2OjaDw=;
 b=XtFxk0ln3mK6FwFnnK4dv7IKIf5U3Txm398QRFqdG62EU2UUfyqdPrbMXbLGOmTOIO
 XstnTtvMBc1bqLEdjN15zMFdrO7zSjrSCp9nkttCAs24pL4mGzISadL3i5O/qjCKqn9A
 8MkO4QtGzP2jnmV9hjx3ke+ZeQPzndzqYtoefxg91TgKopPY5CZoUnN4LPNbRJm4JNRc
 Mlar3qf+3CLHsnSE6r3jXfnsI8xoJ1UAkvY/ur73xum3bTsQhyFDZSXRBVDH25tfeH2W
 th2wLbd23rdG2/lX++HwlDCYR8wUprURL87CnYbrofbG34G0eYupvN9XgN5pyaPCHSab
 mcfQ==
X-Gm-Message-State: AOJu0YwXtu0ys4TCRb2qeKva0fDA2gJ4SgpTupcxWjZYG246sx0228Rw
 CqgLpeJ+ZTnxMObg+jjzeknjTi+DRyAXbWZzkZWTgNes53Wri241C9HL7J85biwpyez+2KqvbDX
 e4dMbPzusxmMF1K5jSrYn/ueK14nHfNxO0/fHOIrqPwOYgGKN+ZZFRBIN8xh3V01fRDb8TaVTWd
 lHrn91D7GNb17lBpMxnkoSfz8Wlq0nkY1aV6cO
X-Gm-Gg: ASbGncszjIjFvsGi2PErjV8wwUCGQEBaTsiKEfdKCRGdDcfMALhYYNeoiSmyfg95sNr
 f9VC/Or2AtDSq4DHUlhg69/PRQ4S/CLzgv5jMPumHUf9ZBMvDb/JaIrfsQKA5G8SwXpHUVttvOA
 Qm8rvnCnO12Rkj6CZhGPg+/ERPjClVnFiPR2ApT194zFbERRkgUMbgQGmsoF1fMbRKSwz05z7tp
 1id8OkGNDjp3aB0isqqToQ/2QqH3Vl8kkJsJAZz1z+9nP7Fsv1t+7uxwd0UU4W2LWbHSUuxv+Oi
 UNygxYRG2NwJne4=
X-Received: by 2002:a05:600c:698e:b0:43d:1b74:e89a with SMTP id
 5b1f17b1804b1-441c48bb3f1mr1956715e9.9.1746259149684; 
 Sat, 03 May 2025 00:59:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEB4g0SB8xuvvrDXehhO/Y9iC/uw0m7XxVPI8hzB8Vk3xOdm9PpL6xyXzverJiPb33P+NT0Q==
X-Received: by 2002:a05:600c:698e:b0:43d:1b74:e89a with SMTP id
 5b1f17b1804b1-441c48bb3f1mr1956515e9.9.1746259149254; 
 Sat, 03 May 2025 00:59:09 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b8a286cfsm66028495e9.29.2025.05.03.00.59.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 00:59:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/13] rust: assertions: Support index field wrapped in BqlCell
Date: Sat,  3 May 2025 09:58:48 +0200
Message-ID: <20250503075858.277375-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250503075858.277375-1-pbonzini@redhat.com>
References: <20250503075858.277375-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
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

Currently, if the `num` field of a varray is not a numeric type, such as
being placed in a wrapper, the array variant of assert_field_type will
fail the check.

HPET currently wraps num_timers in BqlCell<>. Although BqlCell<> is not
necessary from strictly speaking, it makes sense for vmstate to respect
BqlCell.

The failure of assert_field_type is because it cannot convert BqlCell<T>
into usize for use as the index.  Use a constant 0 instead for the index,
by avoiding $(...)? and extracting the common parts of
assert_field_type! into an internal case.

Commit message based on a patch by Zhao Liu <zhao1.liu@intel.com>.

Link: https://lore.kernel.org/r/20250414144943.1112885-3-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/assertions.rs | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/rust/qemu-api/src/assertions.rs b/rust/qemu-api/src/assertions.rs
index eb12e9499a7..a2d38c877df 100644
--- a/rust/qemu-api/src/assertions.rs
+++ b/rust/qemu-api/src/assertions.rs
@@ -78,33 +78,26 @@ fn types_must_be_equal<T, U>(_: T)
 /// ```
 #[macro_export]
 macro_rules! assert_field_type {
-    ($t:ty, $i:tt, $ti:ty) => {
+    (@internal $param_name:ident, $ti:ty, $t:ty, $($field:tt)*) => {
         const _: () = {
             #[allow(unused)]
-            fn assert_field_type(v: $t) {
-                fn types_must_be_equal<T, U>(_: T)
+            fn assert_field_type($param_name: &$t) {
+                fn types_must_be_equal<T, U>(_: &T)
                 where
                     T: $crate::assertions::EqType<Itself = U>,
                 {
                 }
-                types_must_be_equal::<_, $ti>(v.$i);
+                types_must_be_equal::<_, $ti>(&$($field)*);
             }
         };
     };
 
+    ($t:ty, $i:tt, $ti:ty) => {
+        $crate::assert_field_type!(@internal v, $ti, $t, v.$i);
+    };
+
     ($t:ty, $i:tt, $ti:ty, num = $num:ident) => {
-        const _: () = {
-            #[allow(unused)]
-            fn assert_field_type(v: $t) {
-                fn types_must_be_equal<T, U>(_: T)
-                where
-                    T: $crate::assertions::EqType<Itself = U>,
-                {
-                }
-                let index: usize = v.$num.try_into().unwrap();
-                types_must_be_equal::<_, &$ti>(&v.$i[index]);
-            }
-        };
+        $crate::assert_field_type!(@internal v, $ti, $t, v.$i[0]);
     };
 }
 
-- 
2.49.0


