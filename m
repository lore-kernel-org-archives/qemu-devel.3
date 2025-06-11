Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 523F0C677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 13:01:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPL2z-0003ME-Qt; Wed, 11 Jun 2025 08:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uPL2j-0003J3-It
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 08:59:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uPL2e-0004MY-It
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 08:58:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749646735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hR9llZ2IDKIEut4qbfy1PHsnSx1DMDB3uo01UEO4CSM=;
 b=FdG619OCa2lSpLhEn+nvp26/lwjwdTvGdilSaI8eXNqjJf6GVq0lhqG2DlbMxvNm5n6qcI
 8oZLv84rjcLhAZBIQ19XbilyzbY67/Ut7bTE19jy7+LRn/bsOy/9yUo+EyBikLgSiD0YqR
 9gFuZhjR9VHvJe8caRCGpG+BAQaOyDo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-412-Er9dImyTM821dZn7ao9CEQ-1; Wed,
 11 Jun 2025 08:58:53 -0400
X-MC-Unique: Er9dImyTM821dZn7ao9CEQ-1
X-Mimecast-MFC-AGG-ID: Er9dImyTM821dZn7ao9CEQ_1749646732
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2904B1956057
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 12:58:52 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.174])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 66EBA1956053; Wed, 11 Jun 2025 12:58:49 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 01/10] travis.yml: Remove the aarch64 job
Date: Wed, 11 Jun 2025 14:58:37 +0200
Message-ID: <20250611125846.125918-2-thuth@redhat.com>
In-Reply-To: <20250611125846.125918-1-thuth@redhat.com>
References: <20250611125846.125918-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Thomas Huth <thuth@redhat.com>

According to:

 https://docs.travis-ci.com/user/billing-overview/#partner-queue-solution

only s390x and ppc64le are still part of the free OSS tier in Travis.
aarch64 has been removed sometime during the last year. Thus remove
the aarch64 job from our .travis.yml file now to avoid that someone
burns non-OSS CI credits with this job by accident now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250530115454.187727-1-thuth@redhat.com>
---
 .travis.yml | 35 -----------------------------------
 1 file changed, 35 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 8fc1ae0cf22..0a634d7b4a0 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -79,41 +79,6 @@ after_script:
 jobs:
   include:
 
-    - name: "[aarch64] GCC check-tcg"
-      arch: arm64
-      addons:
-        apt_packages:
-          - libaio-dev
-          - libattr1-dev
-          - libbrlapi-dev
-          - libcacard-dev
-          - libcap-ng-dev
-          - libfdt-dev
-          - libgcrypt20-dev
-          - libgnutls28-dev
-          - libgtk-3-dev
-          - libiscsi-dev
-          - liblttng-ust-dev
-          - libncurses5-dev
-          - libnfs-dev
-          - libpixman-1-dev
-          - libpng-dev
-          - librados-dev
-          - libsdl2-dev
-          - libseccomp-dev
-          - liburcu-dev
-          - libusb-1.0-0-dev
-          - libvdeplug-dev
-          - libvte-2.91-dev
-          - ninja-build
-          - python3-tomli
-          # Tests dependencies
-          - genisoimage
-      env:
-        - TEST_CMD="make check check-tcg V=1"
-        - CONFIG="--disable-containers --enable-fdt=system
-                  --target-list=${MAIN_SYSTEM_TARGETS} --cxx=/bin/false"
-
     - name: "[ppc64] Clang check-tcg"
       arch: ppc64le
       compiler: clang
-- 
2.49.0


