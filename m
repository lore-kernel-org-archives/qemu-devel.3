Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE1BD24470
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 17:05:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szJ4b-0001GJ-G1; Fri, 11 Oct 2024 13:05:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1szJ4R-0000hu-Dj
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:04:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1szHe0-0007Fi-TG
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 11:33:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728660812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UO920/vU3UVu5Z0ktPqv8vRtCWnYQqPNoMlASL2Ii24=;
 b=NvwC4+rjkaNv9S2hxG0uDWIPZaMI3YBwVo/UCovKX+qZTKdAGo6uKaHsTKK7XAqr5kselG
 1SviQdzcQVaOGKcNml8xSc7124GGtRzynUbSPSZozIAeP+E6pEcBONkiK8jUtlLhTuT9ba
 FQRVOB05j5YwHgDc/AJTHat36tA1DMQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-17Nv5BX4NjmBkaxHNmusmA-1; Fri, 11 Oct 2024 11:33:31 -0400
X-MC-Unique: 17Nv5BX4NjmBkaxHNmusmA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a9953730a3eso147758966b.3
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 08:33:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728660810; x=1729265610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UO920/vU3UVu5Z0ktPqv8vRtCWnYQqPNoMlASL2Ii24=;
 b=V5L+sdMChLm6AaLJwgoYTqjk9Dd3KYH1v9x/aL/ICRu6MqByX2iukySYQ311Cc9S7v
 RMt5qanGNIJCTAzutCPRuDmWNpbrRojMWdxsPo22kpb2w7oqOyi0hR+8qviFKGNZj/6a
 2JsuUBwXvjR8BlpxPemRVstx2dkiKADnQ0QMtc7QDPj5G0PT6H00zZbRLS+OOjvRnoKc
 4v+oFJOIOsviu11r2Nm5ue3SiNP5tlRRCBcOvihA3LEkefsngHg3gl5JpVCt9VTHGCyP
 vkA8jnXGM3dri7SzVfSFmH9oqOjNtetc8v7PRN66YzY99rmhrAKaok0J9IdZ82PTsboV
 HAsw==
X-Gm-Message-State: AOJu0Yz7Iv6Jd3X9v2/uNjhewoaJbi6jQ+PsxFCTYxs9Q9TOrVuPjTp8
 iO/AfkFfsk8LU7dtZdMc6Wc+h2a4EzR/VyJeKZnPsyEBAZUbJetcJrcGAr9JPe9SEqzv3pAuL4p
 /HAWvZOMFJLCXHtnfs1G+XrSRwLjmFMQR5hEna/7NBDWY9Qg7Ga586uVfuMqgH72RiTXZx0S3bb
 Vlja730DZGpOPGrMvAibRCJc4tATLRxIl3jp96IFU=
X-Received: by 2002:a17:907:f1e0:b0:a99:5240:381e with SMTP id
 a640c23a62f3a-a99b945c558mr269519566b.18.1728660809711; 
 Fri, 11 Oct 2024 08:33:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEY5c+MhPESeTxm1iGZJ9NyliZoffSWV5yw1oqhVw+4SL6ZRpb4oGNehl5+dXTdELd0drshtg==
X-Received: by 2002:a17:907:f1e0:b0:a99:5240:381e with SMTP id
 a640c23a62f3a-a99b945c558mr269516966b.18.1728660809198; 
 Fri, 11 Oct 2024 08:33:29 -0700 (PDT)
Received: from avogadro.local ([151.81.124.37])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99a7f25eedsm224680566b.71.2024.10.11.08.33.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 08:33:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-stable@nongnu.org
Subject: [PULL v3 13/18] meson: ensure -mcx16 is passed when detecting
 ATOMIC128
Date: Fri, 11 Oct 2024 17:32:21 +0200
Message-ID: <20241011153227.81770-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241011153227.81770-1-pbonzini@redhat.com>
References: <20241011153227.81770-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.15,
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
2.46.2


