Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332A3606A332
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 18:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=QYi3YX0c
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRZnr-0006AS-N2; Thu, 12 Nov 2026 13:45:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xRZnl-00064X-SM; Thu, 12 Nov 2026 13:45:37 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xRZnk-0003eK-1k; Thu, 12 Nov 2026 13:45:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794509113; bh=hcOYx8NlulQA7fYgRuOQMjk3eBYQiUUNtmBCNBNgsAU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=QYi3YX0chnEW0052OHULNmQcu84O3DvSvoVydJxVXl7PCq6obk4HUYQ5uDqQGoBrV
 kUDp1DYhLZ4iiXtNQQ51HivZs41+TzEiXhLUixbIX8taj0E9NuaPpBHuAGBTVgClJ3
 6IdZ4nZ64AGPzz22NPdPGoAyT8tz0S7tuGzqY6U/iuQUi4ZT/7706EKSRNqVLh77cX
 9SISsZL4evwdbsOj9DnB9rXj2vHvdZ+6udKZJsxf+kdRcPnTAPx9RORBknfbl/+RSR
 Nct4oLHuCzRMGVo59glPdJbLzxQSfbhNpjnZQ+ikxQxOuhtgqeof5fHEifupVV328n
 6ATijkds1RIAQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8D75A1E5D21;
 Thu, 12 Nov 2026 21:45:13 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8BC7245AADB;
 Thu, 12 Nov 2026 21:45:13 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 5A457B7C58; Thu, 12 Nov 2026 21:45:13 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Matthew White <mehw.is.me@proton.me>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 6/6] configure: --disable-containers should prevent `docker.py
 probe`
Date: Thu, 12 Nov 2026 21:45:09 +0300
Message-ID: <20261112184513.2324634-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261112184513.2324634-1-mjt@tls.msk.ru>
References: <20261112184513.2324634-1-mjt@tls.msk.ru>
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

From: Matthew White <mehw.is.me@proton.me>

Upstream commit c4ce04cfb7460d46c0262d437a7f35bb5c5fc449 changed the
configure file to set container_command regardless of use_containers.
As a result, it runs `docker.py probe` to detect a Docker-compatible
application, such as Podman, even when --disable-containers is used.

On Gentoo, this reopens https://bugs.gentoo.org/732972.  As reported
in https://bugs.gentoo.org/984747, the `docker.py probe` command can
trigger SANDBOX ACCESS VIOLATION errors under QEMU v11.1.2:

 * ACCESS DENIED:  open_wr_creat: /var/lib/rpm/rpmdb.sqlite-wal
 * ACCESS DENIED:  fchown:        /var/lib/rpm/rpmdb.sqlite-wal
 ...

This patch is to prevent `docker.py probe` from running and to clear
container_command when --disable-containers is used.

Buglink: https://bugs.gentoo.org/984747
Signed-off-by: Matthew White <mehw.is.me@proton.me>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 configure | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/configure b/configure
index af14a9c23ef..d38268e340f 100755
--- a/configure
+++ b/configure
@@ -1277,12 +1277,17 @@ fi
 ##########################################
 # functions to probe cross compilers
 
-if test "$container_command" = ""; then
-    container_command=$($python "$source_path"/tests/docker/docker.py probe)
-    test "$container_command" = "no" && container_command=""
-fi
-if test $use_containers = "yes" && test "$container_command" != ""; then
-    docker_py="$python $source_path/tests/docker/docker.py --command $container_command"
+if test $use_containers = "yes"; then
+    if test "$container_command" = ""; then
+        container_command=$($python "$source_path"/tests/docker/docker.py probe)
+        test "$container_command" = "no" && container_command=""
+    fi
+    if test "$container_command" != ""; then
+        docker_py="$python $source_path/tests/docker/docker.py --command $container_command"
+    fi
+else
+    # the option --disable-containers should override and disable --container-command
+    container_command=""
 fi
 
 # cross compilers defaults, can be overridden with --cross-cc-ARCH
-- 
2.47.3


