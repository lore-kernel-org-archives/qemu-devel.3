Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD235606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.a=rsa-sha256 header.s=kylie header.b=vAWXdbSM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVWGq-0000oB-3L; Mon, 23 Nov 2026 10:47:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <243b8fb09d4ca788fe531f8ab49be7b4578e7a3b@kylie.crudebyte.com>)
 id 1xVWGh-0000hv-8c
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:47:47 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <243b8fb09d4ca788fe531f8ab49be7b4578e7a3b@kylie.crudebyte.com>)
 id 1xVWGf-0005Mo-LU
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:47:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=kM97I2SiaRm3nVDJRXcOgNC6LAO7FQ1V0WndtPpSIXE=; b=vAWXd
 bSMagIHttXjwgYhdrWvikBw4v5kA1IhaGKUkHwBdv5kaoNabxAYdbZfPeW6ARbMfqC2bOMAtrioCN
 h7fKVECbqoee1Mr/SONLAbsyKhz769PCjhLUU2SG8ap/iuPoQhNTbZvq1cIdFD/LrYd7GfS+kPOxw
 xuSqQNdT1+ApiXojKvhq8oEhYGLggrdBvEu+nU8543sdRMS3Mtytxq1HRJn92UhIJ2/HUVewqAfNo
 3GnlPGCeStCy7kDvenzQOzjQTyIYGEMAgXR+NjZ2s1Y6GVOBIL1OvvAkkWqqwiqKpPD4pKLsdYy99
 DYIhHYoGFxNw/uZ3Pwx+GLZZIEx1TNltGi3XH3ISnY92ZJLsQZVxWoIdWHVe2aDBeJgF3QWfISSKa
 KMb2goe9uY/zPlzi1lRZwexwaEQOBvvJCEAw7XU4SLtau4WV1usvAz+gHIuoHNy/WXPNCCp8NOqwB
 posQOJAGYqy+lrSf+H6H5bOP+o+qdKqnglCWI9J5pRxxrJIkLIUsvplPVA2jAK491h4PxmNuSAUOJ
 9QsPEwxth9AkSL/QdmmPEusRk1Uj9w0A8rBMQ/DqnFWWpFkxa0/WAH8QIBaT04kjgywdO8iNJ0rSN
 esa9EXTFGZiJoi/yTjzVvsspIqpXlrXr8XrNcqUQBZ+sBKlAoPBSfd2IHlntPA=;
Message-ID: <243b8fb09d4ca788fe531f8ab49be7b4578e7a3b.1795447869.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1795447869.git.qemu_oss@crudebyte.com>
References: <cover.1795447869.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 23 Nov 2026 16:24:56 +0100
Subject: [PATCH 3/7] meson: move 9pfs-util selection to toplevel meson file
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>,
    Paolo Bonzini <pbonzini@redhat.com>,
    "Marc-André Lureau" <marcandre.lureau@redhat.com>,
    "Daniel P. Berrangé" <berrange@redhat.com>,
    Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=243b8fb09d4ca788fe531f8ab49be7b4578e7a3b@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

9p-util-<host>.c are host system dependent function implementations.
For each supported system there is a separate source file implementation
which meson automatically selects.

Move this selection from hw/9pfs/meson.build to toplevel meson.build,
such that hw/9pfs/ and the subsequently added new test suite (under
tests/unit/) can share the selection as variable 'fs_9p_host_util'.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/meson.build |  8 ++------
 meson.build         | 10 ++++++++++
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/hw/9pfs/meson.build b/hw/9pfs/meson.build
index 91b51af838..3232aa4aaa 100644
--- a/hw/9pfs/meson.build
+++ b/hw/9pfs/meson.build
@@ -13,12 +13,8 @@ fs_ss.add(files(
   'coth.c',
   'coxattr.c',
 ))
-if host_os == 'darwin'
-  fs_ss.add(files('9p-util-darwin.c'))
-elif host_os == 'freebsd'
-  fs_ss.add(files('9p-util-freebsd.c'))
-elif host_os == 'linux'
-  fs_ss.add(files('9p-util-linux.c'))
+if fs_9p_host_util != ''
+  fs_ss.add(files(fs_9p_host_util))
 endif
 fs_ss.add(when: 'CONFIG_XEN_BUS', if_true: files('xen-9p-backend.c'))
 system_ss.add_all(when: 'CONFIG_FSDEV_9P', if_true: fs_ss)
diff --git a/meson.build b/meson.build
index 4d267e10b5..feeb4a029c 100644
--- a/meson.build
+++ b/meson.build
@@ -2348,6 +2348,16 @@ have_virtfs = get_option('virtfs') \
     .disable_auto_if(not have_tools and not have_system) \
     .allowed()
 
+if host_os == 'linux'
+  fs_9p_host_util = '9p-util-linux.c'
+elif host_os == 'darwin'
+  fs_9p_host_util = '9p-util-darwin.c'
+elif host_os == 'freebsd'
+  fs_9p_host_util = '9p-util-freebsd.c'
+else
+  fs_9p_host_util = ''
+endif
+
 qga_fsfreeze = false
 qga_fstrim = false
 if host_os == 'linux'
-- 
2.47.3


