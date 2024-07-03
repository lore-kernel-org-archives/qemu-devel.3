Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C21C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 17:53:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP4A0-0003GW-MF; Wed, 03 Jul 2024 13:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sP49y-0003Fm-0c
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 13:52:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sP49t-0001FV-I5
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 13:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720029163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hbUF5STjPhudok6L+kadEXL4R3JWf7aZ4r35ysDd58g=;
 b=TN4lAo2nznU5wHS7diszmkOeRtrTLVS1eemgtDu/ibH93fpbIfI5ejNJRb9jpd6z2zbG2z
 bXfRbTM2G2SCT1LxMm9a2wIQSRipvPuzNyKsjhjCpCIQqZybjr0qYxoVAoUYcQB0/YbGKT
 uKL/xDLMrrsKvwY1Ta9e6dI0OYLCPCs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-sFCXjGzAN9uBUPsmZqOnug-1; Wed,
 03 Jul 2024 13:52:41 -0400
X-MC-Unique: sFCXjGzAN9uBUPsmZqOnug-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AC48F1955BD0; Wed,  3 Jul 2024 17:52:40 +0000 (UTC)
Received: from scv.localdomain (unknown [10.22.34.31])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C7F9B1955BC1; Wed,  3 Jul 2024 17:52:37 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 1/2] Python: bump minimum sphinx version to 3.4.3
Date: Wed,  3 Jul 2024 13:52:34 -0400
Message-ID: <20240703175235.239004-2-jsnow@redhat.com>
In-Reply-To: <20240703175235.239004-1-jsnow@redhat.com>
References: <20240703175235.239004-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

With RHEL 8 support retired (It's been two years since RHEL9 released),
our very oldest build platform version of Sphinx is now 3.4.3; and
keeping backwards compatibility for versions as old as v1.6 when using
domain extensions is a lot of work we don't need to do.

This patch is motivated by my work creating a new QAPI domain, which
unlike the dbus documentation, cannot be allowed to regress by creating
a "dummy" doc when operating under older sphinx versions. Easier is to
raise our minimum version as far as we can push it forwards, reducing my
burden in creating cross-compatibility hacks and patches.

A sampling of sphinx versions from various distributions, courtesy
https://repology.org/project/python:sphinx/versions

Alpine 3.16: v4.3.0 (QEMU support ended 2024-05-23)
Alpine 3.17: v5.3.0
Alpine 3.18: v6.1.3
Alpine 3.19: v6.2.1
Ubuntu 20.04 LTS: EOL
Ubuntu 22.04 LTS: v4.3.2
Ubuntu 22.10: EOL
Ubuntu 23.04: EOL
Ubuntu 23.10: v5.3.0
Ubuntu 24.04 LTS: v7.2.6
Debian 11: v3.4.3 (QEMU support ends 2024-07-xx)
Debian 12: v5.3.0
Fedora 38: EOL
Fedora 39: v6.2.1
Fedora 40: v7.2.6
CentOS Stream 8: v1.7.6 (QEMU support ended 2024-05-17)
CentOS Stream 9: v3.4.3
OpenSUSE Leap 15.4: EOL
OpenSUSE Leap 15.5: 2.3.1, 4.2.0 and 7.2.6

RHEL9 / CentOS Stream 9 becomes the new defining factor in staying at
Sphinx 3.4.3 due to downstream offline build requirements that force us
to use platform Sphinx instead of newer packages from PyPI.

Signed-off-by: John Snow <jsnow@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
---
 docs/conf.py    | 7 +++----
 pythondeps.toml | 2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/docs/conf.py b/docs/conf.py
index aae0304ac6e..876f6768815 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -53,10 +53,9 @@
 
 # If your documentation needs a minimal Sphinx version, state it here.
 #
-# Sphinx 1.5 and earlier can't build our docs because they are too
-# picky about the syntax of the argument to the option:: directive
-# (see Sphinx bugs #646, #3366).
-needs_sphinx = '1.6'
+# 3.4.3 is the oldest version of Sphinx that ships on a platform we
+# pledge build support for.
+needs_sphinx = '3.4.3'
 
 # Add any Sphinx extension module names here, as strings. They can be
 # extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
diff --git a/pythondeps.toml b/pythondeps.toml
index 9c16602d303..bc656376caa 100644
--- a/pythondeps.toml
+++ b/pythondeps.toml
@@ -23,7 +23,7 @@ meson = { accepted = ">=0.63.0", installed = "1.2.3", canary = "meson" }
 
 [docs]
 # Please keep the installed versions in sync with docs/requirements.txt
-sphinx = { accepted = ">=1.6", installed = "5.3.0", canary = "sphinx-build" }
+sphinx = { accepted = ">=3.4.3", installed = "5.3.0", canary = "sphinx-build" }
 sphinx_rtd_theme = { accepted = ">=0.5", installed = "1.1.1" }
 
 [avocado]
-- 
2.45.0


