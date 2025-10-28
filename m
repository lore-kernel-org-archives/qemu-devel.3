Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EC95CCF9EB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 17:36:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDnbw-0006a4-8m; Tue, 28 Oct 2025 13:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vDnbc-0006QV-Fp
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 13:35:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vDnbZ-0004jM-0d
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 13:35:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761672931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a574bfKXPLraHbw9jj5peIvYFBrcTFaJN0NoFwezcZA=;
 b=i1WyCTufu0I+kJ0B2QZmH7tOgjz4KyMBseQXe4DE4CT5Sknpe4AJUcuA8y0tN+XTR2oqe2
 g0XCPM3vJeDChovUHJgXyeKBbMlV2lscJwOHBUWYBynLJyDO2oqhAXZxY4nz5mEN+3qaQN
 +FzE5USgoDx4a8Uo6iCqEFz39xv+GDo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-nzvv6ZSXM--4k-6Gt1sIjA-1; Tue, 28 Oct 2025 13:35:29 -0400
X-MC-Unique: nzvv6ZSXM--4k-6Gt1sIjA-1
X-Mimecast-MFC-AGG-ID: nzvv6ZSXM--4k-6Gt1sIjA_1761672928
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4710d174c31so57781205e9.0
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 10:35:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761672928; x=1762277728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a574bfKXPLraHbw9jj5peIvYFBrcTFaJN0NoFwezcZA=;
 b=sAARNm0f/3wEKM/5JU8eMOgK9wEaNJfI7+iC+R7Q+HKf1o5rXHKRxSGx1dtuUM3K97
 xQUlRRJn8ON7I2tW2Lqx6CqZizD1YjrEP6+Xr10z3dI3a7mNsDWHEApurvDyS1WCJbsS
 7rp1N6mgB5JD7so3f+PDgxoqxruqHW/pYDNNc490NJIvp1RkfmxwL53vRnO3bT0AF9jP
 r5ohYIYSE0fovctgAejjW0x3WuuM9PW+yUaH8mAJddc4i2eh02cLyO339GvzvnvpS+Yt
 uzS9Z1kAb5nMiKvbFIYeq+8GkCp3OuB1IjIfto37to0l1dOBUnQh5MbP5+ED54p2dbs+
 ydzw==
X-Gm-Message-State: AOJu0Yw/7yrmMOPQrkzVcZsoNScvPbQ7B9QX4OKAznB5XVKyxqCMDpQA
 GgIp+fBngxGXtGAAn0BHM82wgbcuTUllzXYOs+7CMknyCtUguFWEtmC1g9QHvhD5IsENrrMYAiC
 qspvw407hErrBKfYu1qcTn+hyDjWTEDcDi8Og+daV1i8h3P9TUubIia+Dx/HFaTJRTMf8bW4ch5
 JUt2cwIXnIV2DFP/8y8KGDXeoP+9M4cXksAkMG8F9K
X-Gm-Gg: ASbGnctQRMDEng5Od0dk/6B7pWZb5AgjZsVRvoA4VjHyOFaOsuwNO8+n0UGC/Z5Lffw
 8XuaCd4x432IPDADX1kI+7hU7T39w0po6BhAwBsCyt9Jd17IqaMTD4ZeqBHDmDINr+PuOwBpRbF
 mVUvFGV0CzegJkbv90crXtUC1gMAJ6sU8WVa4WaFxUX4qVcFhKADDx36Cf7lNbv4vu4bWJF5Lye
 w0B8jncSIeIGIUcBOqbzYshy9iCGaLPqvaSDZaFejFPaL69q9wI0wniL0bpzdQVO53AKNVjbKz6
 0qsji5KAM+Ku80l7UXrt/UQRlH1vPdTcIwlKQw95g38n7g5So1+BoZSnQJERAqTFBP4DXm41ymx
 RLZQ81ab7OprxZ1jTk1Wb2wm18MLenssCWeU8D6aIyT0JttDqkJdaeMTnGevt7QcO5jKquMhCEa
 gOWTk=
