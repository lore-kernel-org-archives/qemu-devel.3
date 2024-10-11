Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A333CD24470
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 17:14:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szJ4c-0001JC-Mn; Fri, 11 Oct 2024 13:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1szJ4S-0000hD-2E
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:04:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1szHdy-0007FV-Nj
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 11:33:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728660810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dl6dcOfhmNp3NrxHyKacGU/S0XBvVsXoKUJy7DRsnQc=;
 b=OKgzqj6y7VCRCJp8ljgFr7vjDmES9nW4A7M70kS+i/t4J5kJps0jHXciKUM0kWxI7nFtkm
 hGs2trYv0MRc4TmXnjOhdb4qoorWxG4jlokcBMLQnmHhhR/Ebxw/9ddyz06k+hhs+M6H/l
 F64hF/SYAJbJJdIuNHZYlKRMl8o1pX8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-bh0bVuhdMBuoAa5BFWppjA-1; Fri, 11 Oct 2024 11:33:28 -0400
X-MC-Unique: bh0bVuhdMBuoAa5BFWppjA-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5c9465e3547so741150a12.3
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 08:33:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728660806; x=1729265606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dl6dcOfhmNp3NrxHyKacGU/S0XBvVsXoKUJy7DRsnQc=;
 b=cSL7pknbJCnSBQLh8VUTUz/TZTryC+/KiFia0ansDCczw9V3F/IxlRXgpocrOsMf6r
 jtj+nDbmhb7CdpZYsXC2XVRI/Kes1LRh9ZNMkBhxw/DWcCDQr1j903+SqAUVh6aNmwaA
 rw+DMKx5YXss1XjJy9sUV2CTl2cyJtrKDIhYUEB2YSane5J4XkM2syRZuEP6xEYqPYMm
 y7dxlj1w2Ey05NoPyvIYgcOK+5xQLWMxwcAI/vR8XuvGiXlcUj3mrj9Jwz+1Z0+TU2+p
 KOLz3zxExzotF7DsikqgZtaTM92PkPJPT9T+Y+sLYwANYwG7FFTazRftxm4MgOQtT8Cr
 VmcA==
X-Gm-Message-State: AOJu0Ywr8IOi/TQWiMs+OCbSMuw8fmGCbAIP+X0slECAzBv4lVJJRaRM
 1XsCfcu70grJoAqhQ7uH73JOSW9/1C7JnyvLgHkdmPPHEu9k+uKuYTvdTr9Z49MHHYQnEq3oQW+
 mpvrSoigUhbXh3bBmVrYf+DkbzntanFe17JSXSQSlSIAWn/vgQrZi0Je2CaCbsv/P5K19MHs+Vi
 qgqdB9R0k2MVmtw5vpuOfKV/lVH8FfUUSCvs1n5IQ=
X-Received: by 2002:a05:6402:26cf:b0:5c5:c059:63c6 with SMTP id
 4fb4d7f45d1cf-5c948c88336mr2251755a12.2.1728660806046; 
 Fri, 11 Oct 2024 08:33:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSXtniGKImJ8V8RYL40QFNziA/aVy/eusWDt39Efn6WOwREBlD134jmzrQ7q8+f7lht8TzSw==
X-Received: by 2002:a05:6402:26cf:b0:5c5:c059:63c6 with SMTP id
 4fb4d7f45d1cf-5c948c88336mr2251729a12.2.1728660805526; 
 Fri, 11 Oct 2024 08:33:25 -0700 (PDT)
Received: from avogadro.local ([151.81.124.37])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c9372ae701sm2012038a12.85.2024.10.11.08.33.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 08:33:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PULL v3 12/18] meson: define qemu_isa_flags
Date: Fri, 11 Oct 2024 17:32:20 +0200
Message-ID: <20241011153227.81770-13-pbonzini@redhat.com>
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

Create a separate variable for compiler flags that enable
specific instruction set extensions, so that they can be used with
cc.compiles/cc.links.

Note that -mfpmath=sse is a code generation option but it does not
enable new instructions, therefore I did not make it part of
qemu_isa_flags.

Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/meson.build b/meson.build
index 76335bb2a51..65ea45cef03 100644
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
+  qemu_isa_flags += ['-march=i486']
 endif
 
 # Pick x86-64 baseline version
@@ -367,29 +371,31 @@ if host_arch in ['i386', 'x86_64']
     else
       # present on basically all processors but technically not part of
       # x86-64-v1, so only include -mneeded for x86-64 version 2 and above
-      qemu_common_flags = ['-mcx16'] + qemu_common_flags
+      qemu_isa_flags += ['-mcx16']
     endif
   endif
   if get_option('x86_version') >= '2'
-    qemu_common_flags = ['-mpopcnt'] + qemu_common_flags
-    qemu_common_flags = cc.get_supported_arguments('-mneeded') + qemu_common_flags
+    qemu_isa_flags += ['-mpopcnt']
+    qemu_isa_flags += cc.get_supported_arguments('-mneeded')
   endif
   if get_option('x86_version') >= '3'
-    qemu_common_flags = ['-mmovbe', '-mabm', '-mbmi', '-mbmi2', '-mfma', '-mf16c'] + qemu_common_flags
+    qemu_isa_flags += ['-mmovbe', '-mabm', '-mbmi', '-mbmi2', '-mfma', '-mf16c']
   endif
 
   # add required vector instruction set (each level implies those below)
   if get_option('x86_version') == '1'
-    qemu_common_flags = ['-msse2'] + qemu_common_flags
+    qemu_isa_flags += ['-msse2']
   elif get_option('x86_version') == '2'
-    qemu_common_flags = ['-msse4.2'] + qemu_common_flags
+    qemu_isa_flags += ['-msse4.2']
   elif get_option('x86_version') == '3'
-    qemu_common_flags = ['-mavx2'] + qemu_common_flags
+    qemu_isa_flags += ['-mavx2']
   elif get_option('x86_version') == '4'
-    qemu_common_flags = ['-mavx512f', '-mavx512bw', '-mavx512cd', '-mavx512dq', '-mavx512vl'] + qemu_common_flags
+    qemu_isa_flags += ['-mavx512f', '-mavx512bw', '-mavx512cd', '-mavx512dq', '-mavx512vl']
   endif
 endif
 
+qemu_common_flags = qemu_isa_flags + qemu_common_flags
+
 if get_option('prefer_static')
   qemu_ldflags += get_option('b_pie') ? '-static-pie' : '-static'
 endif
-- 
2.46.2


