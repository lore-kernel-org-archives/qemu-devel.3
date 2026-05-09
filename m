Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BF81CD3445
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 17:18:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLlIj-0001Y8-0t; Sat, 09 May 2026 13:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wLlIh-0001Jv-4I
 for qemu-devel@nongnu.org; Sat, 09 May 2026 13:17:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wLlIf-0005TN-L4
 for qemu-devel@nongnu.org; Sat, 09 May 2026 13:17:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778347033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wrfgt2+O9xDLwTBdVq4+Tq0EQdn5EuB/u5Gnsjp4egI=;
 b=H96hF8dZNtnpT/3q8bhxwv8EBXQtlvR2nBNywlaBkLzv/3lfSL9FSv37BIfQFcUADjunTa
 3zhTbPGjcdHZUMqWMGL6VomkFB6/Xm+W8KHEz4k8FFF7q0CsIhgD192mOI6n3yjkxWBLzo
 RKMfiGWwoqDaz8U1VtMerStfzyEUdUk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-300-qkJ2ub0MP8GmEOow1gOUtA-1; Sat,
 09 May 2026 13:17:09 -0400
X-MC-Unique: qkJ2ub0MP8GmEOow1gOUtA-1
X-Mimecast-MFC-AGG-ID: qkJ2ub0MP8GmEOow1gOUtA_1778347028
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4E39718005B3; Sat,  9 May 2026 17:17:08 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DC92819560A2; Sat,  9 May 2026 17:17:06 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL v2 31/33] tests/qtest: drop DBUS_VMSTATE_TEST_TMPDIR
Date: Sat,  9 May 2026 21:13:52 +0400
Message-ID: <20260509171356.1157879-32-marcandre.lureau@redhat.com>
In-Reply-To: <20260509171356.1157879-1-marcandre.lureau@redhat.com>
References: <20260509171356.1157879-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

It can rely on the location of the temporary configuration instead, so
we don't have to set that environment variable on every test.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qtest/dbus-vmstate-test.c | 2 --
 tests/dbus-daemon.sh            | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/tests/qtest/dbus-vmstate-test.c b/tests/qtest/dbus-vmstate-test.c
index 15c35e7c0fa..339b731ceb5 100644
--- a/tests/qtest/dbus-vmstate-test.c
+++ b/tests/qtest/dbus-vmstate-test.c
@@ -395,8 +395,6 @@ main(int argc, char **argv)
         exit(1);
     }
 
-    g_setenv("DBUS_VMSTATE_TEST_TMPDIR", workdir, true);
-
     migration_test_add("/dbus-vmstate/without-list",
                        test_dbus_vmstate_without_list);
     migration_test_add("/dbus-vmstate/with-list",
diff --git a/tests/dbus-daemon.sh b/tests/dbus-daemon.sh
index 474e2501548..c4a50c73774 100755
--- a/tests/dbus-daemon.sh
+++ b/tests/dbus-daemon.sh
@@ -26,7 +26,7 @@ write_config()
     cat > "$CONF" <<EOF
 <busconfig>
   <type>session</type>
-  <listen>unix:tmpdir=$DBUS_VMSTATE_TEST_TMPDIR</listen>
+  <listen>unix:tmpdir=$(dirname "$CONF")</listen>
 
   <policy context="default">
      <!-- Holes must be punched in service configuration files for
-- 
2.54.0


