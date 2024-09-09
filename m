Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F548ECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 14:26:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snfLd-0002vl-N2; Mon, 09 Sep 2024 10:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1snfLZ-0002eI-OG
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 10:26:31 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1snfLY-0004Vb-06
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 10:26:29 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-718d704704aso2612035b3a.3
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 07:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1725891986; x=1726496786;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3t+rJYL+OLNJsbkNL6rt5vBSdNx9BVxn2HZsRTYOAAc=;
 b=Lg8Kck88Wi1Q5i9snlC3be9DG0I7i4UGVn7b63cNg9zTSkkZbazhw9ZxCNB5/OH0L9
 6IjT8bRDDVk5b4HNa3L7XxE2ZNYdF+v58Zw3QKSq5IAJTD1/S+vP47tPlYTyNluhFJgp
 4JdqpENwwYEOniJkkNaImR9Z6y9Ts7hyJ4lnYdh9g9hmL+zRoGth8txeO0YJ67yVwmN8
 Aq44L72yGzlQG2E7bqQPre70/X+wdAUOA8dbdSqxfa5WozOZfxUmoFs11ZqwFDJ/J6Iq
 3EwOqTTlbrgRC/ItueQyt3oFFTooAU1MwPbP+yQg8KmmLdZMJAxmeNEO+UL00p6lybAC
 hx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725891986; x=1726496786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3t+rJYL+OLNJsbkNL6rt5vBSdNx9BVxn2HZsRTYOAAc=;
 b=lmj6obVqErqdyy9jNRrEKvcayjVYCuzKHBk5OczvnSz7M+HKt7Q3hmhbCRw1k4HkRA
 p/01du9gLkfwGSGIrvzgWYviQ+x3WyiUSejFOA/ba7BQRqQkFRNBVSRmVPne5Diwm9qj
 csYsARmmPhk0nTStpf8FKtwyevRx8mjeec47aObQgsRkDg+HAtGR/8HINTRwsEsugqh5
 F90h2odB29sQsK1iV7XSIiLgfivq9h+a7Dz0bnMvjIGYTIDXZKKeAJmJY41R+UOaTGYw
 c54NLbYzCbljwSmvrepCbfwu4RarmD1okxrdJb0W33l2c+nn/EohE/4ZBXv2Y0lEQEYa
 TWXw==
X-Gm-Message-State: AOJu0Yz3PmQoVuRpJHW3wmh0L7sG4krpt2mgulZdkiKa/8v7Ng55u5KO
 LECEvaIbWt2aFE9fTu6+pxUloyjMcIpdT7BqXsBRqljieAacmkLhtSobIv4t1JVo0PmV9bX26ix
 15vwxWA==
X-Google-Smtp-Source: AGHT+IF20x8ePnHQeOTMWmc62GgaNvFSf4hhjn7DeEGwKPf/ahMUtNfsCr2ZKZrS/sXSWylkloJfyg==
X-Received: by 2002:a05:6a21:6802:b0:1c4:23f0:9665 with SMTP id
 adf61e73a8af0-1cf2a0b7dbfmr8712618637.29.1725891985705; 
 Mon, 09 Sep 2024 07:26:25 -0700 (PDT)
Received: from localhost.localdomain ([118.114.94.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-718e58b2a88sm3561164b3a.46.2024.09.09.07.26.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 07:26:25 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, yong.huang@smartx.com
Subject: [PATCH RESEND RFC 10/10] tests/migration-tests: Add test case for
 responsive CPU throttle
Date: Mon,  9 Sep 2024 22:25:43 +0800
Message-Id: <d67b9d66351d89e0daeced982c41795fffa52e02.1725891841.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1725891841.git.yong.huang@smartx.com>
References: <cover.1725891841.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=yong.huang@smartx.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Despite the fact that the responsive CPU throttle is enabled,
the dirty sync count may not always increase because this is
an optimization that might not happen in any situation.

This test case just making sure it doesn't interfere with any
current functionality.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 tests/qtest/migration-test.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 4626301435..cf0b1dcb50 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -718,6 +718,7 @@ typedef struct {
 typedef struct {
     /* CPU throttle parameters */
     bool periodic;
+    bool responsive;
 } AutoConvergeArgs;
 
 static int test_migrate_start(QTestState **from, QTestState **to,
@@ -2795,6 +2796,7 @@ static void test_migrate_auto_converge_args(AutoConvergeArgs *input_args)
     QTestState *from, *to;
     int64_t percentage;
     bool periodic = (input_args && input_args->periodic);
+    bool responsive = (input_args && input_args->responsive);
 
     /*
      * We want the test to be stable and as fast as possible.
@@ -2820,6 +2822,16 @@ static void test_migrate_auto_converge_args(AutoConvergeArgs *input_args)
                 periodic_throttle_interval);
     }
 
+    if (responsive) {
+        /*
+         * The dirty-sync-count may not always go down while using responsive
+         * throttle because it is an optimization and may not take effect in
+         * any scenario. Just making sure this feature doesn't break any
+         * existing functionality by turning it on.
+         */
+        migrate_set_parameter_bool(from, "cpu-responsive-throttle", true);
+    }
+
     /*
      * Set the initial parameters so that the migration could not converge
      * without throttling.
@@ -2902,6 +2914,12 @@ static void test_migrate_auto_converge_periodic_throttle(void)
     test_migrate_auto_converge_args(&args);
 }
 
+static void test_migrate_auto_converge_responsive_throttle(void)
+{
+    AutoConvergeArgs args = {.responsive = true};
+    test_migrate_auto_converge_args(&args);
+}
+
 static void *
 test_migrate_precopy_tcp_multifd_start_common(QTestState *from,
                                               QTestState *to,
@@ -3955,6 +3973,8 @@ int main(int argc, char **argv)
                            test_migrate_auto_converge);
         migration_test_add("/migration/auto_converge_periodic_throttle",
                            test_migrate_auto_converge_periodic_throttle);
+        migration_test_add("/migration/auto_converge_responsive_throttle",
+                           test_migrate_auto_converge_responsive_throttle);
         if (g_str_equal(arch, "x86_64") &&
             has_kvm && kvm_dirty_ring_supported()) {
             migration_test_add("/migration/dirty_limit",
-- 
2.39.1


