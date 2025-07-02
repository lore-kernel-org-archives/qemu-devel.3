Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88704C8303F
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 11:32:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWvgN-0000wD-1w; Wed, 02 Jul 2025 07:31:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uWvgH-0000vY-5R
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 07:31:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uWvgA-00052O-I3
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 07:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751455860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=mFmWlY277Om1t9wcCcb1S7yGVkyGpWURkwZuknh2Coc=;
 b=AYNuxLJVBjtq8ClVq9tYZaD2EJ/sIIybyE7pUGfPt4Oiu+X/4Sxy+dsLA/etAF8IG3PvZc
 76fMw513RDy/sgGt2RVFH8Vi2ss+tSQI+6Gl8PGUuYiSDHQu0STRDYTAYo4hSHUPFJjNXE
 7GCSs9szxbiCe/57bOxCykb4iMlJiDQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-Z_LAIBxbN7GGh9PztV5-7g-1; Wed,
 02 Jul 2025 07:30:56 -0400
X-MC-Unique: Z_LAIBxbN7GGh9PztV5-7g-1
X-Mimecast-MFC-AGG-ID: Z_LAIBxbN7GGh9PztV5-7g_1751455855
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 632A51978F63; Wed,  2 Jul 2025 11:30:55 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.225.139])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BCA8C19560AB; Wed,  2 Jul 2025 11:30:52 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Rob Herring <robh@kernel.org>, qemu-arm@nongnu.org,
 Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] hw/arm/highbank: Mark the "highbank" and the "midway" machine
 as deprecated
Date: Wed,  2 Jul 2025 13:30:51 +0200
Message-ID: <20250702113051.46483-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Thomas Huth <thuth@redhat.com>

We don't have any automatic regression tests for these machines and
when asking the usual suspects on the mailing list we came to the
conclusion that nobody tests these machines manually, too, so it seems
like this is currently just completely unused code. Mark them as depre-
cated to see whether anybody still speaks up during the deprecation
period, otherwise we can likely remove these two machines in a couple
of releases.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Here's the preceeding discussion on the mailing list:
 https://lore.kernel.org/qemu-devel/CAFEAcA_0Hu8+G50sy0FJ2rX-=cNymLddDdrS2nN5ZY-doKiT8w@mail.gmail.com/

 docs/about/deprecated.rst | 7 +++++++
 hw/arm/highbank.c         | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 42037131de1..3fb9d8e1ebd 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -344,6 +344,13 @@ they want to use and avoids confusion.  Existing users of the ``spike``
 machine must ensure that they're setting the ``spike`` machine in the
 command line (``-M spike``).
 
+Arm ``highbank`` and ``midway`` machines (since 10.1)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+There are no known users left for these machines (if you still use it,
+please write a mail to the qemu-devel mailing list). If you just want to
+boot an A15 or A9 Linux, use the ``virt`` machine instead.
+
 
 System emulator binaries
 ------------------------
diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index 3ae26ebebdc..165c0b741a5 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -357,6 +357,7 @@ static void highbank_class_init(ObjectClass *oc, const void *data)
     mc->max_cpus = 4;
     mc->ignore_memory_transaction_failures = true;
     mc->default_ram_id = "highbank.dram";
+    mc->deprecation_reason = "no known users left for this machine";
 }
 
 static const TypeInfo highbank_type = {
@@ -381,6 +382,7 @@ static void midway_class_init(ObjectClass *oc, const void *data)
     mc->max_cpus = 4;
     mc->ignore_memory_transaction_failures = true;
     mc->default_ram_id = "highbank.dram";
+    mc->deprecation_reason = "no known users left for this machine";
 }
 
 static const TypeInfo midway_type = {
-- 
2.50.0


