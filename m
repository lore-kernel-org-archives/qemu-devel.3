Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E70FDC25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 12:56:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEThR-0006Pr-HK; Tue, 04 Jun 2024 08:55:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lanyanzhi22b@ict.ac.cn>)
 id 1sEOks-0000Wj-Lf
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 03:38:50 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lanyanzhi22b@ict.ac.cn>)
 id 1sEOkp-0006LJ-EL
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 03:38:50 -0400
Received: from loongson-kernel.loongson.cn (unknown [114.242.206.180])
 by APP-01 (Coremail) with SMTP id qwCowAD3_5t3xF5m6flOCQ--.12118S2;
 Tue, 04 Jun 2024 15:38:31 +0800 (CST)
From: lanyanzhi22b@ict.ac.cn
To: qemu-devel@nongnu.org
Cc: gaosong@loongson.cn,
	lanyanzhi <lanyanzhi22b@ict.ac.cn>
Subject: [PATCH] target/loongarch: fix a wrong print in cpu dump
Date: Tue,  4 Jun 2024 15:38:31 +0800
Message-Id: <20240604073831.666690-1-lanyanzhi22b@ict.ac.cn>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAD3_5t3xF5m6flOCQ--.12118S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtFWkZF4ruFWrGw1kCr48Zwb_yoWkXFX_Ka
 s3Xr1xKrW8ua42qF4avry5A390yF4rtw4a9a1xuFs3Wr1UJF15Cwsaq3Z3AF4Iq3y7GFnx
 Aay7JryrZw15AjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUb2AFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
 6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
 A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
 Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJV
 W0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
 I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
 4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0F24l
 42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
 WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAK
 I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
 4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
 6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUqD73UUUUU=
X-Originating-IP: [114.242.206.180]
X-CM-SenderInfo: 5odq5tpq2kxj0se6xunwoduhdfq/
Received-SPF: pass client-ip=159.226.251.21;
 envelope-from=lanyanzhi22b@ict.ac.cn; helo=cstnet.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 04 Jun 2024 08:55:32 -0400
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

Signed-off-by: lanyanzhi <lanyanzhi22b@ict.ac.cn>
---
 target/loongarch/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index b5c1ec94af..270f711f11 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -707,7 +707,7 @@ void loongarch_cpu_dump_state(CPUState *cs, FILE *f, int flags)
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


