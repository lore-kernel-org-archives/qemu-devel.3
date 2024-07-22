Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BEC6C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 09:19:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVpBY-0006ub-QV; Mon, 22 Jul 2024 05:18:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sVpBW-0006tw-TH
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 05:18:22 -0400
Received: from esa2.hc1455-7.c3s2.iphmx.com ([207.54.90.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sVpBS-0006yS-Eb
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 05:18:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1721639898; x=1753175898;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=dYuPkI1TjOMs3T81fXiJq8uS7Uou35G14/EBS9PRi7M=;
 b=tXqe8J8bun7RSDrSv+b0KAHTMtOqtl636MR/2S/ESH9nVDhYQHjY+NSo
 xuoDppY++SKSdB3vTT/XSGdKpuahYXwlD+uQAE6bzYQR/DjQ1/UA8I2IL
 2SxT3HX4ZyG7kDS+vyaXONJ4q96tNUlM4VIHQFUv5QaOn7zzgLTdIENgC
 0aAxdgC0X8Uc3CtW6R4dH7/M5P4TdkimKBmwfFm4c7v83A8QeATO+i0NH
 t3cXBhxLc9DvS1Ri9vRHlI71/Q6HpvIcQAVIkz+JtoNtfIsPXaF3pNT1S
 2rYw491AtW0Agh9EUhtOYnMzIhS02ypZsqE0vBZkQc7ee6PXwKjQLYnE/ Q==;
X-IronPort-AV: E=McAfee;i="6700,10204,11140"; a="168160644"
X-IronPort-AV: E=Sophos;i="6.09,227,1716217200"; d="scan'208";a="168160644"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
 by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2024 18:18:15 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com
 [192.168.87.60])
 by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id AB540D8011
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 18:18:12 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id EE42CD73A3
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 18:18:11 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 8C09A20071A2A
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 18:18:11 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.225.88])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id E12101A000A;
 Mon, 22 Jul 2024 17:18:10 +0800 (CST)
To: qemu-devel@nongnu.org
Cc: Yao Xingtao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH 0/2] remove useless type cast
Date: Mon, 22 Jul 2024 05:17:26 -0400
Message-ID: <20240722091728.4334-1-yaoxt.fnst@fujitsu.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28544.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28544.006
X-TMASE-Result: 10--5.103200-10.000000
X-TMASE-MatchedRID: kjMpX+Wkr6JRpDxTweAjCRIRh9wkXSlFw+MUH8mZTtScNvh+kFHGrbK6
 GmKppGdq8Xo3NKXpyhdvcmY92rn2+R8TzIzimOwPO6pzAGRBlFzZs3HUcS/scCq2rl3dzGQ16+S
 eJe1QBHwOwy2VAlwwiRCoSDJPtz8Ws+OHfZ8aRwoIcETLZoPshQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=207.54.90.48; envelope-from=yaoxt.fnst@fujitsu.com;
 helo=esa2.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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
Reply-to:  Yao Xingtao <yaoxt.fnst@fujitsu.com>
From:  Yao Xingtao via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Currently the pattern in scripts/coccinelle/typecast.cocci is used to
remove the useless type cast.

Use the following command to find out the use cases and remove the
useless type case:
$ spatch --macro-file scripts/cocci-macro-file.h \
         --sp-file ./scripts/coccinelle/typecast.cocci \
         --keep-comments --in-place --use-gitgrep --dir .

Yao Xingtao (2):
  mips/loongson3_virt: remove useless type cast
  nvme/ctrl: remove useless type cast

 hw/mips/loongson3_virt.c | 4 ++--
 hw/nvme/ctrl.c           | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.41.0


