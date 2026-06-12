Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CD2CCD98CF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 17:00:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY5F2-00056f-J1; Fri, 12 Jun 2026 13:00:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wY5Eq-00053E-Jd; Fri, 12 Jun 2026 13:00:12 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wY5Eo-0005ue-VO; Fri, 12 Jun 2026 13:00:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781283582; bh=wOw4gHrdwsI/h/+aXyMszHFlv9QonRwF2tbfMoUWMxU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Yu5HSzbgFnuaOHzdtlPrFEapgkltc+Uf7FfumvMOOh/Nux+5tFNBePefxawXzsmZ+
 Gk3qAg4/7Bj1b5+6MqjS/Z/sPhJ1O7JCnKQ6QTU6J91bwXZdy7BBhXXbDBLX55dPZ0
 3VYGPXAy8/tlxKRvJPYpgq/lrjaiqd9/gTHJAwbgDyl2qfoek440K3wUmMQ3944ubp
 5tchbdphhgBcX4r2m9BqupHncmcpU0PbvxlKQqpprp2Gp+NdDgLMXeyNP4XtAB7Bvi
 Cox3NHjAuWWBRo6s82h0OaaOB6AfSInL9EhwCSQecWtwfRDN3SzLIpK/mvXF1fmXrO
 fwT8m/2c20K/g==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0DF8E1B6BC7;
 Fri, 12 Jun 2026 19:59:42 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 952FB3CE164;
 Fri, 12 Jun 2026 19:59:57 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 2/8] hw/display/vga: Fix debug message
Date: Fri, 12 Jun 2026 19:59:46 +0300
Message-ID: <20260612165957.1779082-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260612165957.1779082-1-mjt@tls.msk.ru>
References: <20260612165957.1779082-1-mjt@tls.msk.ru>
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Fixes: f9b925fd41 vga: introduce VGADisplayParams
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/display/vga.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/vga.c b/hw/display/vga.c
index 0ac4bf3731..3ea20d7b0f 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -1662,7 +1662,7 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
 
 #if 0
     printf("w=%d h=%d v=%d line_offset=%d cr[0x09]=0x%02x cr[0x17]=0x%02x linecmp=%d sr[0x01]=0x%02x\n",
-           width, height, v, line_offset, s->cr[9], s->cr[VGA_CRTC_MODE],
+           width, height, v, s->params.line_offset, s->cr[9], s->cr[VGA_CRTC_MODE],
            s->params.line_compare, sr(s, VGA_SEQ_CLOCK_MODE));
 #endif
     addr1 = (s->params.start_addr * 4);
-- 
2.47.3


