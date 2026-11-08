Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1027F606A320
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 08:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QohK5BcM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPyfi-00039k-07; Sun, 08 Nov 2026 03:54:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1xPyff-00037k-C5
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 03:54:39 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1xPyfc-0000vZ-IG
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 03:54:39 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 344A2447D0;
 Sun,  8 Nov 2026 08:54:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 177151F008BE;
 Sun,  8 Nov 2026 08:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794128075;
 bh=emAvy/kX/TjT3XGP5DxuZXiiW4DHPqQScNtLSEVzPiE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=QohK5BcMi8EL9UJvuk2fa86xYKX7wfoRXuiiukk1/adOjfhNV1H348MHP2SrS1OR9
 cq92vUgGaiRHOKPc8nbX4wJC7SXG8Mk1wbPkmJg2/I56zLQJX0snT4LDnjk8dWJSny
 U6c+obfx1ZckdtCCYoNTgUVXXiUFiDGFQ7LuHgVtvk0Ih/1grvIResYO3gGDQhE6sK
 vGC1eUnk3Tu/cZvbG0s+nFphNwNrK0bZsxOVRFOyLellIlHzB31xqOVPxoRkoc943t
 q/LHTcPaXms5H8IAUa1TurRJ7WXXdQi/9wtzP5BoTgGoa9684QTELw+/IA/HmP4F4x
 lbfls1GdsO8EQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.100.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1xPyfZ-00000005Uje-1ttM; Sun, 08 Nov 2026 09:54:33 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Michael S Tsirkin <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-edac@vger.kernel.org, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>,
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH 11/13] scripts/ghes_inject: print help if no command specified
Date: Sun,  8 Nov 2026 09:54:24 +0100
Message-ID: <828f9cd2216a95d553222bf3563df0496fc0308d.1794127710.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794127710.git.mchehab+huawei@kernel.org>
References: <cover.1794127710.git.mchehab+huawei@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31;
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
2.56.0


