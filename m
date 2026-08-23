Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 269A4C5DF97
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2026 15:11:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wy9pQ-0001L3-UN; Sun, 23 Aug 2026 11:09:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1wy9pP-0001Jo-1e
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 11:09:43 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1wy9pJ-0000XS-Ve
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 11:09:42 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-ca7c1176317so2191967a12.1
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 08:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787497776; x=1788102576; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2qJkFOwtR18gPKYVYlQn+zI+QIFrhM1zHQf4VsVINkE=;
 b=FzeCJLytqo2kjRVPmBe26Y3C+axTAvs0wDRFIc0YdIDpJmFtqu5RqGhXTJpaJ9oJzk
 pNyfB3vOOze2CyDSxj0kBH5zCkObpiIvaMkDlrVienxwe2WJafcjFC65dWW23LXAsi+u
 kgssTElpP2MMFyWIXP9fnPSg3p2eBI6oSo1uAzsAMaTVr6DmskS8MPwojOdhKkf5Jq0r
 fKb8pOR3fWXwpCJV+3g2NPtHS0undJqdpoTbEZ/lRZN4iBeUIv3T1n9KbbIGN3vIdmMD
 mRhBwDOrHqjDgahSXa/1Q4uz26Dbpw7f2WZ/Ee8b2jzDxqXB6qkgWd9aOizTqsE01vQH
 RTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787497776; x=1788102576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2qJkFOwtR18gPKYVYlQn+zI+QIFrhM1zHQf4VsVINkE=;
 b=dy7KFprQcmnjuJyBdkcdqD3sDxMbQCCIdFO5TSuWa9JEAluqDau3Wo0GZIuRqa5n2O
 lla/sf1i2nymGhT73wnlQGDEiBNfYufFjTA+jtq13NV1KvyCsqzfQZ1lZwd6AeOLiy+U
 8uUfGWbBF/SaOpzNOZrSjwjgA/BMMkNBReOkut/OC3N3/u413JS5fIvmtxAEK1gVpM6Y
 p0T7mD2Tig87zroYH1N2Z2xtXvB9i3XB8xFpxDYfw4I2TS23hnx85tDmRMQj2fGKnOls
 JARywFAuRU7m12zZDCR7yVYrnEoS2YfwcgKcF8QYOcEPiAwSu2A9Phy+Quxq+IwkKLcL
 v8bw==
X-Gm-Message-State: AFuF++ky4yy/PUAJk1KunxweGSYeIvAmsX3PByDdT2K09fbmu7HDGoQr
 B1GCqv1P9BklbUCsdsRFB3niV3A0oH1SOgvxp3y5vHQRhtmrPi9N51x8ihsDW9P69ZQ=
X-Gm-Gg: AR+sD12qKk10idkG+YvzEMb/OKIozngKcgMfMZ6u0fcA7Z8EYht/Id6gjdHuY7IemSQ
 cQzZMEqv1bHeorBUbn4NHjfYoGqXAQMVR+c/U7HyQNrO/cVhYWDM7QX6ZKwDX6S/slVJVawKnHy
 +CDn3DwRbzJi15CLsVkeaF0XC5UbckZWaHAT+atzHFvVuLr70x1JY9vNHU7p4jUgTiE6zAKLM7o
 UVRAX2E9YQkIxsCsIKK/spyIW9kDUTdCLz+xa0OX6k+ki43+3Eg4AxkHj52gc7d5rLSGesvCKmY
 3NNyf0JGkpYoFRDUiNGAdzXvUKly33C1FDdujXSLq2QUL24HksuvsU8XW7Cj7G4fAGcjhq8J084
 G0cC61by3vVWsF0na5JmlgTgbe/xWgaQtqIkeZfmG3hg3p+g8da0+I4V3+Bc/rIPzcNOqOTang4
 W/q78OQAcHArEEjBrnyfc/ioTuQTzOvFy5IBU3mrBImJLrvEmoqQu39c1HvKlTBXJ1KgM1iM9Gv
 7wTIxQq4Vizph+GEzjr3g==
X-Received: by 2002:a17:90b:280a:b0:38e:bfe:81e9 with SMTP id
 98e67ed59e1d1-395dee56103mr24094070a91.1.1787497775653; 
 Sun, 23 Aug 2026 08:09:35 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1418619d6ecsm16024511c88.14.2026.08.23.08.09.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 08:09:34 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Xianglai Li <lixianglai@loongson.cn>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Sunil V L <sunilvl@ventanamicro.com>,
 qemu-riscv@nongnu.org, Alexander Bulekov <alxndr@bu.edu>,
 Zhao Liu <zhao1.liu@intel.com>, Eric Farman <farman@linux.ibm.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chao Liu <chao.liu@processmission.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Song Gao <17746591750@163.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-s390x@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Hildenbrand <david@kernel.org>, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Aurelien Jarno <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Weiwei Li <liwei1518@gmail.com>,
 Darren Kenny <darren.kenny@oracle.com>
