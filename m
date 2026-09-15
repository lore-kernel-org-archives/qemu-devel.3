Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 442DCC88E73
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 08:53:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Ou9-000556-6H; Tue, 15 Sep 2026 04:52:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x6Ou4-00053R-KP
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 04:52:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x6Ou1-0002jh-O8
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 04:52:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789462352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AgJ64QXlNlzjSyv0IPNZDzfp+fVA8HdIWNqJBXQ0Doo=;
 b=AJoQUlWCEdj/2+FbYGUrrxi9Vd26h5w47J1geqfLDVDXohtdwnCFBYglAIue1fJkqueJai
 EPNq+DnJ7NLMzyx+26kdAjV/uu59hl7N5MqGw6kK7eDKZoPQQDkzEw7SohqyWXQLaU53L6
 sz1THBP8u3qpY9gKZj+Pn1lhuo633I0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-258-8Zy5-aS5Ma6P7ztTUiOg-A-1; Tue,
 15 Sep 2026 04:52:28 -0400
X-MC-Unique: 8Zy5-aS5Ma6P7ztTUiOg-A-1
X-Mimecast-MFC-AGG-ID: 8Zy5-aS5Ma6P7ztTUiOg-A_1789462347
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 42442195DBBB; Tue, 15 Sep 2026 08:52:27 +0000 (UTC)
Received: from berrange.csb (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3415D766; Tue, 15 Sep 2026 08:52:25 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 4/5] meson: bump min upstream CLang to 17.0
Date: Tue, 15 Sep 2026 09:52:12 +0100
Message-ID: <20260915085213.139944-5-berrange@redhat.com>
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

Per our supported platform policy, oldest distros we target
have the following CLang available:

          Fedora 43: 21.1.2
    CentOS Stream 9: 22.1.8
          Debian 13: 17.0.6
       Ubuntu 24.04: 20.1.2
            OpenBSD: 22.1.8
            FreeBSD: 23.1.0
             NetBSD: 21.1.8
 OpenSUSE Leap 16.0: 19.1.7

Thus Debian is our prime constraint and we can move from 10.0
to 17.0 as our min version.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 meson.build | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/meson.build b/meson.build
index ff181e7021..fc1bb685ab 100644
--- a/meson.build
+++ b/meson.build
@@ -334,15 +334,15 @@ foreach lang : all_languages
       #  error You need at least XCode Clang v17.0 to compile QEMU
       # endif
       #else
-      # if __clang_major__ < 10
-      #  error You need at least Clang v10.0 to compile QEMU
+      # if __clang_major__ < 17
+      #  error You need at least Clang v17.0 to compile QEMU
       # endif
       #endif''')
     # ok
   elif compiler.get_id() == 'emscripten'
     # ok
   else
-    error('You either need GCC v10.4 or Clang v10.0 (or XCode Clang v17.0) to compile QEMU')
+    error('You either need GCC v10.4 or Clang v17.0 (or XCode Clang v17.0) to compile QEMU')
   endif
 endforeach
 
-- 
2.55.0


