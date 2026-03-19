Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9711109024D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 16:08:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3FvE-0005Pz-A1; Thu, 19 Mar 2026 12:08:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefan@weilnetz.de>)
 id 1w3FuT-0004xV-TH; Thu, 19 Mar 2026 12:07:48 -0400
Received: from mail.weilnetz.de ([37.120.169.71]
 helo=mail.v2201612906741603.powersrv.de)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefan@weilnetz.de>)
 id 1w3FuR-0004WT-13; Thu, 19 Mar 2026 12:07:45 -0400
Received: from qemu.weilnetz.de (qemu.weilnetz.de [188.68.58.204])
 by mail.v2201612906741603.powersrv.de (Postfix) with ESMTP id DC69ADA07A3;
 Thu, 19 Mar 2026 17:07:39 +0100 (CET)
Authentication-Results: mail.v2201612906741603.powersrv.de; dkim=none;
 spf=temperror (mail.v2201612906741603.powersrv.de: error in processing during
 lookup of stefan@weilnetz.de: DNS error) smtp.mailfrom=stefan@weilnetz.de
Received: by qemu.weilnetz.de (Postfix, from userid 1000)
 id B1FD6460028; Thu, 19 Mar 2026 17:07:39 +0100 (CET)
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Stefan Weil <sw@weilnetz.de>
Subject: [PATCH for-11.0] docs: Update GitHub URL of libu2f-emu
Date: Thu, 19 Mar 2026 17:07:39 +0100
Message-ID: <20260319160739.98913-1-sw@weilnetz.de>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: v2201612906741603
X-Rspamd-Queue-Id: DC69ADA07A3
X-Spamd-Bar: /
X-Spamd-Result: default: False [-1.00 / 12.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; R_MISSING_CHARSET(0.50)[];
 FORGED_SENDER(0.30)[sw@weilnetz.de,stefan@weilnetz.de];
 ONCE_RECEIVED(0.20)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_NO_TLS_LAST(0.10)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_ONE(0.00)[1];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_NEQ_ENVFROM(0.00)[sw@weilnetz.de,stefan@weilnetz.de];
 RCPT_COUNT_THREE(0.00)[4]; ARC_NA(0.00)[]; R_DKIM_NA(0.00)[];
 R_SPF_DNSFAIL(0.00)[DNS failed]; FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action
Received-SPF: pass client-ip=37.120.169.71; envelope-from=stefan@weilnetz.de;
 helo=mail.v2201612906741603.powersrv.de
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Stefan Weil <sw@weilnetz.de>
From:  Stefan Weil via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This avoids a redirect from the old to the new URL.

Signed-off-by: Stefan Weil <sw@weilnetz.de>
---
 docs/system/devices/usb-u2f.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/system/devices/usb-u2f.rst b/docs/system/devices/usb-u2f.rst
index 4f57d5c8c3..f7ca127cbb 100644
--- a/docs/system/devices/usb-u2f.rst
+++ b/docs/system/devices/usb-u2f.rst
@@ -41,7 +41,7 @@ requires a working libudev):
 ----------------
 
 ``u2f-emulated`` is a completely software emulated U2F device.
-It uses `libu2f-emu <https://github.com/MattGorko/libu2f-emu>`__
+It uses `libu2f-emu <https://github.com/Agnoctopus/libu2f-emu>`__
 for the U2F key emulation. libu2f-emu
 provides a complete implementation of the U2F protocol device part for
 all specified transports given by the FIDO Alliance.
-- 
2.47.3