Subject: [PATCH 12/12] meson: link ARM and RISC-V into qemu-system
Date: Sun, 23 Aug 2026 23:07:30 +0800
Message-ID: <20260823150731.896-13-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260823150731.896-1-luoyonggang@gmail.com>
References: <20260823150731.896-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

- Build qemu-system (and qemu-systemw on Windows) from aarch64
  common/system objects plus RISC-V arch objects taken from the
  existing riscv64 lib.
- Pull 32-bit TargetInfo and 32-only boards from the arm/riscv32
  libs so hw/arm and target/riscv are not compiled twice.
- Skip linking qemu-system-{arm,aarch64,riscv32,riscv64} and the
  Windows *w variants; symlink those names to qemu-system so
  argv[0] still selects TargetInfo.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 meson.build | 156 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 147 insertions(+), 9 deletions(-)

diff --git a/meson.build b/meson.build
index 449d50f2983..b4f435f6a22 100644
--- a/meson.build
+++ b/meson.build
@@ -4250,6 +4250,10 @@ endif
 
 traceable = []
 emulators = {}
+target_softmmu = {}
+combo_softmmu = ['aarch64-softmmu', 'arm-softmmu', 'riscv32-softmmu', 'riscv64-softmmu']
+have_qemu_system_combo = ('aarch64-softmmu' in target_dirs
+                          and 'riscv64-softmmu' in target_dirs)
 foreach target : target_dirs
   config_target = config_target_mak[target]
   target_name = config_target['TARGET_NAME']
@@ -4399,20 +4403,37 @@ foreach target : target_dirs
                  c_args: c_args,
                  build_by_default: false)
 
+  if target in combo_softmmu
+    target_softmmu += {target: {
+      'lib': lib,
+      'arch_srcs': arch_srcs,
+      'arch_deps': arch_deps,
+      'c_args': c_args,
+      'link_args': link_args,
+      'target_stubs': target_stubs,
+      'main_rs': main_rs,
+      'config_target': config_target,
+      'target_base_arch': target_base_arch,
+    }}
+  endif
+
   if target.endswith('-softmmu')
-    execs = [{
-      'name': 'qemu-system-' + target_name,
-      'win_subsystem': 'console',
-      'sources': [main_rs, files('system/main.c')],
-      'dependencies': [sdl, target_stubs],
-    }]
-    if host_os == 'windows' and (sdl.found() or gtk.found())
+    execs = []
+    if not (have_qemu_system_combo and target in combo_softmmu)
       execs += [{
-        'name': 'qemu-system-' + target_name + 'w',
-        'win_subsystem': 'windows',
+        'name': 'qemu-system-' + target_name,
+        'win_subsystem': 'console',
         'sources': [main_rs, files('system/main.c')],
         'dependencies': [sdl, target_stubs],
       }]
+      if host_os == 'windows' and (sdl.found() or gtk.found())
+        execs += [{
+          'name': 'qemu-system-' + target_name + 'w',
+          'win_subsystem': 'windows',
+          'sources': [main_rs, files('system/main.c')],
+          'dependencies': [sdl, target_stubs],
+        }]
+      endif
     endif
     if get_option('fuzzing')
       specific_fuzz = specific_fuzz_ss.apply(config_target, strict: false)
@@ -4481,6 +4502,123 @@ foreach target : target_dirs
   endforeach
 endforeach
 
