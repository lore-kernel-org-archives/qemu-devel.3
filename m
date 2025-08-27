Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CA74C8303F
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 07:59:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urB1o-0007PL-Ta; Wed, 27 Aug 2025 03:57:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1urB1R-0006WB-QU
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 03:56:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1urB1O-00027j-U6
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 03:56:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756281401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VRq6CMh6hKB/wHqvvgD7Qig0ilrepfijfp9MgM0G3s0=;
 b=cz8s00VNJlFkNlpFeyTur5bpglgzn0aRIBrIKBaaaMs/LE+5nOh7xyCs4SDZRtWI2E++h7
 LonnlFAdCH6AvfROzS8ygKMpDuIx9lPXErurH9KZA9fpSC7s/+OBuHyeAOn46SK0ArrbGZ
 s8Pruxl+V0/VmnNvDWnqxho4VhE3qjk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-j4g_CxbvPgG8HLfLT4WXYg-1; Wed,
 27 Aug 2025 03:56:38 -0400
X-MC-Unique: j4g_CxbvPgG8HLfLT4WXYg-1
X-Mimecast-MFC-AGG-ID: j4g_CxbvPgG8HLfLT4WXYg_1756281397
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D7F9E18002C1; Wed, 27 Aug 2025 07:56:37 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.40])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BEFFE1955F24; Wed, 27 Aug 2025 07:56:35 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 30/31] MAINTAINERS: Adjust wildcards for the migration,
 multiprocess and replay tests
Date: Wed, 27 Aug 2025 09:54:40 +0200
Message-ID: <20250827075443.559712-31-thuth@redhat.com>
In-Reply-To: <20250827075443.559712-1-thuth@redhat.com>
References: <20250827075443.559712-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Now that we moved the tests into subfolders, we have to adjust the
wildcards accordingly.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250819112403.432587-26-thuth@redhat.com>
---
 MAINTAINERS | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 625fe67b41d..a64b5b849b5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3604,7 +3604,8 @@ F: include/migration/
 F: include/qemu/userfaultfd.h
 F: migration/
 F: scripts/vmstate-static-checker.py
-F: tests/functional/*migration.py
+F: tests/functional/migration.py
+F: tests/functional/*/*migration.py
 F: tests/vmstate-static-checker-data/
 F: tests/qtest/migration/
 F: tests/qtest/migration-*
@@ -3773,8 +3774,10 @@ F: include/system/replay.h
 F: docs/devel/replay.rst
 F: docs/system/replay.rst
 F: stubs/replay.c
-F: tests/functional/*reverse_debug*.py
-F: tests/functional/*replay*.py
+F: tests/functional/replay_kernel.py
+F: tests/functional/reverse_debugging.py
+F: tests/functional/*/*replay*.py
+F: tests/functional/*/*reverse_debug*.py
 F: qapi/replay.json
 
 IOVA Tree
@@ -4293,7 +4296,8 @@ F: hw/remote/vfio-user-obj.c
 F: include/hw/remote/vfio-user-obj.h
 F: hw/remote/iommu.c
 F: include/hw/remote/iommu.h
-F: tests/functional/*multiprocess.py
+F: tests/functional/multiprocess.py
+F: tests/functional/*/*multiprocess.py
 
 VFIO-USER:
 M: John Levon <john.levon@nutanix.com>
-- 
2.50.1


