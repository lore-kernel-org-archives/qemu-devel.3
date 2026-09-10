Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F71AC79FB9
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 11:46:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4dDt-0003Lo-Fw; Thu, 10 Sep 2026 07:45:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.eu>) id 1x4dDr-0003Kn-RV
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 07:45:43 -0400
Received: from mout01.posteo.de ([185.67.36.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.eu>) id 1x4dDq-0000QY-2h
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 07:45:43 -0400
Received: from submission (posteo.de [185.67.36.169]) 
 by mout01.posteo.de (Postfix) with ESMTPS id 9EAA1240028
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:45:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.eu;
 s=1984.8680eb; t=1789040740;
 bh=Vin2HBUNP+S+M/KkGzqLeQOdbJgwA44YGEEJCVAJRtk=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
 Content-Transfer-Encoding:From;
 b=gP4QFgAo/bguPGk+alhZq8fkXWQb3OQie3JmUugUGpWh/GMRIMbryCseWJQuiMBIF
 13YOGInnBnT6LIi5PsNC9i2ncL88Xh6zWdrg79HYzfwRrTFVLQRnc1WbueFfMEdQlo
 JnWIWe7UlY0p1GCrMLAA8jNsw/sdF5sv/FM64RTsReJqrXRdcKEkV/GNQUgGzOH0/J
 KL0ntlG9ivEIIAL/1azLl6VqeoitxqYHb0XfCPA/FpDy0xiCyJkL8m0jUqT83TEIJu
 qCmKnujwOUOi/kGuBM0HErVS/GZUXrjCdK1e0JoUWLuAqMFGq4fSm+qhz6Ry1aGBf1
 gUIaA+WxFB3bQ==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4hgbTb6mT2z6v1d;
 Thu, 10 Sep 2026 13:45:39 +0200 (CEST)
From: Thomas Huth <th.huth@posteo.eu>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PULL 5/7] tests: install pylint for functional linters
Date: Thu, 10 Sep 2026 11:45:40 +0000
Message-ID: <20260910114522.396396-6-th.huth@posteo.eu>
In-Reply-To: <20260910114522.396396-1-th.huth@posteo.eu>
References: <20260910114522.396396-1-th.huth@posteo.eu>
MIME-Version: 1.0
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

From: Brian Cain <brian.cain@oss.qualcomm.com>

The functional linter test otherwise imports the system pylint 2.12.2.
On my system w/Python 3.12, its wrapt dependency would fail with:

    ImportError: cannot import name 'formatargspec' from 'inspect'

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
Message-ID: <20260908193656.2787108-1-brian.cain@oss.qualcomm.com>
Signed-off-by: Thomas Huth <th.huth@posteo.eu>
---
 pythondeps.toml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/pythondeps.toml b/pythondeps.toml
index afb1364dd2..d2f62e7aaf 100644
--- a/pythondeps.toml
+++ b/pythondeps.toml
@@ -48,3 +48,4 @@ sphinx_rtd_theme = { accepted = ">=1.2.2", installed = "2.0.0" }
 # fetched from PyPI.
 [functests]
 pygdbmi = { accepted = ">=0.11.0.0", installed = "0.11.0.0" }
+pylint = { accepted = ">=3.0.0", installed = "3.0.0" }
-- 
2.55.0


