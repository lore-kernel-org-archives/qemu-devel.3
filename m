Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09C39D5B86D
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 15:59:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6B5A-0003bh-PO; Wed, 30 Oct 2024 11:58:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6B54-0003aS-Hz
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 11:57:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6B52-0007nM-Sc
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 11:57:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730303876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D04sswxuA64dl9ZML7ycu/fX/0EMcgaz7cJ3EQ22hfI=;
 b=T5eblZPkCxqLCgD/JZ28CKQhfeEFM+7N8WdxinQRRmLPLlwS9YhbxvBO2+Kv3U9YoN3MTC
 H8vWR17DzJahF3u1kumkow8wrm9Ul0huRq5QtPpB6sB7KonYD7f0XMydlS2mwYXptXNMGZ
 +sxnBZJsB1RIf9xWZQKHlof0oBTNX/Q=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-_JZ0IR-pO1O5gxBQvdI4Fw-1; Wed, 30 Oct 2024 11:57:53 -0400
X-MC-Unique: _JZ0IR-pO1O5gxBQvdI4Fw-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6cbed928402so84811836d6.2
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 08:57:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730303872; x=1730908672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D04sswxuA64dl9ZML7ycu/fX/0EMcgaz7cJ3EQ22hfI=;
 b=ASdAciRRy7zlE1bF5ahAaUeQUA8drNN6bU9neuWDkPI2vd/WBeN78w46lmKkZsN8pZ
 DeyizoNwllO31UoBeRg2GDg5r6cXS34+mA4us48Mkru4UOIIB2j1iMD8U7WNl0831Dak
 GXgCpc16ZpNgarorcTLh7qzpC0e7MifEmuMzMTBHNnVO4HemsXdHKERoRF//143snEyz
 3RnlGLOYGwX5ZIr9joGGzv7RmEbxKrrpeSR1yMBM28idzYbtuQvtgbiWowu7kJWHn7gV
 1VsOiP3Xhw13082BausA8gpYN5uFrfcrBJo8z9COwWIoKyFICmCGNRln4DhxgD1at+bX
 C4EQ==
X-Gm-Message-State: AOJu0YyuHIQOolGov3uxHKlPMXY3vpd/QeHsrSvxahey+8UvPTZzW7Yx
 22oPcbtFR5UH2Bb3szavMe9inphxqwLIWflBlpJZvgbiHG5bnVulcO+FkyBmR8keQqqboyZrtgC
 DzMzPieqDLu7FMsuU+7upUj1UOXOZUySP28K7QHO/AyCr6IrlsMLn/vvwWRN+Fg+MjMYNszpXRH
 GMZpHLI1OtaHUNOy/ZjBXXhTcSyuZOjCM6Ag==
X-Received: by 2002:a05:6214:2f01:b0:6cc:4136:205 with SMTP id
 6a1803df08f44-6d1856f3f3cmr326332626d6.26.1730303872641; 
 Wed, 30 Oct 2024 08:57:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZyOG+p6mdeNoMIurYOPKldNYJffEmFXjA6H0JYnamYdreGP9Rd3uz+LSqS+FZ0V8YZefCOw==
X-Received: by 2002:a05:6214:2f01:b0:6cc:4136:205 with SMTP id
 6a1803df08f44-6d1856f3f3cmr326332186d6.26.1730303872168; 
 Wed, 30 Oct 2024 08:57:52 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d19c57c1ffsm22802276d6.89.2024.10.30.08.57.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 08:57:51 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>,
 Hyman Huang <yong.huang@smartx.com>, Peter Xu <peterx@redhat.com>
Subject: [PULL 09/18] tests/migration: Add case for periodic ramblock dirty
 sync
Date: Wed, 30 Oct 2024 11:57:25 -0400
Message-ID: <20241030155734.2141398-10-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241030155734.2141398-1-peterx@redhat.com>
References: <20241030155734.2141398-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

From: Hyman Huang <yong.huang@smartx.com>

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/cb61504f1a1e9d5f2ca4dac12e518deb076ce9f3.1729146786.git.yong.huang@smartx.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration-test.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 95e45b5029..e6a2803e71 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -2791,6 +2791,8 @@ static void test_migrate_auto_converge(void)
      * so we need to decrease a bandwidth.
      */
     const int64_t init_pct = 5, inc_pct = 25, max_pct = 95;
+    uint64_t prev_dirty_sync_cnt, dirty_sync_cnt;
+    int max_try_count, hit = 0;
 
     if (test_migrate_start(&from, &to, uri, &args)) {
         return;
@@ -2827,6 +2829,36 @@ static void test_migrate_auto_converge(void)
     } while (true);
     /* The first percentage of throttling should be at least init_pct */
     g_assert_cmpint(percentage, >=, init_pct);
+
+    /*
+     * End the loop when the dirty sync count greater than 1.
+     */
+    while ((dirty_sync_cnt = get_migration_pass(from)) < 2) {
+        usleep(1000 * 1000);
+    }
+
+    prev_dirty_sync_cnt = dirty_sync_cnt;
+
+    /*
+     * The RAMBlock dirty sync count must changes in 5 seconds, here we set
+     * the timeout to 10 seconds to ensure it changes.
+     *
+     * Note that migrate_ensure_non_converge set the max-bandwidth to 3MB/s,
+     * while the qtest mem is >= 100MB, one iteration takes at least 33s (100/3)
+     * to complete; this ensures that the RAMBlock dirty sync occurs.
+     */
+    max_try_count = 10;
+    while (--max_try_count) {
+        dirty_sync_cnt = get_migration_pass(from);
+        if (dirty_sync_cnt != prev_dirty_sync_cnt) {
+            hit = 1;
+            break;
+        }
+        prev_dirty_sync_cnt = dirty_sync_cnt;
+        sleep(1);
+    }
+    g_assert_cmpint(hit, ==, 1);
+
     /* Now, when we tested that throttling works, let it converge */
     migrate_ensure_converge(from);
 
-- 
2.45.0