X-Received: by 2002:a05:600d:8381:b0:477:f2c:2923 with SMTP id
 5b1f17b1804b1-4771e56e32emr536425e9.30.1761672927940; 
 Tue, 28 Oct 2025 10:35:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZnNqbPfLo6BNj/Nj51EuyWMQJ2GPGJ3ogkcjnhMRXiYI+dTiwJPV/kvQsrC0wZ2F5gwmy8Q==
X-Received: by 2002:a05:600d:8381:b0:477:f2c:2923 with SMTP id
 5b1f17b1804b1-4771e56e32emr536225e9.30.1761672927387; 
 Tue, 28 Oct 2025 10:35:27 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.110.222])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771e3b68fesm2201735e9.13.2025.10.28.10.35.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 10:35:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Chen Miao <chenmiao@openatom.club>
Subject: [PULL 18/18] rust: migration: allow passing ParentField<> to
 vmstate_of!
Date: Tue, 28 Oct 2025 18:34:30 +0100
Message-ID: <20251028173430.2180057-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251028173430.2180057-1-pbonzini@redhat.com>
References: <20251028173430.2180057-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The common superclass for devices could have its own migration state;
for it to be included in the subclass's VMState, ParentField<> must
implement the VMState trait.

Reported-by: Chen Miao <chenmiao@openatom.club>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 roms/opensbi                  | 2 +-
 rust/migration/src/vmstate.rs | 3 ++-
 rust/qom/src/qom.rs           | 3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/roms/opensbi b/roms/opensbi
index a32a9106911..43cace6c367 160000
--- a/roms/opensbi
+++ b/roms/opensbi
@@ -1 +1 @@
-Subproject commit a32a91069119e7a5aa31e6bc51d5e00860be3d80
+Subproject commit 43cace6c3671e5172d0df0a8963e552bb04b7b20
diff --git a/rust/migration/src/vmstate.rs b/rust/migration/src/vmstate.rs
index 42e5df8d818..5a237c409ac 100644
--- a/rust/migration/src/vmstate.rs
+++ b/rust/migration/src/vmstate.rs
@@ -268,7 +268,7 @@ macro_rules! impl_vmstate_transparent {
     ($type:ty where $base:tt: VMState $($where:tt)*) => {
         unsafe impl<$base> $crate::vmstate::VMState for $type where $base: $crate::vmstate::VMState $($where)* {
             const BASE: $crate::vmstate::VMStateField = $crate::vmstate::VMStateField {
-                size: mem::size_of::<$type>(),
+                size: ::core::mem::size_of::<$type>(),
                 ..<$base as $crate::vmstate::VMState>::BASE
             };
             const VARRAY_FLAG: $crate::bindings::VMStateFlags = <$base as $crate::vmstate::VMState>::VARRAY_FLAG;
@@ -282,6 +282,7 @@ unsafe impl<$base> $crate::vmstate::VMState for $type where $base: $crate::vmsta
 impl_vmstate_transparent!(std::cell::UnsafeCell<T> where T: VMState);
 impl_vmstate_transparent!(std::pin::Pin<T> where T: VMState);
 impl_vmstate_transparent!(common::Opaque<T> where T: VMState);
+impl_vmstate_transparent!(std::mem::ManuallyDrop<T> where T: VMState);
 
 #[macro_export]
 macro_rules! impl_vmstate_bitsized {
diff --git a/rust/qom/src/qom.rs b/rust/qom/src/qom.rs
index 5808051cd77..84455cea79b 100644
--- a/rust/qom/src/qom.rs
+++ b/rust/qom/src/qom.rs
@@ -102,7 +102,7 @@
 };
 
 use common::Opaque;
-use migration::impl_vmstate_pointer;
+use migration::{impl_vmstate_pointer, impl_vmstate_transparent};
 
 use crate::bindings::{
     self, object_class_dynamic_cast, object_dynamic_cast, object_get_class, object_get_typename,
@@ -182,6 +182,7 @@ fn as_ref(&self) -> &$parent {
 #[derive(Debug)]
 #[repr(transparent)]
 pub struct ParentField<T: ObjectType>(std::mem::ManuallyDrop<T>);
+impl_vmstate_transparent!(ParentField<T> where T: VMState + ObjectType);
 
 impl<T: ObjectType> Deref for ParentField<T> {
     type Target = T;
-- 
2.51.1


