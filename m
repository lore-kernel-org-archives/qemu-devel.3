Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB55CCDD0E1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 20:35:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Lag-0007rN-VF; Tue, 22 Oct 2024 16:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <castet.matthieu@free.fr>)
 id 1t3Lab-0007mZ-6o
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 16:34:52 -0400
Received: from smtp5-g21.free.fr ([2a01:e0c:1:1599::14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <castet.matthieu@free.fr>)
 id 1t3LaZ-0007vT-FM
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 16:34:48 -0400
Received: from debtag.home (unknown
 [IPv6:2a01:cb00:13da:d200:7cf5:aa34:e526:681b])
 (Authenticated sender: castet.matthieu@free.fr)
 by smtp5-g21.free.fr (Postfix) with ESMTPSA id DB9DC5FFB4;
 Tue, 22 Oct 2024 22:34:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1729629284;
 bh=mso0cJ5JiUfMphl4ElGBNEud7b0Z3n3PIJytDKEgUl0=;
 h=From:To:Cc:Subject:Date:From;
 b=q13bAXDga9ThuZ+HFs61z/DF1hYEUXXvCD10UWszfIE+PV2HqJeQ0gh9Qzgm6lXxH
 4u01kttrfW7NbAyrU2189EGJ5ucIPKvBpEHhz1ngQaZ6Bq0hUeQixXt20ugN0VRAXO
 N4CSbfGUa/6RuyerN7mQ6wgwL5yAx5PczYPK0sI+Ro9PypuTc5YhIfTupFBNhQFfR4
 Zt+fiRHlsZlf3gORkNhKi7K3t5OIh8SZBevafhlaRgcNWJ5kiEAS/S03lOnfz07hcD
 zd5LPFgNFqUFfIaoA3XffQxPdIBqGo0CxuVwf1INFqPnEL3pfPyPECURTxMMDwwGtL
 ER6VxogzLRXEA==
From: Matthieu Castet <castet.matthieu@free.fr>
To: qemu-devel@nongnu.org
Cc: Matthieu Castet <castet.matthieu@free.fr>
Subject: [PATCH 0/1] Add cortex-m0+ support
Date: Tue, 22 Oct 2024 22:34:34 +0200
Message-Id: <20241022203435.181452-1-castet.matthieu@free.fr>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a01:e0c:1:1599::14;
 envelope-from=castet.matthieu@free.fr; helo=smtp5-g21.free.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hello,

I have a patch that should allow to support cortex-m0+.
I used it in a special arm virtual machine that is still in progress (and not submitted).
I think this can be usefull.

Matthieu Castet (1):
  target/arm: Add cortex-m0+ support

 hw/intc/armv7m_nvic.c    | 38 +++++++++++++++++++++++++++++++++-----
 target/arm/cpu.c         |  4 ++--
 target/arm/ptw.c         | 23 +++++++++++++++++++----
 target/arm/tcg/cpu-v7m.c | 21 ++++++++++++++++++++-
 4 files changed, 74 insertions(+), 12 deletions(-)

-- 
2.39.5


