Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50594CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 13:52:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMnWz-0005RO-CN; Tue, 12 May 2026 09:52:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maqianga@uniontech.com>)
 id 1wMm6D-0006rV-E9
 for qemu-devel@nongnu.org; Tue, 12 May 2026 08:20:33 -0400
Received: from smtpbguseast1.qq.com ([54.204.34.129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maqianga@uniontech.com>)
 id 1wMm60-0005Dk-Pa
 for qemu-devel@nongnu.org; Tue, 12 May 2026 08:20:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
 s=onoh2408; t=1778588412;
 bh=QqlykIlcWLPxgRNMM67eP4vjhwzPrhUTf5XFMZHhXV4=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=pXtrhIAHUpEbYK7TmEgoCFznMJZF2jlJzKUB77F131ztPsSZlKMqBJ2NPQ0taNmzH
 /62wT8OsBEc6D8Qq60jVSfkvvkHY9FKmlejUHzR6hG8n+ayUxeq5Wsxe4WyTnN0ckE
 0lvMQT6H5lcgv8WA2as/7NVLBWi5D2engQvx0Rw4=
X-QQ-mid: esmtpgz10t1778588409t0ea5c1b4
X-QQ-Originating-IP: 7eBvXFIH3JwhguSa+rrVQkOhWvyAbQfYP8J43FmQS5M=
Received: from localhost.localdomain ( [123.114.60.34])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 12 May 2026 20:20:08 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6184390343546687435
EX-QQ-RecipientCnt: 3
From: Qiang Ma <maqianga@uniontech.com>
To: gaosong@loongson.cn
Cc: qemu-devel@nongnu.org,
	Qiang Ma <maqianga@uniontech.com>
Subject: [PATCH] target/loongarch/kvm: Include missing exec/cpu-defs.h header
Date: Tue, 12 May 2026 20:19:54 +0800
Message-Id: <20260512121954.2248026-1-maqianga@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: M4I3MZG5ZyeogJYhSv47ttUc5m2SlPr2vsFAp8pxRiNDzScZlVuGP2/q
 VTtyEMME+MWKThVHoK40EtaK8vynCaqzmISwHF1ralNuUNSOM4NTEjrbcgFnqdZ8EIAMGcX
 sSo9XFwJgOIxGXZA22bvrNNVp2FqWcD0unGPbKbstdXhNO1GCV5DlIKlQMttiPZ3XFR1wNM
 gxO5cryAL1qBXJhP8EL9Ubr4yIAPj2ZSSSj3Xfbf4PPcgKjcp2YqZ7MCKWiJD6g3u5NzK6o
 VY+693a3gRmqqXnwR48ezxoPPhyfh2pL4MOo0MtgeEJWnPf3P9D/hbYCvByhyrXYz8rTvNY
 O2V8/A7S95vZ1jjsoo8CkuXmnzLEfnyQ1ZdJ3WsrpLWLDNLTsecxYRaaLMe1u3CbYUkjczK
 TekJgUuzRVB+ghFgvxmYsSIj/T5cfHkYRE/wWlhUVqfcTqHLeA3sun9NpQX4OtIjU1Xnblg
 +xUA2MJE4nzhE5f//tMfX3bdheDIf4T2eNywYNbJ3Cf0ueV6kL+9YEBH11wyTj3U/ne5tce
 I3DbYnOxF29Qhu8et0SH4g6HcNDUTQ6Z/SARR3cP6Gm7p3z+ieoazJWuIxawRw759bR8q9M
 aPSLmKuInEmN1glmtgInV4+66UJGPiqjzwOFCXukHoCplmksZVYHqjKZtSiA7p+4mUHwUIm
 7QtGF7MF+q5iuvzfrwqa8m+83CJWkIPEJYvGrFTZgPvkYBrZOg/3e2MMn69TaMoI0nDQC6b
 nbt9oa11zi6FDIMLbsm5l+a6mSaDAYQBzkZr9eDWpneQryckigQ0VZ4EsEAicUQiAWOGrTz
 Xbdw52qAlufD9Mj9IIIMLxJ9fn0Zildio4rQ4/KWDWADAuPIBtHr9BkYhfUIB4lYlAM8/Pe
 7abAXTwBtc3hdPE/vUH8hSlRmuSqfc9GaJZo6Mt7Lj/takHm+dseBR20YQZMID+O+4brWVW
 bbAWiR2nToejkzlIVTSQ4IHTSPZ9w5Ys4NNCXPCby9v/2N8Bq2PfVdghX7GLRjoxe+RkKmw
 BAFvnKM5VxITF082H+rEAmiHhEymw=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0
Received-SPF: pass client-ip=54.204.34.129;
 envelope-from=maqianga@uniontech.com; helo=smtpbguseast1.qq.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 12 May 2026 09:50:51 -0400
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
index 9d844c4905..7989aec7c7 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -6,6 +6,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "exec/cpu-defs.h"
 #include <sys/ioctl.h>
 #include <linux/kvm.h>
 #include "asm-loongarch/kvm_para.h"
-- 
2.51.0


