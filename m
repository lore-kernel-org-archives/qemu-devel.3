Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6581CC54798
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 11:28:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd7EK-0008Io-5w; Thu, 22 Feb 2024 06:27:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rd7EH-0008Hk-Ub; Thu, 22 Feb 2024 06:27:06 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rd7EG-00052d-3Z; Thu, 22 Feb 2024 06:27:05 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 371BD4FB4F;
 Thu, 22 Feb 2024 14:26:26 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id A62388717B;
 Thu, 22 Feb 2024 14:26:02 +0300 (MSK)
Received: (nullmailer pid 2526179 invoked by uid 1000);
 Thu, 22 Feb 2024 11:26:01 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 13/34] docs: correct typos
Date: Thu, 22 Feb 2024 14:25:40 +0300
Message-Id: <20240222112601.2526057-14-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240222112601.2526057-1-mjt@tls.msk.ru>
References: <20240222112601.2526057-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Correct typos automatically found with the `typos` tool
<https://crates.io/crates/typos>

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
(mjt: trivial fixup)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 docs/devel/ci-jobs.rst.inc      | 2 +-
 docs/devel/docs.rst             | 2 +-
 docs/devel/testing.rst          | 2 +-
 docs/interop/prl-xml.txt        | 2 +-
 docs/interop/vhost-user.rst     | 2 +-
 docs/system/devices/canokey.rst | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/docs/devel/ci-jobs.rst.inc b/docs/devel/ci-jobs.rst.inc
index 4c39cdb2d9..ec33e6ee2b 100644
--- a/docs/devel/ci-jobs.rst.inc
+++ b/docs/devel/ci-jobs.rst.inc
@@ -147,7 +147,7 @@ Set this variable to 1 to create the pipelines, but leave all
 the jobs to be manually started from the UI
 
 Set this variable to 2 to create the pipelines and run all
-the jobs immediately, as was historicaly behaviour
+the jobs immediately, as was the historical behaviour
 
 QEMU_CI_AVOCADO_TESTING
 ~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/docs/devel/docs.rst b/docs/devel/docs.rst
index 50ff0d67f8..a7768b5311 100644
--- a/docs/devel/docs.rst
+++ b/docs/devel/docs.rst
@@ -21,7 +21,7 @@ are processed in two ways:
 
 The syntax of these ``.hx`` files is simple. It is broadly an
 alternation of C code put into the C output and rST format text
-put into the documention. A few special directives are recognised;
+put into the documentation. A few special directives are recognised;
 these are all-caps and must be at the beginning of the line.
 
 ``HXCOMM`` is the comment marker. The line, including any arbitrary
diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index bd132306c1..aa96eacec5 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -728,7 +728,7 @@ For example to setup the HPPA ports builds of Debian::
     EXECUTABLE=(pwd)/qemu-hppa V=1
 
 The ``DEB_`` variables are substitutions used by
-``debian-boostrap.pre`` which is called to do the initial debootstrap
+``debian-bootstrap.pre`` which is called to do the initial debootstrap
 of the rootfs before it is copied into the container. The second stage
 is run as part of the build. The final image will be tagged as
 ``qemu/debian-sid-hppa``.
diff --git a/docs/interop/prl-xml.txt b/docs/interop/prl-xml.txt
index 7031f8752c..cf9b3fba26 100644
--- a/docs/interop/prl-xml.txt
+++ b/docs/interop/prl-xml.txt
@@ -122,7 +122,7 @@ Each Image element has following child elements:
     * Type - image type of the element. It can be:
              "Plain" for raw files.
              "Compressed" for expanding disks.
-    * File - path to image file. Path can be relative to DiskDecriptor.xml or
+    * File - path to image file. Path can be relative to DiskDescriptor.xml or
              absolute.
 
 == Snapshots element ==
diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index ad6e142f23..d1ed39dfa0 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -989,7 +989,7 @@ When reconnecting:
 
    #. If ``d.flags`` is not equal to the calculated flags value (means
       back-end has submitted the buffer to guest driver before crash, so
-      it has to commit the in-progres update), set ``old_free_head``,
+      it has to commit the in-progress update), set ``old_free_head``,
       ``old_used_idx``, ``old_used_wrap_counter`` to ``free_head``,
       ``used_idx``, ``used_wrap_counter``
 
diff --git a/docs/system/devices/canokey.rst b/docs/system/devices/canokey.rst
index cfa6186e48..7f3664963f 100644
--- a/docs/system/devices/canokey.rst
+++ b/docs/system/devices/canokey.rst
@@ -14,7 +14,7 @@ CanoKey [1]_ is an open-source secure key with supports of
 All these platform-independent features are in canokey-core [3]_.
 
 For different platforms, CanoKey has different implementations,
-including both hardware implementions and virtual cards:
+including both hardware implementations and virtual cards:
 
 * CanoKey STM32 [4]_
 * CanoKey Pigeon [5]_
-- 
2.39.2


