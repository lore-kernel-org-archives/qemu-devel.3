Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4CDDC19F32
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 14:21:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnelj-0000io-Oh; Thu, 27 Feb 2025 09:21:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnekr-0007Ot-QU
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:20:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tneko-0003oQ-2M
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:20:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740666044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VMmBZwWfeUJ0S3v0Efj9vDO4/Kt8kiAMYCBrnhv0TtQ=;
 b=UdX+0w+WuRqtX5hQsMK9ynayCjkZIikr8auAco8tJ4ifchG+qsePEg38pBAlGw8ZJ363Pe
 3Mv77cBlBiZOJxMx8f7g/cFtIA+pjxIRAHDdQ7Cz/5PuLySxwV4PSoR9VpdvijRNbVLRAX
 xwgaeGbQugww1FiLuTHOIza5+bjj5b4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-mk5VR0o9NUyKfWUsrdcrDQ-1; Thu, 27 Feb 2025 09:20:40 -0500
X-MC-Unique: mk5VR0o9NUyKfWUsrdcrDQ-1
X-Mimecast-MFC-AGG-ID: mk5VR0o9NUyKfWUsrdcrDQ_1740666040
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5e4987b2107so1060025a12.0
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 06:20:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740666039; x=1741270839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VMmBZwWfeUJ0S3v0Efj9vDO4/Kt8kiAMYCBrnhv0TtQ=;
 b=oVTkgvy9jokgOQFubeiEd3Ro80V9aMG4erF1w30RuAnuIF2x1AyrfloSB7Gn4IwLZr
 mptTnS2eFXTfZRlzunoILCmJJbOKrtPPrKXWmKmxKHWi9gbWiwmgr3bABnnTenPrCEdk
 Qbg7MkF1ZILe/UX1rrwPpXXyN3LAznJP7wrf2u4QSBCWslcV1pJ8aHmTdqtbUuxdH57Z
 V4OLkUkgdXNBt6EzdWEz3tQMHKNiBnnRYQ9YA37DJdTupF9hSpwpWY67jbKhFYQNDung
 LHa8EruT+Ken6ZxkIjOKUXTB0J5PFOSX8cPCG6InV9uYLXbu6a52EQ79YRxSk4fKbl7B
 Jrpw==
X-Gm-Message-State: AOJu0YyYq99A1J/XlJxLl9bj8hkL9bktOMKArCxbjSYtzQ45J2w0LG0a
 kmSsH6P64wiq3MmHn4i/IsVQd/qP00Tx6gT5Nu6qbv/qt20LzBVmtBamQQsv6sg/R9UfTGOwMqV
 PHH5E37JZy0ySEEYloapMr+rouEhteQu/lNvP2zDnBfvNpX/6eI1FdBqns0B/X/Da68Sn6BHhLs
 UwdXKWLkka8O92cdr2kgxSRWAiEPj1jGMWj6IKFRo=
X-Gm-Gg: ASbGncvJOdpb6F2NhNGVwgAG8YsBWovot2zWn2WEzmLzSqw+5J7J8oXrdvntiYkR3Bw
 c0zpHXa8oz7jdSYIuN4HT6qZDQhkgLrzq7ERptYlo3xFdk/MkosYtGb+4Dyh53XLGMxsOXu3AYz
 WMe8nyl+srQGQRhk0qJpdqhBor2wrILfRPxV7ikwg80e+LhQndHAdP/o24/O97zYxLesFEjattC
 qoqlB9kYRsC89NIH6LwGEbQNAnDaQiPx8sspv2A18tzY7o0EELTPh7BBgaYp6WqjefRQ2ijg7Mm
 yW13ITM2n59SU/ecbvG7
X-Received: by 2002:a05:6402:3483:b0:5e4:c522:51cd with SMTP id
 4fb4d7f45d1cf-5e4c5225c72mr2888192a12.20.1740666038596; 
 Thu, 27 Feb 2025 06:20:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdxIZkrf6vaXaGryO1U5cLNzE8R58b3C28wriZ9epCFj4Y53ya5Cbw65qd+d7rpqyN7rr1+g==
X-Received: by 2002:a05:6402:3483:b0:5e4:c522:51cd with SMTP id
 4fb4d7f45d1cf-5e4c5225c72mr2888153a12.20.1740666037999; 
 Thu, 27 Feb 2025 06:20:37 -0800 (PST)
Received: from [192.168.10.48] ([176.206.102.52])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e4c3bb733asm1152112a12.38.2025.02.27.06.20.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 06:20:37 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 20/34] rust: add IsA bounds to QOM implementation traits
Date: Thu, 27 Feb 2025 15:19:38 +0100
Message-ID: <20250227141952.811410-21-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227141952.811410-1-pbonzini@redhat.com>
References: <20250227141952.811410-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
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

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
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


