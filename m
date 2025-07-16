Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C192C83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 17:26:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc5t9-00036v-V1; Wed, 16 Jul 2025 13:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uc5t5-0002yR-J8
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 13:25:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uc5t0-00086c-8c
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 13:25:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752686740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FPUlDJRm3C4ZC75Wzw+UoTp2VLEQ+sxvcVRKb5M1UQ8=;
 b=gdGyWXNkpXjwoVadtAh4vrllP03RAIO0N5LHBhNvKvkMdHSEVr39voBxsPfR9HccXVkL7R
 jRBF9Gmhi+5JElStfBf0wSOUPIbk9ZQ29XXIgXMD19NhItdyhATKwbdTbrQV8dYSszqarz
 xRbPQrfa6/kuFUpz5uCQ6BNfE0FhGuM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-111-sGVv4119NWe1ELS8H5o4qg-1; Wed,
 16 Jul 2025 13:25:39 -0400
X-MC-Unique: sGVv4119NWe1ELS8H5o4qg-1
X-Mimecast-MFC-AGG-ID: sGVv4119NWe1ELS8H5o4qg_1752686738
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B1FFE1800292; Wed, 16 Jul 2025 17:25:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1A07819373D8; Wed, 16 Jul 2025 17:25:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6C97321E675E; Wed, 16 Jul 2025 19:25:35 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Akihiko Odaki <akihiko.odaki@daynix.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PULL 4/6] docs: Bump sphinx to 6.2.1
Date: Wed, 16 Jul 2025 19:25:33 +0200
Message-ID: <20250716172535.3520175-5-armbru@redhat.com>
In-Reply-To: <20250716172535.3520175-1-armbru@redhat.com>
References: <20250716172535.3520175-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Message-ID: <20250715212848.171879-2-jsnow@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/requirements.txt | 4 ++--
 pythondeps.toml       | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/docs/requirements.txt b/docs/requirements.txt
index 02583f209a..87f7afcb2e 100644
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
index 7884ab521d..b2eec940ce 100644
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
2.49.0


