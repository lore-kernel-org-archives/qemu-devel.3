Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 890CAC5DF9B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:30:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNFz-0001xM-Ml; Mon, 24 Aug 2026 01:30:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wyNFo-0001IZ-3b
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:29:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wyNFm-0006nj-FH
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:29:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787549389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xQBxgguTk8og/3EgPgo+BeQOhwuulR6uouJ3UXzYXxA=;
 b=dahFpsIxi4jYyNbwi8z7IXRkHReW9Mt/7cSMryv4nkut6Cubwra+57hJ1YUQ1gP1l0vKH7
 HbSEjFmkq1KkQzEvTlGhrtFGvk714yBUgB3hm25ybqxo08xn+n/7pq275UgrOy4831pQSA
 7CG8Osetjkn0qgmBxal5A7XzN17ZEqw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-223-TKI1udwUOyCrHbVGEk_ZEw-1; Mon,
 24 Aug 2026 01:29:45 -0400
X-MC-Unique: TKI1udwUOyCrHbVGEk_ZEw-1
X-Mimecast-MFC-AGG-ID: TKI1udwUOyCrHbVGEk_ZEw_1787549383
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A2B2B1964CC5; Mon, 24 Aug 2026 05:29:43 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.29])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E07571800577; Mon, 24 Aug 2026 05:29:40 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Cleber Rosa <crosa@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH 10/12] sphinx: require sphinx 7.2.6
Date: Mon, 24 Aug 2026 01:28:56 -0400
Message-ID: <20260824052859.880475-11-jsnow@redhat.com>
In-Reply-To: <20260824052859.880475-1-jsnow@redhat.com>
References: <20260824052859.880475-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Make the extraordinary leap from Sphinx 3.4.3 to Sphinx
7.2.6. Simplifications and cleanup will follow in subsequent patches.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/conf.py             |  4 ++--
 python/setup.cfg         |  2 +-
 python/tests/minreqs.txt | 29 ++++++++++++++++-------------
 pythondeps.toml          |  4 ++--
 4 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/docs/conf.py b/docs/conf.py
index 7e35d2158d3..cded047b539 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -51,9 +51,9 @@
 
 # If your documentation needs a minimal Sphinx version, state it here.
 #
-# 3.4.3 is the oldest version of Sphinx that ships on a platform we
+# 7.2.6 is the oldest version of Sphinx that ships on a platform we
 # pledge build support for.
-needs_sphinx = '3.4.3'
+needs_sphinx = '7.2.6'
 
 # Add any Sphinx extension module names here, as strings. They can be
 # extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
diff --git a/python/setup.cfg b/python/setup.cfg
index ebb4230899c..927f72a46f6 100644
--- a/python/setup.cfg
+++ b/python/setup.cfg
@@ -41,7 +41,7 @@ devel =
     pylint >= 2.17.3
     pytest >= 6.2.4
     tox >= 3.18.0
-    sphinx >= 3.4.3
+    sphinx >= 7.2.6
 
 # Provides qom-fuse functionality
 fuse =
diff --git a/python/tests/minreqs.txt b/python/tests/minreqs.txt
index 85cfa08cf76..7154ad40040 100644
--- a/python/tests/minreqs.txt
+++ b/python/tests/minreqs.txt
@@ -12,7 +12,7 @@
 # on PyPI that allows the test suite to pass.
 
 # Dependencies for qapidoc/qapi_domain et al
-sphinx==3.4.3
+sphinx==7.2.6
 
 # Dependencies for qemu.machine
 qemu.qmp==0.0.6
@@ -48,23 +48,26 @@ platformdirs==2.2.0
 tomlkit==0.10.1
 
 # Transitive sphinx dependencies
-Jinja2==2.7
-MarkupSafe==1.1.0
 alabaster==0.7.1
-babel==1.3
-docutils==0.12
-imagesize==0.5.0
-packaging==14.0
-Pygments==2.0
-pytz==2014.9
-requests==2.5.0
-snowballstemmer==1.1
+babel==2.9
+certifi==2023.5.7
+charset-normalizer==2.0.0
+docutils==0.18.1
+idna==2.5
+imagesize==1.3
+Jinja2==3.0.0
+MarkupSafe==2.0
+packaging==21.0
+Pygments==2.14
+requests==2.25.0
+snowballstemmer==2.0
 sphinxcontrib-applehelp==1.0.0
 sphinxcontrib-devhelp==1.0.0
-sphinxcontrib-htmlhelp==1.0.0
+sphinxcontrib-htmlhelp==2.0.0
 sphinxcontrib-jsmath==1.0.0
 sphinxcontrib-qthelp==1.0.0
-sphinxcontrib-serializinghtml==1.0.0
+sphinxcontrib-serializinghtml==1.1.9
+urllib3==1.26
 
 # Transitive pytest dependencies
 attrs==19.2.0
diff --git a/pythondeps.toml b/pythondeps.toml
index b1879c1a4da..f0f3af915a1 100644
--- a/pythondeps.toml
+++ b/pythondeps.toml
@@ -28,8 +28,8 @@ meson = { accepted = ">=1.12.0", installed = "1.12.0", canary = "meson" }
 
 [docs]
 # Please keep the installed versions in sync with docs/requirements.txt
-sphinx = { accepted = ">=3.4.3", installed = "6.2.1", canary = "sphinx-build" }
-sphinx_rtd_theme = { accepted = ">=0.5", installed = "1.2.2" }
+sphinx = { accepted = ">=7.2.6", installed = "7.2.6", canary = "sphinx-build" }
+sphinx_rtd_theme = { accepted = ">=1.2.2", installed = "1.2.2" }
 
 # This test group is for dependencies required to run various tooling
 # and tests that should always be installed at configure time. It should
-- 
2.55.0


