Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2904CD3B7E7
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 08:06:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFU6O-0004sd-3U; Mon, 25 Nov 2024 03:05:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tFU6E-0004qN-5S
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 03:05:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tFU69-0007Kw-M7
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 03:05:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732521933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CgzaI2zMMeW5+NpW/m1snFUEJdiAuzPs3THN4ondNBU=;
 b=OhRAcMtA+8TUtQSlVMfQ+pLe2gauzMdOkkFlpjF/9nPiXRyHx/hIovZ32YgkuKMa/Vrr8h
 FZIEipYS/AuE7R1s6U7CvISgl2PXRDg56+9fN3Ewq2yJGbwXh4552iNwYs2hKrTUCsERxT
 SQd8EV8U7WpAlWCwVnTCr7ad/s1HaPo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-BPMkPhxuPamFrBSouJw-Ng-1; Mon, 25 Nov 2024 03:05:30 -0500
X-MC-Unique: BPMkPhxuPamFrBSouJw-Ng-1
X-Mimecast-MFC-AGG-ID: BPMkPhxuPamFrBSouJw-Ng
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-434941aa9c2so10672055e9.3
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 00:05:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732521929; x=1733126729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CgzaI2zMMeW5+NpW/m1snFUEJdiAuzPs3THN4ondNBU=;
 b=rf8SZQ4D8X1NzCF0KVQx2DIYpZLsY5ggc+4lFwU+DG9qSBYNpf1AzPyGvNJKCuqvea
 9lA6BazUm+dsTJqaqV2H2hzLGeFVqRoNNUh0riOHlyqlUR12tXpjWYHJB+vAdzQd4MSo
 fvsOkGEfRiXtkTv4ZnDeLyf/l/HWtLbEmowGJMqGlYJfN0MheMW0LmGsz4F4SYiDjlAk
 qpAydv7e38Mjq3Lfc/4q40/tNNm14JWGx4EluOsBoZKHkNDMSR40w4cDiOwGgV3TTN8s
 V+d+E4awJGUVezQEgwG0+ILbidcf9z6l7LXS7kpQz5HRccIQyr8Zk+mI5OieD5fSXGZ4
 xejw==
X-Gm-Message-State: AOJu0YzhWvBgaYTs1q+pvQQB6so6Ifn08RdXK3M0AAghat7S4e5W5lsk
 H25Om65dneT9S9lZ/WqNeWtYY7OC6AUtVL51YADulY/pqbJTd5RsQk1mIDuGIpsjfICOborbkOa
 xgw5Kcjo1ep6KsbUrAED002fehAkkLpWfbSmKW33XAj0B0kKkSpLnECvj9vrNOEf8YXlID1MuDn
 Sv1H67oWwUqTFBeS+gn8/n1IAQ78bdtbyZa2L/
X-Gm-Gg: ASbGnctkvCJ56twXA/UVPzHzETuzCbNm+S2x4Jucdrt1IC9c2Aoj1N2K2QbpQG6jnqv
 CuqV+W2GT0sKN2OU3W+lnoCHJZzBKrp8ucQflTKAEkdDtTzXzvh8BJYAiWeaWQD13SG6PFBSKHj
 SJAK2PxJBTpIYber0BPOoz4N7TsPTK0Gbrrr54Gb5gX0gRdol1WRTW/ozv5D5r8066cRBid7Dai
 NtMpM+z1XTLOJOynCg8d5FjpssvkmAoEgcr2Bqu/7cpCcS98RZM7ic=
X-Received: by 2002:a7b:cb52:0:b0:431:6153:a258 with SMTP id
 5b1f17b1804b1-43487435826mr98689435e9.13.1732521929197; 
 Mon, 25 Nov 2024 00:05:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOhZoHrQ8RiZT4d903DCs85RPE9opYKq+CJaHW2LudvN8tkaa/a33obrwmh7uA+8yZ/GCxkQ==
X-Received: by 2002:a7b:cb52:0:b0:431:6153:a258 with SMTP id
 5b1f17b1804b1-43487435826mr98689185e9.13.1732521928794; 
 Mon, 25 Nov 2024 00:05:28 -0800 (PST)
Received: from [192.168.10.47] ([151.49.236.146])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43499da3eccsm45296925e9.1.2024.11.25.00.05.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 00:05:27 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 7/8] rust: qom: automatically use Drop trait to implement
 instance_finalize
Date: Mon, 25 Nov 2024 09:05:06 +0100
Message-ID: <20241125080507.115450-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125080507.115450-1-pbonzini@redhat.com>
References: <20241125080507.115450-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Replace the customizable INSTANCE_FINALIZE with a generic function
that drops the Rust object.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/definitions.rs | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/rust/qemu-api/src/definitions.rs b/rust/qemu-api/src/definitions.rs
index 0467e6290e0..d64a581a5cc 100644
--- a/rust/qemu-api/src/definitions.rs
+++ b/rust/qemu-api/src/definitions.rs
@@ -8,6 +8,13 @@
 
 use crate::bindings::{Object, ObjectClass, TypeInfo};
 
+unsafe extern "C" fn drop_object<T: ObjectImpl>(obj: *mut Object) {
+    // SAFETY: obj is an instance of T, since drop_object<T>
+    // is called from QOM core as the instance_finalize function
+    // for class T
+    unsafe { std::ptr::drop_in_place(obj.cast::<T>()) }
+}
+
 /// Trait a type must implement to be registered with QEMU.
 pub trait ObjectImpl: ClassInitImpl + Sized {
     type Class;
@@ -16,7 +23,6 @@ pub trait ObjectImpl: ClassInitImpl + Sized {
     const ABSTRACT: bool = false;
     const INSTANCE_INIT: Option<unsafe extern "C" fn(obj: *mut Object)> = None;
     const INSTANCE_POST_INIT: Option<unsafe extern "C" fn(obj: *mut Object)> = None;
-    const INSTANCE_FINALIZE: Option<unsafe extern "C" fn(obj: *mut Object)> = None;
 
     const TYPE_INFO: TypeInfo = TypeInfo {
         name: Self::TYPE_NAME.as_ptr(),
@@ -29,7 +35,7 @@ pub trait ObjectImpl: ClassInitImpl + Sized {
         instance_align: core::mem::align_of::<Self>(),
         instance_init: Self::INSTANCE_INIT,
         instance_post_init: Self::INSTANCE_POST_INIT,
-        instance_finalize: Self::INSTANCE_FINALIZE,
+        instance_finalize: Some(drop_object::<Self>),
         abstract_: Self::ABSTRACT,
         class_size: core::mem::size_of::<Self::Class>(),
         class_init: <Self as ClassInitImpl>::CLASS_INIT,
-- 
2.47.0


