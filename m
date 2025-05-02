Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4445DC3ABA3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 09:01:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAmGO-0006kZ-0e; Fri, 02 May 2025 05:00:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uAmGM-0006hR-AP
 for qemu-devel@nongnu.org; Fri, 02 May 2025 05:00:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uAmGK-0004xx-Ea
 for qemu-devel@nongnu.org; Fri, 02 May 2025 05:00:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746176451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SVdtL49sOwGbUcvuljWA7jXxsATBmy/UlSJlZk7Ssrs=;
 b=VInrMzdNNhlowvN12iPnr6jIGXHWhQo4Hdqx9ki1prxakvl/bYZ9Hkqz9sgWmywtk+dGRj
 9cxC3XPsmiCk9Hp2hDbvuBpNAaqphz5ilndf06rlDTR4Pr1m4WaAGiU3vsWzo5AhBF8WgI
 4j3VTa6JixzxRjOVhupPL3minGGIVj0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-ssaLqLv5NmaqIfMLUfWMMA-1; Fri, 02 May 2025 05:00:50 -0400
X-MC-Unique: ssaLqLv5NmaqIfMLUfWMMA-1
X-Mimecast-MFC-AGG-ID: ssaLqLv5NmaqIfMLUfWMMA_1746176449
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a064c45f03so758864f8f.0
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 02:00:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746176448; x=1746781248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SVdtL49sOwGbUcvuljWA7jXxsATBmy/UlSJlZk7Ssrs=;
 b=emJ80SQB2SVUdrF7sj9akZszppTgUvWSP1iuEkw+OipcoO4xv2l9UKsJeQwtKanVvk
 a1BuHNZ8M/a7hD4Qakz0cSEa2ZMtlmAzK+RKHCLU0xkX2O3u9VTExraQcwI0Td7s+WaS
 WEz6Qgu47ijmIExRFKt8MgZ1wZ5kA4zz4U5UHRLJvzvL7fv4jQGm/8mAsXfHPAckd598
 XcMf+sVYPbAc4S5VkXBSySX4MYczDaEddSYo1vAOMCfjz4UDL5TdpqTXYeSHjKoxgn6+
 F2Fn0Zh9OawupuJcW5CoaI8L5TAGEMdXTq6IVJtV4tEOsrYEYQnywnsowWcyFpfR9Nbv
 E3RQ==
X-Gm-Message-State: AOJu0YzGOQK0RRwVxUiFCIjG5UXtZl2RwJwv7PDX/3Hy3HryIYcuDAcQ
 hibtOMA/n7GgcI6qrIRlB8HcLw0nXz5dI7fty7aRG0iHqvJXtFAkV00PhC2G9AZcVPmJ+eUDA5a
 n8eo+TtB4bl0Dh0LrbScpAuR5Vzw2lwcb9SE6nepRodZlhx0vidBo1955ywIqDxBQkuoleNrM38
 3TiavaZUa5Jqk+z31jcyXnF+MMf65fxqRXci8I
X-Gm-Gg: ASbGncvqi+Yo2hVX6hgu6EhrKc7eLyBEVBJEsrGnm9Wc5Ghj4GzM5ogGrxQRVbFagzF
 4paVAMSYPBC70+tmXB9PdNJqyB3G3b8gxdLKgOTW2PsRm8QOfiv3lldFdoU+nzMn5I6CveiVhlp
 G9LihO8ypAdIGbqyO1ljuBSjt0v7unesYht11Q7X0Zf5o6AgAneuRJz4zyf8JkynNGuwaPHYJND
 HaLcEc0hktBHaVq0O4HUG7DD/MHhsV3+Biv1M3VPnWkwA+TW8pXmwu3Ho781rRXMlufYdVwOPCv
 vvLp/PCCGR1nnUA=
X-Received: by 2002:a05:6000:40c9:b0:391:b93:c971 with SMTP id
 ffacd0b85a97d-3a094058683mr4165664f8f.20.1746176448016; 
 Fri, 02 May 2025 02:00:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHm25j0Nsvu5M2HoQeEQs5LoUFhkGNDq1rFjU+ziHrFWu39A0tvrGRqLp+V/+6SpRaTrYubsQ==
X-Received: by 2002:a05:6000:40c9:b0:391:b93:c971 with SMTP id
 ffacd0b85a97d-3a094058683mr4165631f8f.20.1746176447641; 
 Fri, 02 May 2025 02:00:47 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b2b20a65sm82883545e9.32.2025.05.02.02.00.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 02:00:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	zhao1.liu@intel.com
Subject: [PATCH 1/2] rust: vmstate: support varray for vmstate_clock!
Date: Fri,  2 May 2025 11:00:43 +0200
Message-ID: <20250502090044.85557-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250502090044.85557-1-pbonzini@redhat.com>
References: <20250502090044.85557-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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
index 7d9f3a2ca6f..98152e5964d 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -506,7 +506,7 @@ macro_rules! vmstate_struct {
 #[doc(alias = "VMSTATE_CLOCK")]
 #[macro_export]
 macro_rules! vmstate_clock {
-    ($struct_name:ty, $field_name:ident) => {{
+    ($struct_name:ty, $field_name:ident $([0 .. $num:ident $(* $factor:expr)?])?) => {{
         $crate::bindings::VMStateField {
             name: ::core::concat!(::core::stringify!($field_name), "\0")
                 .as_bytes()
@@ -515,7 +515,7 @@ macro_rules! vmstate_clock {
                 $crate::assert_field_type!(
                     $struct_name,
                     $field_name,
-                    $crate::qom::Owned<$crate::qdev::Clock>
+                    $crate::qom::Owned<$crate::qdev::Clock> $(, num = $num)?
                 );
                 $crate::offset_of!($struct_name, $field_name)
             },
@@ -526,7 +526,14 @@ macro_rules! vmstate_clock {
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


