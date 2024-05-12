Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1103CC10F1A
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2024 10:52:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s66nF-0003g4-0g; Sun, 12 May 2024 06:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s66n6-0003Xc-Ia
 for qemu-devel@nongnu.org; Sun, 12 May 2024 06:50:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s66n4-00069v-Vl
 for qemu-devel@nongnu.org; Sun, 12 May 2024 06:50:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715511050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=06tnROEYbNdlOjy/Cabi3aQ+xVn+VV5Uf85hOLxVCTM=;
 b=cT7CT4xXAKK55sZ72rmrWVmOYsIXbAJyH+e/FVsjx6UJr2YlIa2M8S58m+8MCxE/ymSjoh
 Yq6y/QibX/RCdWeeMGTLdIwBjoVVeWpWjckp6jSeLCL9eXeXx/KXmDASNSwGHlBpBhjxrA
 XBg7ETwlf/MS1IdY2d/gOlAgcTcAutc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-idc5n44jNG2zlnfwGQD-kQ-1; Sun, 12 May 2024 06:50:48 -0400
X-MC-Unique: idc5n44jNG2zlnfwGQD-kQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a59a1fe7396so227179966b.3
 for <qemu-devel@nongnu.org>; Sun, 12 May 2024 03:50:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715511046; x=1716115846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=06tnROEYbNdlOjy/Cabi3aQ+xVn+VV5Uf85hOLxVCTM=;
 b=nNFctuTvjlCarGGBa7FXQVYHze7eIoBb+Koq0KhpOOJgGMHGe//uQIAm7zY4PnzTDp
 6zJh8eqFMQxoip09kGTjvGYj0GSvu/2VBw2PORyp870CPV0Cj3qrPpHyEDXx0l8v+Gdu
 tvUTjaq6yLAlaEu0PZVohiepR6AG2TPGGaHxd9tDE0t15vHyJgZdgtYR4P/Ly6I+VMRm
 oCNEC1Xu1TdaIqbrd4mMQjtmkQ6RJV7sCnv6lMqovwl53XIHHOHWNupkkf0jxcOD5/5h
 qFGCfgE0V9M/V1sbH4hqpS42J4KOLc3SWubdeFYzXn+bIRimdt7P44G+Dwg9jYgSVpaW
 Kx6w==
X-Gm-Message-State: AOJu0YwEt4nFQL1gC7xlsJMtmbrgdSeSoMlP2wz/9XLwPvwdxfw2Qhba
 D7M6WBOoesfmCIyGge3YjZ69AVI6svp4F8WVh8h27W15Hs2/yF86L19bmF9y6oELh+2yqIWR8r/
 gWjDe2X/P0iM2LGPDMiQD8xkCAPMWXw4siZudBXcu5Kn0FR+cuw5FpkTV+eNtOA0LRGhzf0Qzd6
 cpievbgIU+hFAXxPVZtp9BM+W3CFMyIllvd8YM
X-Received: by 2002:a17:907:26c9:b0:a59:ba2b:5913 with SMTP id
 a640c23a62f3a-a5a2d66b525mr593301466b.62.1715511045952; 
 Sun, 12 May 2024 03:50:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhgSuvqUHo8+OApbS+2ShTQmb+abIloJGP3oYeTOLzlneCoW6XvL862kgoXDAN6CQvuIsTwA==
X-Received: by 2002:a17:907:26c9:b0:a59:ba2b:5913 with SMTP id
 a640c23a62f3a-a5a2d66b525mr593300466b.62.1715511045532; 
 Sun, 12 May 2024 03:50:45 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17b17cd0sm442135366b.214.2024.05.12.03.50.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 May 2024 03:50:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 23/27] meson: move libfdt together with other dependencies
Date: Sun, 12 May 2024 12:49:41 +0200
Message-ID: <20240512104945.130198-24-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240512104945.130198-1-pbonzini@redhat.com>
References: <20240512104945.130198-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.587,
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

Move the libfdt detection code together with other dependencies instead
of keeping it with subprojects.  This has the disadvantage of performing
the detection even if no target requires libfdt; but it has the advantage
that Kconfig will be able to observe the availability of the library.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 79 ++++++++++++++++++++++++++---------------------------
 1 file changed, 38 insertions(+), 41 deletions(-)

