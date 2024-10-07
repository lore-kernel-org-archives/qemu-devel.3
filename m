Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9594CFB43F
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 11:05:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxlYC-0002gX-Qh; Mon, 07 Oct 2024 07:05:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sxlXc-0002Bo-3f
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 07:04:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sxlXa-0006bp-Ge
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 07:04:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728299077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d/8ssSTU7mU9zAIr/FLj6Igeoa1uzmUQfACLMVVyPwM=;
 b=NXnrnuASfPt7BQgSLN9fKw3okknjTLCHZpiLcJZxZjaVSs0tXq2lG7LqsVbKzVrSoSU2k4
 7hFqYxqnEQvYuuDaGPBTOQj/3fE1/GEbMaHfvm9OOJ96YeXbe1AZAFCG8kdju9dCuswxh+
 ZyEt4CSZHJUz7SM+c7IhryH0p7Y3Fuw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-d_N7KF7qOKSP0QulGkRL2g-1; Mon, 07 Oct 2024 07:04:36 -0400
X-MC-Unique: d_N7KF7qOKSP0QulGkRL2g-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42cb2c9027dso38862705e9.1
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 04:04:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728299075; x=1728903875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d/8ssSTU7mU9zAIr/FLj6Igeoa1uzmUQfACLMVVyPwM=;
 b=bnxcy/oFTpvdRok7zMNKaPN2fJApUd3OCkrT1xTBS5Vmh0ZEfwSHfZAMAglCDpjaZV
 Mz5eJuONdnfhg/syFB1RqyrR0C4hVOKjCWyPM4n0jIsFVkbKRKb8Sn1xCTwi3jllMzGr
 h0ux2UcS4WzdFsC8h29Qr/TDTWWIHQOdvAzIDrGDl7toyP/SAjzVFxunnGWv6/Uc3fkI
 zZcSlZ+GfK+/QA9n41GdxfzlG0mqkP1FyTUQKBicrEmjl10KlWnSnDxpciObyLjALoam
 j5ITd7mngiB5Swg6iLHFcuppduyhoJsgzTL2DBfhHOejGM3CgRa9wnvjuIPgLWQ2G5mZ
 WfIA==
X-Gm-Message-State: AOJu0Yx7+S2u/ds4oBohZdQcGxlT6kp48ZgmG0RuMYoV1lSntNJPC0vf
 SdnW8MuTgod2WeGntyw/pjZe9utd4cGHTFdGtzHaKl0H8MW01o15O+huXQu5Y/zGI+7zZZ16bdY
 DSUChLeE5DVPk4+4QxyUNs1n9fw3iWIphY90nimXG5rUoLSEm1DV+i9zqqgHMwWcGZAqKQHIrrk
 0w7o5aKhpWAOq+/jtf0v9DNtVoguDD4mJdK0lAlfc=
X-Received: by 2002:a05:600c:3b96:b0:42f:6878:a696 with SMTP id
 5b1f17b1804b1-42f85ab9c1amr87506465e9.21.1728299074671; 
 Mon, 07 Oct 2024 04:04:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbik1kW3SGr9975n00R2FSHNrsf7ncT2Y8dJdjsBQDojLa4Q9UD42Yxb4IXEYsgTOnK2GwGQ==
X-Received: by 2002:a05:600c:3b96:b0:42f:6878:a696 with SMTP id
 5b1f17b1804b1-42f85ab9c1amr87506165e9.21.1728299074204; 
 Mon, 07 Oct 2024 04:04:34 -0700 (PDT)
Received: from avogadro.local ([151.62.111.131])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d1695e3e7sm5477417f8f.72.2024.10.07.04.04.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 04:04:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, zhao1.liu@intel.com, junjie.mao@intel.com,
 pierrick.bouvier@linaro.org, alex.bennee@linaro.org, qemu-stable@nongnu.org
Subject: [PULL 11/12] meson: define qemu_isa_flags
Date: Mon,  7 Oct 2024 13:03:39 +0200
Message-ID: <20241007110342.1298598-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241007110342.1298598-1-pbonzini@redhat.com>
References: <20241007110342.1298598-1-pbonzini@redhat.com>
MIME-Version: 1.0
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

Create a separate variable for compiler flags that enable
specific instruction set extensions, so that they can be used with
cc.compiles/cc.links.

Note that -mfpmath=sse is a code generation option but it does not
enable new instructions, therefore I did not make it part of
qemu_isa_flags.

Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/meson.build b/meson.build
index 76335bb2a51..bbb0f6d9bcf 100644
--- a/meson.build
+++ b/meson.build
@@ -335,6 +335,10 @@ elif host_os == 'windows'
   endif
 endif
 
+# Choose instruction set (currently x86-only)
+
+qemu_isa_flags = []
+
 # __sync_fetch_and_and requires at least -march=i486. Many toolchains
 # use i686 as default anyway, but for those that don't, an explicit
 # specification is necessary
@@ -351,7 +355,7 @@ if host_arch == 'i386' and not cc.links('''
     sfaa(&val);
     return val;
   }''')
-  qemu_common_flags = ['-march=i486'] + qemu_common_flags
+  qemu_isa_flags = ['-march=i486']
 endif
 
 # Pick x86-64 baseline version
@@ -367,29 +371,31 @@ if host_arch in ['i386', 'x86_64']
     else
       # present on basically all processors but technically not part of
       # x86-64-v1, so only include -mneeded for x86-64 version 2 and above
-      qemu_common_flags = ['-mcx16'] + qemu_common_flags
+      qemu_isa_flags = ['-mcx16'] + qemu_isa_flags
     endif
   endif
   if get_option('x86_version') >= '2'
-    qemu_common_flags = ['-mpopcnt'] + qemu_common_flags
-    qemu_common_flags = cc.get_supported_arguments('-mneeded') + qemu_common_flags
+    qemu_isa_flags = ['-mpopcnt'] + qemu_isa_flags
+    qemu_isa_flags = cc.get_supported_arguments('-mneeded') + qemu_isa_flags
   endif
   if get_option('x86_version') >= '3'
-    qemu_common_flags = ['-mmovbe', '-mabm', '-mbmi', '-mbmi2', '-mfma', '-mf16c'] + qemu_common_flags
+    qemu_isa_flags = ['-mmovbe', '-mabm', '-mbmi', '-mbmi2', '-mfma', '-mf16c'] + qemu_isa_flags
   endif
 
   # add required vector instruction set (each level implies those below)
   if get_option('x86_version') == '1'
-    qemu_common_flags = ['-msse2'] + qemu_common_flags
+    qemu_isa_flags = ['-msse2'] + qemu_isa_flags
   elif get_option('x86_version') == '2'
-    qemu_common_flags = ['-msse4.2'] + qemu_common_flags
+    qemu_isa_flags = ['-msse4.2'] + qemu_isa_flags
   elif get_option('x86_version') == '3'
-    qemu_common_flags = ['-mavx2'] + qemu_common_flags
+    qemu_isa_flags = ['-mavx2'] + qemu_isa_flags
   elif get_option('x86_version') == '4'
-    qemu_common_flags = ['-mavx512f', '-mavx512bw', '-mavx512cd', '-mavx512dq', '-mavx512vl'] + qemu_common_flags
+    qemu_isa_flags = ['-mavx512f', '-mavx512bw', '-mavx512cd', '-mavx512dq', '-mavx512vl'] + qemu_isa_flags
   endif
 endif
 
+qemu_common_flags = qemu_isa_flags + qemu_common_flags
+
 if get_option('prefer_static')
   qemu_ldflags += get_option('b_pie') ? '-static-pie' : '-static'
 endif
-- 
2.46.1


