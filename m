Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C9EFD45E5
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 19:39:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvKj5-0007pa-RO; Wed, 25 Feb 2026 14:39:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vvKj1-0007od-FY
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 14:39:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vvKiz-0001sS-SX
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 14:39:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772048349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/0mPiy+0iiFSz1z1ujMFJR4cgSE3YBUuiBiwRtiSapg=;
 b=Pd5bovUu6rqoMI5BUjGTyjOezZaRQp4UubpkmCgmRxT+0OXzG2n9UbR/pURIsCrHiP2+oQ
 R0cO0pqacak438RkwLuB+cUtKBIFqXP1Okrny2FXII08hGkF+uYoahFCU7klYovZztrQxF
 KA6W8o2CP+juqwbczNv2iQZ6PaWb1oc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-304-js_H-syyP0eJZmxyHnd_HQ-1; Wed,
 25 Feb 2026 14:39:07 -0500
X-MC-Unique: js_H-syyP0eJZmxyHnd_HQ-1
X-Mimecast-MFC-AGG-ID: js_H-syyP0eJZmxyHnd_HQ_1772048346
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BD5A9195608A; Wed, 25 Feb 2026 19:39:06 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.89.212])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4B5831800671; Wed, 25 Feb 2026 19:39:04 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 3/3] python: upgrade minimum setuptools/wheel/pip versions
Date: Wed, 25 Feb 2026 14:38:56 -0500
Message-ID: <20260225193856.959771-4-jsnow@redhat.com>
In-Reply-To: <20260225193856.959771-1-jsnow@redhat.com>
References: <20260225193856.959771-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
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

With Debian 11 tests removed from our CI suite, we are allowed to rely
on the versions present in CentOS Stream 9 as a new minimum.

Note that CentOS Stream 9 does offer Python 3.12 packages, but mandating
this incurs the loss of ability to build offline documentation on CentOS
because there is no official Sphinx package for Python 3.12. We will
very likely mandate these upgraded packages for QEMU 11.1, but there is
no real benefit to doing it now for 11.0 - It will be simpler to perform
that upgrade after QEMU drops support for Ubuntu 22.04 LTS in late
April.

See
https://gitlab.com/jsnow/repology-dashboard#results-overview-as-of-2026-02-16
for more details on current Python ecosystem versions across all of our
supported build platforms.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/tests/minreqs.txt |  1 +
 pythondeps.toml          | 18 ++++++++++--------
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/python/tests/minreqs.txt b/python/tests/minreqs.txt
index 855b5129c94..6fc671b1780 100644
--- a/python/tests/minreqs.txt
+++ b/python/tests/minreqs.txt
@@ -16,6 +16,7 @@
 # installation of the QEMU package itself fails, failing to find
 # setuptools.
 setuptools<=70
+wheel==0.36.2
 
 # Dependencies for qapidoc/qapi_domain et al
 sphinx==3.4.3
diff --git a/pythondeps.toml b/pythondeps.toml
index a0717742423..c843f163a8f 100644
--- a/pythondeps.toml
+++ b/pythondeps.toml
@@ -38,14 +38,16 @@ sphinx_rtd_theme = { accepted = ">=0.5", installed = "1.2.2" }
 [tooling]
 "qemu.qmp" = { accepted = ">=0.0.5", installed = "0.0.5" }
 "qemu" = { path = "python/" }
-# NB: The following dependencies should be a little bit more modern than
-# the versions listed here, but we are still using Debian 11 for several
-# GitLab CI tests, so we are further restricted.
-"setuptools" = { accepted = ">=44.1.1" }
-"wheel" = { accepted = ">=0.34.2" }
-# pip should be guaranteed by mkvenv, this is merely a sanity check for
-# which version we are counting on being present.
-"pip" = { accepted = ">=20.3.4" }
+# These dependencies largely serve as sanity checks and a place to
+# record our current accepted minimum versions of various python
+# packaging modules; in offline mode, the absence of these modules will
+# cause configure to fail.
+#
+# We are currently constrained by CentOS Stream 9.
+"setuptools" = { accepted = ">=53.0.0" }
+"wheel" = { accepted = ">=0.36.2" }
+# Guaranteed by mkvenv, sanity-check only
+"pip" = { accepted = ">=21.3.1" }
 
 # This test group is for functional tests, and can include dependencies
 # fetched from PyPI.
-- 
2.53.0


