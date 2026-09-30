Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F5BCA5FC7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 16:47:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBxSa-0001E0-6f; Wed, 30 Sep 2026 12:47:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xBxSP-0001BI-8e
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:47:04 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xBxSM-00032T-Qo
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:47:00 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d37b6so31405025e9.0
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 09:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790786816; x=1791391616; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=op01wSzx++PxzGWlywLCMk6UcO5p6EFFiioUSSIGFPg=;
 b=WSc8OnrimX93Zjx3cfTlaq/HQBZZtP6cE+58deSu2tV47amiMZdK/y/A0A2o/EZfMp
 brOdT66ICxQWVnxO51S5Ptpvc0C3yKEAIQfo8Ns+OK9ASBgI6HQZlBMtaoHZ9HWCB+Py
 myXispuPKpY5/grk1P0MjLWbkgKGl8KPyw0k3Z+rSFE1Rk53dWVZ8vnotpIV5wIaDy+Y
 HmTR7WR6jNEpXMLQtwoTBMEcyp8U1k5KQEy/LFyn/gaw3PJ5QgqFvMmmfglpn9qO+B/a
 GA0fUAi1fKTeRF0j+DmWGSDIqUleS08TsY1iLdQ8QdBqhoPNW0qjq6DnKbtDSKRf3h0H
 fYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790786816; x=1791391616;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=op01wSzx++PxzGWlywLCMk6UcO5p6EFFiioUSSIGFPg=;
 b=xVGvStCENnFczkzAR/ogEmsqDF+z5kj/TkWL56CgzReJueK76iizwF3pBv0VjF/s03
 gs0L7aFx/hs5ug/Ay6TaWfMtrBlfCiGNo4JvcStxPZIFBbSBaAADW3jFhhyOBVLYvl/0
 PPsCMDcM4gTiQ/T5X1yZT9awCRWWMrwYiB9W37tqImMqQpa6JYU3eYl/9TooyM+PUhlf
 3UkDnlM2FLqgR77xY3nGzTj1YDe/haJ7F1Zc++vFZ3RFRgffnC+aDL9hS+L9pZEaejPA
 BU9JUB7IKcaZiwVcBtOx8YJLoOG94EvuPEQViTtpopV8GyE+FRw89iWghG7el4irNEBJ
 WKYA==
X-Gm-Message-State: AFuF++nN3AlEoHnpS6132vVSKUxFg0HDcr9sacAYi4G5/VpGAxSVwWR5
 XNRY6Jb+QlMe6nkgeKBALYulFBZ7zJk0qv3QyvxW+Xu1F9KugyPQdUnge5Lyf+HDy6Q=
X-Gm-Gg: AYBFou2JXXKIwIcJigLGkUCq499u56AOyE7H5njgrWmcBTtYtkxKXeBgk//RGhRVaoz
 3a4CMyc/z9kOWr8Tf1ldZU9Sqjvnp8zzyObzh1mLx5YU9541LS8ZEu8y76JeWm0KlbN1OaaRtql
 yxQsJ7OIuC6cjrMc9LGJI7STdm/YtmC3Ct1S+SPkK/KtxXZ05Dec3UDs8DVLJWXkbUnYR8baxlE
 afJMMn5JSKGRI612prG2iIz3NgLhne9EK65RJFKDiCMwZwFeAVy8lJXayVuDEU9BmnTCpCP/XvH
 yu/UX55S7cDf8p1kxEsbmTr8Zr5Ka0CdCuZQ2AuZVoV+KE8BCgzknZURlOS2sms1Tj+Ad8Cz0l+
 ukR2xvBI5Ly/rdAwnV8hygWcuG5HIM+21wRx+Ku3Pqzcq5QN3fQh5rvfW42SilheCwyIcmoX8+T
 9ZzpPIGeeOSR+3x3VIC5tNX57PYM8W3W3ec0sUnsPoOXI/oi6HP4q300qrYD0c8f2sko0Kuw==
