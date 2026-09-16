Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C5E7C982C9
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 15:34:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6rbL-0002Wz-Ed; Wed, 16 Sep 2026 11:31:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6rb6-0002Jl-Ol
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 11:30:59 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6rb4-0001VX-2V
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 11:30:55 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49b912e64ccso7426565e9.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 08:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789572642; x=1790177442; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=s+iJgOTicDwCjhm5qp3QC56yC+WLMH8ocrsmN4EU6Dc=;
 b=wcB6cI90QZCD/wIjH81Msda/6xHRKMhwo5guXzLgmrDcPvaKMbFMUltET7oibebxDC
 D4+TZIO6MrxIkyYoXyCjbhrv0iPfS+c5BlzgMKQ7uSlsXabkfw2jgAGjDKZX+NBGMaeS
 X2eKJ+J+JIcCu07o2WaXhGzFjdLvwRs68uQiE4EYBRzrKpMTKsbhMxRmzT8VPtKwSI1n
 W2ZSMvE+YrQvdXKipwwELZvAlNGqn27jmbSPlCN1eI0C81AFxUvB4awHNpK4OWQAVG6l
 O3FTHwCcCFQjQQvjMnzpMP+FblBKU8JfXHGb7v6tkSg5RXEcB/Y0L80pk3Rp/aCLz+0G
 axyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789572642; x=1790177442;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=s+iJgOTicDwCjhm5qp3QC56yC+WLMH8ocrsmN4EU6Dc=;
 b=TtCibRNB9dUY4rEcqdNDjI6PwA7AvXaCMSL2UHSwxX2IxeJuT6CXrgxIQ6ASBe2GzN
 I9/qQBJPWnp/SZjB9Z5FGflPvt4lvpsDW9GSkAfC6s9bb6q0KZ2I4WEXcY8nvMiQzq0t
 FTVhtXfwWZyOfURdxzlXRmt4sROSayKs1EEOuyCNBD+7XRoy114AGPYKhrvYAUNEGuwr
 FKsPB2y83bHahkCnD6OK2zuzyAjdh7wRyPeXECwdTrk+7/MmIRw05hq2m8lyBa18vxNG
 NyiUCJUENmC2Cq7+kBNdfD97BoXuV3NkTVSznPjZWNd2PYMExi6dwhYUozZ/zfJ5+Wnt
 6zEg==
X-Gm-Message-State: AFuF++kJrUHDYgjwzd7DQjEgneWaf75CBv3Ns6grxfAOXs473YyRb6Ab
 2tv77YZd9cEW3u4ZYq4JhZLHyDQY70lY/4MFUXNByjyQun/ssyeqLFP4juOgT4jHPys=
X-Gm-Gg: AYBFou3c8yuoWjlozqVJmwUlZCcTiJdeklGzajcOqCRBzMl+woJ/HNMng7P75WOTX5a
 AShsEmhrzojWemZJC84AYdtOgB30t791nxebfYq85AMraXPJkYAZhm1qXurvWNqNr05DDcWPjVt
 3dXX8GhpHrPNsaxVfal2aqTRythv1grKs9xwACPP+eOGO2JPN1dXb8YzeOp6mAXKj9HMgWyoE5G
 7gGbu35r3DfVr20DefUY2V3edEtvAnSRZ/29tuGiqOteaR8pye24sAB8a/yRm9xBD5hXe/7BLgv
 eg1JEv9AHjUYZdHu/7NEBO+UIJgzudsw/lQoei0I9MZFGZLOw9jBwsbbdvcBpzrX9xX4wbpWplf
 6SJhjYVic8bwPhscKvs7MnF2WDcIsz6CXHPBV3iXxk3qtvn6bmhMqWHAoaD8eVsZHlgD61Yne4x
 Wph17duiS0TgiubEBq/I+1Kvmv+PmEoDDhhoHfhyhE26gyfDjgVbC6kFSUlANfJSnq8pNlctQ=
X-Received: by 2002:a05:600c:3e15:b0:49c:f617:7cf with SMTP id
 5b1f17b1804b1-49eac41066amr71528515e9.0.1789572641350; 
 Wed, 16 Sep 2026 08:30:41 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbbd951a0sm16970965e9.4.2026.09.16.08.30.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 08:30:38 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F2A6061A7B;
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
Subject: [PATCH v4 17/19] scripts/make2mtest: add docker dependencies for
 check-tcg-% targets
Date: Wed, 16 Sep 2026 16:30:10 +0100
Message-ID: <20260916153013.2134555-18-alex.bennee@linaro.org>
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

This should trigger the building of the docker image when the user
calls "make check-tcg" or one of the arch specific targets such as
"make check-tcg-m68k-linux-user".

