Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 993B8C44507
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 08:20:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkdnZ-0000ZW-NQ; Fri, 17 Jul 2026 04:19:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rohit.kuma1313@gmail.com>)
 id 1wkdnY-0000Vs-Bm
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 04:19:56 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rohit.kuma1313@gmail.com>)
 id 1wkdnW-0000QN-VW
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 04:19:56 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-493ec555a26so49294785e9.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 01:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784276393; x=1784881193; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AMyx0DRZia3gkeQOWV8JRcpXn8R5O7JzvvSEQ/cE2cg=;
 b=oYtLPAZbzJT+9gN9byzDeuCsKHV3KoDM+xCdx0NzEzxXrVCMQxxMl9uAZUGS5CoQKj
 SfjXFmJBPvGrPMT3CBUgz6WW+9Wsopm8InLmuNrJBjtwOw/2aR6HFblBU653sqqNz9XU
 MDzWYY2p7dvjCAszqn8LXzj0HtkQyQsHi/bgeD10HSl5ncK9fS9/FMguM+j8HDzt/UHS
 KsbwfFGhGGA62me6uUF2vhwC7AqtBGICNOhgPaPOjviwaCvruAl5RDT3sbZqLKsny70x
 qtbCg9WJ9hZiius2D7kTnvMDwvNSxUDHYdS+YLcUBvZL7VQErvWvsAzCJs1E6PTGLc4S
 J6lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784276393; x=1784881193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AMyx0DRZia3gkeQOWV8JRcpXn8R5O7JzvvSEQ/cE2cg=;
 b=aLSf5kgmp7fxeVU1VXHNlUWt3eNTmaW+dpNzjRQCsvIEOo0K9huclEixTx4xs6xQVc
 y/CVinYLGYBs2Qcn2kyweMtsgsKSPn19xhgoJ/yZ9aYIbo6sFFpwPIuTpfmdrki2jKol
 U0GgjaBoKkdXzfkvC+/kBCAF99vyahHF+qOUxd6RRvlCHIm6mzNlkj9ChTdvhC0EvaHD
 i9PUtvIVliKPwV1JqtN0R9fqOttxFlI0wtMASOjbikRX7Fm/OgDBE2TS1OZnyqoQRObI
 KWsgzBkui5r6ESFbogYDLbCMwbX81NDkHimnpFR/5uoPKhufXXkP4YzTiCdjYUep8aD5
 /PcA==
X-Gm-Message-State: AOJu0YzNPsZxPpVUqjrdluhdIQxT9BetZMadAPEyEIcGcCgvhtIhRt9t
 dpUSxGTuza8iMekVgab4FcyozGm11nKxJVFihujVgZvP6d2NVn7LSv9twupd8S4IykY=
X-Gm-Gg: AfdE7cnlkIEFhqu+7M4BQpplFN4mvpVGWWPgZJ+YtZhbzqUT9SyswdsHPNAeYFCM1MF
 OMAGt34YLBgPm2ZxwiAgEO2DLZvH/yCQ72sqUfpsAgqWti+627xhwgPjzwcrj9Wq8SOmdpPWijt
 L7RnCPZrYO3EUBTThO4ZtZ3uaPwxXX16dhfDqfbzz694JxtK1vz5W2+ws7lRyvKv5vVjoekaz4k
 dFVqrepAovp+CreC90dSPUraTPM7grX4LQ9CPtKa9gooLTns0ZyK4TqbveE8id0EDeoks+VxSK7
 Y/zjqCTqpjvb11KuZtZSGaOpekrm1fq5KCuWHBo/luQKfYNEQbZeuUDKoJLa8t2u1n4Yv5fdn4Z
 RtTGoENbbrTq6tMutjUzq0pt8GO3xQy5RkNABXWdDfnJv6ejjLCIxj/0rNbHHMdOp7Y9jxxqeWn
 CfPbpkmuva0bd6uFYMJBqaSZnaU/Yg8KSkhXTgRjR9PxCG3gVgv1dghkSSsDznektUcF4Jd4IZz
 ttbD0eLRcQrPl/Bi4UmKG877cuIBvn2TK/vKyIa2GYnso23OFk=
X-Received: by 2002:a7b:c4da:0:b0:493:bd71:6084 with SMTP id
 5b1f17b1804b1-4954a50bcd9mr11043785e9.31.1784276393059; 
 Fri, 17 Jul 2026 01:19:53 -0700 (PDT)
Received: from ip-172-31-13-20.eu-central-1.compute.internal
 (ec2-18-198-207-175.eu-central-1.compute.amazonaws.com. [18.198.207.175])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49549c96fecsm36504285e9.11.2026.07.17.01.19.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 01:19:52 -0700 (PDT)
From: Rohitashv Kumar <rohit.kuma1313@gmail.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Rohitashv Kumar <roohiit@amazon.de>
Subject: [PATCH 3/3] tests/qtest/pxe-test: skip per-row cases whose machine is
 unavailable
Date: Fri, 17 Jul 2026 08:18:36 +0000
Message-ID: <20260717081845.2439849-4-rohit.kuma1313@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260717081845.2439849-1-rohit.kuma1313@gmail.com>
References: <20260717081845.2439849-1-rohit.kuma1313@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=rohit.kuma1313@gmail.com; helo=mail-wm1-x335.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Rohitashv Kumar <roohiit@amazon.de>

The x86 test table mixes 'pc' and 'q35' rows. When QEMU is built without
the i440fx/pc machine, the 'pc' rows fail with "unsupported machine type".

Add a per-row qtest_has_machine() check in test_batch(), mirroring the
existing per-row qtest_has_device() guard, so rows for an unavailable
machine are skipped while the others (e.g. q35) still run.

Signed-off-by: Rohitashv Kumar <roohiit@amazon.de>
---
 tests/qtest/pxe-test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/qtest/pxe-test.c b/tests/qtest/pxe-test.c
index a3f900fb..e85dec5a 100644
--- a/tests/qtest/pxe-test.c
+++ b/tests/qtest/pxe-test.c
@@ -108,6 +108,10 @@ static void test_batch(const testdef_t *tests, bool ipv6)
         const testdef_t *test = &tests[i];
         char *testname;
 
+        if (!qtest_has_machine(test->machine)) {
+            continue;
+        }
+
         if (!qtest_has_device(test->model)) {
             continue;
         }
-- 
2.47.3


