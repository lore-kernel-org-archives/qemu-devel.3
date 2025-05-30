Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B552EC5AD49
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:16:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKtvY-0008GH-4w; Fri, 30 May 2025 03:13:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtvS-0008FY-UQ
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:13:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtvQ-0006oS-Ug
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:13:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eTt+ijUG9kBQToPAyx24wWv7Og7qKej64dv1M2DfvhE=;
 b=giwndl0bRcen3IU0dLMklWeRFlkF7a0y4X57CN/N3cscSQXvelbyglNHHwpBv3ltI450ON
 t2SoRCkLtoRBxhqzqRp9C/N1ZURi6VVL3r6S3VEk7zQ77dIT22sUSf0Ifse9i3CwrWk08R
 dKhiz6EOFPdDHnViJFcIXKLUK/iC3Uo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-3QIkPAbJMuWIJPeenv9wEA-1; Fri, 30 May 2025 03:13:06 -0400
X-MC-Unique: 3QIkPAbJMuWIJPeenv9wEA-1
X-Mimecast-MFC-AGG-ID: 3QIkPAbJMuWIJPeenv9wEA_1748589186
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-60498322443so1674249a12.2
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:13:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589185; x=1749193985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eTt+ijUG9kBQToPAyx24wWv7Og7qKej64dv1M2DfvhE=;
 b=MPnqGBk/Ra02ZYHEqmitr+C2M7+60ejXiEI6KuJ9IhrD4HgKsaRH6XsoIaMyFajhV8
 TWOnWKrU0JnsoJ74d8jvQJZT4j1pn0CE9kkjtAw0EzWgtR+EUyAnra2hQXVC5JJBh67o
 Do5CDTqlt8vf0MB6IgTeCPAylmjPF3V/7+veM3jNFgrYzELrvcOXDJt0HOiz8CZoOAwt
 LvY1vnt4VJOObZgUFGqTXT6jp0jcQntH4AP7Q4yyBlJXRj8PTdUx6szdRg8DOwMC11ca
 4XOB5IEf1MEGzYSZ0nMXqqsBgutYalkwFqxJal0MBN6zyBFyap5leOIK90az4gBJMFyu
 JR1w==
X-Gm-Message-State: AOJu0Yyn4Y5DPh/amjvM9PDNHWXvVsrz7Yt6E3zFDp/w1Ur4XV4Y4tA5
 ZJAIoDlioe5V97FVGnov3Oa++ELCOKVy0lB+YQ0okWxn+qnC5/TJ4PjIgcs2zBUdWTrAIO+7UAb
 y8mIrotkscyTX9MFV16cJOsWRbZSgnpIzGe07BL26CsWtnVGehbYTWddUTktK+kw5ZUGLfORUjn
 c6QQ+CsFKbtXuRGauq4wBnUM7ma6+01iocpZUXN1mz
X-Gm-Gg: ASbGncsV3lPGEt6ivWEiH4BZ92CuLmFKVo+jU93hVitCrNNHcdKRL6iTx7PUamXnPLf
 Uw4N0JzKqb/4Nm8hkxyFOzBHtUvVqCs3YKN16tGPLmqeammnFTnUSZZ6ibVMoecd349t+5B2iHl
 wTwT47RC/qGCi5EDPG9+xrcmT75yGTG1PDevTpDQnTeF4z4Gm/3mBMVwoF6sYdx/Dnx2YFKXfmh
 ZSHkRycaFLDiQN2r2rvBIQRyOwnY7ttEa6NqKm1FNpf2gzR3+ZrDN/uXztAJc7NNU+aIrGkwyBR
 pyZIauyMiFCNkw==
X-Received: by 2002:a05:6402:280d:b0:5fc:bff8:c60a with SMTP id
 4fb4d7f45d1cf-6056e15e00cmr1835967a12.26.1748589184817; 
 Fri, 30 May 2025 00:13:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3dsOSWerJOHUIIpjiP3mxeAc8cev0PzOink8HHo5XoHQdAQVDzLtsJMJ5zRpNiCCf/CfuHA==
X-Received: by 2002:a05:6402:280d:b0:5fc:bff8:c60a with SMTP id
 4fb4d7f45d1cf-6056e15e00cmr1835936a12.26.1748589184323; 
 Fri, 30 May 2025 00:13:04 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60566c756f5sm1216983a12.45.2025.05.30.00.13.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:13:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 05/77] meson: merge lib{system, user}_ss with {system, user}_ss
Date: Fri, 30 May 2025 09:11:35 +0200
Message-ID: <20250530071250.2050910-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530071250.2050910-1-pbonzini@redhat.com>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Now that target configuration can be applied to lib{system, user}_ss,
there is no reason to keep that separate from the existing {system,
user}_ss.
The only difference is that we'll now compile those files with
-DCOMPILING_SYSTEM_VS_USER, which removes poison for
CONFIG_USER_ONLY and CONFIG_SOFTMMU, without any other side effect.

We extract existing system/user code common common libraries to
lib{system, user}.

