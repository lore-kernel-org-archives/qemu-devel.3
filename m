Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B880C79F9F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 11:46:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4dDs-0003Kw-4v; Thu, 10 Sep 2026 07:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.eu>) id 1x4dDr-0003K6-1X
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 07:45:43 -0400
Received: from mout02.posteo.de ([185.67.36.66])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.eu>) id 1x4dDp-0000QQ-Br
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 07:45:42 -0400
Received: from submission (posteo.de [185.67.36.169]) 
 by mout02.posteo.de (Postfix) with ESMTPS id F3D63240104
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:45:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.eu;
 s=1984.8680eb; t=1789040739;
 bh=7itZamryIBEt+T2mqHtq1aa014Cn0apam4dgqlafzsg=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding:From;
 b=Goj2ZjQT+oBdJNEJoK2n7XxZD73rsRusPmGP+g0PhO6xf8PnW+KyvgzT50FxUMKAZ
 5XpbzrFbvjb6zk51uv8/PYnQOerRssFwJGJHnr19l8VF8wxif2wpty5EGSxIfmmTPy
 DNE/piMlI06nD5Vq6haOSnUNgKZ1jenTG4f+PvMAH7UJN15nTNvixKsGyyYo19ERLD
 xS71FhTJhxSBVm7oJJhlR2I4yBk6YPdQfofrwUnllPF+QWBmv0ETZdnQ/JaVNwWCC8
 B2a9+G0KVc35Fahwr2DIK6QtnZCVpLiyR455hJ5fn5EzOn0/o9a+7JYhSjwAzIF4C+
 i+0QdoOQBTK1Q==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4hgbTZ18p2z6tsg;
 Thu, 10 Sep 2026 13:45:38 +0200 (CEST)
From: Thomas Huth <th.huth@posteo.eu>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 3/7] MAINTAINERS: Mark the next-cube machine as "Orphan"
Date: Thu, 10 Sep 2026 11:45:38 +0000
Message-ID: <20260910114522.396396-4-th.huth@posteo.eu>
In-Reply-To: <20260910114522.396396-1-th.huth@posteo.eu>
References: <20260910114522.396396-1-th.huth@posteo.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.67.36.66; envelope-from=th.huth@posteo.eu;
 helo=mout02.posteo.de
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

I never manage to get this machine to a fully usable state, and in the
course of time I also lost interest in this machine. Mark it as
"Orphan" to set expectations right and make place for somebody else
to take over.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260828095241.118458-4-th.huth@posteo.eu>
Signed-off-by: Thomas Huth <th.huth@posteo.eu>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7183babd6a..e9b68c51f1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1409,8 +1409,7 @@ F: include/hw/m68k/mcf*.h
 F: tests/functional/m68k/test_mcf5208evb.py
 
 NeXTcube
-M: Thomas Huth <th.huth+qemu@posteo.eu>
-S: Odd Fixes
+S: Orphan
 F: hw/m68k/next-*.c
 F: hw/display/next-fb.c
 F: include/hw/m68k/next-cube.h
-- 
2.55.0


