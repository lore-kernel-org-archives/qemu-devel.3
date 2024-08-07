Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F24C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 08:19:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbbsf-0000aR-32; Wed, 07 Aug 2024 04:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xin@zytor.com>) id 1sbbsO-0000Hf-HC
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 04:18:32 -0400
Received: from torg.zytor.com ([2607:7c80:54:3::138] helo=mail.zytor.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xin@zytor.com>) id 1sbbsM-0006ui-Hd
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 04:18:32 -0400
Received: from terminus.zytor.com (terminus.zytor.com
 [IPv6:2607:7c80:54:3:0:0:0:136]) (authenticated bits=0)
 by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 4778IDpf735187
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
 Wed, 7 Aug 2024 01:18:17 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4778IDpf735187
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
 s=2024071601; t=1723018698;
 bh=cLhnhzRXZr2FwWzd1KskHfPSIS/PzC+PgX/l/u713kQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Gep/dezni3c9dR93wP+dHZQLqT7/iiAfYrsPWP0XIPXKjUCApLLbKv4Ub3vji4RhG
 33G8hWTvIclV4SyF7d4BjVsBXlcnzov6hXRenxF5BWAq3WuPAJoOl0t9gHNCCGCRCi
 5J4P2d5oET4Plkep/VsQLAuwF2EXHKm6izGni4I7Vfb6OKWNwiM+UHEHT6h8WS5ZVv
 QPkp31Qq5uXz2C5x1ZTmarCEQjRwYRKQag2+xLxQy7hmMQDJ73e2FnP9F1J7Sdo9TD
 ynUyBxto59MRp7eeSyE7SW9pz231WUj2ps11Vo/QB+lytD8rgHaWlx6iaMXgWpwZFt
 a2skGF4qaFRSA==
From: "Xin Li (Intel)" <xin@zytor.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, lei4.wang@intel.com,
 zhao1.liu@intel.com, xin3.li@intel.com
Subject: [PATCH v1 1/3] target/i386: Delete duplicated macro definition
 CR4_FRED_MASK
Date: Wed,  7 Aug 2024 01:18:10 -0700
Message-ID: <20240807081813.735158-2-xin@zytor.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807081813.735158-1-xin@zytor.com>
References: <20240807081813.735158-1-xin@zytor.com>
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

Macro CR4_FRED_MASK is defined twice, delete one.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
---
 target/i386/cpu.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index c6cc035df3..118ef9cb68 100644
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
-- 
2.45.2


