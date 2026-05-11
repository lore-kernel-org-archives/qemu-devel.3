Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA2CCD37B5
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 10:46:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMO9t-0000p9-Sa; Mon, 11 May 2026 06:46:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wMO9p-0000oF-Nj
 for qemu-devel@nongnu.org; Mon, 11 May 2026 06:46:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wMO9o-0002Vf-8c
 for qemu-devel@nongnu.org; Mon, 11 May 2026 06:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778496399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pZmM5bcLaTlJ0c4pf5pfWQL4WC0xQwp16a5unPkAfuU=;
 b=JDlsB6xowJPfcxU/KE8KSGzgDI6rB5hP4olbSTe11Pl7ptE7iBfCZb1GxtAcZjeUd1yXkF
 5AN/d7/NCINuAzQJLggBn7SQ1REMkbwVTZ2TojrmAtrJ1V7+C1HKIHkV2vI7JQ4rH4QSt1
 MtpnyRBZbvmaLcbbIlRvIiVCfgYDWSU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-56-n2RWiLlJM4ehORe8_X0R8A-1; Mon,
 11 May 2026 06:46:38 -0400
X-MC-Unique: n2RWiLlJM4ehORe8_X0R8A-1
X-Mimecast-MFC-AGG-ID: n2RWiLlJM4ehORe8_X0R8A_1778496397
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 136A7195609F; Mon, 11 May 2026 10:46:37 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C459718004A3; Mon, 11 May 2026 10:46:35 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH] meson: drop sphix-build < 1.7 compatiblity check
Date: Mon, 11 May 2026 14:46:29 +0400
Message-ID: <20260511104629.2634357-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Since commit fe791b7fcc ("Python: bump minimum sphinx version to
3.4.3"), we no longer support building with sphinx-build < 3.4.3

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 docs/meson.build | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/docs/meson.build b/docs/meson.build
index 7e54b01e6a0..f39e3e8b065 100644
--- a/docs/meson.build
+++ b/docs/meson.build
@@ -4,24 +4,12 @@ sphinx_build = find_program(fs.parent(python.full_path()) / 'sphinx-build',
 # Check if tools are available to build documentation.
 build_docs = false
 if sphinx_build.found()
-  SPHINX_ARGS = ['env', 'CONFDIR=' + qemu_confdir, sphinx_build, '-q']
+  SPHINX_ARGS = ['env', 'CONFDIR=' + qemu_confdir, sphinx_build, '-q', '-j', 'auto']
   # If we're making warnings fatal, apply this to Sphinx runs as well
   if get_option('werror')
     SPHINX_ARGS += [ '-W', '-Dkerneldoc_werror=1' ]
   endif
 
-  sphinx_version = run_command(SPHINX_ARGS + ['--version'],
-                               check: true).stdout().split()[1]
-  if sphinx_version.version_compare('>=1.7.0')
-    SPHINX_ARGS += ['-j', 'auto']
-  else
-    nproc = find_program('nproc')
-    if nproc.found()
-      jobs = run_command(nproc, check: true).stdout()
-      SPHINX_ARGS += ['-j', jobs]
-    endif
-  endif
-
   # This is a bit awkward but works: create a trivial document and
   # try to run it with our configuration file (which enforces a
   # version requirement). This will fail if sphinx-build is too old.
-- 
2.54.0


