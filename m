Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD8CC4345F
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2024 17:16:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3fS3-0001kr-5P; Sun, 05 May 2024 13:15:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1s3fS1-0001jW-5J
 for qemu-devel@nongnu.org; Sun, 05 May 2024 13:15:01 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1s3fRz-0005iL-ND
 for qemu-devel@nongnu.org; Sun, 05 May 2024 13:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=6Hyxc6NsbvquaujV8/AXCDaGepCJvLT6ei8fyjF4/nE=; b=OD48jMksWpwm1NDk
 Oop1yNMQF2iIL+ovEdBVaVDFlu+v5h9OjSHj85fBXGBy99iCKFuI/czUlfMpS4UIiykhy7gqtZOhQ
 iWUtb/g67AHf87laQEsALvSkKWINd2tzqXGmZWVmFG1m4CbQLdZYKmqaimOb7Bt9dVfTOf2vBlW0u
 fUB9kgMQf+nPLzp0rwj/H+Y5mzP9UTS47c3L/tBy8mfjE2S9LdJ3c4MXNfIvYyjxlXxFMfFus2+sV
 9wPdtC+7516Za9QpQf6aaTTWmLaa+zOHUqOCDj03755olCOObyCIdgw9gzHNqR1XOKg5OTeFOv6Jr
 gCb/E1Mq9NRoZPkpXA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
 by mx.treblig.org with esmtp (Exim 4.96)
 (envelope-from <dave@treblig.org>) id 1s3fRw-004nca-2q;
 Sun, 05 May 2024 17:14:56 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: peter.maydell@linaro.org,
	laurent@vivier.eu
Cc: qemu-devel@nongnu.org,
	"Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH 3/7] linux-user: sparc: Remove unused struct 'target_mc_fq'
Date: Sun,  5 May 2024 18:14:40 +0100
Message-ID: <20240505171444.333302-4-dave@treblig.org>
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

This struct is unused since Peter's
Commit b8ae597f0e6d ("linux-user/sparc: Fix errors in target_ucontext
structures")

However, hmm, I'm a bit confused since that commit modifies the
structure and then removes it, was that intentional?

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
---
 linux-user/sparc/signal.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/linux-user/sparc/signal.c b/linux-user/sparc/signal.c
index f164b74032..8181b8b92c 100644
--- a/linux-user/sparc/signal.c
+++ b/linux-user/sparc/signal.c
@@ -546,11 +546,6 @@ void setup_sigtramp(abi_ulong sigtramp_page)
 typedef abi_ulong target_mc_greg_t;
 typedef target_mc_greg_t target_mc_gregset_t[SPARC_MC_NGREG];
 
-struct target_mc_fq {
-    abi_ulong mcfq_addr;
-    uint32_t mcfq_insn;
-};
-
 /*
  * Note the manual 16-alignment; the kernel gets this because it
  * includes a "long double qregs[16]" in the mcpu_fregs union,
-- 
2.45.0


