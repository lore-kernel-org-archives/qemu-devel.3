Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58153CCF9E6
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 17:00:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vByfO-0004iM-6a; Thu, 23 Oct 2025 12:59:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <davydov-max@yandex-team.ru>)
 id 1vByfL-0004ho-UD
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 12:59:55 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <davydov-max@yandex-team.ru>)
 id 1vByfJ-0005hf-3D
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 12:59:55 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 567088082B;
 Thu, 23 Oct 2025 19:59:45 +0300 (MSK)
Received: from davydov-max-lin.yandex.net (unknown
 [2a02:6bf:8011:f00:ef9:2188:6644:f7b6])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 8xbwbU0ImGk0-ZjK491YC; Thu, 23 Oct 2025 19:59:44 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761238784;
 bh=mxDCLRNod0GKaG3wsTRPBGD8nMM+k5/E2r8OBylQnYs=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=Qhv1Vbn5V96zNDP3fAn4r2ULWyHv5qPrjAdmlFUEUWQATmYJ4+KyVTfAGvsema2z7
 aqa6LEMrAFdN0kFl33Qlaxhm+R7PSr67yw7bajA0EBBW7EmbvXKBNshlyHaOmVtr82
 I9z6xy/skXKXH8NszdkGspw6x+J/Z9RS/fTXFRLE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Maksim Davydov <davydov-max@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: crosa@redhat.com, jsnow@redhat.com, davydov-max@yandex-team.ru,
 philmd@linaro.org, vsementsov@yandex-team.ru
Subject: [PATCH 0/2] improve compare-machine-types.py
Date: Thu, 23 Oct 2025 19:58:44 +0300
Message-Id: <20251023165846.326295-1-davydov-max@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=davydov-max@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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

Minor improvements of script for machine development: add support of
new types and fix a bug with usage of global variables.

Maksim Davydov (2):
  scripts/compare-mt: add confidential computing getter
  scripts/compare-mt: stop using global variables

 scripts/compare-machine-types.py | 41 +++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 8 deletions(-)

-- 
2.34.1


