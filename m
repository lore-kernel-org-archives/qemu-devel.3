Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092EAD74ECF
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 13:37:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjHKl-0007p8-Is; Fri, 23 Jan 2026 08:36:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vjHKa-0007hL-Og
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 08:36:10 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vjHKV-0004hg-N7
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 08:36:07 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id AA80D43ADE;
 Fri, 23 Jan 2026 13:36:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B282C19421;
 Fri, 23 Jan 2026 13:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769175362;
 bh=9qrS69E/giGmWJ2vuuG1B6GTk/90s8aSx2L1n/goH/0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=U4UpwD2xrPVKew0W8dxBUYqRGkGir4hSnxx1qfqnyfU1fzDBsDXynDh15r2gg6uPz
 aeUkmkogAArZfBjaXPfpiFujWvQUApdF7019GMc7FgoRKOge6Dcw64w/KlM8HSjF7B
 Fpx76j/8APAU8kYpBWavrSY2zquueYWjQaZs6iAtZOmdGPhVJGswIqfRTnk+Z1oS1C
 QMRvVAz90MnelrtVEN1fsPPY9C0WgHlgk4FEHMxqlTsRwKhUUD9PORy3Zo89DDkKQK
 5/SCa87yG76r6A90SnQNwkXhm2F8mlV3hq2A7gqRsaZ6xGE9l9CNGR8Zz27l3IquU8
 Og84igIh1toyw==
Received: from localhost ([::1]) by mail.kernel.org with esmtp (Exim 4.99.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vjHKS-000000063Kl-2F08; Fri, 23 Jan 2026 14:36:00 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v2 12/13] scripts/ghes_inject: print help if no command
 specified
Date: Fri, 23 Jan 2026 14:35:26 +0100
Message-ID: <0e2aed0a0f04a9a575731aee95d373b0b54ab38b.1769175070.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769175069.git.mchehab+huawei@kernel.org>
References: <cover.1769175069.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31;
 envelope-from=mchehab+huawei@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.079,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The first positional argument (command) is mandatory. If not
specified, instead of a simple error message, show help as well.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/ghes_inject.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/ghes_inject.py b/scripts/ghes_inject.py
index 63a8b28002e7..dd2b34a64f15 100755
--- a/scripts/ghes_inject.py
+++ b/scripts/ghes_inject.py
@@ -52,6 +52,9 @@ def main():
         if not args.func(args):
             sys.exit(1)
     else:
+        print("Error: no command specified\n", file=sys.stderr)
+        parser.print_help(file=sys.stderr)
+        print(file=sys.stderr)
         sys.exit(f"Please specify a valid command for {sys.argv[0]}")
 
 if __name__ == "__main__":
-- 
2.52.0


