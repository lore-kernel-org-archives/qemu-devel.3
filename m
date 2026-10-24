Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D936606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 13:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ens-lyon.org header.i=@ens-lyon.org header.a=rsa-sha256 header.s=dkim header.b=RO25KMC2;
	dkim=pass (2048-bit key) header.d=ens-lyon.org header.i=@ens-lyon.org header.a=rsa-sha256 header.s=dkim header.b=L/fcwOd6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKbhy-0008FA-38; Sat, 24 Oct 2026 09:22:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <SRS0=in2V=IO=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org>)
 id 1xKbgr-0007TE-W5
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 09:21:47 -0400
Received: from sonata.ens-lyon.org ([140.77.166.138])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <SRS0=in2V=IO=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org>)
 id 1xKbgn-0000nd-7g
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 09:21:39 -0400
Received: from localhost (localhost [127.0.0.1])
 by sonata.ens-lyon.org (Postfix) with ESMTP id 02A9EA04FA;
 Sat, 24 Oct 2026 15:21:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ens-lyon.org; s=dkim;
 t=1792848091; bh=QBFMfNP5LYG0Z7Yhy6tmRXxmOozuBAzbbB9jh5KLdMc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RO25KMC2vQviTiRpFpekIr8c9lyX22pxa//mxO99akAY4va/NCeyBtScSsyEDKKpy
 WoO58el+SHs+y5w/tXouDRpuupBQ4IDC0v1uZZ2rMfGu6L3iCQ2rUff6H1BTzqaHah
 38I+jc+KKrmkEYdH677Yljst6SjimTUKkKJ8RZg0YUW0QmUXwCgNU+nCc8CkG2aWVU
 YzEAdNYk4jslsFLn2B9WLS494adoqpoXLm5ROVEgG/WAn6jwALv2ULwtUZ6FeQRimB
 4zDgK5hKbswyi7GmYZ4MkoJMSOp8IAWntNsbRoy5PCe+KNR58e3tbAxmt++7FQxLDC
 /JNnIB5sgoWUA==
Received: from sonata.ens-lyon.org ([127.0.0.1])
 by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id INMQe1kkqkR7; Sat, 24 Oct 2026 15:21:30 +0200 (CEST)
Received: from end (lfbn-bor-1-980-210.w90-120.abo.wanadoo.fr [90.120.173.210])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by sonata.ens-lyon.org (Postfix) with ESMTPSA id 34942A0113;
 Sat, 24 Oct 2026 15:21:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ens-lyon.org; s=dkim;
 t=1792848090; bh=QBFMfNP5LYG0Z7Yhy6tmRXxmOozuBAzbbB9jh5KLdMc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=L/fcwOd6ZPwYvaWVuO/nhx9cDERYcCm60kS/EAZEEdDY6lPuaRFqsOZQnW9FIHbOR
 vPedt5CLMzLWirEHRL9AAItKWMUndjuRskLhtS5GyMvfQ9DEPumwBLBJJ1terNDGkl
 ro5Jkxq75iTbM1g0F6rV4a40Tyw+vaHvIioDIGwYlxzlEcz2JEzmj+hI1XlAgY6uag
 FLz8J5ZQ2bEMqc742tlQdJYZ7i2d8XYYSyqFEMVALoOQ88OhK+75JlHB3fniz8l07j
 wev0PcS4SX13MZB84sVe0q2vuQcR2KDb2das0TlB9I5aun+LJcReYsY8ak2Pc5U9Pw
 SyXj1+ovaggVA==
Received: from samy by end with local (Exim 4.100.1)
 (envelope-from <samuel.thibault@ens-lyon.org>)
 id 1xKbgf-00000002b0i-2kgy; Sat, 24 Oct 2026 15:21:29 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Hongyan Xu <getshell@seu.edu.cn>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PULL 1/2] chardev/baum: unregister the brlapi fd handler on finalize
Date: Sat, 24 Oct 2026 15:21:27 +0200
Message-ID: <20261024132128.618909-2-samuel.thibault@ens-lyon.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261024132128.618909-1-samuel.thibault@ens-lyon.org>
References: <20261024132128.618909-1-samuel.thibault@ens-lyon.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=140.77.166.138;
 envelope-from=SRS0=in2V=IO=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org;
 helo=sonata.ens-lyon.org
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

From: Hongyan Xu <getshell@seu.edu.cn>

baum_chr_open() registers baum->brlapi_fd with the main loop through a
raw qemu_set_fd_handler() call.  The chardev base class does not know
about this handler, and char_braille_finalize() only closes the brlapi
connection and frees the handle; it never removes the fd handler.

When the chardev is removed at runtime (QMP chardev-remove /
object_unparent), BaumChardev is finalized and freed while the main loop
still holds an fd handler whose opaque points to the freed object.  The
next time brlapi_fd becomes readable (or the connection drops) the loop
calls baum_chr_read() with a dangling opaque, dereferencing freed
memory -> host use-after-free.

Unregister the handler in char_braille_finalize() before tearing the
connection down, using the same descriptor that baum_chr_open()
registered, and NULL the handle afterwards as a belt-and-braces guard.
Only do so while baum->brlapi is valid: baum_chr_open() sets
baum->brlapi_fd from brlapi__openConnection(), which is
BRLAPI_INVALID_FILE_DESCRIPTOR on failure, and that error path already
g_free()s the handle and returns before any handler is installed.

Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Message-ID: <20260904033055.413-1-getshell@seu.edu.cn>
---
 chardev/baum.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/chardev/baum.c b/chardev/baum.c
index ac1e535ba8..166d6f2f09 100644
--- a/chardev/baum.c
+++ b/chardev/baum.c
@@ -659,6 +659,7 @@ static void baum_chr_read(void *opaque)
     }
     if (ret == -1 && (brlapi_errno != BRLAPI_ERROR_LIBCERR || errno != EINTR)) {
         brlapi_perror("baum: brlapi_readKey");
+        qemu_set_fd_handler(baum->brlapi_fd, NULL, NULL, NULL);
         brlapi__closeConnection(baum->brlapi);
         g_free(baum->brlapi);
         baum->brlapi = NULL;
@@ -671,8 +672,16 @@ static void char_braille_finalize(Object *obj)
 
     timer_free(baum->cellCount_timer);
     if (baum->brlapi) {
+        /*
+         * baum_chr_open() registered brlapi_fd with the main loop via
+         * qemu_set_fd_handler(); unregister it before tearing the
+         * connection down so a later chardev-remove cannot dispatch
+         * baum_chr_read() with a dangling opaque.
+         */
+        qemu_set_fd_handler(baum->brlapi_fd, NULL, NULL, NULL);
         brlapi__closeConnection(baum->brlapi);
         g_free(baum->brlapi);
+        baum->brlapi = NULL;
     }
 }
 
-- 
2.53.0


