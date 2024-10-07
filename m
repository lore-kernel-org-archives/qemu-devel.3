Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE4CBCFB440
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 08:44:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxjLT-000845-Kp; Mon, 07 Oct 2024 04:43:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sxjLR-00083G-O6
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 04:43:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sxjLQ-00073j-0w
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 04:43:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728290635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fGNsId3Odmklk6byXvrAJkl5Byl3Vp7hlDAi2dR9A9w=;
 b=JAL+C31024soG6u9gflWB1PtAptjftRlw2zTe/DO1uyWB2htJ6n7YZXFMx7f5FkdBswEVs
 ssTqkEfQVaL6H4DBhH7j1T1klA78c0z/FdL8Vnsw2E2XZITCzjsOso8Pric/P3hGGfIeqh
 NBVzkQf98LeltdTLFbGBVTNZbnvCD/I=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-ZF7F8BDzNPSFP2DLucK6FA-1; Mon, 07 Oct 2024 04:43:53 -0400
X-MC-Unique: ZF7F8BDzNPSFP2DLucK6FA-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-53994612aa6so4005281e87.1
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 01:43:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728290631; x=1728895431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fGNsId3Odmklk6byXvrAJkl5Byl3Vp7hlDAi2dR9A9w=;
 b=B9iFP2I2NNZooW71KinByS/YMAb01vZgYem9knzikdMNYBL19oE3LA1gs6fY/unh4w
 n9rnOBIbZ+kk3hT/ppdPBL5xWi4iSdif6vz9KJl4CeAenN+fpCHM4qMUeovXPpGCxc2m
 QL/T2z5I1J28r6zCp1M5F0XUYL6KqTWgXdpwcgTCYe59kvOLeW3UmqvhLy6bqrycU7jv
 dKSWXNUn+jwUuSEiPKDIQVvxWe0zcqH2qodnAHPDrTqnjv3PLsgzSEXvUc57k0wDczNX
 cjAKshsO9RwamWuYK0rJUh/ybvZZWYhI3WBAX2Y7i5tWUDSduSgOCDXKT0tfvskcB/0V
 SK8g==
X-Gm-Message-State: AOJu0Yy9TlWwNUUsizXKhCrWXGMGSGrackRmgf+DxIl1fidndeLjAvUZ
 fgT3raN5NJcgaE17K973UyE3k82ZHzr/byK2643MR0o0DWscyv3SowT3+gnNi6q1JLIAbdiiJzU
 /qLOyZM4itWylSjIk0UlAWmQ6SQgswS+UUp7hotNWENdMJBjNwMWx0h2Md/qJBYs8hR6mOuUdRu
 DKEINLR2bxABOR8P5qofH7JOhTM0meu0GwBsjKESk=
X-Received: by 2002:a05:6512:e88:b0:538:96ce:f2ed with SMTP id
 2adb3069b0e04-539ab84e3bemr6297944e87.10.1728290631036; 
 Mon, 07 Oct 2024 01:43:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5V1GiJK2Pe85IHeCU6NAbKIVqJwMV2sDpHebDCB3YSsSr6qt3c0UQERS/creSn7nkei4zEg==
X-Received: by 2002:a05:6512:e88:b0:538:96ce:f2ed with SMTP id
 2adb3069b0e04-539ab84e3bemr6297916e87.10.1728290630500; 
 Mon, 07 Oct 2024 01:43:50 -0700 (PDT)
Received: from avogadro.local ([151.95.43.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a993ab8e75esm299503666b.222.2024.10.07.01.43.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 01:43:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, qemu-stable@nongnu.org, alex.bennee@linaro.org
Subject: [PATCH 2/2] meson: ensure -mcx16 is passed when detecting ATOMIC128
Date: Mon,  7 Oct 2024 10:43:42 +0200
Message-ID: <20241007084342.1264048-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241007084342.1264048-1-pbonzini@redhat.com>
References: <20241007084342.1264048-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Moving -mcx16 out of CPU_CFLAGS caused the detection of ATOMIC128 to
fail, because flags have to be specified by hand in cc.compiles and
cc.links invocations (why oh why??).

Ensure that these tests enable all the instruction set extensions that
will be used to build the emulators.

Fixes: c2bf2ccb266 ("configure: move -mcx16 flag out of CPU_CFLAGS", 2024-05-24)
Reported-by: Alex Bennée <alex.bennee@linaro.org>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/meson.build b/meson.build
index bbb0f6d9bcf..4ceae98ee87 100644
--- a/meson.build
+++ b/meson.build
@@ -2831,7 +2831,7 @@ config_host_data.set('CONFIG_ATOMIC64', cc.links('''
     __atomic_exchange_n(&x, y, __ATOMIC_RELAXED);
     __atomic_fetch_add(&x, y, __ATOMIC_RELAXED);
     return 0;
-  }'''))
+  }''', args: qemu_isa_flags))
 
 has_int128_type = cc.compiles('''
   __int128_t a;
@@ -2865,7 +2865,7 @@ if has_int128_type
       __atomic_compare_exchange_n(&p[4], &p[5], p[6], 0, __ATOMIC_RELAXED, __ATOMIC_RELAXED);
       return 0;
     }'''
-  has_atomic128 = cc.links(atomic_test_128)
+  has_atomic128 = cc.links(atomic_test_128, args: qemu_isa_flags)
 
   config_host_data.set('CONFIG_ATOMIC128', has_atomic128)
 
@@ -2874,7 +2874,8 @@ if has_int128_type
     # without optimization enabled.  Try again with optimizations locally
     # enabled for the function.  See
     #   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=107389
-    has_atomic128_opt = cc.links('__attribute__((optimize("O1")))' + atomic_test_128)
+    has_atomic128_opt = cc.links('__attribute__((optimize("O1")))' + atomic_test_128,
+                                 args: qemu_isa_flags)
     config_host_data.set('CONFIG_ATOMIC128_OPT', has_atomic128_opt)
 
     if not has_atomic128_opt
@@ -2885,7 +2886,7 @@ if has_int128_type
           __sync_val_compare_and_swap_16(&x, y, x);
           return 0;
         }
-      '''))
+      ''', args: qemu_isa_flags))
     endif
   endif
 endif
-- 
2.46.1


