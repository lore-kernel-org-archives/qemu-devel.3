Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D78C3ABA3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 09:01:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAmGP-0006nx-Vr; Fri, 02 May 2025 05:00:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uAmGO-0006l8-Hw
 for qemu-devel@nongnu.org; Fri, 02 May 2025 05:00:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uAmGM-0004yO-RM
 for qemu-devel@nongnu.org; Fri, 02 May 2025 05:00:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746176454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LqeniZgXmPTdrTI+xq1XQTwnSc7B7nOzlTpRU2OjaDw=;
 b=TY3GMfrlEc1weiUR5Q347Z5Ws44AsCuXbx6P7gxdi/lbKb8BgyhB8xdFYLNxU8N6lK2RlC
 Lh48ffL3hAr7uMxtd3gKBj3AkUvX1jerIhzar6LKL9CTN9AKEp2S2kADagAmnnjravoD8y
 LcHyEbCp2S6Glqp4i6vxDSkSvxqFe7k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-eLF1UTk5NZ2AQ0LcMQnDKg-1; Fri, 02 May 2025 05:00:52 -0400
X-MC-Unique: eLF1UTk5NZ2AQ0LcMQnDKg-1
X-Mimecast-MFC-AGG-ID: eLF1UTk5NZ2AQ0LcMQnDKg_1746176451
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43cf3168b87so6941765e9.2
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 02:00:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746176451; x=1746781251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LqeniZgXmPTdrTI+xq1XQTwnSc7B7nOzlTpRU2OjaDw=;
 b=XzEnv8ei14F6LyltrHmJrUMzdKVKnC8j1GTh+RKy1Pio53FJy97SJTIh2EbhYZpE6N
 Xv26GmXKwifVVZVo3OZGLqXNQBpy0CTuujQBDPSRx6K5fGnSozy9eAiOUrWlvu6m6i0v
 16Ios+JidpEcTe5qNjKMDUyWS2v5uLETA/B5Xyt13NqRvgZezQCAOAdEOBPe/5t3jyaq
 eSNYyxVBTnH0HSDaojHMj6kRPpNR5TnQFxLZrWTlNHEs46SuEb6p6h5LXY0YimtjeeS1
 qn1ub0G68HjM/4wCO9sn/12SXB7v5e9MjwZ1FP9+G8M96G0EIFzkQlk9ofuTtxGrK8pD
 WNiQ==
X-Gm-Message-State: AOJu0YwkEktpb+VRiYlteh4+izOC+QSqGJSqVyXQPrA5HGUdxXpTG6pq
 2otYfkrRiPyyCkEO33dV0CzGvCPeURaaHvBjwAOkHTURJWOH5YFLqwZmdAKv/3IEtWPqdxXI1Yu
 9bLFuzbtDXs714Sb6KpUL51dwHTuDh/e4I6SFeyeinC4SZxaA+ZEsfG4wnMpB5NGgDIiB851kpt
 LSybwqUR3lGYYC5a3Iyfbra7aflvntcataL0k0
X-Gm-Gg: ASbGnct5aJoGEodrNuTQlVcscksI+aaneanURfOgEKgVV9ETphXjNM+iMUYWUeNNjV+
 P0AS3iDpwX6UPr4AOYP+1Pc9ItiSGlt5hxH7PjgLTGkIUDLA5dqF/IHD7Vz0ZF0KY7MIEeAHjcF
 I/yRz9wMyh7exly46agYo0DBiQpV8sLVEqDdyfWpoFhCwnP6Mt1DMopiznkZIegGyA/8JGKUrf4
 ajqe5TyaSlCiVnQjfoWTK8EG2zLPf1BUQCy85S6pzSwpMfd+wVjKv3Y3e8yCPBqEbhB/GBrYGVM
 /NlTIxdcWcA2Pww=
X-Received: by 2002:a05:600c:350e:b0:43c:e478:889 with SMTP id
 5b1f17b1804b1-441bbe2c815mr15376105e9.0.1746176451016; 
 Fri, 02 May 2025 02:00:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+tzGHivF2o1epk5esBZ6yOZ/tw87gcc3F+4KjQOedrrPJ6XNosdMscmRTR4AVNNmWzkRMKg==
X-Received: by 2002:a05:600c:350e:b0:43c:e478:889 with SMTP id
 5b1f17b1804b1-441bbe2c815mr15375545e9.0.1746176450510; 
 Fri, 02 May 2025 02:00:50 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b8a2873csm37255055e9.30.2025.05.02.02.00.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 02:00:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	zhao1.liu@intel.com
Subject: [PATCH 2/2] rust: assertions: Support index field wrapped in BqlCell
Date: Fri,  2 May 2025 11:00:44 +0200
Message-ID: <20250502090044.85557-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250502090044.85557-1-pbonzini@redhat.com>
References: <20250502090044.85557-1-pbonzini@redhat.com>
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


