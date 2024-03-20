Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C665AC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 10:43:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmtOg-0006Aw-6L; Wed, 20 Mar 2024 06:42:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rmtOb-0006A0-1T
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 06:42:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rmtOZ-00074c-1L
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 06:42:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710931326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S59hqeQxVfPv1PY8qzf52Vr/RJqhp3BAheI79vK+k+Y=;
 b=Aske/vMdaq9LBvPb+WjJtAV/tMLAxgmAUtRzSlmDXb9ZmeO5+GYnkbKVtAwuoL8drOsQCn
 vW/NlLjWv+0xxC8oP2H7O9sl+kr8xw9KR2lGdqXEjKbGHUDa/p4JoGiTMWqzKixOxX9L3x
 XAOgDeL9O5FQsLNoPA2b5xDLB/9yKuw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-h9oqf5l2MKerk2Z6tL30PA-1; Wed, 20 Mar 2024 06:42:03 -0400
X-MC-Unique: h9oqf5l2MKerk2Z6tL30PA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A9C77811E81;
 Wed, 20 Mar 2024 10:42:02 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.206])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 24C212166B33;
 Wed, 20 Mar 2024 10:42:01 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: [PATCH 6/6] .travis.yml: Do some more testing with Clang
Date: Wed, 20 Mar 2024 11:41:44 +0100
Message-ID: <20240320104144.823425-7-thuth@redhat.com>
In-Reply-To: <20240320104144.823425-1-thuth@redhat.com>
References: <20240320104144.823425-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

We are doing a lot of cross-compilation tests with GCC in the gitlab-CI
already, so we could get some more test coverage by using Clang in the
Travis-CI instead. Thus let's switch two additional jobs to use Clang
for compilation.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .travis.yml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 7527f71c05..cef0308952 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -113,8 +113,9 @@ jobs:
         - CONFIG="--disable-containers --enable-fdt=system
                   --target-list=${MAIN_SYSTEM_TARGETS} --cxx=/bin/false"
 
-    - name: "[ppc64] GCC check-tcg"
+    - name: "[ppc64] Clang check-tcg"
       arch: ppc64le
+      compiler: clang
       addons:
         apt_packages:
           - libaio-dev
@@ -190,8 +191,9 @@ jobs:
               $(exit $BUILD_RC);
           fi
 
-    - name: "[s390x] GCC (other-system)"
+    - name: "[s390x] Clang (other-system)"
       arch: s390x
+      compiler: clang
       addons:
         apt_packages:
           - libaio-dev
-- 
2.44.0


