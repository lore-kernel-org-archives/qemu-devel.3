Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D17CFC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 13:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzFsl-0001HA-76; Tue, 23 Apr 2024 09:08:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mii@sfc.wide.ad.jp>)
 id 1rzCDf-000356-4O
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 05:13:43 -0400
Received: from mail1.sfc.wide.ad.jp ([203.178.142.133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mii@sfc.wide.ad.jp>)
 id 1rzCDc-0005y9-4E
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 05:13:42 -0400
Received: from k8s-worker-01.tail4d807.ts.net (unknown
 [IPv6:2400:4051:3e03:2d00:1e98:ecff:fe05:4840])
 (Authenticated sender: mii)
 by mail1.sfc.wide.ad.jp (Postfix) with ESMTPSA id 1AA6173C;
 Tue, 23 Apr 2024 18:13:31 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sfc.wide.ad.jp;
 s=mail1; t=1713863611;
 bh=4rgFMcl4PjAWS04UAp8ksMm7DNH0AzJ3elAESeixJrw=;
 h=From:To:Cc:Subject:Date:From;
 b=KzuWrQCcwJ4FAxc5VAWygao2toZ6/nCgdzWjpb1SSSO5cwB1eWUCdjmBiittc9tnX
 kELj1jB9kaAP0ZHx2exy2XD8ZG7NzZyY9KgJJKONNSgTRAazVgMJy7yxDaDPTx/9fQ
 eqittpQkQv8mw9T8HPJqn0RgSz+Rj0/aCyhMF6+iUh9KK3gJLq8aWWIwiUV9de2YhD
 jFmrV6t2OgEBjZRp60IUQV3ciSgN+U+0qSd3jfgw/93AFVwdpbGuGm0YjhNrZ1UpiW
 3ydHoAJA6Q5FtoQEaPel6TfT49mhfrzTXSwdhzAla66yQ2zn4rMd/PvUxMkB0uUtsH
 GF//Xa9QbcRvw==
From: Masato Imai <mii@sfc.wide.ad.jp>
To: qemu-devel@nongnu.org
Cc: Masato Imai <mii@sfc.wide.ad.jp>
Subject: [PATCH v2 0/1] migration/dirtyrate: Fix segmentation fault
Date: Tue, 23 Apr 2024 09:13:06 +0000
Message-Id: <20240423091306.754432-1-mii@sfc.wide.ad.jp>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.178.142.133; envelope-from=mii@sfc.wide.ad.jp;
 helo=mail1.sfc.wide.ad.jp
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 23 Apr 2024 09:08:17 -0400
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

Changes from v1:
- fix typo in commit message
- added an extra check for dirty bitmap mode

Masato Imai (1):
  migration/dirtyrate: Fix segmentation fault

 migration/dirtyrate.c | 7 +++++++
 1 file changed, 7 insertions(+)

-- 
2.34.1


