Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A2ACD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 13:52:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMnWU-0004jb-K0; Tue, 12 May 2026 09:51:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maqianga@uniontech.com>)
 id 1wMmti-0003wH-Ji
 for qemu-devel@nongnu.org; Tue, 12 May 2026 09:11:42 -0400
Received: from smtpbgau1.qq.com ([54.206.16.166])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maqianga@uniontech.com>)
 id 1wMmtf-0002r0-UO
 for qemu-devel@nongnu.org; Tue, 12 May 2026 09:11:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
 s=onoh2408; t=1778591487;
 bh=XdedY9/4K+g9ouAI2ogDYxg+WYweP8r7IddZI4bkkq4=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=lImrvuUe2r1oydlX1mKzE8+CbQaeXIQBj+7bJQeFOrLsUW6pP/XJk5VAvEsH0xms/
 PCQPqp398DhkyP3BuqyUFwVyjXnojVjppVYKfC8f2gJJ+tMRLMnnxx13b719vMgdT7
 Se4EtEO9XykHRnSL6wEqvpCZeMRtLK9GINcVCfCA=
X-QQ-mid: zesmtpgz3t1778591484t98565ccb
X-QQ-Originating-IP: QZLymt65pmwqEWIoIjLi8RhOYo9kDebUgAfcnggfk9Y=
Received: from localhost.localdomain ( [123.114.60.34])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 12 May 2026 21:11:23 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17855069848752927182
EX-QQ-RecipientCnt: 5
From: Qiang Ma <maqianga@uniontech.com>
To: gaosong@loongson.cn
Cc: maobibo@loongson.cn, philmd@linaro.org, qemu-devel@nongnu.org,
 Qiang Ma <maqianga@uniontech.com>
Subject: [PATCH v2] target/loongarch/kvm: Include missing exec/cpu-defs.h
 header
Date: Tue, 12 May 2026 21:11:07 +0800
Message-Id: <20260512131107.2388663-1-maqianga@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OFwwhOVq6f4xq28EIeYNjJoDLafTU+R289nnVfaERRP3k1GySUdO/Qcs
 kqj/33RVmiWCal90w7O6QM2w0w9CbozlU93Lpuw9sGYkkjp7Yvh8oZX3qPxhQQJuDyfXnWc
 Pa38z8CI0f2kkPwkmwjqLfXDiI8ZUzX0ugCvmIUazYFuq3ADIXq55Ym3PaB1jdWaBKxD5XC
 S5X9jwfcXKDRkhMWBKDH0lkQuyel2ZUF8OJWdwjm68/bVuUiptxTv6ks1dlag5e7xM840A2
 U11rzcDQmNFEt2/1BziZesZhyVgQFXpVFW8FeYZKKavhgpxMF4fthFSZZ/JIekc0qZiLesQ
 nthR/ZXsl/MgUmJJfy6VOpfnNxDCZ8fG//9SAnHsltONJhN0feFB3/HK5fdrO5jTCj+WmWi
 Gh3XZ6UhJFlSMRbM5hBH2qAMpzHayS+41aF818mGhDHTRS3I4JG/4UWwNbtlMtcLHQI7Pfg
 PghzFbr0qOuB7bUeRKMbG8AE34CHA2aIu7sNZOJZqN+u0rVBLhLncYWQW9Jq08IMPgombCu
 VFRU5NSCIkPl3jscxEz/6EPjn9xaY3L8DqIsND4D2ruaweGGlisYFzcKMeTCWPHY454LxwN
 kT4HOmJz7q8M2V3/vSACKuZJ78hfTxwKnSkILHciuo6DLFwFg4M6HWflRVSm5r+872klNYG
 SebV9+ZXhJloQqXpyvwFwnnI5yPLHTSfPMzVJZZrCwI1aryJZu/4CRbDqAj0/acg2QdxvGK
 Tng6WTcPu6iz/2sT2f568XAoaVERY6fgMivjxX7xen2ClLUlUJcLFiumW2Yrquy60I6KsPh
 sLOS3PP0XO1tN94xJkAsLhCNJDl8IL/Hpv4BCIfq3U9x2CVKExnvwYcDrz77ojxDF9NIb0i
 EUs2lOBrz2yZAFrrpULlIYf2/ekAtVahOjMR4ymGJGg6+p77AGDhvzRwBKvQxWxEDpw7iwm
 jgfA2B2xzGCKm0iPIHlEPIy/IBoNVEllvbx3mw1LCUrKa4nplEXBwdlY8KZroxYII1PmaEb
 SM2+SJTOwyWYKS3ayuUo6GMmro6kbWJXmwDHYazzF6TWzGmr7gZ6/kXPblDP/PeUeZkHCI8
 GgtQdp7aZjFcY1GjrJJByg=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0
Received-SPF: pass client-ip=54.206.16.166;
 envelope-from=maqianga@uniontech.com; helo=smtpbgau1.qq.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 12 May 2026 09:50:53 -0400
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

After commit 71cab1a42d2 removed the indirect include of
exec/cpu-defs.h from target/loongarch/cpu.h, the TARGET_FMT_lx
macro is no longer visible in kvm.c, causing build failures:

  error: expected ')' before TARGET_FMT_lx

Add the missing #include exec/cpu-defs.h to restore the
TARGET_FMT_lx definition.

Signed-off-by: Qiang Ma <maqianga@uniontech.com>
---
 target/loongarch/kvm/kvm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 9d844c4905..4af4ab2ed0 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -6,6 +6,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "exec/target_long.h"
 #include <sys/ioctl.h>
 #include <linux/kvm.h>
 #include "asm-loongarch/kvm_para.h"
-- 
2.20.1


