Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96271C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 15:38:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhroc-0007db-JN; Fri, 01 Aug 2025 11:37:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mkletzan@redhat.com>)
 id 1uhrFy-0008Td-Ko
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:01:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mkletzan@redhat.com>)
 id 1uhrFq-0000PO-S6
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:01:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754060462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m4GgfrFhV1Kr06Y/gRom0+hi3JwWpWM8uAug65G2aKQ=;
 b=Db3lokvZ7XZLwxiuL4evZYJiXfJI0NbwipHgzLoF9CEBGJ2fSw3UZXiSKaYXkMzO15jYyr
 SiIvftDIKOgPgzvZlvWOnpcjUEldpUIT/jWN43NUeFYpTXWHfcDUXmNYetm7QCNozlzws6
 CDbCWfi5aIIJOCVzHXDGGWH32Glv5R8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-SCEQKkcROqijM8MYrlNT3Q-1; Fri, 01 Aug 2025 10:59:54 -0400
X-MC-Unique: SCEQKkcROqijM8MYrlNT3Q-1
X-Mimecast-MFC-AGG-ID: SCEQKkcROqijM8MYrlNT3Q_1754060393
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4561dfd07bcso8503715e9.1
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 07:59:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754060393; x=1754665193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m4GgfrFhV1Kr06Y/gRom0+hi3JwWpWM8uAug65G2aKQ=;
 b=QwxejFFZ7q0Mjb5SrpV1xS3HMzUdb7uqzO1tQ0La4B0UgEjEAKEx8RjufZGlMWJLtx
 VMk9LBbSbQosS4KvK3+cYP/clvNIpmuxnT2GopIpbG6435iMn6qT6XWcNfejzZqIexVE
 coadaVS5EY1x8fpAmAbguriDiaQYMx6qHpA9ZqOkwT0s/+xWAybbCbDJKn79+XDF02b9
 ZSjSS6hNHBIfrD/Q/Xbta47U4BiU9KkTTfgLA29tKSx06R9+SRzWJqDmxZsAN6fdAu7U
 USXTi8knYtaBMgM6loNxRScNLhdgabccaw3Vo/RwSWIwTHowftK8u9Jb6NnXE/m2Gg69
 MlMQ==
X-Gm-Message-State: AOJu0YzgsnmDTIBtyvVJQog+pSNUBTg/qidIPV/lKD6nM7YXvU6RxPAT
 tKtgPI2daqxs/q4/CUfQQEkHYqW2MkkEnXA0fzRoo6sQL+G6S4OgKXwwFynRFOfyh+zhhRdraUJ
 ltE3nH3uQ4QQBSp59M8ITwpJqaNo3P1F4L1Nt40hVY1t4nyKFIDkBmiLJ
X-Gm-Gg: ASbGnculq/Y46n0jzVZ77l+U2soP0RDWoqbX9rBduyeX8QedNJI1BoavlQRISSAM+GN
 p4flyUzO2x+k2SFzVzhiNLSk0S82P0oc1DJkPnQaYuoqFSIMKsklIvabnOx5UGBphr3LtRWu/5t
 QwLRiZmDmhx+KYgc2jAZapzBzuDVRwFCOlILdsUKsKaXpQ0XdxnwP7lQ4LEPgi4xj9KwosmJ9M8
 hqzROw9468rkLns5BarjDvGvz9zzsZwr13P22r+22QcqJZWsGdU0SHcpoHadgShIB5Q4tHDe3KQ
 4Pq80+lz8fVAdvpIJ7p65Wxl2j0Vvwjg03PhaM5dg3as0emy
X-Received: by 2002:a05:600c:c4a2:b0:450:ceb2:67dd with SMTP id
 5b1f17b1804b1-458aa4636cdmr24104175e9.33.1754060392978; 
 Fri, 01 Aug 2025 07:59:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpAaGpuW4PG6FOT1Zg8v45B3c99iWIUZCeh737ACA8E8ljCIdZubk3Xhouql36EWdB5FrjEw==
