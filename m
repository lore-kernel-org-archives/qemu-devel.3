Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D41CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 11:39:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDi2F-0007pA-Ly; Tue, 28 Oct 2025 07:38:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vDi2A-0007oX-Qs
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 07:38:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vDi25-0004uw-EQ
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 07:38:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761651506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=a574bfKXPLraHbw9jj5peIvYFBrcTFaJN0NoFwezcZA=;
 b=ebr9xNe1JcMIRumqFvGTNSn88WLhkBUuht6QxLkQwMOxyULA45ch2EiAqRGNthwMKNh2aV
 PcaWgS7cgsIhhIJPP/u/RFMWd3mWnHQ93lp5c31kaoVMXedi0wR685iCBw3hpRk0jvXs64
 GQMa/dLYMQQzXZ1GNmo7jCMosMwoGjY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-Ru286tihOKCqkPtazumPRA-1; Tue, 28 Oct 2025 07:38:25 -0400
X-MC-Unique: Ru286tihOKCqkPtazumPRA-1
X-Mimecast-MFC-AGG-ID: Ru286tihOKCqkPtazumPRA_1761651504
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47717c2737bso2719115e9.2
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 04:38:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761651503; x=1762256303;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a574bfKXPLraHbw9jj5peIvYFBrcTFaJN0NoFwezcZA=;
 b=ceQ4Zmbh31LCgMiSKmJqehX+/zapDgGjAEgueJd5dx0pvEeeE8h1aquSivvE/0Lp7R
 P+bhKONWhlRIKBj/JTZeDUDTD3Er13yvGCGo7SPTMMMbfIDdhDE1sjH5yGT53dtDFjyA
 zjfotw49RtQhPj9+1gwH9ppLYUgCr5JWbTDtj2S/9H3qrfwyca753friVCX8iPY81zJi
 z5PpVqGBPaTHWkF8cEAzwjBZ31JMn8IGbavE3kvkJscJXXwSSANLoNIJ6weGRkt2NgBN
 DRXFTBuoiYNeuV5Bgke7fCEnIvtsC1yT7W5V31eSXy+eugseyGi90kOMZ4ctJScx7VBF
 yLqg==
X-Gm-Message-State: AOJu0Yz+WssdkZKO0r1h5nRqTOXs2Jw6kPMg+XNsysYTZjyzceKz9Ubx
 /BKdPpw33dxLrHnD/Qdne6ozokSNIs4jdbIQWqrkgZkluSzRK4qaFRo85eP46HI0VZr9VaCPljQ
 +0rRtL7qGDrOzbEdh5PUr2mkBSiz/pf2QFmzVVA6ihc8qwDX+CuMOpML9Sm0R9lR3hPAFpslVdj
 M/eNAxGpnxDMmiFd9ur+li1pXIwwaWs5dZLKXIKfwh
X-Gm-Gg: ASbGncsusPA5x9WMgsmcaoKSOwXZkGti/fJGdoLRf8304SlK+SGUOyjgIa2c0w23i6g
 vRn9fwX9YbviYOJeoNiT8O/9t1K8IArcg8hMu4KuhvebMLtO36FafxtQ+57joX+joZ49IxuBhtq
 vE1sNoZ0FmFzt1eH70py3XgFrv1UsiFC0isd4WZxhTAeyi9JP0IkNGUIhGQVIBv6K4iaUvUxmsh
 H8UYI+uBqOvbGka4sCR/C6H+fPdu1MXvBzfv3CBS6kawtlCEUjsFfpnvYvjG7iJJXgq6SXjKPR9
 P01qFm4YUXtmqu475GZv3scKndNx2HsmhzJGlVYyDjXei3QrgcxFxW8t4/fdrrHspezHnXGPAwH
 1PEzPCxv6nv0sL7KyIwVCVZC2vIQkBxWlAZG1wrtsJTBoHOXkLXGdSeSgpLi2US9hm27DVEP+3P
 Bihog=
X-Received: by 2002:a05:600d:6348:b0:477:1be1:9afe with SMTP id
 5b1f17b1804b1-4771be19d6emr7058705e9.9.1761651503419; 
 Tue, 28 Oct 2025 04:38:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFv0jNmYx0Af9PZs2AJZV5+nVN6X2LPf/KrXe3m1I3ko4nYkjq0LPFaael3P2zvvhQRRJykIA==
X-Received: by 2002:a05:600d:6348:b0:477:1be1:9afe with SMTP id
 5b1f17b1804b1-4771be19d6emr7058525e9.9.1761651502939; 
 Tue, 28 Oct 2025 04:38:22 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.110.222])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771bc597c7sm7614935e9.1.2025.10.28.04.38.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 04:38:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	Chen Miao <chenmiao@openatom.club>
Subject: [PATCH] rust: migration: allow passing ParentField<> to vmstate_of!
Date: Tue, 28 Oct 2025 12:38:21 +0100
Message-ID: <20251028113821.1736215-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


