Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE1C3C5DF94
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 05:16:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyjV7-0002Lw-Hx; Tue, 25 Aug 2026 01:15:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wyjV6-0002Li-IR
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 01:15:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wyjV5-0004ml-3p
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 01:15:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787634906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BZZI4Q6V28Uy048tgQvzEvLiY7Zjt5o3fwG+Seo3N9U=;
 b=GTGyelH5jaqlm3XJAnW9zW6zsWb91RjR4lAK+FCZE0stN8U6140p+pfPHhGufB3KCBJ9aV
 Bo9NDXqtTyHuqbhTTOMSCQGDwHKMMiW7FE61sUr8eGj1gp4HcViJAemewtlQV/3kOA9gb0
 DjrGjuTcpnQKpbP8POR047ZdGb8hhGk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-9C6aNDoyMv-MThyMWsbvOw-1; Tue,
 25 Aug 2026 01:14:59 -0400
X-MC-Unique: 9C6aNDoyMv-MThyMWsbvOw-1
X-Mimecast-MFC-AGG-ID: 9C6aNDoyMv-MThyMWsbvOw_1787634898
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 69A2C1953994; Tue, 25 Aug 2026 05:14:57 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.56])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 30F5D1955F76; Tue, 25 Aug 2026 05:14:52 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Warner Losh <imp@bsdimp.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Reinoud Zandijk <reinoud@netbsd.org>, Kyle Evans <kevans@freebsd.org>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH v2 02/16] tests: update FreeBSD dependencies
Date: Tue, 25 Aug 2026 01:14:27 -0400
Message-ID: <20260825051441.1562454-3-jsnow@redhat.com>
In-Reply-To: <20260825051441.1562454-1-jsnow@redhat.com>
References: <20260825051441.1562454-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

FreeBSD has dropped Python3.11, now defaulting to Python3.12+; upgrade
the names of the various dependencies to match.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/lcitool/mappings.yml      |  9 +++++++++
 tests/vm/generated/freebsd.json | 12 ++++++------
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/tests/lcitool/mappings.yml b/tests/lcitool/mappings.yml
index 1816556dde4..afe52455235 100644
--- a/tests/lcitool/mappings.yml
+++ b/tests/lcitool/mappings.yml
@@ -11,21 +11,29 @@ mappings:
 
   python3-pip:
     CentOSStream9: python3.11-pip
+    FreeBSD: py312-pip
 
   python3-setuptools:
     CentOSStream9: python3.11-setuptools
+    FreeBSD: py312-setuptools
 
   python3-sphinx:
     CentOSStream9:
+    FreeBSD: py312-sphinx
 
   python3-sphinx-rtd-theme:
     CentOSStream9:
+    FreeBSD: py312-sphinx_rtd_theme
 
   python3-venv:
     CentOSStream9: python3.11
 
   python3-wheel:
     CentOSStream9: python3.11-wheel
+    FreeBSD: py312-wheel
+
+  python3-numpy:
+    FreeBSD: py312-numpy
 
   meson:
     # Use Meson from PyPI wherever Rust is enabled
@@ -38,6 +46,7 @@ mappings:
     apk:
     Fedora:
     Debian12:
+    FreeBSD: py312-tomli
 
   rust:
     Debian12: rustc-web
diff --git a/tests/vm/generated/freebsd.json b/tests/vm/generated/freebsd.json
index dfa8b41a524..ee3402f0d2b 100644
--- a/tests/vm/generated/freebsd.json
+++ b/tests/vm/generated/freebsd.json
@@ -52,12 +52,12 @@
     "pixman",
     "pkgconf",
     "png",
-    "py311-pip",
-    "py311-setuptools",
-    "py311-sphinx",
-    "py311-sphinx_rtd_theme",
-    "py311-tomli",
-    "py311-wheel",
+    "py312-pip",
+    "py312-setuptools",
+    "py312-sphinx",
+    "py312-sphinx_rtd_theme",
+    "py312-tomli",
+    "py312-wheel",
     "python3",
     "rpm2cpio",
     "rust",
-- 
2.55.0


