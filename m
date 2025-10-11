Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B0ACCD184
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Oct 2025 14:12:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7a7V-0006E6-3S; Sat, 11 Oct 2025 09:58:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7a7S-0006Cv-Ch; Sat, 11 Oct 2025 09:58:46 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7a7D-0004iY-L6; Sat, 11 Oct 2025 09:58:45 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id CA515C0166;
 Sat, 11 Oct 2025 16:58:07 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a4b::1:3c])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id uvMPBZ1FEOs0-gzisR4Gs; Sat, 11 Oct 2025 16:58:07 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760191087;
 bh=gKfac8l+k6HXx+GuiQXKB7Cy06ACRmzu41QCBlDfSCA=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=BlQjMkX6KEY4kjqc6cCByIY8eAgUKFludFiajwzSEg9V+065lTn7XZc/hoxx/L4Ir
 oSJmqsh0DAaunH6S+KmshD5UgVWUpg+h224/a5xxkb4RqOBlzV5PWBeALY4pH2JJLf
 wzbG8R2H7I9Cmjaaiz31aXsUU4vTS/CvV/mk4rug=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: armbru@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, eblake@redhat.com,
 Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org (open list:S390 general arch...)
Subject: [PATCH 12/33] qapi/machine-s390x.json: docs: width=70 and two spaces
 between sentences
Date: Sat, 11 Oct 2025 16:57:03 +0300
Message-ID: <20251011135754.294521-23-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251011135754.294521-1-vsementsov@yandex-team.ru>
References: <20251011135754.294521-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
 qapi/machine-s390x.json | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/qapi/machine-s390x.json b/qapi/machine-s390x.json
index 966dbd61d2..f8ddc0ff8a 100644
--- a/qapi/machine-s390x.json
+++ b/qapi/machine-s390x.json
@@ -85,7 +85,8 @@
 #
 #     <- { "event": "CPU_POLARIZATION_CHANGE",
 #          "data": { "polarization": "horizontal" },
-#          "timestamp": { "seconds": 1401385907, "microseconds": 422329 } }
+#          "timestamp": { "seconds": 1401385907,
+#                         "microseconds": 422329 } }
 ##
 { 'event': 'CPU_POLARIZATION_CHANGE',
   'data': { 'polarization': 'S390CpuPolarization' },
-- 
2.48.1


