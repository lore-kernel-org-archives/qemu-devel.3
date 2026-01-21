Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ADB8C44507
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 11:28:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viWLZ-0003Bw-Ee; Wed, 21 Jan 2026 06:26:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1viWLF-0002rN-AU
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 06:25:42 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1viWLA-0007my-P0
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 06:25:40 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 555B3441EA;
 Wed, 21 Jan 2026 11:25:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E92CEC2BC87;
 Wed, 21 Jan 2026 11:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768994725;
 bh=WLJTrMBVRNsrytHUwDMQLh8d+CckHuO5TQBxhn4AWog=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=s8/1scL14pnxSE6QTeXMtFh7Rg0nWVOq3sNyEIffw66Orgc7e7Eu+5ZOpE4zx7bLU
 gMyvf61HYMhGNC4h+jCa61fkRwANtw7f84lhGJ6yzlifp8GSw/dsEYkUDsePe0R5M/
 I0gKk390C0FolbxqXzj9A8NF3sn707O6j68tynEgnW+vpVdel6fK1aiS3T1FeLYtSV
 OIriU+IGHQKdxn+hiYNannQzsyNn/EaccYY9rdCRLJkRN91Oe0KCNBkwoBzh+/MkiU
 JwSTpoqyoSNg5nrqSul/Ba9FVcKKyJ+g1Pt6fbH1IeWv5eTmZYxd/G98FgbTHh+Brl
 yJV7WbGDMFUrA==
Received: from mchehab by mail.kernel.org with local (Exim 4.99)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1viWKx-00000003gJm-0oM7; Wed, 21 Jan 2026 12:25:23 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Michael S Tsirkin <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 08/13] scripts/ghes_inject: exit 1 if command was not sent
Date: Wed, 21 Jan 2026 12:25:16 +0100
Message-ID: <746cc65bbde60ebe2232b048d6448d19466601c5.1768993993.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768993993.git.mchehab+huawei@kernel.org>
References: <cover.1768993993.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=mchehab+huawei@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.087,
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
2.52.0


