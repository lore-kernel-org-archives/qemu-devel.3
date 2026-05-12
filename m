Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE35CD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:20:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuQi-0002XS-Vh; Tue, 12 May 2026 17:14:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuQE-0001MD-PX; Tue, 12 May 2026 17:13:49 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuQA-0005NF-Lt; Tue, 12 May 2026 17:13:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619305; bh=663adPU+m3mgRjg9rPiLj3BMr5p2hNhKt3lFk86PrCU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=kV4Ldj7+MX6SWRTFHwxnxnWeBIJSFc4CBPLGJJ21N/jaJ647SlIfgPn0dk/WjKMQp
 7JW7vdoJp8YJCi3Yo+jkLt8M+e4oHUY5XBeAfm3yGL4e1JcLpV35UxgWFdjvPVRPAe
 5MvccUUkP3+3G/BWRHlz/28usD/PDQhT6YQ+VMjf/pFT+e5JsuPbH+cn2n60ssozuL
 UIs36YuGVKodpWBDmH04AuYHtnaqAsmv+kEoNqmhcyivLZlrxZAxhsVhcvQt50b20e
 Y9i8DV+CYt7VB/OMlva/AiVBbp1qhQ+9oSQlZNJDmU/8iNhh0jwe9lGKuv6zzL02Ej
 +Yoka3i3FbsmQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0DFBF1AA38C;
 Tue, 12 May 2026 23:55:05 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1B21D3ABCFB;
 Tue, 12 May 2026 23:55:09 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 078/117] hw/sh4/sh7750: Remove forgotten abort() in
 the MM_ITLB_DATA handler
Date: Tue, 12 May 2026 23:54:20 +0300
Message-ID: <20260512205503.361097-78-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
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

From: Thomas Huth <thuth@redhat.com>

QEMU currently aborts when the guest writes to the MM_ITLB_DATA register:

 echo "writel 0xf3000000 0x11223344" | \
  ./qemu-system-sh4 -M r2d -display none -accel qtest -qtest stdio
 [I 0.000000] OPENED
 [R +0.004476] writel 0xf3000000 0x11223344
 Aborted                    (core dumped)

Looking at the history of the code, the abort() here has likely just
been forgotten when the register handler had been implemented (it used
to be a reminder about unimplemented functionality initially):

 https://gitlab.com/qemu-project/qemu/-/commit/9f97309a70f12df5f9104f1f

Thus simply remove the abort() now to get rid of the problem.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3420
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260422075429.341409-1-thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit 3ab47a47d716f8f2b7686cc06c8312db2e6fc2d4)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/sh4/sh7750.c b/hw/sh4/sh7750.c
index 300eabc595..ba75392e11 100644
--- a/hw/sh4/sh7750.c
+++ b/hw/sh4/sh7750.c
@@ -687,7 +687,6 @@ static void sh7750_mmct_write(void *opaque, hwaddr addr,
         break;
     case MM_ITLB_DATA:
         cpu_sh4_write_mmaped_itlb_data(&s->cpu->env, addr, mem_value);
-        abort();
         break;
     case MM_OCACHE_ADDR:
     case MM_OCACHE_DATA:
-- 
2.47.3


