Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03BEAC88E40
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 18:16:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4jIp-0003xN-Fj; Thu, 10 Sep 2026 14:15:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x4jIl-0003sz-Vx
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 14:15:12 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x4jIk-00072a-1K
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 14:15:11 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-49b392ccaacso1919245e9.2
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 11:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789064108; x=1789668908; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=C9qlVmOnQkWE+xFF6u070uQ1ams8HXddt0mJhaLqyXQ=;
 b=OnvnqQf4cNWBeit5+aJuJ/6bU4r+YHsRakComzHrJRyzsUbeR/W3z8QjhsieCCjrkH
 MKmot2uceTtFcjXPXDprX1Q+OoKapXuLnr7VX9YJkA0dS0maueuKP+O5z8xU88HEq6X0
 jyKO3tEhTSR4PZJTxAPzJ7uVt2xY4tjsdAiVvu43R4YEa8vSstnoMDpm6M0WJCyeEhbR
 uAHyktlnKrp3gxePlHbwAU97wT9MfxWdDZIg2etOAQJyJg/WaCQWggyPF+T6dHIRH0W2
 yQFoO7z7UYZlGBHikIs9e1X9v7f6Q9k7LDJm86YFd64BsW43Nm8fg9QLrBtgiw5TTcGh
 V08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789064108; x=1789668908;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=C9qlVmOnQkWE+xFF6u070uQ1ams8HXddt0mJhaLqyXQ=;
 b=JewXy81/h13JWjBbobU98s7AAeYBQy7tsdE3AxsFN3NDlDbvgWsZQUyZIGA7L7x1qf
 6Y4/JTDMFsBYT6fcR6E/Sa5/WlrTKun8w+2Tu+7gai6nkcLdIm8lJwo/e89N/1HWo39U
 /4LoD8pIjoE2MN40VU3PgBpxLQR9IFJy+smlMMv9XyMITytYbNaksyobelKWDqIwbvF+
 5b4TfNozlG8sWjjbGjL/5eKRjcXaDJE+ATkRyCZHDKZhaFK7LG2k+t24WpA75yBKN6bJ
 8E5kW7QGiz+5kLCR44gp39cBWmByJObBiwOtB1EA1QIt3neeGvzg4+Kxn/T5w7Sbw1Qg
 e6yg==
X-Gm-Message-State: AFuF++nTsvYqJzXqkt7VLnqbnUpFonDJLnn0C95/FcNyXiCl39bCWwnK
 8UXKl+PgxIVIxyegCL3KIU1CNOPuPRX6Ii0mx7e3+9h8Cj93I/Yxzl6p+OwXObru7BY=
X-Gm-Gg: AYBFou0nJJ7FUHvnsEANfQuX68+QifSU6/zZVnwItsQMl0NRj5t5oGVphlGgYoENfjT
 FN8SxVeylbraI22DV2BmUT0ufAkzlkLVwFt6imNWsohn5DkupzRajhqNIe/qkKRTB86UwGpIhGX
 lrBYvk0fY+OgVarJDDcFoNguN0P4pBppCgDGuplOxLMy7d7Cl77ZEkAB8Bx1Akoq+wINpUnMaoK
 gygktWUV9cIUpp0dtpb4fThRDHPpsXhzx2Ypze5yKKCdAkXiUqmqg+koFeY9ea7LIaYoMsrfwZH
 BAgvdRS9hyGoKHc8JPkCqZRP9St5LYs/F3SQKhYRZxcZAUaH8hU9C17lu/B5OaZcG1VL8JRSANz
 y4uTlWFkjdDDfRol5QGGjMzNOVVIETVg1ulLMVAvoEeFfeXd1ystVuDiQgMRacE9UBB4GxqNK4Z
 DjA6gsFGc6CDDxmBB1JCZVkGPkcAut6Go1QRD0gbP85YK3XC7Pn6UPrW/T6UfuSpNzRAxXE70=
X-Received: by 2002:a05:600d:8494:20b0:49d:1840:4fd2 with SMTP id
 5b1f17b1804b1-49e619c461amr2105885e9.23.1789064108305; 
 Thu, 10 Sep 2026 11:15:08 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26d49d57sm81356795e9.14.2026.09.10.11.15.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 11:15:06 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 681A35FBD6;
 Thu, 10 Sep 2026 19:15:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Song Gao <gaosong@loongson.cn>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
Subject: [PATCH 4/9] tests/tcg: use --add-current-user when building containers
Date: Thu, 10 Sep 2026 19:14:59 +0100
Message-ID: <20260910181504.1010916-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260910181504.1010916-1-alex.bennee@linaro.org>
References: <20260910181504.1010916-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

As the meson tcg build routes the container builds through docker.py
we can also clean up its hack which involved appending a RUN line to
the dockerfile. All the dockerfiles that care will work with the
--build-arg.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/docker.py | 13 ++++++-------
 tests/tcg/meson.build  |  3 ++-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 315fa2ff848..6090a9dc957 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -297,13 +297,6 @@ def build_image(self, tag, docker_dir, dockerfile,
                                              dir=docker_dir, suffix=".docker")
         tmp_df.write(dockerfile)
 
-        if user:
-            uid = os.getuid()
-            uname = getpass.getuser()
-            tmp_df.write("\n")
-            tmp_df.write("RUN id %s 2>/dev/null || useradd -u %d -U %s" %
-                         (uname, uid, uname))
-
         tmp_df.write("\n")
         tmp_df.write("LABEL com.qemu.dockerfile-checksum=%s\n" % (checksum))
         for f, c in extra_files_cksum:
@@ -315,6 +308,12 @@ def build_image(self, tag, docker_dir, dockerfile,
         if self._buildkit:
             build_args += ["--build-arg", "BUILDKIT_INLINE_CACHE=1"]
 
+        if user:
+            uid = os.getuid()
+            uname = getpass.getuser()
+            build_args += ["--build-arg", "USER=%s" % uname,
+                           "--build-arg", "UID=%s" % uid]
+
         if registry is not None:
             pull_args = ["pull", "%s/%s" % (registry, tag)]
             self._do(pull_args, quiet=quiet)
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 0604c4b90b9..814f2f8cd8c 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -255,7 +255,8 @@ foreach target, plan: tcg_tests
     image_name = 'image-' + cc_dockerfile
     has_docker = docker_host_arch_supported and docker_supported
     if cc_dockerfile not in image_targets and has_docker
-      cmd = [docker_wrapper, 'build', '-f', dockerfile, '-t', 'qemu/' + cc_dockerfile]
+      cmd = [docker_wrapper, 'build', '-f', dockerfile, '-t', 'qemu/' + cc_dockerfile,
+             '--add-current-user']
       t = custom_target(image_name, command: cmd,
                         build_by_default: false,
                         output: 'no_output_' + image_name)
-- 
2.47.3


