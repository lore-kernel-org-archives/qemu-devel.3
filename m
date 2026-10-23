Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAA2606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 18:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=BfydVS4r
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKJeL-0006fC-P4; Fri, 23 Oct 2026 14:05:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xKJeF-0006aK-Ts
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 14:05:48 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xKJeD-0004WZ-1A
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 14:05:47 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a1dede3c2cso13453725e9.2
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 11:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792778743; x=1793383543; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zO/QvGlb4mMzF7FTz1lc+Wyn9pl4Kh4AW7io/4UesVQ=;
 b=BfydVS4rZ6WrFNRMZIOTtUFKIIOAa3yiZdzrTpztBpDI6bNyv9ce1p53DNqeRajlZj
 Bb0KhAjyhWQep5lLVfpMBVWyXGcwT3fmJfZLs60UgVpC/XbthgbXMF7uNgcsEBrx0gTm
 rz7VY7ZlPO3joBr5MtP6S/s8vAlbQE4k+NrgmTLxnakLNX293w4t9zD3f9pb07v6iAAR
 vbpxeYWb9m7bGdvf3LQptI4380Y3TkICnDbYUw6jLFvnSKi8TeTWNLQF8mezoGRlza/O
 fp5jSowOy/RTrNGSyzkIb1Q0fk27idwo9T4endEDeCWazFHRljXLbRxTbf6XshLZgME3
 tveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792778743; x=1793383543;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zO/QvGlb4mMzF7FTz1lc+Wyn9pl4Kh4AW7io/4UesVQ=;
 b=qt4W3lDfOW0DU4UDu0pgn6vsUDZ9vfaxndEhClJRc7lhbxDRa7Y0Jf9obW0MAKsIWp
 7FKgk5wsC4rORymxpC/ueSyJJy6gOoqkWTFmedywVbxdczODw9yufTsBHPy/+58aMR1p
 p/qgHSeUG5cuI2fzRpJ1y8gYv58OdQ22bMunlCXI3+pFIsTD7dURs6eRcGTtLTqbhfPm
 XwuQUlQiznOJiS8xFid6HI5aOJcYuzVRNzQOPEMCyPBzttvQ+t0IyjDn7SGtAlCnLMab
 vGRFNKTMKwmkxMfOb62FqCZUefsmamc6mIfiO+yKFT/uRb39oi3yHRFNOTtoZJVPcvky
 I9lA==
X-Gm-Message-State: AFq9FYLT9Jsuz0paCDpKl5+wajrhoqYaMWMkyCsiz47u4f51ZP+r/O7S
 AhXH3SQWFS7vjF5AAU5FXEBsmdKRqHIRdQL90JTmI3BySrc0UTaXDeKC44tvd0rU9fs=
X-Gm-Gg: AYBFou3ekWYtxkyw8ZU+xeiv8iVq4nqte+qVl9cQ5HYbPTHQUDrD99Wj+kwAS5miql3
 LvH1zdDNt1M+e0zRuT7liIZhb7bTh5c3CFcSDexoYHes4yY1hg6wkjjz1BBf2vt4D7PUU3DIy1C
 MVU9GxWUKdzqlY+kyxljc2AH0WlHHvu8bWhiEVLDM1E1OO81Rl1dG5wTR6oKVd2EYZvnih7wVOu
 /OHE/ytv4m5MSjHQQvo12SK8HthCj5/jPKSa7lmCG/IMfjw3Y1p//0ln0yiuhh8gMVcK2TnAHq/
 EPz68xgY14o2A8ARvnssDNOBOvx9+YZyKLGQaJX78gJazaKXmE0w6kZFyeGnxcHNkLHWmFzcqMN
 lnkLqeLT2aO5FNXLs/sL9NZJwwpt4paZzErFE6VjA+IZeV62hgwy8BEWHI8NF9dTcum1idn7B39
 kZjRJ9y6aNtUP+AGSek2oQGdmeefaF/uIA6IxHGl6AfU7SgoZffZL8NZk5CHXJsYlX4n5i9T1Mx
 XeRi17+k8R1WQLc8+y73DRIoZdHArSCJiVV3HJmh3XcXqLbuRNn+f8=
X-Received: by 2002:a05:600d:82c7:b0:4a1:fe55:88ef with SMTP id
 5b1f17b1804b1-4a211ee56ecmr56940995e9.20.1792778743543; 
 Fri, 23 Oct 2026 11:05:43 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a359fc1207sm49825e9.1.2026.10.23.11.05.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 11:05:41 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C51D060A1F;
 Fri, 23 Oct 2026 19:05:39 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 04/19] meson: move gdb detection into the top level build file
Date: Fri, 23 Oct 2026 19:05:22 +0100
Message-ID: <20261023180539.1574134-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261023180539.1574134-1-alex.bennee@linaro.org>
References: <20261023180539.1574134-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently gdb is only used by TCG based tests but hypervisors want to
use gdbstub too. To be able to test this case we need to always probe
and report the gdb we have.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20261019192704.3220373-5-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/meson.build b/meson.build
index bbef9d9c293..4f29bc6cc33 100644
--- a/meson.build
+++ b/meson.build
@@ -163,6 +163,12 @@ else
   iasl = find_program(get_option('iasl'), required: true)
 endif
 
+if get_option('gdb') == ''
+  gdb = find_program(['gdb-multiarch', 'gdb'], required: false)
+else
+  gdb = find_program(get_option('gdb'), required: true)
+endif
+
 edk2_targets = [ 'arm-softmmu', 'aarch64-softmmu', 'i386-softmmu', 'x86_64-softmmu', 'riscv64-softmmu', 'loongarch64-softmmu' ]
 unpack_edk2_blobs = false
 foreach target : edk2_targets
@@ -4710,14 +4716,7 @@ summary(summary_info, bool_yn: true, section: 'Directories')
 summary_info = {}
 summary_info += {'python':            '@0@ (version: @1@)'.format(python.full_path(), python.language_version())}
 summary_info += {'sphinx-build':      sphinx_build}
-
-# FIXME: the [binaries] section of machine files, which can be probed
-# with find_program(), would be great for passing gdb and genisoimage
-# paths from configure to Meson.  However, there seems to be no way to
-# hide a program (for example if gdb is too old).
-if config_host.has_key('GDB')
-  summary_info += {'gdb':             config_host['GDB']}
-endif
+summary_info += {'gdb':               gdb}
 summary_info += {'iasl':              iasl}
 summary_info += {'genisoimage':       config_host['GENISOIMAGE']}
 if host_os == 'windows' and have_ga
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index c7362dd00ef..68c601d4036 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -83,9 +83,8 @@ foreach speed : ['quick', 'thorough']
                      separator : ':')
 
     # Define the GDB environment variable if gdb is available.
-    gdb = get_option('gdb')
-    if gdb != ''
-      test_env.set('QEMU_TEST_GDB', gdb)
+    if gdb.found()
+      test_env.set('QEMU_TEST_GDB', gdb.full_path())
     endif
 
     foreach test : target_tests
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 1cd2d421cea..06f013fbe3d 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -1,11 +1,6 @@
 env = find_program('env')
 
 docker_wrapper = find_program('../docker/docker.py')
-if get_option('gdb') != ''
-  gdb = find_program(get_option('gdb'), required: true)
-else
-  gdb = find_program(['gdb-multiarch', 'gdb'], required: false)
-endif
 prog_check_plugin_output = find_program('./scripts/check_plugin_output.sh')
 prog_gdb_test = find_program('../guest-debug/run-test.py')
 prog_record_replay = find_program('./scripts/record_replay.sh')
-- 
2.47.3


