Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F60C982C5
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 15:32:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6rbZ-0003Dc-2h; Wed, 16 Sep 2026 11:31:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6rb5-0002Je-Ox
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 11:30:59 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6rb4-0001V9-21
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 11:30:55 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e71cdb22bso8148555e9.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 08:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789572640; x=1790177440; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nksEiQivVR8/k7raC/CDe1zTFm2rFZxFOrnHCS7fvTI=;
 b=Znn/CIZCN8PY+xWR5+BwPrcGJ0x8Jid9m1heLR+H0smD/v4gREYE/uRJcAiG+QF+4X
 ATKjj89uURBVJCygieAjwEiWoEQ0faQfkuLmueM99PtlxKR3TexOnQEKYOTCucM/OxcG
 MFm7oM5h4kUMPblCoWbr+bBDzmezcgytRuoeXxwCTA3BNJ6MvIxBCQzHMdqBmEdwDRn5
 H/I2FCbicBxpAhqaG7JiR76Bocax1uxdoWbe912EMhFUKmovgQiZrih67jJEWjPyVu1O
 5wY+frEK35uIoA65bavDAHITpagqQAFDK95ZxBC0c9HZ/eYmv950PKmQyX96pgvCnhOm
 Xb8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789572640; x=1790177440;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nksEiQivVR8/k7raC/CDe1zTFm2rFZxFOrnHCS7fvTI=;
 b=JYCZTytuxvatdFIo0i1OsPkP8FahXOICfEljmk0ktPIZxcQyUg1iX0aGiKYek941ZI
 YFzgLla2Tn30gZguii51PGBF9OPglvcTaDlLQ4fsby9R4SLj2AuYhOd0DGlCzRjAJUqb
 F7iLihz/fzDHLzTWOLJMwRnAQlBlgnPavrtOupUD0pHOnlD+K5UTwF+gWOh7u5ghyg/2
 Wk1LxKNktNH9RdFsJs4lQ7Y4SXXRph+gLgFy95OkJH8MLNwWgy9VbbDGT2shUoJKv51i
 XsrVWuumikn9tvE/NWrICkEh0RRHWHfH8ZiF/WqJlFveR45Tsf9ZB8q9hOjEhd1oksYz
 q26w==
X-Gm-Message-State: AFuF++mcDt9kG+QbdVdxltGZOMrehBESx3G0pazsaawF5RtFsVPb2D6N
 4/YkTxuk0fwK8XpAtGdKNmmn255WdWabXCwYYFQgHReVYocXDUVRGs1x/2uukF7mGvA=
X-Gm-Gg: AYBFou3FE5CfcWM3UUwTbQRltz4XSNVSBbicq3VIT53EDlm3fo3mS+fePDHPQmS6Thq
 ImwFKqVaLRnGt6DwR+Eeg+C4oOY2WGxXideEgTCQyhNKLiQOGZ4rq7U1tcejMmwTPDP8vNLuKyh
 MWK+JXKSEU3no9UFv8FICin0nJ2PV5mhLJ6Zn6X3YzvgL3h/VkIB+BPd7dxJPEiqmB7UhMlTtui
 6qqRFCnVhpHpndnQgTq299ypsy6mogOrO73YXxa6FYFSJcm0vPXh+WA8tDYKQGfnbTjM1XpqXr7
 szL+Le+UyoIr/sqGGIdOz7ovXsmoAlt9nslH8kzoDkkkyWnbh5myVKYA8h93fvCAXsF/Ng48lZB
 7cjMCB5UGDdxACQ5ZfrKCSvuNEjItLtmNoMdgh71aXxSeugK9KunqDuoyItOmsQBABWgg/11isG
 UgSJSnWcSEsp2pygN/IYNv8NhgVImeknueQ0lFLxwU7+wtmHFIjQvkXZMIy/t+kDa4ML0g9WNkG
 CMNZ3Vk7Q==
X-Received: by 2002:a05:600d:4441:10b0:49f:bb8a:b4ce with SMTP id
 5b1f17b1804b1-49fbb8ab4f2mr19974205e9.28.1789572639885; 
 Wed, 16 Sep 2026 08:30:39 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e847e89f3sm30374395e9.3.2026.09.16.08.30.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 08:30:38 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8F341619A3;
 Wed, 16 Sep 2026 16:30:14 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, qemu-arm@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 John Snow <jsnow@redhat.com>, David Hildenbrand <david@kernel.org>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Kyle Evans <kevans@freebsd.org>,
 Eric Farman <farman@linux.ibm.com>, Brad Smith <brad@comstyle.com>,
 Fabiano Rosas <farosas@suse.de>, Helge Deller <deller@gmx.de>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-s390x@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 13/19] tests/docker: add specific command to parser
Date: Wed, 16 Sep 2026 16:30:06 +0100
Message-ID: <20260916153013.2134555-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260916153013.2134555-1-alex.bennee@linaro.org>
References: <20260916153013.2134555-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

A future change will want to use additional flags which clash with
docker/podman command lines. Currently they would get snarfed up by
argparser. Make the pass-through commands explicit to avoid this.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/coverity-scan/run-coverity-scan | 2 +-
 tests/docker/docker.py                  | 5 ++++-
 tests/tcg/meson.build                   | 2 +-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/scripts/coverity-scan/run-coverity-scan b/scripts/coverity-scan/run-coverity-scan
index 2f9ccd5e44b..0e1361606e0 100755
--- a/scripts/coverity-scan/run-coverity-scan
+++ b/scripts/coverity-scan/run-coverity-scan
@@ -381,7 +381,7 @@ if [ "$DOCKER" = yes ]; then
     # Arrange for this docker run to get access to the sources with -v.
     # We pass through all the configuration from the outer script to the inner.
     export COVERITY_EMAIL COVERITY_BUILD_CMD
-    tests/docker/docker.py run -it --env COVERITY_EMAIL --env COVERITY_BUILD_CMD \
+    tests/docker/docker.py run -- -it --env COVERITY_EMAIL --env COVERITY_BUILD_CMD \
            -v "$SECRETDIR:/work" coverity-scanner \
            ./run-coverity-scan --version "$VERSION" \
            --description "$DESCRIPTION" $ARGS --tokenfile /work/token \
diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index a2e97061240..d7eb4cf6811 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -336,9 +336,12 @@ def args(self, parser):
                             help="Don't remove image when command completes")
         parser.add_argument("--run-as-current-user", action="store_true",
                             help="Run container using the current user's uid")
+        parser.add_argument('cmd', nargs='*',
+                            help="""The command to run. You should precede with
+                            -- to avoid confusion about its flags""")
 
     def run(self, args, argv):
-        return Docker(args.command).run(argv, args.keep, quiet=args.quiet,
+        return Docker(args.command).run(args.cmd, args.keep, quiet=args.quiet,
                                         as_user=args.run_as_current_user)
 
 
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 87e5614fc83..80205f6f98a 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -257,7 +257,7 @@ foreach target, plan: tcg_tests
       mount = meson.project_source_root()
       mount = mount + ':' + mount
       here = meson.project_build_root()
-      cc = [docker_wrapper, 'run', '--run-as-current-user',
+      cc = [docker_wrapper, 'run', '--run-as-current-user', '--',
             '-w', here, '-v', mount,
             'qemu/' + cc_dockerfile, plan['cc']]
       has_cc = true
-- 
2.47.3