diff --git a/meson.build b/meson.build
index ab1f44b25c2..dd4a28f8f8f 100644
--- a/meson.build
+++ b/meson.build
@@ -1858,6 +1858,34 @@ if numa.found() and not cc.links('''
   endif
 endif
 
+fdt = not_found
+fdt_opt = get_option('fdt')
+if fdt_opt == 'enabled' and get_option('wrap_mode') == 'nodownload'
+  fdt_opt = 'system'
+endif
+if fdt_opt in ['enabled', 'system'] or (fdt_opt == 'auto' and have_system)
+  fdt = cc.find_library('fdt', required: fdt_opt == 'system')
+  if fdt.found() and cc.links('''
+     #include <libfdt.h>
+     #include <libfdt_env.h>
+     int main(void) { fdt_find_max_phandle(NULL, NULL); return 0; }''',
+       dependencies: fdt)
+    fdt_opt = 'system'
+  elif fdt_opt != 'system'
+    fdt_opt = get_option('wrap_mode') == 'nodownload' ? 'disabled' : 'internal'
+    fdt = not_found
+  else
+    error('system libfdt is too old (1.5.1 or newer required)')
+  endif
+endif
+if fdt_opt == 'internal'
+  assert(not fdt.found())
+  libfdt_proj = subproject('dtc', required: true,
+                           default_options: ['tools=false',  'yaml=disabled',
+                                             'python=disabled', 'default_library=static'])
+  fdt = libfdt_proj.get_variable('libfdt_dep')
+endif
+
 rdma = not_found
 if not get_option('rdma').auto() or have_system
   libumad = cc.find_library('ibumad', required: get_option('rdma'))
@@ -2199,6 +2227,7 @@ config_host_data.set('CONFIG_BSD', host_os in bsd_oses)
 config_host_data.set('CONFIG_CAPSTONE', capstone.found())
 config_host_data.set('CONFIG_COCOA', cocoa.found())
 config_host_data.set('CONFIG_DARWIN', host_os == 'darwin')
+config_host_data.set('CONFIG_FDT', fdt.found())
 config_host_data.set('CONFIG_FUZZ', get_option('fuzzing'))
 config_host_data.set('CONFIG_GCOV', get_option('b_coverage'))
 config_host_data.set('CONFIG_LIBUDEV', libudev.found())
@@ -3024,14 +3053,16 @@ foreach target : target_dirs
     error('No accelerator available for target @0@'.format(target))
   endif
 
-  actual_target_dirs += target
   config_target += keyval.load('configs/targets' / target + '.mak')
   config_target += { 'TARGET_' + config_target['TARGET_ARCH'].to_upper(): 'y' }
 
-  if 'TARGET_NEED_FDT' in config_target
+  if 'TARGET_NEED_FDT' in config_target and not fdt.found()
     fdt_required += target
+    continue
   endif
 
+  actual_target_dirs += target
+
   # Add default keys
   if 'TARGET_BASE_ARCH' not in config_target
     config_target += {'TARGET_BASE_ARCH': config_target['TARGET_ARCH']}
@@ -3119,6 +3150,10 @@ genh += custom_target('config-poison.h',
                       command: [find_program('scripts/make-config-poison.sh'),
                                 target_configs_h])
 
+if fdt_required.length() > 0
+  error('fdt disabled but required by targets ' + ', '.join(fdt_required))
+endif
+
 ###############
 # Subprojects #
 ###############
@@ -3129,44 +3164,6 @@ if have_system and vfio_user_server_allowed
   libvfio_user_dep = libvfio_user_proj.get_variable('libvfio_user_dep')
 endif
 
-fdt = not_found
-fdt_opt = get_option('fdt')
-if fdt_required.length() > 0 or fdt_opt == 'enabled'
-  if fdt_opt == 'disabled'
-    error('fdt disabled but required by targets ' + ', '.join(fdt_required))
-  endif
-
-  if fdt_opt in ['enabled', 'auto', 'system']
-    if get_option('wrap_mode') == 'nodownload'
-      fdt_opt = 'system'
-    endif
-    fdt = cc.find_library('fdt', required: fdt_opt == 'system')
-    if fdt.found() and cc.links('''
-       #include <libfdt.h>
-       #include <libfdt_env.h>
-       int main(void) { fdt_find_max_phandle(NULL, NULL); return 0; }''',
-         dependencies: fdt)
-      fdt_opt = 'system'
-    elif fdt_opt == 'system'
-       error('system libfdt requested, but it is too old (1.5.1 or newer required)')
-    else
-      fdt_opt = 'internal'
-      fdt = not_found
-    endif
-  endif
-  if not fdt.found()
-    assert(fdt_opt == 'internal')
-    libfdt_proj = subproject('dtc', required: true,
-                             default_options: ['tools=false',  'yaml=disabled',
-                                               'python=disabled', 'default_library=static'])
-    fdt = libfdt_proj.get_variable('libfdt_dep')
-  endif
-else
-  fdt_opt = 'disabled'
-endif
-
-config_host_data.set('CONFIG_FDT', fdt.found())
-
 vhost_user = not_found
 if host_os == 'linux' and have_vhost_user
   libvhost_user = subproject('libvhost-user')
@@ -4417,7 +4414,7 @@ summary_info += {'Linux AIO support': libaio}
 summary_info += {'Linux io_uring support': linux_io_uring}
 summary_info += {'ATTR/XATTR support': libattr}
 summary_info += {'RDMA support':      rdma}
-summary_info += {'fdt support':       fdt_opt == 'disabled' ? false : fdt_opt}
+summary_info += {'fdt support':       fdt_opt == 'internal' ? 'internal' : fdt}
 summary_info += {'libcap-ng support': libcap_ng}
 summary_info += {'bpf support':       libbpf}
 summary_info += {'rbd support':       rbd}
-- 
2.45.0


