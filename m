Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 364E8C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 22:22:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucAW6-0008An-2n; Wed, 16 Jul 2025 18:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1ucA8Q-00087O-4G; Wed, 16 Jul 2025 17:57:54 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1ucA8M-0002EU-JJ; Wed, 16 Jul 2025 17:57:53 -0400
DKIM-Signature: a=rsa-sha256; bh=zzonJQxswZ84hXBpj0LR6s25Asu+hIu08m80f3+4oeY=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:In-Reply-To:To:Cc; q=dns/txt; s=20240113;
 t=1752703065; v=1;
 b=X0Gm50u8nLQ8nosC+CGm0uGd4gy0co4TKA34tII78ndA7O0HH8Od8w1Tb2vOiZg70eqRaTe6
 hWA5VhuFP+16l2SnUWAjDWPuMFj362SeIxAVJDEOJ6hnJRx8Bb0J58zb48fn7gnMni3R0LfYkDl
 TGTwEp4QcLD+ml8vChoIb4S7Q0i241SdGO41V1psj51tYSvn2DEv2zur04t/WeigMfKj8dPR8nb
 58lilqWQ0qo7KfHNb4IstlROSIhZRnhQwPa7RLwHm30ot+ul5JvaSQShZCV9/jo4OxAaDq1DGMm
 GmuiEFHiuJTjDkPNJ9/loXEKVfZuB19140EwEBoQrlhUg==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 90D8F22777;
 Wed, 16 Jul 2025 21:57:45 +0000 (UTC)
From: ~wojtekka <wojtekka@git.sr.ht>
Date: Wed, 16 Jul 2025 22:03:42 +0200
Subject: [PATCH qemu 2/2] Fill out m68k PIC register
Message-ID: <175270306503.19369.144677794735042916-2@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <175270306503.19369.144677794735042916-0@git.sr.ht>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 16 Jul 2025 18:20:18 -0400
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
Reply-To: ~wojtekka <wojtekka@toxygen.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Wojtek Kaniewski <wojtekka@toxygen.net>

D5 is expected to be set to data address on m68k without MMU. See
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/=
m68k/include/asm/flat.h
for reference.

Signed-off-by: Wojtek Kaniewski <wojtekka@toxygen.net>
---
 linux-user/elfload.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index ea214105ff..b151ebcba2 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1756,6 +1756,7 @@ static uint32_t get_elf_hwcap(void)
 static inline void init_thread(struct target_pt_regs *regs,
                                struct image_info *infop)
 {
+    regs->d5 =3D infop->start_data;   /* For uClinux PIC binaries. */
     regs->usp =3D infop->start_stack;
     regs->sr =3D 0;
     regs->pc =3D infop->entry;
--=20
2.45.3

