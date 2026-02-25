Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 741F7FD3772
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 16:19:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvHbR-0005bo-Tf; Wed, 25 Feb 2026 11:19:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vvHbE-0005aM-Vv
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 11:18:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vvHbD-0005Yn-Jt
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 11:18:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772036334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KwiA/VocsgJE5koLumNzb9lbDO7ZzR8Dp4qZ7x4C91U=;
 b=ipt6d17CAUTvlrwW4ewTUtUCVZ+Lwf8WL8Xlnr0ZN4sKB/kogebRyf78nwFo0LOg/xev/B
 UqY//ca+96swdFPeUYF/mDRjDjYrfEQgT6TZawNZ+Tu23Hm/cnhceV1Oj+DYZo4ABoI0wP
 er1dOpBbnQlxCMHCEMdF3JoS/Qa4eMU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-491-DNVnx9--Pcmnrw38wOHa1A-1; Wed,
 25 Feb 2026 11:18:46 -0500
X-MC-Unique: DNVnx9--Pcmnrw38wOHa1A-1
X-Mimecast-MFC-AGG-ID: DNVnx9--Pcmnrw38wOHa1A_1772036324
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B664A1800378; Wed, 25 Feb 2026 16:18:43 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.158])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8EA6E1800465; Wed, 25 Feb 2026 16:18:38 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: devel@lists.libvirt.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH 2/4] tests/qtest: Remove the microblazeel target from the
 qtests
Date: Wed, 25 Feb 2026 17:18:19 +0100
Message-ID: <20260225161823.1438850-3-thuth@redhat.com>
In-Reply-To: <20260225161823.1438850-1-thuth@redhat.com>
References: <20260225161823.1438850-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


