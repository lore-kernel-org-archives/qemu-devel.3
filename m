Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4615DCD4F24
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:19:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuRZ-00084A-B9; Tue, 12 May 2026 17:15:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuRW-0007b5-WD; Tue, 12 May 2026 17:15:07 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuRU-0005vP-RI; Tue, 12 May 2026 17:15:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619305; bh=OqpCMFDriJq7bLue/i+En3QGZ4ydXZjQ0P+n8gzci4k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=bXeRf9CT0inEKaZsOmubjK+6H6Vmwf1cr5QB8bGt8uXeid4R2HvgGkH3xrjMVQoCt
 CXg9JxNk7xS7s0Q2xx9pwYSBWqd82c+YohNP29P4ssHUzqsrbWl6f/5r9l0tZfZYbX
 eoyeVpZPJr5cixoUOVBdyqNE0LS+jyhc/AuWSfGvNjvAAxwfbxf8zkWpE3T9S1KIvp
 QuY28s+XQtQrjSU+k4xN33mc4jJbGqwwOuGuGWleRvu/dDHS3nqtJmL0KmjwB6aDjj
 F5/JvpB0OPK3hWSbYUDwJUSWOyfY7Pgm9puONM6a3A/8YxXfK6jLHU77dKlpLhM/eS
 B19aKyc0pyP5g==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C3D0F1AA398;
 Tue, 12 May 2026 23:55:05 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id D07563ABD07;
 Tue, 12 May 2026 23:55:09 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Helge Deller <deller@gmx.de>,
 Peter Hartley <peter@talesfromthearmchair.net>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 090/117] linux-user: Use abi_int for imr_ifindex in
 ip_mreqn struct
Date: Tue, 12 May 2026 23:54:32 +0300
Message-ID: <20260512205503.361097-90-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Helge Deller <deller@gmx.de>

Peter Hartley noticed, that in the qemu code the imr_ifindex member of
struct target_ip_mreq needs to be of type "int" instead of "long", which
is what the Linux kernel uses on all architectures.

Adjust the type accordingly, and add a QEMU_BUILD_BUG_ON() checker to
prevent such issues in the future.

This change should fix multicast issues when using hosts and guests with
different endianess or bit size.

Reported-by: Peter Hartley <peter@talesfromthearmchair.net>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2553
Signed-off-by: Helge Deller <deller@gmx.de>
(cherry picked from commit e2af3eadc09b3672017c650e0abfd29a08521921)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 755304d604..47270eb15e 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -2164,6 +2164,8 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
 
             QEMU_BUILD_BUG_ON(sizeof(struct ip_mreq) !=
                               sizeof(struct target_ip_mreq));
+            QEMU_BUILD_BUG_ON(sizeof(struct ip_mreqn) !=
+                              sizeof(struct target_ip_mreqn));
 
             if (optname == IP_MULTICAST_IF) {
                 min_size = sizeof(struct in_addr);
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 55443ff965..be68c54c90 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -210,7 +210,7 @@ struct target_ip_mreq {
 struct target_ip_mreqn {
     struct target_in_addr imr_multiaddr;
     struct target_in_addr imr_address;
-    abi_long imr_ifindex;
+    abi_int imr_ifindex;
 };
 
 struct target_ip_mreq_source {
-- 
2.47.3