X-Received: by 2002:a05:600c:c4a2:b0:450:ceb2:67dd with SMTP id
 5b1f17b1804b1-458aa4636cdmr24103945e9.33.1754060392500; 
 Fri, 01 Aug 2025 07:59:52 -0700 (PDT)
Received: from wheatley.localdomain ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458af87a773sm14938815e9.1.2025.08.01.07.59.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 07:59:51 -0700 (PDT)
Received: from wheatley.pinto-pinecone.ts.net (wheatley.k8r.cz [127.0.0.1])
 by wheatley.localdomain (Postfix) with ESMTP id 20617C5A9A3D;
 Fri, 01 Aug 2025 16:59:51 +0200 (CEST)
From: Martin Kletzander <mkletzan@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-rust@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH 1/2] rust: Add antoher variant for impl_vmstate_struct! macro
Date: Fri,  1 Aug 2025 16:59:49 +0200
Message-ID: <ad68bd5bdf4148770e3750fca4f14d0ae794538d.1754060086.git.mkletzan@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1754060086.git.mkletzan@redhat.com>
References: <cover.1754060086.git.mkletzan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mkletzan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Martin Kletzander <mkletzan@redhat.com>

In some cases (e.g. in vmstate_tests.rs) the second argument to
impl_vmstate_struct! is actually an existing struct which is then
copied (since VMStateDescription implements Copy) when saved into the
static VMSD using .get().  That is not a problem because it is part of
the data segment and the pointers are not being free'd since they point
to static data.  But it is a problem when tests rely on comparing the
VMState descriptions as pointers rather than contents.  And it also
wastes space, more or less.

Introduce second variant of the macro which can, instead of the
expression, take an identifier or what looks like a reference.  This
second variant is added before the current variant so that it has
preference, and only references the existing static data from it.

This way tests are fixed and space is saved.

And now that the VMStateDescription checking is fixed we can also check
for the right value in test_vmstate_struct_varray_uint8_wrapper().

Signed-off-by: Martin Kletzander <mkletzan@redhat.com>
---
I'm not sure whether this is caused by different utility on my system or bash
version or whatever, but without this patch these three tests fail for me and
this patch fixes it.

 rust/qemu-api/src/vmstate.rs         | 11 +++++++++++
 rust/qemu-api/tests/vmstate_tests.rs |  1 +
 2 files changed, 12 insertions(+)

diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index b5c6b764fbba..716e52afe740 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -449,6 +449,17 @@ macro_rules! vmstate_validate {
 /// description of the struct.
 #[macro_export]
 macro_rules! impl_vmstate_struct {
+    ($type:ty, $(&)?$vmsd:ident) => {
+        unsafe impl $crate::vmstate::VMState for $type {
+            const BASE: $crate::bindings::VMStateField =
+                $crate::bindings::VMStateField {
+                    vmsd: $vmsd.as_ref(),
+                    size: ::core::mem::size_of::<$type>(),
+                    flags: $crate::bindings::VMStateFlags::VMS_STRUCT,
+                    ..$crate::zeroable::Zeroable::ZERO
+                };
+        }
+    };
     ($type:ty, $vmsd:expr) => {
         unsafe impl $crate::vmstate::VMState for $type {
             const BASE: $crate::bindings::VMStateField = {
diff --git a/rust/qemu-api/tests/vmstate_tests.rs b/rust/qemu-api/tests/vmstate_tests.rs
index 2c0670ba0eed..7d3180e6c2ea 100644
--- a/rust/qemu-api/tests/vmstate_tests.rs
+++ b/rust/qemu-api/tests/vmstate_tests.rs
@@ -320,6 +320,7 @@ fn test_vmstate_struct_varray_uint8_wrapper() {
         b"arr_a_wrap\0"
     );
     assert_eq!(foo_fields[5].num_offset, 228);
+    assert_eq!(foo_fields[5].vmsd, VMSTATE_FOOA.as_ref());
     assert!(unsafe { foo_fields[5].field_exists.unwrap()(foo_b_p, 0) });
 
     // The last VMStateField in VMSTATE_FOOB.
-- 
2.50.1


