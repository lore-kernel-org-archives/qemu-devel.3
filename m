Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71369C25B4F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 07:52:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4c5f-00071w-Et; Wed, 08 May 2024 03:51:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4c57-0006nn-DM
 for qemu-devel@nongnu.org; Wed, 08 May 2024 03:51:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4c55-0003dC-LU
 for qemu-devel@nongnu.org; Wed, 08 May 2024 03:51:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715154674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aF6SQzXi+7Oush+66RT8SAXzChZcE8LPXmBbHUWcUJI=;
 b=b5HttNku8EjwZOSBNaN7Ze+LIEa+qEJCsI8aVQQUWhBxOtbEEgiSiRI2hCa39quUF/AXdp
 1s82V0/GrU6y5rBvAXPsZaVB2AHRLGywarmDvCjyJQScs+7sR76T0QqTpFF/Y783VpkNh3
 sri+AjCmR1UsT8ipuSO377Jmc5H5/EY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-V8TBXfEGPHi6a5tz_qCzgw-1; Wed, 08 May 2024 03:51:13 -0400
X-MC-Unique: V8TBXfEGPHi6a5tz_qCzgw-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-572a0c5ece9so2210010a12.2
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 00:51:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715154671; x=1715759471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aF6SQzXi+7Oush+66RT8SAXzChZcE8LPXmBbHUWcUJI=;
 b=u6Y2izUvVCobd1c2qQn6Olj+4vJ52gZMDXwnMQ2xOrslGd4zqoWSi0ROF+k6bHbLa6
 q+jGoGo1l7sf2FyTvWFUhE9Ba9HDxvGAvrAyIsUFAL0BpvKyLrOq6DHUtPSqpOV8OWYG
 Pxc8I5YXc88maPba+tIrxMnU7ohR4cBy0mnFAkqtzTGa6NAReT2ifjZyZLhxzKSTZGTn
 8DoAZ2yMiFnccUNCRitjo7Y/QaksCbtD4QG0zeRt4UlLprX5UIDsV9mExovhe+4vXqn1
 hJO3tl2AHF/r9uVKn/WzoogC6qkUIhbNCGZ15kKwlff8CL0xWhTgU0AkQD8i77y2ueNp
 t9aQ==
X-Gm-Message-State: AOJu0Yxvlac6hpz8ckBr/xXyM1EpKL+Ff9m/7G69X4e8rI0opkxB326F
 jI5laqxNA3fbeBobqToIdrwV9OnPb7Z9Xr9gcPviV2nfGL18su71QRVWUxLsHjlGGWr16nqnMjX
 Tpq9VQ8F5qJB7sZJ/fl/MlrK7ymyxojzUNepBjLWaeV1j5LBCgfgaOKFEmQflcy86eNi2H4iDfY
 8NwRukQnUje6s1CnMQ5MPouqvwDjVgakElJn6A
X-Received: by 2002:a50:c058:0:b0:56e:2daf:1ee6 with SMTP id
 4fb4d7f45d1cf-5731d9d453bmr1040436a12.16.1715154671595; 
 Wed, 08 May 2024 00:51:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGV01I27rqhAqFQss75UdBEuV42V+CYWvqMC+VjX2bLX6QqiYcVrGE63vRD1q9xVDkJbGnwkA==
X-Received: by 2002:a50:c058:0:b0:56e:2daf:1ee6 with SMTP id
 4fb4d7f45d1cf-5731d9d453bmr1040426a12.16.1715154671247; 
 Wed, 08 May 2024 00:51:11 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 d25-20020aa7ce19000000b00572a7127cb0sm7308880edv.50.2024.05.08.00.51.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 May 2024 00:51:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH 2/6] meson: move libfdt together with other dependencies
Date: Wed,  8 May 2024 09:51:01 +0200
Message-ID: <20240508075105.15510-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240508075105.15510-1-pbonzini@redhat.com>
References: <20240508075105.15510-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 79 ++++++++++++++++++++++++++---------------------------
 1 file changed, 38 insertions(+), 41 deletions(-)

diff --git a/meson.build b/meson.build
index 7ca0ba4987f..2e7e2b15406 100644
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
@@ -3025,14 +3054,16 @@ foreach target : target_dirs
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
@@ -3120,6 +3151,10 @@ genh += custom_target('config-poison.h',
                       command: [find_program('scripts/make-config-poison.sh'),
                                 target_configs_h])
 
+if fdt_required.length() > 0
+  error('fdt disabled but required by targets ' + ', '.join(fdt_required))
+endif
+
 ###############
 # Subprojects #
 ###############
@@ -3130,44 +3165,6 @@ if have_system and vfio_user_server_allowed
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
@@ -4419,7 +4416,7 @@ summary_info += {'Linux AIO support': libaio}
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


