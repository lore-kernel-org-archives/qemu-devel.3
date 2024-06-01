Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F1D2C27C52
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Jun 2024 07:07:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sDIoN-00047l-EL; Sat, 01 Jun 2024 03:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sDIoM-000476-1i
 for qemu-devel@nongnu.org; Sat, 01 Jun 2024 03:05:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sDIoK-00004t-Fk
 for qemu-devel@nongnu.org; Sat, 01 Jun 2024 03:05:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717225551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AW9FLDXyevM3aRLiC+CScYvLcglRp2zyO+RbIh98HY4=;
 b=EaCJRUtTkzYhB1LTynXwSJxOAK5lTBwH625lLOmxgcLppONKNFlBuNGuUBtvi6YA3nS5v2
 PO3liVMOiAZIbB50Zxo9eRo8Avfe/vk/FXgY7+XTocQQ4IGlHLeROf7DN1xnCEv6jvjPh7
 HebTOFgH4c+4rtlTnm4ZLnErR/Ap2eQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-UWXHsZLjPe2ADLtU8f9xCw-1; Sat,
 01 Jun 2024 03:05:47 -0400
X-MC-Unique: UWXHsZLjPe2ADLtU8f9xCw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A0CDD29AA381;
 Sat,  1 Jun 2024 07:05:47 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A569B200A35C;
 Sat,  1 Jun 2024 07:05:46 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 2/5] tests/lcitool: Bump to latest libvirt-ci and update
 Fedora and Alpine version
Date: Sat,  1 Jun 2024 09:05:40 +0200
Message-ID: <20240601070543.37786-3-thuth@redhat.com>
In-Reply-To: <20240601070543.37786-1-thuth@redhat.com>
References: <20240601070543.37786-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
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

Update to the latest version of lcitool. It dropped support for Fedora 38
and Alpine 3.18, so we have to update these to newer versions here, too.

Python 3.12 dropped the "imp" module which we still need for running
Avocado. Fortunately Fedora 40 still ships with a work-around package
that we can use until somebody updates our Avocado to a newer version.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/lcitool/libvirt-ci        | 2 +-
 tests/lcitool/projects/qemu.yml | 1 +
 tests/lcitool/refresh           | 6 +++---
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci
index cec6703971..0e9490cebc 160000
--- a/tests/lcitool/libvirt-ci
+++ b/tests/lcitool/libvirt-ci
@@ -1 +1 @@
-Subproject commit cec67039719becbfbab866f9c23574f389cf9559
+Subproject commit 0e9490cebc726ef772b6c9e27dac32e7ae99f9b2
diff --git a/tests/lcitool/projects/qemu.yml b/tests/lcitool/projects/qemu.yml
index 7511ec7ccb..070d7f4706 100644
--- a/tests/lcitool/projects/qemu.yml
+++ b/tests/lcitool/projects/qemu.yml
@@ -89,6 +89,7 @@ packages:
  - pkg-config
  - pulseaudio
  - python3
+ - python3-imp
  - python3-numpy
  - python3-opencv
  - python3-pillow
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 789acefb75..9d8e9c6a4a 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -124,11 +124,11 @@ try:
     #
     # Standard native builds
     #
-    generate_dockerfile("alpine", "alpine-318")
+    generate_dockerfile("alpine", "alpine-319")
     generate_dockerfile("centos9", "centos-stream-9")
     generate_dockerfile("debian", "debian-12",
                         trailer="".join(debian12_extras))
-    generate_dockerfile("fedora", "fedora-38")
+    generate_dockerfile("fedora", "fedora-40")
     generate_dockerfile("opensuse-leap", "opensuse-leap-15")
     generate_dockerfile("ubuntu2204", "ubuntu-2204")
 
@@ -191,7 +191,7 @@ try:
                         trailer=cross_build("s390x-linux-gnu-",
                                             "s390x-softmmu,s390x-linux-user"))
 
-    generate_dockerfile("fedora-win64-cross", "fedora-38",
+    generate_dockerfile("fedora-win64-cross", "fedora-40",
                         project='qemu,qemu-win-installer',
                         cross="mingw64",
                         trailer=cross_build("x86_64-w64-mingw32-",
-- 
2.45.1


