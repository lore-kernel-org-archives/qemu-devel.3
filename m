Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4CF4F45A08
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:27:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHTx-0007vy-6j; Fri, 10 Apr 2026 15:25:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHTv-0007qA-Gg
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:25:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHTr-00037T-ID
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:25:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775849122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O4VieNyitoZM6vdnySp+EAtZC0C03hqFOmVIR3JD8Rw=;
 b=cSm2Q/+4VlQKfNKb2HSJvK1h1jMjWXxm/w/Q/7CVd4Q0t4mjbxMXfpp5W0P63qvqfQYiZt
 Yf4l3rSFT8T9ToxDYPd74THgsN4rtxiqwRMyoVp4bsarRWzZQvQV4qtU2+PXUWoFU8+NLJ
 Fo/zua4puRyP5+0ktrMXoW//kjyJvn4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-115-XPDv3GFoNcOJlRkOUbDSbQ-1; Fri,
 10 Apr 2026 15:25:19 -0400
X-MC-Unique: XPDv3GFoNcOJlRkOUbDSbQ-1
X-Mimecast-MFC-AGG-ID: XPDv3GFoNcOJlRkOUbDSbQ_1775849118
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 563EE1956061; Fri, 10 Apr 2026 19:25:18 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C03DF180049F; Fri, 10 Apr 2026 19:25:16 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 10 Apr 2026 23:19:26 +0400
Subject: [PATCH v2 64/67] tests: rename the dbus-daemon helper script
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-qemu-vnc-v2-64-231416f76dc3@redhat.com>
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
In-Reply-To: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1301;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=LH4JWYWHaNyhEr5pqXX3nN+pvRwn2yT8dc9n8/gsAp4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp2U0XWWdspLuY/TJz6CKPFIbtEQyK7G70UJjyS
 Cej4vGf86qJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCadlNFwAKCRDa6OEJdZac
 5atnD/9MADWDaqtslJwF+1E6winsuIFS8JUml4hwU9T+Pi1wXbKGSLTID/Wxf1sLnFk57rV+BQ+
 N6a6K0OB1kKsmU04Jax07vi+Hzt4gZcUfSCcZm0x23cuEdmv8VujOIrFlqWK/WXGpAvfeUlxFLQ
 mel6dWspVIOUmohjZw8ZVA2X5W6rOJoHRGfI5iBcBmGpLfXpqWfSb8X/VsYep/jhd0+KITItbwb
 c9prdr2tRrlDxAc6TEZ+q7+/Epaf0mM1Rdv3JRroYkb522m8rGwWZcoiqKKYs1RIi58I5egeR2o
 P/m0WdBtmF6yo7w8/zCai0TiRC9R2L3oM6IWSU223zKnqYKygeP1dUNIX9DPPJ2NwRJATzB419A
 0L2BNOdkBklojz/MlXFlJXknGJW0OSmG435HnQRo+5Plxln7p81mBR0eU4eO4vpBn3YdCTwuTM0
 Fok1ZjP5Pf5pZnxWgMWP5Zk5Qiehz+NQ6vgSR35CFLW2Uxx9BV2FEosifU+I+mwyVum3Ws70Qmi
 zljgreUFdcKFJN+1p8nCYxbcHPKW++i8905rX1SezyDCcbgbbBD6itNsqhKIVujEEO55m0t2esN
 VY37biwobjRbmHUFD01bYJhLzwlxF7QVH9/ig8+/GklXSwL5htOQ3ZpMArzULmx04i9dIli3M0m
 0YAvlGAFsM1dftA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

The following patches are going to use it for qemu-vnc.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/{dbus-vmstate-daemon.sh => dbus-daemon.sh} | 0
 tests/qtest/meson.build                          | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/dbus-vmstate-daemon.sh b/tests/dbus-daemon.sh
similarity index 100%
rename from tests/dbus-vmstate-daemon.sh
rename to tests/dbus-daemon.sh
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index be4fa627b5f..b735f55fc40 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -435,7 +435,7 @@ foreach dir : target_dirs
     qtest_env.set('QTEST_QEMU_IMG', './qemu-img')
     test_deps += [qemu_img]
   endif
-  qtest_env.set('G_TEST_DBUS_DAEMON', meson.project_source_root() / 'tests/dbus-vmstate-daemon.sh')
+  qtest_env.set('G_TEST_DBUS_DAEMON', meson.project_source_root() / 'tests/dbus-daemon.sh')
   qtest_env.set('QTEST_QEMU_BINARY', './qemu-system-' + target_base)
   if have_tools and have_vhost_user_blk_server
     qtest_env.set('QTEST_QEMU_STORAGE_DAEMON_BINARY', './storage-daemon/qemu-storage-daemon')

-- 
2.53.0


