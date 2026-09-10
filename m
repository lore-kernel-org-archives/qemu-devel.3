Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EABEC88E42
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 11:46:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4dDu-0003M0-0H; Thu, 10 Sep 2026 07:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.eu>) id 1x4dDs-0003Ks-2Z
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 07:45:44 -0400
Received: from mout01.posteo.de ([185.67.36.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.eu>) id 1x4dDq-0000QS-F5
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 07:45:43 -0400
Received: from submission (posteo.de [185.67.36.169]) 
 by mout01.posteo.de (Postfix) with ESMTPS id 0F3B6240029
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:45:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.eu;
 s=1984.8680eb; t=1789040740;
 bh=Q746dd0StghLEbGririTRZgWrzTNJ5HqC0nLAX4uouo=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding:From;
 b=e1+drc/mtX/fWH3GE+Yxwrv9iNYEFRbawvrLeXpebgSZ5fn73xr39wCW1CqdBRmt9
 pprqRz/R9+PiYNcJBGZI8VRDtx3PMZKbKSmeVYq0kvk/Tss7maQEpVlfFdvE5cHKFa
 XIxM/t0fn5oClKFikAEbvI9QNTFiVzvjYFQdasSfOmffuN/FY8kJfRrNQA9q9r0WH+
 MRwRPmp1FG9i6gVa7ah4NuOFPQOQu9xk/ChXaEEMWoaxP0YLv6Sm1P3eNrdOaqptMo
 GhqYfcOM3PFjgo7a7LhZTMLGLTQYOp9KAhL9dxPGt6pui7QW7kcjOOoh0CVKrT2Img
 PpdBG4SfcKsOA==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4hgbTZ6kN1z6v2J;
 Thu, 10 Sep 2026 13:45:38 +0200 (CEST)
From: Thomas Huth <th.huth@posteo.eu>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 4/7] scripts/clean_functional_cache: Remove also .stamp files
Date: Thu, 10 Sep 2026 11:45:39 +0000
Message-ID: <20260910114522.396396-5-th.huth@posteo.eu>
In-Reply-To: <20260910114522.396396-1-th.huth@posteo.eu>
References: <20260910114522.396396-1-th.huth@posteo.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.67.36.65; envelope-from=th.huth@posteo.eu;
 helo=mout01.posteo.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The cache cleanup script already successfully removes the assets
that are unused since more than 6 months, but it forgot to delete
the corresponding timestamp files, too.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20260814122643.312129-1-thuth@redhat.com>
Signed-off-by: Thomas Huth <th.huth@posteo.eu>
---
 scripts/clean_functional_cache.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/clean_functional_cache.py b/scripts/clean_functional_cache.py
index c3370ffbb8..1ff98c7606 100755
--- a/scripts/clean_functional_cache.py
+++ b/scripts/clean_functional_cache.py
@@ -28,8 +28,9 @@
     if len(file.name) != 64:
         continue
 
+    stampfile = file.with_suffix(".stamp")
     try:
-        timestamp = int(file.with_suffix(".stamp").read_text())
+        timestamp = int(stampfile.read_text())
     except FileNotFoundError:
         # Assume it's an old file that was already in the cache before we
         # added the code for evicting stale assets. Use the release date
@@ -43,3 +44,4 @@
         print(f"Removing {cache_dir}/{file.name}.")
         file.chmod(stat.S_IWRITE)
         file.unlink()
+        stampfile.unlink()
-- 
2.55.0