X-Received: by 2002:a05:600c:3b10:b0:49f:fbad:29c1 with SMTP id
 5b1f17b1804b1-4a01b133c13mr36246665e9.33.1790786816126; 
 Wed, 30 Sep 2026 09:46:56 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01ebadfdfsm2601245e9.14.2026.09.30.09.46.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 09:46:50 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E8C785F917;
 Wed, 30 Sep 2026 17:46:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Song Gao <gaosong@loongson.cn>,
 Ani Sinha <anisinha@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Brad Smith <brad@comstyle.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Anders Roxell <anders.roxell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Klaus Jensen <its@irrelevant.dk>,
 Fabiano Rosas <farosas@suse.de>, Jesper Devantier <foss@defmacro.it>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org (open list:nvme)
Subject: [PATCH 02/13] tests/functional: add migration diagnostics and pace
 nvme activity (HACK!)
Date: Wed, 30 Sep 2026 17:46:38 +0100
Message-ID: <20260930164649.433573-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930164649.433573-1-alex.bennee@linaro.org>
References: <20260930164649.433573-1-alex.bennee@linaro.org>
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

This is a hacky patch for comment but I've included the diagnostic
hacks to the migration test as well as my workaround to get itworking.

This test was failing on my KVM system. On investigation I found the
nVME activity meant the migration never completed. I ended up
inserting some sleeps into the workload script until I was able to
get it to run.

*NOTE*: obviously this can't be merged as is but I think we could
certainly do with more tracking in the test to see when things aren't
working with possibly the sleep as another patch.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/functional/migration.py                 | 37 +++++++++++++++----
 .../functional/x86_64/test_nvme_migration.py  |  1 +
 2 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/tests/functional/migration.py b/tests/functional/migration.py
index 8d2428efc24..e51a82c22f4 100644
--- a/tests/functional/migration.py
+++ b/tests/functional/migration.py
@@ -22,18 +22,41 @@ class MigrationTest(QemuSystemTest):
     timeout = 10
 
     @staticmethod
-    def migration_finished(vm):
-        return vm.cmd('query-migrate')['status'] in ('completed', 'failed')
+    def migration_finished(query):
+        return query['status'] in ('completed', 'failed')
 
-    def assert_migration(self, src_vm, dst_vm):
+    def wait_for_vm(self, src_or_dst, vm):
+        "Track the state of one VM in the migration"
+        current_state = last_state = vm.cmd('query-migrate')
 
-        end = time.monotonic() + self.timeout
-        while time.monotonic() < end and not self.migration_finished(src_vm):
-            time.sleep(0.1)
+        self.log.info(f"waiting for {src_or_dst} to complete")
 
         end = time.monotonic() + self.timeout
-        while time.monotonic() < end and not self.migration_finished(dst_vm):
+        while time.monotonic() < end:
+            if self.migration_finished(current_state):
+                break
+            else:
+                last_remain = last_state['remaining']
+                current_remain = current_state['remaining']
+
+                if current_remain > last_remain:
+                    self.log.warning(f"slow migration {current_remain} > {last_remain}")
+
             time.sleep(0.1)
+            last_state = current_state
+            current_state = vm.cmd('query-migrate')
+
+
+    def assert_migration(self, src_vm, dst_vm):
+
+        self.wait_for_vm("src", src_vm)
+
+        # if we hit this we never completed...
+        self.assertEqual(src_vm.cmd('query-migrate')['status'], 'completed')
+
+        self.wait_for_vm("dst", dst_vm)
+
+        self.log.info("checking everything is OK")
 
         self.assertEqual(src_vm.cmd('query-migrate')['status'], 'completed')
         self.assertEqual(dst_vm.cmd('query-migrate')['status'], 'completed')
diff --git a/tests/functional/x86_64/test_nvme_migration.py b/tests/functional/x86_64/test_nvme_migration.py
index 890f0aab6d6..58596f63cd3 100755
--- a/tests/functional/x86_64/test_nvme_migration.py
+++ b/tests/functional/x86_64/test_nvme_migration.py
@@ -109,6 +109,7 @@ def launch_source_vm(self, vm):
                 rm -f /tmp/test_nvme_mig_workload.iter_finished; \
                 echo 3 > /proc/sys/vm/drop_caches; \
                 find /usr/bin -type f -exec cksum {} \\;; \
+                sleep 0.3; \
                 touch /tmp/test_nvme_mig_workload.iter_finished; \
             done) > /dev/null 2> /tmp/test_nvme_mig_workload.errors &",
             prompt, vm=vm)
-- 
2.47.3


