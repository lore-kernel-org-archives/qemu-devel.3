Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D050A606A33D
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=P7KgFkNQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWp0t-00020D-3K; Fri, 27 Nov 2026 01:00:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp0W-0001UL-2p; Fri, 27 Nov 2026 01:00:29 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp0S-0001K8-Iu; Fri, 27 Nov 2026 01:00:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795758881; bh=V+OLfHxdHsNzDHwR5+L5BXZQpJTLfKI93fz8RVFHbWo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=P7KgFkNQ0WW+WZ4syasARpQcOAryI/sLvCNqh1QouVXHpV5Wn8vwz2ua6FFx8gRXK
 EK6C5DzwBOus1hgL6idcTAU2wdG20KGWI/jQKHiHbNxxG4lFssxwR31HCjCxgyb0I9
 Nx4XhoykNWse+mJpKe+twTF76QH59XtTpHmlFriKg4qe3OA2+F50LGZ5KpfdOXsi8/
 ZQDzNhlKRnnge0uERoAS0d1QhzcJgvl1hBROSsKrHPO8/zoHHymSWMswEYpFaVHJZm
 AF+/uY3hNNRKsin1dlXef+p/F0W01Pda6U+uT6QSGDxDQejduY/dHF5bpMIUyerkTR
 EDrsydOanmAPw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9835C1EA306;
 Fri, 27 Nov 2026 08:54:41 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 95EAB469940;
 Fri, 27 Nov 2026 08:54:41 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 88E18CF28C; Fri, 27 Nov 2026 08:54:41 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 v2 123/140] CI: Use mingw-w64-x86_64-curl-winssl
 instead of mingw-w64-x86_64-curl for Windows build
Date: Fri, 27 Nov 2026 08:53:49 +0300
Message-ID: <20261127055421.39015-64-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Stefan Weil <sw@weilnetz.de>

mingw-w64-x86_64-curl-winssl is required for https connections.

Signed-off-by: Stefan Weil <sw@weilnetz.de>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20250806200909.507803-1-sw@weilnetz.de>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit fe26463d7b3e0f65de4b11377d762d5dcc03bd24)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
index 45ed0c96fea..beac39e5bde 100644
--- a/.gitlab-ci.d/windows.yml
+++ b/.gitlab-ci.d/windows.yml
@@ -77,7 +77,7 @@ msys2-64bit:
       git grep make sed
       mingw-w64-x86_64-binutils
       mingw-w64-x86_64-ccache
-      mingw-w64-x86_64-curl
+      mingw-w64-x86_64-curl-winssl
       mingw-w64-x86_64-gcc
       mingw-w64-x86_64-glib2
       mingw-w64-x86_64-libnfs
-- 
2.47.3


