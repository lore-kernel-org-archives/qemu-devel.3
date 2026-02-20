Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42428C5ACD4
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 16:21:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtTEw-0000Jp-UZ; Fri, 20 Feb 2026 11:20:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <davydov-max@yandex-team.ru>)
 id 1vtTEs-0000Gd-9X
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 11:20:23 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <davydov-max@yandex-team.ru>)
 id 1vtTEp-00013x-6l
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 11:20:22 -0500
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c37:8aa5:0:640:e6ae:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id E5DBD8074A;
 Fri, 20 Feb 2026 19:20:12 +0300 (MSK)
Received: from davydov-max-lin.yandex.net (unknown
 [2a02:6bf:8011:f00:b5ad:46f:80fc:2732])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id vJfuXW4AvuQ0-b7UpRVyM; Fri, 20 Feb 2026 19:20:12 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1771604412;
 bh=iFWgJ+SAcLn3qYBu6swnvadGHzGPwetwbHBxi6Gm8y8=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=qwwv/VuOWELJoly6iB9GMlopNa7UJbwXxZqKtu0syUtrYIdAV9eCFKbI5KfntgKNn
 J+S9kAZryBSPsTMfIzbsSxt+NWY3OsfEhVx58b7ZNgQKE6wPi4uZlpYuxrkSGEfKTd
 dS6QYJA4cU+K3gNjOzNesrnrUFaj1HjnlzC6iAos=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Maksim Davydov <davydov-max@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: crosa@redhat.com, jsnow@redhat.com, philmd@linaro.org,
 vsementsov@yandex-team.ru, davydov-max@yandex-team.ru
Subject: [PATCH v2 0/2] improve compare-machine-types.py
Date: Fri, 20 Feb 2026 19:19:46 +0300
Message-Id: <20260220161948.213380-1-davydov-max@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=davydov-max@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Minor improvements of script for machine development: add support of
new types and fix a bug with usage of global variables.

v2 -> v1:
 * commit messages were changed

Maksim Davydov (2):
  scripts/compare-mt: add confidential computing getter
  scripts/compare-mt: stop using global variables

 scripts/compare-machine-types.py | 41 +++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 8 deletions(-)

-- 
2.34.1


