Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE46606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 21:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=JNq2evIa;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=5Prvlb0c;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=JNq2evIa;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=5Prvlb0c
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMXJy-0002In-Vk; Thu, 29 Oct 2026 17:06:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xMXJw-0002II-W9
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 17:06:01 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xMXJl-0001Hn-KI
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 17:05:51 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0AAFC222AE;
 Thu, 29 Oct 2026 21:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793307948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8eECAd2qviXuH4H5ifNDEV7YwGp86dHyjOuJa/+/PzI=;
 b=JNq2evIaoshpxrDu28MSsoLuVbedcyAJ6AdyO3QR/Fh0XkJZsc1W7EbA+Mkps3pBIo94Ae
 Sxj8Xg8qME1OoRldHSV6jntsvZj42HjSe+CK0t55+YA9HotfhPNjLIqW0M9O2c6Eq8znGz
 MEMc8j1dRGmN2Dmgw9fZfBiviScflwQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793307948;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8eECAd2qviXuH4H5ifNDEV7YwGp86dHyjOuJa/+/PzI=;
 b=5Prvlb0csEZGFLGqFpd5jP9EoYv3qUtOROMVwu0QU23XHZn9B7zo5316Z6kAxDsNnHfB0U
 yV+tg1daiVr1bOCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793307948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8eECAd2qviXuH4H5ifNDEV7YwGp86dHyjOuJa/+/PzI=;
 b=JNq2evIaoshpxrDu28MSsoLuVbedcyAJ6AdyO3QR/Fh0XkJZsc1W7EbA+Mkps3pBIo94Ae
 Sxj8Xg8qME1OoRldHSV6jntsvZj42HjSe+CK0t55+YA9HotfhPNjLIqW0M9O2c6Eq8znGz
 MEMc8j1dRGmN2Dmgw9fZfBiviScflwQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793307948;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8eECAd2qviXuH4H5ifNDEV7YwGp86dHyjOuJa/+/PzI=;
 b=5Prvlb0csEZGFLGqFpd5jP9EoYv3qUtOROMVwu0QU23XHZn9B7zo5316Z6kAxDsNnHfB0U
 yV+tg1daiVr1bOCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 05EA313419;
 Thu, 29 Oct 2026 21:05:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id E1LmGia142qaYAAAD6G6ig:T5
 (envelope-from <farosas@suse.de>); Thu, 29 Oct 2026 21:05:46 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 4/5] qtest: multiple fixes to socket_accept()
Date: Thu, 29 Oct 2026 18:05:35 -0300
Message-ID: <20261029210536.2260016-5-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029210536.2260016-1-farosas@suse.de>
References: <20261029210536.2260016-1-farosas@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-12.30 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -12.30
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

From: Daniel P. Berrangé <berrange@redhat.com>

If the very first iteration of the loop breaks early due to the
dead QEMU process, 'ret' is never initialized. Furthermore the
listener socket is not closed on success and there is no error
message printed if timing out after all iterations are complete.
These problems were introduced by the recent refactoring to check
QEMU is alive.

CID 1688281

Reported-by: Markus Armbruster <armbru@redhat.com>
Fixes: c12ad5378739 ("qtest: fail fast when QEMU terminates early")
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/libqtest.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 22b0dc193c9..dcce889ccc1 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -119,7 +119,7 @@ static int qtest_socket_accept(QTestState *s, int sock)
 {
     struct sockaddr_un addr;
     socklen_t addrlen;
-    int ret;
+    int ret = -1;
     size_t i;
 #ifndef _WIN32
     struct timeval timeout = { .tv_sec = 0,
@@ -145,14 +145,13 @@ static int qtest_socket_accept(QTestState *s, int sock)
 
         addrlen = sizeof(addr);
         ret = accept(sock, (struct sockaddr *)&addr, &addrlen);
-        if (ret == -1) {
-            if (errno == EINTR || errno == EAGAIN) {
-                continue;
-            } else {
-                fprintf(stderr, "%s failed: %s\n", __func__, strerror(errno));
-            }
+        if (ret == -1 && (errno == EINTR || errno == EAGAIN)) {
+            continue;
         }
-        return ret;
+        break;
+    }
+    if (ret == -1) {
+        fprintf(stderr, "%s failed: %s\n", __func__, strerror(errno));
     }
 
  cleanup:
-- 
2.53.0


