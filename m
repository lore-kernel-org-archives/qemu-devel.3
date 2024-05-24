Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF9CC25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 16:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAXea-0005wb-06; Fri, 24 May 2024 12:20:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sAXeY-0005wI-NS
 for qemu-devel@nongnu.org; Fri, 24 May 2024 12:20:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sAXeU-0006vm-5J
 for qemu-devel@nongnu.org; Fri, 24 May 2024 12:20:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716567617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3sEk1rvH/evWwEYWhEaFKw6+w0WamReoUwldQRZvSf0=;
 b=Hn7KC7hximljcVlI73cwa6txrbSYBwLDfyEcU/U6Za5d4IazT1N5bXYkt0YbZ15/Ws62Oh
 rGMLrjer0AtftyRBCeRyVKuHRNR/wlvvq2r6/IjtsLHE1aCYw3/jZO9HTzW7rTwwVJY79M
 p8WPOmCX5N6jt5G7ff5bWI352fSZ/OI=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-c0z-iDnKOtqtjw41pIrGwg-1; Fri, 24 May 2024 12:20:15 -0400
X-MC-Unique: c0z-iDnKOtqtjw41pIrGwg-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2e95ad43e9fso7624411fa.2
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 09:20:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716567613; x=1717172413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3sEk1rvH/evWwEYWhEaFKw6+w0WamReoUwldQRZvSf0=;
 b=ZzhlD/y1ESYx//S1aQiSUG6OFnJd9GQAddCmlBXPJRg9m0d56pZ5qYt5J/RD/+3SoG
 aK9Ae7PjXBwOQXz1wbiEc9hK6dBpGf/4wSptsf0QmAX2k0meZyc698Sf61TKCFDd5ZLt
 t65tAP1wNE+FiKgY3b/95oDhV8Tev5/jn7iqDCa0b2ffIlo/Cuk9T0rOsKB8UAdzeYHL
 FFFCV3vD7hyl9T15coStmlzgaz/pLhLneh1P6y8jTXQlW/omVgUSKmiKh5rh5WOghI1U
 dc9A2ALt623jZVRkxVRXYz2IYyyb8GrQvCe/PinSGCTSNtIY2/apkfGK/I8bTujaYh+U
 U/Ow==
X-Gm-Message-State: AOJu0YzNvz/hbYeQpC/goWScCWs9Mr+DllM1tFgT3CwG2h3UUXMEbl6R
 qR+fqD0jryES+frUIp9DRKbsUIpLy66MH/2ItrWd6FiYu/gJbZzIHc1g838NMs/gopfXsLpF4AS
 426GGmH5NjTAaiC6E0BD8+4wrDJCXwdljTg83C6Ts/2M0d5uSS3LDs0Bwya/JdV9PS+15xhwmOP
 m2bMTglHVBwKctsBMb3Jo/qSjHf8SA/wmYs1Yp
X-Received: by 2002:a05:6512:10cc:b0:523:7f19:cb44 with SMTP id
 2adb3069b0e04-52965198b94mr2382400e87.29.1716567613560; 
 Fri, 24 May 2024 09:20:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7Wl5brTiOmcL4b/xr3ZIj6Q24X7XAWmo2DUrBCiyMxyHS7qJxQVpxFbha3pUpPeT3jj7Mww==
X-Received: by 2002:a05:6512:10cc:b0:523:7f19:cb44 with SMTP id
 2adb3069b0e04-52965198b94mr2382367e87.29.1716567612963; 
 Fri, 24 May 2024 09:20:12 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-529716df1c1sm204323e87.304.2024.05.24.09.20.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 09:20:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/5] meson: remove unnecessary dependency
Date: Fri, 24 May 2024 18:20:02 +0200
Message-ID: <20240524162006.1271778-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240524162006.1271778-1-pbonzini@redhat.com>
References: <20240524162006.1271778-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The dbus_display1_dep is not really used since all occurrences also
request gio independently.  Just list the generated sources and drop
dbus_display1_dep.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 audio/meson.build       | 4 ++--
 tests/qtest/meson.build | 2 +-
 ui/meson.build          | 5 ++---
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/audio/meson.build b/audio/meson.build
index 608f35e6af7..59f0a431d51 100644
--- a/audio/meson.build
+++ b/audio/meson.build
@@ -30,8 +30,8 @@ endforeach
 
 if dbus_display
     module_ss = ss.source_set()
-    module_ss.add(when: [gio, dbus_display1_dep, pixman],
-                  if_true: files('dbusaudio.c'))
+    module_ss.add(when: [gio, pixman],
+                  if_true: [dbus_display1, files('dbusaudio.c')])
     audio_modules += {'dbus': module_ss}
 endif
 
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 86293051dce..b98fae6a6dd 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -354,7 +354,7 @@ if vnc.found()
 endif
 
 if dbus_display
-  qtests += {'dbus-display-test': [dbus_display1_dep, gio]}
+  qtests += {'dbus-display-test': [dbus_display1, gio]}
 endif
 
 qtest_executables = {}
diff --git a/ui/meson.build b/ui/meson.build
index 5d89986b0ee..cfbf29428df 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -91,8 +91,7 @@ if dbus_display
                                           '--interface-prefix', 'org.qemu.',
                                           '--c-namespace', 'QemuDBus',
                                           '--generate-c-code', '@BASENAME@'])
-  dbus_display1_dep = declare_dependency(sources: dbus_display1, dependencies: gio)
-  dbus_ss.add(when: [gio, dbus_display1_dep],
+  dbus_ss.add(when: gio,
               if_true: [files(
                 'dbus-chardev.c',
                 'dbus-clipboard.c',
@@ -100,7 +99,7 @@ if dbus_display
                 'dbus-error.c',
                 'dbus-listener.c',
                 'dbus.c',
-              ), opengl, gbm, pixman])
+              ), opengl, gbm, pixman, dbus_display1])
   ui_modules += {'dbus' : dbus_ss}
 endif
 
-- 
2.45.1


