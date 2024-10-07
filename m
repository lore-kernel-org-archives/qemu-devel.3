Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 569A5CFB43F
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 11:06:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxlYI-000304-7f; Mon, 07 Oct 2024 07:05:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sxlXh-0002Jd-Pi
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 07:04:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sxlXf-0006cL-08
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 07:04:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728299081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V6V8xn3cYBKmTkAPSQmt0gd5cDHJVis4A9sKN4ydUBU=;
 b=RZqR0Dn5LGkYRvwwr5CiA3rD3t6FKbk7BLdWxPyTuGcRVNuxK51yWlo8CEARgyvsASRTlX
 Ah7sItkdNX2nKrmueiYl+zqERlFItsiTC0u3KSBHmCI9NGHAwaM7vXLF+rlcJoe4QMw8Jy
 XXgMB1geMeIvJFEpx58pW9ULhe6wVTk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-ATk04ZJMPaSp0-Hsw-uayQ-1; Mon, 07 Oct 2024 07:04:40 -0400
X-MC-Unique: ATk04ZJMPaSp0-Hsw-uayQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42cb479fab2so23418315e9.1
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 04:04:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728299078; x=1728903878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V6V8xn3cYBKmTkAPSQmt0gd5cDHJVis4A9sKN4ydUBU=;
 b=LGm0htXC606XFCHPpOfqDD2KS3HxAbm++EMz6iuczFk6sKF73DCKRNIBsyO6hGNFc7
 cv9OTt70e4FX6Z1Cm81ElViEehjKOAK7KF2uvCYLfRDilYHbPJxZmb8ie3BQQq+PmLMK
 NVhnOYnMohgQ+42Tcih/TlYXtW7p2sZ9qtpcq5P285bhhaa8nskdj/gpEA5yDTlF5imC
 lef/UjF3gTstRxNxCEokosAoK+Hdq0SoEfZzWsXp/KIOby8TBh0KPk+kKttpN/tZFYNX
 aFmrMGEdCuaV3TUcEtgIzzxs4zsI2TJ1In2ssyA9iaWtCpLb1MBmIh1Ob7lvRBubtAPL
 WO0w==
X-Gm-Message-State: AOJu0YyLFR4mTHBudujBDNCsPmrsxe7rlALhfh2FNtayDeLs2gQcGB/+
 mTvVGaUBv166z0tUbIDR2NuFnQL6Ub1ArzvCrHQf7hqvCfTwDKa4fxoSvYjGyPBMYX92MWYCUcJ
 7HjKom9VSfTGb6o0y7nh/MIdFgYt7qEzf9LKmS33kqqjEEV3Lz6KAbqyiMa+ZdbFdu/skmMkLs2
 vNk9PhZwV4eEvgVItE0lTdVXggKCphrGBZo7Lqpqo=
X-Received: by 2002:a05:600c:1d96:b0:42c:b166:913 with SMTP id
 5b1f17b1804b1-42f856d19a6mr70284435e9.11.1728299078223; 
 Mon, 07 Oct 2024 04:04:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHy8K/Cxs6McTe5nQA9ZIim+KSLTfmQQE9cVAPZo4wOQSY60HhwJiy5ieckhM5hKc4cH8/jPw==
X-Received: by 2002:a05:600c:1d96:b0:42c:b166:913 with SMTP id
 5b1f17b1804b1-42f856d19a6mr70284205e9.11.1728299077799; 
 Mon, 07 Oct 2024 04:04:37 -0700 (PDT)
Received: from avogadro.local ([151.62.111.131])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f86b444f1sm88659885e9.38.2024.10.07.04.04.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 04:04:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, zhao1.liu@intel.com, junjie.mao@intel.com,
 pierrick.bouvier@linaro.org, alex.bennee@linaro.org, qemu-stable@nongnu.org
Subject: [PULL 12/12] meson: ensure -mcx16 is passed when detecting ATOMIC128
Date: Mon,  7 Oct 2024 13:03:40 +0200
Message-ID: <20241007110342.1298598-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241007110342.1298598-1-pbonzini@redhat.com>
References: <20241007110342.1298598-1-pbonzini@redhat.com>
MIME-Version: 1.0
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

Moving -mcx16 out of CPU_CFLAGS caused the detection of ATOMIC128 to
fail, because flags have to be specified by hand in cc.compiles and
cc.links invocations (why oh why??).

Ensure that these tests enable all the instruction set extensions that
will be used to build the emulators.

Fixes: c2bf2ccb266 ("configure: move -mcx16 flag out of CPU_CFLAGS", 2024-05-24)
Reported-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
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


