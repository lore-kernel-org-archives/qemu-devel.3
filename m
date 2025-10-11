Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C9BCCD184
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Oct 2025 14:17:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7a7q-0006I5-HD; Sat, 11 Oct 2025 09:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7a7e-0006H6-Cz
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 09:58:58 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7a7R-0004kF-Pm
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 09:58:58 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 841E5C0178;
 Sat, 11 Oct 2025 16:58:13 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a4b::1:3c])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id uvMPBZ1FEOs0-Uq0HgRMR; Sat, 11 Oct 2025 16:58:13 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760191093;
 bh=Va9tPsZdzTxRbSPf8QsoAdULO2YTnBK/t9JKeUkaz0c=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=y1soZKe1+dRD99RxJZvOInvn+TLo9TudtlqmIYbSXiGm9+S2dviHp6foApLEJZ9YA
 W8OP7kbRbxohCjN4KNVavk5qI4sOC54KqmdkIcfHcqqc9nK6fU7K5PXE1taU5Y9V05
 yEqx4ITKSweFLv8gKL3vwcFAaPtyaVgPED1LLdOo=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: armbru@redhat.com
Cc: qemu-devel@nongnu.org,
	vsementsov@yandex-team.ru,
	eblake@redhat.com
Subject: [PATCH 16/33] qapi/misc-i386.json: reflow docs to width=70 and two
 spaces between sentences
Date: Sat, 11 Oct 2025 16:57:12 +0300
Message-ID: <20251011135754.294521-32-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251011135754.294521-1-vsementsov@yandex-team.ru>
References: <20251011135754.294521-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 qapi/misc-i386.json | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/qapi/misc-i386.json b/qapi/misc-i386.json
index d1ce8caf25..3783202674 100644
--- a/qapi/misc-i386.json
+++ b/qapi/misc-i386.json
@@ -137,9 +137,9 @@
 # .. qmp-example::
 #
 #     -> { "execute": "query-sev" }
-#     <- { "return": { "enabled": true, "api-major" : 0, "api-minor" : 0,
-#                      "build-id" : 0, "policy" : 0, "state" : "running",
-#                      "handle" : 1 } }
+#     <- { "return": { "enabled": true, "api-major" : 0,
+#                      "api-minor" : 0, "build-id" : 0, "policy" : 0,
+#                      "state" : "running", "handle" : 1 } }
 ##
 { 'command': 'query-sev', 'returns': 'SevInfo' }
 
@@ -220,7 +220,8 @@
 # .. qmp-example::
 #
 #     -> { "execute": "query-sev-capabilities" }
-#     <- { "return": { "pdh": "8CCDD8DDD", "cert-chain": "888CCCDDDEE",
+#     <- { "return": { "pdh": "8CCDD8DDD",
+#                      "cert-chain": "888CCCDDDEE",
 #                      "cpu0-id": "2lvmGwo+...61iEinw==",
 #                      "cbitpos": 47, "reduced-phys-bits": 1}}
 ##
-- 
2.48.1


