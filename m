Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32390C2BD05
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 09:48:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLgJE-0006XV-83; Mon, 24 Jun 2024 05:48:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sLgJD-0006XN-0F
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 05:48:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sLgJB-00026K-DO
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 05:48:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719222500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=pBgqBXOrtR4/kBVs6zdlCEQHstBE6BLIMegjCdEgrpc=;
 b=HigglY5cUTgZcwknNh1O9WiywLh/lS3SZeaCf1+OrNHiYfULU1VVMp+bxqypl4Lg40NuKK
 8BhoIoBNFTe1Ml8WDiyVuvS+lDknhxBBu/yd//OLEJ3FfXdJ/bF2lbVGNWi/8ugFAptfNf
 8WAIQqJcvg0OxRbXwa6/ksSdET5+6mg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-41-Gl6q30h2M6CzZAlKcdTMlQ-1; Mon,
 24 Jun 2024 05:48:18 -0400
X-MC-Unique: Gl6q30h2M6CzZAlKcdTMlQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 31CBF195608E; Mon, 24 Jun 2024 09:48:17 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.33])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E541F3000219; Mon, 24 Jun 2024 09:48:13 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH] .travis.yml: Install python3-tomli in all build jobs
Date: Mon, 24 Jun 2024 11:48:07 +0200
Message-ID: <20240624094807.182313-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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

Since commit 1f97715c83 ('Revert "python: use vendored tomli"')
this package is a hard requirement for compiling QEMU, so install
it now in all Travis jobs, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .travis.yml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index cef0308952..8fc1ae0cf2 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -106,6 +106,7 @@ jobs:
           - libvdeplug-dev
           - libvte-2.91-dev
           - ninja-build
+          - python3-tomli
           # Tests dependencies
           - genisoimage
       env:
@@ -141,6 +142,7 @@ jobs:
           - libvdeplug-dev
           - libvte-2.91-dev
           - ninja-build
+          - python3-tomli
           # Tests dependencies
           - genisoimage
       env:
@@ -175,6 +177,7 @@ jobs:
           - libvdeplug-dev
           - libvte-2.91-dev
           - ninja-build
+          - python3-tomli
           # Tests dependencies
           - genisoimage
       env:
@@ -215,6 +218,7 @@ jobs:
           - libzstd-dev
           - nettle-dev
           - ninja-build
+          - python3-tomli
           # Tests dependencies
           - genisoimage
       env:
@@ -231,6 +235,7 @@ jobs:
           - ninja-build
           - flex
           - bison
+          - python3-tomli
       env:
         - TEST_CMD="make check check-tcg V=1"
         - CONFIG="--disable-containers --disable-system"
@@ -263,6 +268,7 @@ jobs:
           - libvdeplug-dev
           - libvte-2.91-dev
           - ninja-build
+          - python3-tomli
       env:
         - TEST_CMD="make check-unit"
         - CONFIG="--disable-containers --disable-tcg --enable-kvm --disable-tools
-- 
2.45.2


