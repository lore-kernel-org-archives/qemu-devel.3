Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ACC6C4345F
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2024 17:15:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3fS5-0001nd-TJ; Sun, 05 May 2024 13:15:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1s3fS4-0001mN-8r
 for qemu-devel@nongnu.org; Sun, 05 May 2024 13:15:04 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1s3fS2-0005j2-NN
 for qemu-devel@nongnu.org; Sun, 05 May 2024 13:15:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=y1pCsRYGvDr35bTdn+QJCzGL0DPnvrEX9HngvWUCCiY=; b=CLldyQ/GepXz30TX
 murXN/Jw/Mv89fwyq/EomrecGaLftEpIhLn5nfMwiqgpXRX5h2TEnr+ZB2Q+GLetUWyuzRv3xNAlM
 DSDtA3bBtrZLoHXs0bEPIAXTms8bOeDcFwtIbRyOEqvaFH4HtPn5sbRnELzoNlUIMADgiCNdb2emN
 o1TSDQrU5qGiFVL8Y4fxEJtOqENuGcEw6wpAnCojuCkCqti4zrzcvfYd2OL33OycwjUJOSdrpo3CW
 zr4bM4fk/pSo2uo3pGXTE8f9fKaxa2SBV6M+9mHsz09mRvmVTP1a7q6duX/wInjVPkUw61a+jE9rO
 l9kpYFRZiFK+pJaTNQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
 by mx.treblig.org with esmtp (Exim 4.96)
 (envelope-from <dave@treblig.org>) id 1s3fRz-004nca-2d;
 Sun, 05 May 2024 17:14:59 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: peter.maydell@linaro.org,
	laurent@vivier.eu
Cc: qemu-devel@nongnu.org,
	"Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH 7/7] net/can: Remove unused struct 'CanBusState'
Date: Sun,  5 May 2024 18:14:44 +0100
Message-ID: <20240505171444.333302-8-dave@treblig.org>
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

As far as I can tell this struct has never been used in this
file (it is used in can_core.c).

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
---
 net/can/can_host.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/can/can_host.c b/net/can/can_host.c
index a3c84028c6..b2fe553f91 100644
--- a/net/can/can_host.c
+++ b/net/can/can_host.c
@@ -34,12 +34,6 @@
 #include "net/can_emu.h"
 #include "net/can_host.h"
 
-struct CanBusState {
-    Object object;
-
-    QTAILQ_HEAD(, CanBusClientState) clients;
-};
-
 static void can_host_disconnect(CanHostState *ch)
 {
     CanHostClass *chc = CAN_HOST_GET_CLASS(ch);
-- 
2.45.0


