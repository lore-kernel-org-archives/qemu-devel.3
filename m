Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B41CCF9E9
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Oct 2025 16:58:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vChay-0003NM-JG; Sat, 25 Oct 2025 12:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vChav-0003Ha-OZ
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 12:58:21 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vChas-0000oe-7A
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 12:58:21 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 724B5C00DE;
 Sat, 25 Oct 2025 19:58:14 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:538::1:38])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id BwdGg31Lu4Y0-Q2yd0teW; Sat, 25 Oct 2025 19:58:14 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761411494;
 bh=kR6CpP02GlCPob2Oarww73N0zL9bPXWDYq061g4VJR4=;
 h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
 b=rRLtjbDzRtRdIm5gtqozrv9mHxpOms+4f07pXSeY6eps3nJjlVRpHIaCv8u8bv2sc
 GJfw0i/MVRms1jC/22noM5KeYi/TAFyGywc8pU4QF8U2AVotv+9eGMSozCClOKQZMB
 xdQHWFZ/3pm1lw3rPCNr0d9nBjVc1Cjoabo6js2Y=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: thuth@redhat.com
Cc: philmd@linaro.org, berrange@redhat.com, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru
Subject: [PATCH 2/2] MAINTAINERS: fix functional tests section
Date: Sat, 25 Oct 2025 19:58:04 +0300
Message-ID: <20251025165809.930670-3-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251025165809.930670-1-vsementsov@yandex-team.ru>
References: <20251025165809.930670-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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

Without "S: Maintained", ./scripts/get_maintainer.pl shows "unknown"
role instead of "maintainer" for "M: " entry, it's confusing. I really
hope that functional tests are maintained:)

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f33f95ceea..27e5e93d2a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4408,6 +4408,7 @@ Functional testing framework
 M: Thomas Huth <thuth@redhat.com>
 R: Philippe Mathieu-Daudé <philmd@linaro.org>
 R: Daniel P. Berrange <berrange@redhat.com>
+S: Maintained
 F: docs/devel/testing/functional.rst
 F: scripts/clean_functional_cache.py
 F: tests/functional/qemu_test/
-- 
2.48.1


