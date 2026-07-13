Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC9CC44501
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 11:21:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjEiA-0000Cf-7W; Mon, 13 Jul 2026 07:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1wjEi5-0008Uh-Dl
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 07:20:30 -0400
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1wjEi3-00080G-KM
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 07:20:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=Fjlc31f
 1QAY8DVNww2O6PDsOaYsaRRayc8OQcf0AIMhL6rJQrU+whpj9gxfkg8cGQjN5Xu0i2nRsS
 KLbDSZ38Q7laYLzA9u+9rXUXc9YY+rGT+5K3FCcusnzeRvX8xF/j1WknPOEzj0ZaAp6YwI
 j/B3K8NYDxTtQU98VGzm/VpAtus8EMYezDs2QtelcXygXTE7GugPPIfV3qtiUIqZ8AqVEm
 1rHoqBFsD7L4bkKy/IKEGt8rJDL+ZmKN3RyVDICpuHBYfnsXqeKzO0C+YBoYEwXrpTMVdw
 2EoPezSnBlKiB3rBJDQdZI/h1Xs6aylmvUHsHAkvkYfOiQ8jhnYxHwA==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=o
 Lwt71prGK6I83sbfOW6rxv5mtmxp7hjhNlN3IYrmsM=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=XS0ywIBDS5Wau57egXQsz51xcg8q9GWj4MEsyZH5nKTloW8i4Cd5lxoIpXjF8B35UFYM
 prHnoS6F2xcCh+3ayU/T4JzhEh2mddYqXXHO8pQZCddqelkNnnSfW57cOMzXM/D12tek1M
 YNX5DucWPDPiUhjVZu/NhNBv4Dv8PhlaHCw9zuLYa337BiCmQoQ8tYUWDZuBKQMYPM+M47
 gP/v8W7hnNRR3ROqng0QqwHkqpchNR+pcW7pJ79uHspCmLgUOd62HqJ9heEp/kvl4MDjz/
 PcX37cDSWAiSkJ/1pfZ+00OVmYX0y/X2trB31X522CLwSwNjCKmeoOClMXp2s6DQ==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=Vwo/iDP3; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=/R/dGq+O;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=oLwt71pr
 GK6I83sbfOW6rxv5mtmxp7hjhNlN3IYrmsM=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=Vwo/iDP3IAABSyS5Oeg7kQB2Ee4EVDkgxYF
 GCSBqNTZd1xkWkmjYqbmEfKk764Z9h/JikLIJBdZ5tfcI3jm+TuMGTZyXEf6XxYi0KlM2B
 sJGPD+eN+ZXwJcQTc5P2uGUwQlDCGvchKaXCHqPPUgk/zAJTm112YjYkJAaC5GAljBj4KC
 X7uJFWcTA1YaHzT/qL7nyUZ16TZpZfquBZB7661EFs9gAWgEBHYw7GpIdfWh9MG8qPZs/m
 b9/U12ROQdjPemJ49wjAft/HDs3rmw88C107WCvT30GIGtzzGCQ/iXwGq3eqH22jKyVkq+
 fxntXRDmUiZeQmGxJnmnKKTszRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=oLwt71prGK6I83sbfOW6rxv5mtmxp7hjhNlN3IYrmsM=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=/R/dGq+OVmH8+5+bxB
 P+AciCjQs2lGBfbx295hGqbf32v7LCEmN+uqYGEQ79fHVohjGs/LOwdHwEIyAlpPv9Cw==
Received: by mx1.catap.net (OpenSMTPD) with ESMTPSA id 655b3f44
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Mon, 13 Jul 2026 13:20:17 +0200 (CEST)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 9fabe162;
 Mon, 13 Jul 2026 13:20:14 +0200 (CEST)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH 8/9] target/mips: allow Octeon unaligned accesses
Date: Mon, 13 Jul 2026 13:16:36 +0200
Message-ID: <20260713112004.4956-9-kirill@korins.ky>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260713112004.4956-1-kirill@korins.ky>
References: <20260713112004.4956-1-kirill@korins.ky>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.55.82.72; envelope-from=kirill@korins.ky;
 helo=mx1.catap.net
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

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
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
2.54.0


