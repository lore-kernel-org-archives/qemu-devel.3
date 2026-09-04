Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A096C61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:54:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TQB-0001ZS-2X; Fri, 04 Sep 2026 08:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TQ8-0001Xv-Ph
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:53:28 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TQ6-0000eG-Qn
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:53:28 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-485843aeab8so1029706f8f.1
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 05:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788526405; x=1789131205; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=F0/wxzAZP3kHp8qnztiYWhe/t57dvgEiELFRAI7X1zY=;
 b=PJo6LEN0tqkDnywuZD6mvYbj92dN7ulpcisXd8IkbENbRX7qRUepQG2O+YlxNxHffl
 Ta8LcZP1YYKmVbC0YwbkZWFK+1u5s1/i1suUkAv1JDPtKzeGxo7a5FAOh92ebowqU7H/
 WUShTY32gTERGYHxsDxwPW3L7r+6qFBnqKTZqiKERWu4qPMNlUsEP9Lewvc3aedCa1eV
 vQu1DzBbi8Sd+Pa0+9a/q+/nxJT8EvR/JKih5a/tI2wGXfNmXXKZf0asVZHMLmChC1rA
 JMHMjqjIUAX8fmduy1foQ1roNbvEaf8G3bl9eb0vmRdPjuuJDbDEPYMN3oe8pOngDthM
 qFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788526405; x=1789131205;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=F0/wxzAZP3kHp8qnztiYWhe/t57dvgEiELFRAI7X1zY=;
 b=qc+xQtDaDvXuTBYlJH3c7S2BkitX4xRO5J+9RJP3CnsTV9dwnvTE+eiwzSN3R7L9ky
 fnaqCdLqe/Tv/x+0pXIskOFGhqXEVe59alBmlb/7RQxdlUes4U3WTk2H09UL82bUhxes
 ewaBEriAz/yEQHTAYd9ypvdyuyCXBpHi1cUNeDjOrMUZ4TVsShX0bTk8qYQbGlC2z8JD
 fu9t8Fi+FlCRfVbJje00Jh4c/aTq36gHYtvLswspCPqNXfmuwhuHLsfLBcZWZ+4qc+ht
 OOAbBZM9VavXwpkXhj6qRfT+g2DWRJGqmZrAyxW/sFLpzae4xp5a9F5/sc8+yUgdRH8O
 KTgA==
X-Gm-Message-State: AFuF++nP7eDFxQqCZm0rKIgWue0awj1ZTmOkGMZenVo3+e35qS8xO5cI
 4EVdp80S4tanpQQOZBVU7oJnnSzz2l2+gKyR4TKSmypBRYof6DS701yDlAyNj/uouqc=
X-Gm-Gg: AYBFou0eOTeujOdp0DjeGaGKYCxwrf4EdldwxjzfdKriOOISh1k5emIaAjZ0Seevx3s
 Gi7SHQrATIlIv3npuOtlEGor7FvvejQyrMYHudrcmf46nrgm7P5TnagpyUIDoD8ylIJKbyQ8x0Q
 4tc7nCenm9hkmqoTzt3W5LsxhDD6BSJ0zFuQ9rS/blna1WfBklnoFjlgUcbZa5TLoZ0dCs5lQ5N
 CVw/7O5Q2gDngFVJFdFtO4+ND+RCDPCeKYde77rmy+lw5d39TfMaPQMLale3y/VHlP+3bge3MrR
 ndi7VIkasV3occdwYtFF8pzuU7t+em51e6hLDYEtbh4PBWpm5VZ8KYRpHRIu7wOqxq6gYqZcMZt
 NJCMXnCTBMZYBn8P75YPjJuZJlkyacxvWSl+oq+4YW1tmID1eBxyzERv5h2EimHzVKz4BVG0hZN
 YvBDmu29+QfaGo50BJKDk+vSHoi0dxgR+BlztfaevHERzw20W7ltWKI/dqrkWRszs1PlSVIAA=
X-Received: by 2002:a05:6000:4b11:b0:485:8313:9f47 with SMTP id
 ffacd0b85a97d-48587055d09mr12830712f8f.10.1788526405062; 
 Fri, 04 Sep 2026 05:53:25 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883a9a56sm5209387f8f.15.2026.09.04.05.53.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:53:23 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 582D061E33;
 Fri, 04 Sep 2026 13:46:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 103/105] meson.build: add summary for TCG tests
Date: Fri,  4 Sep 2026 13:45:57 +0100
Message-ID: <20260904124604.2207440-104-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Replacing existing summary that only contained information about
existing cross compilers with a full summary for all targets.
We add gdb and container information.
We specify cc for each target (softmmu + linux-user) independently
in case we would use different cc for bare metal vs user binaries.

Users can query full command line for tests by building tests with
tcg-tests target, so no need to repeat it here.

