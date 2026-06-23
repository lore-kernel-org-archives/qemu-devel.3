Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E39CDB46F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 10:13:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wby7e-0001qg-IW; Tue, 23 Jun 2026 06:12:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wby7b-0001nJ-VD
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 06:12:48 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wby7a-000751-FQ
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 06:12:47 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-46066e640easo3260705f8f.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 03:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782209565; x=1782814365; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NpbhSBkeCzIyJRSoZI/dnYPX9/ao03hxlbtgFWqxmIE=;
 b=Hzxhvzm7dK1WE1UDRujmfQDtU2j8BJOpwoi/pd+R4/osaT/AC4FHwvuhj3nz41+TCa
 NOzP1wftRjReFaacf+pe30UKytPmg4gFZ8Ms2IFT6WfgVpJi0wPoIRAbQb6lniVYw5A5
 Vx5dFOhCDuoWMCyhFWi41jsXo+q+U7v+3VU2dbYnuG3dvvN4FzwCXvQZoQLskyTUbT7o
 eTc+uXnEgCPj36A5gD5w68+00JJIA6rU0mzD/vZV4La8QiFXp63/yLmAQk7mzNYJQeXr
 b6KsputyqqXPHIY6Cq1K+DLCNz8ps27IqXUj5CcPs3Sgbbk8s6B+eZcpseaX7/RJvuOu
 LoNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782209565; x=1782814365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NpbhSBkeCzIyJRSoZI/dnYPX9/ao03hxlbtgFWqxmIE=;
 b=BGUauld1lIfwsBVsl7WjsHpR9PlJKhw3XHWQ3E2pcO7W3FE7Hkz69P/XVnC4ae19c4
 1G8ZK6CWgLsTOUdXW1ACL2e4N+7asWwtk5cXGZ2xaLAz/SJGIqjH40LC3msYRxCLL2jx
 DZtxTPwwnsQoYCJ4jb7iJC4qBzasxbADClxXM015ZgtN1aAG7vzZkprhASdBPGsjVHE0
 3ZD93Ct0vlNDRmPOk6Y7q1XePCHqMoBTmQEcXslHkEXqHF4CNq21dWX/rUUaWN2LHAnO
 4EDTI0Uda+rTPd6liUCsXBugkMPSIXMmXOpeHv11Mfx4VuK/QSsGZ26FFD+7CQ9nrmhs
 wSlQ==
X-Gm-Message-State: AOJu0Ywq8JcwJN5y6AygbIF0QnL2ASjO/p5YLOTUEvNNVROVGAXBTJT3
 0Py5tsU9pW/Um4UtjZiviXqx4icQSn6zcJqXoGqko7qDfoyqKNQFYIPjRxaSNNGh2yM=
X-Gm-Gg: AfdE7ckpDXl0YyyNu2I5FjzntJDXok0EJTU0md6HGdZ5EYTeJafMYqUrE3IbBUS3AEX
 sG0neOBS0bjhPTxbqXwXWo6HmHKT4AD+Tqp0xfque0fKOjQ7CM0ixowZND6QKWb8wwCTHog9DOO
 49upOc/J6gTQlJfmC1M8GATu4VwdmbXdlzVpjrBY837gqMcShfuQyw7sl9Dz+AidxmadXSr3re3
 UrVhjcXYqenkBa6Kfojfj7rvqa9eMp6Noxw+lG6YDEWwVIarhBJg6DVezzAMxvcv1ckSttSktyM
 2taOoBYWzx0/y44TB6rRSdqbd5ufxVhMxT1DXMGJIPuYAiy3MXb8EmOc5H91R+wnq9fIxK14PA4
 YxODmzdbQMK6KNqYqHeTZXfOaJZkFhj6ENhV+TzqLlVknEeLF+/ikboG0zIJSPYsNlJGpY3IMx1
 BJmJXddULq7p3r0btkmhpuMc0=
X-Received: by 2002:a05:600c:4e4f:b0:492:5bb6:6d56 with SMTP id
 5b1f17b1804b1-4925bb66e31mr23752535e9.35.1782209564835; 
 Tue, 23 Jun 2026 03:12:44 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49240ee9bc2sm261051995e9.1.2026.06.23.03.12.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 03:12:43 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DB3A85FC69;
 Tue, 23 Jun 2026 11:12:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL v2 5/7] gitlab: ensure "check-XXX' jobs capture functional test
 logs
Date: Tue, 23 Jun 2026 11:12:36 +0100
Message-ID: <20260623101238.3806547-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260623101238.3806547-1-alex.bennee@linaro.org>
References: <20260623101238.3806547-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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
Message-ID: <20260619155657.944220-6-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

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


