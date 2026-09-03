Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80FBFC624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 12:07:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x26CG-0002tP-4p; Thu, 03 Sep 2026 08:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1x26CD-0002s0-I5
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 08:05:33 -0400
Received: from mx2.catap.net ([65.21.79.163])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1x26CB-0005Ja-PO
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 08:05:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=JtsWlNo
 VAvbxXw57qvxt3fOowbbqlH3nlI5t4GBn6FF9WmrivCaZ3eDO3uy7eiRuD9EM5iJzWCqQa
 E73CapZAABSbQZpqoY60QvUSybGZmz91mdjyQNWxOxxP9zmlFj/DDfyRDfuDxCQrOXoHc6
 F4vLCrp0NqoMTv7ZZ+oQ14FuMB/pAXHgv8FFT+DGRyRnAV8EhI6Ifqgj1Y00PEwizobK+A
 6M9Gt+0gtMUOhV10JZZj2f/+TE9Ue+jLS5X54+zbASHYV+b7CZjUZNLrSgJ5V2FAResUo5
 IEFs5/zU/QXTt7A/F84j/prChDSeQL1X2/7B2VdhOXGh6e7tuH0Dx7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=e
 Rs7Nx22YOQkSo3nfdsN3O8p4gxxy+RQUr+QOagrgLk=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=Yrk4w5VX31BZKFuIWgs38plpfTVfZDi98G1/g8NsYa0oE0fWuPlHwzmTYuCIDlB0zGU7
 cC9qgS/1IgMe8JwvlH6DNpmq61UFC9IIL2wZzOwe51eQUQ/eS+qlM5iZQKWDNvnqsefezh
 4/o5lwkeHw0LmJyPim1URBOxZGsAFZt1esaFJ0c+XRn9C1x0TLHAxLdae/nWKNELgaon6T
 nIjRF2V4iheW7i/b4RL5TuN+k0dxsN7jUoiKgbh9W1EVO/gN3ODCHQtfThZlfkBaZL7mso
 bub+Va4+/0cE1SaaaRqjkBXZ/cmrCncv9X1G92a+lLPB6FPbPmCW9zOY6Ayuc2Rw==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=fPGQ2uJ2; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=4OkcnKlM;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=eRs7Nx22
 YOQkSo3nfdsN3O8p4gxxy+RQUr+QOagrgLk=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=fPGQ2uJ2nUT/4eq6BE3u96FwDU5rj0aajX2
 4LMwPh1zHK6KTttPgynGHxrPMFaFjq5LyT2H+gMik681QcYsvyN2d+kX0DfEyTXNQpDiuA
 2zzEy4aiDJ0kneIZv4jblyRNRCXR65/1Q1Rbj75Q+a608zCRrAJk2ndmruR0l+JWpMNdLS
 BD+0t1UHYrLIeYoM1EG80KCMtiEtqjX978ozfon3AhewbdnE/L6yxhs4pF6YKr4Nu+eNqD
 ZIZiPtLPDEXoxoGvUBZx2/quRH5IGxt+S9hlbMZbsHLkLkKxKXaABzDHzr7irBbBUXEGOI
 Gj8MncV87zyKPtln93XTy9v5uEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=eRs7Nx22YOQkSo3nfdsN3O8p4gxxy+RQUr+QOagrgLk=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=4OkcnKlMPl8TmTOgoK
 a5CymBWWB94h3eFTOM8NLEw6OI3OcIOKfSgUSq7kJgUjEyPRwvbVgMi0poURfRD4GPAQ==
Received: by mx2.catap.net (OpenSMTPD) with ESMTPSA id 6e9a89a8
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Thu, 3 Sep 2026 14:05:24 +0200 (CEST)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id bb67079e;
 Thu, 3 Sep 2026 14:05:15 +0200 (CEST)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH v2 07/25] target/mips: allow Octeon unaligned accesses
Date: Thu,  3 Sep 2026 14:01:55 +0200
Message-ID: <20260903120510.34876-8-kirill@korins.ky>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903120510.34876-1-kirill@korins.ky>
References: <20260903120510.34876-1-kirill@korins.ky>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=65.21.79.163; envelope-from=kirill@korins.ky;
 helo=mx2.catap.net
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Octeon firmware performs unaligned memory accesses during early DDR
setup.

Use QEMU's unaligned memory operation mode for Octeon translations,
matching the existing treatment for MIPS R6 and Loongson3A.
---
 target/mips/tcg/translate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 123ba6aecd..d83f76e514 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -15193,6 +15193,7 @@ static void mips_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 #endif
     ctx->default_tcg_memop_mask = (!(ctx->insn_flags & ISA_NANOMIPS32) &&
                                   (ctx->insn_flags & (ISA_MIPS_R6 |
+                                  INSN_OCTEON |
                                   INSN_LOONGSON3A))) ? MO_UNALN : MO_ALIGN;
     if (tb_flags & TB_FLAG_MIPS_FIXADE) {
         ctx->default_tcg_memop_mask = MO_UNALN;
-- 
2.55.0


