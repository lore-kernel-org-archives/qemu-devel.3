Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4EABC28B30
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 11:52:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trxrI-0003f1-2H; Tue, 11 Mar 2025 07:33:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trxqf-0003Kc-VF
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:32:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trxqA-0006YF-VO
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:32:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741692724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=flO+mLezwqffdgGJp6T3uxQumA1quEGBxSePL44H6K8=;
 b=aDTfJ3KyVYgKThn8TJ/oeKELoTl6Xyd9pSjXT1dyrxxmQjZ3a8qxFrqTXPryzyd5iliek3
 JtC54XR1ozECuZ1Pv6smxMH7+bOHq2E8KvKrCu9IPYceb+fOIJ0Qp33nE6YLijlxpLteW1
 dOsg8EBvGNCDtUr90FCgI3D0HP8qw0w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-145-815TWPPoNjCDSsTWSIMtJQ-1; Tue,
 11 Mar 2025 07:32:03 -0400
X-MC-Unique: 815TWPPoNjCDSsTWSIMtJQ-1
X-Mimecast-MFC-AGG-ID: 815TWPPoNjCDSsTWSIMtJQ_1741692722
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5323D180025A
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 11:32:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C32601800268
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 11:32:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 98F1A21E60E3; Tue, 11 Mar 2025 12:31:38 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 57/61] docs: disambiguate cross-references
Date: Tue, 11 Mar 2025 12:31:33 +0100
Message-ID: <20250311113137.1277125-58-armbru@redhat.com>
In-Reply-To: <20250311113137.1277125-1-armbru@redhat.com>
References: <20250311113137.1277125-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: John Snow <jsnow@redhat.com>

The next patch will engage the qapidoc transmogrifier, which creates a
lot of cross-reference targets. Some of the existing targets
("migration", "qom", "replay") will become ambiguous as a result. Nail
them down more explicitly to prevent ambiguous cross-reference warnings.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20250311034303.75779-61-jsnow@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/devel/codebase.rst |  6 +++---
 docs/glossary.rst       | 10 +++++-----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/docs/devel/codebase.rst b/docs/devel/codebase.rst
index 4039875ee0..1b09953197 100644
--- a/docs/devel/codebase.rst
+++ b/docs/devel/codebase.rst
@@ -23,7 +23,7 @@ Some of the main QEMU subsystems are:
 - `Devices<device-emulation>` & Board models
 - `Documentation <documentation-root>`
 - `GDB support<GDB usage>`
-- `Migration<migration>`
+- :ref:`Migration<migration>`
 - `Monitor<QEMU monitor>`
 - :ref:`QOM (QEMU Object Model)<qom>`
 - `System mode<System emulation>`
@@ -112,7 +112,7 @@ yet, so sometimes the source code is all you have.
 * `libdecnumber <https://gitlab.com/qemu-project/qemu/-/tree/master/libdecnumber>`_:
   Import of gcc library, used to implement decimal number arithmetic.
 * `migration <https://gitlab.com/qemu-project/qemu/-/tree/master/migration>`__:
-  `Migration framework <migration>`.
+  :ref:`Migration framework <migration>`.
 * `monitor <https://gitlab.com/qemu-project/qemu/-/tree/master/monitor>`_:
   `Monitor <QEMU monitor>` implementation (HMP & QMP).
 * `nbd <https://gitlab.com/qemu-project/qemu/-/tree/master/nbd>`_:
@@ -193,7 +193,7 @@ yet, so sometimes the source code is all you have.
   - `lcitool <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/lcitool>`_:
     Generate dockerfiles for CI containers.
   - `migration <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/migration>`_:
-    Test scripts and data for `Migration framework <migration>`.
+    Test scripts and data for :ref:`Migration framework <migration>`.
   - `multiboot <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/multiboot>`_:
     Test multiboot functionality for x86_64/i386.
   - `qapi-schema <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/qapi-schema>`_:
diff --git a/docs/glossary.rst b/docs/glossary.rst
index 693d9855dd..4fa044bfb6 100644
--- a/docs/glossary.rst
+++ b/docs/glossary.rst
@@ -120,7 +120,7 @@ Migration
 ---------
 
 QEMU can save and restore the execution of a virtual machine between different
-host systems. This is provided by the `Migration framework<migration>`.
+host systems. This is provided by the :ref:`Migration framework<migration>`.
 
 NBD
 ---
@@ -212,14 +212,14 @@ machine emulator and virtualizer.
 QOM
 ---
 
-`QEMU Object Model <qom>` is an object oriented API used to define various
-devices and hardware in the QEMU codebase.
+:ref:`QEMU Object Model <qom>` is an object oriented API used to define
+various devices and hardware in the QEMU codebase.
 
 Record/replay
 -------------
 
-`Record/replay <replay>` is a feature of QEMU allowing to have a deterministic
-and reproducible execution of a virtual machine.
+:ref:`Record/replay <replay>` is a feature of QEMU allowing to have a
+deterministic and reproducible execution of a virtual machine.
 
 Rust
 ----
-- 
2.48.1


