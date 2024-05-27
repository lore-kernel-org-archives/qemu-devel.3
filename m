Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4415C41513
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 10:50:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBXvS-0000yO-AG; Mon, 27 May 2024 06:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sBXvL-0000tB-5H
 for qemu-devel@nongnu.org; Mon, 27 May 2024 06:49:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sBXvG-0001Cw-Qv
 for qemu-devel@nongnu.org; Mon, 27 May 2024 06:49:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716806986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1tM29WfhfyEOTzjt/XNRBsoe6DlIh4rkAE5ygZhRbqM=;
 b=hjp0V8LZd3GmUmoD1ISa29yxaHHBknoQwB5WtyZfRJmY/MZXLL753Mdh28R31aPLk/3d/s
 4sQS1c/f7O4uZkb6eL+w1fPSZ/zwhEJJkbL9v1ecyXjbLfLSN07ChoMb1wapp2BDXcxy1s
 zHKL2MRtalpIwUCKFytlzSWrdxPweDk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-CXVpgVGgOPOIXMByqgRTTQ-1; Mon, 27 May 2024 06:49:44 -0400
X-MC-Unique: CXVpgVGgOPOIXMByqgRTTQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a629e32f5fdso81242066b.2
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 03:49:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716806982; x=1717411782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1tM29WfhfyEOTzjt/XNRBsoe6DlIh4rkAE5ygZhRbqM=;
 b=s0saa30u66kUZyeIjxr7S/zv4x18D81tC00jp6wqCwNPF/vShXVcSJdQugb24ij0NI
 aZZuuKDGV97gkl6EoH4jpe0yxZOlLURRWgbvVK5NIx198+NEBmCCtE9IsKhEHdBERlhT
 pOxfx9zSyHaPdCxQCfuWKlAjHcmWzpT5uUkr3bMn8bmN5RaCGcBprXiZQMoCI58D5ogy
 eUixXdTwH9xpRC9UjbY5u3hQqZb+zbiFHWyFmBTW24GlZWBJ14W84PxBX89AENwLbwkZ
 Wv3R3QFSPpzSm199ABy7GdAyPymweYQYRFxWUlunHF4NBQXIGvnxRv63qRFBWCyUITiH
 PcNA==
X-Gm-Message-State: AOJu0Yytv1WF1Y27KQJyj1HkqYWAytEL1aAM2Q3mpVD7ojqvd28Ya1S1
 rT/Ez/nnpSH75VFnVchd7MlsXK6Ro2YK5GhHnBadx7LVCBq8ngqAFFcHjUpcsTjmVmf39H0wDgn
 DFnrv+CECFzPoixC5LU2+LjbOLgeNz6iVxe/RBCSRSBLEB7oxtotQZ4QCQ9P6u9EMDSRWQsP2DC
 Co/grBSYADqf8zDgIMmh5U/T6YzD9/WDTy/Z4Q
X-Received: by 2002:a17:906:2a02:b0:a62:187b:e7f5 with SMTP id
 a640c23a62f3a-a62651287femr558469466b.57.1716806982681; 
 Mon, 27 May 2024 03:49:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtQFTWTPxzajdvMgPY68bN+7LR3G78mAVzfqt+oZOvKtTwXzsVQM61ZQss11Z//DpM7FZbig==
X-Received: by 2002:a17:906:2a02:b0:a62:187b:e7f5 with SMTP id
 a640c23a62f3a-a62651287femr558468066b.57.1716806982159; 
 Mon, 27 May 2024 03:49:42 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626c93842csm477217966b.74.2024.05.27.03.49.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 03:49:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: akihiko.odaki@daynix.com
Subject: [RFC PATCH v2 1/5] meson: move shared_module() calls where modules
 are already walked
Date: Mon, 27 May 2024 12:49:33 +0200
Message-ID: <20240527104937.30443-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527104937.30443-1-pbonzini@redhat.com>
References: <20240527104937.30443-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
index 63866071445..92ddbd17c32 100644
--- a/meson.build
+++ b/meson.build
@@ -3562,21 +3562,28 @@ modinfo_files = []
 
 block_mods = []
 system_mods = []
+emulator_modules = []
 foreach d, list : modules
   if not (d == 'block' ? have_block : have_system)
     continue
   endif
 
   foreach m, module_ss : list
+    module_ss.add(modulecommon)
     if enable_modules
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
@@ -3601,6 +3608,7 @@ endforeach
 
 foreach d, list : target_modules
   foreach m, module_ss : list
+    module_ss.add(modulecommon)
     if enable_modules
       foreach target : target_dirs
         if target.endswith('-softmmu')
@@ -3614,11 +3622,16 @@ foreach d, list : target_modules
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
@@ -3652,6 +3665,10 @@ if enable_modules
       hw_arch[arch].add(modinfo_dep)
     endif
   endforeach
+
+  if emulator_modules.length() > 0
+    alias_target('modules', emulator_modules)
+  endif
 endif
 
 nm = find_program('nm')
@@ -3745,19 +3762,6 @@ common_ss.add(hwcore)
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
2.45.1


