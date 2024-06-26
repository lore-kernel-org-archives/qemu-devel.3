Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79AB4C3064D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 13:44:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMSvx-0000yA-T6; Wed, 26 Jun 2024 09:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sMSvv-0000xE-M8; Wed, 26 Jun 2024 09:43:35 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sMSvt-0007Cg-Kg; Wed, 26 Jun 2024 09:43:35 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:958d:0:640:7be4:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 6E6B960BD1;
 Wed, 26 Jun 2024 16:43:29 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b645::1:29])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 6hQ8Aa0IZiE0-OvEF861i; Wed, 26 Jun 2024 16:43:28 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1719409408;
 bh=N7LvrfUUoLWyiDiK3UnXtSiFFB/8nIdxwZuxNzzQYdE=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=HI46iaf3KmdwMgZIA1tg89gFZOsmt7Y0EwUcAS0FUDSitvW7TE4LMDLz3L//xq843
 JIoUb89K/niknhZQLimM7nxE8ZX728z5yv1vCgOD0JChMIPHEKkPlL/QYX4Rvy61EN
 PCHQZLpx7PycZHESnWxmIkfiiGsyuxDj3VSY7A9M=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-trivial@nongnu.org, armbru@redhat.com,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH 3/3] vl.c: select_machine(): add selected machine type to
 error message
Date: Wed, 26 Jun 2024 16:43:05 +0300
Message-Id: <20240626134305.432627-4-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626134305.432627-1-vsementsov@yandex-team.ru>
References: <20240626134305.432627-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
 system/vl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/vl.c b/system/vl.c
index 947b433905..a6a4b470a7 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1674,7 +1674,7 @@ static MachineClass *select_machine(QDict *qdict, Error **errp)
         machine_class = find_machine(machine_type, machines);
         qdict_del(qdict, "type");
         if (!machine_class) {
-            error_setg(errp, "unsupported machine type");
+            error_setg(errp, "unsupported machine type: \"%s\"", optarg);
         }
     } else {
         machine_class = find_default_machine(machines);
-- 
2.34.1


