Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A025C61CE7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 20:50:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNe1B-0000jb-TT; Fri, 06 Jun 2025 16:50:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uNe17-0000iI-6E
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 16:50:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uNe14-0006oV-Ui
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 16:50:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749243015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GRhGqsdjHlcdtOThhMwkVpv7y+rIn5IxVqeOj32kKGs=;
 b=gSb2cr6JMSaeRxNjTgqCTDL9h7BDO3rK8hYuqbfV1KVFdop7DleFyMVNOXczE80qVM2ybT
 1kLRQe4lsyjuJlYehsQ/86kWr5WhqqXwWrXirT2alqhUEUp0/TpmrtQLViARYv8QoZcaCT
 dhmvI+3NkpwjZuxlzITCfmzC9juXf4w=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-114-G2qu1HA2MbKkqyoHvUMdxg-1; Fri,
 06 Jun 2025 16:50:14 -0400
X-MC-Unique: G2qu1HA2MbKkqyoHvUMdxg-1
X-Mimecast-MFC-AGG-ID: G2qu1HA2MbKkqyoHvUMdxg_1749243013
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C3CC9180047F; Fri,  6 Jun 2025 20:50:12 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C2E0430001B7; Fri,  6 Jun 2025 20:50:11 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Cleber Rosa <crosa@redhat.com>
Subject: [PATCH 1/4] python: update requirements for Sphinx
Date: Fri,  6 Jun 2025 16:50:06 -0400
Message-ID: <20250606205009.584615-2-jsnow@redhat.com>
In-Reply-To: <20250606205009.584615-1-jsnow@redhat.com>
References: <20250606205009.584615-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

In advance of actually bumping the build system requirements for Sphinx,
bump the version used for the static analysis tests. Update the minimum
requirements accordingly.

This changes the test environment without actually changing the build
requirements, and no extra changes are needed for the tests to continue
passing.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/setup.cfg         |  2 +-
 python/tests/minreqs.txt | 36 +++++++++++++++++++++---------------
 2 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/python/setup.cfg b/python/setup.cfg
index d7f5dc7bafe..dc9615c1173 100644
--- a/python/setup.cfg
+++ b/python/setup.cfg
@@ -46,7 +46,7 @@ devel =
     urwid >= 2.1.2
     urwid-readline >= 0.13
     Pygments >= 2.9.0
-    sphinx >= 3.4.3
+    sphinx >= 6.2.1
 
 # Provides qom-fuse functionality
 fuse =
diff --git a/python/tests/minreqs.txt b/python/tests/minreqs.txt
index cd2e2a81c3d..fd7ec40929b 100644
--- a/python/tests/minreqs.txt
+++ b/python/tests/minreqs.txt
@@ -11,19 +11,19 @@
 # When adding new dependencies, pin the very oldest non-yanked version
 # on PyPI that allows the test suite to pass.
 
-# For some reason, the presence of packaging==14.0 below requires us to
+# For some reason, the presence of packaging==21.0 below requires us to
 # also pin setuptools to version 70 or below. Otherwise, the
 # installation of the QEMU package itself fails, failing to find
 # setuptools.
 setuptools<=70
 
 # Dependencies for qapidoc/qapi_domain et al
-sphinx==3.4.3
+sphinx==6.2.1
 
 # Dependencies for the TUI addon (Required for successful linting)
 urwid==2.1.2
 urwid-readline==0.13
-Pygments==2.9.0
+Pygments==2.13.0
 
 # Dependencies for mkvenv
 distlib==0.3.6
@@ -55,24 +55,30 @@ astroid==2.15.4
 dill==0.2
 lazy-object-proxy==1.4.0
 platformdirs==2.2.0
-toml==0.10.0
 tomlkit==0.10.1
 wrapt==1.14.0
 
 # Transitive sphinx dependencies
-Jinja2==2.7
-MarkupSafe==1.1.0
+Jinja2==3.0
+MarkupSafe==2.0.0
 alabaster==0.7.1
-babel==1.3
-docutils==0.12
-imagesize==0.5.0
-packaging==14.0
-pytz==2011b0
-requests==2.5.0
-snowballstemmer==1.1
+babel==2.9
+certifi==2017.4.17
+chardet==3.0.2
+docutils==0.18.1
+idna==2.5
+imagesize==1.3
+importlib-metadata==4.8.1
+packaging==21.0
+pyparsing==2.0.2
+pytz==2015.7
+requests==2.25.0
+snowballstemmer==2.0
 sphinxcontrib-applehelp==1.0.0
 sphinxcontrib-devhelp==1.0.0
-sphinxcontrib-htmlhelp==1.0.0
+sphinxcontrib-htmlhelp==2.0.0
 sphinxcontrib-jsmath==1.0.0
 sphinxcontrib-qthelp==1.0.0
-sphinxcontrib-serializinghtml==1.0.0
+sphinxcontrib-serializinghtml==1.1.5
+urllib3==1.21.1
+zipp==0.5
-- 
2.48.1


