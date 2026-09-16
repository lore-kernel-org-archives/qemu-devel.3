Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9745EC982C1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 08:56:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6lOv-0007qm-BJ; Wed, 16 Sep 2026 04:53:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6lOt-0007pr-Nq
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 04:53:55 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6lOr-00050v-8l
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 04:53:55 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49cd38e0e5dso7766755e9.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 01:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789548832; x=1790153632; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7O9UJOMF0J+VNfP7rnUceN1KGDlS3Etlt1DaVQnlEaY=;
 b=W2f4/dvEGW+lS5HRfvJ0g1phYWfPLp9tNWCQwDH7p/VmQIR9+AoQfYCLy0XbOze9rx
 XwP2imp30mwhnB24GRQQCB0rB0/o3Nhhbyi32KLLBVSJFIc5gnCztfQlZ5WTdklq2ei6
 /97gC07gWDKui54D3IXHllXIob6Xb5n+feQKGzJNQSqQfBClHzkAAD7sAW1CRMUEYLio
 f3PldHifP2e3ybOZh4DDzzf2ykHo1jx7x+VDOTWe8HOuU4rxUOt7cB0Hc8f2svmG8Dzf
 +Q/iOEjYXi92hcwpE4rJ0mIY0+yYzSen2n0Qzp+/QqgIZyT7ccpirDeNerib8SWJ1VlW
 vonQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789548832; x=1790153632;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7O9UJOMF0J+VNfP7rnUceN1KGDlS3Etlt1DaVQnlEaY=;
 b=q7Knt9bf5HJcX0+7RaTa09y7m6DCuOdd970LZqcO/yYc99FMiS0oFEQpEpJseDUDtg
 /OiQ0vSvKc0V25tBol7mFQnBqMyaHO0LFXEnJi9Y+zXIhudu+KACCiAKwkU1mmN3OWPN
 CPWc/D9t79vmBGcTHqq2b1tKQp5WU7DiWwzZ46ROXyBggQnDE7m9+p44brp5t0WBG16L
 HiyxFC7nUgrtKBAFQwcYSFe/jy9hk9uCxfr7iVDENirLbhqaSMyxlj+U/vjlPMuX4/E+
 IJ14JTEf4DtRinjvEmemWr7KqX+/qXuM3C7B4L9nPJC17x4sVFJUuO0lPV8vlTk+f2nL
 ZTKA==
X-Gm-Message-State: AFuF++l1PX+4c2y9KlrSh6qFQdv9vWG80mmhLltB58lITY/vrrCxzUYf
 XbMM00vDa70zTX9nm3oa5eeL3g3dfJqDw3S288Gj2qBMG6YS8vagVlCdtJ+ltJggnS8=
X-Gm-Gg: AYBFou1LYVrk12HjG7gfkSPe5YYh5Pnki8W3tF8PEgpbsbubtdgeIAKjRLVVyntXiow
 WAzZdcxhMImAJwe7sLOolCn/i9AHuV+9NOyZMKdND7O5kBIxvWU3caC4LJk0OUazIlLA3Nd0YZm
 QcJebXFgh1vEg70Nm7wjRIXwft/oQQdy0OiNPxOO6jh4XoisPTY55beaWUbugckTmurzxHPfy0Y
 KjD90D0aj3l3yyAmD0GBBdmQPXqmsMPZEnGN3zO+7AiWO500vb1VNmmGVZsThGulGt6YLEUF8gz
 /28dqcmQC2C2LlI8+pRe/gv1B8CnjZE+Fn/GA1JanYi/WWkqG7z4lh6eSXZey0ht0z2ABK9N6s7
 dNoJyxehPfqTk3fiG1h+NCcKTjHlIZp2EGOIYRkNqa6stRdm9iI4cp/4Se9AyzJBLhGRfcLE4r8
 DMQEjqL+51WzZ/JqKOlu4mgQDy3XQZ/V1DbB3yL+wmu2yYLXgi70CaPpO+iIAbd2Xb3iTdlU4=
