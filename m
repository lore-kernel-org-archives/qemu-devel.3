Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5AC8CAC5A7
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 08:37:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzWbi-0002xX-6L; Fri, 19 Sep 2025 04:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uzWbg-0002xC-Rf
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 04:36:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uzWbe-00021i-EG
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 04:36:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758270996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=I7QpmFqByfXSGbut223Bkx57Iv2EkBrIKj3x/sFSAvk=;
 b=gDzAjyr5DWVHR0O9zSZ9itGfssv20eeaJ4KoYMdLYbP++uvn87JsDknsWpWSyxGvQUhwwJ
 p81vjDU+eRIultiOfYzygZfNLz7da4X223YKqub3wRAbsywwfBuVOd5htERrUaj50WLITX
 DCTbTbYIGqvm161pnXvGMU96ptkUVnY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-360-ub-z1p9bPFOjgZTBNV4sNA-1; Fri,
 19 Sep 2025 04:36:26 -0400
X-MC-Unique: ub-z1p9bPFOjgZTBNV4sNA-1
X-Mimecast-MFC-AGG-ID: ub-z1p9bPFOjgZTBNV4sNA_1758270985
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3BA44195609F
 for <qemu-devel@nongnu.org>; Fri, 19 Sep 2025 08:36:25 +0000 (UTC)
Received: from avogadro.redhat.com (unknown [10.44.33.250])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C0B381800447; Fri, 19 Sep 2025 08:36:23 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com
Subject: [PATCH] docs: use the pyvenv version of Meson
Date: Fri, 19 Sep 2025 10:36:21 +0200
Message-ID: <20250919083621.86615-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The version in the system might be too old for QEMU; this will be
especially true if Rust is going to be enabled by default.

Adjust the docs to suggest using pyvenv/bin/meson.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/build-system.rst | 2 +-
 docs/devel/rust.rst         | 2 +-
 docs/system/devices/igb.rst | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
index 2c884197a20..6204aa6a72e 100644
--- a/docs/devel/build-system.rst
+++ b/docs/devel/build-system.rst
@@ -450,7 +450,7 @@ are run with ``make bench``.  Meson test suites such as ``unit`` can be ran
 with ``make check-unit``, and ``make check-tcg`` builds and runs "non-Meson"
 tests for all targets.
 
-If desired, it is also possible to use ``ninja`` and ``meson test``,
+If desired, it is also possible to use ``ninja`` and ``pyvenv/bin/meson test``,
 respectively to build emulators and run tests defined in meson.build.
 The main difference is that ``make`` needs the ``-jN`` flag in order to
 enable parallel builds or tests.
diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index 13a20e86a16..2f0ab2e2821 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -66,7 +66,7 @@ __ https://mesonbuild.com/Commands.html#devenv
 As shown above, you can use the ``--tests`` option as usual to operate on test
 code.  Note however that you cannot *build* or run tests via ``cargo``, because
 they need support C code from QEMU that Cargo does not know about.  Tests can
-be run via ``meson test`` or ``make``::
+be run via Meson (``pyvenv/bin/meson test``) or ``make``::
 
    make check-rust
 
diff --git a/docs/system/devices/igb.rst b/docs/system/devices/igb.rst
index 71f31cb1160..50f625fd77e 100644
--- a/docs/system/devices/igb.rst
+++ b/docs/system/devices/igb.rst
@@ -54,7 +54,7 @@ directory:
 
 .. code-block:: shell
 
-  meson test qtest-x86_64/qos-test
+  pyvenv/bin/meson test qtest-x86_64/qos-test
 
 ethtool can test register accesses, interrupts, etc. It is automated as an
 functional test and can be run from the build directory with the following
-- 
2.51.0


