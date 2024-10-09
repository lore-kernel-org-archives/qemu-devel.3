Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74901CEFC5D
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 09:50:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syTHr-0001Pk-96; Wed, 09 Oct 2024 05:47:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1syTHl-0001KE-Ml
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 05:47:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1syTHh-0008Ud-GX
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 05:47:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728467227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dl6dcOfhmNp3NrxHyKacGU/S0XBvVsXoKUJy7DRsnQc=;
 b=CqSeWvNzt+yHBWywf1G9ltLqyCqQaaLeY86yY+12DUWPx9W+mrjE+In6JhWDnZdE3hkG//
 CmejZ+Z/Pl48sTePiJlYw/wNiHwAfA+CC52g6DauElXefxfqzQXT3fEe/aOpihbc/31edh
 hP1rMDPvlneYMV2HyOYaulSdcoHc4EQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-c4IRnI9HNCydMtMiXW0W4w-1; Wed, 09 Oct 2024 05:47:06 -0400
X-MC-Unique: c4IRnI9HNCydMtMiXW0W4w-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42cb808e9fcso42771805e9.0
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 02:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728467224; x=1729072024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dl6dcOfhmNp3NrxHyKacGU/S0XBvVsXoKUJy7DRsnQc=;
 b=oasSWL4HpIQRPNJGq6OIO6cDuoJW7eHkSX8zLbUVIXs3MBTeXRlX7M40OI2QFUc51D
 kxR1GKVigdvYKXSHYyRbQAFe+JD4kXDfTIgB9YmZEHCzfvJk0jdvmxmavFoPpRvjqZM7
 +7o/Hxtd1XkOZW/UNuwunJyTsn0cDZwFe8rqQRQzn6GyVN6nlJCRi4o28WYOO05Q5f+F
 iRx+yDC9Je6NaHh7cj/UsweVcaXxGkaFe18dqyjwB/DWqeU1h2OU0A0OseFLCYKZ4Mxc
 gODo2cRC2uBx/cHhPg3kTDBUmoynInHeiM0dwRSlKMKgdnH0++GzNe7Uo8zcnYkVoVyn
 OIXg==
X-Gm-Message-State: AOJu0YzgmAkztvCJZ0D1HTF/xODhI8tgk0NUCasztzJUJ44ILJN/rbQh
 m0BYWoi9T03aHoudtVfbLLd49Lpb6KLKgpMQBG0mDlz4h7ZFXy+o99cnuyMFOMjW7Y/XN6d2/hU
 BrzKS95fu18mESm5ISLnYOTH6fl6S+zaqXO7YwSBjSTYKZyVoiHLhSNCOfHRsDNUYzUPUkIPiYm
 7ydDaJxXT5dRkkcEzk1FWocWMG6JDdnkUaEDwNqWc=
X-Received: by 2002:a05:600c:1c29:b0:42f:8515:e479 with SMTP id
 5b1f17b1804b1-430ccf1b06bmr10736795e9.4.1728467223708; 
 Wed, 09 Oct 2024 02:47:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHL7vls5kcNVvdId8ftDZ1XKreLngtwEKOPDmF1mk0TamZefma8bmLVF91+D0wDkTwdiTC0XA==
X-Received: by 2002:a05:600c:1c29:b0:42f:8515:e479 with SMTP id
 5b1f17b1804b1-430ccf1b06bmr10736585e9.4.1728467223226; 
 Wed, 09 Oct 2024 02:47:03 -0700 (PDT)
Received: from avogadro.local ([151.62.111.131])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43096601152sm16362115e9.0.2024.10.09.02.47.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 02:47:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PULL 11/14] meson: define qemu_isa_flags
Date: Wed,  9 Oct 2024 11:46:12 +0200
Message-ID: <20241009094616.1648511-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241009094616.1648511-1-pbonzini@redhat.com>
References: <20241009094616.1648511-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
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