X-Received: by 2002:a05:600c:6592:b0:49d:1cc7:5ec3 with SMTP id
 5b1f17b1804b1-49eb7326586mr39359295e9.9.1789548831681; 
 Wed, 16 Sep 2026 01:53:51 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e83da071asm76138895e9.8.2026.09.16.01.53.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 01:53:48 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9BCA361901;
 Wed, 16 Sep 2026 09:53:42 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brad Smith <brad@comstyle.com>, qemu-arm@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Warner Losh <imp@bsdimp.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <gaosong@loongson.cn>,
 Kyle Evans <kevans@freebsd.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 11/17] tests/docker: strip remaining caching logic from
 docker.py
Date: Wed, 16 Sep 2026 09:53:34 +0100
Message-ID: <20260916085341.1692742-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260916085341.1692742-1-alex.bennee@linaro.org>
References: <20260916085341.1692742-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x10.google.com
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

The caching logic was a remnant of an older time when we had multiple
shared layers building that went into the final image. It was arguable
that it worked back then but it is definitely not needed now so into
the bin it goes.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/docker.py | 148 ++++++++++++++---------------------------
 1 file changed, 49 insertions(+), 99 deletions(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index fd0cbdfe856..a2e97061240 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -15,7 +15,6 @@
 import sys
 import subprocess
 import json
-import hashlib
 import atexit
 import uuid
 import argparse
@@ -27,7 +26,6 @@
 from tarfile import TarFile, TarInfo
 from io import StringIO, BytesIO
 from shutil import copy, rmtree
-from datetime import datetime, timedelta
 
 
 FILTERED_ENV_NAMES = ['ftp_proxy', 'http_proxy', 'https_proxy']
@@ -35,20 +33,9 @@
 
 DEVNULL = open(os.devnull, 'wb')
 
-def _bytes_checksum(bytes):
-    """Calculate a digest string unique to the text content"""
-    return hashlib.sha1(bytes).hexdigest()
-
-def _text_checksum(text):
-    """Calculate a digest string unique to the text content"""
-    return _bytes_checksum(text.encode('utf-8'))
-
 def _read_dockerfile(path):
     return open(path, 'rt', encoding='utf-8').read()
 
-def _file_checksum(filename):
-    return _bytes_checksum(open(filename, 'rb').read())
-
 
 def _guess_engine_command():
     """ Guess a working engine command or raise exception if not found"""
@@ -263,38 +250,15 @@ def inspect_tag(self, tag):
         except subprocess.CalledProcessError:
             return None
 
-    def get_image_creation_time(self, info):
-        return json.loads(info)[0]["Created"]
-
-    def get_image_dockerfile_checksum(self, tag):
-        resp = self.inspect_tag(tag)
-        labels = json.loads(resp)[0]["Config"].get("Labels", {})
-        return labels.get("com.qemu.dockerfile-checksum", "")
-
-    def build_image(self, tag, docker_dir, dockerfile,
-                    quiet=True, user=False, argv=None, registry=None,
-                    extra_files_cksum=[]):
+    def build_image(self, tag, docker_dir, dockerfile_path,
+                    quiet=True, user=False, argv=None, registry=None):
         if argv is None:
             argv = []
 
-        if not _dockerfile_verify_flat(dockerfile):
+        if not _dockerfile_verify_flat(_read_dockerfile(dockerfile_path)):
             return -1
 
-        checksum = _text_checksum(dockerfile)
-
-        tmp_df = tempfile.NamedTemporaryFile(mode="w+t",
-                                             encoding='utf-8',
-                                             dir=docker_dir, suffix=".docker")
-        tmp_df.write(dockerfile)
-
-        tmp_df.write("\n")
-        tmp_df.write("LABEL com.qemu.dockerfile-checksum=%s\n" % (checksum))
-        for f, c in extra_files_cksum:
-            tmp_df.write("LABEL com.qemu.%s-checksum=%s\n" % (f, c))
-
-        tmp_df.flush()
-
-        build_args = ["build", "-t", tag, "-f", tmp_df.name]
+        build_args = ["build", "-t", tag, "-f", dockerfile_path]
         if self._buildkit:
             build_args += ["--build-arg", "BUILDKIT_INLINE_CACHE=1"]
 
@@ -320,13 +284,6 @@ def update_image(self, tag, tarball, quiet=True):
 
         self._do_check(["build", "-t", tag, "-"], quiet=quiet, stdin=tarball)
 
-    def image_matches_dockerfile(self, tag, dockerfile):
-        try:
-            checksum = self.get_image_dockerfile_checksum(tag)
-        except Exception:
-            return False
-        return checksum == _text_checksum(dockerfile)
-
     def run(self, cmd, keep, quiet, as_user=False):
         label = uuid.uuid4().hex
         if not keep:
@@ -412,61 +369,54 @@ def args(self, parser):
                             help="Dockerfile name")
 
     def run(self, args, argv):
