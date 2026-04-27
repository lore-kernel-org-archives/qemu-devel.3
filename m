Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFED7FF8869
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 09:59:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHIjR-0007pq-HA; Mon, 27 Apr 2026 05:58:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wHIjA-0007k3-JN
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 05:58:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wHIj5-00085c-B1
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 05:58:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777283882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CApNhrC8Uo90IDNwWPD2mDbMfjH7rj94AQmsKwXeTgE=;
 b=MNuLyxdZ0mXt6RzRWBZEoGAhtGomb5WvKlHw6PCxOBiJbCp72yHveJfuC3gmKwbEmi9PN1
 4SEBD2uIWqbsQwnr2yLBZKeb/pF0fITnR3ahcFhDjI/WDw6d/UPNpH0/RH4zc9ealiqpQl
 H7OlmjU0STOrmN7ZIlUVss9ljPQ6UmE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-Ji_DAO2hNBOvZVbcdwZlKQ-1; Mon,
 27 Apr 2026 05:58:00 -0400
X-MC-Unique: Ji_DAO2hNBOvZVbcdwZlKQ-1
X-Mimecast-MFC-AGG-ID: Ji_DAO2hNBOvZVbcdwZlKQ_1777283879
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5AF5218005AB; Mon, 27 Apr 2026 09:57:59 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.48.146])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DFDF23000707; Mon, 27 Apr 2026 09:57:56 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PULL 01/10] meson.build: Bump the minimum GCC version to v10.4
Date: Mon, 27 Apr 2026 11:57:38 +0200
Message-ID: <20260427095747.1070244-2-thuth@redhat.com>
In-Reply-To: <20260427095747.1070244-1-thuth@redhat.com>
References: <20260427095747.1070244-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Thomas Huth <thuth@redhat.com>

Our minimum supported version of GCC used to be v7.4 since we still
wanted to support NetBSD 9.x in the past:

 https://gitlab.com/qemu-project/qemu/-/issues/614
 https://gitlab.com/qemu-project/qemu/-/commit/3830df5f83b9b52d949676

However, NetBSD 10 has already been released since two years ago
(see https://www.netbsd.org/releases/formal-10/NetBSD-10.0.html),
so according to our support policy, starting with QEMU v11.0, we
don't have to take care of the previous major release of NetBSD
anymore.

Looking at the various distros that we take care of (see e.g.
https://repology.org/project/gcc/versions), and the NetBSD 10.0
3rd party package information:

 https://cvsweb.netbsd.org/bsdweb.cgi/src/doc/3RDPARTY?rev=1.1905.2.14;content-type=text%2Fplain;only_with_tag=netbsd-10-0-RELEASE

... it seems like NetBSD 10 has the lowest version of GCC again,
but at least it's GCC 10.4 now. Thus bump our GCC requirement to
this version now.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Acked-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260310155331.320066-1-thuth@redhat.com>
---
 meson.build | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index 096303f021c..7d25b1ec7ef 100644
--- a/meson.build
+++ b/meson.build
@@ -329,7 +329,7 @@ endif
 
 foreach lang : all_languages
   compiler = meson.get_compiler(lang)
-  if compiler.get_id() == 'gcc' and compiler.version().version_compare('>=7.4')
+  if compiler.get_id() == 'gcc' and compiler.version().version_compare('>=10.4')
     # ok
   elif compiler.get_id() == 'clang' and compiler.compiles('''
       #ifdef __apple_build_version__
@@ -345,7 +345,7 @@ foreach lang : all_languages
   elif compiler.get_id() == 'emscripten'
     # ok
   else
-    error('You either need GCC v7.4 or Clang v10.0 (or XCode Clang v15.0) to compile QEMU')
+    error('You either need GCC v10.4 or Clang v10.0 (or XCode Clang v15.0) to compile QEMU')
   endif
 endforeach
 
-- 
2.53.0


