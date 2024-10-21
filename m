Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 998F0D15DBC
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 16:37:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2vOE-00067b-H7; Mon, 21 Oct 2024 12:36:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2vNw-0005un-GM
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:36:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2vNu-0006IO-W3
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:36:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729528557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+VBSGG9/QZnUbOHJ1ZUaj0+mzJGppSH57Y5XCkB20uU=;
 b=Yk3GtvRLSGY7iZFUV50TFOnDSVheFkVJ/YF3Qln5InL9h023DQ9J1lVWc97ktE5f68NBeM
 iTjtWeLCTKHPJg5fdNiIDu/JGc41zGWCVwIPpFwidsNWRSUCtW3DBW9Lg77fbpyGDsQUga
 TYoTihjTT8B2E9ToNHkxnxzL/CJjfIw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-5mxRttA5MCijBc4yZAYxew-1; Mon, 21 Oct 2024 12:35:56 -0400
X-MC-Unique: 5mxRttA5MCijBc4yZAYxew-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43151e4ef43so34583445e9.3
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 09:35:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729528555; x=1730133355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+VBSGG9/QZnUbOHJ1ZUaj0+mzJGppSH57Y5XCkB20uU=;
 b=n3LRHWlr+ZmF2vDLli7A3s9Hk9ZAUGYKn2g2cNoTevwTpWbNnV4nYK0gfABVCPS6uO
 FVSCp7MqfGXfEMarD1TKAd8AAvOOf0QJY5zdt2qD69sz5HCF/HalK4w5+HDHcvsKMSO9
 0UmW9yAw92y+sTnlv4PduY+5mnI1dEUrL4r5qTOYxk8iinzFaKJ+XjKKw0+V0JceE9Th
 867pFzMPyX0+nBfMVcA/3dXA/fy27N0g9/pCpXG9MVpxh5E6DWhI/u+6BgnNn8UxmPKD
 vvmw8VdyhyvTT9dJY3iZ93ajy3jFOv1qWDX6kVuQxzQVehf9rxRyvCXzkEIW0g4z/Aws
 S4Gw==
X-Gm-Message-State: AOJu0YwX+JZwqtWSnxFpBFXrJsnS8o63b0cYEIhhwKi+TmvB4zg+V8OA
 eRA6bZQbnF+9Gld6M6tUB4g6WoctEXvsGt92E3qKOH+z0jV2mVRopKtv3ApxKw8AJP2R5BaEdU3
 dD8Il1/Q61AYNvL9XjQ/oP99M3klSIWZTA/EhiEyNKf2RA53WLunFgdKI1fn7GbZZzo2trAiNpG
 Ko5h8GyMpB7dF4lk5nS01ps7ZZ3Hpcy9gIqgTgSU8=
X-Received: by 2002:a05:600c:5124:b0:431:5bf2:2d4 with SMTP id
 5b1f17b1804b1-431616a388cmr100577145e9.29.1729528554862; 
 Mon, 21 Oct 2024 09:35:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIIIJRzkemrUvKk4iyOOzbee7lZKyXOs6e3741YOKlQdEaBc8g+wXmIVejD4MgZgdKWSgxZw==
X-Received: by 2002:a05:600c:5124:b0:431:5bf2:2d4 with SMTP id
 5b1f17b1804b1-431616a388cmr100576935e9.29.1729528554427; 
 Mon, 21 Oct 2024 09:35:54 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316f5cc1e2sm63458665e9.42.2024.10.21.09.35.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 09:35:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: [PATCH v2 04/13] rust: do not use --no-size_t-is-usize
Date: Mon, 21 Oct 2024 18:35:29 +0200
Message-ID: <20241021163538.136941-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241021163538.136941-1-pbonzini@redhat.com>
References: <20241021163538.136941-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This not necessary and makes it harder to write code that
is portable between 32- and 64-bit systems: it adds extra casts even
though size_of, align_of or offset_of already return the right type.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                      | 1 -
 rust/qemu-api/src/definitions.rs | 6 +++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/meson.build b/meson.build
index 63c07a5b660..6739165908e 100644
--- a/meson.build
+++ b/meson.build
@@ -3934,7 +3934,6 @@ if have_rust and have_system
     '--no-doc-comments',
     '--use-core',
     '--with-derive-default',
-    '--no-size_t-is-usize',
     '--no-layout-tests',
     '--no-prepend-enum-name',
     '--allowlist-file', meson.project_source_root() + '/include/.*',
diff --git a/rust/qemu-api/src/definitions.rs b/rust/qemu-api/src/definitions.rs
index 60bd3f8aaa6..0b681c593f2 100644
--- a/rust/qemu-api/src/definitions.rs
+++ b/rust/qemu-api/src/definitions.rs
@@ -81,13 +81,13 @@ macro_rules! type_info {
             } else {
                 ::core::ptr::null_mut()
             },
-            instance_size: ::core::mem::size_of::<$t>() as $crate::bindings::size_t,
-            instance_align: ::core::mem::align_of::<$t>() as $crate::bindings::size_t,
+            instance_size: ::core::mem::size_of::<$t>(),
+            instance_align: ::core::mem::align_of::<$t>(),
             instance_init: <$t as $crate::definitions::ObjectImpl>::INSTANCE_INIT,
             instance_post_init: <$t as $crate::definitions::ObjectImpl>::INSTANCE_POST_INIT,
             instance_finalize: <$t as $crate::definitions::ObjectImpl>::INSTANCE_FINALIZE,
             abstract_: <$t as $crate::definitions::ObjectImpl>::ABSTRACT,
-            class_size:  ::core::mem::size_of::<<$t as $crate::definitions::ObjectImpl>::Class>() as $crate::bindings::size_t,
+            class_size:  ::core::mem::size_of::<<$t as $crate::definitions::ObjectImpl>::Class>(),
             class_init: <<$t as $crate::definitions::ObjectImpl>::Class as $crate::definitions::Class>::CLASS_INIT,
             class_base_init: <<$t as $crate::definitions::ObjectImpl>::Class as $crate::definitions::Class>::CLASS_BASE_INIT,
             class_data: ::core::ptr::null_mut(),
-- 
2.46.2


