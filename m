Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67D41FCD0A2
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 17:46:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2uxa-00019y-K2; Wed, 18 Mar 2026 13:45:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefan@weilnetz.de>)
 id 1w2uxW-00019N-Kq; Wed, 18 Mar 2026 13:45:31 -0400
Received: from mail.weilnetz.de ([37.120.169.71]
 helo=mail.v2201612906741603.powersrv.de)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefan@weilnetz.de>)
 id 1w2uxU-0005Lg-FE; Wed, 18 Mar 2026 13:45:30 -0400
Received: from qemu.weilnetz.de (qemu.weilnetz.de [188.68.58.204])
 by mail.v2201612906741603.powersrv.de (Postfix) with ESMTP id 20CF7DA07A3;
 Wed, 18 Mar 2026 18:45:23 +0100 (CET)
Authentication-Results: mail.v2201612906741603.powersrv.de; dkim=none;
 spf=temperror (mail.v2201612906741603.powersrv.de: error in processing during
 lookup of stefan@weilnetz.de: DNS error) smtp.mailfrom=stefan@weilnetz.de
Received: by qemu.weilnetz.de (Postfix, from userid 1000)
 id F2AFA460028; Wed, 18 Mar 2026 18:45:22 +0100 (CET)
To: =?UTF-8?q?C=C3=A9sar=20Belley?= <cesar.belley@lse.epita.fr>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Stefan Weil <sw@weilnetz.de>
Subject: [PATCH for-11.0.0] Fix include statement for u2f-emu.h
Date: Wed, 18 Mar 2026 18:45:22 +0100
Message-ID: <20260318174522.87902-1-sw@weilnetz.de>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: v2201612906741603
X-Rspamd-Queue-Id: 20CF7DA07A3
X-Spamd-Bar: -
X-Spamd-Result: default: False [-1.00 / 12.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; R_MISSING_CHARSET(0.50)[];
 FORGED_SENDER(0.30)[sw@weilnetz.de,stefan@weilnetz.de];
 ONCE_RECEIVED(0.20)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_NO_TLS_LAST(0.10)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_ONE(0.00)[1];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_NEQ_ENVFROM(0.00)[sw@weilnetz.de,stefan@weilnetz.de];
 RCPT_COUNT_FIVE(0.00)[6]; ARC_NA(0.00)[]; R_DKIM_NA(0.00)[];
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

All examples on https://github.com/Agnoctopus/libu2f-emu/ don't
simply include u2f-emu.h without any added directory.

The additional include directory does not exist when libu2f
was built with meson.

It's up to pkgconfig to make sure that u2f-emu.h is found in any case.

Signed-off-by: Stefan Weil <sw@weilnetz.de>
---

libu2f-emu seems to be unmaintained. There are no Debian/Ubuntu packages,
and I am afraid that it is also not part of the CI tests.

Should it be deprecated/removed?

I recently was asked by a user to add it to QEMU for Windows.
It seems to work basically, but the user also noticed some issues.

Regards
Stefan

Citing the user's feedback:

As promised, I have tested the u2f and so far, it works as expected.
However, I do have a few notes.

1)
If you send the u2f emulation a malformed USB HID packet either to the HID Control EP
or the HID Interrupt EP, it crashes QEmu. Windows will show the "busy" mouse cursor
for a few seconds and then it will shut down QEmu. I am guessing the u2f emulation
doesn't do much error checking on that part.

2)
There are two versions of the u2f, one dated 11/04/2017 and one dated 12/20/2023.
The emulation is for the later, not the former. There is enough of a difference that it
is not backward compatible. I wonder if a note can be placed in the documentation
that the emulation is for the version dated 12/20/2023.

old version (11/04/2017)
https://fidoalliance.org/specs/fido-u2f-v1.2-ps-20170411/

new version (12/20/2023)
https://fidoalliance.org/specs/u2f-specs-master/

3)
If I don't send a "challenge" request first, the u2f seems to still process a successful
transfer even though the CID value is invalid. I guess the emulation doesn't check
for a valid CID before processing the request. This is a huge security problem, though
only in emulation, not host related.

4) (not really a QEmu problem, but still worth mentioning)
The specs don't specifically state that each transaction must be only a 64-byte
USB transaction. For example, if you need to send a message that is two 64-byte packets,
you must send them as individual USB transactions. You cannot send a single 128-byte USB transaction.
After reading the specs a bit more, it is implied, but not directly specified.
It took me a little trial and error to figure this out. I had a message that was more
than 64 bytes and less than 128 bytes so I was sending a single 128-byte USB transaction.
The u2f emulation didn't like this and only works if I send two consecutive 64-byte USB transactions.

5)
I only used the following in my command line:

  -device u2f-emulated

I did not try the 'passthru' nor the two following examples from the QEmu documentation.

 -device u2f-emulated,dir=$dir
 -device u2f-emulated,cert=$DIR1/$FILE1,priv=$DIR2/$FILE2,counter=$DIR3/$FILE3,entropy=$DIR4/$FILE4

All in all, if you have a properly coded u2f driver, I believe the QEmu u2f emulation to work as expected.
However, it does need some error checking added.



 hw/usb/u2f-emulated.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/u2f-emulated.c b/hw/usb/u2f-emulated.c
index 196d05a83a..b82a315019 100644
--- a/hw/usb/u2f-emulated.c
+++ b/hw/usb/u2f-emulated.c
@@ -31,7 +31,7 @@
 #include "hw/usb/usb.h"
 #include "hw/core/qdev-properties.h"
 
-#include <u2f-emu/u2f-emu.h>
+#include <u2f-emu.h>
 
 #include "u2f.h"
 
-- 
2.47.3


