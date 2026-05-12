Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0CFECD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:17:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuNu-00081L-JN; Tue, 12 May 2026 17:11:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuNf-0007ot-VJ; Tue, 12 May 2026 17:11:10 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuNe-00040d-Gw; Tue, 12 May 2026 17:11:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619303; bh=REayO9aCVDrVaPWZeXJGYE5hvEQMCsaum6RUoViQERk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=WhUC+MsuBnk9EbmKwvLpM6QfOaBaEmZaMylhKlqdmFZsh4+qjGH2wQKYDTCGk4D99
 4ceA478klgQrBAoYmlLP3D8VKyBFez0ohvft/3Ifx3jcVMSoPSrwRDmZfyQ8lunXrH
 mqxnEpThK4vaspA0coLlC8HJmxcbj1+BuEdk9728ada88LfgHmgskIK/Dho+UOXVRd
 32wSIqEq3yS8ummtTCJ14ym5ABsppKKjg2F3yaT4l8fxVAYlYG9oUTFZf3SE3VnRI4
 yTRrgWUDzTjfxjyhj+/UlhAIYgXn6l4waQfkJncsUI4Est7k2Gfoda35ueo03ZgtYS
 wmczjDl4pwlhA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0CD3A1AA36F;
 Tue, 12 May 2026 23:55:03 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0F5513ABCDF;
 Tue, 12 May 2026 23:55:07 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 050/117] accel/tcg: Don't pass NULL to
 get_page_addr_code_hostp
Date: Tue, 12 May 2026 23:53:52 +0300
Message-ID: <20260512205503.361097-50-mjt@tls.msk.ru>
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

From: Richard Henderson <richard.henderson@linaro.org>

Pass a dummy variable instead to let the value be discarded,
in preparation for making the argument mandatory.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit 813dbe869f4f82f00f2b465fdd22d30db1d5233e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
index 6adfeefe13..0ca13750f9 100644
--- a/accel/tcg/internal-common.h
+++ b/accel/tcg/internal-common.h
@@ -105,7 +105,8 @@ tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, vaddr addr,
 static inline tb_page_addr_t get_page_addr_code(CPUArchState *env,
                                                 vaddr addr)
 {
-    return get_page_addr_code_hostp(env, addr, NULL);
+    void *discard;
+    return get_page_addr_code_hostp(env, addr, &discard);
 }
 
 /*
-- 
2.47.3


