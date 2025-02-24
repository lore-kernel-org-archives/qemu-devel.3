Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE0EC021B6
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 03:39:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmPIp-0001iu-Nq; Sun, 23 Feb 2025 22:38:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tmPIO-0001Qc-VU
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 22:38:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tmPIM-0005S5-OF
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 22:38:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740368292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NbNayGZzT5MkWdIwYFTlZTtHA+MFXV5ILRIOuKh2nCU=;
 b=XgUl6CKCJSf1PRF8A7xTHpsUkcfHMVpRfOikh7TvXrOQLoUtCSO8YcRQcXQUSq40wFLCb4
 FSsZTXzlpZmHXv5HX4eCsf7WExj9y1QR0E5oh1Q+yzedYUcgGkv0KyNaqReqkLuqtA24Md
 n4DaP8Wur71LFk/x2KTe8ED9kFwkt00=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-we2NwQSvMS28V5v6NkXWxQ-1; Sun,
 23 Feb 2025 22:38:09 -0500
X-MC-Unique: we2NwQSvMS28V5v6NkXWxQ-1
X-Mimecast-MFC-AGG-ID: we2NwQSvMS28V5v6NkXWxQ_1740368288
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DBD361800873; Mon, 24 Feb 2025 03:38:07 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.88])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 168FF19560A3; Mon, 24 Feb 2025 03:38:05 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 10/10] docs: disambiguate cross-references
Date: Sun, 23 Feb 2025 22:37:41 -0500
Message-ID: <20250224033741.222749-11-jsnow@redhat.com>
In-Reply-To: <20250224033741.222749-1-jsnow@redhat.com>
References: <20250224033741.222749-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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

These references are not in and of themselves problems at the moment,
however, the forthcoming qapidoc conversion series will begin adding
cross-reference targets that conflict with these existing targets.

As a result, cross-references such as "migration", "qom", "replay" will
become ambiguous. Modify these references to be more explicit to prevent
"ambiguous cross-reference" warnings in the future.

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


