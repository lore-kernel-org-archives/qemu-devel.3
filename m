Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A69C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 20:10:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujkRt-00055U-2s; Wed, 06 Aug 2025 16:09:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefan@weilnetz.de>)
 id 1ujkRr-00054k-0S
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 16:09:19 -0400
Received: from mail.weilnetz.de ([37.120.169.71]
 helo=mail.v2201612906741603.powersrv.de)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefan@weilnetz.de>)
 id 1ujkRo-00068Y-Cn
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 16:09:18 -0400
Received: from qemu.weilnetz.de (qemu.weilnetz.de [188.68.58.204])
 by mail.v2201612906741603.powersrv.de (Postfix) with ESMTP id 7A62BDA0BD4;
 Wed, 06 Aug 2025 22:09:10 +0200 (CEST)
Authentication-Results: mail.v2201612906741603.powersrv.de; dkim=none;
 spf=softfail (mail.v2201612906741603.powersrv.de: 188.68.58.204 is neither
 permitted nor denied by domain of stefan@weilnetz.de)
 smtp.mailfrom=stefan@weilnetz.de; 
 dmarc=fail reason="No valid SPF,
 No valid DKIM" header.from=weilnetz.de (policy=none)
Received: by qemu.weilnetz.de (Postfix, from userid 1000)
 id 6E22746003A; Wed, 06 Aug 2025 22:09:10 +0200 (CEST)
To: Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
	Stefan Weil <sw@weilnetz.de>
Subject: [PATCH for-10.1] CI: Use mingw-w64-x86_64-curl-winssl instead of
 mingw-w64-x86_64-curl for Windows build
Date: Wed,  6 Aug 2025 22:09:09 +0200
Message-ID: <20250806200909.507803-1-sw@weilnetz.de>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.60 / 12.00]; VIOLATED_DIRECT_SPF(3.50)[];
 BAYES_HAM(-3.00)[99.99%]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 FORGED_SENDER(0.30)[sw@weilnetz.de,stefan@weilnetz.de];
 ONCE_RECEIVED(0.20)[];
 DMARC_POLICY_SOFTFAIL(0.10)[weilnetz.de : No valid SPF, No valid
 DKIM,quarantine,sampled_out]; RCVD_NO_TLS_LAST(0.10)[];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_COUNT_ONE(0.00)[1];
 ASN(0.00)[asn:197540, ipnet:188.68.56.0/22, country:DE];
 ARC_NA(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FROM_NEQ_ENVFROM(0.00)[sw@weilnetz.de,stefan@weilnetz.de];
 DBL_BLOCKED_OPENRESOLVER(0.00)[weilnetz.de:mid,weilnetz.de:email];
 R_DKIM_NA(0.00)[];
 FREEMAIL_TO(0.00)[gmail.com,linaro.org,redhat.com];
 RCPT_COUNT_FIVE(0.00)[6]; R_SPF_SOFTFAIL(0.00)[~all:c]
X-Rspamd-Server: v2201612906741603
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 7A62BDA0BD4
X-Spamd-Bar: ++
Received-SPF: pass client-ip=37.120.169.71; envelope-from=stefan@weilnetz.de;
 helo=mail.v2201612906741603.powersrv.de
X-Spam_score_int: 14
X-Spam_score: 1.4
X-Spam_bar: +
X-Spam_report: (1.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

mingw-w64-x86_64-curl-winssl is required for https connections.

Signed-off-by: Stefan Weil <sw@weilnetz.de>
---
 .gitlab-ci.d/windows.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
index 45ed0c96fe..beac39e5bd 100644
--- a/.gitlab-ci.d/windows.yml
+++ b/.gitlab-ci.d/windows.yml
@@ -77,7 +77,7 @@ msys2-64bit:
       git grep make sed
       mingw-w64-x86_64-binutils
       mingw-w64-x86_64-ccache
-      mingw-w64-x86_64-curl
+      mingw-w64-x86_64-curl-winssl
       mingw-w64-x86_64-gcc
       mingw-w64-x86_64-glib2
       mingw-w64-x86_64-libnfs
-- 
2.47.2


