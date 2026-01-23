Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10428D74ED0
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 13:36:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjHKL-0007V1-Cu; Fri, 23 Jan 2026 08:35:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vjHKK-0007UR-8o
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 08:35:52 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vjHKI-0004dI-Sg
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 08:35:52 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 07955419B6;
 Fri, 23 Jan 2026 13:35:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC574C4CEF1;
 Fri, 23 Jan 2026 13:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769175349;
 bh=df1SQyLPe1AgLmzuzWGgw1GL4THVwDBvScVE5vk9mvo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gQRksBFKHXQNbBkP7ZMbZOZYb96eJ/gIPhrkyLMeqlrYuuEHi3MBsWkk1Y90jYiuu
 EXOiaB3Wz06aAKXnIvy4ZV9ESXA/lFWS/gLP2Ky79Yo+M5+L2A+6FemLGHREvoayXA
 Y/hqSMM7oYWRnbzcnNApqvKaiVKVuJn36ITdOD+AeDJA5NSAyk0CX6L2eomyKy0meR
 YlJCJdecrA26FixckDufwYwzn1X1FBfZ5Jy6bo7x8vG4MDuTZTXce9CqnrQwtVT3gU
 jNMkOVtBUi+Raoe0/v7hf8/fGQf09r+oWBmJmCJnqiX8qg4oFMqciLqoMn2jjx9BTR
 xN679LODWV0Jw==
Received: from localhost ([::1]) by mail.kernel.org with esmtp (Exim 4.99.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vjHKF-000000063K1-2tqd; Fri, 23 Jan 2026 14:35:48 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v2 08/13] scripts/ghes_inject: exit 1 if command was not sent
Date: Fri, 23 Jan 2026 14:35:22 +0100
Message-ID: <33f73ccf18dd1cf7cb7dbf54e72c81581eb7c84c.1769175070.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769175069.git.mchehab+huawei@kernel.org>
References: <cover.1769175069.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=mchehab+huawei@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.079,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

add a return code to subparser func() and return 1 if the
command failed.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 scripts/arm_processor_error.py | 2 +-
 scripts/ghes_inject.py         | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/scripts/arm_processor_error.py b/scripts/arm_processor_error.py
index 73d069f070d4..d9845adb0c0a 100644
--- a/scripts/arm_processor_error.py
+++ b/scripts/arm_processor_error.py
@@ -473,4 +473,4 @@ def send_cper(self, args):
 
         self.data = data
 
-        qmp_cmd.send_cper(cper_guid.CPER_PROC_ARM, self.data)
+        return qmp_cmd.send_cper(cper_guid.CPER_PROC_ARM, self.data)
diff --git a/scripts/ghes_inject.py b/scripts/ghes_inject.py
index 9a235201418b..6ac917d0b5db 100755
--- a/scripts/ghes_inject.py
+++ b/scripts/ghes_inject.py
@@ -43,7 +43,8 @@ def main():
 
     args = parser.parse_args()
     if "func" in args:
-        args.func(args)
+        if not args.func(args):
+            sys.exit(1)
     else:
         sys.exit(f"Please specify a valid command for {sys.argv[0]}")
 
-- 
2.52.0


