Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E66E0C3ABBE
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 15:34:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCKEz-0003ls-GX; Tue, 06 May 2025 11:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCKEw-0003k6-GB
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:29:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCKEt-0001xN-Mg
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:29:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746545386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KVv4MrS7maqnZXU2DLQdOtK/vMh68KY00+XUfGh8Kxo=;
 b=G7EC/PJR4kJZH2hODwIqSt2dxODFcb59m+hpcAOyFbDxdjwe7eJEeMDnTEWNgD+HETzDW/
 zQXHetER52GlyRYFw/Klx7gedwvLl5AkgXvd+ZJedfGriadBXCmAcF+mGeBjfhQEP5/ajT
 dPGI8JbNHKUwEiuHozK2zQ9RbZYwFAw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-oLVm_zf3OYe507ZE__yooA-1; Tue, 06 May 2025 11:29:45 -0400
X-MC-Unique: oLVm_zf3OYe507ZE__yooA-1
X-Mimecast-MFC-AGG-ID: oLVm_zf3OYe507ZE__yooA_1746545384
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43ea256f039so45017065e9.0
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 08:29:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746545383; x=1747150183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KVv4MrS7maqnZXU2DLQdOtK/vMh68KY00+XUfGh8Kxo=;
 b=VyoXK+557ylxcjnTgcYsf/9akghTIgZWN72e9k42eeJMn7dI2j+xel0PvF/OSD2Jsd
 gYHzUDQazNAovbZ76BWO9mDolFVNGgeF3sWr7Y1qAj+dK4cQmSnciOzIHbtIr2C253hS
 GC0Ddun4HA7hmHbZZ017QDYmGSXhu8ZVPHVBm/C9Zu+kYw9xHTOuOu/bSktNQ6ewQ0qM
 TPORrfAVgzqCDHA7wiMtpGjMJD+3SpHJex0AqdbRBN72WifbjqRPmoO6ZojhUCCfQy5M
 5sTONeUaeRHuUxzgRWyyDOuhT0C8Wa3diL2U/gn770NPxqlkhIlsM/FSyvqZpsAarPyl
 /DDw==
X-Gm-Message-State: AOJu0Yx2lsi3C88nXV9XPX6szq/GbbjLJKs6EIkRm+Hzeb6+EhzEjEvG
 7YlzpLcu3+FmtPa9U27uECwhNf/0atN0/rQiYNcKMcwVwJ2Q2bA/yitqTnPxkY3qHQOqeT6N+Pi
 1oGAdo6jfdgCBZlImO53+MOYlT2XCobJ4vr3nGM7J3S2HYfYiOGZ9fnxUVk14TZFBOxNKrtozHa
 N5Rkw0Q+WkmT0QOsfdWm8n4nw0/51bnVUk8buu
X-Gm-Gg: ASbGncsKIQxp6ffwePEtfguXR7s5G4WFz2bgSwi7vOZCL3PZU8vvfpW74P0lXl1ibLR
 zCVbCQjejtapjSn9EAfNqVnfyj9LzZG4v8VGAAQLbiPJSb5/wZIDpKgXomuzKgpqNTwMzdRPFrb
 osldcTyYgJ8dofGR67S2PiW/pHhlcAv/6QQ8JnSV1xiEvu+Hx0RCdc5iSY1M11xYY6xBD4IsU2E
 4ivmB3ea+lLVHBlSRAbOa6+6Gg7WO1SuCpW0L/N/GCZtA7jSVT9jvDZ6BRSyqdvspL/45o9YO2a
 foBvifqqf7iVj0E=
X-Received: by 2002:a05:600c:5027:b0:441:b698:3431 with SMTP id
 5b1f17b1804b1-441c4948315mr93497065e9.28.1746545382775; 
 Tue, 06 May 2025 08:29:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRFvoU8Uq5DPz3g7DwIGvUUgHj4/SCmYkbYd1Nx7T9OiGm9jsmFwOjYI48SwRQYJ9pLtMVWw==
X-Received: by 2002:a05:600c:5027:b0:441:b698:3431 with SMTP id
 5b1f17b1804b1-441c4948315mr93496875e9.28.1746545382389; 
 Tue, 06 May 2025 08:29:42 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b2af4546sm221945135e9.22.2025.05.06.08.29.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 08:29:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 07/30] rust: qom: fix TODO about zeroability of classes
Date: Tue,  6 May 2025 17:29:02 +0200
Message-ID: <20250506152927.222671-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506152927.222671-1-pbonzini@redhat.com>
References: <20250506152927.222671-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

The proposed suggestion is not correct.  First it is not necessary for
*all* classes to be Zeroable, only for Rust-defined ones; classes
defined in C never implement ObjectImpl.

Second, the parent class field need not be Zeroable.  For example,
ChardevClass's chr_write and chr_be_event fields cannot be NULL,
therefore ChardevClass cannot be Zeroable.  However, char_class_init()
initializes them, therefore ChardevClass could be subclassed by Rust code.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/qom.rs | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/rust/qemu-api/src/qom.rs b/rust/qemu-api/src/qom.rs
index 6929e4d33ae..52e3a1ec981 100644
--- a/rust/qemu-api/src/qom.rs
+++ b/rust/qemu-api/src/qom.rs
@@ -534,9 +534,10 @@ pub trait ObjectImpl: ObjectType + IsA<Object> {
     /// While `klass`'s parent class is initialized on entry, the other fields
     /// are all zero; it is therefore assumed that all fields in `T` can be
     /// zeroed, otherwise it would not be possible to provide the class as a
-    /// `&mut T`.  TODO: add a bound of [`Zeroable`](crate::zeroable::Zeroable)
-    /// to T; this is more easily done once Zeroable does not require a manual
-    /// implementation (Rust 1.75.0).
+    /// `&mut T`.  TODO: it may be possible to add an unsafe trait that checks
+    /// that all fields *after the parent class* (but not the parent class
+    /// itself) are Zeroable.  This unsafe trait can be added via a derive
+    /// macro.
     const CLASS_INIT: fn(&mut Self::Class);
 }
 
-- 
2.49.0


