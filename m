Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E03C88E7D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 08:53:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Otz-00052q-Up; Tue, 15 Sep 2026 04:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x6Ots-000513-SI
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 04:52:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x6Otr-0002hr-Fg
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 04:52:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789462342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jpx0mZVTq5VKGYrqBMfaSmRma0Q8RgW9IcUiR3TGX+Y=;
 b=gtbt/UvSMGJzDTgn+NZ1MzZCjXOtmyYcX8FsWuxZ4h4K34+E5QWEdUX9rg9YvdSolp+v9X
 /7rHMHMlpslWrC+vhrihZUDw4IzzAJP6/OZA663L2DKVGs9HSJvUw8KBegEKe4g76jMHXC
 12KpPQCYx2wWVSCy6yYMXesrZybszAs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-Ut4tgC-uPsKJ4_lRifRATA-1; Tue,
 15 Sep 2026 04:52:21 -0400
X-MC-Unique: Ut4tgC-uPsKJ4_lRifRATA-1
X-Mimecast-MFC-AGG-ID: Ut4tgC-uPsKJ4_lRifRATA_1789462340
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F08231953976; Tue, 15 Sep 2026 08:52:19 +0000 (UTC)
Received: from berrange.csb (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 06923426; Tue, 15 Sep 2026 08:52:17 +0000 (UTC)
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 1/5] tests/vm: drop redundant ';
 ' at end of each shell command
Date: Tue, 15 Sep 2026 09:52:09 +0100
Message-ID: <20260915085213.139944-2-berrange@redhat.com>
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
Reply-to:  =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
From:  =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The newline implicitly separates every command, and the one case
where two comamnds were on the same line can trivially be split.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/vm/netbsd | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tests/vm/netbsd b/tests/vm/netbsd
index 45afe675e1..a9879f6146 100755
--- a/tests/vm/netbsd
+++ b/tests/vm/netbsd
@@ -64,15 +64,16 @@ class NetBSDVM(basevm.BaseVM):
     ]
 
     BUILD_SCRIPT = """
-        set -e;
+        set -e
         rm -rf /home/qemu/qemu-test.*
-        cd $(mktemp -d /home/qemu/qemu-test.XXXXXX);
-        mkdir src build; cd src;
-        tar -xf /dev/rld1a;
+        cd $(mktemp -d /home/qemu/qemu-test.XXXXXX)
+        mkdir src build
+        cd src
+        tar -xf /dev/rld1a
         cd ../build
         ../src/configure --disable-opengl --extra-ldflags=-L/usr/pkg/lib \
-                          --extra-cflags=-I/usr/pkg/include {configure_opts};
-        gmake --output-sync -j{jobs} {target} {verbose};
+                         --extra-cflags=-I/usr/pkg/include {configure_opts}
+        gmake --output-sync -j{jobs} {target} {verbose}
     """
     poweroff = "/sbin/poweroff"
 
-- 
2.55.0


