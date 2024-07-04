Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A376C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 09:59:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPJEI-0006RC-1V; Thu, 04 Jul 2024 05:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sPJEG-0006Qj-8C
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 05:58:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sPJEE-000854-JJ
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 05:58:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720087093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EYG7z0+92zsKHX2B0kS2w6WkiJ9TG5QWULKkYSPwyBU=;
 b=GorGj7byopdBn3WFbRVhRUI2tLdJOVj9jMPFdjpHW0XefOmlgT1l8E4veCMXb/XfITj09M
 meyeqSPhCq5rv1dFN3wZmEg7dJ2OERrH4NS+mt4xGikAXbCiygF8iQu3qWDKmEdHKj2h6N
 RKd6hrqGx/+SjRFRpPnAAZE/sArAxdk=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-o-fV7CN6NCCRB8Jj-ZFBkQ-1; Thu, 04 Jul 2024 05:58:11 -0400
X-MC-Unique: o-fV7CN6NCCRB8Jj-ZFBkQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-52ea249d1c9so187217e87.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 02:58:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720087090; x=1720691890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EYG7z0+92zsKHX2B0kS2w6WkiJ9TG5QWULKkYSPwyBU=;
 b=ZM8s2VOZTJPTcD8JJ7qWlirZvsh7hh0pH9qmk4yqczTYG+sNZCux2VxkvyygK6Ktgh
 9N3KP1FYr9pOELB/jcGJQEjcFfKl8J4sJb5lI1hnG/SRdg5UruQYhfj5RHVGlKB4hI8g
 pPPzI/ZcZ7iG2axjLUreCbaFyTnd2hi1S7ghgJuKvH75MoBOeGv54iW8dYOYKY1gNLR4
 DztOXoKxUzc/2wPOpupV+/pu2eax3XtxZsoeOe0+zRmhjPv0KEsxQf46NDo6PgXko4an
 34v65DAQIje33vBc0X2Ad76nFlg3YYL70fcPkZ+f0OHU/cxwcWN1VrR8X9R8j92DtXc7
 7tAQ==
X-Gm-Message-State: AOJu0Yw2J7yYhsu9qiklnwObjYRoFpZ2RxXlKjD8hrv+K2v7CG7nbKFP
 kv7kfyDUb9OrWx6ksgqlR5LS5WIhzkG5/a4XTOuojyi2Rr/Z+5q+J62ZsQlGaGumQyBZoq7CYV+
 Fy16h/1ZkxEJ2k0uxmy6jerpk+gp1ap8Jz77R2NQEizUd5nx0X+6g4yh0g/d/FKPmShUMJjnZE7
 cC9s7O9CvAGReJqPxaOq6I8SdFtR2rbVbhkz7N
X-Received: by 2002:ac2:57c1:0:b0:52e:7125:c70a with SMTP id
 2adb3069b0e04-52ea06bc9f4mr801000e87.47.1720087089905; 
 Thu, 04 Jul 2024 02:58:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrtf+9BoxgTq+hDNCHdQVz0sxkcrpAjCxOl0rZNolNELJQnztPXtQuW3I5ogVA8NUniAvdVw==
X-Received: by 2002:ac2:57c1:0:b0:52e:7125:c70a with SMTP id
 2adb3069b0e04-52ea06bc9f4mr800991e87.47.1720087089448; 
 Thu, 04 Jul 2024 02:58:09 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a1d50b0sm17612535e9.7.2024.07.04.02.58.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 02:58:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/16] meson: move shared_module() calls where modules are
 already walked
Date: Thu,  4 Jul 2024 11:57:51 +0200
Message-ID: <20240704095806.1780273-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704095806.1780273-1-pbonzini@redhat.com>
References: <20240704095806.1780273-1-pbonzini@redhat.com>
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/meson.build b/meson.build
index 54e6b09f4fb..8909f8c87d9 100644
--- a/meson.build
+++ b/meson.build
@@ -3602,6 +3602,7 @@ modinfo_files = []
 
 block_mods = []
 system_mods = []
+emulator_modules = []
 foreach d, list : modules
   if not (d == 'block' ? have_block : have_system)
     continue
@@ -3609,14 +3610,20 @@ foreach d, list : modules
 
   foreach m, module_ss : list
     if enable_modules
+      module_ss.add(modulecommon)
       module_ss = module_ss.apply(config_all_devices, strict: false)
       sl = static_library(d + '-' + m, [genh, module_ss.sources()],
-                          dependencies: [modulecommon, module_ss.dependencies()], pic: true)
+                          dependencies: module_ss.dependencies(), pic: true)
       if d == 'block'
         block_mods += sl
       else
         system_mods += sl
       endif
+      emulator_modules += shared_module(sl.name(),
+                    name_prefix: '',
+                    link_whole: sl,
+                    install: true,
+                    install_dir: qemu_moddir)
       if module_ss.sources() != []
         # FIXME: Should use sl.extract_all_objects(recursive: true) as
         # input. Sources can be used multiple times but objects are
@@ -3642,6 +3649,7 @@ endforeach
 foreach d, list : target_modules
   foreach m, module_ss : list
     if enable_modules
+      module_ss.add(modulecommon)
       foreach target : target_dirs
         if target.endswith('-softmmu')
           config_target = config_target_mak[target]
@@ -3654,11 +3662,16 @@ foreach d, list : target_modules
             module_name = d + '-' + m + '-' + config_target['TARGET_NAME']
             sl = static_library(module_name,
                                 [genh, target_module_ss.sources()],
-                                dependencies: [modulecommon, target_module_ss.dependencies()],
+                                dependencies: target_module_ss.dependencies(),
                                 include_directories: target_inc,
                                 c_args: c_args,
                                 pic: true)
             system_mods += sl
+            emulator_modules += shared_module(sl.name(),
+                    name_prefix: '',
+                    link_whole: sl,
+                    install: true,
+                    install_dir: qemu_moddir)
             # FIXME: Should use sl.extract_all_objects(recursive: true) too.
             modinfo_files += custom_target(module_name + '.modinfo',
                                            output: module_name + '.modinfo',
@@ -3692,6 +3705,10 @@ if enable_modules
       hw_arch[arch].add(modinfo_dep)
     endif
   endforeach
+
+  if emulator_modules.length() > 0
+    alias_target('modules', emulator_modules)
+  endif
 endif
 
 nm = find_program('nm')
@@ -3785,19 +3802,6 @@ common_ss.add(hwcore)
 # Targets #
 ###########
 
-emulator_modules = []
-foreach m : block_mods + system_mods
-  emulator_modules += shared_module(m.name(),
-                build_by_default: true,
-                name_prefix: '',
-                link_whole: m,
-                install: true,
-                install_dir: qemu_moddir)
-endforeach
-if emulator_modules.length() > 0
-  alias_target('modules', emulator_modules)
-endif
-
 system_ss.add(authz, blockdev, chardev, crypto, io, qmp)
 common_ss.add(qom, qemuutil)
 
-- 
2.45.2


