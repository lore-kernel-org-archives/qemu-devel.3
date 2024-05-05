Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 851A8C4345F
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2024 17:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3fS5-0001mf-8F; Sun, 05 May 2024 13:15:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1s3fS3-0001lm-Mu
 for qemu-devel@nongnu.org; Sun, 05 May 2024 13:15:03 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1s3fS2-0005ir-7f
 for qemu-devel@nongnu.org; Sun, 05 May 2024 13:15:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=6VcNWgHQlHoShRzZIx36jlPM5YOe1vzWmwbKSfnn+dc=; b=L4t5UBx5HLLbWed4
 VAa+J3vSIQqJSDLxPcmXdpH0IyFkyABEwLb/30+AypW1rfrogTcLO6+oB0zdclSCJJGJcN2EKSCVp
 ZQy4XO45F1KX6sPXCG7t3A4GwqW1fD81LTWuCHysWdqiMB06IZv33BpBzGS9qqhfepbBfAO3pChC4
 E/7cvLQZOWgk+j8RX1oRrkgtr8a8Av5u50LnYmPxuSSZh4m3hQDlNa36uOyBcjYITsC0Az2Lzk4UF
 KTd0HFybYUlIaBMSu6i3qUqR7HYl77fQNy5bl8XfCxeXfMrTMZQC8kF/uibCpLesWQggOuKXfRrZU
 Z4aUYRl72Pku4Jc2bw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
 by mx.treblig.org with esmtp (Exim 4.96)
 (envelope-from <dave@treblig.org>) id 1s3fRz-004nca-0E;
 Sun, 05 May 2024 17:14:59 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: peter.maydell@linaro.org,
	laurent@vivier.eu
Cc: qemu-devel@nongnu.org,
	"Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH 6/7] target/ppc: Remove unused struct 'mmu_ctx_hash32'
Date: Sun,  5 May 2024 18:14:43 +0100
Message-ID: <20240505171444.333302-7-dave@treblig.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240505171444.333302-1-dave@treblig.org>
References: <20240505171444.333302-1-dave@treblig.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dave@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

I think it's use was removed by
Commit 5883d8b296 ("mmu-hash*: Don't use full ppc_hash{32,
64}_translate() path for get_phys_page_debug()")

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
---
 target/ppc/mmu-hash32.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
index 3976416840..746321329c 100644
--- a/target/ppc/mmu-hash32.c
+++ b/target/ppc/mmu-hash32.c
@@ -36,12 +36,6 @@
 #  define LOG_BATS(...) do { } while (0)
 #endif
 
-struct mmu_ctx_hash32 {
-    hwaddr raddr;      /* Real address              */
-    int prot;                      /* Protection bits           */
-    int key;                       /* Access key                */
-};
-
 static int ppc_hash32_pp_prot(int key, int pp, int nx)
 {
     int prot;
-- 
2.45.0


