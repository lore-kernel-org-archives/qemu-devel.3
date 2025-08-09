Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3BA2C87FCB
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Aug 2025 06:14:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukcpT-0008Ch-Sd; Sat, 09 Aug 2025 02:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefan@weilnetz.de>)
 id 1ukcpL-0008Ac-T3; Sat, 09 Aug 2025 02:13:11 -0400
Received: from mail.weilnetz.de ([37.120.169.71]
 helo=mail.v2201612906741603.powersrv.de)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefan@weilnetz.de>)
 id 1ukcpJ-0004es-UK; Sat, 09 Aug 2025 02:13:11 -0400
Received: from qemu.weilnetz.de (qemu.weilnetz.de [188.68.58.204])
 by mail.v2201612906741603.powersrv.de (Postfix) with ESMTP id AB500DA04B9;
 Sat, 09 Aug 2025 08:13:05 +0200 (CEST)
Authentication-Results: mail.v2201612906741603.powersrv.de; dkim=none;
 spf=softfail (mail.v2201612906741603.powersrv.de: 188.68.58.204 is neither
 permitted nor denied by domain of stefan@weilnetz.de)
 smtp.mailfrom=stefan@weilnetz.de; 
 dmarc=fail reason="No valid SPF,
 No valid DKIM" header.from=weilnetz.de (policy=none)
Received: by qemu.weilnetz.de (Postfix, from userid 1000)
 id 8994D46012D; Sat, 09 Aug 2025 08:13:05 +0200 (CEST)
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Michael Tokarev <mjt@tls.msk.ru>, rent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Stefan Weil <sw@weilnetz.de>
Subject: [PATCH trivial] chardev/baum: Fix compiler warning for Windows builds
Date: Sat,  9 Aug 2025 08:13:02 +0200
Message-ID: <20250809061302.596931-1-sw@weilnetz.de>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.60 / 12.00]; VIOLATED_DIRECT_SPF(3.50)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 FORGED_SENDER(0.30)[sw@weilnetz.de,stefan@weilnetz.de];
 ONCE_RECEIVED(0.20)[];
 DMARC_POLICY_SOFTFAIL(0.10)[weilnetz.de : No valid SPF, No valid
 DKIM,quarantine,sampled_out]; MIME_GOOD(-0.10)[text/plain];
 RCVD_NO_TLS_LAST(0.10)[]; RCVD_COUNT_ONE(0.00)[1];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[weilnetz.de:mid,weilnetz.de:email];
 ASN(0.00)[asn:197540, ipnet:188.68.56.0/22, country:DE];
 RCPT_COUNT_SEVEN(0.00)[8]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; R_DKIM_NA(0.00)[];
 FROM_NEQ_ENVFROM(0.00)[sw@weilnetz.de,stefan@weilnetz.de];
 R_SPF_SOFTFAIL(0.00)[~all]; ARC_NA(0.00)[]
X-Rspamd-Server: v2201612906741603
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: AB500DA04B9
X-Spamd-Bar: ++
Received-SPF: pass client-ip=37.120.169.71; envelope-from=stefan@weilnetz.de;
 helo=mail.v2201612906741603.powersrv.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Stefan Weil <sw@weilnetz.de>
From:  Stefan Weil via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Compiler warning:

../chardev/baum.c:657:25: warning: comparison between pointer and integer

Use brlapi_fileDescriptor instead of int for brlapi_fd and
BRLAPI_INVALID_FILE_DESCRIPTOR instead of -1.

Signed-off-by: Stefan Weil <sw@weilnetz.de>
---

This is a rather old patch which I now use since more than two years
to support Braille with QEMU on Windows.

It's a hack (because Windows uses a pointer (64 bit) which is
assigned to an int (32 bit), but it seems to work.

Regards,
Stefan


 chardev/baum.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/chardev/baum.c b/chardev/baum.c
index f3e8cd27f0..5c3587dda5 100644
--- a/chardev/baum.c
+++ b/chardev/baum.c
@@ -94,7 +94,7 @@ struct BaumChardev {
     Chardev parent;
 
     brlapi_handle_t *brlapi;
-    int brlapi_fd;
+    brlapi_fileDescriptor brlapi_fd;
     unsigned int x, y;
     bool deferred_init;
 
@@ -654,7 +654,7 @@ static void baum_chr_open(Chardev *chr,
     baum->brlapi = handle;
 
     baum->brlapi_fd = brlapi__openConnection(handle, NULL, NULL);
-    if (baum->brlapi_fd == -1) {
+    if (baum->brlapi_fd == BRLAPI_INVALID_FILE_DESCRIPTOR) {
         error_setg(errp, "brlapi__openConnection: %s",
                    brlapi_strerror(brlapi_error_location()));
         g_free(handle);
-- 
2.47.2


