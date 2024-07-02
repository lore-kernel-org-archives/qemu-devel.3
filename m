Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBAA9C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 22:16:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOlmU-0003NP-Py; Tue, 02 Jul 2024 18:15:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xin@zytor.com>) id 1sOlm6-0003KK-6N
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 18:15:00 -0400
Received: from torg.zytor.com ([2607:7c80:54:3::138] helo=mail.zytor.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xin@zytor.com>) id 1sOlm0-0000fN-IS
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 18:14:57 -0400
Received: from terminus.zytor.com (terminus.zytor.com
 [IPv6:2607:7c80:54:3:0:0:0:136]) (authenticated bits=0)
 by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 462MEYag020032
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
 Tue, 2 Jul 2024 15:14:38 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 462MEYag020032
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
 s=2024061501; t=1719958479;
 bh=bbNwVXOr7mQVz1cDObhCPhAldXpEeSEx7lnpAxYk31s=;
 h=From:To:Cc:Subject:Date:From;
 b=K1otk+YLFMDi1EyzvD/Zp7+SKAAE/dzIigWYjRVaEm3FZAAHV8UjKApqlhoCAAwiO
 EcsQQ1hUQtCsOtJoYN0T76yarEZo1SiHCfWd4Tm0uL9TtYi/PQ/1u65FxYaOlEeRvF
 W5CBy6xmHW7HNEfTEPn9zf+VMn3S4nd56OSL6BiG0UjNSYLJ3otxTjifymQ2OpzsZI
 icAnYWVK7LQ7bUOMpVEVyyHtM3DC2pbSD2noQUH1JBEVFRTHmLXw0VODJOPnYcHQO0
 xzZaYBmDJTw26fiBeblmbKHVA/SUhBMRhC6fvOD8fF7LPKiMkvwfC7w6lpt17NNMnS
 mblKurWuSL+Pg==
From: "Xin Li (Intel)" <xin@zytor.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, xin3.li@intel.com
Subject: [PATCH v1 1/1] target/i386: Delete a duplicated macro definition
 CR4_FRED_MASK
Date: Tue,  2 Jul 2024 15:14:33 -0700
Message-ID: <20240702221433.20017-1-xin@zytor.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:7c80:54:3::138; envelope-from=xin@zytor.com;
 helo=mail.zytor.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Macro CR4_FRED_MASK is defined twice due to a merge incident, delete one.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
---
 target/i386/cpu.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 29daf37048..b73685a745 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -267,12 +267,6 @@ typedef enum X86Seg {
 #define CR4_FRED_MASK   0
 #endif
 
-#ifdef TARGET_X86_64
-#define CR4_FRED_MASK   (1ULL << 32)
-#else
-#define CR4_FRED_MASK   0
-#endif
-
 #define CR4_RESERVED_MASK \
 (~(target_ulong)(CR4_VME_MASK | CR4_PVI_MASK | CR4_TSD_MASK \
                 | CR4_DE_MASK | CR4_PSE_MASK | CR4_PAE_MASK \

base-commit: ff6d8490e33acf44ed8afd549e203a42d6f813b5
-- 
2.45.2


