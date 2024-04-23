Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A68F5C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 22:42:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzOnK-0002WO-Ta; Tue, 23 Apr 2024 18:39:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzOmd-0001Tn-2r
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 18:38:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzOmY-00066K-Cl
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 18:38:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713911909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PVnzxCbAuG2GikN/Jbq0cWGmjJHswtb1DxYwcvLfucI=;
 b=Qs3svR8XQp/KPONZ/mU+A2Ht1xrOp48Gnyp1vhLYaXG99Yg0l+7FbW7FYiCK4rV3pMlFle
 3hbCSqdQyjbHS9KOfOXDKUVdocAO22AUvFdv4Oj/A9OxNV7ynjq18DnriiQdvEGNCtvgmx
 KAsV5zuzHbldquvS3vfouyEdAglrHzo=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-l0ITG3qPNMijqwh9LO31aQ-1; Tue, 23 Apr 2024 18:38:28 -0400
X-MC-Unique: l0ITG3qPNMijqwh9LO31aQ-1
Received: by mail-yb1-f200.google.com with SMTP id
 3f1490d57ef6-dc6c5a52a3fso100758276.1
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 15:38:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713911908; x=1714516708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PVnzxCbAuG2GikN/Jbq0cWGmjJHswtb1DxYwcvLfucI=;
 b=lBeWHskZ4PYdS10HONSIptjnYMClv29CnDXCU2+r9CzHmPLT+lyXIVa0RXEmuElXNW
 aaoxIEe0zsxxC0F7L+uBlwM78jHwlsXXnadcNIT7VERHpfQQWp2ZtxEKMn9h40Yq9IRm
 XKL6POFsnVBBnr2Y+/hrnZEmRtsZn5/sJebdYTW+UB3pu3qGBKpMTtqENowGuo9Ktn6Y
 xcplxxr7FnNROJ98BLPsm3/NpCA0So42KO9c9wHZNWK8j3gGMsNqU11UPCsmgHkEW2LP
 6tWXM1WX3pWRV19adC8D6kAOo32izxNJe8+ovuEQ+Ll845wz9NzFSrPrLaIqJbiu1/wP
 NtNA==
X-Gm-Message-State: AOJu0Yxiwru7bnU2y0sqNp28QtMI7nX0tfhC7wnFk05p/Gi3tv2y+O/h
 NHNuVL0SqheJrlaD5O7yG6xLs5TNe2AnRb0NWEmo01Gvp0Ak0wcJ6nZeJ6q2cPVySsPs2ePDach
 YhFnbhPSd8erCWd0PPyvtl/76wP9skcwLrtcydru/6KI9cqyyj9Bu5oN54l1RfbbPE9YnQrrcl3
 DRZcqeXLZBQeWTws+N0nZIQmTGBVZr74pK1Q==
X-Received: by 2002:a25:6913:0:b0:dcc:f9ce:ec1d with SMTP id
 e19-20020a256913000000b00dccf9ceec1dmr927266ybc.0.1713911907923; 
 Tue, 23 Apr 2024 15:38:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIth4pqu6Sy7qJ8VEDilzUs8uhyKuXfGI9YPTIX5goZ7gHWie+zDRk8Kdwks5zasiWxcTqYA==
X-Received: by 2002:a25:6913:0:b0:dcc:f9ce:ec1d with SMTP id
 e19-20020a256913000000b00dccf9ceec1dmr927247ybc.0.1713911907300; 
 Tue, 23 Apr 2024 15:38:27 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 c21-20020a05620a11b500b0078d67886632sm5647726qkk.37.2024.04.23.15.38.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 15:38:27 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Prasad Pandit <ppandit@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Het Gala <het.gala@nutanix.com>
Subject: [PULL 08/26] tests/qtest/migration: Add negative tests to validate
 migration QAPIs
Date: Tue, 23 Apr 2024 18:37:55 -0400
Message-ID: <20240423223813.3237060-9-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423223813.3237060-1-peterx@redhat.com>
References: <20240423223813.3237060-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Het Gala <het.gala@nutanix.com>

Migration QAPI arguments - uri and channels are mutually exhaustive.
Add negative validation tests, one with both arguments present and
one with none present.

Signed-off-by: Het Gala <het.gala@nutanix.com>
Suggested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240312202634.63349-9-het.gala@nutanix.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration-test.c | 55 +++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index be67a92536..5d6d8cd634 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1724,7 +1724,7 @@ static void test_precopy_common(MigrateCommon *args)
     }
 
     if (args->result == MIG_TEST_QMP_ERROR) {
-        migrate_qmp_fail(from, args->connect_uri, NULL, "{}");
+        migrate_qmp_fail(from, args->connect_uri, args->connect_channels, "{}");
         goto finish;
     }
 
@@ -2571,6 +2571,55 @@ static void test_validate_uuid_dst_not_set(void)
     do_test_validate_uuid(&args, false);
 }
 
+static void do_test_validate_uri_channel(MigrateCommon *args)
+{
+    QTestState *from, *to;
+
+    if (test_migrate_start(&from, &to, args->listen_uri, &args->start)) {
+        return;
+    }
+
+    /* Wait for the first serial output from the source */
+    wait_for_serial("src_serial");
+
+    /*
+     * 'uri' and 'channels' validation is checked even before the migration
+     * starts.
+     */
+    migrate_qmp_fail(from, args->connect_uri, args->connect_channels, "{}");
+    test_migrate_end(from, to, false);
+}
+
+static void test_validate_uri_channels_both_set(void)
+{
+    MigrateCommon args = {
+        .start = {
+            .hide_stderr = true,
+        },
+        .listen_uri = "defer",
+        .connect_uri = "tcp:127.0.0.1:0",
+        .connect_channels = "[ { 'channel-type': 'main',"
+                            "    'addr': { 'transport': 'socket',"
+                            "              'type': 'inet',"
+                            "              'host': '127.0.0.1',"
+                            "              'port': '0' } } ]",
+    };
+
+    do_test_validate_uri_channel(&args);
+}
+
+static void test_validate_uri_channels_none_set(void)
+{
+    MigrateCommon args = {
+        .start = {
+            .hide_stderr = true,
+        },
+        .listen_uri = "defer",
+    };
+
+    do_test_validate_uri_channel(&args);
+}
+
 /*
  * The way auto_converge works, we need to do too many passes to
  * run this test.  Auto_converge logic is only run once every
@@ -3679,6 +3728,10 @@ int main(int argc, char **argv)
                        test_validate_uuid_src_not_set);
     migration_test_add("/migration/validate_uuid_dst_not_set",
                        test_validate_uuid_dst_not_set);
+    migration_test_add("/migration/validate_uri/channels/both_set",
+                       test_validate_uri_channels_both_set);
+    migration_test_add("/migration/validate_uri/channels/none_set",
+                       test_validate_uri_channels_none_set);
     /*
      * See explanation why this test is slow on function definition
      */
-- 
2.44.0