Output before change:

$ ./configure
  Cross compilers
    aarch64                         : /path/to/qemu/build/pyvenv/bin/python3 -B /path/to/qemu/tests/docker/docker.py --engine auto cc --cc aarch64-linux-gnu-gcc -i qemu/debian-arm64-cross -s /path/to/qemu --
    aarch64_be                      : /path/to/qemu/build/pyvenv/bin/python3 -B /path/to/qemu/tests/docker/docker.py --engine auto cc --cc aarch64-linux-gnu-gcc -i qemu/debian-all-test-cross -s /path/to/qemu --
    alpha                           : alpha-linux-gnu-gcc
    ...

Output after change:

$ ./configure --disable-containers
  TCG tests
    gdb                             : /usr/bin/gdb-multiarch
    container command               : NO
    cc for aarch64-softmmu          : NO
    cc for aarch64-linux-user       : NO
    cc for aarch64_be-linux-user    : NO
    cc for alpha-softmmu            : alpha-linux-gnu-gcc

$ ./configure --gdb=gdb --container-command=podman
  TCG tests
    gdb                             : /usr/bin/gdb
    container command               : podman
    cc for aarch64-softmmu          : aarch64-linux-gnu-gcc (from 'debian-all-test-cross' container)
    cc for aarch64-linux-user       : aarch64-linux-gnu-gcc (from 'debian-all-test-cross' container)
    cc for aarch64_be-linux-user    : aarch64-linux-gnu-gcc (from 'debian-all-test-cross' container)
    cc for alpha-softmmu            : alpha-linux-gnu-gcc
    ...

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-104-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/meson.build b/meson.build
index 0a64bcfc6e9..2a022c4d85d 100644
--- a/meson.build
+++ b/meson.build
@@ -4610,6 +4610,7 @@ subdir('docs')
 subdir('pyvenv')
 # Tests are disabled on emscripten because they rely on host features that aren't
 # supported by emscripten (e.g. fork and unix socket).
+tcg_tests_summary = {}
 if host_os != 'emscripten'
   subdir('tests')
 endif
@@ -4797,21 +4798,9 @@ summary_info += {'sparse':            sparse}
 summary_info += {'mingw32 support':   host_os == 'windows'}
 summary(summary_info, bool_yn: true, section: 'Compilation')
 
-# snarf the cross-compilation information for tests
-summary_info = {}
-have_cross = false
-foreach target: target_dirs
-  tcg_mak = meson.current_build_dir() / 'tests/tcg' / target / 'config-target.mak'
-  if fs.exists(tcg_mak)
-    config_cross_tcg = keyval.load(tcg_mak)
-    if 'CC' in config_cross_tcg
-      summary_info += {config_cross_tcg['TARGET_NAME']: config_cross_tcg['CC']}
-      have_cross = true
-    endif
-  endif
-endforeach
-if have_cross
-  summary(summary_info, bool_yn: true, section: 'Cross compilers')
+# TCG tests configuration
+if tcg_tests_summary != {}
+  summary(tcg_tests_summary, bool_yn: true, section: 'TCG tests')
 endif
 
 # Targets and accelerators
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 9cf632d2717..243cdb5fc8c 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -77,25 +77,30 @@ if gdb.found()
     gdb_arch_supported += {arch: true}
   endforeach
 endif
+tcg_tests_summary += {'gdb': gdb}
 
 docker_supported = false
+container_command = false
 if get_option('containers')
   if get_option('container_command') != ''
     # make sure command is working
-    cmd = get_option('container_command').split()
+    container_command = get_option('container_command')
+    cmd = container_command.split()
     run_command([cmd, 'info'], check: true)
     docker_supported = true
     docker_wrapper = [docker_wrapper, '--command',
-                      get_option('container_command')]
+                      container_command]
   else
     docker_probe = run_command(docker_wrapper, 'probe', check: false)
     docker_supported = docker_probe.returncode() == 0
     if docker_supported
+      container_command = docker_probe.stdout().strip()
       docker_wrapper = [docker_wrapper, '--command',
-                        docker_probe.stdout().strip()]
+                        container_command]
     endif
   endif
 endif
+tcg_tests_summary += {'container command': container_command}
 
 # plugins come first, as we need to build the list
 test_plugins = {}
@@ -270,6 +275,15 @@ foreach target, plan: tcg_tests
     endif
   endif
 
+  summary_cc = false
+  if has_cc
+    summary_cc = plan['cc']
+    if not cc_from_system
+      summary_cc += ' (from \'' + plan['cc_dockerfile'] + '\' container)'
+    endif
+  endif
+  tcg_tests_summary += {'cc for ' + target: summary_cc}
+
   folder = plan['folder']
   gdb_arch = plan['gdb_arch']
   qemu = plan['qemu']
-- 
2.47.3


