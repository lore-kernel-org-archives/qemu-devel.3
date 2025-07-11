Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E518DC83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 13:51:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaE9j-0006O5-B2; Fri, 11 Jul 2025 09:51:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <unisono@quyllur.org>)
 id 1uaE5D-00064X-Fc
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:46:35 -0400
Received: from quyllur.org ([185.247.226.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <unisono@quyllur.org>)
 id 1uaE58-00016D-PC
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:46:35 -0400
Received: from quyllur.org (localhost [127.0.0.1])
 by quyllur.org (OpenSMTPD) with ESMTP id c79b005d;
 Fri, 11 Jul 2025 16:46:12 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=quyllur.org; h=from:to:cc
 :subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding; s=dkimselector; bh=5aq6QtDa6VajchZx0
 TztYXXq7FQ=; b=X3us6PWXCec2GnEQ9tcoD73mko1ELStASsJUXGSmvpI1E2sfd
 cXxTsuF+FukBsZS7Kf5ziUHyPy5xmu7tQas6FDhTjkYOMq6kazDibYl+EQgInIxg
 MrAhkA/2FaxSU433fmOImqSf+Ex9fQln5sr6OCWEApMuqa29+5pH8VLvG8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=quyllur.org; h=from:to:cc
 :subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding; q=dns; s=dkimselector; b=T3KEKpEqKmi
 gqHkVir6ZlZwt+uy+TtqdsdR49T7STXTrupTzRd05rOEJFCZdUA3EI5Y+lpVXTgl
 CU/L0k1J9Kbw+qnSQSZgzV9DcMlkFu6/GC7/wmZ6ML2RZDZh95JpTxhmhzfJX1s9
 i0gRxIHqYPAKwHTi2gX1p8Sddly9MflU=
Received: from Rizin (<unknown> [194.127.199.111])
 by quyllur.org (OpenSMTPD) with ESMTPSA id 57f113ba
 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO); 
 Fri, 11 Jul 2025 16:46:06 +0300 (EEST)
From: unisono@quyllur.org
To: alex.bennee@linaro.org
Cc: atar4qemu@gmail.com, laurent@vivier.eu, mark.cave-ayland@ilande.co.uk,
 philmd@linaro.org, qemu-devel@nongnu.org, Rot127 <unisono@quyllur.org>
Subject: [PATCH 3/3] Assign the GDB register XML files of Sparc64 to
 Sparc32plus.
Date: Fri, 11 Jul 2025 08:45:38 -0500
Message-ID: <20250711134538.57520-2-unisono@quyllur.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250711134538.57520-1-unisono@quyllur.org>
References: <87h5zltojx.fsf@draig.linaro.org>
 <20250711134538.57520-1-unisono@quyllur.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.247.226.42; envelope-from=unisono@quyllur.org;
 helo=quyllur.org
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SORTED_RECIPS=2.499, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Rot127 <unisono@quyllur.org>

Commit 3/3

Signed-off-by: Rot127 <unisono@quyllur.org>
---
 configs/targets/sparc32plus-linux-user.mak | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/targets/sparc32plus-linux-user.mak b/configs/targets/sparc32plus-linux-user.mak
index 7a16934fd1..0d9cf44652 100644
--- a/configs/targets/sparc32plus-linux-user.mak
+++ b/configs/targets/sparc32plus-linux-user.mak
@@ -5,4 +5,5 @@ TARGET_ABI_DIR=sparc
 TARGET_SYSTBL_ABI=common,32
 TARGET_SYSTBL=syscall.tbl
 TARGET_BIG_ENDIAN=y
+TARGET_XML_FILES=gdb-xml/sparc64-core.xml
 TARGET_LONG_BITS=64
-- 
2.50.0


