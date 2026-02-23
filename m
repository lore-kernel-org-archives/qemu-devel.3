Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EB34EA4FB4
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 11:52:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuUSn-0004VG-JI; Mon, 23 Feb 2026 06:50:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vuUSc-0004SG-8Z
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 06:50:46 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vuUSX-0004rh-4F
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 06:50:45 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 0240A443A5;
 Mon, 23 Feb 2026 11:50:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B5AC2BC9E;
 Mon, 23 Feb 2026 11:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771847433;
 bh=7wkhWQx0OVm0fhiqLkvqrfLKqF/jJ/70yA1ANDUDhFQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DjHledo4byn/Dg4gRfos4Gr87z1rP/8vzkSdPv5GiTIk07eUli6HvctynQLFPRZ9H
 cZJp+XMEFjG4OT/sffmEmQMkIr4GCHjAzdqYm1a/+owvCXu5w5s1Ih15ShNq31CO6Y
 yfWqsqdct+4sTvGYSpo6GaFlXW5vQyYM8ckY529w6odIQcfpH5m0V4gm23maoLlNUh
 s06qSrc59z11RDbNRIh7IXpX1cK0rWaI/KXWb1FXjNv5SuUH5zUMmFAor6rAOJr0K7
 AgP7JBa2FFtFV6YbAmRJnsuq5fiqZFp4zT0eUL6pgsw/6Ckp7YR/zA+3Vw5QT9pymg
 OYnBCmT+D2drw==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vuUSO-00000007JoR-0UG4; Mon, 23 Feb 2026 12:50:32 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Michael S Tsirkin <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH v3 09/14] scripts/ghes_inject: exit 1 if command was not sent
Date: Mon, 23 Feb 2026 12:50:25 +0100
Message-ID: <048db3ff4105e897b5e1356e086171920dcb35de.1771847176.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1771847176.git.mchehab+huawei@kernel.org>
References: <cover.1771847176.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=mchehab+huawei@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
2.53.0


