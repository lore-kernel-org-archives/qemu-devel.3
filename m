Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC4FD30016
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 14:45:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1oCO-0008EK-08; Fri, 18 Oct 2024 10:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t1oCM-0008Dg-QD
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:43:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t1oCL-0002bH-F0
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:43:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729262604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YnWs6TCqS8/kK1EZwGdItbHdFaXUR6Q2fvMJR0lbNSc=;
 b=UVv9V4CfxhZ2djLR7+D1Tz5Tsmi6VxKxWeYt7eGKKqp96k5WSrWncVQyKoIartXKd7Q3wn
 19/qjRhjKOnFPqg088KFwO0TeAgnaxYBYzMrTZZAIde8lIf8G+vUXISOm+MTWx4LQmtx5w
 QDrCFMJXMf6xzT3sN2mQ4CUS1CQdeIs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-mDp0fhS6PvK_f76_ViecYw-1; Fri, 18 Oct 2024 10:43:23 -0400
X-MC-Unique: mDp0fhS6PvK_f76_ViecYw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-431518ae047so16264075e9.0
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 07:43:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729262601; x=1729867401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YnWs6TCqS8/kK1EZwGdItbHdFaXUR6Q2fvMJR0lbNSc=;
 b=OT5DpkH5VEHXVaqJ+E81RwqlOKfmmKZmmGYm54SRXzmH70NUQ3lzhXziomfCk8oBaK
 1heIHTv12cjgrcoNJuJUuqyiH1BkwencWBbC1W5WAL1l5uoIKz5NPnzUkJpLaS0OPFkm
 Sv3aP9cuY0nkTrvgLZ9YghRN6EnZ6X8xg1L3rIPFtSeVSS4PNhb6g/cBc4yDK/4V5Wop
 9SndxV5S5XR46F9qARZzxkYmGqfoilYfis3uqq9lwiZS8vhz2gu0G+mKK7ia1Ll3dmCi
 1nazOTvsTRlF+hmGbQo5kkcWSOZAgVQQAr6aDL4/5mlO9qpS9N44mYflpjseA5pWnRoJ
 dY6Q==
X-Gm-Message-State: AOJu0Yy0qECRew13GhgfCpns6y3mDvxzUeBPAV6Qx/asL4vN++atgumz
 6jvT3Q+SxhE2s9KSTQqs6Mn07qlP2ROqHFsKbHmbZwokQsSC9onB70tJIgzT1iLwFcFmtdZ+Jom
 r2Ft9hNqi9B8jO1VL4GJeu9P1pzviDwKb8VVetRxF7BNxhVdNIA0lqPHpqp/ne7M+I/DTPRS0yx
 RExwswe5yZw2N/ZHh4FUB58sjbzz41/ttXL0AMdfg=
X-Received: by 2002:a05:600c:4fd2:b0:431:15f1:421d with SMTP id
 5b1f17b1804b1-43158760531mr48904955e9.16.1729262601451; 
 Fri, 18 Oct 2024 07:43:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlJfRDHgpGcAwHn5SwM3qN01kA1iAScDSzLvZG2bCO5VvRaQSsnb/rAzMOkv976pB31/NZrw==
X-Received: by 2002:a05:600c:4fd2:b0:431:15f1:421d with SMTP id
 5b1f17b1804b1-43158760531mr48904665e9.16.1729262600903; 
 Fri, 18 Oct 2024 07:43:20 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43160e4424asm25788395e9.32.2024.10.18.07.43.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 07:43:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: [PATCH 04/13] rust: do not use --no-size_t-is-usize
Date: Fri, 18 Oct 2024 16:42:56 +0200
Message-ID: <20241018144306.954716-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241018144306.954716-1-pbonzini@redhat.com>
References: <20241018144306.954716-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This not necessary and makes it harder to write code that
is portable between 32- and 64-bit systems: it adds extra casts even
though size_of, align_of or offset_of already return the right type.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                      | 1 -
 rust/qemu-api/src/definitions.rs | 6 +++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/meson.build b/meson.build
index 44f3bf34931..48f82fd4ba6 100644
--- a/meson.build
+++ b/meson.build
@@ -3932,7 +3932,6 @@ if have_rust and have_system
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


