Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30215C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:36:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24nd-0002Xn-G1; Thu, 03 Sep 2026 06:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x24nZ-0002Wg-3n
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:36:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x24nX-0005Sg-Jn
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:36:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788431758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r0ZJZz6nbVmbWsxVoto8xEswVIifX0ib/coJwNdot8I=;
 b=KoyI68HOyTwttKn1euAFGH8F0ec6q5iAoex5HLTrQEUuQ/NA8oMtBDx7T/jDgY6XOvv4Pl
 kLt4I/vL7UyK0LB4694ugHjxVSm4k1Hqv+OFxH+VenpSIWgjk5x7FwnymU9F3PuYxNr/a4
 BipRl7Uv6NwYB4nK+bFNQyGAcZLSCY0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-P-FLny9wN8eh1Zpol4bFtw-1; Thu,
 03 Sep 2026 06:35:57 -0400
X-MC-Unique: P-FLny9wN8eh1Zpol4bFtw-1
X-Mimecast-MFC-AGG-ID: P-FLny9wN8eh1Zpol4bFtw_1788431756
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 41AE91829E23; Thu,  3 Sep 2026 10:35:56 +0000 (UTC)
Received: from berrange.csb (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 81A69180049F; Thu,  3 Sep 2026 10:35:54 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 2/4] meson: bump min XCode CLang to 17.0
Date: Thu,  3 Sep 2026 11:35:46 +0100
Message-ID: <20260903103548.2142568-3-berrange@redhat.com>
In-Reply-To: <20260903103548.2142568-1-berrange@redhat.com>
References: <20260903103548.2142568-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The current two latest macOS releases (Tahoe and Sequoia) support
XCode 17.x, XCode 26.x and XCode 27.x is in Beta.

XCode 17.x reported CLang 17.0.0, and this continued with XCode 26.0
stream until XCode 26.4 switched to reporting CLang 21.0.0.

A min XCode CLang of 17.0.0 looks appropriate and matches our current
CI job matrix.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 meson.build | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/meson.build b/meson.build
index 70e2755149..388423e4fd 100644
--- a/meson.build
+++ b/meson.build
@@ -330,8 +330,8 @@ foreach lang : all_languages
     # ok
   elif compiler.get_id() == 'clang' and compiler.compiles('''
       #ifdef __apple_build_version__
-      # if __clang_major__ < 15
-      #  error You need at least XCode Clang v15.0 to compile QEMU
+      # if __clang_major__ < 17
+      #  error You need at least XCode Clang v17.0 to compile QEMU
       # endif
       #else
       # if __clang_major__ < 10
@@ -342,7 +342,7 @@ foreach lang : all_languages
   elif compiler.get_id() == 'emscripten'
     # ok
   else
-    error('You either need GCC v10.4 or Clang v10.0 (or XCode Clang v15.0) to compile QEMU')
+    error('You either need GCC v10.4 or Clang v10.0 (or XCode Clang v17.0) to compile QEMU')
   endif
 endforeach
 
-- 
2.55.0


