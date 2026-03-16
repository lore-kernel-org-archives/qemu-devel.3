Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07802F506D5
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 13:55:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w28Ox-0005lp-Lc; Mon, 16 Mar 2026 09:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w28Ot-0005ku-KB
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 09:54:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w28Oq-0000fV-Mn
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 09:54:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773669268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y090uhrTHum62iMfI/BuYM4x62iP/PIl9++PQtRPX0s=;
 b=BGxcWdvrjmmu6b4ZePliv5XYedzMR3zdStJ9SOVjtM9vl414nFH9ZQwz/BV9vNK4B9j885
 I55lC+1KMLhI2U5BTPTjzoxCwyfJ9lzUzYVqrYIo4j/EeGD+EHjRxzLYwtmXXqTf/4WJCB
 eSfZD5TcjLJKxeJi4vbU89v5ES1xNDo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-356-dpd48muJOI2iP_ZQFWGo7Q-1; Mon,
 16 Mar 2026 09:54:25 -0400
X-MC-Unique: dpd48muJOI2iP_ZQFWGo7Q-1
X-Mimecast-MFC-AGG-ID: dpd48muJOI2iP_ZQFWGo7Q_1773669264
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 88FA21955EA1; Mon, 16 Mar 2026 13:54:24 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.101])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C9B8419560B7; Mon, 16 Mar 2026 13:54:21 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 2/3] tests/lcitool: Update openSUSE to version 16
Date: Mon, 16 Mar 2026 14:54:06 +0100
Message-ID: <20260316135407.209072-3-thuth@redhat.com>
In-Reply-To: <20260316135407.209072-1-thuth@redhat.com>
References: <20260316135407.209072-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

From: Thomas Huth <thuth@redhat.com>

The first version of openSUSE 15 has been released in 2018, and
according to our support policy, we "support the most recent major
version at all times for up to five years after its initial release."

Since openSUSE 16 has been released a while ago, and openSUSE is
clearly older than 5 years already, it's time to update to version 16
now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 configure                  |  1 -
 tests/lcitool/mappings.yml | 58 --------------------------------------
 tests/lcitool/refresh      |  2 +-
 3 files changed, 1 insertion(+), 60 deletions(-)

diff --git a/configure b/configure
index cd1dadd8bb2..f3603fd9160 100755
--- a/configure
+++ b/configure
@@ -929,7 +929,6 @@ if ! check_py_version "$python"; then
   error_exit "Cannot use '$python', Python >= 3.9 is required." \
              "Use --python=/path/to/python to specify a supported Python." \
              "Maybe try:" \
-             "  openSUSE Leap 15.3+: zypper install python39" \
              "  CentOS: dnf install python3.12"
 fi
 
diff --git a/tests/lcitool/mappings.yml b/tests/lcitool/mappings.yml
index 60618971584..62fe60d047f 100644
--- a/tests/lcitool/mappings.yml
+++ b/tests/lcitool/mappings.yml
@@ -3,70 +3,17 @@ mappings:
   bindgen:
     Ubuntu2204:
 
-  flake8:
-    OpenSUSELeap15:
-
   meson:
-    OpenSUSELeap15:
     # Use Meson from PyPI wherever Rust is enabled
     Debian:
     Fedora:
     Ubuntu:
 
-  python3:
-    OpenSUSELeap15: python311-base
-
-  python3-PyYAML:
-    OpenSUSELeap15:
-
-  python3-devel:
-    OpenSUSELeap15: python311-devel
-
-  python3-docutils:
-    OpenSUSELeap15:
-
-  python3-numpy:
-    OpenSUSELeap15:
-
-  python3-opencv:
-    OpenSUSELeap15:
-
-  python3-pillow:
-    OpenSUSELeap15:
-
-  python3-pip:
-    OpenSUSELeap15: python311-pip
-
-  python3-pillow:
-    OpenSUSELeap15:
-
-  python3-selinux:
-    OpenSUSELeap15:
-
-  python3-setuptools:
-    OpenSUSELeap15: python311-setuptools
-
-  python3-sphinx:
-    OpenSUSELeap15:
-
-  python3-sphinx-rtd-theme:
-    OpenSUSELeap15:
-
-  python3-sqlite3:
-    OpenSUSELeap15: python311
-
   python3-tomli:
     # test using tomllib
     apk:
     Fedora:
     Debian12:
-    OpenSUSELeap15:
-
-  python3-venv:
-    OpenSUSELeap15: python311-base
-
-  python3-wheel:
-    OpenSUSELeap15: python311-wheel
 
   rust:
     Debian12: rustc-web
@@ -79,12 +26,7 @@ pypi_mappings:
     default: meson==1.8.1
 
   # Drop packages that need devel headers
-  python3-numpy:
-    OpenSUSELeap15:
-
-  # see above
   python3-tomli:
     apk:
     Fedora:
     Debian12:
-    OpenSUSELeap15:
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 259e6ea0729..79e0b6776c7 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -226,7 +226,7 @@ try:
     generate_dockerfile("debian", "debian-13",
                         trailer="".join(debian13_extras))
     generate_dockerfile("fedora", "fedora-43")
-    generate_dockerfile("opensuse-leap", "opensuse-leap-15")
+    generate_dockerfile("opensuse-leap", "opensuse-leap-16")
     generate_dockerfile("ubuntu2204", "ubuntu-2204",
                         trailer="".join(ubuntu2204_rust_extras),
                         # https://bugs.launchpad.net/ubuntu/+source/rustc-1.83/+bug/2120318
-- 
2.53.0


