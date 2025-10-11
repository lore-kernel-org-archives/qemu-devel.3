Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66933CCD184
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Oct 2025 14:18:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7aDz-0004x7-1B; Sat, 11 Oct 2025 10:05:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7aDh-0004XT-Ht
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 10:05:18 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7aDS-0005PT-IQ
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 10:05:13 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 3F596C018E;
 Sat, 11 Oct 2025 17:04:49 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a4b::1:3c])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id h4NOTl1FrqM0-1JAyxGJA; Sat, 11 Oct 2025 17:04:48 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760191488;
 bh=1uUca7a6+MkNXsTvw98aS79VCYXTlBA27mbsctANXQw=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=IVk9qAbABs+X9gtRDvFmzH57ruh7XoKXpuMTJ+JuZwmIc9KZj7BEg/WbBALq0IzTT
 oMKYnpAQYxQQibOc4BDC6XcHkjeOkMVy73kIFB7gLWAXG/vr3G6QgxAKpu4OKon21p
 rPbWW3EmojRc4fFKQ+leDpzpHDFOOvLBJ9RRaVoE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: armbru@redhat.com
Cc: qemu-devel@nongnu.org,
	vsementsov@yandex-team.ru,
	eblake@redhat.com
Subject: [PATCH v2 10/33] qapi/introspect.json: docs: width=70 and two spaces
 between sentences
Date: Sat, 11 Oct 2025 17:04:16 +0300
Message-ID: <20251011140441.297246-11-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251011140441.297246-1-vsementsov@yandex-team.ru>
References: <20251011140441.297246-1-vsementsov@yandex-team.ru>
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
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
 qapi/introspect.json | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/qapi/introspect.json b/qapi/introspect.json
index 53100714a8..c8432c8ed8 100644
--- a/qapi/introspect.json
+++ b/qapi/introspect.json
@@ -22,10 +22,10 @@
 # `SchemaInfo`.  This lets QMP clients figure out what commands and
 # events are available in this QEMU, and their parameters and results.
 #
-# However, the `SchemaInfo` can't reflect all the rules and restrictions
-# that apply to QMP.  It's interface introspection (figuring out
-# what's there), not interface specification.  The specification is in
-# the QAPI schema.
+# However, the `SchemaInfo` can't reflect all the rules and
+# restrictions that apply to QMP.  It's interface introspection
+# (figuring out what's there), not interface specification.  The
+# specification is in the QAPI schema.
 #
 # Furthermore, while we strive to keep the QMP wire format
 # backwards-compatible across QEMU versions, the introspection output
-- 
2.48.1


