Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7884CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 08:24:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v78OI-00029d-VE; Fri, 10 Oct 2025 04:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v78OE-00028D-WA
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 04:22:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v78O9-000107-6K
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 04:22:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760084514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zR9N58YTO83JkhU3KfFhan4WvyWnN7pZ0OHhHvlNLhI=;
 b=J6EDlhIG5zwsUHijjbQ2/fZ+67Q1sYr3r0yn/2DhTHasA1cmSnu2n6FIJK0q3UmkGfmefI
 3dHddq2Qgdmohg9/T+6ruEuXHfVas4qDmEcHuVNIQscSVMhbonXc53/CGv4Y70lT5CRv2y
 KhRNNooGFguVE8W+M5B0Q7EAyl8XcxE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-322-zjYJYCvUMOeQ1CTLtnoBRQ-1; Fri,
 10 Oct 2025 04:21:51 -0400
X-MC-Unique: zjYJYCvUMOeQ1CTLtnoBRQ-1
X-Mimecast-MFC-AGG-ID: zjYJYCvUMOeQ1CTLtnoBRQ_1760084510
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 20BB019560AE; Fri, 10 Oct 2025 08:21:50 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.34.98])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 963441800452; Fri, 10 Oct 2025 08:21:48 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 1/9] tests/functional: Drop the "Attempting to cache ..." log
 text
Date: Fri, 10 Oct 2025 10:21:36 +0200
Message-ID: <20251010082145.576222-2-thuth@redhat.com>
In-Reply-To: <20251010082145.576222-1-thuth@redhat.com>
References: <20251010082145.576222-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The fetch() function already either prints "Using cached asset ..."
or "Downloading ... to ..." with the same file name to the log,
so the "Attempting to cache ..." message does not provide any
additional valuable information. Thus let's drop it to limit the
length of the logging output to a more reasonable size.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20251006170304.197387-1-thuth@redhat.com>
---
 tests/functional/qemu_test/asset.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
index 2971a989d1e..f666125bfaf 100644
--- a/tests/functional/qemu_test/asset.py
+++ b/tests/functional/qemu_test/asset.py
@@ -225,7 +225,6 @@ def precache_test(test):
         log.addHandler(handler)
         for name, asset in vars(test.__class__).items():
             if name.startswith("ASSET_") and type(asset) == Asset:
-                log.info("Attempting to cache '%s'" % asset)
                 try:
                     asset.fetch()
                 except AssetError as e:
-- 
2.51.0


