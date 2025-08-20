Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5847ACA0EE4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 18:38:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uonhL-0001bV-RP; Wed, 20 Aug 2025 14:38:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aokblast@FreeBSD.org>)
 id 1uonhJ-0001bI-Mi
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 14:38:09 -0400
Received: from mx2.freebsd.org ([96.47.72.81])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aokblast@FreeBSD.org>)
 id 1uonhI-0008RO-9a
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 14:38:09 -0400
Received: from mx1.freebsd.org (mx1.freebsd.org [96.47.72.80])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits)
 client-signature RSA-PSS (4096 bits))
 (Client CN "mx1.freebsd.org", Issuer "R10" (verified OK))
 by mx2.freebsd.org (Postfix) with ESMTPS id 4c6Zvg2ZcCz4SRL;
 Wed, 20 Aug 2025 18:38:07 +0000 (UTC)
 (envelope-from aokblast@FreeBSD.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [96.47.72.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
 client-signature RSA-PSS (4096 bits) client-digest SHA256)
 (Client CN "smtp.freebsd.org", Issuer "R11" (verified OK))
 by mx1.freebsd.org (Postfix) with ESMTPS id 4c6Zvg1fdsz3DVx;
 Wed, 20 Aug 2025 18:38:07 +0000 (UTC)
 (envelope-from aokblast@FreeBSD.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
 t=1755715087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Meg5y5yIO9cA5TOxaGY2rGJmv+4eQqldz+xmooMPcro=;
 b=yImsna9cFl1/LpIM3tiupWi9AzsIAcRGhcKZ4DgqKigtuHhYAj8eBHE8N4noijt9qeWiIl
 0OWJskdSIrmeAxw80tHmDj7vXCmpDgK/e73vT2G6Vp101yFgxBFj7TxL9XymVSqkycaMco
 O/0mChsWqqviEvDCBy0TV77Fw/50ilrYprLqCLBHwf4aiI7epn6B6q0m07hhFb3drpSL+B
 ZrRDbS9kSeYzhzCsggn8NZ9pbea7GKEsWBi2/Ds1I++BbwfiGbJ+3O0QNaUTjEUdCgGXSs
 9MMzKlYuMyVVe9t8a8AbAsxETAYdqC2pXCiJAfPcNZYXzJ4J0iqqspMikzUycw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
 s=dkim; t=1755715087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Meg5y5yIO9cA5TOxaGY2rGJmv+4eQqldz+xmooMPcro=;
 b=mo4y6SWJd4NLmDSLDrtdYHgf9q1DIxwfkseBQqi28fvXY2FNgJGHVCisOFmmwREs3b9+zB
 XVGcvWehQUEOuae9PkuacnZ+onwPmd5Ny8117ScNeGqHJpMbKQbTKJ1AcZlvHpZnLZE1Il
 L4CCEBBo6XKYZh122ksnQ+JWudWHczP1SxQnoh/yvQpr6F+0OaDhB1PQ8KfvB7wQIzBUbt
 e7ps79c777q6LOXDZjCuZsVQowj63KO3Hht9E39bt+bgo367Eo0Nj8FE4ikcdPHoR1nlFx
 U4AOsvRgqiowt6deoexjDA+VoiRHdGDelMkbrAZLXQ8Z7VEd0lCYOTuTEfwcuA==
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1755715087; a=rsa-sha256; cv=none;
 b=CIWwW0hnHp4paUtCheFDOvllSaoAjOQuXrUJObaTrUxjlc8hcVOsZsVuNxMrDao0wDz6eN
 X9oMwq+oyDZVJ5U+dqve+D3mxUbfl/Sz70IPVtMlIMWJep2bJYwTRaGaBPEEkr+OE45zMD
 zBe7a9hOCS8XFGL0Oe8TCtB1TPYi0xcwtmsj+YtjiOTkbmETyFrwS8r5pD1GfQHCbendQA
 pdnp7Cp89sJNGGAKL/Gu1g4zvezQvQkI9bMvt+1KaSW1vUelgtES7tq6PX+NiaAv31MJ1E
 12C9l2vOkMRxFF2Bkf/iKAVACS3dUXD5SzyIlAbN1X5XsESdpkwc3AVlv20VKw==
ARC-Authentication-Results: i=1;
	mx1.freebsd.org;
	none
Received: from localhost.localdomain (1-34-10-216.hinet-ip.hinet.net
 [1.34.10.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 (Authenticated sender: aokblast)
 by smtp.freebsd.org (Postfix) with ESMTPSA id 4c6Zvd6nT1ztFD;
 Wed, 20 Aug 2025 18:38:05 +0000 (UTC)
 (envelope-from aokblast@FreeBSD.org)
From: ShengYi Hung <aokblast@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 ShengYi Hung <aokblast@FreeBSD.org>
Subject: [PATCH] i6300esb: fix incorrect mask for interrupt type
Date: Wed, 20 Aug 2025 14:37:38 -0400
Message-ID: <20250820183738.20524-1-aokblast@FreeBSD.org>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=96.47.72.81; envelope-from=aokblast@FreeBSD.org;
 helo=mx2.freebsd.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

According to Intel 6300ESB Controller Hub Datasheet 14.4.15, the interrupt type
mask should be 0x03 (0b11) instead of 0x11. In the original
implementation, when we want to disable all interrupt by setting the
value to 0x03, we will get 0x01 which will be incorrect when we reading
the value again. However, there is no problem since 0x1 is reserved and
unused.

Signed-off-by: ShengYi Hung <aokblast@FreeBSD.org>
Sponsored by:   The FreeBSD Foundation
---
 hw/watchdog/wdt_i6300esb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/watchdog/wdt_i6300esb.c b/hw/watchdog/wdt_i6300esb.c
index bb8a2766b6..3aa01b8d68 100644
--- a/hw/watchdog/wdt_i6300esb.c
+++ b/hw/watchdog/wdt_i6300esb.c
@@ -55,7 +55,7 @@
 /* Config register bits */
 #define ESB_WDT_REBOOT  (0x01 << 5)   /* Enable reboot on timeout          */
 #define ESB_WDT_FREQ    (0x01 << 2)   /* Decrement frequency               */
-#define ESB_WDT_INTTYPE (0x11 << 0)   /* Interrupt type on timer1 timeout  */
+#define ESB_WDT_INTTYPE (0x03 << 0)   /* Interrupt type on timer1 timeout  */
 
 /* Reload register bits */
 #define ESB_WDT_RELOAD  (0x01 << 8)    /* prevent timeout                   */
-- 
2.50.1