We still keep the internal meson dependency so individual tests can
launched and the docker build verified.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/mtest2make.py | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/scripts/mtest2make.py b/scripts/mtest2make.py
index 383ea68b16d..ab894d90d47 100644
--- a/scripts/mtest2make.py
+++ b/scripts/mtest2make.py
@@ -14,6 +14,7 @@ class Suite(object):
     def __init__(self):
         self.deps = set()
         self.speeds = set()
+        self.docker_deps = set()
 
     def names(self, base):
         return [f'{base}-{speed}' for speed in self.speeds]
@@ -40,7 +41,22 @@ def names(self, base):
 
 introspect = json.load(sys.stdin)
 
-def process_tests(test, targets, suites):
+targets = {t['id']: [os.path.relpath(f) for f in t['filename']]
+           for t in introspect['targets']}
+
+# collect the docker images uses by the tests. This is totally a hacky
+# heuristic that fishes the images out of the test custom commands by
+# looking for the qemu/image pattern.
+targets_docker = {}
+for t in introspect['targets']:
+    for src in t.get('target_sources', []):
+        for arg in src.get('compiler', []):
+            if arg.startswith('qemu/'):
+                img = arg.split('/', 1)[1]
+                targets_docker[t['id']] = f'docker-image-{img}'
+                break
+
+def process_tests(test, targets, targets_docker, suites):
     executable = test['cmd'][0]
     try:
         executable = os.path.relpath(executable)
@@ -51,6 +67,8 @@ def process_tests(test, targets, suites):
     deps = itertools.chain.from_iterable(deps)
     deps = list(deps)
 
+    docker_deps = [targets_docker[x] for x in test['depends'] if x in targets_docker]
+
     test_suites = test['suite'] or ['default']
     for s in test_suites:
         # The suite name in the introspection info is "PROJECT" or "PROJECT:SUITE"
@@ -59,6 +77,7 @@ def process_tests(test, targets, suites):
             if s == 'slow' or s == 'thorough':
                 continue
         suites[s].deps.update(deps)
+        suites[s].docker_deps.update(docker_deps)
         if s.endswith('-slow'):
             s = s[:-5]
             suites[s].speeds.add('slow')
@@ -81,6 +100,9 @@ def emit_prolog(suites, prefix):
     print(f'all-{prefix}-xml = {all_xml}')
     print(f'.PHONY: {prefix} do-meson-{prefix} {prefix}-report.junit.xml $(all-{prefix}-targets) $(all-{prefix}-xml)')
     print(f'ninja-cmd-goals += $(foreach s, $(.{prefix}.mtest-suites), $(.{prefix}-$s.deps))')
+    print(f'docker-cmd-goals += $(foreach s, $(.{prefix}.mtest-suites), $(.{prefix}-$s.docker-deps))')
+    print(f'docker-cmd-goals += $(foreach g, $(MAKECMDGOALS), $(.docker-goals.$g))')
+    print(f'run-ninja: $(sort $(docker-cmd-goals))')
     print(f'{prefix}-build: run-ninja')
     print(f'{prefix} $(all-{prefix}-targets): do-meson-{prefix}')
     print(f'do-meson-{prefix}: run-ninja; $(if $(MAKE.n),,+)$(MESON) test $(.{prefix}.mtestargs)')
@@ -93,6 +115,10 @@ def emit_suite(name, suite, prefix):
     print()
     print(f'.{prefix}-{tgtname}.deps = {deps}')
     print(f'.ninja-goals.check-build += $(.{prefix}-{tgtname}.deps)')
+    if suite.docker_deps:
+        docker_deps = ' '.join(sorted(suite.docker_deps))
+        print(f'.{prefix}-{tgtname}.docker-deps = {docker_deps}')
+        print(f'.docker-goals.check-build += $(.{prefix}-{tgtname}.docker-deps)')
 
     names = ' '.join(sorted(suite.names(name)))
     targets = f'{prefix}-{tgtname} {prefix}-report-{tgtname}.junit.xml'
@@ -105,19 +131,16 @@ def emit_suite(name, suite, prefix):
     print(f".{prefix}.mtest-suites += {name} $(call .speed.$(SPEED), {names})")
     print(f'endif')
 
-targets = {t['id']: [os.path.relpath(f) for f in t['filename']]
-           for t in introspect['targets']}
-
 testsuites = defaultdict(Suite)
 for test in introspect['tests']:
-    process_tests(test, targets, testsuites)
+    process_tests(test, targets, targets_docker, testsuites)
 emit_prolog(testsuites, 'check')
 for name, suite in testsuites.items():
     emit_suite(name, suite, 'check')
 
 benchsuites = defaultdict(Suite)
 for test in introspect['benchmarks']:
-    process_tests(test, targets, benchsuites)
+    process_tests(test, targets, targets_docker, benchsuites)
 emit_prolog(benchsuites, 'bench')
 for name, suite in benchsuites.items():
     emit_suite(name, suite, 'bench')
-- 
2.47.3


