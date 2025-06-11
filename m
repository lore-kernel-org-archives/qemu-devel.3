Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28D5FC61CE7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 13:00:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPL33-0003Nu-Si; Wed, 11 Jun 2025 08:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uPL2x-0003LF-7a
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 08:59:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uPL2u-0004P8-HI
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 08:59:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749646750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hyhSXVN0r+Yj60p1w9pJKY9rEe8e07VBYGJYHD+AD8w=;
 b=N4BjPM4T9IA5nGBtGU16/OawIUqdwfVRoIQvd3RFTDc+PcW22vjnYyNHUzjRXaiaCmmBGF
 efqVf73DCTUlKtrFiaFkw2I213wq6on9RHjIdZyCRHWc7Yt5n+1AsYFVr9ozjbkuC80+GM
 8vnGX1rW5LDyM+f/X/OgWO2QHGrKN+M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-EBWzPebIO9eAB8HWA4pv8g-1; Wed,
 11 Jun 2025 08:59:08 -0400
X-MC-Unique: EBWzPebIO9eAB8HWA4pv8g-1
X-Mimecast-MFC-AGG-ID: EBWzPebIO9eAB8HWA4pv8g_1749646747
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BA61B180028A
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 12:59:07 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.174])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3AE6019560A3; Wed, 11 Jun 2025 12:59:05 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Ani Sinha <anisinha@redhat.com>
Subject: [PULL 08/10] MAINTAINERS: Update the paths to the testing
 documentation files
Date: Wed, 11 Jun 2025 14:58:44 +0200
Message-ID: <20250611125846.125918-9-thuth@redhat.com>
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

When the testing docs were moved to a separate subfolder, the entries
in the MAINTAINERS file were missed. Update them now.

Fixes: ff41da50308 ("docs/devel: Split testing docs from the build docs and move to separate folder")
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250610053734.10417-1-thuth@redhat.com>
---
 MAINTAINERS | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index aa6763077ea..eb2b338fb11 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2124,7 +2124,7 @@ M: Michael S. Tsirkin <mst@redhat.com>
 S: Supported
 F: tests/functional/acpi-bits/*
 F: tests/functional/test_acpi_bits.py
-F: docs/devel/acpi-bits.rst
+F: docs/devel/testing/acpi-bits.rst
 
 ACPI/HEST/GHES
 R: Dongjiu Geng <gengdongjiu1@gmail.com>
@@ -3440,8 +3440,8 @@ F: system/qtest.c
 F: include/system/qtest.h
 F: accel/qtest/
 F: tests/qtest/
-F: docs/devel/qgraph.rst
-F: docs/devel/qtest.rst
+F: docs/devel/testing/qgraph.rst
+F: docs/devel/testing/qtest.rst
 X: tests/qtest/bios-tables-test*
 X: tests/qtest/migration-*
 
@@ -3459,7 +3459,7 @@ F: tests/qtest/fuzz-*test.c
 F: tests/docker/test-fuzz
 F: scripts/oss-fuzz/
 F: hw/mem/sparse-mem.c
-F: docs/devel/fuzzing.rst
+F: docs/devel/testing/fuzzing.rst
 
 Register API
 M: Alistair Francis <alistair@alistair23.me>
@@ -4078,7 +4078,7 @@ M: Stefan Hajnoczi <stefanha@redhat.com>
 L: qemu-block@nongnu.org
 S: Supported
 F: block/blkverify.c
-F: docs/devel/blkverify.rst
+F: docs/devel/testing/blkverify.rst
 
 bochs
 M: Stefan Hajnoczi <stefanha@redhat.com>
@@ -4156,7 +4156,7 @@ M: Hanna Reitz <hreitz@redhat.com>
 L: qemu-block@nongnu.org
 S: Supported
 F: block/blkdebug.c
-F: docs/devel/blkdebug.rst
+F: docs/devel/testing/blkdebug.rst
 
 vpc
 M: Kevin Wolf <kwolf@redhat.com>
@@ -4276,7 +4276,8 @@ F: tests/vm/
 F: tests/lcitool/
 F: tests/functional/test_*_tuxrun.py
 F: scripts/archive-source.sh
-F: docs/devel/testing.rst
+F: docs/devel/testing/ci*
+F: docs/devel/testing/main.rst
 W: https://gitlab.com/qemu-project/qemu/pipelines
 W: https://travis-ci.org/qemu/qemu
 
-- 
2.49.0


