Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4264CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 07:35:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0b48-0005xR-Mv; Mon, 22 Sep 2025 03:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1v0b45-0005wt-JG
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 03:34:25 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1v0b40-0007Nr-Qf
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 03:34:25 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxH9Pv+9BoFRwNAA--.28190S3;
 Mon, 22 Sep 2025 15:34:07 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJCxocLo+9Bo5wulAA--.64540S7;
 Mon, 22 Sep 2025 15:34:07 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 5/5] target/loongarch: Define loongarch_exception_name() as
 static
Date: Mon, 22 Sep 2025 15:34:00 +0800
Message-Id: <20250922073400.1308169-6-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250922073400.1308169-1-maobibo@loongson.cn>
References: <20250922073400.1308169-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxocLo+9Bo5wulAA--.64540S7
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Function loongarch_exception_name() is only called in defined file
target/loongarch/tcg/tcg_cpu.c, set this function as static.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/internals.h   | 2 --
 target/loongarch/tcg/tcg_cpu.c | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
index e50d109767..29956f0fbe 100644
--- a/target/loongarch/internals.h
+++ b/target/loongarch/internals.h
@@ -24,8 +24,6 @@ void G_NORETURN do_raise_exception(CPULoongArchState *env,
                                    uint32_t exception,
                                    uintptr_t pc);
 
-const char *loongarch_exception_name(int32_t exception);
-
 #ifdef CONFIG_TCG
 int ieee_ex_to_loongarch(int xcpt);
 void restore_fp_status(CPULoongArchState *env);
diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
index 59b5800ecf..82b54e6dc3 100644
--- a/target/loongarch/tcg/tcg_cpu.c
+++ b/target/loongarch/tcg/tcg_cpu.c
@@ -45,7 +45,7 @@ static const struct TypeExcp excp_names[] = {
     {EXCP_HLT, "EXCP_HLT"},
 };
 
-const char *loongarch_exception_name(int32_t exception)
+static const char *loongarch_exception_name(int32_t exception)
 {
     int i;
 
-- 
2.39.3


