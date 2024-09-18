Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F075ECDD54F
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 18:33:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqzTF-0001up-5p; Wed, 18 Sep 2024 14:32:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqzTA-0001iM-LI
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 14:32:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqzT8-0001zu-Vp
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 14:32:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726684318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uETirslRtXhm+HFuN3lM3k4dcuoD9xd+DaieOslfWmM=;
 b=HevbksN63CUp+QI+rSuOWZHmHH7Kfpugyyx6xrPBzAyhCXQOf6FrZPT60BWhiBI2dEH+0o
 XVX/2Au5mgS7tCpmsSyE8xNFqW0X7aE0hmdBFXI8JokkXoI7+SvWaIbI/oDgDfLFNiF8Zf
 gewbB7M8ASrxBIKt0zi1MJK1+aO+0UM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-wmar7DSVNKKYN-9stHlkfw-1; Wed, 18 Sep 2024 14:31:57 -0400
X-MC-Unique: wmar7DSVNKKYN-9stHlkfw-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6c5bd369336so15068796d6.2
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 11:31:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726684316; x=1727289116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uETirslRtXhm+HFuN3lM3k4dcuoD9xd+DaieOslfWmM=;
 b=Dd0I8tnQjrL9lc2w6UStDNUTTOLs4LiPdJBuyPuJgMv/FIQOXJ7O+WAHiUwFL9nUAK
 uXPju1p0Y0SuR4GpsWD1X43NRI0JshOFyE0tNn4OgeXh6fmd1+l+ZNmkKNpDjCCe5fbc
 uNcOBtfZZ0GNX/92WzO3BJOCbAHIeH7XtedxeMoHn0rZVeAJxf8IuDqcOgdy+CBLfGc7
 31ymPDGJ4mKlinZ+wjZIdYkH2jGZ0jpHvyS+3LiEAswD+qvxPBDIbyR6hAt0D5X2NabC
 XWZz+uZUIr+Cj/wsMXRxLZgFhUMBo76FeMbMvf0nKDodYqM0gpjqZANBHNOfNtfE4pWi
 Wsdg==
X-Gm-Message-State: AOJu0YzCK01OlJcd3EagOePQILOZpBtgw0cdjRGnBXG33kYm1tOLcekp
 sYtBGq6I/vpj0WuaokvzqYnFfdXraoJXXCWap38bY3HkC1aWMQ56FdOBQcscTvzEW5rxLii3ONT
 2kGYWC/aParL4NhbSfo5SCchgk5qiYtUNg6dJBBJ2mJL61en3regYkIjRMK1OjFuX/fluhuDjWr
 +wjz3TqGFAaXUFc620UCfHaO8GS4kBMulBTQ==
X-Received: by 2002:a05:6214:3287:b0:6c5:537a:ce43 with SMTP id
 6a1803df08f44-6c573539d30mr283695866d6.26.1726684315938; 
 Wed, 18 Sep 2024 11:31:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPGA/4cJDt3GPNtANhhFUTyElR/0b5sIbrd0sFs7rsYtic57E5PyKvNHw5ZKsFSx0/lG4xgw==
X-Received: by 2002:a05:6214:3287:b0:6c5:537a:ce43 with SMTP id
 6a1803df08f44-6c573539d30mr283695596d6.26.1726684315543; 
 Wed, 18 Sep 2024 11:31:55 -0700 (PDT)
Received: from x1n.. (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c75e494a28sm30486d6.68.2024.09.18.11.31.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 11:31:54 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 peterx@redhat.com
Subject: [PULL v2 1/6] tests/qtest/migration: Move a couple of slow tests
 under g_test_slow
Date: Wed, 18 Sep 2024 14:31:46 -0400
Message-ID: <20240918183151.6413-2-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240918183151.6413-1-peterx@redhat.com>
References: <20240918183151.6413-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Fabiano Rosas <farosas@suse.de>

The xbzrel and vcpu_dirty_limit are the two slowest tests from
migration-test. Move them under g_test_slow() to save about 40s per
run.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240911145204.17692-1-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration-test.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index d6768d5d71..814ec109a6 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -3803,8 +3803,10 @@ int main(int argc, char **argv)
 
     migration_test_add("/migration/precopy/unix/plain",
                        test_precopy_unix_plain);
-    migration_test_add("/migration/precopy/unix/xbzrle",
-                       test_precopy_unix_xbzrle);
+    if (g_test_slow()) {
+        migration_test_add("/migration/precopy/unix/xbzrle",
+                           test_precopy_unix_xbzrle);
+    }
     migration_test_add("/migration/precopy/file",
                        test_precopy_file);
     migration_test_add("/migration/precopy/file/offset",
@@ -3979,7 +3981,7 @@ int main(int argc, char **argv)
     if (g_str_equal(arch, "x86_64") && has_kvm && kvm_dirty_ring_supported()) {
         migration_test_add("/migration/dirty_ring",
                            test_precopy_unix_dirty_ring);
-        if (qtest_has_machine("pc")) {
+        if (qtest_has_machine("pc") && g_test_slow()) {
             migration_test_add("/migration/vcpu_dirty_limit",
                                test_vcpu_dirty_limit);
         }
-- 
2.45.0


