Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B061CC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 13:06:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh7zj-0007H4-8M; Mon, 04 Mar 2024 08:04:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rh7zQ-0006vh-K7
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 08:04:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rh7zO-0001JA-1t
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 08:04:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709557449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=TUyA7fKH/nKtjBaT+gvwBXdJlE67N+fsa5o5MIECjw0=;
 b=KJ41h4G+t+K238Q8Lf5ObYlDD7Rw1Wayu/NZZ+12q8fEd7JVbB2gPygdIoLXD3uKmdy0aW
 ldtmHeylK4d1xDslhIUkUhtkBJi0qrl+8VG6iYtdJaos/pCSJclRttX59cHz0m0yBOk9tX
 nbIKoyX7SgTfgHoz3lztU9LKy/7xGcw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-xU8dRY1ENcmDxQZLUrpSeQ-1; Mon, 04 Mar 2024 08:04:06 -0500
X-MC-Unique: xU8dRY1ENcmDxQZLUrpSeQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DDCF485A58E;
 Mon,  4 Mar 2024 13:04:05 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 758B6492BE2;
 Mon,  4 Mar 2024 13:04:04 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2] docs/conf.py: Remove usage of distutils
Date: Mon,  4 Mar 2024 14:04:03 +0100
Message-ID: <20240304130403.129543-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The macOS jobs in our CI recently started failing, complaining that
the distutils module is not available anymore. And indeed, according to
https://peps.python.org/pep-0632/ it's been deprecated since a while
and now likely got removed in recent Python versions.

Fortunately, we only use it for a version check via LooseVersion here
which we don't really need anymore - according to Repology.org, these
are the versions of sphinx-rtd-theme that are currently used by the
various distros:

 centos_stream_8: 0.3.1
 centos_stream_9: 0.5.1
 fedora_38: 1.1.1
 fedora_39: 1.2.2
 freebsd: 1.0.0
 haikuports_master: 1.2.1
 openbsd: 1.2.2
 opensuse_leap_15_5: 0.5.1
 pkgsrc_current: 2.0.0
 debian_11: 0.5.1
 debian_12: 1.2.0
 ubuntu_20_04: 0.4.3
 ubuntu_22_04: 1.0.0
 ubuntu_24_04: 2.0.0

So except for CentOS 8, all distros are using a newer version of
sphinx-rtd-theme, and for CentOS 8 we don't support compiling with
the Sphinx of the distro anymore anyway, since it's based on the
Python 3.6 interpreter there. For compiling on CentOS 8, you have
to use the alternative Python 3.8 interpreter which comes without
Sphinx, so that needs the Sphinx installed via pip in the venv
instead, and that is using a newer version, too, according to our
pythondeps.toml file.

Thus we can simply drop the version check now to get rid of the
distutils dependency here.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Updated the commit description (it's about sphinx-rtd-theme,
     not the Sphinx program itself)

 docs/conf.py | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/docs/conf.py b/docs/conf.py
index e84a95e71c..1b2afa241c 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -29,7 +29,6 @@
 import os
 import sys
 import sphinx
-from distutils.version import LooseVersion
 from sphinx.errors import ConfigError
 
 # The per-manual conf.py will set qemu_docdir for a single-manual build;
@@ -165,11 +164,10 @@
 # Theme options are theme-specific and customize the look and feel of a theme
 # further.  For a list of options available for each theme, see the
 # documentation.
-if LooseVersion(sphinx_rtd_theme.__version__) >= LooseVersion("0.4.3"):
-    html_theme_options = {
-        "style_nav_header_background": "#802400",
-        "navigation_with_keys": True,
-    }
+html_theme_options = {
+    "style_nav_header_background": "#802400",
+    "navigation_with_keys": True,
+}
 
 html_logo = os.path.join(qemu_docdir, "../ui/icons/qemu_128x128.png")
 
-- 
2.44.0


