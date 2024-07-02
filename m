Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE00FC3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 10:34:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOapj-0004VC-43; Tue, 02 Jul 2024 06:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sOaph-0004RS-JZ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 06:33:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sOapg-00077o-1x
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 06:33:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719916435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Owm1mlq7uqIiykzVPb5sz2Sw4STwQhD7wcxtudtRzVE=;
 b=R0kEiAMrSYUpFmKg2mhCd8Gp7QYTGjjZPaLA6WYfgQW9dqIEaIP2L1b4aSjdPTEvise9jw
 foq4iG+5f/yrGFfsvynECHMmj9izY/QPcXvd6U7m820FeyWC3zRE+A2a3CfzwIJdicxqoi
 N6XLYNfOy7Y/GUphX3Q3Y/r3YEfTVJ4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-484-F56KU3M9PnKMma4Ed_hEMg-1; Tue,
 02 Jul 2024 06:33:53 -0400
X-MC-Unique: F56KU3M9PnKMma4Ed_hEMg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BEC871944D36; Tue,  2 Jul 2024 10:33:52 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7146719560AA; Tue,  2 Jul 2024 10:33:50 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 11/12] .travis.yml: Install python3-tomli in all build jobs
Date: Tue,  2 Jul 2024 12:33:09 +0200
Message-ID: <20240702103310.347201-12-thuth@redhat.com>
In-Reply-To: <20240702103310.347201-1-thuth@redhat.com>
References: <20240702103310.347201-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

Since commit 1f97715c83 ('Revert "python: use vendored tomli"')
this package is a hard requirement for compiling QEMU, so install
it now in all Travis jobs, too.

Message-ID: <20240624094807.182313-1-thuth@redhat.com>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
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


