Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F6CBD1AD23
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 07:58:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0yu9-0003b9-5J; Wed, 16 Oct 2024 03:57:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t0yu5-0003a1-7b
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 03:57:09 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t0yu3-0000hW-OD
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 03:57:09 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-20cf3e36a76so27502685ad.0
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 00:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1729065426; x=1729670226;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pcYOvgD8gChlYAF/Rf2Le7Pe4jCTRSW5UuA6AvRkQG8=;
 b=HlCqMLWwerVg7V5oD4Zma7UFsCX5VyuhevYJv2GqzoKP7MtI/9uzuZyfjicrn+9cWa
 OXe36AM8hXy2apyBuFTzZdlMpmXS+Gj0lvmJaYAGsj+qNcMx8WpbmL3rchs9pIyCokFt
 jMoULTUOaeZ92z3+uG6156jT/HY9fNeWH3Zua1b5uSG4qMCTJNSJa+wYdB4/+kY5qzum
 kMey3SCsQ+ScXQDFAgp46vPx0/QzTr0lbehQp6UzURz79qt7D8onkhneMinx/gVN8/+m
 ugIKVnUtH8UMLTX1EUJSAEE/N7m8R4Pqyq7WzNCImgeKmYx7fKmkjUBq48FGG2kQ58oA
 FH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729065426; x=1729670226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pcYOvgD8gChlYAF/Rf2Le7Pe4jCTRSW5UuA6AvRkQG8=;
 b=mu6bUr5IDA7epqK3VXnroxrig0yPbDzbCLS6Ct9DMAkrUe5Xa/YHGF+NUGpGIUb8GJ
 M/vIO1YeKvOyfo2xrEtET/ceXbqpgsgHANVRI8sVB6wMA71wqIKzF+zGaYUihBkcUuDq
 XxcRawJuPUt+nN4J8V7mG+iaIB1PSo7DvTuqYdhyejvLnPcfB+ERCiHJZAXcvOgQtDKh
 KkF/5Csvm/t1R2ewq/wL85kcKz6WZJdiQrSya5wvjA3lPTRaF8tgOOuZzaGntJ4ISGQv
 MAN2MUNZdevE+fmGtww8Tzj44fBb0JGoJi2mp6vI01jkn1e/hvs4qejMt7ti4IDFNfxW
 Kufw==
X-Gm-Message-State: AOJu0YxWQHtumDQMcwdXl5/xG98T4oQQPQnakcK77eMbaNeJYHESfGof
 JI7z8LGCTGqhX+5Vzew4IrQwFKIGbHrESQ0NnQxpcWdTlMlvdotoGqtkR61u5RjVO5qdT3Kchei
 R4WItyA==
X-Google-Smtp-Source: AGHT+IG2wjYJnDF1lSnEufnk35yRFrDDMqVotom4wcV/Zill1PNjw9sakq/oCxkKdV6gmoLoxlEm/w==
X-Received: by 2002:a17:902:e747:b0:20c:bca5:12a8 with SMTP id
 d9443c01a7336-20cbca515a5mr158145675ad.60.1729065425667; 
 Wed, 16 Oct 2024 00:57:05 -0700 (PDT)
Received: from Hyman-Dev-Euler.zelin.local ([85.208.104.155])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20d17f84dd1sm23608365ad.43.2024.10.16.00.57.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 00:57:05 -0700 (PDT)
From: yong.huang@smartx.com
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, yong.huang@smartx.com
Subject: [PATCH v3 4/4] tests/migration: Add case for periodic ramblock dirty
 sync
Date: Wed, 16 Oct 2024 15:56:45 +0800
Message-Id: <4252161b9ec3964330d91a15295abe9fb171145f.1729064919.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1729064919.git.yong.huang@smartx.com>
References: <cover.1729064919.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x62c.google.com
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

From: Hyman Huang <yong.huang@smartx.com>

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
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
2.27.0


