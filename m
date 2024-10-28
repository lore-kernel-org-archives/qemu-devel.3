Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0136D33991
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 14:37:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5Qo7-0003bY-Ia; Mon, 28 Oct 2024 10:33:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5Ql6-0000Lk-0B
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 10:30:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5Ql3-0003wp-8W
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 10:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730125811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZoEppBkNJR/14g0bmNDZNUQB+Nk2QV/cd9OKt2f5MTM=;
 b=K+Kxr4R0mojXxu1YaZpMUzrYKpfjkRPGjT/gwFUf2n6bEKKQfJqwrQYmH1d7lg9s6p01s4
 2RJi0uB+lLWVf3GqKrkPN8bbF64i6PYHGSheQrXbqZDL1HRNZHooQ9x8lysxSKVLT2uyW0
 s/mXBHijL7pjnb4xiNVmFviKDO6F5fc=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-V-eYszI3OJSzEGutMtscCA-1; Mon, 28 Oct 2024 10:30:10 -0400
X-MC-Unique: V-eYszI3OJSzEGutMtscCA-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-53a017bc09dso2852471e87.0
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 07:30:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730125808; x=1730730608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZoEppBkNJR/14g0bmNDZNUQB+Nk2QV/cd9OKt2f5MTM=;
 b=Pc+H6Ne/RD7PzhyhIp4nXXhRUgs6bTMd2oALAQ0frmXcVIRmR1/e72HmngEBf31UmU
 qEHbHkdkT10wNoBl0DoFhUZjPzKKG53bB/8rbQGLMiTTz/s//AilT0lPSWpty6vjsMCM
 B5ZdwLYeP6Zi8Snb1Yb0FaVpkNLnNwk6dBDWcm57YlawOFPrPf3PcuAdbSMEz8omLObj
 2zaZcCWb9I80dOTAiBOE7DJ62UQW7CHEzT5u2jj7bHG8CLg4P72TN8P9po4/JljWJoCR
 atjgXBarlf4ENH5b5IycquWzfN/d3ZZjCCKur9Sqz85bpDpgePgL7ggue9tw1d4bnhS4
 BKuA==
X-Gm-Message-State: AOJu0YxKiE87vRZ9xoUXLJ+Ukw+qZIiOgia+i4me41+EFuVKMLekage8
 YTuWt2JshvdAwcNsRNwnMUXxy58A/RDEdTZ2vO4w4BUYD8brIH2Wcx0o7XRAECSVtlHihSGVG8b
 bLpPBci0hVCsj0RLl5R+jTM1juHLsUw8cQTc6W0tFc9kNd19FFF9sZudAJER9ojUoParlf1z6/N
 25P1jHY6gTGbuZ4GzfBzH+U6S7vVCjQFFwAPyd4C0=
X-Received: by 2002:a05:6512:2211:b0:53a:40e:d54f with SMTP id
 2adb3069b0e04-53b347c0d7bmr3359910e87.8.1730125807921; 
 Mon, 28 Oct 2024 07:30:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdHIPi5rEXMula3+AoKp8exEomSbld+95bY7Ip3L05SSzYWpR2hp238PzoYfEE60cR8DJC4Q==
X-Received: by 2002:a05:6512:2211:b0:53a:40e:d54f with SMTP id
 2adb3069b0e04-53b347c0d7bmr3359888e87.8.1730125807444; 
 Mon, 28 Oct 2024 07:30:07 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43193573ce2sm111718585e9.10.2024.10.28.07.30.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 07:30:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Junjie Mao <junjie.mao@hotmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 13/24] rust: do not use --no-size_t-is-usize
Date: Mon, 28 Oct 2024 15:29:20 +0100
Message-ID: <20241028142932.363687-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028142932.363687-1-pbonzini@redhat.com>
References: <20241028142932.363687-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

This is not necessary and makes it harder to write code that is
portable between 32- and 64-bit systems: it adds extra casts even
though size_of, align_of or offset_of already return the right type.

Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                      | 1 -
 rust/qemu-api/src/definitions.rs | 6 +++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/meson.build b/meson.build
index 0b8c3495eab..6c268ef2445 100644
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
2.47.0


