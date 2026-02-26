Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15961FC5912
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 08:47:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvX14-0005CW-A7; Thu, 26 Feb 2026 03:46:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vvX13-00059X-42
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 03:46:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vvX0z-00057C-2M
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 03:46:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772095591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lo6thbzL5M+bBo8LMBzQOCPXTH1vCLMmvXDu0opS2zo=;
 b=ZPz08SFmykiQiIRgwqz8l4sXf9Ol1z+/dGMy47+rHL21IRyC+hUhF8/0NTIxWNIXmqGBPY
 nKDfkSoyHgtbKqapAQc8TVdU84/lvsjoW8iGFV4zrLUCifsg/v4xa4zbVneE19HCIg7Q5J
 t6GBinkMy6yTrCk00L8n9MmPtB7HZ4M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-488-Ne-5l52kME2jOLWTCzWz1w-1; Thu,
 26 Feb 2026 03:46:26 -0500
X-MC-Unique: Ne-5l52kME2jOLWTCzWz1w-1
X-Mimecast-MFC-AGG-ID: Ne-5l52kME2jOLWTCzWz1w_1772095585
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BDBCD1956050; Thu, 26 Feb 2026 08:46:24 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.225.23])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 24CE519560B5; Thu, 26 Feb 2026 08:46:20 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 2/4] tests/qtest: Remove the microblazeel target from the
 qtests
Date: Thu, 26 Feb 2026 09:46:04 +0100
Message-ID: <20260226084608.11251-3-thuth@redhat.com>
In-Reply-To: <20260226084608.11251-1-thuth@redhat.com>
References: <20260226084608.11251-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78, SPF_HELO_PASS=-0.001,
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

From: Thomas Huth <thuth@redhat.com>

The "petalogix-ml605" boot-serial-test can be run with the
"microblaze" target. The remaining tests can simply be dropped
now that we are going to remove the "microblazeel" target.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/boot-serial-test.c  | 2 +-
 tests/qtest/machine-none-test.c | 1 -
 tests/qtest/meson.build         | 2 --
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/tests/qtest/boot-serial-test.c b/tests/qtest/boot-serial-test.c
index a05d26ee996..bcd0a9c50e7 100644
--- a/tests/qtest/boot-serial-test.c
+++ b/tests/qtest/boot-serial-test.c
@@ -186,7 +186,7 @@ static const testdef_t tests[] = {
     { "m68k", "next-cube", "", "TT", sizeof(bios_nextcube), 0, bios_nextcube },
     { "microblaze", "petalogix-s3adsp1800", "", "TT",
       sizeof(kernel_pls3adsp1800), kernel_pls3adsp1800 },
-    { "microblazeel", "petalogix-ml605", "", "TT",
+    { "microblaze", "petalogix-ml605", "", "TT",
       sizeof(kernel_plml605), kernel_plml605 },
     { "arm", "raspi2b", "", "TT", sizeof(bios_raspi2), 0, bios_raspi2 },
     { "aarch64", "virt", "-cpu max", "TT", sizeof(kernel_aarch64),
diff --git a/tests/qtest/machine-none-test.c b/tests/qtest/machine-none-test.c
index b6a87d27edb..c1e22dcecc7 100644
--- a/tests/qtest/machine-none-test.c
+++ b/tests/qtest/machine-none-test.c
@@ -32,7 +32,6 @@ static struct arch2cpu cpus_map[] = {
     { "alpha", "ev67" },
     { "m68k", "m5206" },
     { "microblaze", "any" },
-    { "microblazeel", "any" },
     { "mips", "4Kc" },
     { "mipsel", "I7200" },
     { "mips64", "20Kc" },
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 25fdbc79801..ba9f59d2f8f 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -159,8 +159,6 @@ qtests_m68k = ['boot-serial-test'] + \
 qtests_microblaze = ['boot-serial-test'] + \
   qtests_filter
 
-qtests_microblazeel = qtests_microblaze
-
 qtests_mips = \
   qtests_filter + \
   (config_all_devices.has_key('CONFIG_ISA_TESTDEV') ? ['endianness-test'] : []) +            \
-- 
2.53.0