+# Combined ARM + RISC-V system emulator (32 and 64).
+# Common/system objects come from aarch64. RISC-V arch objects come
+# from the existing riscv64 lib. 32-bit TargetInfo and 32-only boards
+# come from the arm/riscv32 libs. Per-target qemu-system-* names are
+# symlinks to qemu-system (argv[0] selects TargetInfo).
+if have_qemu_system_combo
+  a64 = target_softmmu['aarch64-softmmu']
+  rv = target_softmmu['riscv64-softmmu']
+  extra_objs = []
+  target_info_def = files('target-info-def.c')
+  foreach spec : [[common_ss, common_all], [system_ss, libsystem]]
+    rv_src = spec[0].apply(rv['config_target'], strict: false)
+    a64_src = spec[0].apply(a64['config_target'], strict: false)
+    extra = []
+    foreach f : rv_src.sources()
+      if f not in a64_src.sources() and not f.full_path().endswith('_stubs.c')
+        extra += f
+      endif
+    endforeach
+    if extra.length() > 0
+      extra_objs += spec[1].extract_objects(extra)
+    endif
+  endforeach
+  rv_base = rv['target_base_arch']
+  if rv_base in target_common_arch_libs
+    src = target_common_arch[rv_base].apply(rv['config_target'], strict: false)
+    extra_objs += target_common_arch_libs[rv_base].extract_objects(src.sources())
+  endif
+  if rv_base in target_common_system_arch_libs
+    src = target_common_system_arch[rv_base].apply(rv['config_target'], strict: false)
+    extra_objs += target_common_system_arch_libs[rv_base].extract_objects(src.sources())
+  endif
+  foreach pair : [['arm-softmmu', 'aarch64-softmmu'], ['riscv32-softmmu', 'riscv64-softmmu']]
+    t32 = pair[0]
+    t64 = pair[1]
+    if t32 in target_softmmu
+      extra_objs += target_softmmu[t32]['lib'].extract_objects(target_info_def)
+      base32 = target_softmmu[t32]['target_base_arch']
+      if base32 in hw_arch
+        hw32 = hw_arch[base32].apply(target_softmmu[t32]['config_target'], strict: false)
+        hw64 = hw_arch[base32].apply(target_softmmu[t64]['config_target'], strict: false)
+        extra_hw = []
+        foreach f : hw32.sources()
+          if f not in hw64.sources()
+            extra_hw += f
+          endif
+        endforeach
+        if extra_hw.length() > 0
+          extra_objs += target_softmmu[t32]['lib'].extract_objects(extra_hw)
+        endif
+      endif
+    endif
+  endforeach
+  combo_objects = extra_objs
+  combo_objects += a64['lib'].extract_all_objects(recursive: true)
+  combo_objects += rv['lib'].extract_objects(rv['arch_srcs'])
+  combo_deps = a64['arch_deps'] + rv['arch_deps'] + [sdl, a64['target_stubs'], rv['target_stubs']]
+  if 'arm-softmmu' in target_softmmu
+    combo_deps += target_softmmu['arm-softmmu']['arch_deps']
+  endif
+  if 'riscv32-softmmu' in target_softmmu
+    combo_deps += target_softmmu['riscv32-softmmu']['arch_deps']
+  endif
+  combo_execs = [{
+    'name': 'qemu-system',
+    'win_subsystem': 'console',
+  }]
+  if host_os == 'windows' and (sdl.found() or gtk.found())
+    combo_execs += [{
+      'name': 'qemu-systemw',
+      'win_subsystem': 'windows',
+    }]
+  endif
+  combo_exe_suffix = host_os == 'windows' ? '.exe' : ''
+  combo_alias_py = 'import os, sys; src, dst = sys.argv[1:3]; os.path.exists(dst) and os.remove(dst); os.symlink(os.path.basename(src), dst)'
+  foreach exe : combo_execs
+    emulator = executable(exe['name'], [a64['main_rs'], files('system/main.c')],
+               install: true,
+               c_args: a64['c_args'],
+               dependencies: combo_deps,
+               objects: combo_objects,
+               link_depends: [block_syms, qemu_syms],
+               link_args: a64['link_args'],
+               win_subsystem: exe['win_subsystem'])
+    emulators += {exe['name']: emulator}
+    traceable += [{
+      'exe': exe['name'],
+      'probe-prefix': 'qemu.system.multi',
+    }]
+    foreach t : combo_softmmu
+      if t not in target_softmmu
+        continue
+      endif
+      tname = target_softmmu[t]['config_target']['TARGET_NAME']
+      if exe['name'] == 'qemu-systemw'
+        alias = 'qemu-system-' + tname + 'w'
+      else
+        alias = 'qemu-system-' + tname
+      endif
+      alias_tgt = custom_target(alias,
+                                input: emulator,
+                                output: alias + combo_exe_suffix,
+                                command: [python, '-c', combo_alias_py, '@INPUT@', '@OUTPUT@'],
+                                build_by_default: true,
+                                install: false)
+      emulators += {alias: alias_tgt}
+      install_symlink(alias + combo_exe_suffix,
+                      pointing_to: exe['name'] + combo_exe_suffix,
+                      install_dir: get_option('bindir'))
+      traceable += [{
+        'exe': alias,
+        'probe-prefix': 'qemu.system.' + tname,
+      }]
+    endforeach
+  endforeach
+endif
+
 # Other build targets
 
 if get_option('plugins')
-- 
2.52.0.windows.1


