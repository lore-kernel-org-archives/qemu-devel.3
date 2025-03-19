Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65890C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 13:20:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tutKK-0008SF-AN; Wed, 19 Mar 2025 09:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tutKI-0008Re-JM
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 09:19:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tutKG-0007cA-HV
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 09:19:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742390355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yO8tatKd3Pm3cwIW7k7JzR0bRCuWoVaygtzUxWeAGQs=;
 b=YR8w4r8TiLSmYj4mb1T/uosWInQnnG5fUWb7npOw3YEtlSFs7A3e/Oq6mfOGp8kVWgaAdA
 ENoDxwloJZ++tpmv74sWYD346M8lz06B5SwjuxAQ5Jlm9ksXpSBBNP1MMWcWIkXlkT8Tbu
 oTjUyXHf8dcB+lUCNPCqEuq4y96Wy/4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-227-_1cYEbWiO2COeHVdfJdBHg-1; Wed,
 19 Mar 2025 09:19:12 -0400
X-MC-Unique: _1cYEbWiO2COeHVdfJdBHg-1
X-Mimecast-MFC-AGG-ID: _1cYEbWiO2COeHVdfJdBHg_1742390352
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EB37F19560B2
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 13:19:11 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.212])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 49A273001D12; Wed, 19 Mar 2025 13:19:08 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 3/8] tests/functional: remove all class level fields
Date: Wed, 19 Mar 2025 14:18:46 +0100
Message-ID: <20250319131851.148817-4-thuth@redhat.com>
In-Reply-To: <20250319131851.148817-1-thuth@redhat.com>
References: <20250319131851.148817-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Daniel P. Berrangé <berrange@redhat.com>

A number of fields are set at the class level on QemuBaseTest, even
though the exact same named field is then set at the object level
later in most cases.

The 'self.logger' initialization in ACPI bits test needs to be removed
since 'self.log' won't exist at that point in the flow. It already
initialized 'self.logger' later in the setUp() method, so the __init__
method was redundant.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20250317124300.84266-1-berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/qemu_test/testcase.py | 6 ------
 tests/functional/test_acpi_bits.py     | 1 -
 2 files changed, 7 deletions(-)

diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index 50d232a7c63..50c401b8c3c 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -33,12 +33,6 @@
 
 class QemuBaseTest(unittest.TestCase):
 
-    arch = None
-
-    workdir = None
-    log = None
-    logdir = None
-
     '''
     @params compressed: filename, Asset, or file-like object to uncompress
     @params format: optional compression format (gzip, lzma)
diff --git a/tests/functional/test_acpi_bits.py b/tests/functional/test_acpi_bits.py
index 20da4356873..8e0563a97b1 100755
--- a/tests/functional/test_acpi_bits.py
+++ b/tests/functional/test_acpi_bits.py
@@ -119,7 +119,6 @@ def __init__(self, *args, **kwargs):
 
         self._debugcon_addr = '0x403'
         self._debugcon_log = 'debugcon-log.txt'
-        self.logger = self.log
 
     def _print_log(self, log):
         self.logger.info('\nlogs from biosbits follows:')
-- 
2.48.1


