Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 045BAC369D9
	for <qemu-devel@archiver.kernel.org>; Sat,  3 May 2025 08:00:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uB7mH-000846-TX; Sat, 03 May 2025 03:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uB7mF-00083K-6M
 for qemu-devel@nongnu.org; Sat, 03 May 2025 03:59:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uB7mB-0006cY-SL
 for qemu-devel@nongnu.org; Sat, 03 May 2025 03:59:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746259151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rCO405x1iA5TZa/s7VrWx8Lz2D6IP//q8p2gI6CpMtk=;
 b=FQKKUBmZgMcaDSiYM5jDNG8NVZT/kL4mjWu1uoJgtTrV0rvyskzDLTiN2FdRLLxQymkbCa
 A343lpB9kr8X3gRSKcNmu21emc8aQIu3dknvKviQ017fVRIpdcl735V+GLXpLDnNqbvpF6
 EMTZeorokdcl0Qc0ZETadFiCgP2dH+c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-TenHEXkSMOe4-Egg4rUFUg-1; Sat, 03 May 2025 03:59:09 -0400
X-MC-Unique: TenHEXkSMOe4-Egg4rUFUg-1
X-Mimecast-MFC-AGG-ID: TenHEXkSMOe4-Egg4rUFUg_1746259148
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43cf446681cso15678755e9.1
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 00:59:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746259148; x=1746863948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rCO405x1iA5TZa/s7VrWx8Lz2D6IP//q8p2gI6CpMtk=;
 b=VnvUR7JPj9LY4vxfbhtUStmQYlfGcrfYkAjFwFdDSi77hHrCE2gfTypZwbhK/4R8pN
 obnCuMDLJzVzeZJLmJAXodcEhx5qBTyNFcfuMbYc7t0jaAaskCDn4J45U5r0hdTXUgDw
 JvUsJA1cNTVZVi8PQhgGfC1BheLfISFtOGiEBHk/RSKI/472SbCau4EOmHZ3Ag/1tm0c
 ogfjSj368UGjk7IxAJl47oZXdmUV6jJSqqHIZyYkqRAOUPOmRz0zoq9ekuJjySOY6C6e
 BR5nRAli1uM6Wyw9/eTPyDoCjXAyosqAljfSD+HCgHjO+NX9GrtfxsV7OUdujPb51xUG
 vtvw==
X-Gm-Message-State: AOJu0Yzs5kBv4YOS9UUAp/VefBjnyt5VbN1NI6sad1AiieniDT1pNeAe
 aTxhrDV9vCkz2ZEa1Zxv0lYDKJvGJE2MR+jy1X52u9VF7GNupQ3F+i0lJDVY81F5iYXvkKp6N0q
 4t+1sey5A2S9MUE7c2daPKLJItOLFG8TyjEkbOe3gZPPdWNlpFajaAKs/w1YT5tVLbzkY51iEbz
 ChSNWiesyvjTHfOS7CrxLQz2G1A+lC4wb2m+h4
X-Gm-Gg: ASbGncv7Nb3GKtOgIWPasV9gT74y7SJ00ihmSPjTiQTXwuJKn8Wz9wq9KfTk0AJMQJV
 nXcGcwA/tG8xa48uvMY5LKGRO3jRBnUq7KsyHZpm22ze9+8Y+86GcSsgWnXLT/f11JvMQ1Im4vS
 ZMC/B2YyJnEOjJkOCJaFHbsXoYiGqdQPMD9oqlDNvphONb73K70r5oU9rKG6A5N/eB/4FXbmUvu
 8ottdysdcbWzvBUnojiHZA7WBDxGyBo4+tJEfYG4lw9nhd4TQ3Ya1MwhhW1B9Wjdnf53YxC93Yr
 1CYq8Ajsq5NbI7I=
X-Received: by 2002:a05:600c:1986:b0:43d:585f:ebf5 with SMTP id
 5b1f17b1804b1-441c48b03e9mr1597945e9.1.1746259147705; 
 Sat, 03 May 2025 00:59:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSHTe5beqPnSvMYUqqHVp3t1Tw9eA5PQSdaH6GvWhORq2j3L6nGS1jrfbQKAaNzsditSPxEA==
X-Received: by 2002:a05:600c:1986:b0:43d:585f:ebf5 with SMTP id
 5b1f17b1804b1-441c48b03e9mr1597755e9.1.1746259147322; 
 Sat, 03 May 2025 00:59:07 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b2b28082sm111753275e9.34.2025.05.03.00.59.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 00:59:03 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/13] vmstate: support varray for vmstate_clock!
Date: Sat,  3 May 2025 09:58:47 +0200
Message-ID: <20250503075858.277375-3-pbonzini@redhat.com>
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

Make vmstate_struct and vmstate_clock more similar; they are basically the
same thing, except for the clock case having a built-in VMStateDescription.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/vmstate.rs | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 8c4a5bee3c1..9ae97c389c1 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -507,7 +507,7 @@ macro_rules! vmstate_struct {
 #[doc(alias = "VMSTATE_CLOCK")]
 #[macro_export]
 macro_rules! vmstate_clock {
-    ($struct_name:ty, $field_name:ident) => {{
+    ($struct_name:ty, $field_name:ident $([0 .. $num:ident $(* $factor:expr)?])?) => {{
         $crate::bindings::VMStateField {
             name: ::core::concat!(::core::stringify!($field_name), "\0")
                 .as_bytes()
@@ -516,7 +516,7 @@ macro_rules! vmstate_clock {
                 $crate::assert_field_type!(
                     $struct_name,
                     $field_name,
-                    $crate::qom::Owned<$crate::qdev::Clock>
+                    $crate::qom::Owned<$crate::qdev::Clock> $(, num = $num)?
                 );
                 $crate::offset_of!($struct_name, $field_name)
             },
@@ -527,7 +527,14 @@ macro_rules! vmstate_clock {
             ),
             vmsd: unsafe { ::core::ptr::addr_of!($crate::bindings::vmstate_clock) },
             ..$crate::zeroable::Zeroable::ZERO
-        }
+         } $(.with_varray_flag_unchecked(
+                  $crate::call_func_with_field!(
+                      $crate::vmstate::vmstate_varray_flag,
+                      $struct_name,
+                      $num
+                  )
+              )
+           $(.with_varray_multiply($factor))?)?
     }};
 }
 
-- 
2.49.0