-        dockerfile = _read_dockerfile(args.dockerfile)
         tag = args.tag
 
         dkr = Docker(args.command)
-        if "--no-cache" not in argv and \
-           dkr.image_matches_dockerfile(tag, dockerfile):
-            pass
-        else:
-            # Create a docker context directory for the build
-            docker_dir = tempfile.mkdtemp(prefix="docker_build")
-
-            # Validate binfmt_misc will work
-            if args.skip_binfmt:
-                qpath = args.include_executable
-            elif args.include_executable:
-                qpath, enabled = _check_binfmt_misc(args.include_executable)
-                if not enabled:
-                    return 1
-
-            # Is there a .pre file to run in the build context?
-            docker_pre = os.path.splitext(args.dockerfile)[0]+".pre"
-            if os.path.exists(docker_pre):
-                stdout = DEVNULL if args.quiet else None
-                rc = subprocess.call(os.path.realpath(docker_pre),
-                                     cwd=docker_dir, stdout=stdout)
-                if rc == 3:
-                    print("Skip")
-                    return 0
-                elif rc != 0:
-                    print("%s exited with code %d" % (docker_pre, rc))
-                    return 1
-
-            # Copy any extra files into the Docker context. These can be
-            # included by the use of the ADD directive in the Dockerfile.
-            cksum = []
-            if args.include_executable:
-                # FIXME: there is no checksum of this executable and the linked
-                # libraries, once the image built any change of this executable
-                # or any library won't trigger another build.
-                _copy_binary_with_libs(args.include_executable,
-                                       qpath, docker_dir)
-
-            for filename in args.extra_files or []:
-                _copy_with_mkdir(filename, docker_dir)
-                cksum += [(filename, _file_checksum(filename))]
-
-            argv += ["--build-arg=" + k.lower() + "=" + v
-                     for k, v in os.environ.items()
-                     if k.lower() in FILTERED_ENV_NAMES]
-            dkr.build_image(tag, docker_dir, dockerfile,
-                            quiet=args.quiet, user=args.user,
-                            argv=argv, registry=args.registry,
-                            extra_files_cksum=cksum)
-
-            rmtree(docker_dir)
+
+        # Create a docker context directory for the build
+        docker_dir = tempfile.mkdtemp(prefix="docker_build")
+
+        # Validate binfmt_misc will work
+        if args.skip_binfmt:
+            qpath = args.include_executable
+        elif args.include_executable:
+            qpath, enabled = _check_binfmt_misc(args.include_executable)
+            if not enabled:
+                return 1
+
+        # Is there a .pre file to run in the build context?
+        docker_pre = os.path.splitext(args.dockerfile)[0]+".pre"
+        if os.path.exists(docker_pre):
+            stdout = DEVNULL if args.quiet else None
+            rc = subprocess.call(os.path.realpath(docker_pre),
+                                 cwd=docker_dir, stdout=stdout)
+            if rc == 3:
+                print("Skip")
+                return 0
+            elif rc != 0:
+                print("%s exited with code %d" % (docker_pre, rc))
+                return 1
+
+        # Copy any extra files into the Docker context. These can be
+        # included by the use of the ADD directive in the Dockerfile.
+        if args.include_executable:
+            # FIXME: there is no checksum of this executable and the linked
+            # libraries, once the image built any change of this executable
+            # or any library won't trigger another build.
+            _copy_binary_with_libs(args.include_executable,
+                                   qpath, docker_dir)
+
+        for filename in args.extra_files or []:
+            _copy_with_mkdir(filename, docker_dir)
+
+        argv += ["--build-arg=" + k.lower() + "=" + v
+                 for k, v in os.environ.items()
+                 if k.lower() in FILTERED_ENV_NAMES]
+        dkr.build_image(tag, docker_dir, args.dockerfile,
+                        quiet=args.quiet, user=args.user,
+                        argv=argv, registry=args.registry)
+
+        rmtree(docker_dir)
 
         return 0
 
-- 
2.47.3


