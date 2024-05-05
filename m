Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB5BCC4345F
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2024 17:16:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3fS1-0001jR-5J; Sun, 05 May 2024 13:15:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1s3fRz-0001gz-C1
 for qemu-devel@nongnu.org; Sun, 05 May 2024 13:14:59 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1s3fRx-0005hZ-21
 for qemu-devel@nongnu.org; Sun, 05 May 2024 13:14:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=zoFRNLIY6BP1XoWwIzP9QZR90QvA4/4xhjDkn34Jg4w=; b=Mz2xSG9Ui5d0/FyD
 f+fpNbs2Vch4OhQDOVsMAfWv4GBjqGTBv4/PratNtRkY+zbKqukiPQ4bUPQWp0XVBHwijkrHZCveY
 896QWWsNtTuFnL/MEDujQX+wyY5wkVAzJdKNPYnJ94tz4C1rToy/C7o+Fbur+MadqpbJ2zhN4kxHN
 X65ktBDyHS0wxhFycNl2L+8/+26XtR+fjVJCeI37RwG3x4YAEzZXin04gdVs+NgRaU/ufaWiPVnbU
 lL+5GI2QY8kB9We5Aba8RyDJpXP6sBFENsl/wCt+CuNoV+rHK9oKGVDwRJ99wsA7DsBCla2UOl4Mm
 piG0luWG6nEMcWvrwg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
 by mx.treblig.org with esmtp (Exim 4.96)
 (envelope-from <dave@treblig.org>) id 1s3fRs-004nca-2k;
 Sun, 05 May 2024 17:14:52 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: peter.maydell@linaro.org,
	laurent@vivier.eu
Cc: qemu-devel@nongnu.org,
	"Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH 1/7] linux-user: cris: Remove unused struct 'rt_signal_frame'
Date: Sun,  5 May 2024 18:14:38 +0100
Message-ID: <20240505171444.333302-2-dave@treblig.org>
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

Since 'setup_rt_frame' has never been implemented, this struct
is unused.

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
---
 linux-user/cris/signal.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/linux-user/cris/signal.c b/linux-user/cris/signal.c
index 4f532b2903..10948bcf30 100644
--- a/linux-user/cris/signal.c
+++ b/linux-user/cris/signal.c
@@ -35,14 +35,6 @@ struct target_signal_frame {
     uint16_t retcode[4];      /* Trampoline code. */
 };
 
-struct rt_signal_frame {
-    siginfo_t *pinfo;
-    void *puc;
-    siginfo_t info;
-    ucontext_t uc;
-    uint16_t retcode[4];      /* Trampoline code. */
-};
-
 static void setup_sigcontext(struct target_sigcontext *sc, CPUCRISState *env)
 {
     __put_user(env->regs[0], &sc->regs.r0);
-- 
2.45.0


