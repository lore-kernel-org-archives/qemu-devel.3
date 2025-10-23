Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF11FCCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 13:56:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBvnY-0004ga-Q6; Thu, 23 Oct 2025 09:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mkletzan@redhat.com>)
 id 1vBvnV-0004c8-6L
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 09:56:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mkletzan@redhat.com>)
 id 1vBvnQ-0005EE-Q4
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 09:56:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761227762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tC8PZlPiQjZNcHg5jwXV2rm1RllOkzq/OVQijD7JM1A=;
 b=icO5srdAQvZvJBaBh5yMnc/TyiXaL//fkJrcS9nIQziT/qohrszDuh+j7DG1HEB3bSXC5I
 lJfPBcvpcgBe3Mv6coishQ7Fu46hmIh6jUiNKKN5LSlg32xlwuiu1cU4F9FPq8EkY8FIwx
 KPUxtO1n3AUgKwir29xHFy9gm242bwY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-PUEN0nrrMgyW6tb-6L4E_w-1; Thu, 23 Oct 2025 09:54:21 -0400
X-MC-Unique: PUEN0nrrMgyW6tb-6L4E_w-1
X-Mimecast-MFC-AGG-ID: PUEN0nrrMgyW6tb-6L4E_w_1761227660
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47113dfdd20so4550465e9.1
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 06:54:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761227660; x=1761832460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tC8PZlPiQjZNcHg5jwXV2rm1RllOkzq/OVQijD7JM1A=;
 b=R4D0VC7v+RIjxA8kjsMcZQR1Hlrpp2rinwY9Rh8x4V/hXdPVjGIRt1sQqzFFqrWmza
 wpFgr1BIeBgfnqwj9D3Vb9Q9zTqd2mSZqMWpt/tJB16JbsMDwe8J3uP8P6VcRm5jl8sq
 wffJk7Mp+zMfb9zeTqO0kM57E+458DibK1lSM3pVcrQ3hNcSczmTq5lYVWHtUGTY8Jrg
 2scMYo3maGPe+El6Q+vP6+dkt5x6/ttP9KhLzPgZGe/8TmodOw/Wf/4NxEE+IM0hb2+d
 0cB3sg/lM+ZC4v77oF7obUItxSavAjKwKGV1Nkhlz1CVhKabevVA13RmxOkzkb2IVpbH
 mb9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWw+kokhpxql7Xvyms1RsyhY2uOdEPJokb3mWYhTRSF3OWoTYjammONFPDfycrFK4qDJOV/LvZgH/Lm@nongnu.org
X-Gm-Message-State: AOJu0Ywe/ZXP4VoN+CiGlNXz7hhs9uOKyOABh363+Cm3NC5AsMOjNPKw
 ydK9FhDTe1W1LZx4nJNmhFpdPLVFyR7xrN4wLsxPLf+MbAn5gBLnPWaTQGxXIQUWne9/JuGglzb
 +Q/tix0hCdVA8nAytNFzqzuY6FMtgRQWkVOo703byH6vGLhaX/eot9SHo
X-Gm-Gg: ASbGncvANUl70wUd5/ktZb24sjEzu6dyK9sXNjWu5JunjMrg1tSVHmR8+z5RCOvnZMK
 Cdh/nl/eV20k6xuZWXRLwTk0NGti/3LmbApvK7SeWYiwG1mXfNxCK/m4g6JtYhxPp6SXYlnbGSd
 fOApZjh7GgFJIitJ+UlCOOM+jrJ9CXQELxq54ATdTpLYy6QwnP7aGJYkMH56wJMiw+i+PFBCHmf
 /M+gUJC3+9Q0j7vyLbTUvSMnjBngxh5lrGgjnbYuF/JcKwu7byRxP3PH8ra+GCA/JGOjTYA8iUZ
 xOHiw85iEiMm8gGi2Pkimb46A3GjrQ3jp3lsBiW8+j2nbrpkJi6p7NgY8bPVSuouA5aJvadWFgy
 ho60Blovs
X-Received: by 2002:a05:600c:548c:b0:471:14af:c725 with SMTP id
 5b1f17b1804b1-4711787697bmr184430005e9.3.1761227660109; 
 Thu, 23 Oct 2025 06:54:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkRo97rOZa0vHoBd+1HXJAJdMK9Xy13Ii2gJArN1Q5CgZ+Gu+uE3BLWBbO8Dq8nYtz2jsSqw==
X-Received: by 2002:a05:600c:548c:b0:471:14af:c725 with SMTP id
 5b1f17b1804b1-4711787697bmr184429835e9.3.1761227659752; 
 Thu, 23 Oct 2025 06:54:19 -0700 (PDT)
Received: from wheatley.localdomain ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475cae9f571sm40672855e9.7.2025.10.23.06.54.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 06:54:19 -0700 (PDT)
Received: from wheatley.pinto-pinecone.ts.net (wheatley.k8r.cz [127.0.0.1])
 by wheatley.localdomain (Postfix) with ESMTP id 76740DC7C868;
 Thu, 23 Oct 2025 15:54:18 +0200 (CEST)
From: Martin Kletzander <mkletzan@redhat.com>
To: 'Manos Pitsidianakis ' <manos.pitsidianakis@linaro.org>,
 qemu-rust@nongnu.org, qemu-devel@nongnu.org
Subject: [RFC PATCH 2/2] rust/util: Change Timer and TimerListGroup to normal
 structs
Date: Thu, 23 Oct 2025 15:54:09 +0200
Message-ID: <b21bfbd144b1a4ecbe4b9e0323a0f57c35c6e47d.1761226974.git.mkletzan@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1761226974.git.mkletzan@redhat.com>
References: <cover.1761226974.git.mkletzan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mkletzan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Martin Kletzander <mkletzan@redhat.com>

This will allow the use of pinned_init crate which does not support
tuple structs.

Signed-off-by: Martin Kletzander <mkletzan@redhat.com>
---
 rust/util/src/timer.rs | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/rust/util/src/timer.rs b/rust/util/src/timer.rs
index a99ff5e7ef7a..bc6297214525 100644
--- a/rust/util/src/timer.rs
+++ b/rust/util/src/timer.rs
@@ -17,14 +17,18 @@
 /// A safe wrapper around [`bindings::QEMUTimer`].
 #[repr(transparent)]
 #[derive(Debug, common::Wrapper)]
-pub struct Timer(Opaque<bindings::QEMUTimer>);
+pub struct Timer {
+    inner: Opaque<bindings::QEMUTimer>,
+}
 
 unsafe impl Send for Timer {}
 unsafe impl Sync for Timer {}
 
 #[repr(transparent)]
 #[derive(common::Wrapper)]
-pub struct TimerListGroup(Opaque<bindings::QEMUTimerListGroup>);
+pub struct TimerListGroup {
+    inner: Opaque<bindings::QEMUTimerListGroup>,
+}
 
 unsafe impl Send for TimerListGroup {}
 unsafe impl Sync for TimerListGroup {}
@@ -42,7 +46,7 @@ impl Timer {
     /// [`modify`](Self::modify).
     pub const unsafe fn new() -> Self {
         // SAFETY: requirements relayed to callers of Timer::new
-        Self(unsafe { Opaque::zeroed() })
+        Self { inner: unsafe { Opaque::zeroed() } }
     }
 
     /// Create a new timer with the given attributes.
-- 
2.51.0


