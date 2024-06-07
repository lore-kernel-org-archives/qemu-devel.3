Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90DCFC27C53
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 23:28:04 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFf1A-00068A-WC; Fri, 07 Jun 2024 15:12:53 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sFf19-0005gd-9v; Fri, 07 Jun 2024 15:12:51 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sFf17-0001i0-Jo; Fri, 07 Jun 2024 15:12:51 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4A76B6E537;
 Fri,  7 Jun 2024 22:13:16 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 8317FE2737;
 Fri,  7 Jun 2024 22:12:21 +0300 (MSK)
Received: (nullmailer pid 528261 invoked by uid 1000);
 Fri, 07 Jun 2024 19:12:20 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, lanyanzhi <lanyanzhi22b@ict.ac.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.12 29/29] target/loongarch: fix a wrong print in cpu dump
Date: Fri,  7 Jun 2024 22:12:12 +0300
Message-Id: <20240607191219.528194-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.12-20240607221018@cover.tls.msk.ru>
References: <qemu-stable-7.2.12-20240607221018@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: lanyanzhi <lanyanzhi22b@ict.ac.cn>

description:
    loongarch_cpu_dump_state() want to dump all loongarch cpu
state registers, but there is a tiny typographical error when
printing "PRCFG2".

Cc: qemu-stable@nongnu.org
Signed-off-by: lanyanzhi <lanyanzhi22b@ict.ac.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20240604073831.666690-1-lanyanzhi22b@ict.ac.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
(cherry picked from commit 78f932ea1f7b3b9b0ac628dc2a91281318fe51fa)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 92dd50e15e..56e36d81b3 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -653,7 +653,7 @@ void loongarch_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     qemu_fprintf(f, "EENTRY=%016" PRIx64 "\n", env->CSR_EENTRY);
     qemu_fprintf(f, "PRCFG1=%016" PRIx64 ", PRCFG2=%016" PRIx64 ","
                  " PRCFG3=%016" PRIx64 "\n",
-                 env->CSR_PRCFG1, env->CSR_PRCFG3, env->CSR_PRCFG3);
+                 env->CSR_PRCFG1, env->CSR_PRCFG2, env->CSR_PRCFG3);
     qemu_fprintf(f, "TLBRENTRY=%016" PRIx64 "\n", env->CSR_TLBRENTRY);
     qemu_fprintf(f, "TLBRBADV=%016" PRIx64 "\n", env->CSR_TLBRBADV);
     qemu_fprintf(f, "TLBRERA=%016" PRIx64 "\n", env->CSR_TLBRERA);
-- 
2.39.2


