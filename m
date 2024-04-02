Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFCC1CD129A
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 13:17:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrdzA-0004x2-Ee; Tue, 02 Apr 2024 09:15:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <martin@geanix.com>)
 id 1rrZLz-0002r9-FY; Tue, 02 Apr 2024 04:18:47 -0400
Received: from www530.your-server.de ([188.40.30.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <martin@geanix.com>)
 id 1rrZLa-0000GZ-Um; Tue, 02 Apr 2024 04:18:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com; 
 s=default2211;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=xodLMmFhUnIM014SbB1dYLiXNH1fSXGDxPNUu70lntg=; b=h87sfBlq899h0LjQMm4RpbLTJB
 gsFHBnYBqs4ijkQ5jSDM4gGNPG78d0CObdGmXDowj5S9XJzqqcopGUYooIpZNM9+rz4y09bia6TE6
 qmP5MCfccW/gZKmPzL1AmoDuQh0eGezikTTeAIXsWvybJD9bDERWHdKuA56wMOY2JLYNuf6kKFcAp
 PGzhLEoq4gDLOuCPxfBnt1fMHn1yrs60Xr1a0brKK+2p3eI2OR4Ei/773cHGw527oMpihykBAkhai
 lLiMKgZMkcXfxmLVekuegVmiFf5DGA8oES2BO6feKRdYSFMKGNkJdPbklEAl+cMnSB95q7k1GzjC0
 YKpVX5vQ==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.94.2) (envelope-from <martin@geanix.com>)
 id 1rrZLH-000IXv-MH; Tue, 02 Apr 2024 10:18:03 +0200
Received: from [185.17.218.86] (helo=zen..)
 by sslproxy01.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <martin@geanix.com>) id 1rrZLH-0003f0-34;
 Tue, 02 Apr 2024 10:18:03 +0200
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH] Makefile: preserve --jobserver-auth argument when calling
 ninja
Date: Tue,  2 Apr 2024 10:17:38 +0200
Message-ID: <20240402081738.1051560-1-martin@geanix.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: martin@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27232/Mon Apr  1 10:23:51 2024)
Received-SPF: pass client-ip=188.40.30.78; envelope-from=martin@geanix.com;
 helo=www530.your-server.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 02 Apr 2024 09:15:20 -0400
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

Qemu wraps its call to ninja in a Makefile. Since ninja, as opposed to
make, utilizes all CPU cores by default, the qemu Makefile translates
the absense of a `-jN` argument into `-j1`. This breaks jobserver
functionality, so update the -jN mangling to take the --jobserver-auth
argument into considerationa too.

Signed-off-by: Martin Hundebøll <martin@geanix.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 8f36990335..183756018f 100644
--- a/Makefile
+++ b/Makefile
@@ -142,7 +142,7 @@ MAKE.k = $(findstring k,$(firstword $(filter-out --%,$(MAKEFLAGS))))
 MAKE.q = $(findstring q,$(firstword $(filter-out --%,$(MAKEFLAGS))))
 MAKE.nq = $(if $(word 2, $(MAKE.n) $(MAKE.q)),nq)
 NINJAFLAGS = $(if $V,-v) $(if $(MAKE.n), -n) $(if $(MAKE.k), -k0) \
-        $(filter-out -j, $(lastword -j1 $(filter -l% -j%, $(MAKEFLAGS)))) \
+        $(or $(filter -l% -j%, $(MAKEFLAGS)), $(if $(filter --jobserver-auth=%, $(MAKEFLAGS)),, -j1)) \
         -d keepdepfile
 ninja-cmd-goals = $(or $(MAKECMDGOALS), all)
 ninja-cmd-goals += $(foreach g, $(MAKECMDGOALS), $(.ninja-goals.$g))
-- 
2.44.0


