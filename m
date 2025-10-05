Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C2FCAC5B8
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:49:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UiH-0001OR-26; Sun, 05 Oct 2025 15:48:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <SRS0=F64V=4O=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org>)
 id 1v5UiF-0001O2-7B
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:48:07 -0400
Received: from sonata.ens-lyon.org ([140.77.166.138])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <SRS0=F64V=4O=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org>)
 id 1v5UiD-0001nV-2z
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:48:06 -0400
Received: from localhost (localhost [127.0.0.1])
 by sonata.ens-lyon.org (Postfix) with ESMTP id 5297BA02DA;
 Sun,  5 Oct 2025 21:48:01 +0200 (CEST)
Received: from sonata.ens-lyon.org ([127.0.0.1])
 by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id seeBKAXnH6Ig; Sun,  5 Oct 2025 21:48:01 +0200 (CEST)
Received: from begin (38.127.95.79.rev.sfr.net [79.95.127.38])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by sonata.ens-lyon.org (Postfix) with ESMTPSA id 16F95A0282;
 Sun,  5 Oct 2025 21:48:01 +0200 (CEST)
Received: from samy by begin with local (Exim 4.98.2)
 (envelope-from <samuel.thibault@ens-lyon.org>)
 id 1v5Uhj-0000000H8cu-01Ku; Sun, 05 Oct 2025 21:47:35 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, stefanha@redhat.com,
 jan.kiszka@siemens.com
Subject: [PULL 0/1] slirp branch
Date: Sun,  5 Oct 2025 21:47:33 +0200
Message-ID: <20251005194734.4084726-1-samuel.thibault@ens-lyon.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=140.77.166.138;
 envelope-from=SRS0=F64V=4O=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org;
 helo=sonata.ens-lyon.org
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 6d10e021318b16e3e90f98b7b2fa187826e26c0a:

  Add a feature for mapping a host unix socket to a guest tcp socket (2025-10-05 21:13:11 +0200)

are available in the Git repository at:

  https://people.debian.org/~sthibault/qemu.git tags/samuel-thibault

for you to fetch changes up to 6d10e021318b16e3e90f98b7b2fa187826e26c0a:

  Add a feature for mapping a host unix socket to a guest tcp socket (2025-10-05 21:13:11 +0200)

----------------------------------------------------------------
Add a feature for mapping a host unix socket to a guest tcp socket

----------------------------------------------------------------

