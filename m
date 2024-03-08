Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA74C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 10:42:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riXg7-0007Xq-UO; Fri, 08 Mar 2024 05:42:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1riXg6-0007XS-Vc
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 05:42:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1riXg5-0002d4-IY
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 05:42:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709894532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=R8lL/g6oDQcA7TfztXytEJa3Vv3eTQ3pcbjrOlW+zS0=;
 b=NWQ8OU0QvnMwtHZsDVVsw+XYj1gwcUR/xmi2xSqk8UlHxubnjRLXUtCqGkGmATvcR5WfBQ
 glgNoMxvqsrdqmCwTnbTStBX0y1vv3Ay0q48nUIG8MD/g+1FKGkKcXyZyBc8aX9Cf5QHym
 cOtyVOfuUXe2SB3THhG5cttWY1DMmwY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-DoegQFvQMletphR2VExa_g-1; Fri, 08 Mar 2024 05:42:09 -0500
X-MC-Unique: DoegQFvQMletphR2VExa_g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E322D101A526;
 Fri,  8 Mar 2024 10:42:08 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9B0CB492BCB;
 Fri,  8 Mar 2024 10:42:07 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH] docs/about: Deprecate the "mainstone",
 "tosa" and "z2" machines
Date: Fri,  8 Mar 2024 11:42:06 +0100
Message-ID: <20240308104206.480929-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Support for these boards has been removed from the Linux kernel
in version 6.3 in 2023, so there are likely no users left for these
boards. Time to mark them as deprecated in QEMU, too!

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/about/deprecated.rst | 8 ++++++++
 hw/arm/mainstone.c        | 1 +
 hw/arm/tosa.c             | 1 +
 hw/arm/z2.c               | 1 +
 4 files changed, 11 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 8565644da6..da5cc91eec 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -247,6 +247,14 @@ to correct issues, mostly regarding migration compatibility. These are
 no longer maintained and removing them will make the code easier to
 read and maintain. Use versions 2.12 and above as a replacement.
 
+``mainstone``, ``tosa`` and ``z2`` PXA2xx arm machines (since 9.0)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+Support for these boards has been removed from the Linux kernel
+in version 6.3 in 2023, so there are likely no users left for these
+boards, thus they will be removed without replacement.
+
+
 Backend options
 ---------------
 
diff --git a/hw/arm/mainstone.c b/hw/arm/mainstone.c
index d2e2e68aa3..c6018c6e81 100644
--- a/hw/arm/mainstone.c
+++ b/hw/arm/mainstone.c
@@ -169,6 +169,7 @@ static void mainstone2_machine_init(MachineClass *mc)
     mc->init = mainstone_init;
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("pxa270-c5");
+    mc->deprecation_reason = "machine is old and has no more Linux kernel support";
 }
 
 DEFINE_MACHINE("mainstone", mainstone2_machine_init)
diff --git a/hw/arm/tosa.c b/hw/arm/tosa.c
index 3ca2e4459c..9241867ba9 100644
--- a/hw/arm/tosa.c
+++ b/hw/arm/tosa.c
@@ -270,6 +270,7 @@ static void tosapda_machine_init(MachineClass *mc)
     mc->init = tosa_init;
     mc->block_default_type = IF_IDE;
     mc->ignore_memory_transaction_failures = true;
+    mc->deprecation_reason = "machine is old and has no more Linux kernel support";
 }
 
 DEFINE_MACHINE("tosa", tosapda_machine_init)
diff --git a/hw/arm/z2.c b/hw/arm/z2.c
index eb2ff8dbc8..c7c26bd726 100644
--- a/hw/arm/z2.c
+++ b/hw/arm/z2.c
@@ -347,6 +347,7 @@ static void z2_machine_init(MachineClass *mc)
     mc->init = z2_init;
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("pxa270-c5");
+    mc->deprecation_reason = "machine is old and has no more Linux kernel support";
 
     machine_add_audiodev_property(mc);
 }
-- 
2.44.0


