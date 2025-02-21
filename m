Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 977C4C021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 17:04:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlWRQ-0006jn-Ar; Fri, 21 Feb 2025 12:03:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tlWRN-0006cI-VF
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 12:03:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tlWRM-0001OE-0E
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 12:03:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740157431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0g4/7JXprhjHS9Kq/Ky0pszdlpKOhaBkh9IAViO+mbo=;
 b=RRxcsidf7qenxIGKhtBe8ZxQrVHMCBiw4OuIqo5xsYaDadZu5orBM6QyrPAdHvduamP4UF
 EY2P7BWHmt61qvGoGE/OW3UH+UPTwNP1tA4u9YxXSPqKKi/xQWuXcd/0qaTzzhFUkgV+Mu
 gNrvY+p8kXebBoyCLm4iHewl9tlbEvA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-O_1whEdTPeKCF4scU9v1LQ-1; Fri, 21 Feb 2025 12:03:47 -0500
X-MC-Unique: O_1whEdTPeKCF4scU9v1LQ-1
X-Mimecast-MFC-AGG-ID: O_1whEdTPeKCF4scU9v1LQ_1740157426
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4393e873962so12153655e9.3
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 09:03:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740157426; x=1740762226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0g4/7JXprhjHS9Kq/Ky0pszdlpKOhaBkh9IAViO+mbo=;
 b=ec8oj/dmd6UqEB8tF2fjcco0Zvt5GPok8K3Q27c4z0itdBaOoQ6pId5877xP7+B0Lu
 XlLZZG8vMSAk8iL5AZvh1JB7FhZlWc2iJsHsFuvkBz8a2MTB8Ji5ljonf1KFx7sMMFMT
 a3xthBodab1WgB5GOJb05CWcjANgKG/fts3ldrqEItKeseN8ZZPtI6TVQmqzKx9CgcFn
 XJqoK8V9tSXvEtEhAZvZgX12Eh1BZr2I2VYlk+UW679zWDLEoMIzt1gXz+pXkXDttu90
 U2Gv0qYjkZS8wAsFMVJxTI+Dc6tBLp9eT1bOIWKpviZRao5FKgmSdyRMuQIGIBfYvwKb
 Vksw==
X-Gm-Message-State: AOJu0YyZzc7Y4MXG8WX/zML4cRf4Jq9kUqWk+EFbE7fg90nN3MbLeayA
 W5kqxrbacBEgsvxzziAJRc63q4G4DOVjgriPagX96YLU+HZ7Blr3Ze627WWxBFn8r0kTlWb0+mQ
 Onki3CGZi5OC8Mwz598PvLi4XLWSwXm78I/PHf/w0uVGpOKFDCXo7CKk7ALrjcOKUXKHyopqtro
 OiYU4ONOSx9Z9PqMPeMvxtB2eyIpPQD4kWqKKuO1o=
X-Gm-Gg: ASbGncsa2U9YjKpYPQRdjovFMepSO3ytw9+YXnN6yHWwON6CYWLe3tSb5Ewmb2k7hwv
 W4mx+ECHWD6O+YAq2m73xnheGX6AC1eLz6gsAJTSmKufi6x6dKrLIJnG3rtcuup9U2jF9pJRPmC
 1Akgn8QhCuHYj57dxhKL4BFxzK2JSF0n084jIh8l49VnU9W4nNKTQGny0v1tkcDv1EC31l9+/ST
 jBhFSSUYS4Gb+1OetleT4Znhxnnj9Rib7thR6NFLTl7A+5M1LFgkgYHj3YZ+Bt+fiX4FGBgZW/S
 HRg9KLWKS9pqD9vAT0I=
X-Received: by 2002:a05:600c:4ecc:b0:439:84d3:f7ee with SMTP id
 5b1f17b1804b1-439ae2189bemr27774635e9.24.1740157425843; 
 Fri, 21 Feb 2025 09:03:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHtZV5PSFgZqTOdAUJyQQTcqb6e++ndjRbyVA7u2lzRkwjkjWYbB7b6ugUaJc4QQsNIsJE8pg==
X-Received: by 2002:a05:600c:4ecc:b0:439:84d3:f7ee with SMTP id
 5b1f17b1804b1-439ae2189bemr27773765e9.24.1740157424715; 
 Fri, 21 Feb 2025 09:03:44 -0800 (PST)
Received: from [192.168.10.48] ([151.95.61.185])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b0371b7bsm23277985e9.33.2025.02.21.09.03.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 09:03:44 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 01/15] rust: add IsA bounds to QOM implementation traits
Date: Fri, 21 Feb 2025 18:03:28 +0100
Message-ID: <20250221170342.63591-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221170342.63591-1-pbonzini@redhat.com>
References: <20250221170342.63591-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Check that the right bounds are provided to the qom_isa! macro
whenever the class is defined to implement a certain class.
This removes the need to add IsA<> bounds together with the
*Impl trait bounds.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/qdev.rs | 2 +-
 rust/qemu-api/src/qom.rs  | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
index 3a7aa4def62..c4dd26b582c 100644
--- a/rust/qemu-api/src/qdev.rs
+++ b/rust/qemu-api/src/qdev.rs
@@ -86,7 +86,7 @@ pub trait ResettablePhasesImpl {
 }
 
 /// Trait providing the contents of [`DeviceClass`].
-pub trait DeviceImpl: ObjectImpl + ResettablePhasesImpl {
+pub trait DeviceImpl: ObjectImpl + ResettablePhasesImpl + IsA<DeviceState> {
     /// _Realization_ is the second stage of device creation. It contains
     /// all operations that depend on device properties and can fail (note:
     /// this is not yet supported for Rust devices).
diff --git a/rust/qemu-api/src/qom.rs b/rust/qemu-api/src/qom.rs
index 3d5ab2d9018..10ce359becb 100644
--- a/rust/qemu-api/src/qom.rs
+++ b/rust/qemu-api/src/qom.rs
@@ -37,6 +37,8 @@
 //! * a trait for virtual method implementations, for example `DeviceImpl`.
 //!   Child classes implement this trait to provide their own behavior for
 //!   virtual methods. The trait's methods take `&self` to access instance data.
+//!   The traits have the appropriate specialization of `IsA<>` as a supertrait,
+//!   for example `IsA<DeviceState>` for `DeviceImpl`.
 //!
 //! * an implementation of [`ClassInitImpl`], for example
 //!   `ClassInitImpl<DeviceClass>`. This fills the vtable in the class struct;
@@ -497,7 +499,7 @@ impl<T: ObjectType> ObjectDeref for &mut T {}
 impl<T: ObjectType> ObjectCastMut for &mut T {}
 
 /// Trait a type must implement to be registered with QEMU.
-pub trait ObjectImpl: ObjectType + ClassInitImpl<Self::Class> {
+pub trait ObjectImpl: ObjectType + ClassInitImpl<Self::Class> + IsA<Object> {
     /// The parent of the type.  This should match the first field of the
     /// struct that implements `ObjectImpl`, minus the `ParentField<_>` wrapper.
     type ParentType: ObjectType;
-- 
2.48.1


