Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15AFDCFB440
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 08:44:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxjLP-00082R-Vy; Mon, 07 Oct 2024 04:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sxjLN-000823-VN
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 04:43:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sxjLM-000733-I6
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 04:43:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728290631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d/8ssSTU7mU9zAIr/FLj6Igeoa1uzmUQfACLMVVyPwM=;
 b=N7IxhtwmWUA1h8MXFv6rwyCST77dqH9q4vrWSmZBL/YY6OhfTDpZlSgrxegsUOgVIy1E2Q
 7eU5iduvcTUatUc55/BcnnrD7vgWWWKzL95NxJZdV3oPEssZA+LS/oyszh5fVi1qXG6dmv
 ZAbV7WPiZhjt+xMxQtyi+BXdyaWHJgA=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-3_7axu_GPKKUkS_zLlkR4w-1; Mon, 07 Oct 2024 04:43:50 -0400
X-MC-Unique: 3_7axu_GPKKUkS_zLlkR4w-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-539ada1e190so1998537e87.2
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 01:43:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728290628; x=1728895428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d/8ssSTU7mU9zAIr/FLj6Igeoa1uzmUQfACLMVVyPwM=;
 b=OIrqsDr9luiEY0TqgZ60NKJEa6Nz/FeDAS9Zbt+ZPiAu+HLIqbH2vfT2StMJrbegzc
 zJrpDrwhlrEWvFLCN71JwHPbXOfBdpUoBpTL+mViJjzYApxUyxPdDPPqmOWlgE6m0/yr
 yy6ofAhl+4uxiAvDXrzxK8tvCdpnppKocmqt4uPLhxFH3rmojldxUvoo8q+5lI4lMYR/
 ow4vAoe7yFwVQKDekoFiZ2eI7Nvq+Y4qG977oPccD68lxSyoBErTv2sBXGUJSl8/RQMy
 nY1JpYII949H+KwQj08S6EQ48NC6bLJKMn6lAMZMzkhd3PUOp6VkK/CC3vNb6Te7cVgn
 btEA==
X-Gm-Message-State: AOJu0Yw2FgzUYI1JgoEmaAMaj0btPMsBESgpbMBaPBIHR/A+cUaw2z3c
 F1RDcbHOpnE8xcr/J+LS8gZ1aaP7WFPnMqObTwSbQ44MtaWv56WWh3lDucF5Ma8NxMwiHzfZyp5
 g/xa6D+AU5koMi6Rsuf1PCKy+fp9bASP2DOdLfR4Wqy64H38ayDOMCCGaVkgZGL6zI8tRZppbXW
 YR7LaO8XOaOyn5WLFiAHiRGKvgY9DRVkj1c0+l3/0=
X-Received: by 2002:a05:6512:12d3:b0:533:43bf:565d with SMTP id
 2adb3069b0e04-539ab88c2a2mr5700183e87.27.1728290627952; 
 Mon, 07 Oct 2024 01:43:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqBJ5ceAmjH2rg5nlWsPeFAHNncYMKPjrHV9R7EH5+aIBgJPeJufJvRliNGN7L8XhnyMkd7w==
X-Received: by 2002:a05:6512:12d3:b0:533:43bf:565d with SMTP id
 2adb3069b0e04-539ab88c2a2mr5700162e87.27.1728290627385; 
 Mon, 07 Oct 2024 01:43:47 -0700 (PDT)
Received: from avogadro.local ([151.95.43.71])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c8e05a9297sm2922858a12.33.2024.10.07.01.43.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 01:43:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, qemu-stable@nongnu.org, alex.bennee@linaro.org
Subject: [PATCH 1/2] meson: define qemu_isa_flags
Date: Mon,  7 Oct 2024 10:43:41 +0200
Message-ID: <20241007084342.1264048-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241007084342.1264048-1-pbonzini@redhat.com>
References: <20241007084342.1264048-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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


