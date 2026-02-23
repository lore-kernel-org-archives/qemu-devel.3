Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E32EA4FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 11:51:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuUSi-0004Tr-7V; Mon, 23 Feb 2026 06:50:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vuUSb-0004RI-11
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 06:50:45 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vuUSV-0004rq-Vh
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 06:50:43 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 2C7CC444BA;
 Mon, 23 Feb 2026 11:50:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B5E8C2BC9E;
 Mon, 23 Feb 2026 11:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771847434;
 bh=8uItO1tBCDK9cbJY1YqaD7Ae5ZOfPLv8XnCqS8/3E6M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Rj22aF4YxlsgP5Zmk2lHWR2E2KCDe6VreJ1F6sMc+uSB9cukA6wdwVDSG5IUXKBEY
 UPJzOjhLWJbxVnRwGuZ4WNCcW5KWheofCqfx225SEMWZeb69DW8yWPUgPoFoXS5c//
 UnjCOzGF6EBy14e4a+zA3gLCRe0ER+zQzJym3DCVXdpF/+2ip3lnBgFEUk0KGbvA2Z
 B61NarZrLEv5Wr3uJVyOuyxNJAlymLrezUeNCXB9Ni1yKQw4ns2zn4EqzBETlLL75E
 ltYCc+8DfU/eiFMnStsFfBGSg5jFSqdxwWY4epvfgyZ7v+NyZoFHoZRt+dF5y5sYwf
 dQj04W3v1t1fw==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vuUSO-00000007Jp3-15C4; Mon, 23 Feb 2026 12:50:32 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Michael S Tsirkin <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH v3 13/14] scripts/ghes_inject: print help if no command
 specified
Date: Mon, 23 Feb 2026 12:50:29 +0100
Message-ID: <1d5de20e8059de8749694e18430eacfcc3f409e7.1771847176.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1771847176.git.mchehab+huawei@kernel.org>
References: <cover.1771847176.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31;
 envelope-from=mchehab+huawei@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
index 781b37cc68af..4028fdb15582 100755
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
2.53.0


