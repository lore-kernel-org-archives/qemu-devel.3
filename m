Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F662CFB44F
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 17:24:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxrSH-0006N0-IW; Mon, 07 Oct 2024 13:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sxrSG-0006MM-Aa
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 13:23:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sxrSE-0005bI-LK
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 13:23:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728321809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n044stD13alJM9/WvKJBX9deYtaclz2MSlRl7pK1WOY=;
 b=O8H+EYRWAErHICbckLeySh3FBmJSYxMqkb9rgI+edNc1SL0y7XqdmIaDht6Bf7D8jMeRep
 2tpBCbN+btBHlofthDqAE1VLxjNA35CJx+/ydoTzaROGAGIVo9DikY/FetCY6KshIspmNJ
 /h2zdier47mT+nKaeEyxbV4co5Z7PmE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-AK9adqQxPKClv2fA0IKtTQ-1; Mon, 07 Oct 2024 13:23:28 -0400
X-MC-Unique: AK9adqQxPKClv2fA0IKtTQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42cb2c5d634so31193325e9.0
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 10:23:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728321806; x=1728926606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n044stD13alJM9/WvKJBX9deYtaclz2MSlRl7pK1WOY=;
 b=Px02MHmgLOScgybAIDDux4xWcOU0Pw/hSnF4r/WVW+225ThpCvTzxaMP84jLuXCFI7
 7xyWd3/QPFiSxP6Y7+fnS6zAqq8Z7pvTwrmrCYUCBv+PHNrnQa2dOrdtftMeL58dY1vr
 g8ev4Ea3IOB3qUDqnvG9eSkPM0yUaxQ5Yj36+lQLavhw1kRWBRq9Zhyy1qXNyY2rnq1X
 ++ihjDdrOwyTennaU3M2WCMqOLs5F84DCkJ+Rh99NV22+J4lfbNEK8uDRb11y6o9xfGE
 4RLgtKpIJCIpioyDPyLPME90akEpcq8MmdEcKGjd+eovM2MFvYsxyFT4EN4KoqwMqTip
 mzPw==
X-Gm-Message-State: AOJu0YxOojQdCu5IIog24pk32FKVOe+OtUzk2EOrabVVSO3pC220teaz
 WZ5lvFlyEwd0+s15kwe2P0bcHijne7shn40n5NIpOh4xE0qYak5O6wsR4l+eQPL7UFTetbA/uaO
 ZZ2vhUGHjKupWxGWwUZxT3doYtxvXAnJiAHp0JmXspkK6z2ORZUk0Qn9hkSCUI6Q/oAYwUEgXja
 tw3wYbwWt50Qt29mzPPVCyvINP3x3LSZIKYdGYBso=
X-Received: by 2002:a7b:c454:0:b0:42c:b995:20c8 with SMTP id
 5b1f17b1804b1-42f877baf34mr84170195e9.24.1728321806429; 
 Mon, 07 Oct 2024 10:23:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGohh+NaEkNIBY6fL4ijRLI7VnZDTJC17SLnNWYGHaWve0B2v7ocFcD4zd/zsepcs4VGK1mUw==
X-Received: by 2002:a7b:c454:0:b0:42c:b995:20c8 with SMTP id
 5b1f17b1804b1-42f877baf34mr84170025e9.24.1728321805985; 
 Mon, 07 Oct 2024 10:23:25 -0700 (PDT)
Received: from avogadro.local ([151.62.111.131])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f8a05173dsm80547955e9.5.2024.10.07.10.23.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 10:23:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru, alex.bennee@linaro.org, richard.henderson@linaro.org,
 qemu-stable@nongnu.org
Subject: [PATCH 2/2] meson: ensure -mcx16 is passed when detecting ATOMIC128
Date: Mon,  7 Oct 2024 19:23:16 +0200
Message-ID: <20241007172317.1439564-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241007172317.1439564-1-pbonzini@redhat.com>
References: <20241007172317.1439564-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/meson.build b/meson.build
index 65ea45cef03..e4b2af138da 100644
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


