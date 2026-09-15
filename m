Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE5FC88E53
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 08:53:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Ou8-00054x-Vg; Tue, 15 Sep 2026 04:52:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x6Ou4-00053Q-H8
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 04:52:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x6Ou1-0002jx-Mx
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 04:52:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789462352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p1R8zRjtTbyqQaAnVSGvz+wcJmf/OCxpjN5ua0lRRJg=;
 b=cTpzZxctCGdlU9HfYJ43zDP80u13fcK2K0ZqUW9EE9Dhzb3ETcA9ztrsEOS1igVgbFCKSk
 PztW9Hq9PeSv939ZKKzDCxxEUseF4Y57UupdHe63tBNBqJwrzO49zzN3dSDzo/KPMi6BAu
 wIgppstOwFB1vOmzOF96TMRsENNbCS0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-264-3_5NIUnCPQa1aMJ8XOxCDA-1; Tue,
 15 Sep 2026 04:52:31 -0400
X-MC-Unique: 3_5NIUnCPQa1aMJ8XOxCDA-1
X-Mimecast-MFC-AGG-ID: 3_5NIUnCPQa1aMJ8XOxCDA_1789462350
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D606919540DF; Tue, 15 Sep 2026 08:52:29 +0000 (UTC)
Received: from berrange.csb (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C3E535C0; Tue, 15 Sep 2026 08:52:27 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 5/5] meson: bump min GCC to 12.0
Date: Tue, 15 Sep 2026 09:52:13 +0100
Message-ID: <20260915085213.139944-6-berrange@redhat.com>
In-Reply-To: <20260915085213.139944-1-berrange@redhat.com>
References: <20260915085213.139944-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This is a slight violation of our platform support policy since
current NetBSD only has GCC 10.4 as its system compiler. It
does, however, have new enough CLang and newer GCC versions can
be opted-in.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 meson.build     | 4 ++--
 tests/vm/netbsd | 6 +++++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/meson.build b/meson.build
index fc1bb685ab..9845317b73 100644
--- a/meson.build
+++ b/meson.build
@@ -326,7 +326,7 @@ endif
 
 foreach lang : all_languages
   compiler = meson.get_compiler(lang)
-  if compiler.get_id() == 'gcc' and compiler.version().version_compare('>=10.4')
+  if compiler.get_id() == 'gcc' and compiler.version().version_compare('>=12.0')
     # ok
   elif compiler.get_id() == 'clang' and compiler.compiles('''
       #ifdef __apple_build_version__
@@ -342,7 +342,7 @@ foreach lang : all_languages
   elif compiler.get_id() == 'emscripten'
     # ok
   else
-    error('You either need GCC v10.4 or Clang v17.0 (or XCode Clang v17.0) to compile QEMU')
+    error('You either need GCC v12.0 or Clang v17.0 (or XCode Clang v17.0) to compile QEMU')
   endif
 endforeach
 
diff --git a/tests/vm/netbsd b/tests/vm/netbsd
index a9879f6146..749116d3dc 100755
--- a/tests/vm/netbsd
+++ b/tests/vm/netbsd
@@ -61,6 +61,9 @@ class NetBSDVM(basevm.BaseVM):
 
         # libs: networking
         "libslirp",
+
+        # Until system GCC is updated to >= 12.0
+        "clang",
     ]
 
     BUILD_SCRIPT = """
@@ -72,7 +75,8 @@ class NetBSDVM(basevm.BaseVM):
         tar -xf /dev/rld1a
         cd ../build
         ../src/configure --disable-opengl --extra-ldflags=-L/usr/pkg/lib \
-                         --extra-cflags=-I/usr/pkg/include {configure_opts}
+                         --extra-cflags=-I/usr/pkg/include {configure_opts} \
+                         --cc=clang
         gmake --output-sync -j{jobs} {target} {verbose}
     """
     poweroff = "/sbin/poweroff"
-- 
2.55.0


