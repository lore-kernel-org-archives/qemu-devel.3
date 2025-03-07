Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94173C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 11:56:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqWHC-0002PE-Iz; Fri, 07 Mar 2025 06:54:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tqWHB-0002Op-0P
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 06:54:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tqWH8-0000Mj-Ua
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 06:54:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741348438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zauGDAHW/VZ8KQXAC0Fs6S1Kmclqu/+eitmfaMVBHpU=;
 b=Q6VjhsNV/d2Glx/CKTOqDKua3W3cn6xzm+CGJdZ2pkILRTpyj03O496ol5T77+mBq9HwSH
 IJIWLpmM3/B1teYs1+tMrLyFz1klAV/E1esjQDwsMpdVIju2HARzSP9NNQJ2TSlAxYdI4s
 ClRyMY8AGDpkdAzDmrDXKbg/02yzaUQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-572-L0Y6Xg6-OhyyX9I90jUeHQ-1; Fri,
 07 Mar 2025 06:53:54 -0500
X-MC-Unique: L0Y6Xg6-OhyyX9I90jUeHQ-1
X-Mimecast-MFC-AGG-ID: L0Y6Xg6-OhyyX9I90jUeHQ_1741348433
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2BE001955BC9; Fri,  7 Mar 2025 11:53:53 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.60])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 93E461944F2E; Fri,  7 Mar 2025 11:53:50 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Aditya Gupta <adityag@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 12/15] doc: add missing 'Asset' type in function test doc
Date: Fri,  7 Mar 2025 12:53:11 +0100
Message-ID: <20250307115314.1096373-13-thuth@redhat.com>
In-Reply-To: <20250307115314.1096373-1-thuth@redhat.com>
References: <20250307115314.1096373-1-thuth@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

From: Aditya Gupta <adityag@linux.ibm.com>

Seems 'Asset' got missed in the documentation by mistake.

Also fix the one spellcheck issue pointed by spellcheck

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250306060706.1982992-1-adityag@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/devel/testing/functional.rst | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/docs/devel/testing/functional.rst b/docs/devel/testing/functional.rst
index bcb5509512e..a9fa45eac1f 100644
--- a/docs/devel/testing/functional.rst
+++ b/docs/devel/testing/functional.rst
@@ -251,7 +251,7 @@ Many functional tests download assets (e.g. Linux kernels, initrds,
 firmware images, etc.) from the internet to be able to run tests with
 them. This imposes additional challenges to the test framework.
 
-First there is the the problem that some people might not have an
+First there is the problem that some people might not have an
 unconstrained internet connection, so such tests should not be run by
 default when running ``make check``. To accomplish this situation,
 the tests that download files should only be added to the "thorough"
@@ -274,7 +274,9 @@ the tests are run. This pre-caching is done with the qemu_test.Asset
 class. To use it in your test, declare an asset in your test class with
 its URL and SHA256 checksum like this::
 
-    ASSET_somename = (
+    from qemu_test import Asset
+
+    ASSET_somename = Asset(
         ('https://www.qemu.org/assets/images/qemu_head_200.png'),
         '34b74cad46ea28a2966c1d04e102510daf1fd73e6582b6b74523940d5da029dd')
 
-- 
2.48.1


