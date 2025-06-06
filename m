Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE5BC5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 20:50:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNe19-0000jI-KE; Fri, 06 Jun 2025 16:50:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uNe17-0000iE-4G
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 16:50:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uNe15-0006ot-8y
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 16:50:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749243018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E6EjVPsLrNhvnNwp1UJ0tdgE37dKoZfSM4H2nVcEoEg=;
 b=hCcyD3AhNM+mZgdH4mwXmLsJQmLJwdeQb7o+B3EBXH1IoIhIKU73QZJNF9YgWKJkEfnidX
 fibL6JWKHHfHMvIw5nx64XeRlINR+Xsec80bLOW6Zocfi9B+F5mzr3TMRHYmTOQxsRjZm2
 tEvUC/p/O+njRdrxxfsq0cM6QuleYWM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-142-QT5haPuSPUqYqEjskRxkCg-1; Fri,
 06 Jun 2025 16:50:15 -0400
X-MC-Unique: QT5haPuSPUqYqEjskRxkCg-1
X-Mimecast-MFC-AGG-ID: QT5haPuSPUqYqEjskRxkCg_1749243014
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4141E19560B5; Fri,  6 Jun 2025 20:50:14 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2725B30001B7; Fri,  6 Jun 2025 20:50:12 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Cleber Rosa <crosa@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 2/4] docs: Bump sphinx to 6.2.1
Date: Fri,  6 Jun 2025 16:50:07 -0400
Message-ID: <20250606205009.584615-3-jsnow@redhat.com>
In-Reply-To: <20250606205009.584615-1-jsnow@redhat.com>
References: <20250606205009.584615-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

sphinx 5.3.0 fails with Python 3.13.1:

../docs/meson.build:37: WARNING: /home/me/qemu/build/pyvenv/bin/sphinx-build:
Extension error:
Could not import extension sphinx.builders.epub3 (exception: No module named 'imghdr')

../docs/meson.build:39:6: ERROR: Problem encountered: Install a Python 3 version of python-sphinx and the readthedoc theme

Bump sphinx to 6.2.1 and also sphinx_rtd_theme as required for the new
sphinx version.

(jsnow note: this patch bumps the recommended version for Sphinx to
install when it is missing, but allows old versions to be used if they
are present and functional. The version used for building docs on
readthedocs is pinned to the recommended version, 6.2.1.)

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/requirements.txt | 4 ++--
 pythondeps.toml       | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/docs/requirements.txt b/docs/requirements.txt
index 02583f209aa..87f7afcb2e7 100644
--- a/docs/requirements.txt
+++ b/docs/requirements.txt
@@ -1,5 +1,5 @@
 # Used by readthedocs.io
 # Should be in sync with the "installed" key of pythondeps.toml
 
-sphinx==5.3.0
-sphinx_rtd_theme==1.1.1
+sphinx==6.2.1
+sphinx_rtd_theme==1.2.2
diff --git a/pythondeps.toml b/pythondeps.toml
index 7884ab521d1..b2eec940ce5 100644
--- a/pythondeps.toml
+++ b/pythondeps.toml
@@ -24,8 +24,8 @@ pycotap = { accepted = ">=1.1.0", installed = "1.3.1" }
 
 [docs]
 # Please keep the installed versions in sync with docs/requirements.txt
-sphinx = { accepted = ">=3.4.3", installed = "5.3.0", canary = "sphinx-build" }
-sphinx_rtd_theme = { accepted = ">=0.5", installed = "1.1.1" }
+sphinx = { accepted = ">=3.4.3", installed = "6.2.1", canary = "sphinx-build" }
+sphinx_rtd_theme = { accepted = ">=0.5", installed = "1.2.2" }
 
 [testdeps]
 qemu.qmp = { accepted = ">=0.0.3", installed = "0.0.3" }
-- 
2.48.1


