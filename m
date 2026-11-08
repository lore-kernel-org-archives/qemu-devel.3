Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3146C606A320
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 08:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eoo2lLmT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPyfh-000392-2r; Sun, 08 Nov 2026 03:54:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1xPyfe-00037T-69
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 03:54:38 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1xPyfc-0000vb-GI
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 03:54:37 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2AE3F43DDA;
 Sun,  8 Nov 2026 08:54:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A9DB1F008A5;
 Sun,  8 Nov 2026 08:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794128075;
 bh=Ix9yM4d5Xtx+niZfRaYVX3/vvAStkIgt4uKxhLjOfgY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=eoo2lLmTSIn1x9Pa8JnTvSSuv9J8xJhjqx8ctAGTnrSwmKL7b7sUdDC7crMYy83uh
 WzYmmQZHVoyJMW7LSqSTJ2tofEl7MyWaIrKoT3JKeQ1DhO35CQwkaaJ76EFyh86F6h
 0gO0zAauta0HgwZpwlEDud7sTP9MaWlTPDCt2BNcBCAgeEHNMhv7L2lHoUdz4XPvh1
 FSH3CA0PmWfS874iWDpVGrtNslL0eTUNG+kqu4+antHQ9c4UGI2Fe4x96An429y4Yv
 KT2bziTqp3oORwwQWeHimabuvQtj1vs73VwG+gF+Au/RfiQ2D4p7WtLJKgJ7FV3Nw7
 MDA2mZTuCfulQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.100.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1xPyfZ-00000005Uj5-1T7b; Sun, 08 Nov 2026 09:54:33 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Michael S Tsirkin <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-edac@vger.kernel.org, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>,
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH 07/13] scripts/ghes_inject: exit 1 if command was not sent
Date: Sun,  8 Nov 2026 09:54:20 +0100
Message-ID: <0f4a1190c7ca0d89aca378130eb892265b52e54a.1794127710.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794127710.git.mchehab+huawei@kernel.org>
References: <cover.1794127710.git.mchehab+huawei@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=mchehab+huawei@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
2.56.0


