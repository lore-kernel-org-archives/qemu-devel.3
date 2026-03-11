Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E8DA1125841
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 15:02:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0L5E-0004RJ-Mb; Wed, 11 Mar 2026 11:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0L4y-0004Od-Nx; Wed, 11 Mar 2026 11:02:32 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0L4x-0003jg-3z; Wed, 11 Mar 2026 11:02:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773241303; bh=0uZ5ATjhIzDgyacoMi6E796UKRKgVRPT0yaUj1O9yhM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=FN5vCu3Yrcznhlv9865CAfNj71vWdBvKov9p1S28oAigNNN5HJJdNnAcbCrfPu0PV
 loakVqQT3/5AqmzvdPlhYc58h//XxTVAVhs/ciA1FhQ9ddO84JKa/09B23mKEc/Lh+
 wN4i6xzAx77QZirx6nVl1s++Guto5wu5c7Fljy9ntT8/tW7O4vKwQZvU7JUMEhGNdg
 CGY3b5ykshqgmxbQzrSbfgAyMyO4DDBApKf1hqXnwmHDgIDtzXkt8j4LylM9B7Tir5
 ThmPQJJdzp7yk7AikA2oZSkWT3ltW5tlg1wCVima99B9ImV9i+ZrBP+ZArF1B9DK+B
 Var59tR+UB1yg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 605A7191E41;
 Wed, 11 Mar 2026 18:01:43 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3EB9B37C293;
 Wed, 11 Mar 2026 18:02:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, John Snow <jsnow@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.9 03/44] python: drop uses of pkg_resources
Date: Wed, 11 Mar 2026 18:01:35 +0300
Message-ID: <20260311150221.1084186-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.9-20260311180113@cover.tls.msk.ru>
References: <qemu-stable-10.0.9-20260311180113@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: John Snow <jsnow@redhat.com>

pkg_resources has been fully dropped from modern pip/setuptools
distributions and we should phase out its use. This patch is enough to,
by itself, repair most GitLab CI tests upstream; with the exception of
tox tests which are still making use of avocado - which will be dropped
in a separate series to restore functionality there.

Signed-off-by: John Snow <jsnow@redhat.com>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20260211195804.135144-3-jsnow@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit e44a26ba940214824b61976324058e73d9f41658)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/python/setup.py b/python/setup.py
index c5bc45919a..789fa39b0f 100755
--- a/python/setup.py
+++ b/python/setup.py
@@ -7,7 +7,6 @@
 import setuptools
 from setuptools.command import bdist_egg
 import sys
-import pkg_resources
 
 
 class bdist_egg_guard(bdist_egg.bdist_egg):
@@ -30,9 +29,6 @@ def main():
     QEMU tooling installer
     """
 
-    # https://medium.com/@daveshawley/safely-using-setup-cfg-for-metadata-1babbe54c108
-    pkg_resources.require('setuptools>=39.2')
-
     setuptools.setup(cmdclass={'bdist_egg': bdist_egg_guard})
 
 
-- 
2.47.3


