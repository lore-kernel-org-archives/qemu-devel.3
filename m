Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 957FECD1296
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 07:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruSO6-0006SR-Ub; Wed, 10 Apr 2024 03:28:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSNy-0006Hs-EM; Wed, 10 Apr 2024 03:28:47 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSNw-0004xt-TR; Wed, 10 Apr 2024 03:28:46 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E9B815D6AD;
 Wed, 10 Apr 2024 10:25:06 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 8D458B02ED;
 Wed, 10 Apr 2024 10:23:08 +0300 (MSK)
Received: (nullmailer pid 4191833 invoked by uid 1000);
 Wed, 10 Apr 2024 07:23:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Yao Xingtao <yaoxt.fnst@fujitsu.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.3 61/87] monitor/hmp-cmds-target: Append a space in error
 message in gpa2hva()
Date: Wed, 10 Apr 2024 10:22:34 +0300
Message-Id: <20240410072303.4191455-61-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
References: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Yao Xingtao <yaoxt.fnst@fujitsu.com>

In qemu monitor mode, when we use gpa2hva command to print the host
virtual address corresponding to a guest physical address, if the gpa is
not in RAM, the error message is below:

  (qemu) gpa2hva 0x750000000
  Memory at address 0x750000000is not RAM

A space is missed between '0x750000000' and 'is'.

Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
Fixes: e9628441df ("hmp: gpa2hva and gpa2hpa hostaddr command")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
Message-ID: <20240319021610.2423844-1-ruansy.fnst@fujitsu.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit a158c63b3ba120f1656e4dd815d186c623fb5ef6)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
index d9fbcac08d..af6176a7a4 100644
--- a/monitor/hmp-cmds-target.c
+++ b/monitor/hmp-cmds-target.c
@@ -260,7 +260,7 @@ void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, uint64_t size, Error **errp)
     }
 
     if (!memory_region_is_ram(mrs.mr) && !memory_region_is_romd(mrs.mr)) {
-        error_setg(errp, "Memory at address 0x%" HWADDR_PRIx "is not RAM", addr);
+        error_setg(errp, "Memory at address 0x%" HWADDR_PRIx " is not RAM", addr);
         memory_region_unref(mrs.mr);
         return NULL;
     }
-- 
2.39.2


