Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B1CC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 10:42:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmtOm-0006CD-41; Wed, 20 Mar 2024 06:42:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rmtOW-00069P-DL
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 06:42:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rmtOU-00073m-VL
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 06:42:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710931322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o2jVHJU5vYiExdxPV1zFz/jz+Zd76NApu5yKy6lTusE=;
 b=EwKPkAa0mPFGK68IOiwEIPF7siDLNoRNsBXmMblLydvjVAaTyKW32hx2okdl6I6K9Nzln9
 23uRzzOrfu5QgviQBuAW8j+933o5vHW9hUIkoilE3bQ1NjL/1YaDGF8uoWtey0bodCj73g
 OeR8va5Kb3/6CevAAgi/fIOS2gEIfV0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-dI4spFhfOFWS50RsIUuV2w-1; Wed,
 20 Mar 2024 06:41:59 -0400
X-MC-Unique: dI4spFhfOFWS50RsIUuV2w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 99D1E1C05145;
 Wed, 20 Mar 2024 10:41:58 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.206])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2B1EA2166B34;
 Wed, 20 Mar 2024 10:41:56 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: [PATCH 4/6] .travis.yml: Update the jobs to Ubuntu 22.04
Date: Wed, 20 Mar 2024 11:41:42 +0100
Message-ID: <20240320104144.823425-5-thuth@redhat.com>
In-Reply-To: <20240320104144.823425-1-thuth@redhat.com>
References: <20240320104144.823425-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
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

According to our support policy, we'll soon drop our official support
for Ubuntu 20.04 ("Focal Fossa") in QEMU. Thus we should update the
Travis jobs now to a newer release (Ubuntu 22.04 - "Jammy Jellyfish")
for future testing. Since all jobs are using this release now, we
can drop the entries from the individual jobs and use the global
setting again.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .travis.yml | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 8da88c4360..16cf706c07 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -1,5 +1,5 @@
 os: linux
-dist: focal
+dist: jammy
 language: c
 compiler:
   - gcc
@@ -7,7 +7,7 @@ cache:
   # There is one cache per branch and compiler version.
   # characteristics of each job are used to identify the cache:
   # - OS name (currently only linux)
-  # - OS distribution (for Linux, bionic or focal)
+  # - OS distribution (e.g. "jammy" for Linux)
   # - Names and values of visible environment variables set in .travis.yml or Settings panel
   timeout: 1200
   ccache: true
@@ -81,7 +81,6 @@ jobs:
 
     - name: "[aarch64] GCC check-tcg"
       arch: arm64
-      dist: focal
       addons:
         apt_packages:
           - libaio-dev
@@ -117,7 +116,6 @@ jobs:
 
     - name: "[ppc64] GCC check-tcg"
       arch: ppc64le
-      dist: focal
       addons:
         apt_packages:
           - libaio-dev
@@ -152,7 +150,6 @@ jobs:
 
     - name: "[s390x] GCC check-tcg"
       arch: s390x
-      dist: focal
       addons:
         apt_packages:
           - libaio-dev
@@ -197,7 +194,6 @@ jobs:
 
     - name: "[s390x] GCC (other-system)"
       arch: s390x
-      dist: focal
       addons:
         apt_packages:
           - libaio-dev
@@ -227,7 +223,6 @@ jobs:
 
     - name: "[s390x] GCC (user)"
       arch: s390x
-      dist: focal
       addons:
         apt_packages:
           - libgcrypt20-dev
@@ -242,8 +237,7 @@ jobs:
 
     - name: "[s390x] Clang (disable-tcg)"
       arch: s390x
-      dist: focal
-      compiler: clang-10
+      compiler: clang
       addons:
         apt_packages:
           - libaio-dev
@@ -269,7 +263,6 @@ jobs:
           - libvdeplug-dev
           - libvte-2.91-dev
           - ninja-build
-          - clang-10
       env:
         - TEST_CMD="make check-unit"
         - CONFIG="--disable-containers --disable-tcg --enable-kvm --disable-tools
-- 
2.44.0


