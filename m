Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 383E1CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:10:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuHy-0008NP-Cx; Tue, 12 May 2026 17:05:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuHB-0005iH-Q4; Tue, 12 May 2026 17:04:27 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuH8-0008PD-Ob; Tue, 12 May 2026 17:04:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619279; bh=Q3lCuv4X+Ag/LDgtUcJpyEVJ8Rrvluf+nuqZHXrk1hg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=qq9LXjvKM4iu0YuqSfnhXfOwAX7tDPuQ5LW5OEuiDdJ/0QTArzh0ZjwRVjDfs33OC
 k5qv6X3e6zz/99uivijzmMKui2dyBgoq+Ab51++H0WTFpswddUtPTW/noDD+rowBPC
 QXSH++tuVQHc3MiPSYDasi9P10shlf8ma6o/3whxJPQUFgd+MEyDxs6SIEQjYCLCwT
 Z5yAt3kmOF33u7C0adcDs5J4qwEEWwanhpZgZhfOv3jR6DXykRbSvoPaigCIQeTIPk
 84bv/fYhulbWGYijtV2LcMSBPSRY3cG8OirfPO8psJhUxeKIWUih6YrAcwM1ezwSkI
 AvnoKJIstU3gQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8FBD61AA32A;
 Tue, 12 May 2026 23:54:39 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9CB683ABC9B;
 Tue, 12 May 2026 23:54:43 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 094/107] tests/rcutorture: Fix build error
Date: Tue, 12 May 2026 23:54:21 +0300
Message-ID: <20260512205437.360850-94-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
References: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Cédric Le Goater <clg@redhat.com>

Newer gcc compiler (version 16.0.0 20260103 (Red Hat 16.0.0-0) (GCC))
detects an unused variable error:

  ../tests/unit/rcutorture.c: In function ‘rcu_read_stress_test’:
  ../tests/unit/rcutorture.c:251:18: error: variable ‘garbage’ set but not used [-Werror=unused-but-set-variable=]
    251 |     volatile int garbage = 0;
        |                  ^~~~~~~

Since the 'garbage' variable is used to generate memory reads from the
CPU while holding the RCU lock, it can not be removed. Tag it as
((unused)) instead to silence the compiler warnings/errors.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260112163350.1251114-1-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
(cherry picked from commit 7a05be8c70bb789c23076b1ca2563ed7d87c6fb8)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/unit/rcutorture.c b/tests/unit/rcutorture.c
index 7662081683..2f19d479a3 100644
--- a/tests/unit/rcutorture.c
+++ b/tests/unit/rcutorture.c
@@ -248,7 +248,7 @@ static void *rcu_read_stress_test(void *arg)
     int pc;
     long long n_reads_local = 0;
     long long rcu_stress_local[RCU_STRESS_PIPE_LEN + 1] = { 0 };
-    volatile int garbage = 0;
+    volatile int garbage __attribute__ ((unused)) = 0;
 
     rcu_register_thread();
 
-- 
2.47.3


