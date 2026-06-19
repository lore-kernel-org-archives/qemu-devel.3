Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67D21CDB466
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 15:57:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wabaf-0007K2-PF; Fri, 19 Jun 2026 11:57:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wabad-0007IW-P1
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 11:57:07 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wabac-0001IT-30
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 11:57:07 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-464192ab2e1so1386446f8f.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 08:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781884625; x=1782489425; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I/w0e+35WQwMdGgvrVQ6ookznor3U6z7jkLjp6mxTL4=;
 b=vv9imfEg57W6W6txRvKo/H9znBFvFob83k5e7vbZheFc2WPnX5EyJVf9br+U2yxD0H
 MB2FVODoBu4g0Cbndg9CrQIjB60U+pSZQkReZOoVIV5yPr+fOSGWOQR1NGJJ2WehyWRf
 WJ2aMq2+hN/GYouZTfp4y50qm7XFEz0XCxaXQDusYWBPNxzfCr0Z+PZEU9EdfT/U1zuf
 qs2/6GySGxUPXrdrgCWiGjMJ+VYTXA8AqfVYAeLf9a9RhlrO+pZHK4QNCpUohp+cQDzD
 sqZ/c6lk7D+jCW6Lg5+mkcDR1nyI61p6os1nDqk+uzMJmyqUJkRj2ftyDe77PuGoE4LZ
 +Q/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781884625; x=1782489425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I/w0e+35WQwMdGgvrVQ6ookznor3U6z7jkLjp6mxTL4=;
 b=sL60/p8Cypk6VLPfZPRYrgeuaqHvvO9MZsOlYzFaKN/iZfeqZ24RDikUwiRax3p8iL
 Vnj455iB35HEMNFXFXQ4mK4w61Io+5UDQtZXBXkOeVryCo8XJyRj8geeWiI89BwMBeV5
 HioX0LppnrT9YCoKIaPM5Rx8h2H0AG+ldguNm3Vp7Mv5KO6JX5ZCtehoCUG85OXEieUA
 WNsJCGUSg5WVFMEFL5kN33O5eiIoM+P9+SNKEWPgQD3vB8h5PxeDhUbP/9btDSulawH+
 RovxX6koNdFyxBnG5aAI4Ueps7BiHmkZiXCYBCD6dxz74+ysCd7B8OtzP2SfQSohyPzd
 XI6A==
X-Gm-Message-State: AOJu0YxLJOlIaS4RnlTdnS9d42Pw4bLKgjdytDsmb1feLT++BmVfBgxP
 Koe5NilBb+l2ArDQQwViV3oszyVwtDaEx7+/sJwHwdZnM9sRy41nlMaMr7BM1EE2TOQ=
X-Gm-Gg: AfdE7cnsNbRayKPuIT6lC5bkG4XJ1z7aMwLp+tsBr7oMorsyPn7oxnbM3tqV6NUUWZm
 ayRhx8f7zbPrwwZheRB6iuZ3SqGwR9Fnk/C2td8He3KjXkg3cbXXrIJixD2+Aq8oRWbTYTf6kdm
 wNx1RdiErpCijWlcicF7/pp5vAFUX14KUO2zBdkz3Heg2A5cD6KGIEOBIUXyXQ8zCp7TK/SqUHW
 ZyDVM1OuYvEjA8HfFAi5yX88eVGvgadTrwKv9wuNAliefLKaFt3vWxRbyYq5kWvL6HW0CGHkBGj
 3geCX3zvVTiosLD1LqbNN6TpJwfZLhnuUuaZWMNUM6xz6D4cGeiwJoFrvB6FpDD7K82BSEgX5jB
 mgnzYUY/J8V8Q/fiSfZMEyp/tQe7t5dAZ0x1UNUBzTj/Ieu9q3FhWU/cKf+M7VmWIWKXfXaUfzA
 csEB9rJa0a9G7J
X-Received: by 2002:a5d:5249:0:b0:45e:f5b6:7bf9 with SMTP id
 ffacd0b85a97d-465024021d2mr6422512f8f.31.1781884624716; 
 Fri, 19 Jun 2026 08:57:04 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-466643f4e3esm66531f8f.8.2026.06.19.08.57.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 08:57:02 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C0CDF5FAF9;
 Fri, 19 Jun 2026 16:56:57 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>,
 Cleber Rosa <crosa@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Warner Losh <imp@bsdimp.com>,
 Brad Smith <brad@comstyle.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Subject: [PATCH 5/7] gitlab: ensure "check-XXX' jobs capture functional test
 logs
Date: Fri, 19 Jun 2026 16:56:54 +0100
Message-ID: <20260619155657.944220-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260619155657.944220-1-alex.bennee@linaro.org>
References: <20260619155657.944220-1-alex.bennee@linaro.org>
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

From: Daniel P. Berrangé <berrange@redhat.com>

A small subset of functional tests are run by default with
'make check', and so run in the context of 'check-XXX' CI
jobs, rather than 'functional-XXX' CI jobs.  Thus we need
to capture the functional test logs unconditionally for all
test jobs.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260610121254.2870259-1-berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/buildtest-template.yml | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
index 005058625eb..3b003abc999 100644
--- a/.gitlab-ci.d/buildtest-template.yml
+++ b/.gitlab-ci.d/buildtest-template.yml
@@ -78,6 +78,15 @@
   extends: .meson_job_template
   stage: test
   image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
+  artifacts:
+    name: "$CI_JOB_NAME-$CI_COMMIT_REF_SLUG"
+    when: always
+    expire_in: 7 days
+    paths:
+      - build/meson-logs
+      - build/tests/functional/*/*/*.log
+    reports:
+      junit: build/meson-logs/*.junit.xml
   script:
     - source scripts/ci/gitlab-ci-section
     - section_start buildenv "Setting up to run tests"
@@ -111,15 +120,6 @@
     paths:
       - ${CI_PROJECT_DIR}/functional-cache
     policy: pull-push
-  artifacts:
-    name: "$CI_JOB_NAME-$CI_COMMIT_REF_SLUG"
-    when: always
-    expire_in: 7 days
-    paths:
-      - build/meson-logs
-      - build/tests/functional/*/*/*.log
-    reports:
-      junit: build/meson-logs/*.junit.xml
   before_script:
     - export QEMU_TEST_ALLOW_UNTRUSTED_CODE=1
     - export QEMU_TEST_CACHE_DIR=${CI_PROJECT_DIR}/functional-cache
-- 
2.47.3


