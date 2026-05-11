Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90DD3CD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 14:20:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMRUq-0000Ub-TW; Mon, 11 May 2026 10:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arei.gonglei@huawei.com>)
 id 1wMRUU-0000SZ-Up; Mon, 11 May 2026 10:20:16 -0400
Received: from canpmsgout04.his.huawei.com ([113.46.200.219])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arei.gonglei@huawei.com>)
 id 1wMRUQ-00021O-PO; Mon, 11 May 2026 10:20:14 -0400
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=DeLiX4StaG1lf50Qkc/7jDg0+HLyErR4bZryqKHq8R8=;
 b=e7+/fjhPwfI3PLSs72dSqr+t12Z9z01+Wyz7zpmmsmhubpnxVYHmhgQMgOOvm7KzR359V6I+z
 qiz82BDJk+2VhdUZMnOtESFPCHiEeRrmaJOuhe8Zzo05wdhwcbnF7AMUpUF33G1zD4fjzxVaVS4
 PDIkTIv2Gy4b3kqvUNf+hc0=
Received: from mail.maildlp.com (unknown [172.19.162.140])
 by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4gDhW01ZJSz1prkc;
 Mon, 11 May 2026 22:12:12 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
 by mail.maildlp.com (Postfix) with ESMTPS id BE299201E9;
 Mon, 11 May 2026 22:19:50 +0800 (CST)
Received: from DESKTOP-EH3TE8S.china.huawei.com (10.174.54.174) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 11 May 2026 22:19:49 +0800
From: Gonglei <arei.gonglei@huawei.com>
To: <arei.gonglei@huawei.com>, <qemu-devel@nongnu.org>,
 <qemu-stable@nongnu.org>
CC: <berrange@redhat.com>, <mcascell@redhat.com>
Subject: [PULL 0/1] cryptodev CVE fix
Date: Mon, 11 May 2026 22:19:45 +0800
Message-ID: <20260511141947.267-1-arei.gonglei@huawei.com>
X-Mailer: git-send-email 2.52.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.54.174]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf200006.china.huawei.com (7.185.36.61)
Received-SPF: pass client-ip=113.46.200.219;
 envelope-from=arei.gonglei@huawei.com; helo=canpmsgout04.his.huawei.com
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

The following changes since commit ee7eb612be8f8886d48c1d0c1f1c65e495138f83:

  Merge tag 'single-binary-20260506' of https://github.com/philmd/qemu into staging (2026-05-06 10:45:02 -0400)

are available in the Git repository at:

  git@github.com:gongleiarei/qemu.git tags/cryptodev-2026-05-11

for you to fetch changes up to 82862a08a8a45880f2b091f22f174089cf3dd203:

  backends/cryptodev-lkcf: fix use-after-free in session lifecycle (2026-05-11 20:58:59 +0800)

----------------------------------------------------------------
Cryptodev pull request 2026-05-11

----------------------------------------------------------------

Gonglei (Arei) (1):
  backends/cryptodev-lkcf: fix use-after-free in session lifecycle

 backends/cryptodev-lkcf.c | 59 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

-- 
2.53.0.windows.1