To not break existing meson files, we alias libsystem_ss to system_ss
and libuser_ss to user_ss, so we can do the cleanup in next commit.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/20250521223414.248276-6-pierrick.bouvier@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/meson.build b/meson.build
index 79d123c50ee..ea54d15f4a6 100644
--- a/meson.build
+++ b/meson.build
@@ -3694,14 +3694,14 @@ io_ss = ss.source_set()
 qmp_ss = ss.source_set()
 qom_ss = ss.source_set()
 system_ss = ss.source_set()
-libsystem_ss = ss.source_set()
+libsystem_ss = system_ss
 specific_fuzz_ss = ss.source_set()
 specific_ss = ss.source_set()
 rust_devices_ss = ss.source_set()
 stub_ss = ss.source_set()
 trace_ss = ss.source_set()
 user_ss = ss.source_set()
-libuser_ss = ss.source_set()
+libuser_ss = user_ss
 util_ss = ss.source_set()
 
 # accel modules
@@ -4078,21 +4078,19 @@ common_ss.add(hwcore)
 system_ss.add(authz, blockdev, chardev, crypto, io, qmp)
 common_ss.add(qom, qemuutil)
 
-common_ss.add_all(when: 'CONFIG_SYSTEM_ONLY', if_true: [system_ss])
-common_ss.add_all(when: 'CONFIG_USER_ONLY', if_true: user_ss)
-
 libuser = static_library('user',
-                         libuser_ss.all_sources() + genh,
+                         user_ss.all_sources() + genh,
                          c_args: ['-DCONFIG_USER_ONLY',
                                   '-DCOMPILING_SYSTEM_VS_USER'],
-                         dependencies: libuser_ss.all_dependencies(),
+                         include_directories: common_user_inc,
+                         dependencies: user_ss.all_dependencies(),
                          build_by_default: false)
 
 libsystem = static_library('system',
-                           libsystem_ss.all_sources() + genh,
+                           system_ss.all_sources() + genh,
                            c_args: ['-DCONFIG_SOFTMMU',
                                     '-DCOMPILING_SYSTEM_VS_USER'],
-                           dependencies: libsystem_ss.all_dependencies(),
+                           dependencies: system_ss.all_dependencies(),
                            build_by_default: false)
 
 # Note that this library is never used directly (only through extract_objects)
@@ -4101,7 +4099,6 @@ libsystem = static_library('system',
 common_all = static_library('common',
                             build_by_default: false,
                             sources: common_ss.all_sources() + genh,
-                            include_directories: common_user_inc,
                             implicit_include_directories: false,
                             dependencies: common_ss.all_dependencies())
 
@@ -4115,10 +4112,20 @@ foreach target_base_arch, config_base_arch : config_base_arch_mak
   inc = [common_user_inc + target_inc]
 
   target_common = common_ss.apply(config_target, strict: false)
+  target_system = system_ss.apply(config_target, strict: false)
+  target_user = user_ss.apply(config_target, strict: false)
   common_deps = []
+  system_deps = []
+  user_deps = []
   foreach dep: target_common.dependencies()
     common_deps += dep.partial_dependency(compile_args: true, includes: true)
   endforeach
+  foreach dep: target_system.dependencies()
+    system_deps += dep.partial_dependency(compile_args: true, includes: true)
+  endforeach
+  foreach dep: target_user.dependencies()
+    user_deps += dep.partial_dependency(compile_args: true, includes: true)
+  endforeach
 
   # prevent common code to access cpu compile time definition,
   # but still allow access to cpu.h
@@ -4133,7 +4140,7 @@ foreach target_base_arch, config_base_arch : config_base_arch_mak
       sources: src.all_sources() + genh,
       include_directories: inc,
       c_args: target_system_c_args,
-      dependencies: src.all_dependencies() + common_deps)
+      dependencies: src.all_dependencies() + common_deps + system_deps)
     hw_common_arch_libs += {target_base_arch: lib}
   endif
 
@@ -4145,7 +4152,8 @@ foreach target_base_arch, config_base_arch : config_base_arch_mak
       sources: src.all_sources() + genh,
       include_directories: inc,
       c_args: target_c_args,
-      dependencies: src.all_dependencies() + common_deps)
+      dependencies: src.all_dependencies() + common_deps +
+                    system_deps + user_deps)
     target_common_arch_libs += {target_base_arch: lib}
   endif
 
@@ -4157,7 +4165,7 @@ foreach target_base_arch, config_base_arch : config_base_arch_mak
       sources: src.all_sources() + genh,
       include_directories: inc,
       c_args: target_system_c_args,
-      dependencies: src.all_dependencies() + common_deps)
+      dependencies: src.all_dependencies() + common_deps + system_deps)
     target_common_system_arch_libs += {target_base_arch: lib}
   endif
 endforeach
@@ -4336,12 +4344,12 @@ foreach target : target_dirs
     arch_deps += src.dependencies()
   endif
   if target_type == 'system'
-    src = libsystem_ss.apply(config_target, strict: false)
+    src = system_ss.apply(config_target, strict: false)
     objects += libsystem.extract_objects(src.sources())
     arch_deps += src.dependencies()
   endif
   if target_type == 'user'
-    src = libuser_ss.apply(config_target, strict: false)
+    src = user_ss.apply(config_target, strict: false)
     objects += libuser.extract_objects(src.sources())
     arch_deps += src.dependencies()
   endif
-- 
2.49.0


