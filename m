Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C31B9C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 03:53:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpflW-0006gA-7v; Tue, 04 Mar 2025 22:49:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tpflM-0005tD-HV
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 22:49:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tpflK-0006Ux-MW
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 22:49:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741146578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=95agMskPgnBc4AkyN44TZ2mvq+7CH/4kl3dTXY02EW8=;
 b=SkW5f8wCkpQQfOGjrGIgAHzQfNaw2D61sbgla5bX8QHl17083Xz72Bg5BfTS3eIH0NVrPc
 tOlH7g5biuIH04hdvu/+wavw/MqRbKy6lBUGmgh2CN7S/c+9f4Bdfm4ZxUTL63Zwvtqxjd
 r2YfWPmJjagfRmDuiSKYEUcd+M4sCtY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-322-p5QP6MnJOwaOB_KSIW3sEQ-1; Tue,
 04 Mar 2025 22:49:32 -0500
X-MC-Unique: p5QP6MnJOwaOB_KSIW3sEQ-1
X-Mimecast-MFC-AGG-ID: p5QP6MnJOwaOB_KSIW3sEQ_1741146571
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AE1E119039CE; Wed,  5 Mar 2025 03:49:31 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.45])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 36F4A1956095; Wed,  5 Mar 2025 03:49:28 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 53/57] docs: disambiguate cross-references
Date: Tue,  4 Mar 2025 22:46:02 -0500
Message-ID: <20250305034610.960147-54-jsnow@redhat.com>
In-Reply-To: <20250305034610.960147-1-jsnow@redhat.com>
References: <20250305034610.960147-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
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

The next patch will engage the qapidoc transmogrifier, which creates a
lot of cross-reference targets. Some of the existing targets
("migration", "qom", "replay") will become ambiguous as a result. Nail
them down more explicitly to prevent ambiguous cross-reference warnings.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/devel/codebase.rst |  6 +++---
 docs/glossary.rst       | 10 +++++-----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/docs/devel/codebase.rst b/docs/devel/codebase.rst
index 4039875ee04..1b09953197b 100644
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
index 693d9855dd1..4fa044bfb6e 100644
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


