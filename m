Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE6DCFD2F6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 17:35:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOfsh-0004TY-2E; Thu, 27 Nov 2025 12:34:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vOfsb-0004Rn-Uv
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 12:34:05 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vOfsX-0001Gr-Mx
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 12:34:05 -0500
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 1348180DF3;
 Thu, 27 Nov 2025 20:33:58 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:834::1:7])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id rXiJgL0F7Os0-K9ftgLa0; Thu, 27 Nov 2025 20:33:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1764264837;
 bh=ueby3IU3TcupzmFwaUbWLNrW2a/+cLbdDLEJHIRz1bE=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=FDOK4f6ARNBodCvNTfwYB26PYi6GOxeE2kCnhvYI8wHRxFiOlrmhVpQjWnfyK7BQ7
 P3CFPVmuAqpDEHpxubjuDgfLm1XoYSbxNPNeuJaV9xlL90JmotWKW98U8+zyWAVpXs
 1rh6Tv47GH/C4f3EJSnYvVWFzhYTzF2Yu5X7mqJE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: dave@treblig.org,
	armbru@redhat.com
Cc: pbonzini@redhat.com, marcandre.lureau@redhat.com, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru
Subject: [PATCH 5/5] error-report: fix doc for vreport()
Date: Thu, 27 Nov 2025 20:33:52 +0300
Message-ID: <20251127173352.283731-6-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251127173352.283731-1-vsementsov@yandex-team.ru>
References: <20251127173352.283731-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

We actually don't print any errors to QMP monitor.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 util/error-report.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/error-report.c b/util/error-report.c
index 7ffbcf2123..0f3b1c0354 100644
--- a/util/error-report.c
+++ b/util/error-report.c
@@ -177,7 +177,7 @@ real_time_iso8601(void)
 }
 
 /*
- * Print a message to current monitor if we have one, else to stderr.
+ * Print a message to current HMP monitor if we have one, else to stderr.
  * @report_type is the type of message: error, warning or informational.
  * Format arguments like vsprintf().  The resulting message should be
  * a single phrase, with no newline or trailing punctuation.
-- 
2.48.1


