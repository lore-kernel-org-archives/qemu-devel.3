Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5706CC25B78
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2024 11:37:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sApfh-0003PM-0D; Sat, 25 May 2024 07:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sApff-0003OU-Nj
 for qemu-devel@nongnu.org; Sat, 25 May 2024 07:34:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sApfe-0004B6-7D
 for qemu-devel@nongnu.org; Sat, 25 May 2024 07:34:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716636880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3sEk1rvH/evWwEYWhEaFKw6+w0WamReoUwldQRZvSf0=;
 b=M13DRuCdu2P4nR+BLqY5OQeHrsDZ679uHpBEIuLVjddC02azJc5TvbKJEiWDOjk8wSAfld
 4ZmPUzgm+J3VWcLjbWqOgIS/aVcPizDHKeeXFWlDobxEPMYfSINMPd+4dMvIGUKVhr4bKC
 ZqRiN6lDU7QdT58IcKbNyIHT61aqf2k=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-FstQo-nVM_2RYTObatxp5w-1; Sat, 25 May 2024 07:34:38 -0400
X-MC-Unique: FstQo-nVM_2RYTObatxp5w-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a621c9a65f4so137735366b.2
 for <qemu-devel@nongnu.org>; Sat, 25 May 2024 04:34:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716636877; x=1717241677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3sEk1rvH/evWwEYWhEaFKw6+w0WamReoUwldQRZvSf0=;
 b=l32GQDEia/RHzQSN+LhPexvsU1+aqOUSigSIoIah62/InAY6rmF/+NtcVd6z7ZSIyC
 /E8s7vcKQ8NLPOOVoyrpfHoF3i4fELfxiG7sYK3F9Ej1zIVms1D+ctkeQchgqKWhcTNT
 41iw2gEy+5podNMxR2Li//ZvP0bLrYD2FRnb2Skyqr1LK/NP0rJZsfuHgnegjSbMzR0f
 8NVKjWvlx08jGFAyMoqIkBX7SsDEFmkzTWgf2IV3/flZRErPJdWednOk7AOG8l1EluCj
 M98ok9lJ7aTVR6A4CfZMuy439zdUTs+BY6ZlQOutpQ+DC948wf6DnMrKFnQx3ICrCu3R
 LZnQ==
X-Gm-Message-State: AOJu0Yy8as3hdV7Z+Rw+o6+gU951z2tc54Gu4krY8ny3rXjQquHZuY8V
 oLDm7AWGd2pNddvrE6WEBrf12ujrkoRzlirkp//z1/JUTbt1ni/GZov1/2Jc4unS/tCmw989yul
 mLaumKSwzZj1Z2ABK68vILLHtVDhIkdC/+8ntNQx9oAkofZOYLia6fSArnR1+w9suptwyNfV4Zv
 NaI3oQqmXvkGHewA4J5XifMZc1SZy1pv5PFirC
X-Received: by 2002:a17:906:2719:b0:a62:ad3e:2528 with SMTP id
 a640c23a62f3a-a62ad3e2616mr93825066b.14.1716636877188; 
 Sat, 25 May 2024 04:34:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIHZDAwSEN6dZBp8XzkZGTcd1q8BsawcvAFBsq/YcGh9JkqVoBdI9wKksHK7pyPOVI4ANOWQ==
X-Received: by 2002:a17:906:2719:b0:a62:ad3e:2528 with SMTP id
 a640c23a62f3a-a62ad3e2616mr93824066b.14.1716636876605; 
 Sat, 25 May 2024 04:34:36 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626cc893fasm247057466b.143.2024.05.25.04.34.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 May 2024 04:34:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 21/24] meson: remove unnecessary dependency
Date: Sat, 25 May 2024 13:33:29 +0200
Message-ID: <20240525113332.1404158-22-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240525113332.1404158-1-pbonzini@redhat.com>
References: <20240525113332.1404158-1-pbonzini@redhat.com>
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


